//
//  ZCSliderView.h
//  douyu
//
//  Created by zhangcheng on 16/2/5.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZCSliderView;

@protocol ZCSliderViewDelegate <NSObject>

- (void)sliderViewdidIndex:(NSInteger)index;

@end

@interface ZCSliderView : UIView


@property (nonatomic,assign)CGFloat indexProgress;

- (instancetype)initWithFrame:(CGRect)frame Array:(NSArray<UIView *> *)array;

@property(nonatomic,weak)id<ZCSliderViewDelegate> delegate;

@end
