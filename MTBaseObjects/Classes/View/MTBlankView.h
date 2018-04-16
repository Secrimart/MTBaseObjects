//
//  MTBlankView.h
//  AFNetworking
//
//  Created by Jason Li on 2018/4/13.
//

#import "MTBaseView.h"

@interface MTBlankView : MTBaseView

+ (instancetype)sharedManager;

@property (nonatomic, strong) UIImageView *imageView; // 没有数据的图片

@property (nonatomic, strong) UILabel *labelMessage; // 没有数据的描述

@property (nonatomic, strong) UIButton *buttonGoOn; // 继续业务处理的按钮

@property (nonatomic, strong) UIImage *imageBlank; // 空白页图片

@property (nonatomic, strong) NSString *message; // 空白页说明

+ (void)blankViewAddTo:(UIView *)view message:(NSString *)message;
+ (void)blankViewAddTo:(UIView *)view message:(NSString *)message yOffset:(CGFloat)offset;

+ (void)blankViewHidden:(UIView *)view;

- (void)blankViewAddTo:(UIView *)view message:(NSString *)message yOffset:(CGFloat)offset;
- (void)blankViewHidden:(UIView *)view;
- (void)showGoOnButton:(NSString *)title target:(id)target action:(SEL)action;
- (BOOL)isShowed;

@end
