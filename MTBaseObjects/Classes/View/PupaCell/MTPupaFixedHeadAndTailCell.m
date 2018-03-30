//
//  MTPupaFixedHeadAndTailCell.m
//  MTBaseObjects
//
//  Created by Jason Li on 2018/3/29.
//

#import "MTPupaFixedHeadAndTailCell.h"

@implementation MTPupaFixedHeadAndTailCell

- (void)initCell {
    [super initCell];
    
    self.labelHead.lineBreakMode = NSLineBreakByWordWrapping;
    self.labelBody.lineBreakMode = NSLineBreakByTruncatingTail;
    self.labelTail.lineBreakMode = NSLineBreakByWordWrapping;
}

- (void)setupLayoutConstraint {
    __weak typeof(self) weakSelf = self;
    
    CGSize headSize = [self.labelHead simpleSize];
    
    [self.labelHead mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.contentInsets.top);
        make.left.mas_equalTo(weakSelf.contentInsets.left);
        make.size.mas_equalTo(headSize);
    }];
    
    CGSize tailSize = [self.labelTail simpleSize];
    [self.labelTail mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.contentInsets.top);
        make.right.mas_equalTo(-weakSelf.contentInsets.right);
        make.size.mas_equalTo(tailSize);
    }];
    
    /**
     * 为了让三段文字顶端对齐，labelBody不能与Bottom进行约束，所以需要调整lineBreakMode，根据实际字符计算高度
     * 当文本高度小于Cell的内容高度时，使用文本高度进行约束
     * 如果文本高度大于Cell的内容高度时，将文本高度设置为Cell内容高度能够显示下的最大行数的高度
     **/
    NSLineBreakMode tempMode = self.labelBody.lineBreakMode;
    self.labelBody.lineBreakMode = NSLineBreakByWordWrapping;
    // 计算文本实际高度
    CGFloat bodyHeight = [self.labelBody realHeightInView:self.contentView atInsets:UIEdgeInsetsMake(self.contentInsets.top, (self.contentInsets.left + headSize.width + self.controlHalfInterval), self.contentInsets.bottom, (self.contentInsets.right + tailSize.width + self.controlHalfInterval))];
    self.labelBody.lineBreakMode = tempMode;
    // 计算Cell的内容高度
    CGFloat contentHeight = self.contentView.view_height - self.contentInsets.top - self.contentInsets.bottom;
    if (bodyHeight > contentHeight) {
        // 将文本高度设置为Cell内容高度能够显示下的最大行数的高度
        bodyHeight -= ceilf((bodyHeight - contentHeight)/self.labelBody.font.lineHeight) * self.labelBody.font.lineHeight;
    }
    
    [self.labelBody mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.contentInsets.top);
        make.height.mas_equalTo(bodyHeight);
        make.left.mas_equalTo(weakSelf.labelHead.mas_right).mas_offset(weakSelf.controlHalfInterval);
        make.right.mas_equalTo(weakSelf.labelTail.mas_left).mas_offset(-weakSelf.controlHalfInterval);
        
    }];
}

@end
