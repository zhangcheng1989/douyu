//
//  UIView+ZCExtension.m
//  douyu
//
//  Created by zhangcheng on 16/1/27.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "UIView+ZCExtension.h"

@implementation UIView (ZCExtension)

#pragma mark --setter

- (void)setX:(CGFloat)x{
    CGRect rec = self.frame;
    rec.origin.x = x;
    self.frame = rec;
}

- (void)setY:(CGFloat)y{
    CGRect rec = self.frame;
    rec.origin.y = y;
    self.frame = rec;
}

- (void)setWidth:(CGFloat)width{
    CGRect rec = self.frame;
    rec.size.width = width;
    self.frame = rec;
}

- (void)setHeight:(CGFloat)height{
    CGRect rec = self.frame;
    rec.size.height = height;
    self.frame = rec;
}

#pragma mark --getter

- (CGFloat)x{
    return self.frame.origin.x;
}

- (CGFloat)y{
    return self.frame.origin.y;
}

- (CGFloat)width{
    return self.frame.size.width;
}

- (CGFloat)height{
    return self.frame.size.height;
}

@end
