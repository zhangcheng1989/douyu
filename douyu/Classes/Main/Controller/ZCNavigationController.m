//
//  ZCNavigationController.m
//  douyu
//
//  Created by zhangcheng on 16/1/27.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCNavigationController.h"
#import "ZCTabBar.h"
#import "ZCTitleView.h"
@interface ZCNavigationController ()<UINavigationControllerDelegate>

@end

@implementation ZCNavigationController

+ (void)initialize{
    if (self == [ZCNavigationController class]) {
         [self setUpNavBar];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.interactivePopGestureRecognizer.delegate = nil;
    
    self.delegate = self;
}

+ (void)setUpNavBar{
    
    UINavigationBar *appearance = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:[NSArray arrayWithObjects:[ZCNavigationController class], nil]];
    [appearance setBarTintColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]];
    
    UIBarButtonItem *barItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:[NSArray arrayWithObjects:[ZCNavigationController class], nil]];
    
    NSMutableDictionary *disableDictM = [NSMutableDictionary dictionary];
    disableDictM[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [barItem setTitleTextAttributes:disableDictM forState:UIControlStateDisabled];
    
    NSMutableDictionary *normalDictM = [NSMutableDictionary dictionary];
    normalDictM[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
    [barItem setTitleTextAttributes:normalDictM forState:UIControlStateNormal];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    
    if (self.childViewControllers.count) {
        
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIBarButtonItem *popPre = [UIBarButtonItem barButtonItemWithImage:@"navigationbar_back" highImage:@"navigationbar_back_highlighted" target:self action:@selector(popToPre)];
        viewController.navigationItem.leftBarButtonItem = popPre;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)popToPre{
     [self popViewControllerAnimated:YES];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    UITabBarController *tabBarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    
    for (UIView *tabBarButton in tabBarVc.tabBar.subviews) {
        if (![tabBarButton isKindOfClass:[ZCTabBar class]]) {
            [tabBarButton removeFromSuperview];
        }
    }
    
}


@end
