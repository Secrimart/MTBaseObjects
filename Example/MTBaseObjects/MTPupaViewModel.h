//
//  MTPupaViewModel.h
//  MTBaseObjects_Example
//
//  Created by Jason Li on 2018/3/29.
//  Copyright © 2018年 rstx_reg@aliyun.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MTPupaRowType) {
    MTPupaRowTypeNomarl = 0,
    MTPupaRowTypeVertical,
    MTPupaRowTypeFixedHeadAndTail,
    MTPupaRowTypeVerticalFixedHeadAndTail,
    MTPupaRowTypeFixedTailHeadAndBodyHalfOfRemain,
    MTPupaRowTypeVerticalFixedTailHeadAndBodyHalfOfRemain
};

@import MTBaseObjects;

@interface MTPupaViewModel : MTBaseViewModel

@end
