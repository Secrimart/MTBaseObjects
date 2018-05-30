//
//  MTWebViewController.m
//  MTBaseObjects
//
//  Created by Jason Li on 2018/3/12.
//

#import "MTWebViewController.h"

@interface MTWebViewController ()<WKNavigationDelegate,WKUIDelegate>
@property (nonatomic, strong) WKWebViewConfiguration *conf; // 网页视图配置对象
@property (nonatomic, strong) UIProgressView *progress; // 加载进度条

@end

@implementation MTWebViewController

- (void)toLoadRequest:(NSURLRequest *)request {
    [self.webView loadRequest:request];
    
}

- (void)toLoadHTMLString:(NSString *)html {
    [self.webView loadHTMLString:html baseURL:[NSURL URLWithString:self.baseURL]];
    
}

//MARK: - Life Cycle
- (void)initController {
    [self setHidesBottomBarWhenPushed:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.webView];
    if (self.navigationController &&
        !self.navigationController.isNavigationBarHidden) {
        [self.view addSubview:self.progress];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_webView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
    
    [_webView setNavigationDelegate:nil];
    [_webView setUIDelegate:nil];
    
}

//MARK: - Layout
- (void)setupLayoutConstraint {
    __weak typeof(self) weakSelf = self;
    [self.webView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.view);
    }];
    if (self.navigationController &&
        !self.navigationController.isNavigationBarHidden) {
        [self.progress mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(weakSelf.view);
            make.height.mas_equalTo(2);
            if (self.navigationController.navigationBar.translucent) {
                CGFloat height = CGRectGetHeight([UIApplication sharedApplication].statusBarFrame) + CGRectGetHeight(weakSelf.navigationController.navigationBar.frame);
                make.top.mas_equalTo(weakSelf.view).mas_offset(height);
            } else {
                make.top.mas_equalTo(weakSelf.view);
            }
        }];
    }
    
}

//MARK: - Getter And Setter
- (WKWebViewConfiguration *)conf {
    if (_conf) return _conf;
    _conf = [[WKWebViewConfiguration alloc] init];
    
    return _conf;
}

- (WKWebView *)webView {
    if (_webView) return _webView;
    _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:self.conf];
    _webView.navigationDelegate = self;
    _webView.UIDelegate = self;
    
    [_webView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:NSKeyValueObservingOptionNew context:nil];
    
    return _webView;
}

- (UIProgressView *)progress {
    if (_progress) return _progress;
    _progress = [[UIProgressView alloc] initWithFrame:CGRectZero];
    [_progress setTrackTintColor:[UIColor clearColor]];
    [_progress setTintColor:[UIColor blueColor]];
    
    return _progress;
}

- (void)setScriptMessageName:(NSString *)scriptMessageName {
    _scriptMessageName = scriptMessageName;
    [self.conf.userContentController addScriptMessageHandler:self name:scriptMessageName];
    
}

//MARK: - WebView GoBack
- (BOOL)navigationShouldPopOnBackButton {
    [self toOperBackButton];
    return NO;
}

- (void)toOperBackButton {
    if (self.webView.canGoBack) {
        [self.webView goBack];
        
    }else{
        if (self.popToController) {
            [self.navigationController popToViewController:self.popToController animated:YES];
        } else {
            [self.navigationController popViewControllerAnimated:YES]; //返回上一层
        }
    }
    
}

//MARK: - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name isEqualToString:self.scriptMessageName]) {
        if ([message.body isKindOfClass:[NSDictionary class]]) {
            //            [self actionToDealDeepLinkWithMessageInfo:message.body];
        }
    }
}

// 处理自签名 SSL
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        NSURLCredential *card = [[NSURLCredential alloc]initWithTrust:challenge.protectionSpace.serverTrust];
        
        completionHandler(NSURLSessionAuthChallengeUseCredential,card);
    }
}

//MARK: - WKUIDelegate
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    /**
     * 针对a标签 taget='_blank' 无效的问题
     * 判断target标签中内容为_blank时，主动加载navigationAction.request
     **/
    if (!navigationAction.targetFrame.isMainFrame) {
        NSString *fullRequest = navigationAction.request.URL.absoluteString;
        NSString *scriptString = [NSString stringWithFormat:@"%@%@%@", @"document.querySelectorAll(\"[href='", fullRequest, @"']\")[0].getAttribute('target');"];
        
        [webView evaluateJavaScript:scriptString completionHandler:^(id _Nullable targetAttr, NSError * _Nullable error) {
            if (!error) {
                if ([((NSString *)targetAttr).lowercaseString isEqualToString:@"_blank"]) {
                    [webView loadRequest:navigationAction.request];
                }
            }
        }];
    }
    
    return nil;
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    
    [self showAlertNote:message];
    completionHandler();
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
    completionHandler(NO);
}

//MARK: - Observe
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))] && object == self.webView) {
        [self.progress setAlpha:1.f];
        BOOL animated = self.webView.estimatedProgress > self.progress.progress;
        [self.progress setProgress:self.webView.estimatedProgress animated:animated];
        
        if (self.webView.estimatedProgress >= 1.0f) {
            [UIView animateWithDuration:0.3f
                                  delay:0.3f
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 [self.progress setAlpha:0.0f];
                             }
                             completion:^(BOOL finished) {
                                 [self.progress setProgress:0.0f animated:NO];
                             }];
        }
        
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
