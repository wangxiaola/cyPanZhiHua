//
//  ZKAdvertisementViewController.m
//  cyPZH
//
//  Created by 王小腊 on 16/6/6.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import "ZKAdvertisementViewController.h"
#import "ZKBaseWebViewController.h"

@interface ZKAdvertisementViewController ()

@property (nullable, nonatomic, strong) UIImageView *advertisementImageView;

@property (nonatomic, strong) UIImageView *markImageView;

@property (nonatomic, strong) UIButton *goButton;

@property (nonatomic, strong) UIButton *clickView;

@property (nonatomic, strong) UIImageView *indicateImage;

@property (nonatomic, strong) NSString *advUrl;

@property (nonatomic, assign) BOOL isGoWeb;
@end

@implementation ZKAdvertisementViewController

@synthesize advertisementImageView,markImageView,goButton,clickView,indicateImage;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initadvertisementViews];
    
    int64_t delayInSeconds = 5.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        [self goContenView];
    });
    
}
/**
 *  创建布局
 */
- (void)initadvertisementViews
{

    advertisementImageView = [[UIImageView alloc] init];
    advertisementImageView.contentMode = UIViewContentModeScaleAspectFit;
    advertisementImageView.backgroundColor = [UIColor whiteColor];
    advertisementImageView.userInteractionEnabled = YES;
    [self.view addSubview:advertisementImageView];
    
    
    markImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"advertisement"]];
    markImageView.contentMode = UIViewContentModeScaleAspectFit;
    markImageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:markImageView];
    
    
    goButton = [UIButton buttonWithType:UIButtonTypeCustom];
    goButton.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    [goButton setTitle:@"跳过广告" forState:UIControlStateNormal];
    goButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [goButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [goButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [goButton addTarget:self action:@selector(goContenView) forControlEvents:UIControlEventTouchUpInside];
    [advertisementImageView addSubview:goButton];
    
    
    clickView = [UIButton buttonWithType:UIButtonTypeCustom];
    [clickView addTarget:self action:@selector(doTap) forControlEvents:UIControlEventTouchUpInside];
    clickView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    [advertisementImageView addSubview:clickView];


    
    indicateImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"register_stepArrow_high"]];
    indicateImage.backgroundColor = [UIColor clearColor];
    [clickView addSubview:indicateImage];
    
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    
     [advertisementImageView mas_updateConstraints:^(MASConstraintMaker *make) {
         make.left.right.top.mas_equalTo(0);
         make.height.mas_equalTo(_SCREEN_HEIGHT-90);
         
      }];
    
    [markImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.right.left.bottom.mas_equalTo(0);
        make.height.mas_equalTo(90);
    }];
    
    
    [goButton mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(advertisementImageView.mas_right).offset(-12);
        make.top.mas_equalTo(advertisementImageView.mas_top).offset(16
                                                                    );
        make.width.mas_equalTo(76);
    }];
    
    [clickView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(advertisementImageView.mas_right).offset(0);
        make.left.mas_equalTo(advertisementImageView.mas_left).offset(0);
        make.bottom.mas_equalTo(advertisementImageView.mas_bottom).offset(0);
        make.height.mas_equalTo(80);

    }];
    
    [indicateImage mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(40);
        make.right.mas_equalTo(clickView.mas_right).offset(-12);
        make.centerY.mas_equalTo(clickView.mas_centerY);
    }];

}
/**
 *  广告请求
 */
- (void)postData
{
    NSMutableDictionary *dic = [NSMutableDictionary params];
    [ZKHttp postWithURLString:POST_ZK_URL parameters:dic success:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
    
}

#pragma mark -- 点击事件
- (void)doTap
{
    
    
   self.isGoWeb = YES;
    NSLog(@" --- ");
    ZKBaseWebViewController *web = [[ZKBaseWebViewController alloc] init];
    web.htmlUrl = @"www.baidu.com";
    web.htmlName = @"这是测试";
    [web loadHtml];
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController pushViewController:web animated:YES];
    
}
- (void)goContenView
{
   if (self.isGoWeb == YES) {return;}
    self.isGoWeb = YES;
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController pushViewController:[NSClassFromString(@"ZKRobotViewController") new] animated:YES];
    
       NSLog(@"++= ");
    
    
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
