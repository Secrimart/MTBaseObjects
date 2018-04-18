//
//  MTLocalRecordVM.m
//  MTBaseObjects
//
//  Created by Jason Li on 2018/3/12.
//

#import "MTLocalRecordVM.h"

@implementation MTLocalRecordVM

- (void)toReloadDataSourceBeforeRequest:(VoidBlock)before onFinished:(DataSourceStatusBlock)finished onFailed:(VoidBlock)failed {
    if (before) before();
    
    // 判定 本地存储标识 是否已经设置，配置 recordKey 之后才能进行数据加载
    if (self.recordKey.length == 0) {
        MDLogFuncStr(@"*** 本地存储标识 recordKey 不能为空");
        if (failed) failed();
        return;
    }
    
    NSString *recordJsonString = [self userDefaultObjectForKey:self.recordKey];
    if (recordJsonString.length > 0) {
        self.dataSource = [NSMutableArray arrayWithArray:[recordJsonString objectFromJSONString]];
    } else {
        self.dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    if (finished) finished(DataSourceStatusNormal);
}

- (BOOL)isExistsRecord {
    NSString *recordJsonString = [self userDefaultObjectForKey:self.recordKey];
    return recordJsonString.length > 0 ? YES : NO;
}

- (NSString *)recordAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataSource.count > 0) {
        if (self.dataSource.count >= indexPath.section) {
            NSArray *array = self.dataSource[indexPath.section];
            if (array.count >= indexPath.row) {
                return array[indexPath.row];
            }
        }
    }
    
    return @"";
}

- (void)toAddRecord:(NSString *)record {
    // 本地存储堆栈深度 maxRecord 不能为 0
    if (self.maxRecord == 0) {
        MDLogFuncStr(@"*** 本地存储堆栈深度 maxRecord 不能为 0");
        return;
    }
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    if (self.dataSource.count > 0) {
        array = [NSMutableArray arrayWithArray:[self.dataSource objectAtIndex:0]];
    }
    // 删除原有相同 本地存储，以保证 记录唯一
    if ([array containsObject:record]) {
        [array removeObject:record];
    }
    
    // 记录压入堆栈
    [array insertObject:record atIndex:0];
    
    // 清除超额数据
    if (array.count > self.maxRecord) {
        [array removeObjectAtIndex:(array.count - 1)];
    }
    
    self.dataSource = [NSMutableArray arrayWithObject:array];
    
    [self setUserDefaultObject:[self.dataSource JSONString] forKey:self.recordKey];
}

- (void)toClearAllRecord {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    self.dataSource = [NSMutableArray arrayWithObject:array];
    [self setUserDefaultObject:[self.dataSource JSONString] forKey:self.recordKey];
}

@end
