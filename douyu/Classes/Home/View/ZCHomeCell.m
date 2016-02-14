
//
//  ZCHomeCell.m
//  douyu
//
//  Created by zhangcheng on 16/2/14.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCHomeCell.h"
#import "Masonry.h"
@interface ZCHomeCell()
@property(nonatomic,weak)UIView *tool;
@end

@implementation ZCHomeCell


- (UIView *)tool{
    if (_tool == nil) {
        UIView *tool = [UIView new];
        tool.backgroundColor = [UIColor blackColor];
        tool.alpha = 0.4;
        [self.contentView addSubview:tool];
        self.tool = tool;
    }
    return _tool;
}

- (UIImageView *)imageV{
    if (_imageV == nil) {
        UIImageView *imageV = [UIImageView new];
        [self.contentView addSubview:imageV];
        self.imageV = imageV;
    }
    return _imageV;
}

- (UILabel *)lb_title{
    if (_lb_title == nil) {
        UILabel *title = [UILabel new];
        title.font = [UIFont systemFontOfSize:15.0];
        title.textColor = [UIColor whiteColor];
        [title sizeToFit];
        [self.tool addSubview:title];
        self.lb_title = title;
    }
    return _lb_title;
}



- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageV.frame = self.bounds;
    
    [self.tool mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(self.width, 30));
    }];
    
    self.lb_title.frame = CGRectMake(20, 0, self.width, 30);
    
}

@end
