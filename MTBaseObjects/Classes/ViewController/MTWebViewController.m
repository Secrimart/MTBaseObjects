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
    [self.view addSubview:self.progress];
    
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
    
    [self.webView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    [self.progress mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(-20);
    }];
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

//MARK: - WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if (!navigationAction.targetFrame.isMainFrame &&
        [navigationAction.request.URL.relativeString containsString:@"http"]) {
        if (self.navigationController) {
            MTWebViewController *webVC = [[MTWebViewController alloc] init];
            webVC.title = self.title;
            [webVC toLoadRequest:navigationAction.request];
            [self.navigationController pushViewController:webVC animated:YES];
        } else {
            [webView evaluateJavaScript:@"var a = document.getElementsByTagName('a');for(var i=0;i<a.length;i++){a[i].setAttribute('target','');}" completionHandler:nil];
        }
        
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

// 处理自签名 SSL
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        NSURLCredential *card = [[NSURLCredential alloc]initWithTrust:challenge.protectionSpace.serverTrust];
        
        completionHandler(NSURLSessionAuthChallengeUseCredential,card);
    }
}

//MARK: - WKUIDelegate
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
