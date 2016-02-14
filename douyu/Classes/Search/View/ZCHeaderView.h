//
//  ZCHeaderView.h
//  douyu
//
//  Created by zhangcheng on 16/1/31.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZCHeaderView;
@protocol ZCHeaderViewDelegate <NSObject>

- (void)headerViewClickClear:(ZCHeaderView *)headerView;

@end

@interface ZCHeaderView : UIView

@property(nonatomic,weak)id<ZCHeaderViewDelegate> delegate;

@end
