//
//  MTPupaCell.h
//  MTBaseObjects
//
//  Created by Jason Li on 2018/3/28.
//

#import <UIKit/UIKit.h>

@import JLFramework;
@import Masonry;

/**
 * 三段文本Cell, 三段文本横向布局，三等分，文本截断（初始化时定义，使用时可修改）
 *  __________________________
 * |Head... |Body... |Tail... |
 *  --------------------------
 **/

@interface MTPupaCell : UITableViewCell

@property (nonatomic, strong) UILabel *labelHead; // 虫头

@property (nonatomic, strong) UILabel *labelBody; // 虫身

@property (nonatomic, strong) UILabel *labelTail; // 虫尾

@end
