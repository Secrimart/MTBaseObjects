//
//  MTBlankView.m
//  AFNetworking
//
//  Created by Jason Li on 2018/4/13.
//

#import "MTBlankView.h"

@interface MTBlankView ()
@property (nonatomic) CGFloat yOffset; // y轴偏移量

@end

@implementation MTBlankView

+ (instancetype)sharedManager {
    static dispatch_once_t onceInstance;
    static MTBlankView *instance;
    dispatch_once(&onceInstance, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

+ (void)blankViewAddTo:(UIView *)view message:(NSString *)message {
    return [[MTBlankView sharedManager] blankViewAddTo:view message:message yOffset:0];
}

+ (void)blankViewAddTo:(UIView *)view message:(NSString *)message yOffset:(CGFloat)offset; {
    return [[MTBlankView sharedManager] blankViewAddTo:view message:message yOffset:offset];
}

+ (void)blankViewHidden:(UIView *)view {
    return [[MTBlankView sharedManager] blankViewHidden:view];
}


- (void)blankViewAddTo:(UIView *)view message:(NSString *)message yOffset:(CGFloat)offset; {
    [self setFrame:view.bounds];
    self.message = message;
    self.yOffset = offset;
    
    if (self.isShowed) [self removeFromSuperview];
    [view addSubview:self];
}

- (void)blankViewHidden:(UIView *)view {
    if (self.isShowed) [self removeFromSuperview];
}

- (void)showGoOnButton:(NSString *)title target:(id)target action:(SEL)action {
    [self.buttonGoOn setHidden:NO];
    [self.buttonGoOn setTitle:title forState:UIControlStateNormal];
    [self.buttonGoOn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
}

- (BOOL)isShowed {
    return self.superview?YES:NO;
}

//MARK: - Life Cycle
- (void)initView {
    [super initView];
    
    [self addSubview:self.imageView];
    [self addSubview:self.labelMessage];
    [self addSubview:self.buttonGoOn];
    
}

- (void)setupLayoutConstraint {
    __weak typeof(self) weakSelf = self;
    
    CGSize size = self.imageBlank.size;
    [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf);
        make.centerY.mas_equalTo(weakSelf.mas_centerY).mas_offset(weakSelf.yOffset);
        make.size.mas_equalTo(size);
    }];
    
    CGSize sizeLabel = [self.labelMessage.text sizeByFont:self.labelMessage.font boundSize:self.contentSize lineBreakMode:NSLineBreakByWordWrapping];
    
    [self.labelMessage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.contentInsets.left);
        make.right.mas_equalTo(-weakSelf.contentInsets.right);
        make.top.mas_equalTo(weakSelf.imageView.mas_bottom).mas_offset(weakSelf.controlInterval);
        make.height.mas_equalTo(sizeLabel.height);
        
    }];
    
    CGFloat realWidthBtnTitle = [self.buttonGoOn.titleLabel simpleSize].width;
    CGFloat widthBtn = self.imageBlank.size.width;
    if (widthBtn < realWidthBtnTitle) {
        widthBtn = realWidthBtnTitle * 1.2f;
    }
    [self.buttonGoOn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.labelMessage.mas_bottom).mas_offset(weakSelf.controlInterval);
        make.height.mas_equalTo(weakSelf.rowHeight);
        make.width.mas_equalTo(widthBtn);
    }];
    
}

//MARK: - Getter And Setter
- (UIImageView *)imageView {
    if (_imageView) return _imageView;
    _imageView = [[UIImageView alloc] init];
    [_imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    _imageView.backgroundColor = [UIColor clearColor];
    
    return _imageView;
}

- (UILabel *)labelMessage {
    if (_labelMessage) return _labelMessage;
    _labelMessage = [[UILabel alloc] initDesc];
    _labelMessage.textAlignment = NSTextAlignmentCenter;
    _labelMessage.text = @"暂无数据";
    
    _labelMessage.numberOfLines = 0;
    _labelMessage.lineBreakMode = NSLineBreakByWordWrapping;
    
    return _labelMessage;
}

- (UIButton *)buttonGoOn {
    if (_buttonGoOn) return _buttonGoOn;
    _buttonGoOn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_buttonGoOn setTranslatesAutoresizingMaskIntoConstraints:NO];
    _buttonGoOn.backgroundColor = [UIColor spotColor];
    _buttonGoOn.layer.cornerRadius = self.cornerRadius;
    [_buttonGoOn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_buttonGoOn setHidden:YES];
    
    return _buttonGoOn;
}

- (void)setImageBlank:(UIImage *)imageBlank {
    _imageBlank = imageBlank;
    [self.imageView setImage:imageBlank];
}

- (void)setMessage:(NSString *)message {
    _message = message;
    self.labelMessage.text = message;
}

@end
