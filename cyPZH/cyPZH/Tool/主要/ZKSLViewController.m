//
//  ZKViewController.m
//  slyjg
//
//  Created by 王小腊 on 16/2/29.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import "ZKSLViewController.h"
#import "BaiduMobStat.h"

@interface ZKSLViewController ()

@end

@implementation ZKSLViewController


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    if (self.title) {

        [[BaiduMobStat defaultStat] pageviewStartWithName:[NSString stringWithFormat:@"涉旅－%@",self.title]];
    }

}

-(void)viewDidDisappear:(BOOL)animated
{

    [super viewDidDisappear:animated];
    

    if (self.title) {
        
        [[BaiduMobStat defaultStat] pageviewEndWithName:[NSString stringWithFormat:@"涉旅－%@",self.title]];
    }
 
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    self.view.backgroundColor =[UIColor whiteColor];

    
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
