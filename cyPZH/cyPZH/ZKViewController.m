//
//  ZKViewController.m
//  cyPZH
//
//  Created by 小腊 on 16/6/5.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import "ZKViewController.h"

@interface ZKViewController ()

@end

@implementation ZKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor orangeColor];
    UIButton *bty = [[UIButton alloc] initWithFrame:CGRectMake(100, 60, 100, 100)];
    bty.backgroundColor = [UIColor whiteColor];
    [bty addTarget:self action:@selector(bty) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bty];
    
}
- (void)bty
{

    UIViewController *vc = [UIViewController new];
    vc.view.backgroundColor = [UIColor yellowColor];
    [self.navigationController pushViewController:vc animated:YES];
    
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
