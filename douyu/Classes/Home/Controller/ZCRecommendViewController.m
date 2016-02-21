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
@interface ZCRecommendViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *items;
@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,weak)ZCHomeHeader *header;
@end


@implementation ZCRecommendViewController


- (NSMutableArray *)items{
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [self setUpHeaderView];

    [self loadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

- (void)setUpHeaderView{
    ZCHomeHeader *header = [ZCHomeHeader new];
    [self.view addSubview:header];
    self.header = header;
    [header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(self.view.width, 150));
    }];
    self.tableView.tableHeaderView = header;
    
}


- (void)loadData{
    [ZCHomeHttp slider:^(NSArray *result) {
        self.header.imageURLStringsGroup = result;
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}




@end
