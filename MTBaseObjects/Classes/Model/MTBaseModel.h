//
//  MTBaseModel.h
//  MTBaseObjects
//
//  Created by Jason Li on 2018/3/12.
//

#import <Foundation/Foundation.h>
#import "MTUploadFile.h"

@import MTFramework;
@import AFNetworking;
@import MBProgressHUD;

NS_ASSUME_NONNULL_BEGIN
extern NSTimeInterval const HUDHideDelayInterval;    // HUD关闭延迟时长

extern NSString *const RequestErrorDescription;     // 请求异常描述

typedef void(^BaseModelResponse)(NSString *code, NSString* msg, NSDictionary *data);

@interface MTBaseModel : NSObject
@property (nonatomic, strong, nullable) UIView *hudOnView; // HUD添加到给视图上

/**
 显示网络请求失败或异常提示信息
 
 @param reason 指定的提示信息
 */
- (void)toShowFailedHUD:(nullable NSString *)reason;

//MARK: - service url
@property (nonatomic, strong) NSString *networkProtocol; // 网络访问协议 HTTP or HTTPS
@property (nonatomic, strong) NSString *baseURL; // 服务域名
@property (nonatomic, strong) NSString *serviceName; // 服务名称

//MARK: - request object
@property (nonatomic, strong, nullable) AFHTTPSessionManager *session; // 请求session
@property (nonatomic, strong, nullable) NSMutableDictionary *params; // 服务请求参数

//MARK: - post
/**
 按照POST方式进行的网络请求，不对失败进行处理，默认使用HUD
 
 @param success 请求成功数据反馈block
 */
- (void)postSuccess:(nullable void (^)(id responseObject))success;

/**
 按照POST方式进行的网络请求，默认使用HUD
 
 @param success 请求成功数据反馈block
 @param failure 请求失败异常反馈block
 */
- (void)postSuccess:(nullable void (^)(id responseObject))success
failure:(nullable void (^)(NSError *error))failure;

/**
 按照POST方式进行的网络请求，不对失败进行处理
 
 @param success 请求成功数据反馈block
 @param show 是否使用HUD进行阻断
 */
- (void)postSuccess:(nullable void (^)(id responseObject))success
showHUD:(BOOL)show;

/**
 按照POST方式进行的网络请求
 
 @param success 请求成功数据反馈block
 @param failure 请求失败异常反馈block
 @param show 是否使用HUD进行阻断
 */
- (void)postSuccess:(nullable void (^)(id responseObject))success
failure:(nullable void (^)(NSError *error))failure
showHUD:(BOOL)show;

//MARK: - get
/**
 按照GET方式进行的网络请求，不对失败进行处理，默认使用HUD
 
 @param success 请求成功数据反馈block
 */
- (void)getSuccess:(nullable void (^)(id responseObject))success;

/**
 按照GET方式进行的网络请求，默认使用HUD
 
 @param success 请求成功数据反馈block
 @param failure 请求失败异常反馈block
 */
- (void)getSuccess:(nullable void (^)(id responseObject))success
failure:(nullable void (^)(NSError *error))failure;

/**
 按照GET方式进行的网络请求，不对失败进行处理
 
 @param success 请求成功数据反馈block
 @param show 是否使用HUD进行阻断
 */
- (void)getSuccess:(nullable void (^)(id responseObject))success
showHUD:(BOOL)show;

/**
 按照GET方式进行的网络请求
 
 @param success 请求成功数据反馈block
 @param failure 请求失败异常反馈block
 @param show 是否使用HUD进行阻断
 */
- (void)getSuccess:(nullable void (^)(id responseObject))success
failure:(nullable void (^)(NSError *error))failure
showHUD:(BOOL)show;

//MARK: - upload

/**
 文件上传，不进行失败反馈，默认启动HUD进行阻断
 
 @param file 文件对象
 @param success 请求成功数据反馈block
 */
- (void)uploadFile:(MTUploadFile *)file
success:(nullable void (^)(id responseObject))success;

/**
 文件上传，不进行失败反馈
 
 @param file 文件对象
 @param success 请求成功数据反馈block
 @param show 是否使用HUD进行阻断
 */
- (void)uploadFile:(MTUploadFile *)file
success:(nullable void (^)(id responseObject))success
showHUD:(BOOL)show;

/**
 文件上传
 
 @param file 文件
 @param success 请求成功数据反馈block
 @param failure 请求失败异常反馈block
 @param show 是否使用HUD进行阻断
 */
- (void)uploadFile:(MTUploadFile *)file
success:(nullable void (^)(id responseObject))success
failure:(nullable void (^)(NSError *error))failure
showHUD:(BOOL)show;


@end
NS_ASSUME_NONNULL_END
