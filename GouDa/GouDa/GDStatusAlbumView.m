//
//  GDStatusAlbumView.m
//  SomeViewsForGouDa
//
//  Created by 张威 on 15/9/21.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "GDStatusAlbumView.h"

@interface GDStatusAlbumView ()

@property (nonatomic, strong) NSArray *photoViews;;

@end

static CGFloat kAlbumInteritemSpacing = 5.f;
#define kAlbumMarginTop     (10.f)

@implementation GDStatusAlbumView {
    UIImageView *_imageView1;
    UIImageView *_imageView2;
    UIImageView *_imageView3;
}

- (UIImageView *)generateImageView {
    UIImageView *imageView           = [[UIImageView alloc] init];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:({
        UITapGestureRecognizer *tapGestureRecognizer =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sigleTapGestureRecognizerHandle:)];
        tapGestureRecognizer.numberOfTapsRequired = 1;
        tapGestureRecognizer;
    })];
    return imageView;
}

- (void)commonInit {
    self.backgroundColor = [UIColor greenColor];
    
    _imageView1 = [self generateImageView];
    _imageView2 = [self generateImageView];
    _imageView3 = [self generateImageView];
    
    _photoViews = @[_imageView1, _imageView2, _imageView3];
    
    [self addSubview:_imageView1];
    [self addSubview:_imageView2];
    [self addSubview:_imageView3];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)layoutSubviews {
    UIView *superView = self;
    
    [_imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView.mas_top).offset(kAlbumMarginTop);
        make.bottom.equalTo(superView.mas_bottom);
        make.left.equalTo(superView.mas_left);
        make.width.equalTo(_imageView2.mas_width);
    }];
    
    [_imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageView1.mas_top);
        make.bottom.equalTo(superView.mas_bottom);
        make.left.equalTo(_imageView1.mas_right).offset(kAlbumInteritemSpacing);
        make.width.equalTo(_imageView1.mas_width);
        make.width.equalTo(_imageView3.mas_width);
    }];
    
    [_imageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageView1.mas_top);
        make.bottom.equalTo(superView.mas_bottom);
        make.left.equalTo(_imageView2.mas_right).offset(kAlbumInteritemSpacing);
        make.right.equalTo(superView.mas_right);
        make.width.equalTo(_imageView2.mas_width);
    }];
    
    [super layoutSubviews];
}

- (void)sigleTapGestureRecognizerHandle:(UIGestureRecognizer *)gestureRecognizer {
    NSInteger index = [self.photoViews indexOfObject:gestureRecognizer.view];
    if ([self.delegate respondsToSelector:@selector(didTappedAlbumView:atIndex:)]) {
        [self.delegate didTappedAlbumView:self atIndex:index];
    } else {
        NSLog(@"无响应");
    }
}

- (void)prepareForReuse {
    for (UIImageView *imageView in self.photoViews) {
        imageView.image = nil;
    }
}

- (CGSize)intrinsicContentSize {
    //if (_photos.count == 0) {
    //    return CGSizeMake(UIViewNoIntrinsicMetric, UIViewNoIntrinsicMetric);
    //}
    CGFloat imageViewSideLength = floorf((self.maxWidth - kAlbumInteritemSpacing * 2) / 3);
    return CGSizeMake(imageViewSideLength * 3 + kAlbumInteritemSpacing * 2, imageViewSideLength + kAlbumMarginTop);
}

- (void)setPhotos:(NSArray *)photos {
    _photos = [photos copy];
    int i = 0;
    while (i < _photos.count) {
        UIImageView *imageView = [self.photoViews objectAtIndex:i];
        imageView.backgroundColor = [UIColor redColor];
        i++;
    }
    while (i < self.photoViews.count) {
        UIImageView *imageView = [self.photoViews objectAtIndex:i];
        imageView.backgroundColor = [UIColor clearColor];
        i++;
    }
}

@end
