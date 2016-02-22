//
//  ZCScrollerView.m
//  douyu
//
//  Created by zhangcheng on 16/2/22.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCScrollerView.h"
#import "NSData+ZCSDDataCache.h"
#import "ZCSliderCell.h"
#import "ZCSilderModel.h"
#import "UIImageView+WebCache.h"
@interface ZCScrollerView()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,weak)UICollectionViewFlowLayout *layout;
@property(nonatomic,weak)UICollectionView *collectionView;
@property(nonatomic,assign)NSInteger totalPageCount;
@property(nonatomic,strong)NSMutableArray *cacheImages;

@end

static NSString *ID = @"slider";

@implementation ZCScrollerView

- (NSMutableArray *)cacheImages{
    if (_cacheImages == nil) {
        _cacheImages = [NSMutableArray array];
    }
    return _cacheImages;
}

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
    NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:images.count];
    for (NSInteger i=0; i<images.count; i++) {
        UIImage *image = [[UIImage alloc]init];
        [arrM addObject:image];
    }
    self.cacheImages = arrM;
    [self loadImageWithImageURLsGroup:images];
//    [_collectionView reloadData];
}

- (void)loadImageWithImageURLsGroup:(NSArray *)imgArr{
    for (int i = 0; i < imgArr.count; i++) {
        [self loadImageAtIndex:i];
    }
}

- (void)loadImageAtIndex:(NSInteger)index{
    NSString *urlStr = self.images[index];
    
    
    NSData *data = [NSData getDataCacheWithIdentifier:urlStr];

    if (data) {
        [self.cacheImages setObject:[UIImage imageWithData:data] atIndexedSubscript:index];
        [self.collectionView reloadData];
    }else{
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            UIImage *image = [UIImage imageWithData:data];
            [self.cacheImages setObject:image atIndexedSubscript:index];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (index==0) {
                    [_collectionView reloadData];
                }
            });
            [data saveDataCacheWithIdentifier:urlStr];
        }];
        [task resume];
    }
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
    [collectionView registerClass:[ZCSliderCell class] forCellWithReuseIdentifier:ID];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self addSubview:collectionView];
    _collectionView = collectionView;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _layout.itemSize = self.frame.size;
    _collectionView.frame = self.bounds;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZCSliderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    long itemIndex = indexPath.item % self.cacheImages.count;
    UIImage *image = self.cacheImages[itemIndex];
    cell.imageView.image = image;
    if (_titles) {
        cell.title = _titles[itemIndex];
    }
    return cell;
}

- (void)clearCache{
    [NSData clearCache];
}

@end
