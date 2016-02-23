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
#import "Masonry.h"

#define maxSections 100

@interface ZCScrollerView()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,weak)UICollectionViewFlowLayout *layout;
@property(nonatomic,weak)UICollectionView *collectionView;
@property(nonatomic,assign)NSInteger totalPageCount;
@property(nonatomic,strong)NSMutableArray *cacheImages;
@property(nonatomic,weak)UIControl *pageControl;
@property(nonatomic,strong)NSTimer *timer;
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
    
    [self setUpPageControl];
}

- (void)setUpPageControl{
    UIPageControl *pageControl = [UIPageControl new];
    pageControl.numberOfPages = self.cacheImages.count;
    pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    [self addSubview:pageControl];
    _pageControl = pageControl;

    [_collectionView reloadData];

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
    
    
    [self addTimer];
    
}



- (void)layoutSubviews{
    [super layoutSubviews];
    _layout.itemSize = self.frame.size;
    _collectionView.frame = self.bounds;
    
    [_pageControl sizeToFit];
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.right.equalTo(self).offset(-10);
        make.size.mas_equalTo(CGSizeMake(200, 30));
    }];
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

#pragma mark-UICollectionViewDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self removeNSTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self addTimer];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int page=(int)(scrollView.contentOffset.x/scrollView.frame.size.width+0.5)%self.cacheImages.count;
    UIPageControl *pageControl = (UIPageControl *)_pageControl;
    pageControl.currentPage = page;
}

- (void)addTimer{
    NSTimer *timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
    _timer = timer;
}

- (void)removeNSTimer{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)nextPage{
    //获取当前位置
    NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems]lastObject];
    //显示回中间那组数据
    NSIndexPath *currentIndexPathRest = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:0];
    [self.collectionView scrollToItemAtIndexPath:currentIndexPathRest atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    //计算下一个需要展示的位置
    NSInteger nextItem=currentIndexPathRest.item+1;
    NSInteger nextSection=currentIndexPathRest.section;
    if (nextItem == self.cacheImages.count) {
        nextItem = 0;
    }
    NSIndexPath *nextIndexPath=[NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    
    [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

- (void)clearCache{
    [NSData clearCache];
}

- (void)dealloc{
    [self.timer invalidate];
    self.timer = nil;
}

@end
