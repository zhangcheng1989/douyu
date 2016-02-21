//
//  ZCBaseResult.h
//  douyu
//
//  Created by zhangcheng on 16/2/22.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCBaseResult : NSObject
@property(nonatomic,strong)NSArray *data;
@property(nonatomic,copy)NSString *error;
@end
