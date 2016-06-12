//
//  ZKBaseWebViewController.m
//  cyPZH
//
//  Created by 王小腊 on 16/6/6.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import "ZKBaseWebViewController.h"
#import "UIBarButtonItem+Custom.h"
#import "ZKNavigationController.h"

@interface ZKBaseWebViewController ()<UIWebViewDelegate>

@property (nonatomic, weak) UIImageView *errorImageView;

@end

@implementation ZKBaseWebViewController

- (UIImageView *)errorImageView
{
    if (_errorImageView == nil) {
        UIImageView *errorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:ZK_ERR]];
        errorImageView.bounds = CGRectMake(0, 0, 100, 100);
        errorImageView.center = CGPointMake(self.webView.frame.size.width / 2, self.webView.frame.size.height / 2);
        
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

    
}
- (void)setHtmlName:(NSString *)htmlName
{

    self.title = htmlName;
}
- (void)loadHtml
{
    NSString *path = self.htmlName;
    NSURL *URL = [NSURL URLWithString:path];
    [self.webView loadRequest:[NSURLRequest requestWithURL:URL]];
}

/**
 *  返回
 */
- (void)goBack
{
    
    
    if (self.webView.canGoBack == NO) {
        

        [[UserInfo sharedUserInfo] loadUserInfo];
        
        if (strIsEmpty([UserInfo sharedUserInfo].name)) {
            
            self.navigationController.navigationBarHidden = NO;
            [self.navigationController pushViewController:[NSClassFromString(@"ZKRobotViewController") new] animated:YES];
        }
        else
        {
            
            ZKNavigationController *nav = [[ZKNavigationController alloc] initWithRootViewController:[NSClassFromString(@"ZKLoginViewController") new]];
            nav.navigationBarHidden = YES;
            [APPDELEGATE window].rootViewController = nav;
        }
        

        
    }
    else
    {
        [self.webView goBack];
        
    }
    
    
}
#pragma mark webDalege

- (void)webViewDidFinishLoad:(UIWebView *)webView
{

    self.errorImageView.hidden = YES;
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView;
{
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
