//
//  MTBaseCollectionViewCell.h
//  MTBaseObjects
//
//  Created by Jason Li on 2018/3/21.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MTBaseCollCellTitleLayout) {
    MTTitleLayoutTop = 0,
    MTTitleLayoutBottom,
    MTTitleLayoutCenter,
    MTTitleLayoutCenterBottom
};

@interface MTBaseCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView; // 图片视图

@property (nonatomic, strong) UILabel *labelTitle; // 标题文本对象

@property (nonatomic, strong) NSString *title; // 标题

@property (nonatomic) MTBaseCollCellTitleLayout layoutType; // 标题布局类型，Default 0

@property (nonatomic, strong) NSString *imageName; // 本地图片名称

@property (nonatomic, strong) NSString *imageURL; // 网络图片地址

/**
 为标题文本框设置显示时的高度，子类可重写

 @return 标题行高
 */
- (CGFloat)heightOfTitle;

@end
