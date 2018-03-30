//
//  MTPupaVerticalCell.m
//  MTBaseObjects
//
//  Created by Jason Li on 2018/3/29.
//

#import "MTPupaVerticalCell.h"

@implementation MTPupaVerticalCell

//MARK: - Layout
- (void)setupLayoutConstraint {
    __weak typeof(self) weakSelf = self;
    
    CGFloat height = ceilf((self.contentView.view_height - self.contentInsets.top - self.contentInsets.bottom - (2*weakSelf.controlHalfInterval))/3);
    
    [self.labelHead mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.contentInsets.top);
        make.left.mas_equalTo(weakSelf.contentInsets.left);
        make.right.mas_equalTo(-weakSelf.contentInsets.right);
        make.height.mas_equalTo(height);
    }];
    
    [self.labelTail mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weakSelf.labelHead);
        make.bottom.mas_equalTo(-weakSelf.contentInsets.bottom);
        make.height.mas_equalTo(height);
    }];
    
    [self.labelBody mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weakSelf.labelHead);
        make.top.mas_equalTo(weakSelf.labelHead.mas_bottom).mas_offset(weakSelf.controlHalfInterval);
        make.bottom.mas_equalTo(weakSelf.labelTail.mas_top).mas_offset(-weakSelf.controlHalfInterval);
    }];
}

@end
