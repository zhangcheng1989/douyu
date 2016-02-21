//
//  ZCHomeResult.m
//  douyu
//
//  Created by zhangcheng on 16/2/22.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCHomeResult.h"
#import "ZCSilderModel.h"
@implementation ZCHomeResult

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"data":[ZCSilderModel class]};
}

@end
