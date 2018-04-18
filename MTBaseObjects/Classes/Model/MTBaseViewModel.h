//
//  MTBaseViewModel.h
//  MTBaseObjects
//
//  Created by Jason Li on 2018/3/12.
//

#import <Foundation/Foundation.h>
#import "MTBaseVMProtocol.h"

@import MTFramework;

@interface MTBaseViewModel : NSObject<MTBaseVMProtocol>
@property (nonatomic) NSInteger page; // 分页查询时记录当前页数
@property (nonatomic) NSInteger size; // 分页查询时设置每页记录数

@property (nonatomic, strong) NSMutableArray *dataSource; // 存储显示数据

@end
