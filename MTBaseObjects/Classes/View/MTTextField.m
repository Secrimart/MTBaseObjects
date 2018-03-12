//
//  MTTextField.m
//  MTBaseObjects
//
//  Created by Jason Li on 2018/3/12.
//

#import "MTTextField.h"

@implementation MTTextField
- (void)initView {
    self.contentInsets = self.edgeInsets;
}

- (void)setPlaceholderColor:(UIColor *)color {
    if (self.placeholder.length > 0) {
        NSMutableAttributedString *attr = [self attributedStringPlaceholder];
        [attr addAttribute:NSForegroundColorAttributeName value:color range:[self.placeholder range]];
        
        self.attributedPlaceholder = attr;
    }
    
}

- (void)setPlaceholderFont:(UIFont *)font {
    if (self.placeholder.length > 0) {
        NSMutableAttributedString *attr = [self attributedStringPlaceholder];
        [attr addAttribute:NSFontAttributeName value:font range:[self.placeholder range]];
        
        self.attributedPlaceholder = attr;
    }
}

- (NSMutableAttributedString *)attributedStringPlaceholder {
    NSMutableAttributedString *string = nil;
    if (self.attributedPlaceholder) {
        string = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedPlaceholder];
    } else {
        string = [[NSMutableAttributedString alloc] initWithString:self.placeholder];
    }
    
    return string;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (self.menuUnvisible) {
        UIMenuController *menuController = [UIMenuController sharedMenuController];
        if (menuController) {
            [UIMenuController sharedMenuController].menuVisible = NO;
        }
        
        return NO;
    }
    
    return [super canPerformAction:action withSender:sender];
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds {
    bounds.size.height = CGRectGetHeight(self.bounds);
    bounds.size.width = CGRectGetHeight(self.bounds);
    return bounds;
}

- (CGRect)rightViewRectForBounds:(CGRect)bounds {
    bounds.size.height = CGRectGetHeight(self.bounds);
    bounds.size.width = CGRectGetHeight(self.bounds);
    bounds.origin.x = CGRectGetWidth(self.bounds) - CGRectGetWidth(bounds);
    
    return bounds;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    if (self.layer.borderWidth > 0.0f && !self.leftView) {
        bounds.origin.x += self.contentInsets.left;
    } else if (self.leftView && self.textAlignment != NSTextAlignmentRight) {
        bounds.origin.x += CGRectGetMaxX(self.leftView.frame);
    } else if (self.rightView && self.textAlignment != NSTextAlignmentLeft) {
        bounds.size.width -= CGRectGetWidth(self.rightView.frame);
    }
    
    return CGRectInset(bounds, 5, 0);
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    if (self.layer.borderWidth > 0.0f && !self.leftView) {
        bounds.origin.x += self.contentInsets.left;
    } else if (self.leftView && self.textAlignment != NSTextAlignmentRight) {
        bounds.origin.x += CGRectGetMaxX(self.leftView.frame);
    } else if (self.rightView && self.textAlignment != NSTextAlignmentLeft) {
        bounds.size.width -= CGRectGetWidth(self.rightView.frame);
    }
    
    return CGRectInset(bounds, 5, 0);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    if (self.layer.borderWidth > 0.0f && !self.leftView) {
        bounds.origin.x += self.contentInsets.left;
    } else if (self.leftView && self.textAlignment != NSTextAlignmentRight) {
        bounds.origin.x += CGRectGetMaxX(self.leftView.frame);
    } else if (self.rightView && self.textAlignment != NSTextAlignmentLeft) {
        bounds.size.width -= CGRectGetWidth(self.rightView.frame);
    }
    
    return CGRectInset(bounds, 5, 0);
}

@end
