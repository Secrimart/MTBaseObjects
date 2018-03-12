//
//  UILabel+mtBase.m
//  AFNetworking
//
//  Created by Jason Li on 2018/3/12.
//

#import "UILabel+mtBase.h"
#import "UIColor+mtBase.h"
#import "UIFont+mtBase.h"

@implementation UILabel (mtBase)

- (UILabel *)initTitle {
    UILabel *label = [self init];
    label.textColor = [UIColor dataColor];
    label.font = [UIFont titleFont];
    
    return label;
}

- (UILabel *)initDesc {
    UILabel *label = [self init];
    label.textColor = [UIColor grayDataColor];
    label.font = [UIFont descFont];
    
    return label;
}

- (UILabel *)initContent {
    UILabel *label = [self init];
    label.textColor = [UIColor grayDataColor];
    label.font = [UIFont contentFont];
    
    return label;
}

@end
