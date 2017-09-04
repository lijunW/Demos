//
//  FirstViewController.m
//  Guiji
//
//  Created by wanglijun on 2017/8/24.
//  Copyright © 2017年 wanglijun. All rights reserved.
//

#import "FirstViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "LocalShareModel.h"

@interface FirstViewController ()
@property(nonatomic,strong)AMapLocationManager * locationManager;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];    
//    // Do any additional setup after loading the view, typically from a nib.
//    self.locationManager = [[AMapLocationManager alloc] init];
//    self.locationManager.delegate = self;
//    self.locationManager.distanceFilter = 50;
//    
//    //iOS 9（不包含iOS 9） 之前设置允许后台定位参数，保持不会被系统挂起
//    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
//    
//    //iOS 9（包含iOS 9）之后新特性：将允许出现这种场景，同一app中多个locationmanager：一些只能在前台定位，另一些可在后台定位，并可随时禁止其后台定位。
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9) {
//        self.locationManager.allowsBackgroundLocationUpdates = YES;
//    }
//    [self.locationManager setLocatingWithReGeocode:YES];
//    [self.locationManager startUpdatingLocation];
//    //开始持续定位
//    [self.locationManager startUpdatingLocation];
}


//- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode
//{
//    LocalShareModel * localShareModel = [[LocalShareModel alloc]init];
//    localShareModel.latitude = location.coordinate.latitude;
//    localShareModel.longitude = location.coordinate.longitude;
//    localShareModel.verticalAccuracy = location.verticalAccuracy;
//    localShareModel.horizontalAccuracy = location.horizontalAccuracy;
//    localShareModel.speed = location.speed;
//    localShareModel.timestamp = location.timestamp;
//    localShareModel.altitude = location.altitude;
//    localShareModel.creatTime = [NSDate date];
//    
//    if (reGeocode)
//    {
//        localShareModel.formattedAddress = reGeocode.formattedAddress;
//        NSLog(@"reGeocode:%@", reGeocode);
//    }
//    
//    if ([[RLMRealm defaultRealm] transactionWithBlock:^{
//        [LocalShareModel createInDefaultRealmWithValue:localShareModel];
//    } error:nil]) {}
//    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
//}



@end
