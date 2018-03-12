//
//  MTButtonsView.h
//  MTBaseObjects
//
//  Created by Jason Li on 2018/3/12.
//

#import "MTBaseView.h"

typedef NS_ENUM(NSUInteger, ButtonStyle) {
    ButtonStyleCustom = 0,
    ButtonStyleDefault,
    ButtonStyleFill,
    ButtonStyleBorder,
    ButtonStyleLight,
    ButtonStyleSpotLight
};

typedef NS_ENUM(NSUInteger, ButtonsLayoutStyle) {
    ButtonsLayoutStyleLine = 0,
    ButtonsLayoutStyleLineRight,
    ButtonsLayoutStyleLineSeparate,
    
};

@interface MTButtonsView : MTBaseView

@property (nonatomic, strong) NSMutableArray *buttons; // 存储按钮对象的数组

@property (nonatomic) ButtonStyle styleButton; // 按钮样式

@property (nonatomic) ButtonsLayoutStyle styleLayout; // 按钮布局

/**
 使用指定的Tag获取按钮对象
 
 @param tag 按钮tag标识
 @return 按钮对象
 */
- (UIButton *)buttonWithTag:(NSInteger)tag;

/**
 使用指定的Tag将按钮设置为无效和有效
 
 @param enable 按钮是否有效
 @param tag 按钮tag标识
 */
- (void)toEnableButton:(BOOL)enable withTag:(NSInteger)tag;

/**
 使用指定的Tag标识重新设置按钮的标题
 
 @param title 按钮的标题
 @param tag 按钮tag标识
 */
- (void)toResetButtonTitle:(NSString *)title withTag:(NSInteger)tag;

/**
 清除所有的按钮
 */
- (void)toClearButtons;

/**
 通过该方法向视图中添加按钮
 
 @param title 按钮的标题
 @param tag 按钮tag标识
 @param style 按钮的样式 ButtonStyle
 @param target 按钮的时间处理对象
 @param action 按钮的相应方法
 */
- (void)toAddButtonWithTitle:(NSString *)title
                     withTag:(NSInteger)tag
                   withStyle:(ButtonStyle)style
                      target:(id)target
                      action:(SEL)action;

/**
 通过该方法向视图中添加按钮，ButtonStyle 默认 ButtonStyleFill
 
 @param title 按钮的标题
 @param tag 按钮tag标识
 @param target 按钮的时间处理对象
 @param action 按钮的相应方法
 */
- (void)toAddButtonWithTitle:(NSString *)title
                     withTag:(NSInteger)tag
                      target:(id)target
                      action:(SEL)action;

/**
 通过该方法向视图中添加按钮，ButtonStyle 默认 ButtonStyleFill，tag 默认 0
 
 @param title 按钮的标题
 @param target 按钮的时间处理对象
 @param action 按钮的相应方法
 */
- (void)toAddButtonWithTitle:(NSString *)title
                      target:(id)target
                      action:(SEL)action;


@end
