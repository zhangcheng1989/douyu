//
//  ZCSearchHttp.h
//  douyu
//
//  Created by zhangcheng on 16/1/31.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCSearchHttp : NSObject


+ (void)searchWithText:(NSString *)text success:(void(^)(NSArray *array))success failure:(void(^)(NSError *error))failure;

@end
