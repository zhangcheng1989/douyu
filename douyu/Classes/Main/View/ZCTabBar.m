//
//  ZCTabBar.m
//  douyu
//
//  Created by zhangcheng on 16/1/28.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCTabBar.h"
#import "ZCTabBarButton.h"
@interface ZCTabBar()

@property (nonatomic, strong) NSMutableArray *tabBarbuttons;

@property (nonatomic, strong) UIButton *selctedButton;
@end

@implementation ZCTabBar

- (NSMutableArray *)tabBarbuttons{
    if (_tabBarbuttons == nil) {
        _tabBarbuttons = [NSMutableArray array];
    }
    return _tabBarbuttons;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    NSInteger i = 0;
    NSInteger count = self.tabBarbuttons.count;
    CGFloat btnW = self.width/count;
    CGFloat btnH = self.height;
    
    for (UIView *tabView in self.tabBarbuttons) {
        tabView.frame = CGRectMake(i*btnW, 0, btnW, btnH);
        i++;
    }
}

- (void)addTabBarButtonWithItem:(UITabBarItem *)item{
    
    ZCTabBarButton *btn = [ZCTabBarButton buttonWithType:UIButtonTypeCustom];
    
    btn.item = item;
    
    btn.tag = self.tabBarbuttons.count;
    
    [btn addTarget:self action:@selector(didClickSlect:) forControlEvents:UIControlEventTouchDown];
    
    if (self.tabBarbuttons.count ==0) {
        [self didClickSlect:btn];
    }
    
    [self addSubview:btn];
    
    [self.tabBarbuttons addObject:btn];
    
}


- (void)didClickSlect:(UIButton *)btn{
    _selctedButton.selected = NO;
    btn.selected = YES;
    _selctedButton = btn;
    
    if ([self.delegate respondsToSelector:@selector(tabBar:didClickSlecteIndex:)]) {
        [self.delegate tabBar:self didClickSlecteIndex:btn.tag];
    }
}

@end
