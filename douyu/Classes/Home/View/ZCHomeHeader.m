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
#import "NSData+ZCSDDataCache.h"
@interface ZCHomeHeader()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,weak)UICollectionView *collectionView;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,strong)NSMutableArray *imagesGroup;
@end

static NSString *ID = @"cell";

@implementation ZCHomeHeader


- (NSMutableArray *)imagesGroup{
    if (_imagesGroup == nil) {
        _imagesGroup = [NSMutableArray array];
    }
    return _imagesGroup;
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
    
//    [self addTimer];
    
}

- (void)setImageURLStringsGroup:(NSArray *)imageURLStringsGroup{
    _imageURLStringsGroup = imageURLStringsGroup;
    
    [self.imagesGroup addObjectsFromArray:imageURLStringsGroup];
    
    [self.collectionView reloadData];
    
    NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:imageURLStringsGroup.count];
    for (ZCSliderResult *result in imageURLStringsGroup) {
        [arrM addObject:result];
    }
    
    [self loadImageWithImageURLsGroup:arrM];

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

- (void)loadImageWithImageURLsGroup:(NSArray *)imageURLsGroup{
    
    for (NSInteger i = 0; i < imageURLsGroup.count; i++) {
        ZCSliderResult *result = [imageURLsGroup objectAtIndex:i];
        NSData *data = [NSData getDataCacheWithIdentifier:result.pic_url.absoluteString];
        [data saveDataCacheWithIdentifier:result.pic_url.absoluteString];
    }
}



- (void)didPage{
    NSIndexPath *currentIndexPathReset = [self resetIndexPath];
    NSInteger nextItem = currentIndexPathReset.item+1;
    if (nextItem== self.imagesGroup.count) {
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
    return self.imagesGroup.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZCHomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    ZCSliderResult *result = self.imagesGroup[indexPath.row];
    [cell.imageV sd_setImageWithURL:result.pic_url];
    cell.lb_title.text = result.title;
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

-(void)willMoveToWindow:(UIWindow *)newWindow{
    if (!newWindow) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)dealloc{
    self.collectionView.delegate = nil;
    self.collectionView.dataSource = self;
    [self.timer invalidate];
    self.timer = nil;
}

@end
