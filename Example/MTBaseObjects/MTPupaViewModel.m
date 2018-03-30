//
//  MTPupaViewModel.m
//  MTBaseObjects_Example
//
//  Created by Jason Li on 2018/3/29.
//  Copyright © 2018年 rstx_reg@aliyun.com. All rights reserved.
//

#import "MTPupaViewModel.h"

@implementation MTPupaViewModel

- (void)toReloadDataSourceBeforeRequest:(VoidBlock)before onFinished:(DataSourceStatusBlock)finished onFailed:(VoidBlock)failed {
    self.dataSource = [NSMutableArray arrayWithCapacity:0];
    
    [self.dataSource addObject:@[@{JLRowType:@(MTPupaRowTypeNomarl)}]];
    [self.dataSource addObject:@[@{JLRowType:@(MTPupaRowTypeVertical)}]];
    [self.dataSource addObject:@[@{JLRowType:@(MTPupaRowTypeFixedHeadAndTail)}]];
    [self.dataSource addObject:@[@{JLRowType:@(MTPupaRowTypeVerticalFixedHeadAndTail)}]];
    [self.dataSource addObject:@[@{JLRowType:@(MTPupaRowTypeFixedTailHeadAndBodyHalfOfRemain)}]];
    [self.dataSource addObject:@[@{JLRowType:@(MTPupaRowTypeVerticalFixedTailHeadAndBodyHalfOfRemain)}]];
}

@end
