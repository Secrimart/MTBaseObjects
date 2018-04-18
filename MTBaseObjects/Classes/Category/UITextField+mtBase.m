//
//  UITextField+mtBase.m
//  AFNetworking
//
//  Created by Jason Li on 2018/3/12.
//

#import "UITextField+mtBase.h"
#import <objc/runtime.h>

#import "UIColor+mtBase.h"
#import "UIFont+mtBase.h"

@import MTFramework;
@import Masonry;

static inline
float shake(float b,int i,float f)
{
    return b - i*f;
}

@implementation UITextField (mtBase)
- (void)usingDefaultStyle {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = .5f;
    self.layer.cornerRadius = self.cornerRadius;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    self.textColor = [UIColor dataColor];
}

#pragma mark - Left And Right Image
- (void)setLeftImage:(UIImage *)image {
    [self setLeftImage:image AddGestureRecognizer:nil];
}

- (void)setLeftImage:(UIImage *)image AddGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer {
    if (!image) return;
    if (self.leftView && image) {
        for (UIView *subView in self.leftView.subviews) {
            if ([subView isKindOfClass:[UIImageView class]]) {
                [((UIImageView *)subView) setImage:image];
            }
        }
        return;
    }
    self.leftView = [self imageViewWithImage:image];
    if (gestureRecognizer) {
        for (UIGestureRecognizer *recognizer in self.leftView.gestureRecognizers) {
            [self.leftView removeGestureRecognizer:recognizer];
        }
        [self.leftView addGestureRecognizer:gestureRecognizer];
    }
    self.leftViewMode = UITextFieldViewModeAlways;
}

- (void)setRightImage:(UIImage *)image {
    [self setRightImage:image AddGestureRecognizer:nil];
}

- (void)setRightImage:(UIImage *)image AddGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer {
    if (!image) return;
    if (self.rightView && image) {
        for (UIView *subView in self.rightView.subviews) {
            if ([subView isKindOfClass:[UIImageView class]]) {
                [((UIImageView *)subView) setImage:image];
            }
        }
        return;
    }
    self.rightView = [self imageViewWithImage:image];
    if (gestureRecognizer) {
        for (UIGestureRecognizer *recognizer in self.rightView.gestureRecognizers) {
            [self.rightView removeGestureRecognizer:recognizer];
        }
        [self.rightView addGestureRecognizer:gestureRecognizer];
    }
    self.rightViewMode = UITextFieldViewModeAlways;
}

- (UIView *)imageViewWithImage:(UIImage *)image {
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetHeight(self.bounds), CGRectGetHeight(self.bounds))];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [containerView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(containerView);
    }];
    
    return containerView;
}

#pragma mark - Input Accessory View
- (UIBarButtonItem *)hideBarButtonItem {
    return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(resignFirstResponder)];
}

- (UIBarButtonItem *)hideBarButtonItemCancel {
    return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(resignFirstResponder)];
}

- (UIBarButtonItem *)flexableBarButtonItem {
    return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
}

- (UIBarButtonItem *)noteBarButtonItem:(NSString *)note {
    CGRect frame = CGRectZero;
    frame.size.height = self.rowHeight;
    frame.size.width = ceilf([note sizeByFont:[UIFont titleFont]].width);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = note;
    [label setFont:[UIFont titleFont]];
    return [[UIBarButtonItem alloc] initWithCustomView:label];
}

- (void)addAccessoryViewCompletedButton {
    CGRect rect = [UIScreen mainScreen].bounds;
    rect.size.height = self.rowHeight;
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:rect];
    [toolbar setBarStyle:UIBarStyleDefault];
    
    UIBarButtonItem *done = [self hideBarButtonItem];
    [done setTintColor:[UIColor spotColor]];
    
    UIBarButtonItem *cancel = [self hideBarButtonItemCancel];
    [cancel setTintColor:[UIColor grayDataColor]];
    
    [toolbar setItems:@[cancel,[self flexableBarButtonItem],done]];
    [self setInputAccessoryView:toolbar];
}

- (void)addAccessoryViewMessage:(NSString *)msg {
    CGRect rect = [UIScreen mainScreen].bounds;
    rect.size.height = self.rowHeight;
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:rect];
    [toolbar setBarStyle:UIBarStyleDefault];
    
    [toolbar setItems:@[[self noteBarButtonItem:msg],[self flexableBarButtonItem],[self hideBarButtonItem]]];
    [self setInputAccessoryView:toolbar];
}

- (void)viewShake {
    [self viewShake:nil];
}

- (void)viewShake:(void (^)(void))completion {
    __block NSString *weakText = self.text;
    __weak typeof(self) weakSelf = self;
    [self viewShakeAnimation:20.f
              decayAmplitude:4.f
                  decayCount:5
                  completion:^{
                      [weakSelf becomeFirstResponder];
                      weakSelf.text = weakText;
                      if (completion) completion();
                  }];
}

- (void)viewShakeAnimation:(CGFloat)shakeDistance
            decayAmplitude:(CGFloat)amplitude
                decayCount:(NSInteger)count
                completion:(void (^)(void))completion {
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, self.center.x, self.center.y);
    for (int i=0; i<count-1; i++) {
        shakeDistance = shake(shakeDistance,i,amplitude);
        CGPathAddLineToPoint(path, NULL, self.center.x-shakeDistance, self.center.y);
        CGPathAddLineToPoint(path, NULL, self.center.x+shakeDistance, self.center.y);
    }
    CGPathAddLineToPoint(path, NULL, self.center.x, self.center.y);
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        if (completion) {
            completion();
        }
    }];
    
    CAKeyframeAnimation *keyAni = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [keyAni setDuration:.5];
    [keyAni setPath:path];
    [keyAni setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [keyAni setRemovedOnCompletion:NO];
    [self.layer addAnimation:keyAni forKey:@"shake"];
    CGPathRelease(path);
    [CATransaction commit];
}

@end
