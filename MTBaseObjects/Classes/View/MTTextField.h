//
//  MTTextField.h
//  MTBaseObjects
//
//  Created by Jason Li on 2018/3/12.
//

#import <UIKit/UIKit.h>

@import MTFramework;

@interface MTTextField : UITextField

@property (nonatomic, assign) BOOL menuUnvisible;   // 长按显示菜单项功能是否启用，默认 不启用

/**
 设置Placeholder的颜色
 
 @param color 颜色对象
 */
- (void)setPlaceholderColor:(UIColor *)color;

/**
 设置Placeholder的字体
 
 @param font 字体对象
 */
- (void)setPlaceholderFont:(UIFont *)font;

@end
