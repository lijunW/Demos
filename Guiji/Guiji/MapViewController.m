//
//  MapViewController.m
//  SF-Manger
//
//  Created by wanglijun on 2017/8/24.
//  Copyright © 2017年 sifang. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()<MAMapViewDelegate>
@property (nonatomic, strong) MAMapView *mapView;
@end

@implementation MapViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =  @"定位";
    [self setupMapView];
}
- (void)viewDidAppear:(BOOL)animated{
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(self.localtion.latitude, self.localtion.longitude);
    pointAnnotation.title = self.localtion.formattedAddress;
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    pointAnnotation.subtitle = [formatter stringFromDate:self.localtion.creatTime];
    [_mapView addAnnotation:pointAnnotation];
    [_mapView selectAnnotation:pointAnnotation animated:YES];
}
#pragma mark - MAMapView Delegate
- (void)setupMapView
{
    [self.view addSubview:self.mapView];
    
    [self.mapView setDelegate:self];
    [self.mapView setZoomLevel:16 animated:NO];
    
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollowWithHeading;
    
    self.mapView.centerCoordinate = CLLocationCoordinate2DMake(self.localtion.latitude, self.localtion.longitude);
}
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAUserLocation class]]) {
        return nil;
    }
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.pinColor = MAPinAnnotationColorRed;
        return annotationView;
    }
    return nil;
}

-(MAMapView *)mapView{
    if (!_mapView)
    {
        _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
        //        _mapView.centerCoordinate = [MapGerTool share].location;
    }
    return _mapView;
}


@end
