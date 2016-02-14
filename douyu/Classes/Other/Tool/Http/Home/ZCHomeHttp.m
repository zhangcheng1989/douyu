//
//  ZCHomeHttp.m
//  douyu
//
//  Created by zhangcheng on 16/2/6.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCHomeHttp.h"
#import "ZCAFNManager.h"
#import "ZCSliderResult.h"
@implementation ZCHomeHttp


+ (void)slider:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
    NSDictionary *param = [NSDictionary dictionary];
    param = @{@"client_sys":@"ios",@"time":@"1454671140",@"version":@"2.0",@"auth":@"36e253d6a48a5aa36e9d17406a4e634e"};
    [ZCAFNManager GET:@"http://capi.douyucdn.cn/api/v1/slide/6?aid=ios" parameters:[param mj_keyValues] success:^(id responseObject) {
        NSArray *array = [ZCSliderResult mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        if (success) {
            success(array);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
