//
//  FirstViewController.m
//  OpenCVDemo
//
//  Created by wanglijun on 2017/8/23.
//  Copyright © 2017年 wanglijun. All rights reserved.
//

#import "FirstViewController.h"
#import <opencv2/videoio/cap_ios.h>
using namespace cv;

@interface FirstViewController ()<CvVideoCameraDelegate>{
    CvVideoCamera *  videoCamera;
    __weak IBOutlet UIImageView *imageView;
    __weak IBOutlet UIButton *button;
}
@property (nonatomic, retain) CvVideoCamera* videoCamera;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.videoCamera = [[CvVideoCamera alloc]initWithParentView:imageView];
    self.videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionBack;
    self.videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset352x288;
    self.videoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
    self.videoCamera.defaultFPS = 30;
    self.videoCamera.grayscaleMode = NO;
    self.videoCamera.delegate = self;
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)start:(id)sender {
    [self.videoCamera start];
}

#ifdef __cplusplus
// delegate method for processing image frames
- (void)processImage:(Mat&)image{
    // Do some OpenCV stuff with the image
    Mat image_copy;
    cvtColor(image, image_copy, COLOR_BGR2GRAY);
    // invert image
    bitwise_not(image_copy, image_copy);
    //Convert BGR to BGRA (three channel to four channel)
    Mat bgr;
    cvtColor(image_copy, bgr, COLOR_GRAY2BGR);
    cvtColor(bgr, image, COLOR_BGR2BGRA);
}
#endif


@end
