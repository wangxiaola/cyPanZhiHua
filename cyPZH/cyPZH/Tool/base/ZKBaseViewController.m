//
//  ZKBaseViewController.m
//  cyPZH
//
//  Created by 王小腊 on 16/6/6.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import "ZKBaseViewController.h"
#import "BaiduMobStat.h"
@interface ZKBaseViewController ()

@end

@implementation ZKBaseViewController
@dynamic paoMaTitle;
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.title)
    {
        
        [[BaiduMobStat defaultStat] pageviewStartWithName:[NSString stringWithFormat:@"%@",self.title]];
    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    
    [super viewDidDisappear:animated];
    
    if (self.title)
    {
        
        [[BaiduMobStat defaultStat] pageviewEndWithName:[NSString stringWithFormat:@"%@",self.title]];
    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - title
- (void)setPaoMaTitle:(NSString *)paoMaTitle
{
    if ([paoMaTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:0 attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:18]} context:nil].size.width > 225) {
        [self beginAnimationWithTitle:paoMaTitle];
    }else {
        self.title = paoMaTitle;
    }
}

- (NSString *)paoMaTitle
{
    return self.title;
}

- (void)beginAnimationWithTitle:(NSString *)title
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 225, 44)];
    view.backgroundColor = [UIColor clearColor];
    view.clipsToBounds = YES;
    self.navigationItem.titleView = view;
    
    NSString *extendedTitle = [NSString stringWithFormat:@"    %@    ", title];
    CGSize labelSize = [extendedTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:0 attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:18]} context:nil].size;
    for (int i = 0; i < 2; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.text = extendedTitle;
        label.textColor = CYBColorGreen;
        label.font = [UIFont systemFontOfSize:18];
        label.frame = CGRectMake(i * labelSize.width, 0, labelSize.width, view.frame.size.height);
        [view addSubview:label];
        
        CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
        anim.toValue = @(-label.frame.size.width);
        anim.repeatCount = MAXFLOAT;
        anim.duration = title.length / 1.8;
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
