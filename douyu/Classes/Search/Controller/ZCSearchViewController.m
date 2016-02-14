//
//  ZCSearchViewController.m
//  douyu
//
//  Created by zhangcheng on 16/1/30.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCSearchViewController.h"
#import "ZCSearchBar.h"
#import "ZCHeaderView.h"
#import "ZCDBTool.h"
#import "ZCSearchHttp.h"
#import "ZCData.h"
#import "ZCSearch.h"
@interface ZCSearchViewController ()<UITableViewDataSource,UITableViewDelegate,ZCHeaderViewDelegate,UITextFieldDelegate>
@property(nonatomic,strong)NSMutableArray *items;
@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,weak)ZCHeaderView *headerView;
@end

@implementation ZCSearchViewController

- (NSMutableArray *)items{
    if (_items == nil) {
        NSArray *array = [ZCDBTool findSearch];
        NSMutableArray *arrM = [NSMutableArray array];
        for (NSString *text in array) {
            [arrM addObject:text];
        }
        _items = arrM;
    }
    return _items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置导航工具栏
    [self setUpNavBar];
    //设置headerView
    [self setHeadView];
    
    [self setUpTableView];
    

}

- (void)setUpNavBar{
    ZCSearchBar *searchBar = [[ZCSearchBar alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 32)];
    searchBar.delegate = self;
    self.navigationItem.titleView = searchBar;
}

- (void)setHeadView{
    ZCHeaderView *headerView = [[ZCHeaderView alloc]initWithFrame:CGRectMake(0, 64, self.view.width, 50)];
    headerView.delegate = self;
    [self.view addSubview:headerView];
    self.headerView = headerView;
    
}

- (void)setUpTableView{
    
    CGFloat tableX = 0;
    CGFloat tableY = self.headerView.y+self.headerView.height;
    CGFloat tableW = self.view.width;
    CGFloat tableH = self.view.height;
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(tableX, tableY, tableW, tableH) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    

}

#pragma mark --UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.items.count==0) {
        UILabel *backView = [[UILabel alloc]initWithFrame:self.tableView.bounds];
        backView.text = @"暂无数据";
        backView.textColor = [UIColor lightGrayColor];
        backView.textAlignment = NSTextAlignmentCenter;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.backgroundView = backView;
        return 0;
    }else{
        return 1;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [self.items objectAtIndex:indexPath.row];
    
    
    return cell;
}

#pragma mark --ZCHeaderViewDelegate
- (void)headerViewClickClear:(ZCHeaderView *)headerView{
    [self.items removeAllObjects];
    [ZCDBTool clearText];
    [self.tableView reloadData];
}

#pragma mark --UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.text ==nil || [textField.text isEqualToString:@""]) {
        UIAlertController *show = [UIAlertController alertControllerWithTitle:@"提示" message:@"搜索的内容不能为空" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *yes = [UIAlertAction actionWithTitle:@"提示" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [show addAction:yes];
        [self presentViewController:show animated:YES completion:nil];
    }else{
        [ZCDBTool saveTitle:textField.text];
//        UIView *view = [[UIView alloc]initWithFrame:self.view.bounds];
//        view.backgroundColor = [UIColor redColor];
//        [self.view addSubview:view];
    }
    return YES;
}

/**
 
http://www.douyutv.com/api/v1/search/%E9%98%BF/1?aid=ios&client_sys=ios&time=1454250600&auth=ce5aca8c2e6c256b6848bf4f1125a659
 
http://www.douyutv.com/api/v1/search/%E9%98%BF/0?aid=ios&client_sys=ios&time=1454250600&auth=f148ceda9f6e672ebd177441f2f22f3a
 
 **/



@end
