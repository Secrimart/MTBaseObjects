//
//  MTPupaVerticalFixedHeadAndTailCell.h
//  MTBaseObjects
//
//  Created by Jason Li on 2018/3/29.
//

#import "MTPupaCell.h"

/**
 * 三段文本Cell, 三段文本纵向布局
 * 头尾按照文字内容折行定高
 * Body可变高并文本截断
 *  ________________
 * |Head Content    |
 * |Body Content... |
 * |Tail Tail Tail  |
 * |Tail            |
 *  ----------------
 **/
@interface MTPupaVerticalFixedHeadAndTailCell : MTPupaCell

@end
