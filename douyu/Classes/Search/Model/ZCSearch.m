//
//  ZCSearch.m
//  douyu
//
//  Created by zhangcheng on 16/1/31.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCSearch.h"
#import "MJExtension.h"
#import "ZCData.h"
@implementation ZCSearch

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"data":[ZCData class]};
}

@end
