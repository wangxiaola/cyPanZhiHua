//
//  ZKBaseWebViewController.m
//  cyPZH
//
//  Created by 王小腊 on 16/6/6.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import "ZKBaseWebViewController.h"
#import "UIBarButtonItem+Custom.h"
#import "ZKMainTabBarViewController.h"

@interface ZKBaseWebViewController ()<UIWebViewDelegate>

@property (nonatomic, weak) UIImageView *errorImageView;

@end

@implementation ZKBaseWebViewController

- (UIImageView *)errorImageView
{
    if (_errorImageView == nil) {
        UIImageView *errorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:ZK_ERR]];
        errorImageView.bounds = CGRectMake(0, 0, 100, 28);
        errorImageView.center = CGPointMake(self.webView.frame.size.width / 2, self.webView.frame.size.height / 2);
        errorImageView.image = [UIImage imageNamed:@"no_data"];
        UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loadHtml)];
        [errorImageView addGestureRecognizer:tapGr];
        
        [self.webView addSubview:errorImageView];
        
        
        
        self.errorImageView = errorImageView;
    }
    return _errorImageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIWebView * webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.backgroundColor = [UIColor whiteColor];
    webView.opaque = NO;
    webView.dataDetectorTypes = UIDataDetectorTypeNone;
    webView.delegate = self;
    [self.view addSubview:webView];
    self.webView = webView;
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"backimage" highIcon:@"backimage" target:self action:@selector(goBack)];
    
    NSString *path = self.htmlUrl;
    NSURL *URL = [NSURL URLWithString:path];
    [self.webView loadRequest:[NSURLRequest requestWithURL:URL]];
    
    
}

- (void)setHtmlName:(NSString *)htmlName
{
    
    self.title = htmlName;
}
- (void)loadHtml
{

}

/**
 *  返回
 */
- (void)goBack
{
    
    
    if (self.webView.canGoBack == NO)
    {
        
        if (self.isMain == NO)
        {
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        else
        {
            UIStoryboard *board =[UIStoryboard storyboardWithName:@"main" bundle:nil];
            
            ZKMainTabBarViewController *vc =[board instantiateInitialViewController];
            [APPDELEGATE window].rootViewController = vc;
            
        }
        
        
    }
    else
    {
        [self.webView goBack];
        
    }
    
    
}
#pragma mark webDalege
  //网页加载之前会调用此方法
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //retrun YES 表示正常加载网页 返回NO 将停止网页加载
    return YES;
    
}
//开始加载网页调用此方法
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [SVProgressHUD showImage:[UIImage imageNamed:@"loading_logo"] status:@"加载中..."];
}
//网页加载完成调用此方法
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
    self.errorImageView.hidden = YES;
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}
//网页加载失败 调用此方法
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error;
{
    [SVProgressHUD dismiss];
    self.errorImageView.hidden = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
