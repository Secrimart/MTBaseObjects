//
//  UITextField+mtBase.h
//  AFNetworking
//
//  Created by Jason Li on 2018/3/12.
//

#import <UIKit/UIKit.h>

@interface UITextField (mtBase)

- (void)usingDefaultStyle;

- (void)setLeftImage:(UIImage *)image;
- (void)setLeftImage:(UIImage *)image AddGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer;
- (void)setRightImage:(UIImage *)image;
- (void)setRightImage:(UIImage *)image AddGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer;

- (void)addAccessoryViewCompletedButton;
- (void)addAccessoryViewMessage:(NSString *)msg;

- (void)viewShake;
- (void)viewShake:(void(^)(void))completion;

@end
