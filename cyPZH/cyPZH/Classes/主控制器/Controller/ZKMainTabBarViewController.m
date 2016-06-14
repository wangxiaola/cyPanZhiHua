//
//  ZKMainTabBarViewController.m
//  cyPZH
//
//  Created by 王小腊 on 16/6/13.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import "ZKMainTabBarViewController.h"

@interface ZKMainTabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation ZKMainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.delegate = self;

    self.tabBar.tintColor = CYBColorGreen;
}



-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    
    
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
