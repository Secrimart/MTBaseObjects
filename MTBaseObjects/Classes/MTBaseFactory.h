//
//  MTBaseFactory.h
//  MTBaseObjects
//
//  Created by Jason Li on 2018/3/12.
//

#import <Foundation/Foundation.h>

@import MTFramework;

@protocol MTBaseFactoryDataSource<NSObject>

@required
// 配置项目 主色
- (UIColor *)setupBaseSpotColor;

// 配置项目 数据色
- (UIColor *)setupBaseDataColor;

// 配置项目 内容数据色
- (UIColor *)setupBaseGrayDataColor;

// 配置项目 标题字体
- (UIFont *)setupBaseTitleFont;

// 配置项目 内容字体
- (UIFont *)setupBaseContentFont;

// 配置项目 描述字体
- (UIFont *)setupBaseDescFont;

@end

@interface MTBaseFactory : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, weak) id <MTBaseFactoryDataSource> dataSource; // 工厂数据源

@property (nonatomic, strong) NSString *networkProtocol; // 网络访问协议 HTTP or HTTPS

@property (nonatomic, strong) NSString *baseURL; // 服务域名

//MARK: - UIColor for Project
- (UIColor *)spotColor;

- (UIColor *)dataColor;

- (UIColor *)grayDataColor;

//MARK: - UIFont for Project
- (UIFont *)titleFont;

- (UIFont *)contentFont;

- (UIFont *)descFont;


@end
