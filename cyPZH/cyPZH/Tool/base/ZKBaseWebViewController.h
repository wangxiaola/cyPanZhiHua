//
//  ZKBaseWebViewController.h
//  cyPZH
//
//  Created by 王小腊 on 16/6/6.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZKBaseWebViewController : UIViewController

@property (nonatomic, weak) UIWebView *webView;
@property (nonatomic, copy) NSString *htmlName;
@property (nonatomic, strong) NSString *htmlUrl;

- (void)loadHtml;

@end
