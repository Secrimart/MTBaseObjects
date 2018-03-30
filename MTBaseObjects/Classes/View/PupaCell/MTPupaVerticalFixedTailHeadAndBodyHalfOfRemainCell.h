//
//  MTPupaVerticalFixedTailHeadAndBodyHalfOfRemainCell.h
//  MTBaseObjects
//
//  Created by Jason Li on 2018/3/29.
//

#import "MTPupaCell.h"

/**
 * 三段文本Cell, 三段文本纵向布局
 * 尾按照文字内容折行定高
 * 头身可变宽并文本截断
 *  ________________
 * |Head Content... |
 * |Body Content... |
 * |Tail Tail Tail  |
 * |Tail            |
 *  ----------------
 **/
@interface MTPupaVerticalFixedTailHeadAndBodyHalfOfRemainCell : MTPupaCell

@end
