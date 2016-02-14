//
//  UIBarButtonItem+ZCExtension.h
//  douyu
//
//  Created by zhangcheng on 16/1/30.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (ZCExtension)

+ (instancetype)barButtonItemWithImage:(NSString *)imageName highImage:(NSString *)highImageName target:(id)target action:(SEL)action;

+ (instancetype)barButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action;

@end
