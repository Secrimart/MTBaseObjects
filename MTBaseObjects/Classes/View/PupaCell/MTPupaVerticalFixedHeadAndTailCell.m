//
//  MTPupaVerticalFixedHeadAndTailCell.m
//  MTBaseObjects
//
//  Created by Jason Li on 2018/3/29.
//

#import "MTPupaVerticalFixedHeadAndTailCell.h"

@implementation MTPupaVerticalFixedHeadAndTailCell

- (void)initCell {
    [super initCell];
    
    self.labelHead.lineBreakMode = NSLineBreakByWordWrapping;
    self.labelHead.numberOfLines = 0;
    
    self.labelBody.lineBreakMode = NSLineBreakByTruncatingTail;
    self.labelBody.numberOfLines = 0;
    
    self.labelTail.lineBreakMode = NSLineBreakByWordWrapping;
    self.labelTail.numberOfLines = 0;
}

- (void)setupLayoutConstraint {
    __weak typeof(self) weakSelf = self;
    
    CGFloat headHeight = [self.labelHead realHeightInView:self.contentView];
    [self.labelHead mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.contentInsets.top);
        make.left.mas_equalTo(weakSelf.contentInsets.left);
        make.right.mas_equalTo(-weakSelf.contentInsets.right);
        make.height.mas_equalTo(headHeight);
    }];
    
    CGFloat tailHeight = [self.labelTail realHeightInView:self.contentView];
    [self.labelTail mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-weakSelf.contentInsets.bottom);
        make.left.right.mas_equalTo(weakSelf.labelHead);
        make.height.mas_equalTo(tailHeight);
    }];
    
    [self.labelBody mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weakSelf.labelHead);
        make.top.mas_equalTo(weakSelf.labelHead.mas_bottom).mas_offset(weakSelf.controlHalfInterval);
        make.bottom.mas_equalTo(weakSelf.labelTail.mas_top).mas_offset(-weakSelf.controlHalfInterval);
    }];
}

@end
