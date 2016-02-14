//
//  ZCSliderScrollerView.m
//  douyu
//
//  Created by zhangcheng on 16/2/5.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCSliderScrollerView.h"
#import "ZCSliderView.h"
@interface ZCSliderScrollerView()<ZCSliderViewDelegate,UIScrollViewDelegate>
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)ZCSliderView *sliderView;

@property (nonatomic,assign)NSInteger arrayCount;
@property (nonatomic,assign)BOOL shoulScroll;
@end

@implementation ZCSliderScrollerView


- (UIScrollView *)scrollView {
    if (!_scrollView) {
        self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.sliderView.frame.size.height, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)-self.sliderView.frame.size.height)];
        self.scrollView.pagingEnabled = YES;
        self.scrollView.delegate = self;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.bounces = NO;
    }
    return _scrollView;
}


- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<UIView *> *)titles contents:(NSArray<UIView *> *)contents{
    if (self == [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        [self commonInitWithItemArray:titles contents:contents];
    }
    return self;
}

- (void)commonInitWithItemArray:(NSArray<UIView *>*)titles contents:(NSArray<UIView *>*)contents{
    self.arrayCount = titles.count;
    
    self.sliderView = [[ZCSliderView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), 50) Array:titles];
    
    self.sliderView.delegate = self;
    
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.bounds)*titles.count, CGRectGetHeight(self.bounds)-self.sliderView.frame.size.height);
    
    [contents enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.frame = CGRectMake(idx*CGRectGetWidth(self.bounds), 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
        [self.scrollView addSubview:obj];
    }];
    
    [self addSubview:self.sliderView];
    
    [self addSubview:self.scrollView];
}


- (void)sliderViewdidIndex:(NSInteger)index{
    [self.scrollView setContentOffset:CGPointMake(index*CGRectGetWidth(self.bounds), self.scrollView.contentOffset.y) animated:YES];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat f = scrollView.contentOffset.x/self.bounds.size.width;
    self.sliderView.indexProgress = f;
}


@end
