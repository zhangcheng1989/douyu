//
//  ZCSliderResult.m
//  douyu
//
//  Created by zhangcheng on 16/2/6.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCSliderResult.h"
#import "ZCRoom.h"
@implementation ZCSliderResult

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"room":[ZCRoom class]};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}

@end
