//
//  ZCHeaderView.m
//  douyu
//
//  Created by zhangcheng on 16/1/31.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCHeaderView.h"
#import "Masonry.h"
@interface ZCHeaderView()
@property(nonatomic,weak)UILabel *lb_text;
@property(nonatomic,weak)UIButton *btn_clear;
@end

@implementation ZCHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self setUpView];
    }
    return self;
}

- (void)setUpView{
    UILabel *lb_text = [UILabel new];
    lb_text.text = @"历史搜索";
    lb_text.textColor = [UIColor lightGrayColor];
    [self addSubview:lb_text];
    self.lb_text = lb_text;
    
    UIButton *btn_clear = [UIButton new];
    [btn_clear setTitle:@"清空" forState:UIControlStateNormal];
    [btn_clear setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btn_clear addTarget:self action:@selector(ClickClear:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn_clear];
    self.btn_clear = btn_clear;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.lb_text sizeToFit];
    [self.lb_text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.centerY.equalTo(self);
    }];
    
    [self.btn_clear mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-30);
        make.centerY.equalTo(self);
    }];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(self.width, 1));
    }];
}


- (void)ClickClear:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(headerViewClickClear:)]) {
        [self.delegate headerViewClickClear:self];
    }
}

@end

