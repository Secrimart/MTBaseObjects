//
//  MTLocalRecordVM.h
//  MTBaseObjects
//
//  Created by Jason Li on 2018/3/12.
//

#import "MTBaseViewModel.h"

@interface MTLocalRecordVM : MTBaseViewModel

@property (nonatomic, strong) NSString *recordKey; // 本地记录存储标识

@property (nonatomic) NSInteger maxRecord; // 本地基类存储栈的深度

/**
 是否存在对应存储标识的本地存储记录
 
 @return YES 存在 NO 不存在
 */
- (BOOL)isExistsRecord;

/**
 通过指定位置，获取对应存储标识的本地存储记录信息
 
 @param indexPath 本地记录存储位置
 @return 本地记录的内容
 */
- (NSString *)recordAtIndexPath:(NSIndexPath *)indexPath;

/**
 向对应存储标识中添加本地存储记录，添加记录存放栈顶，栈中记录信息内容唯一
 
 @param record 需要本地存储的记录内容
 */
- (void)toAddRecord:(NSString *)record;

/**
 清空对应存储标识中的所有本地存储记录
 */
- (void)toClearAllRecord;

@end
