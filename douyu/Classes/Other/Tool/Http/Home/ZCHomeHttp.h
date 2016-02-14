//
//  ZCHomeHttp.h
//  douyu
//
//  Created by zhangcheng on 16/2/6.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface ZCHomeHttp : NSObject


+ (void)slider:(void(^)(NSArray *result))success failure:(void(^)(NSError *error))failure;

@end
