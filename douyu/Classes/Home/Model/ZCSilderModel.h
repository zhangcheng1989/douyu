//
//  ZCSilderModel.h
//  douyu
//
//  Created by zhangcheng on 16/2/22.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCRoomModel.h"
@interface ZCSilderModel : NSObject
@property(nonatomic,copy)NSString *ID;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *pic_url;
@property(nonatomic,strong)ZCRoomModel *room;
@end
