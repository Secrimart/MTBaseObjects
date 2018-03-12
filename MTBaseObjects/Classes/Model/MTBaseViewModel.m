//
//  MTBaseViewModel.m
//  MTBaseObjects
//
//  Created by Jason Li on 2018/3/12.
//

#import "MTBaseViewModel.h"

@implementation MTBaseViewModel
- (instancetype)init {
    if (self = [super init]) {
        self.page = 0;
        self.size = 20;
    }
    return self;
    
}

- (NSMutableArray *)dataSource {
    if (_dataSource) return _dataSource;
    _dataSource = [NSMutableArray arrayWithCapacity:0];
    
    return _dataSource;
}

- (void)toReloadDataSourceBeforeRequest:(VoidBlock)before
                             onFinished:(DataSourceStatusBlock)finished
                               onFailed:(VoidBlock)failed {
    
}

@end
