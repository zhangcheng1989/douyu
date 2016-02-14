

//
//  ZCSliderView.m
//  douyu
//
//  Created by zhangcheng on 16/2/5.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCSliderView.h"

@interface ZCSliderView()

@property (nonatomic,strong)UIView *sliderView;
@property (nonatomic,assign)NSInteger index;
@property (nonatomic,assign)BOOL isUseIndexProgress;//如果使用了indePressgress则,index失效，避免冲突

@property (nonatomic,assign)CGFloat width;
@property (nonatomic,assign)CGFloat height;

@property (nonatomic,assign)CGFloat slider_center_x;
@property (nonatomic,assign)CGFloat slider_center_y;

@end

@implementation ZCSliderView

- (UIView *)sliderView{
    if (_sliderView == nil) {
        _sliderView = [[UIView alloc]initWithFrame:CGRectMake(0,self.height-3, self.width, 3)];
        _sliderView.backgroundColor = [UIColor orangeColor];
        self.slider_center_x = _sliderView.center.x;
        self.slider_center_y = _sliderView.center.y;
    }
    return _sliderView;
}

- (instancetype)initWithFrame:(CGRect)frame Array:(NSArray<UIView *> *)array{
    if (self == [super initWithFrame:frame]) {
        [self commonInitWithArray:array];
    }
    return self;
}

- (void)commonInitWithArray:(NSArray<UIView *>*)array{
    self.width = self.frame.size.width/array.count;
    self.height = self.frame.size.height;
    
    [self addSubview:self.sliderView];
    
    [array enumerateObjectsUsingBlock:^(UIView * _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
        view.frame = CGRectMake(idx * self.width, 0, self.width, self.height-3);
        view.userInteractionEnabled = YES;
        view.tag = idx + 10;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPressed:)];
        [view addGestureRecognizer:tap];
        [self addSubview:view];
    }];
}

- (void)tapPressed:(UITapGestureRecognizer *)tapGest{
    self.index = tapGest.view.tag - 10;
    if (!self.isUseIndexProgress) {
        [UIView animateWithDuration:0.2 animations:^{
            self.sliderView.center = CGPointMake(self.slider_center_x+self.index*self.width,self.slider_center_y);
        }];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(sliderViewdidIndex:)]) {
        [self.delegate sliderViewdidIndex:self.index];
    }
}

- (void)setIndexProgress:(CGFloat)indexProgress{
    _indexProgress = indexProgress;
    self.isUseIndexProgress = YES;
    self.sliderView.center = CGPointMake(self.slider_center_x + _indexProgress * self.width,self.slider_center_y);
}

@end
