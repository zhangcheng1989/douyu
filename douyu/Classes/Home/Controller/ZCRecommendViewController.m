//
//  ZCRecommendViewController.m
//  douyu
//
//  Created by zhangcheng on 16/2/6.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCRecommendViewController.h"
#import "ZCHomeHttp.h"
#import "Masonry.h"
#import "ZCHomeHeader.h"
#import "ZCHomeBody.h"
@interface ZCRecommendViewController ()

@end

@implementation ZCRecommendViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpHeaderView];
    
}


- (void)setUpHeaderView{
    [ZCHomeHttp slider:^(NSArray *result) {
        ZCHomeHeader *header = [ZCHomeHeader new];
        [self.view addSubview:header];
        [header mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.view);
            make.size.mas_equalTo(CGSizeMake(self.view.width, 150));
        }];
        header.items = result;
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


@end
