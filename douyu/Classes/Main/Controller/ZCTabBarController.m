//
//  ZCTabBarController.m
//  douyu
//
//  Created by zhangcheng on 16/1/27.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCTabBarController.h"
#import "ZCNavigationController.h"
#import "ZCMineViewController.h"
#import "ZCLiveViewController.h"
#import "ZCColumnViewController.h"
#import "ZCHomeViewController.h"
#import "ZCTabBar.h"
@interface ZCTabBarController ()<TabBarDelegate>
@property(nonatomic,weak)ZCTabBar *customTabBar;
@property(nonatomic,strong)ZCMineViewController *mineVC;
@property(nonatomic,strong)ZCColumnViewController *columnVC;
@property(nonatomic,strong)ZCLiveViewController *liveVC;
@property(nonatomic,strong)ZCHomeViewController *homeVC;
@property(nonatomic,assign)NSInteger selIndex;
@end

@implementation ZCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTabBar];
    
    [self addAllViewController];
}

- (void)setUpTabBar{
    
    ZCTabBar *tabBar = [[ZCTabBar alloc]init];
    tabBar.frame = self.tabBar.bounds;
    tabBar.delegate = self;
    tabBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background"]];
    [self.tabBar addSubview:tabBar];
    _customTabBar = tabBar;
    
}

- (void)addAllViewController{
    
    ZCHomeViewController *homeVC = [[ZCHomeViewController alloc]init];
    [self setUpViewController:homeVC imageName:nil selImageName:nil title:@"首页"];
    _homeVC = homeVC;
    
    
    ZCColumnViewController *columnVC = [[ZCColumnViewController alloc]init];
    [self setUpViewController:columnVC imageName:@"" selImageName:@"" title:@"栏目"];
    _columnVC = columnVC;
    
    ZCLiveViewController *liveVC = [[ZCLiveViewController alloc]init];
    [self setUpViewController:liveVC imageName:@"" selImageName:@"" title:@"直播"];
    _liveVC = liveVC;
    
    ZCMineViewController *mineVC = [[ZCMineViewController alloc]init];
    [self setUpViewController:mineVC imageName:@"" selImageName:@"" title:@"我的"];
    _mineVC = mineVC;
}

- (void)setUpViewController:(UIViewController *)vc imageName:(NSString *)imageName selImageName:(NSString *)selImageName title:(NSString *)title{
    
    vc.title = title;
    
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    
    UIImage *selImage = [UIImage imageNamed:selImageName];
    
    if (iOS7) {
        selImage = [selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    vc.tabBarItem.selectedImage = selImage;
    
    ZCNavigationController *nav = [[ZCNavigationController alloc]initWithRootViewController:vc];
    
    [self addChildViewController:nav];
    
    [self.customTabBar addTabBarButtonWithItem:vc.tabBarItem];
}

- (void)tabBar:(ZCTabBar *)tabBar didClickSlecteIndex:(NSInteger)selIndex{
    self.selectedIndex = selIndex;
    self.selIndex = selIndex;
}


/**
http://www.douyutv.com/api/v1/slide/6?aid=ios&client_sys=ios&time=1454161080&auth=e62d8fb7f5704a88ef0fcae19241f77a

 http://www.douyutv.com/api/v1/getExpRule?aid=ios&client_sys=ios&time=1454161080&auth=27d14a2ee7e83143ac93eb4dbdddb615
 
http://www.douyutv.com/api/v1/getCyclePicture?aid=ios&client_sys=ios&time=1454161080&auth=da8844f4f88e2d76e0f33411cfaa5e87
 
http://www.douyutv.com/api/v1/channel?aid=ios&client_sys=ios&limit=4&time=1454161080&auth=2600f0cd824ddc278931646aad42eae9
 
 
http://www.douyutv.com/api/v1/getCyclePicture?aid=ios&client_sys=ios&time=1454161080&auth=da8844f4f88e2d76e0f33411cfaa5e87
 **/
 

@end
