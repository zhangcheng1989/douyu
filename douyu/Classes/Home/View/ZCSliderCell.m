//
//  ZCSliderCell.m
//  douyu
//
//  Created by zhangcheng on 16/2/22.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCSliderCell.h"

@interface ZCSliderCell()
@property(nonatomic,weak)UILabel *lb_title;
@end

@implementation ZCSliderCell

- (UIImageView *)imageView{
    if (_imageView == nil) {
        UIImageView *imageView = [UIImageView new];
        
        [self.contentView addSubview:imageView];
        _imageView = imageView;
    }
    return _imageView;
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.lb_title.text = [NSString stringWithFormat:@"   %@",title];
}

- (UILabel *)lb_title{
    if (_lb_title == nil) {
        UILabel *lable = [UILabel new];
        lable.hidden = YES;
        [self.contentView addSubview:lable];
        _lb_title = lable;
    }
    return _lb_title;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _imageView.frame = self.bounds;
    
    CGFloat titleLabelW = self.width;
    CGFloat titleLabelH = 30;
    CGFloat titleLabelX = 0;
    CGFloat titleLabelY = self.height - titleLabelH;
    _lb_title.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    _lb_title.hidden = !_lb_title.text;
}

@end
