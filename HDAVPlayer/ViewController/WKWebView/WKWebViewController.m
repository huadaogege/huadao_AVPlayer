//
//  WKWebViewController.m
//  HDAVPlayer
//
//  Created by 崔玉冠 on 2018/7/29.
//  Copyright © 2018年 崔玉冠. All rights reserved.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>

@interface WKWebViewController () <WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler>

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation WKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    WKUserContentController *userController = [[WKUserContentController alloc] init];
    configuration.userContentController = userController;
    
    [userController addScriptMessageHandler:self name:@"TianJiProtocol"];
    
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 64, Screen_width, Screen_height) configuration:configuration];
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    self.webView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.webView];
    
    
    
    NSString *H5Path = [[NSBundle mainBundle] pathForResource:@"JSOC" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:H5Path];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

#pragma mark -- wkwebViewDelegate --
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"页面开始加载时调用");
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"当内容开始到达时调用");
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"页面加载完成之后调用");
    [self performSelector:@selector(OCCallJSMethod) withObject:nil afterDelay:2.0];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"页面加载失败时调用");
}


/* 在JS端调用alert函数时，会触发此代理方法 */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    NSString *contentString = [NSString stringWithFormat:@"内容为:%@", message];
    NSLog(@"%@", contentString);
    completionHandler();
}

/* JS端调用confirm函数时，会触发此代理方法 */
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler {
    
}

/* JS端调用prompt函数时，会触发此代理方法 */
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable result))completionHandler {
    
}

- (void)addScriptMessageHandler:(id <WKScriptMessageHandler>)scriptMessageHandler name:(NSString *)name {
    
}

/* oc调用js方法, 直接调用js已知的方法 */
- (void)OCCallJSMethod {
    [self.webView evaluateJavaScript:@"openPhoto()" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        //此处可以打印error.
    }];
}

/*JS调用OC规则:
 *JS代码的Function中{
  window.webkit.messageHandlers.'协议名称'.postMessage({
                                                           "body": "协议参数"
                                                           });}
 *OC代码中：在创建wkwebView的时候:WKUserContentController *userController = [[WKUserContentController alloc] init];
                              [userController addScriptMessageHandler:self name:@"协议名称"];
 *两者的协议名称必须一致
 *在回调方法中根据传入的参数做出相应的动作
 */

/**
 JS调用OC代码回调方法

 @param userContentController userContentController description
 @param message 回调携带参数
 */
- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"%@", message.body);
    //找到对应js端的方法名,获取messge.body
    if ([message.name isEqualToString:@"TianJiProtocol"]) {
        NSLog(@"%@", message.body);
        NSDictionary *bodyDic = message.body;
        NSString *key = bodyDic[@"body"];
        NSString *title = @"";
        if ([key isEqualToString:@"openCamera"]) {
            title = @"打开相机";
        } else if ([key isEqualToString:@"openPhoto"]) {
            title = @"打开相册";
        } else if ([key isEqualToString:@"openLocation"]) {
            title = @"打开地理定位";
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"JS调用OC代码"
                                                        message:title
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles: nil];
        [alert show];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
