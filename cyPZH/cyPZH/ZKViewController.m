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
    [self beginAnimationWithTitle:@"这是一个车身的水"];
    self.view.backgroundColor = [UIColor orangeColor];
    UIButton *bty = [[UIButton alloc] initWithFrame:CGRectMake(100, 60, 100, 100)];
    bty.backgroundColor = [UIColor whiteColor];
    [bty addTarget:self action:@selector(bty) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bty];
    
}
- (void)bty
{

    UIViewController *vc = [UIViewController new];
    vc.title = @"么哦用";
    vc.view.backgroundColor = [UIColor yellowColor];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)beginAnimationWithTitle:(NSString *)title
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 225, 44)];
    view.backgroundColor = [UIColor clearColor];
    view.clipsToBounds = YES;
    self.navigationItem.titleView = view;
    
    NSString *extendedTitle = [NSString stringWithFormat:@"    %@    ", title];
    CGSize labelSize = [extendedTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:0 attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:20]} context:nil].size;
    for (int i = 0; i < 2; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.text = extendedTitle;
        label.textColor = [UIColor colorWithRed:51/255.0 green:202/255.0 blue:171/255.0 alpha:1];
        label.font = [UIFont systemFontOfSize:20];
        label.frame = CGRectMake(i * labelSize.width, 0, labelSize.width, view.frame.size.height);
        [view addSubview:label];
        
        CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
        anim.toValue = @(-label.frame.size.width);
        anim.repeatCount = MAXFLOAT;
        anim.duration = title.length / 2;
        anim.fillMode = kCAFillModeForwards;
        anim.removedOnCompletion = NO;
        [label.layer addAnimation:anim forKey:nil];
    }
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
