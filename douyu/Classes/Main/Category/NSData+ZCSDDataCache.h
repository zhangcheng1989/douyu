//
//  NSData+ZCSDDataCache.h
//  douyu
//
//  Created by zhangcheng on 16/2/19.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (ZCSDDataCache)

- (void)saveDataCacheWithIdentifier:(NSString *)identifier;

+ (NSData *)getDataCacheWithIdentifier:(NSString *)identifier;

+ (void)clearCache;

@end
