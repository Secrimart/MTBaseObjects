//
//  MTButtonsView.m
//  MTBaseObjects
//
//  Created by Jason Li on 2018/3/12.
//

#import "MTButtonsView.h"

@implementation MTButtonsView

- (void)toAddButtonWithTitle:(NSString *)title withTag:(NSInteger)tag withStyle:(ButtonStyle)style target:(id)target action:(SEL)action {
    UIButton *btn = [self instanceButton:style];
    btn.tag = tag;
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    [self toSetupButtonStyle:style button:btn];
    
    [self.buttons addObject:btn];
    [self addSubview:btn];
}

- (void)toAddButtonWithTitle:(NSString *)title withTag:(NSInteger)tag target:(id)target action:(SEL)action {
    [self toAddButtonWithTitle:title withTag:tag withStyle:ButtonStyleFill target:target action:action];
}

- (void)toAddButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    [self toAddButtonWithTitle:title withTag:0 target:target action:action];
}

- (void)toClearButtons {
    for (UIButton *btn in self.buttons) {
        [btn removeFromSuperview];
    }
    [self.buttons removeAllObjects];
    self.buttons = nil;
}

- (void)toResetButtonTitle:(NSString *)title withTag:(NSInteger)tag {
    UIButton *button = [self buttonWithTag:tag];
    if (button) {
        [button setTitle:title forState:UIControlStateNormal];
    }
}

- (void)toEnableButton:(BOOL)enable withTag:(NSInteger)tag {
    UIButton *button = [self buttonWithTag:tag];
    if (button) {
        [button setEnabled:enable];
        if (enable) {
            button.alpha = 1.f;
        } else {
            button.alpha = .6f;
        }
    }
}

- (UIButton *)buttonWithTag:(NSInteger)tag {
    for (UIButton *btn in self.buttons) {
        if (btn.tag == tag) {
            return btn;
        }
    }
    return nil;
}

//MARK: - Layout
- (void)setupLayoutConstraint {
    if (self.buttons.count > 0) {
        CGFloat widthBtn = ceilf((CGRectGetWidth(self.bounds) - self.contentInsets.left - self.contentInsets.right - (self.buttons.count - 1)*self.controlInterval)/self.buttons.count);
        
        if (self.styleLayout == ButtonsLayoutStyleLine) {
            
            __weak typeof(self) weakSelf = self;
            [self.buttons enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                UIButton *button = obj;
                [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(weakSelf.contentInsets.top);
                    make.bottom.mas_equalTo(-weakSelf.contentInsets.bottom);
                    if (idx == 0) {
                        make.left.mas_equalTo(weakSelf.contentInsets.left);
                    } else {
                        UIButton *leftButton = [weakSelf.buttons objectAtIndex:idx - 1];
                        make.left.mas_equalTo(leftButton.mas_right).mas_offset(self.controlInterval);
                    }
                    make.width.mas_equalTo(widthBtn);
                }];
            }];
        } else if (self.styleLayout == ButtonsLayoutStyleLineRight) {
            
            __weak typeof(self) weakSelf = self;
            [self.buttons enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                UIButton *button = obj;
                [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(weakSelf.contentInsets.top);
                    make.bottom.mas_equalTo(-weakSelf.contentInsets.bottom);
                    if (idx == (weakSelf.buttons.count - 1)) {
                        make.right.mas_equalTo(-weakSelf.contentInsets.right);
                    } else {
                        UIButton *rightButton = [weakSelf.buttons objectAtIndex:idx + 1];
                        make.right.mas_equalTo(rightButton.mas_left).mas_offset(-self.controlInterval);
                    }
                    make.width.mas_equalTo(widthBtn);
                }];
            }];
            
        } else if (self.styleLayout == ButtonsLayoutStyleLineSeparate) {
            __weak typeof(self) weakSelf = self;
            [self.buttons enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                UIButton *button = obj;
                [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(weakSelf.contentInsets.top);
                    make.bottom.mas_equalTo(-weakSelf.contentInsets.bottom);
                    if (idx == 0) {
                        make.left.mas_equalTo(weakSelf.contentInsets.left);
                    } else {
                        UIButton *leftButton = [weakSelf.buttons objectAtIndex:idx - 1];
                        make.left.mas_equalTo(leftButton.mas_right).mas_offset(self.controlInterval);
                    }
                    make.width.mas_equalTo(widthBtn);
                }];
                if (idx >= weakSelf.buttons.count/2.f) {
                    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
                } else {
                    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
                }
            }];
        }
    }
}

