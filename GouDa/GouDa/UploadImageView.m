//
//  UploadImageView.m
//  SomeViewsForGouDa
//
//  Created by 张威 on 15/10/15.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "UploadImageView.h"

static NSString * noticeText;
static UIColor * noticeColor;
static UIFont * noticeFont;
static CGFloat borderWidth;

@interface UploadImageView ()

@property (nonatomic, strong) UIImageView *innerImageView;

@end


@implementation UploadImageView

+ (void)initialize {
    noticeText  = @"添加照片";
    noticeColor = [[UIColor alloc] initWithRed:216/255.f green:217/255.f blue:217/255.f alpha:1.0];
    noticeFont  = [UIFont systemFontOfSize:11.f];
}

- (void)commonInit {
    _innerImageView = ({
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView;
    });
    [self addSubview:_innerImageView];
    
    borderWidth = 1.f;
    
    self.backgroundColor   = [UIColor whiteColor];
    self.layer.borderColor = [noticeColor CGColor];
    self.layer.borderWidth = borderWidth;
    
    [self addTarget:self action:@selector(clickedHandle:) forControlEvents:UIControlEventTouchUpInside];
    
    UILongPressGestureRecognizer *longPress =
    [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressHandle:)];
//    longPress.minimumPressDuration = 0.8;
    [self addGestureRecognizer:longPress];
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

- (instancetype)initWithImage:(UIImage *)image {
    NSAssert(true, @"not avaliable");
    return nil;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    NSAssert(true, @"not avaliable");
    return nil;
}

- (instancetype)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage {
    NSAssert(true, @"not avaliable");
    return nil;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.innerImageView.frame = self.bounds;
}

- (void)drawRect:(CGRect)rect {
#define kTextHeight     (16.f)
#define kLineMargin     (10.f)
#define kOffsetY        (5.f)
    [noticeColor set];
    UIBezierPath *viewPath = [UIBezierPath bezierPath];
    // 竖线
    [viewPath moveToPoint:CGPointMake(self.frame.size.width / 2,
                                      MIN(kLineMargin+kOffsetY, self.frame.size.height))];
    [viewPath addLineToPoint:CGPointMake(self.frame.size.width / 2,
                                         MAX(self.frame.size.height - kLineMargin - kTextHeight+kOffsetY, 0))];
    [viewPath closePath];
    [viewPath stroke];
    
    // 横线
    [viewPath moveToPoint:CGPointMake(MIN(kLineMargin+kTextHeight/2, self.frame.size.width),
                                      (self.frame.size.height - kTextHeight) / 2 + kOffsetY)];
    [viewPath addLineToPoint:CGPointMake(MAX(0, self.frame.size.width-kLineMargin-kTextHeight/2),
                                         (self.frame.size.height - kTextHeight) / 2 + kOffsetY)];
    [viewPath closePath];
    [viewPath stroke];
    
    if ([self respondsToSelector:@selector(snapshotViewAfterScreenUpdates:)]) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.alignment = NSTextAlignmentCenter;
        [noticeText drawInRect:CGRectMake(0, self.frame.size.height-kTextHeight, self.frame.size.width, kTextHeight)
                withAttributes:@{NSFontAttributeName:noticeFont,
                                 NSForegroundColorAttributeName:noticeColor,
                                 NSParagraphStyleAttributeName:paragraphStyle}
         ];
    } else {
        [noticeText drawInRect:CGRectMake(0, self.frame.size.height-kTextHeight, self.frame.size.width, kTextHeight)
                withAttributes:@{NSFontAttributeName:noticeFont,
                                 NSForegroundColorAttributeName:noticeColor}];
    }
}

- (void)setImage:(UIImage *)image {
    if (_image == image) {
        return;
    }
    _image = image;
    self.innerImageView.image = image;
    if (_image != nil) {
        self.layer.borderColor = [[UIColor clearColor] CGColor];
        self.layer.borderWidth = 0.f;
    } else {
        self.layer.borderColor = [noticeColor CGColor];
        self.layer.borderWidth = borderWidth;
    }
}

#pragma mark - actions

- (void)clickedHandle:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didClickedUploadImageView:)]) {
        [self.delegate didClickedUploadImageView:self];
    }
}

- (void)longPressHandle:(UILongPressGestureRecognizer *)gesture {
    if (gesture.state != UIGestureRecognizerStateBegan) {
        return;
    }
    if ([self.delegate respondsToSelector:@selector(didLongPressedUploadImageView:)]) {
        [self.delegate didLongPressedUploadImageView:self];
    }
}

@end
