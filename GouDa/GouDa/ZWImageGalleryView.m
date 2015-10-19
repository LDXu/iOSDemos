//
//  ZWImageGalleryView.m
//  GouDa
//
//  Created by 张威 on 15/9/26.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "ZWImageGalleryView.h"

#define kPageControlHeight       (10.f)
#define kPageControlMarginBottom (10.f)

@interface ZWImageGalleryView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, assign) NSInteger currentPageIndex;

@end

@implementation ZWImageGalleryView

- (void)commonInit {
    self.backgroundColor = [UIColor purpleColor];
    _currentPageIndex = -1;
    
    // init self.scrollView
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator   = NO;
    _scrollView.pagingEnabled                  = YES;
    _scrollView.delegate                       = self;
    [self addSubview:_scrollView];
    
    // init self.pageControl
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.pageIndicatorTintColor        = [UIColor lightGrayColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.currentPage                   = 0;
    [self addSubview:_pageControl];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

#pragma mark - setters

- (void)setPageControlPageIndicatorTintColor:(UIColor *)pageControlPageIndicatorTintColor {
    _pageControlPageIndicatorTintColor = pageControlPageIndicatorTintColor;
    self.pageControl.pageIndicatorTintColor = _pageControlPageIndicatorTintColor;
}

- (void)setPageControlCurrentPageIndicatorTintColor:(UIColor *)pageControlCurrentPageIndicatorTintColor {
    _pageControlCurrentPageIndicatorTintColor = pageControlCurrentPageIndicatorTintColor;
    self.pageControl.currentPageIndicatorTintColor = pageControlCurrentPageIndicatorTintColor;
}

//- (void)setImagesArray:(NSArray<AppWebImageViewDelegate> *)imagesArray {
- (void)setImagesArray:(NSArray *)imagesArray {
    for (UIView *view in _imagesArray) {
        if (view.superview != nil) {
            [view removeFromSuperview];
        }
    }
    _imagesArray = [imagesArray copy];
    for (int i = 0; i < _imagesArray.count; ++i) {
        UIView *view = _imagesArray[i];
        view.center = CGPointMake(self.center.x+self.bounds.size.width*i, self.center.y);
        [self.scrollView addSubview:view];
    }

    // update content size
    self.scrollView.contentSize =
    CGSizeMake(self.bounds.size.width * _imagesArray.count, self.bounds.size.height);
    // update content offset
    self.scrollView.contentOffset = CGPointZero;
    // update number of image views
    self.pageControl.numberOfPages = _imagesArray.count;
    
    // set first image views
    if (_imagesArray.count > 0) {
        [self didStartViewingPageAtIndex:0];
    }
}

#pragma mark - UIScrollViewDeleagte

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // calculate current page
    CGFloat currentContentOffsetX = scrollView.contentOffset.x;
    NSInteger currentIndex = (NSInteger)(currentContentOffsetX  / (self.bounds.size.width) + 0.5);
    
    if (currentIndex < 0) {
        currentIndex = 0;
    }
    if (currentIndex > self.imagesArray.count - 1) {
        currentIndex = self.imagesArray.count - 1;
    }
    
    // previous current page index
    NSUInteger previousCurrentPageIndex = self.currentPageIndex;
    // update currentPageIndex
    self.currentPageIndex = currentIndex;
    if (previousCurrentPageIndex != currentIndex) {
        [self didStartViewingPageAtIndex:currentIndex];
    }
}

- (void)didStartViewingPageAtIndex:(NSInteger)index {
    if (index < 0 || index >= self.imagesArray.count) {
        return;
    }
    
    // update page control
    self.pageControl.currentPage = index;
    
    // callback imageview startViewing handler
    id<AppWebImageViewDelegate> imageView = self.imagesArray[index];
    if ([imageView respondsToSelector:@selector(didStartViewing)]) {
        [imageView didStartViewing];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.scrollView.frame = self.bounds;
    
    CGSize pageControlSize = CGSizeMake(self.bounds.size.width, kPageControlHeight);
    self.pageControl.frame = CGRectMake((self.bounds.size.width - pageControlSize.width) / 2,
                                        self.bounds.size.height - pageControlSize.height - kPageControlMarginBottom,
                                        pageControlSize.width, pageControlSize.height);
}

@end
