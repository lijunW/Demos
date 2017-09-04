//
//  BackGroundLocationManager.m
//  Guiji
//
//  Created by wanglijun on 2017/9/1.
//  Copyright © 2017年 wanglijun. All rights reserved.
//

#import "BackGroundLocationManager.h"

@interface BackGroundLocationManager ()<AMapLocationManagerDelegate>
@end

@implementation BackGroundLocationManager
+ (instancetype)sharedManager
{
    static BackGroundLocationManager *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[BackGroundLocationManager alloc] init];
    });
    
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if ( self )
    {
        _minSpeed = 3;
        _minFilter = 50;
        _minInteval = 10;
        
        
        _locationManager = [[AMapLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.distanceFilter = _minFilter;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        //iOS 9（不包含iOS 9） 之前设置允许后台定位参数，保持不会被系统挂起
        [_locationManager setPausesLocationUpdatesAutomatically:NO];
        
        //iOS 9（包含iOS 9）之后新特性：将允许出现这种场景，同一app中多个locationmanager：一些只能在前台定位，另一些可在后台定位，并可随时禁止其后台定位。
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9) {
            _locationManager.allowsBackgroundLocationUpdates = YES;
        }
        [self.locationManager setLocatingWithReGeocode:YES];
    }
    return self;
}

-(void)startLocationRecord{
    //开始持续定位
    [self.locationManager startUpdatingLocation];
}
-(void)stopLocationRecord{
    [self.locationManager stopUpdatingLocation];
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode
{
    LocalShareModel * localShareModel = [[LocalShareModel alloc]init];
    localShareModel.latitude = location.coordinate.latitude;
    localShareModel.longitude = location.coordinate.longitude;
    localShareModel.verticalAccuracy = location.verticalAccuracy;
    localShareModel.horizontalAccuracy = location.horizontalAccuracy;
    localShareModel.speed = location.speed;
    localShareModel.timestamp = location.timestamp;
    localShareModel.altitude = location.altitude;
    localShareModel.creatTime = [NSDate date];
    
    localShareModel.background = ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground);
    localShareModel.loc        = [NSString stringWithFormat:@"speed:%.0f filter:%.0f",location.speed,manager.distanceFilter];
    
    if (reGeocode)
    {
        localShareModel.formattedAddress = reGeocode.formattedAddress;
        NSLog(@"reGeocode:%@", reGeocode);
    }
    
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
    
    //[self adjustDistanceFilter:location];
    [self uploadLocation:localShareModel];
}


/**
 *  规则: 如果速度小于minSpeed m/s 则把触发范围设定为50m
 *  否则将触发范围设定为minSpeed*minInteval
 *  此时若速度变化超过10% 则更新当前的触发范围(这里限制是因为不能不停的设置distanceFilter,
 *  否则uploadLocation会不停被触发)
 */
- (void)adjustDistanceFilter:(CLLocation*)location
{
    //    NSLog(@"adjust:%f",location.speed);
    if ( location.speed < self.minSpeed )
    {
        if ( fabs(self.locationManager.distanceFilter-self.minFilter) > 0.1f )
        {
            self.locationManager.distanceFilter = self.minFilter;
        }
    }
    else
    {
        CGFloat lastSpeed = self.locationManager.distanceFilter/self.minInteval;
        if ( (fabs(lastSpeed-location.speed)/lastSpeed > 0.1f) || (lastSpeed < 0) )
        {
            CGFloat newSpeed  = (int)(location.speed+0.5f);
            CGFloat newFilter = newSpeed*self.minInteval;
            self.locationManager.distanceFilter = newFilter;
        }
    }
}


//这里仅用本地数据库模拟上传操作
- (void)uploadLocation:(LocalShareModel *)location
{
    NSLog(@"uploadLocation");
    
    if ([[RLMRealm defaultRealm] transactionWithBlock:^{
        [LocalShareModel createInDefaultRealmWithValue:location];
    } error:nil]) {}
    
#warning 如果有较长时间的操作 比如HTTP上传 请使用beginBackgroundTaskWithExpirationHandler
    //    if ( [UIApplication sharedApplication].applicationState == UIApplicationStateActive )
    //    {
    //        //TODO HTTP upload
    //
    //        [self endBackgroundUpdateTask];
    //    }
    //    else//后台定位
    //    {
    //        //假如上一次的上传操作尚未结束 则直接return
    //        if ( self.taskIdentifier != UIBackgroundTaskInvalid )
    //        {
    //            return;
    //        }
    //
    //        [self beingBackgroundUpdateTask];
    //
    //        //TODO HTTP upload
    //        //上传完成记得调用 [self endBackgroundUpdateTask];
    //    }
    
}


//- (void)beingBackgroundUpdateTask
//{
//    self.taskIdentifier = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
//        [self endBackgroundUpdateTask];
//    }];
//}
//
//- (void)endBackgroundUpdateTask
//{
//    if ( self.taskIdentifier != UIBackgroundTaskInvalid )
//    {
//        [[UIApplication sharedApplication] endBackgroundTask: self.taskIdentifier];
//        self.taskIdentifier = UIBackgroundTaskInvalid;
//    }
//}
@end
