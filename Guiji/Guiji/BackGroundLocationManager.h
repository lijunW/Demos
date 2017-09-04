//
//  BackGroundLocationManager.h
//  Guiji
//
//  Created by wanglijun on 2017/9/1.
//  Copyright © 2017年 wanglijun. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;
@import UIKit;

#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "LocalShareModel.h"

@interface BackGroundLocationManager : NSObject
@property(nonatomic,strong)AMapLocationManager * locationManager;
@property (nonatomic, assign) CGFloat minSpeed;
@property (nonatomic, assign) CGFloat minFilter;
@property (nonatomic, assign) CGFloat minInteval;

+ (instancetype)sharedManager;
-(void)startLocationRecord;
-(void)stopLocationRecord;
@end
