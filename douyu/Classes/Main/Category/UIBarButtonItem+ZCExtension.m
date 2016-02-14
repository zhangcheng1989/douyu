//
//  UIBarButtonItem+ZCExtension.m
//  douyu
//
//  Created by zhangcheng on 16/1/30.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "UIBarButtonItem+ZCExtension.h"

@implementation UIBarButtonItem (ZCExtension)


+ (instancetype)barButtonItemWithImage:(NSString *)imageName highImage:(NSString *)highImageName target:(id)target action:(SEL)action{
    UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
    barButton.frame = CGRectMake(0, 0, 30, 30);
    [barButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [barButton setImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    [barButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc]initWithCustomView:barButton];
}

+ (instancetype)barButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 60, 30);
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}

@end
