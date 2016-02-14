//
//  ZCHomeHeader.m
//  douyu
//
//  Created by zhangcheng on 16/2/14.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCHomeHeader.h"
#import "ZCHomeCell.h"
#import "UIImageView+WebCache.h"
#import "ZCSliderResult.h"
@interface ZCHomeHeader()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,weak)UICollectionView *collectionView;
@property(nonatomic,strong)NSTimer *timer;
@end

static NSString *ID = @"cell";

@implementation ZCHomeHeader

- (NSArray *)items{
    if (_items == nil) {
        _items = [NSArray array];
    }
    return _items;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(self.width, self.height);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.pagingEnabled = YES;
    [collectionView registerClass:[ZCHomeCell class] forCellWithReuseIdentifier:ID];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self addSubview:collectionView];
    self.collectionView = collectionView;
    
    [self addTimer];
  
}

- (void)addTimer{
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(didPage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSDefaultRunLoopMode];
    self.timer = timer;
}

- (void)removeTimer{
    [self.timer invalidate];
    self.timer = nil;
}

- (NSIndexPath *)resetIndexPath{
    NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems]lastObject];
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:0];
     [self.collectionView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    return currentIndexPathReset;
}


- (void)didPage{
    NSIndexPath *currentIndexPathReset = [self resetIndexPath];
    NSInteger nextItem = currentIndexPathReset.item+1;
    if (nextItem== self.items.count) {
        nextItem =0;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:0];
    
    [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}


#pragma mark --UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZCHomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    dispatch_async(dispatch_get_main_queue(), ^{
        ZCSliderResult *result = self.items[indexPath.row];
        [cell.imageV sd_setImageWithURL:result.pic_url];
        cell.lb_title.text = result.title;
    });
    return cell;
}
#pragma mark --UICollectionViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self removeTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self addTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

- (void)dealloc{
    [self.timer invalidate];
    self.timer = nil;
}

@end