//MARK: - Getter And Setter
- (UIButton *)instanceButton:(ButtonStyle)style {
    UIButton *button = nil;
    if (style == ButtonStyleLight) {
        button = [UIButton buttonWithType:UIButtonTypeCustom];
    } else {
        button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    }
    
    return button;
}

- (NSMutableArray *)buttons {
    if (_buttons) return _buttons;
    _buttons = [NSMutableArray arrayWithCapacity:0];
    
    return _buttons;
}

- (void)setStyleButton:(ButtonStyle)styleButton {
    _styleButton = styleButton;
    for (UIButton *btn in self.buttons) {
        [self toSetupButtonStyle:styleButton button:btn];
    }
}

//MARK: - Action
- (void)toSetupButtonStyle:(ButtonStyle)style button:(UIButton *)button {
    button.titleLabel.font = [UIFont titleFont];
    if (style == ButtonStyleFill) {
        button.backgroundColor = [UIColor spotColor];
        [button setTintColor:[UIColor whiteColor]];
        button.layer.cornerRadius = self.cornerRadius;
        
        NSString *title = button.titleLabel.text;
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:title];
        NSRange range = NSMakeRange(0, title.length);
        [attStr addAttribute:NSFontAttributeName value:[UIFont titleFont] range:range];
        [button setAttributedTitle:attStr forState:UIControlStateNormal];
    } else if (style == ButtonStyleBorder) {
        button.backgroundColor = [UIColor whiteColor];
        [button setTintColor:[UIColor spotColor]];
        button.layer.cornerRadius = self.cornerRadius;
        button.layer.borderWidth = 1.f;
        button.layer.borderColor = [UIColor spotColor].CGColor;
        
        NSString *title = button.titleLabel.text;
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:title];
        NSRange range = NSMakeRange(0, title.length);
        [attStr addAttribute:NSFontAttributeName value:[UIFont titleFont] range:range];
        [button setAttributedTitle:attStr forState:UIControlStateNormal];
    } else if (style == ButtonStyleLight) {
        NSString *title = [NSString stringWithFormat:@" %@ ",button.titleLabel.text];
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:title];
        NSRange range = NSMakeRange(0, title.length);
        [attStr addAttribute:NSUnderlineColorAttributeName value:[UIColor grayDataColor] range:range];
        [attStr addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:range];
        [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayDataColor] range:range];
        [attStr addAttribute:NSFontAttributeName value:[UIFont descFont] range:range];
        
        [button setAttributedTitle:attStr forState:UIControlStateNormal];
    } else if (style == ButtonStyleSpotLight) {
        NSString *title = [NSString stringWithFormat:@" %@ ",button.titleLabel.text];
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:title];
        NSRange range = NSMakeRange(0, title.length);
        [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor spotColor] range:range];
        [attStr addAttribute:NSFontAttributeName value:[UIFont contentFont] range:range];
        
        [button setAttributedTitle:attStr forState:UIControlStateNormal];
    } else if (style == ButtonStyleDefault) {
        button.backgroundColor = [UIColor whiteColor];
        NSString *title = [NSString stringWithFormat:@" %@ ",button.titleLabel.text];
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:title];
        NSRange range = NSMakeRange(0, title.length);
        [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayDataColor] range:range];
        [attStr addAttribute:NSFontAttributeName value:[UIFont contentFont] range:range];
        
        [button setAttributedTitle:attStr forState:UIControlStateNormal];
    }
    
    [self setNeedsLayout];
}

@end
