//
//  MapViewController.h
//  Guiji
//
//  Created by wanglijun on 2017/8/24.
//  Copyright © 2017年 wanglijun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "LocalShareModel.h"
@interface MapViewController : UIViewController
@property(nonatomic,strong)LocalShareModel *  localtion;
@end
