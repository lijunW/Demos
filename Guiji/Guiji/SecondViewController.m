//
//  SecondViewController.m
//  Guiji
//
//  Created by wanglijun on 2017/8/24.
//  Copyright © 2017年 wanglijun. All rights reserved.
//

#import "SecondViewController.h"
#import <MAMapKit/MAMapKit.h>
#import "LocalShareModel.h"
#import <Realm/Realm.h>
#import "WSDatePickerView.h"
@interface SecondViewController ()
{
     CLLocationCoordinate2D coords1[10000];
}
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) MAAnimatedAnnotation* annotation;
@end

@implementation SecondViewController
- (IBAction)pickDate:(UIBarButtonItem *)sender {
    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate *selectDate) {
        NSString * dateFormatter = @"yyyy-MM-dd";
        NSString *date = [selectDate stringWithFormat:dateFormatter];
        NSLog(@"选择的日期：%@",date);
    }];
    //datepicker.dateLabelColor = Theme_Main_Color;//年-月-日-时-分 颜色
    datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
    //datepicker.doneButtonColor = Theme_Main_Color;//确定按钮的颜色
    [datepicker show];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initCoordinates];
    
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    self.mapView.centerCoordinate = CLLocationCoordinate2DMake(31.767066, 117.216093);
    
    //add overlay
    MAPolyline *polyline1 = [MAPolyline polylineWithCoordinates:coords1 count:sizeof(coords1) / sizeof(coords1[0])];
    [self.mapView addOverlay:polyline1];
    
    MAAnimatedAnnotation *anno = [[MAAnimatedAnnotation alloc] init];
    anno.coordinate = coords1[0];
    self.annotation = anno;
    
    [self.mapView addAnnotation:self.annotation];
    
    [self initButton];

}
- (void)initCoordinates {

    RLMResults * results = [LocalShareModel allObjects];
    for (LocalShareModel *model in results) {
        NSInteger index = [results indexOfObject:model];
        coords1[index].latitude = model.latitude;
        coords1[index].longitude = model.longitude;
    }
}

- (void)initButton
{
    UIButton *button1=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button1.frame = CGRectMake(10, 50, 70,25);
    button1.backgroundColor = [UIColor redColor];
    [button1 setTitle:@"Go" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(button1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    UIButton *button2=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button2.frame = CGRectMake(10, 100,70,25);
    button2.backgroundColor = [UIColor redColor];
    [button2 setTitle:@"Stop" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(button2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
}

- (void)button1 {
    self.annotation.coordinate = coords1[0];
    
    MAAnimatedAnnotation *anno = self.annotation;
    
    NSInteger count =[LocalShareModel allObjects].count;
    CLLocationCoordinate2D coords[count];
    for (int i = 0; i < count; i++) {
        coords[i].latitude = coords1[i].latitude;
        coords[i].longitude = coords1[i].longitude;
    }
    
    [anno addMoveAnimationWithKeyCoordinates:coords count:sizeof(coords) / sizeof(coords1[0]) withDuration:5 withName:nil completeCallback:^(BOOL isFinished) {
    }];
    
//    [anno addMoveAnimationWithKeyCoordinates:coords2 count:sizeof(coords2) / sizeof(coords2[0]) withDuration:5 withName:nil completeCallback:^(BOOL isFinished) {
//    }];
//    
//    
//    [anno addMoveAnimationWithKeyCoordinates:coords3 count:sizeof(coords3) / sizeof(coords3[0]) withDuration:5 withName:nil completeCallback:^(BOOL isFinished) {
//    }];
}

- (void)button2 {
    for(MAAnnotationMoveAnimation *animation in [self.annotation allMoveAnimations]) {
        [animation cancel];
    }
    
    self.annotation.movingDirection = 0;
    self.annotation.coordinate = coords1[0];
}

#pragma mark - mapview delegate
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        polylineRenderer.lineWidth    = 8.f;
        [polylineRenderer loadStrokeTextureImage:[UIImage imageNamed:@"arrowTexture"]];
        return polylineRenderer;
        
    }
    
    return nil;
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        NSString *pointReuseIndetifier = @"myReuseIndetifier";
        MAAnnotationView *annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:pointReuseIndetifier];
            
            UIImage *imge  =  [UIImage imageNamed:@"userPosition"];
            annotationView.image =  imge;
        }
        
        annotationView.canShowCallout               = YES;
        annotationView.draggable                    = NO;
        annotationView.rightCalloutAccessoryView    = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        
        return annotationView;
    }
    
    return nil;
}


@end
