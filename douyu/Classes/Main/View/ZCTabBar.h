//
//  ZCTabBar.h
//  douyu
//
//  Created by zhangcheng on 16/1/28.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZCTabBar;

@protocol TabBarDelegate <NSObject>

- (void)tabBar:(ZCTabBar *)tabBar didClickSlecteIndex:(NSInteger)selIndex;

@end

@interface ZCTabBar : UIView

@property(nonatomic,weak)id<TabBarDelegate> delegate;

- (void)addTabBarButtonWithItem:(UITabBarItem *)item;

@end
