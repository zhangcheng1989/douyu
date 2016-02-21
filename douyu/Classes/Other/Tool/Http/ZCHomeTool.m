//
//  ZCHomeTool.m
//  douyu
//
//  Created by zhangcheng on 16/2/21.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCHomeTool.h"
#import "ZCHttpTool.h"
#import "MJExtension.h"
#import "ZCHomeResult.h"
#import "ZCSilderModel.h"
#import "NSString+ZCNowDate.h"
@implementation ZCHomeTool

+ (void)hoemSilder:(void (^)(NSArray *))success{
    NSDictionary *param = [NSDictionary dictionary];
    param = @{@"client_sys":@"ios",@"time":[NSString getCurrentTime],@"version":@"2.0",@"auth":@"36e253d6a48a5aa36e9d17406a4e634e",@"aid":@"ios"};
    [ZCHttpTool postWithPath:@"http://capi.douyucdn.cn/api/v1/slide/6" params:[param mj_keyValues] completion:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }else{
            ZCHomeResult *result = [ZCHomeResult mj_objectWithKeyValues:responseObject];
            if ([result.error isEqualToString:@"0"]) {
                NSMutableArray *titles = [NSMutableArray array];
                NSMutableArray *images = [NSMutableArray array];
                [result.data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    ZCSilderModel *model = (ZCSilderModel *)obj;
                    [titles addObject:model.title];
                    [images addObject:model.pic_url];
                }];
                success(@[titles,images]);
            }else{
                NSLog(@"%@",result.error);
            }
        }
    }];
}

@end
