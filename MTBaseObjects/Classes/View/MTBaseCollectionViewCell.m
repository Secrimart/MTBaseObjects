//
//  MTBaseCollectionViewCell.m
//  MTBaseObjects
//
//  Created by Jason Li on 2018/3/21.
//

#import "MTBaseCollectionViewCell.h"

@import MTFramework;
@import SDWebImage;
@import Masonry;

#import "UIColor+mtBase.h"
#import "UIFont+mtBase.h"
#import "UILabel+mtBase.h"

@implementation MTBaseCollectionViewCell

- (void)initView {
    [self addSubview:self.imageView];
    [self addSubview:self.labelTitle];
    
    self.contentInsets = UIEdgeInsetsZero;
}

- (CGFloat)heightOfTitle {
    CGFloat height = self.labelTitle.font.lineHeight;
    height += self.contentInsets.top;
    height += self.contentInsets.bottom;
    
    return ceilf(height);
}

//MARK: - Layout
- (void)setupLayoutConstraint {
    if (self.layoutType == MTTitleLayoutCenter) {
        [self setupCenterLayout];
    } else if (self.layoutType == MTTitleLayoutCenterBottom) {
        [self setupCenterBottomLayout];
    } else if (self.layoutType == MTTitleLayoutTop) {
        [self setupTopLayout];
    } else if (self.layoutType == MTTitleLayoutBottom) {
        [self setupBottomLayout];
    }
    
}

/**
 Label和Image的大小相同，且背景透明覆盖在ImageView之上
 */
- (void)setupCenterLayout {
    __weak typeof(self) weakSelf = self;
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.contentInsets.top);
        make.bottom.mas_equalTo(weakSelf.contentInsets.bottom);
        make.left.mas_equalTo(weakSelf.contentInsets.left);
        make.right.mas_equalTo(weakSelf.contentInsets.right);
    }];
    
    [self.labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.contentInsets.top);
        make.bottom.mas_equalTo(weakSelf.contentInsets.bottom);
        make.left.mas_equalTo(weakSelf.contentInsets.left);
        make.right.mas_equalTo(weakSelf.contentInsets.right);
    }];
    
}

/**
 Label和ImageView同宽，Bottom对齐，Label高度为 -heightOfTitle
 */
- (void)setupCenterBottomLayout {
    __weak typeof(self) weakSelf = self;
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.contentInsets.top);
        make.bottom.mas_equalTo(weakSelf.contentInsets.bottom);
        make.left.mas_equalTo(weakSelf.contentInsets.left);
        make.right.mas_equalTo(weakSelf.contentInsets.right);
    }];
    
    [self.labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(weakSelf.imageView);
        make.height.mas_equalTo([weakSelf heightOfTitle]);
    }];
}

/**
 Label和ImageView同宽，Label在ImageView上方，Label.bottom与ImageView.top对齐，
 间隔self.controlInterval，Label高度为 -heightOfTitle
 */
- (void)setupTopLayout {
    __weak typeof(self) weakSelf = self;
    [self.labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.contentInsets.top);
        make.left.mas_equalTo(weakSelf.contentInsets.left);
        make.right.mas_equalTo(weakSelf.contentInsets.right);
        make.height.mas_equalTo([weakSelf heightOfTitle]);
    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.labelTitle.mas_bottom);
        make.bottom.mas_equalTo(weakSelf.contentInsets.bottom);
        make.left.mas_equalTo(weakSelf.contentInsets.left);
        make.right.mas_equalTo(weakSelf.contentInsets.right);
    }];
}

/**
 Label和ImageView同宽，Label在ImageView下方，Label.top与ImageView.Bottom对齐，
 间隔self.controlInterval，Label高度为 -heightOfTitle
 */
- (void)setupBottomLayout {
    __weak typeof(self) weakSelf = self;
    [self.labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.contentInsets.bottom);
        make.left.mas_equalTo(weakSelf.contentInsets.left);
        make.right.mas_equalTo(weakSelf.contentInsets.right);
        make.height.mas_equalTo([weakSelf heightOfTitle]);
    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.labelTitle.mas_top);
        make.top.mas_equalTo(weakSelf.contentInsets.top);
        make.left.mas_equalTo(weakSelf.contentInsets.left);
        make.right.mas_equalTo(weakSelf.contentInsets.right);
    }];
}

//MARK: - Getter And Setter
- (void)setTitle:(NSString *)title {
    _title = title;
    self.labelTitle.text = title;
    [self.labelTitle setHidden:!(title.length > 0)];
}

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    [self.imageView setImage:[UIImage imageNamed:imageName]];
}

- (void)setImageURL:(NSString *)imageURL {
    _imageURL = imageURL;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageURL]];
}

- (UIImageView *)imageView {
    if (_imageView) return _imageView;
    _imageView = [[UIImageView alloc] init];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    _imageView.layer.cornerRadius = self.cornerRadius;
    
    [_imageView setClipsToBounds:YES];
    
    return _imageView;
}

- (UILabel *)labelTitle {
    if (_labelTitle) return _labelTitle;
    _labelTitle = [[UILabel alloc] initTitle];
    [_labelTitle setHidden:YES];
    _labelTitle.textAlignment = NSTextAlignmentCenter;
    _labelTitle.numberOfLines = 0;
    _labelTitle.lineBreakMode = NSLineBreakByTruncatingTail;
    
    return _labelTitle;
}

@end
