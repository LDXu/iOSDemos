//
//  ZWCommentInputView.m
//  SomeViewsForGouDa
//
//  Created by 张威 on 15/9/28.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "ZWCommentInputView.h"

@interface ZWCommentInputView () <HPGrowingTextViewDelegate>

@property (nonatomic, strong) UIButton *faceButton;
@property (nonatomic, strong) HPGrowingTextView *inputView;

@end

@implementation ZWCommentInputView

#define kTopLineHeihgt    (0.5)
#define kViewHeight       (44.5)
#define kButtonSideLength (35.f)
#define kLineSpacing      (12.f)

- (void)commonInit {
    self.backgroundColor = [UIColor whiteColor];
    
    UIView *topLineView =
    [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, kTopLineHeihgt)];
    topLineView.backgroundColor = [UIColor lightGrayColor];
    topLineView.autoresizingMask =
    UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [self addSubview:topLineView];
    
    // top left bottom right
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(5+kTopLineHeihgt, 14, 8, 14);
    _inputView =
    [[HPGrowingTextView alloc] initWithFrame:CGRectMake(edgeInsets.left, edgeInsets.top,
                                                 self.frame.size.width - edgeInsets.right
                                                 - edgeInsets.left - kLineSpacing - kButtonSideLength,
                                                 kViewHeight - edgeInsets.top - edgeInsets.bottom)];
    //_inputTextField.backgroundColor = [UIColor redColor];
    _inputView.layer.borderColor             = [[UIColor lightGrayColor] CGColor];
    _inputView.layer.borderWidth             = 0.5f;
    _inputView.layer.cornerRadius            = 5.f;
    _inputView.isScrollable                  = NO;
    _inputView.contentInset                  = UIEdgeInsetsMake(5, 2, 5, 2);
    _inputView.font                          = [UIFont systemFontOfSize:14.f];
    _inputView.enablesReturnKeyAutomatically = YES;
    _inputView.delegate                      = self;

//    _inputView.minHeight = kViewHeight - 8 - kTopLineHeihgt - 8;
    _inputView.minNumberOfLines = 1;
    _inputView.maxNumberOfLines = 6;

    _inputView.placeholder                            = @"评论";
    _inputView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
    _inputView.autoresizingMask                       = UIViewAutoresizingFlexibleWidth;
    _inputView.returnKeyType                          = UIReturnKeySend;
    
    [self addSubview:_inputView];
    
    _faceButton =
    [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - edgeInsets.right - kButtonSideLength,
                                               (kViewHeight-kButtonSideLength)/2, kButtonSideLength, kButtonSideLength)];
    [_faceButton setImage:[UIImage imageNamed:@"face"] forState:UIControlStateNormal];
    _faceButton.selected = false;
//    [_faceButton setImage:[UIImage imageNamed:@"face_HL"] forState:UIControlStateHighlighted];
    [_faceButton setImage:[UIImage imageNamed:@"keyboard"] forState:UIControlStateSelected];
    [_faceButton addTarget:self
                    action:@selector(faceButtonDidClicked:)
          forControlEvents:UIControlEventTouchUpInside];
    _faceButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
    [self addSubview:_faceButton];
    
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
}

- (instancetype)initWithOrigin:(CGPoint)origin {
    self = [super initWithFrame:CGRectMake(origin.x, origin.y, [UIScreen mainScreen].bounds.size.width, kViewHeight)];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)faceButtonDidClicked:(UIButton *)sender {
    sender.selected = !sender.selected;

    if ([self.delegate respondsToSelector:@selector(inputView:didSendEmotionStateChanged:)]) {
        [self.delegate inputView:self didSendEmotionStateChanged:sender.selected];
    }
}

- (void)prepareForReuse {
    self.faceButton.selected = false;
    self.inputView.text = nil;
}

+ (CGFloat)initalHeight {
    return kViewHeight;
}

/*
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if (self.faceButton.selected) {
        self.faceButton.selected = !self.faceButton.selected;
        if ([self.delegate respondsToSelector:@selector(inputView:didSendEmotionStateChanged:)]) {
            [self.delegate inputView:self didSendEmotionStateChanged:self.faceButton.selected];
        }
    }
    return true;
}
 */

/*
- (BOOL)textViewShouldEndEditing:(UITextView *)textView;

- (void)textViewDidBeginEditing:(UITextView *)textView;
- (void)textViewDidEndEditing:(UITextView *)textView;

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
- (void)textViewDidChange:(UITextView *)textView;

- (void)textViewDidChangeSelection:(UITextView *)textView;

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange NS_AVAILABLE_IOS(7_0);
- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange NS_AVAILABLE_IOS(7_0);
*/

#pragma mark - HPGrowingTextViewDelegate

- (BOOL)growingTextViewShouldBeginEditing:(HPGrowingTextView *)growingTextView {
    if (self.faceButton.selected) {
        self.faceButton.selected = !self.faceButton.selected;
        if ([self.delegate respondsToSelector:@selector(inputView:didSendEmotionStateChanged:)]) {
            [self.delegate inputView:self didSendEmotionStateChanged:self.faceButton.selected];
        }
    }
    return true;
}

- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height {
    float diff = (growingTextView.frame.size.height - height);
    
    CGRect r = self.frame;
    r.size.height -= diff;
    r.origin.y += diff;
    self.frame = r;
}

- (BOOL)growingTextViewShouldReturn:(HPGrowingTextView *)growingTextView {
    if ([self.delegate respondsToSelector:@selector(inputViewShouldReturn:)]) {
        return [self.delegate inputViewShouldReturn:self];
    }
    return YES;
}

@end
