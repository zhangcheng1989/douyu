//
//  ZCSearchBar.m
//  douyu
//
//  Created by zhangcheng on 16/1/31.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCSearchBar.h"

@implementation ZCSearchBar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        self.placeholder = @"搜索房间ID，主播名称";
        self.backgroundColor = color(211, 211, 211);
        self.font = [UIFont systemFontOfSize:14.0];
        UIImageView *leftView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, self.height)];
        leftView.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        self.leftView = leftView;
        self.leftViewMode = UITextFieldViewModeAlways;
        
        [self.layer setCornerRadius:10];
    }
    return self;
}


@end
