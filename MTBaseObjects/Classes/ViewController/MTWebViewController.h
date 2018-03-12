//
//  MTWebViewController.h
//  MTBaseObjects
//
//  Created by Jason Li on 2018/3/12.
//

#import "MTBaseViewController.h"
#import <WebKit/WebKit.h>

@interface MTWebViewController : MTBaseViewController<WKScriptMessageHandler>
@property (nonatomic, strong) NSString *baseURL; // 网络访问基础URL
@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, strong) NSString *scriptMessageName; // 与JS交互的秘钥名称

@property (nonatomic, strong) UIViewController *popToController; // 指定返回目的控制器

- (void)toLoadRequest:(NSURLRequest *)request;

- (void)toLoadHTMLString:(NSString *)html;

//子类实现此方法，处理JS调用
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message;

@end
