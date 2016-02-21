//
//  NSString+ZCNowDate.m
//  douyu
//
//  Created by zhangcheng on 16/2/20.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "NSString+ZCNowDate.h"

@implementation NSString (ZCNowDate)

+ (NSString *)getCurrentTime{

    NSDate *nowDate = [NSDate date];
    NSTimeInterval times = nowDate.timeIntervalSince1970;
    return [NSString stringWithFormat:@"%.01f",times];
}

+ (NSString *)fm_date{
    NSDateFormatter *fm = [[NSDateFormatter alloc]init];
    fm.dateFormat = @"yyyyMMddHHmmss";
    return [fm stringFromDate:[NSDate new]];
}

@end
