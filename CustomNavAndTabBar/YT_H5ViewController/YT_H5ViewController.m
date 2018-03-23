//
//  TuiJianController.m
//  SugeiOS
//
//  Created by suge on 2016/11/17.
//  Copyright © 2016年 素格. All rights reserved.
//

#import "YT_H5ViewController.h"
#import <WebKit/WebKit.h>
@interface YT_H5ViewController ()<UIWebViewDelegate,WKUIDelegate,WKNavigationDelegate>
@property (nonatomic,strong) UIProgressView *progressView;
@property (nonatomic,strong) WKWebView *wkWebView;
//@property (nonatomic,strong) MBProgressHUD *hud;
@property (nonatomic,strong) UIView * faileView;
//导航栏返回按钮
@property (nonatomic,strong) UIButton *backBtn;
@end

@implementation YT_H5ViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = self.titleName;
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:21.0]}];
    self.view.backgroundColor = [UIColor whiteColor];
//    [self setBackButton];
    
    
    UIButton *right_Button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [right_Button setTitle:@"刷新" forState:UIControlStateNormal];
    right_Button.titleLabel.font = [UIFont systemFontOfSize:15];
    [right_Button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    right_Button.backgroundColor = [UIColor clearColor];
    UIView *right_View = [[UIView alloc] init];
    right_View.frame = CGRectMake(0, 0, 44, 44);
    right_View.backgroundColor = [UIColor clearColor];
    right_Button.frame = CGRectMake((44 - 40)/2.0, (44 - 40)/2.0, 40, 40);
    [right_Button addTarget:self action:@selector(reloadButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [right_View addSubview:right_Button];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:right_View];
    
    self.navigationItem.rightBarButtonItem = leftItem;
    
    
    _wkWebView = [[WKWebView alloc]initWithFrame:CGRectMake(0, ([[UIApplication sharedApplication] statusBarFrame].size.height + self.navigationController.navigationBar.frame.size.height), [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - ([[UIApplication sharedApplication] statusBarFrame].size.height + self.navigationController.navigationBar.frame.size.height) )];
    _wkWebView.backgroundColor = [UIColor whiteColor];
    [_wkWebView setUserInteractionEnabled:YES];//是否支持交互
    _wkWebView.UIDelegate = self;
    _wkWebView.navigationDelegate = self;
    [_wkWebView setOpaque:NO];//opaque是不透明的意思
    [self.view addSubview:_wkWebView];
    
    //添加进度条
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, [[UIApplication sharedApplication] statusBarFrame].size.height + self.navigationController.navigationBar.frame.size.height, [UIScreen mainScreen].bounds.size.width, 2)];
    self.progressView.backgroundColor = [UIColor blueColor];
    //设置进度条的高度，进度条宽度变为原来的1倍，高度变为原来的1.5倍
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    [self.view addSubview:self.progressView];
    
    
    self.faileView = [[UIImageView alloc] init];
    self.faileView.frame = CGRectMake(0, ([[UIApplication sharedApplication] statusBarFrame].size.height + self.navigationController.navigationBar.frame.size.height), [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-([[UIApplication sharedApplication] statusBarFrame].size.height + self.navigationController.navigationBar.frame.size.height));
    
    self.faileView.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    self.faileView.userInteractionEnabled = YES;
    [self.view addSubview:self.faileView];
    
    UIButton *Button = [UIButton buttonWithType:UIButtonTypeCustom];
    Button.frame = CGRectMake((self.faileView.frame.size.width - 100)/2.0, self.faileView.frame.size.height - 200 - 40, 100, 40);
    [Button setTitle:@"重新加载" forState:UIControlStateNormal];
    
    Button.titleLabel.font = [UIFont systemFontOfSize:15];
    [Button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    Button.backgroundColor = [UIColor whiteColor];
    [Button addTarget:self action:@selector(reloadButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.faileView addSubview:Button];
    
    
    UILabel *Label = [[UILabel alloc] init];
    Label.frame = CGRectMake(0, self.faileView.frame.size.height - 200 - 40 - 10 - 20, self.faileView.frame.size.width, 20);
    Label.font = [UIFont systemFontOfSize:15];
    Label.textColor = [UIColor grayColor];
    Label.text = @"您的网络不正常，请稍后再试";
    Label.textAlignment = NSTextAlignmentCenter;
    Label.backgroundColor = [UIColor clearColor];
    [self.faileView addSubview:Label];
    
    UIImageView *ImageView = [[UIImageView alloc] init];
    ImageView.frame = CGRectMake((self.faileView.frame.size.width - 100)/2.0, self.faileView.frame.size.height - 200 - 40 - 10 - 20 - 10 - 100, 100, 100);
    ImageView.image = [UIImage imageNamed:@"onclick"];
    //        ImageView.backgroundColor = [UIColor whiteColor];
    [self.faileView addSubview:ImageView];
    self.faileView.hidden = YES;
    
    
    
    //添加KVO，WKWebView有一个属性estimatedProgress，就是当前网页加载的进度，所以监听这个属性
    [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];

    //1.创建并加载远程网页  tuiJianTest
    NSURL *url = [NSURL URLWithString:self.urlString];
    [_wkWebView loadRequest:[NSURLRequest requestWithURL:url]];

}
#pragma mark - 设置返回按钮
- (void)setBackButton{
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBtn.frame = CGRectMake(0, 0, 44, 44);
    //    [self.backBtn setImage:[UIImage imageNamed:@"向左箭头png"] forState:UIControlStateNormal];
    //    self.backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -44/2.0+10, 0,44/2.0);
    [self.backBtn setTitle:@"返回" forState:0];
    [self.backBtn setTintColor:[UIColor blackColor]];
    [self.backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
}
- (void)doBack:(UIButton *)backBtn{
    
    if ([self.wkWebView canGoBack]) {
        [self.wkWebView goBack];
        
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}
#pragma mark - 重新加载按钮
- (void)reloadButtonClick{
    NSLog(@"重新加载按钮");
    self.faileView.hidden = YES;
    NSURL *url = [NSURL URLWithString:self.urlString];
    [_wkWebView loadRequest:[NSURLRequest requestWithURL:url]];
}

#pragma mark - 在监听方法中获取网页加载的进度，并将进度赋给progressView.progress
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.progress = self.wkWebView.estimatedProgress;
        if (self.progressView.progress == 1) {
            /*
             *添加一个简单的动画，将progressView的Height变为1.4倍
             *动画时长0.25s，延时0.3s后开始动画
             *动画结束后将progressView隐藏
             */
            __weak typeof (self)weakSelf = self;
            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                weakSelf.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
            } completion:^(BOOL finished) {
                weakSelf.progressView.hidden = YES;
                
            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
#pragma mark - WKWebView 开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"开始加载网页");
    self.progressView.hidden = NO;
    //开始加载网页的时候将progressView的Height恢复为1.5倍
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
}
#pragma mark - WKWebView 加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"加载完成");
    //加载完成后隐藏progressView
    self.progressView.hidden = YES;
}

#pragma mark - WKWebView 加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"加载失败");
    //加载失败同样需要隐藏progressView
    self.faileView.hidden = NO;
    self.progressView.hidden = YES;
}
#pragma mark - WKWebView 页面跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    //允许页面跳转
    NSLog(@"允许页面跳转----%@",navigationAction.request.URL);
    
    
    
    decisionHandler(WKNavigationActionPolicyAllow);
}
- (void)dealloc {
    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
