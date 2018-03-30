//
//  MTPupaCell.m
//  MTBaseObjects
//
//  Created by Jason Li on 2018/3/28.
//

#import "MTPupaCell.h"
#import "UILabel+mtBase.h"

@implementation MTPupaCell

//MARK: - Life Cycle
- (void)initCell {
    [self.contentView addSubview:self.labelHead];
    [self.contentView addSubview:self.labelBody];
    [self.contentView addSubview:self.labelTail];
    
    self.contentInsets = UIEdgeInsetsZero;
    
    self.labelHead.lineBreakMode = NSLineBreakByTruncatingTail;
    self.labelBody.lineBreakMode = NSLineBreakByTruncatingTail;
    self.labelTail.lineBreakMode = NSLineBreakByTruncatingTail;
}

//MARK: - Layout
- (void)setupLayoutConstraint {
    __weak typeof(self) weakSelf = self;
    
    CGFloat width = ceilf((self.contentView.view_width - self.contentInsets.left - self.contentInsets.right)/3);
    
    [self.labelHead mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.contentInsets.top);
        make.left.mas_equalTo(weakSelf.contentInsets.left);
        make.bottom.mas_equalTo(-weakSelf.contentInsets.bottom);
        make.width.mas_equalTo(width);
    }];
    
    [self.labelTail mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(weakSelf.labelHead);
        make.right.mas_equalTo(-weakSelf.contentInsets.right);
        make.width.mas_equalTo(width);
    }];
    
    [self.labelBody mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(weakSelf.labelHead);
        make.left.mas_equalTo(weakSelf.labelHead.mas_right).mas_offset(weakSelf.controlHalfInterval);
        make.right.mas_equalTo(weakSelf.labelTail.mas_left).mas_equalTo(-weakSelf.controlHalfInterval);
    }];
    
}

//MARK: - Getter And Setter
- (UILabel *)labelHead {
    if (_labelHead) return _labelHead;
    _labelHead = [[UILabel alloc] initContent];
    
    return _labelHead;
}

- (UILabel *)labelBody {
    if (_labelBody) return _labelBody;
    _labelBody = [[UILabel alloc] initContent];
    
    return _labelBody;
}

- (UILabel *)labelTail {
    if (_labelTail) return _labelTail;
    _labelTail = [[UILabel alloc] initContent];
    
    return _labelTail;
}

@end
