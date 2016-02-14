//
//  ZCData.h
//  douyu
//
//  Created by zhangcheng on 16/1/31.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCData : NSObject
@property(nonatomic,copy)NSString *room_id;
@property(nonatomic,copy)NSURL *room_src;
@property(nonatomic,copy)NSString *cate_id;
@property(nonatomic,copy)NSString *room_name;
@property(nonatomic,copy)NSString *show_status;
@property(nonatomic,copy)NSString *subject;
@property(nonatomic,copy)NSString *show_time;
@property(nonatomic,copy)NSString *owner_uid;
@property(nonatomic,copy)NSString *specific_catalog;
@property(nonatomic,copy)NSString *specific_status;
@property(nonatomic,copy)NSString *vod_quality;
@property(nonatomic,copy)NSString *nickname;
@property(nonatomic,assign)int online;
@property(nonatomic,copy)NSString *child_id;
@property(nonatomic,copy)NSString *url;
@property(nonatomic,copy)NSString *game_url;
@property(nonatomic,copy)NSString *game_name;
@property(nonatomic,copy)NSString *fans;
@end
