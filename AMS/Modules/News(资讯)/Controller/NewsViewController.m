//
//  NewsViewController.m
//  AMS
//
//  Created by jianlu on 2018/11/13.
//  Copyright © 2018 jianlu. All rights reserved.
//

#import "NewsViewController.h"
#import <AXWebViewController.h>
#import <RDVTabBarController.h>
#import <WebKit/WebKit.h>
#import <NJKWebViewProgress.h>

@interface NewsViewController ()<WKNavigationDelegate>
@property(nonatomic,strong) WKWebView *webView;
@property(nonatomic,strong) UIProgressView *progressView;
@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"资讯中心";
    // Do any additional setup after loading the view.
    AXWebViewController *newsVC = [[AXWebViewController alloc] initWithAddress:NEWS_URL];
    newsVC.showsToolBar = NO;
    newsVC.navigationController.navigationBar.translucent = NO;

    newsVC.view.frame = self.view.bounds;
    [self addChildViewController:newsVC];
    [self.view addSubview:newsVC.view];
    [newsVC didMoveToParentViewController:self];
//    [self.view addSubview:self.webView];
//    self.webView.frame = self.view.bounds;
//
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    
}

//// 记得取消监听
//- (void)dealloc
//{
//    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
//}
//
//#pragma mark - WKNavigationDelegate method
//// 如果不添加这个，那么wkwebview跳转不了AppStore
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
//{
//    if ([webView.URL.absoluteString hasPrefix:@"https://itunes.apple.com"]) {
//        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
//        decisionHandler(WKNavigationActionPolicyCancel);
//    }else {
//        decisionHandler(WKNavigationActionPolicyAllow);
//    }
//}
//
//#pragma mark - event response
//// 计算wkWebView进度条
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    if (object == self.webView && [keyPath isEqualToString:@"estimatedProgress"]) {
//        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
//        self.progressView.alpha = 1.0f;
//        [self.progressView setProgress:newprogress animated:YES];
//        if (newprogress >= 1.0f) {
//            [UIView animateWithDuration:0.3f
//                                  delay:0.3f
//                                options:UIViewAnimationOptionCurveEaseOut
//                             animations:^{
//                                 self.progressView.alpha = 0.0f;
//                             }
//                             completion:^(BOOL finished) {
//                                 [self.progressView setProgress:0 animated:NO];
//                             }];
//        }
//
//    } else {
//        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
//    }
//}
//
//#pragma mark - getter and setter
//- (UIProgressView *)progressView
//{
//    if (_progressView == nil) {
//        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, kTopHeight, [UIScreen mainScreen].bounds.size.width, 2)];
//        _progressView.tintColor = [UIColor zj_colorWithHexString:@"#C80E42" alpha:1];
//        _progressView.trackTintColor = kNavBackGroundColor;
//    }
//
//    return _progressView;
//}
//
//- (WKWebView *)webView
//{
//    if(_webView == nil)
//    {
//        _webView = [[WKWebView alloc] initWithFrame:CGRectZero];
//        _webView.navigationDelegate = self;
//        _webView.opaque = NO;
//        _webView.multipleTouchEnabled = YES;
//        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
//    }
//
//    return _webView;
//}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.rdv_tabBarController.tabBarHidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.rdv_tabBarController.tabBarHidden = YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
