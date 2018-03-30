//
//  MTPupaVerticalFixedTailHeadAndBodyHalfOfRemainCell.m
//  MTBaseObjects
//
//  Created by Jason Li on 2018/3/29.
//

#import "MTPupaVerticalFixedTailHeadAndBodyHalfOfRemainCell.h"

@implementation MTPupaVerticalFixedTailHeadAndBodyHalfOfRemainCell

- (void)setupLayoutConstraint {
    __weak typeof(self) weakSelf = self;
    
    CGFloat headTail = [self.labelTail realHeightInView:self.contentView];
    [self.labelTail mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-weakSelf.contentInsets.bottom);
        make.left.mas_equalTo(weakSelf.contentInsets.left);
        make.right.mas_equalTo(-weakSelf.contentInsets.right);
        make.height.mas_equalTo(headTail);
    }];
    
    CGFloat height = ceilf((self.contentView.view_height - self.contentInsets.top - self.contentInsets.bottom - headTail - (2*self.controlHalfInterval))/2);
    [self.labelHead mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weakSelf.labelTail);
        make.top.mas_equalTo(weakSelf.contentInsets.top);
        make.height.mas_equalTo(height);
    }];
    
    [self.labelBody mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weakSelf.labelHead);
        make.top.mas_equalTo(weakSelf.labelHead.mas_bottom).mas_offset(weakSelf.controlHalfInterval);
        make.bottom.mas_equalTo(weakSelf.labelTail.mas_top).mas_offset(-weakSelf.controlHalfInterval);
    }];
}

@end
