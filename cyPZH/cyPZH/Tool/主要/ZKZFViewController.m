//
//  ZKZFViewController.m
//  slyjg
//
//  Created by 王小腊 on 16/3/21.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import "ZKZFViewController.h"
#import "BaiduMobStat.h"

@implementation ZKZFViewController

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    if (self.title) {

        [[BaiduMobStat defaultStat] pageviewStartWithName:[NSString stringWithFormat:@"执法－%@",self.title]];
    }
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    
    [super viewDidDisappear:animated];
    
    
    if (self.title) {
        
        [[BaiduMobStat defaultStat] pageviewEndWithName:[NSString stringWithFormat:@"执法－%@",self.title]];
    }
    
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    self.view.backgroundColor =[UIColor whiteColor];
    
    
}

@end
