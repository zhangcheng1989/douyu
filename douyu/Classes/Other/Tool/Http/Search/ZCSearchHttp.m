//
//  ZCSearchHttp.m
//  douyu
//
//  Created by zhangcheng on 16/1/31.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCSearchHttp.h"
#import "ZCAFNManager.h"
#import "ZCSearch.h"
#import "ZCData.h"
@implementation ZCSearchHttp


+ (void)searchWithText:(NSString *)text  success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
    NSDictionary *dict = [NSDictionary dictionary];
    dict = @{@"aid":@"ios",@"client_sys":@"ios",@"time":@"1454250600",@"auth":@"ce5aca8c2e6c256b6848bf4f1125a659"};
    NSString *urlString = [NSString stringWithFormat:@"http://www.douyutv.com/api/v1/search/%@/1",text];
    NSString *urlStr = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [ZCAFNManager GET:urlStr parameters:[dict mj_keyValues] success:^(id responseObject) {
        NSArray *array = [ZCData mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
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
