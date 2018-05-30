//
//  MTBaseModel.m
//  MTBaseObjects
//
//  Created by Jason Li on 2018/3/12.
//

#import "MTBaseModel.h"
#import "MTBaseFactory.h"

NSTimeInterval const HUDHideDelayInterval = 2.f;

NSString *const RequestErrorDescription = @"网络异常\n请检查网络或稍后重试";

@implementation MTBaseModel
- (void)toShowFailedHUD:(NSString *)reason {
    if (self.hudOnView) {
        MBProgressHUD *hud = [MBProgressHUD HUDForView:self.hudOnView];
        if (!hud) {
            hud = [MBProgressHUD showHUDAddedTo:self.hudOnView animated:NO];
        } else {
            if (hud.customView) {
                [((UIImageView *)hud.customView) stopAnimating];
            }
            [hud hideAnimated:NO];
            hud = [MBProgressHUD showHUDAddedTo:self.hudOnView animated:NO];
        }
        hud.mode = MBProgressHUDModeText;
        if (reason) hud.detailsLabel.text = reason;
        [hud hideAnimated:NO afterDelay:HUDHideDelayInterval];
    }
}

//MARK: - service url
- (NSString *)networkProtocol {
    if (_networkProtocol) {
        return _networkProtocol;
    }
    return [MTBaseFactory sharedInstance].networkProtocol;
}

- (NSString *)baseURL {
    if (_baseURL) {
        return _baseURL;
    }
    return [MTBaseFactory sharedInstance].baseURL;
}

- (void)setServiceName:(NSString *)serviceName {
    self.params = nil;
    _serviceName = serviceName;
    
}

//MARK: - request object
- (AFHTTPSessionManager *)session {
    if (_session) return _session;
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.networkProtocol,self.baseURL]];
    _session = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    
#ifdef HTTPS
    [_session setSecurityPolicy:[self customSecurityPolicy]];
#endif
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillTerminate)
                                                 name:UIApplicationWillTerminateNotification
                                               object:nil];
    return _session;
}

- (AFSecurityPolicy *)customSecurityPolicy {
    // /先导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"xxsh" ofType:@"cer"];//证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    
    securityPolicy.pinnedCertificates = [NSSet setWithObject:certData];
    
    return securityPolicy;
}

- (void)applicationWillTerminate {
    [self.session invalidateSessionCancelingTasks:YES];
}

- (NSMutableDictionary *)params {
    if (_params) return _params;
    _params = [NSMutableDictionary dictionaryWithCapacity:0];
    
    return _params;
}

//MARK: - post
- (void)postSuccess:(void (^)(id _Nonnull))success {
    [self postSuccess:success failure:nil showHUD:YES];
}

- (void)postSuccess:(void (^)(id _Nonnull))success
            failure:(void (^)(NSError * _Nonnull))failure {
    [self postSuccess:success failure:failure showHUD:YES];
}

- (void)postSuccess:(void (^)(id responseObject))success
            showHUD:(BOOL)show {
    [self postSuccess:success failure:nil showHUD:show];
}

- (void)postSuccess:(void (^)(id responseObject))success
            failure:(void (^)(NSError *error))failure
            showHUD:(BOOL)show {
    MDLog(@"*** Service %@ Request parameters is %@",self.serviceName,self.params);
    if (self.hudOnView && show) [MBProgressHUD showHUDAddedTo:self.hudOnView animated:YES];
    __weak typeof(self) weakSelf = self;
    [self.session POST:self.serviceName parameters:self.params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        MDLog(@"*** Service %@ Response object is %@",self.serviceName,responseObject);
        
        if (success) {
            success(responseObject);
        } else {
            if (show) [MBProgressHUD hideHUDForView:weakSelf.hudOnView animated:YES];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf toShowFailedHUD:RequestErrorDescription];
        if (failure) {
            failure(error);
        }
    }];
}

//MARK: - get
- (void)getSuccess:(void (^)(id _Nonnull))success {
    [self getSuccess:success failure:nil showHUD:YES];
}

- (void)getSuccess:(void (^)(id _Nonnull))success
           failure:(void (^)(NSError * _Nonnull))failure {
    [self getSuccess:success failure:failure showHUD:YES];
}

- (void)getSuccess:(void (^)(id responseObject))success
           showHUD:(BOOL)show {
    [self getSuccess:success failure:nil showHUD:show];
}

- (void)getSuccess:(void (^)(id _Nonnull))success
           failure:(void (^)(NSError * _Nonnull))failure
           showHUD:(BOOL)show {
    MDLog(@"*** Service %@ Request parameters is %@",self.serviceName,self.params);
    if (self.hudOnView && show) [MBProgressHUD showHUDAddedTo:self.hudOnView animated:YES];
    __weak typeof(self) weakSelf = self;
    [self.session GET:self.serviceName parameters:self.params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        MDLog(@"*** Service %@ Response object is %@",self.serviceName,responseObject);
        
        if (success) {
            success(responseObject);
        } else {
            if (show) [MBProgressHUD hideHUDForView:weakSelf.hudOnView animated:YES];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf toShowFailedHUD:RequestErrorDescription];
        if (failure) {
            failure(error);
        }
    }];
}

//MARK: - upload
- (void)uploadFile:(MTUploadFile *)file
           success:(void (^)(id _Nonnull))success {
    [self uploadFile:file success:success failure:nil showHUD:YES];
}

- (void)uploadFile:(MTUploadFile *)file
           success:(void (^)(id _Nonnull))success
           showHUD:(BOOL)show {
    [self uploadFile:file success:success failure:nil showHUD:show];
}

- (void)uploadFile:(MTUploadFile *)file
           success:(void (^)(id _Nonnull))success
           failure:(void (^)(NSError * _Nonnull))failure
           showHUD:(BOOL)show {
    MDLog(@"*** Upload File is %@",file.fileName);
    MDLog(@"*** Request parameters is %@",self.params);
    if (self.hudOnView && show) [MBProgressHUD showHUDAddedTo:self.hudOnView animated:YES];
    __weak typeof(self) weakSelf = self;
    [self.session POST:self.serviceName parameters:self.params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:file.fileData
                                    name:file.uploadKey
                                fileName:file.fileName
                                mimeType:file.fileType];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        MDLog(@"*** Upload File %@ Response object is %@",file.fileName,responseObject);
        
        if (success) {
            success(responseObject);
        } else {
            if (show) [MBProgressHUD hideHUDForView:weakSelf.hudOnView animated:YES];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf toShowFailedHUD:RequestErrorDescription];
        if (failure) {
            failure(error);
        }
    }];
}

@end
