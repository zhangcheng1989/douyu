//
//  ZCSliderResult.h
//  douyu
//
//  Created by zhangcheng on 16/2/6.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZCRoom;
@interface ZCSliderResult : NSObject
@property(nonatomic,copy)NSString *ID;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSURL *pic_url;
@property(nonatomic,strong)ZCRoom *room;
@end
