//
//  MTPupaFixedTailHeadAndBodyHalfOfRemainCell.m
//  MTBaseObjects
//
//  Created by Jason Li on 2018/3/29.
//

#import "MTPupaFixedTailHeadAndBodyHalfOfRemainCell.h"

@implementation MTPupaFixedTailHeadAndBodyHalfOfRemainCell

- (void)setupLayoutConstraint {
    __weak typeof(self) weakSelf = self;
    
    CGSize tailSize = [self.labelHead simpleSize];
    [self.labelTail mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.contentInsets.top);
        make.right.mas_equalTo(-weakSelf.contentInsets.right);
        make.size.mas_equalTo(tailSize);
    }];
    
    CGFloat width = ceilf((weakSelf.contentView.view_width - weakSelf.contentInsets.left - weakSelf.contentInsets.right - tailSize.width - (2 * weakSelf.controlHalfInterval))/2);
    /**
     * 为了让三段文字顶端对齐，labelHead和labelBody不能与Bottom进行约束，所以需要调整lineBreakMode，根据实际字符计算高度
     * 当文本高度小于Cell的内容高度时，使用文本高度进行约束
     * 如果文本高度大于Cell的内容高度时，将文本高度设置为Cell内容高度能够显示下的最大行数的高度
     **/
    NSLineBreakMode tempMode = self.labelHead.lineBreakMode;
    self.labelHead.lineBreakMode = NSLineBreakByWordWrapping;
    // 计算文本实际高度
    CGFloat headHeight = [self.labelHead realHeightInView:self.contentView atInsets:UIEdgeInsetsMake(self.contentInsets.top, self.contentInsets.left, self.contentInsets.bottom, (self.contentInsets.right + tailSize.width + width + (2*self.controlHalfInterval)))];
    self.labelHead.lineBreakMode = tempMode;
    // 计算Cell的内容高度
    CGFloat contentHeight = self.contentView.view_height - self.contentInsets.top - self.contentInsets.bottom;
    if (headHeight > contentHeight) {
        // 将文本高度设置为Cell内容高度能够显示下的最大行数的高度
        headHeight -= ceilf((headHeight - contentHeight)/self.labelHead.font.lineHeight) * self.labelHead.font.lineHeight;
    }
    
    [self.labelHead mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.contentInsets.top);
        make.height.mas_equalTo(headHeight);
        make.left.mas_equalTo(weakSelf.contentInsets.left);
        make.width.mas_equalTo(width);
    }];
    
    
    tempMode = self.labelBody.lineBreakMode;
    self.labelBody.lineBreakMode = NSLineBreakByWordWrapping;
    // 计算文本实际高度
    CGFloat bodyHeight = [self.labelBody realHeightInView:self.contentView atInsets:UIEdgeInsetsMake(self.contentInsets.top, (self.contentInsets.left + width + self.controlHalfInterval), self.contentInsets.bottom, (self.contentInsets.right + tailSize.width + self.controlHalfInterval))];
    self.labelBody.lineBreakMode = tempMode;
    if (bodyHeight > contentHeight) {
        // 将文本高度设置为Cell内容高度能够显示下的最大行数的高度
        bodyHeight -= ceilf((bodyHeight - contentHeight)/self.labelBody.font.lineHeight) * self.labelBody.font.lineHeight;
    }
    [self.labelBody mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.labelHead);
        make.height.mas_equalTo(bodyHeight);
        make.left.mas_equalTo(weakSelf.labelHead.mas_right).mas_offset(weakSelf.controlHalfInterval);
        make.right.mas_equalTo(weakSelf.labelTail.mas_left).mas_offset(-weakSelf.controlHalfInterval);
    }];
}

@end
