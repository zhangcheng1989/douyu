//
//  ZCAFNManager.h
//  douyu
//
//  Created by zhangcheng on 16/1/31.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCAFNManager : NSObject

+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;


+ (void)POST:(NSString *)URLString parameters:(id)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

@end
