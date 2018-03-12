//
//  MTBaseVMProtocol.h
//  MTBaseObjects
//
//  Created by Jason Li on 2018/3/12.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, DataSourceStatus) {
    DataSourceStatusNone = 0, // 第一页就没有查询到任何数据
    DataSourceStatusFristPage,  // 第一页 查询存在返回数据，且存在 下一页
    DataSourceStatusNormal,   //非 第一页 查询存在数据且存在 下一页
    DataSourceStatusNoMore    //不存在 下一页
};

typedef void(^VoidBlock)(void);
typedef void(^DataSourceStatusBlock)(DataSourceStatus status);

@protocol MTBaseVMProtocol <NSObject>

/**
 实现ViewModel刷新数据
 
 @param before 请求发送之前的block句柄
 @param finished 请求完成后的block句柄，返回数据状态
 @param failed 请求失败时的block句柄
 */
- (void)toReloadDataSourceBeforeRequest:(VoidBlock)before
                             onFinished:(DataSourceStatusBlock)finished
                               onFailed:(VoidBlock)failed;

@end
