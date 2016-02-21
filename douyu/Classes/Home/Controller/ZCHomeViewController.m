//
//  ZCHomeViewController.m
//  douyu
//
//  Created by zhangcheng on 16/1/28.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCHomeViewController.h"
#import "ZCNotesViewController.h"
#import "ZCSearchViewController.h"
#import "ZCSweepViewController.h"
#import "ZCSliderScrollerView.h"
#import "ZCRecommendViewController.h"
#import "ZCTwoViewController.h"
#import "Masonry.h"
#import "ZCHomeTool.h"
@interface ZCHomeViewController ()
@property(nonatomic,strong)NSArray *titles;
@end

@implementation ZCHomeViewController

- (NSArray *)titles{
    if (_titles == nil) {
        _titles = [NSArray arrayWithObjects:@"推荐",@"游戏",@"娱乐",@"奇葩", nil];
    }
    return _titles;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addUpNav];
    
    [self addSideNav];
}

- (void)addUpNav{

    self.navigationItem.title = nil;
    UIBarButtonItem *leftItem = [UIBarButtonItem barButtonItemWithTitle:@"斗鱼TV" target:self action:@selector(clickRefresh)];
    self.navigationItem.leftBarButtonItem  = leftItem;
    
    UIBarButtonItem *notesItem = [UIBarButtonItem barButtonItemWithTitle:@"历史" target:self action:@selector(clickHistory)];
    
    UIBarButtonItem *searchItem = [UIBarButtonItem barButtonItemWithImage:@"tabbar_discover" highImage:@"tabbar_discover_selected" target:self action:@selector(clickSearch)];
    
    UIBarButtonItem *sweepItem = [UIBarButtonItem barButtonItemWithImage:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted" target:self action:@selector(clickSweep)];

    self.navigationItem.rightBarButtonItems = @[notesItem,searchItem,sweepItem];

}

- (void)addSideNav{
    
    UILabel *lb_recommend = [UILabel new];
    lb_recommend.text = @"推荐";
    lb_recommend.textAlignment = NSTextAlignmentCenter;
    
    UILabel *lb_game = [UILabel new];
    lb_game.text = @"游戏";
    lb_game.textAlignment = NSTextAlignmentCenter;

    UILabel *lb_recreation = [UILabel new];
    lb_recreation.text = @"娱乐";
    lb_recreation.textAlignment = NSTextAlignmentCenter;

    UILabel *lb_wonderful = [UILabel new];
    lb_wonderful.text = @"奇葩";
    lb_wonderful.textAlignment = NSTextAlignmentCenter;
    
    
    UIView *view2 = [UIView new];
    view2.backgroundColor = [UIColor orangeColor];
    UIView *view3 = [UIView new];
    view3.backgroundColor = [UIColor purpleColor];
    UIView *view4 = [UIView new];
    view4.backgroundColor = [UIColor yellowColor];
    
   
    
    ZCRecommendViewController *recoVC = [[ZCRecommendViewController alloc]init];
    ZCTwoViewController *twoVC = [[ZCTwoViewController alloc]init];
    
    
    ZCSliderScrollerView *scrollerView = [[ZCSliderScrollerView alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)) titles:@[lb_recommend,lb_game,lb_recreation,lb_wonderful] contents:@[recoVC.view,twoVC.view,view3,view4]];
    [self.view addSubview:scrollerView];
}

- (void)clickRefresh{
    
}

- (void)clickHistory{
    ZCNotesViewController *notesVC = [[ZCNotesViewController alloc]init];
    notesVC.hidesBottomBarWhenPushed = YES;
    notesVC.title = @"观看历史";
    [self.navigationController pushViewController:notesVC animated:YES];
}

- (void)clickSearch{
    ZCSearchViewController *searchVC = [[ZCSearchViewController alloc]init];
    searchVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchVC animated:YES];
}

- (void)clickSweep{
    ZCSweepViewController *sweepVC = [[ZCSweepViewController alloc]init];
    sweepVC.hidesBottomBarWhenPushed = YES;
    sweepVC.title = @"扫描二维码";
    [self.navigationController pushViewController:sweepVC animated:YES];
}

/**
 
 http://capi.douyucdn.cn/api/v1/channel?aid=ios&client_sys=ios&limit=4&time=1454671140&auth=087b7896c20b2a87730871b0b84b1062
 
 
 **/

@end
