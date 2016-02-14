//
//  ZCSweepViewController.m
//  douyu
//
//  Created by zhangcheng on 16/1/31.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCSweepViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface ZCSweepViewController ()<AVCaptureMetadataOutputObjectsDelegate>
@property (nonatomic, weak) AVCaptureSession *session;
@property (nonatomic, weak) AVCaptureVideoPreviewLayer *layer;
@end



@implementation ZCSweepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    [self startReading];

 
}

- (void)startReading{
    AVCaptureSession *session = [[AVCaptureSession alloc]init];
    self.session = session;
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];

    if ([session canAddInput:input]) {
         [session addInput:input];
    }
   
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    
    if ([session canAddOutput:output]) {
        [session addOutput:output];
    }
    
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    if ([[output availableMetadataObjectTypes] containsObject:AVMetadataObjectTypeQRCode]) {
        [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    }
    
    
    // 4.添加扫描图层
    AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    layer.frame = self.view.bounds;
    [self.view.layer addSublayer:layer];
    self.layer = layer;
    // 5.开始扫描
    [session startRunning];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
//    NSString *stringValue = nil;
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *object = [metadataObjects lastObject];
        NSLog(@"%@", object.stringValue);
        // 停止扫描
        [self.session stopRunning];
        // 将预览图层移除
        [self.layer removeFromSuperlayer];
    } else {
        NSLog(@"没有扫描到数据");
    }

}


@end
