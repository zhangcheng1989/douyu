//
//  ZCTabBarButton.m
//  douyu
//
//  Created by zhangcheng on 16/1/27.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCTabBarButton.h"
#import "Masonry.h"


@implementation ZCTabBarButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:13.0];
        [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    }
    return self;
}

- (void)setItem:(UITabBarItem *)item{
    _item = item;
    //设置tabBarItem的图片
    [self setImage:item.image forState:UIControlStateNormal];
    [self setImage:item.image forState:UIControlStateSelected];
    //设置tabBarItem的标题
    [self setTitle:item.title forState:UIControlStateNormal];
    
    [self addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
    
    [self addObserver:self forKeyPath:@"selectedImage" options:NSKeyValueObservingOptionNew context:nil];
    
    [self addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
    [self setTitle:self.item.title forState:UIControlStateNormal];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat btnW = self.width;
    CGFloat btnH = self.height;
    CGFloat imageH = btnH *0.7;
    self.imageView.frame = CGRectMake(0, 0, btnW, imageH);
 
    
    CGFloat titleH = btnH - imageH;
    CGFloat titleY = imageH - 2;
    self.titleLabel.frame = CGRectMake(0, titleY, btnW, titleH);
    
}

- (void)setHighlighted:(BOOL)highlighted{
    
}

- (void)dealloc{
    [self removeObserver:self forKeyPath:@"image"];
    [self removeObserver:self forKeyPath:@"selectedImage"];
    [self removeObserver:self forKeyPath:@"title"];
}

@end

