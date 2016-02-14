//
//  ZCDBTool.m
//  douyu
//
//  Created by zhangcheng on 16/1/31.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCDBTool.h"
#import "FMDB.h"

#define PATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"/zc.sqlite"]


@interface ZCDBTool()

@end

static FMDatabase *_db;

@implementation ZCDBTool

+ (void)initialize{
    _db = [FMDatabase databaseWithPath:PATH];
    if ([_db open]) {
        BOOL success  = [_db executeUpdate:@"create table if not exists zc_search (id integer primary key autoincrement,title text not null);"];
        if (success) {
            NSLog(@"建表成功");
        }else{
            NSLog(@"建表失败");
        }
    }else{
        NSLog(@"打开失败");
    }
}

+ (void)saveTitle:(NSString *)text{
    BOOL success = [_db executeUpdate:@"insert into zc_search(title) values(?) ;",text];
    if (success) {
        NSLog(@"添加成功");
    }else{
        NSLog(@"添加失败");
    }
}

+ (NSArray *)findSearch{
    FMResultSet *rs;
    rs = [_db executeQuery:@"select title from zc_search;"];
    NSMutableArray *arrM = [NSMutableArray array];
    while ([rs next]) {
        [arrM addObject:[rs stringForColumn:@"title"]];
    }
    return arrM;
}

+ (void)clearText{
    BOOL success = [_db executeUpdate:@"delete from zc_search;"];
    if (success) {
        NSLog(@"删除成功");
    }else{
        NSLog(@"删除失败");
    }
}

@end
