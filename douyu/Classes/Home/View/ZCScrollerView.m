//
//  ZCScrollerView.m
//  douyu
//
//  Created by zhangcheng on 16/2/22.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCScrollerView.h"

@interface ZCScrollerView()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,weak)UICollectionViewFlowLayout *layout;
@property(nonatomic,weak)UICollectionView *collectionView;
@property(nonatomic,assign)NSInteger totalPageCount;
@end

@implementation ZCScrollerView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self setUpView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self == [super initWithCoder:aDecoder]) {
        [self setUpView];
    }
    return self;
}


- (void)setImages:(NSArray *)images{
    _images = images;
    
    
}


- (void)setUpView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = self.frame.size;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _layout = layout;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
    collectionView.scrollsToTop = NO;
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.pagingEnabled = YES;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
//    [collectionView registerClass:[SDCollectionViewCell class] forCellWithReuseIdentifier:ID];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self addSubview:collectionView];
    _collectionView = collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    _layout.itemSize = self.frame.size;
    _collectionView.frame = self.bounds;
}

@end
