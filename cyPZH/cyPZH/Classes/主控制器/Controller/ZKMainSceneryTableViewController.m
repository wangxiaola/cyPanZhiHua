//
//  ZKMainSceneryTableViewController.m
//  cyPZH
//
//  Created by 王小腊 on 16/6/13.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import "ZKMainSceneryTableViewController.h"
#import "ZKMainSceneryMode.h"
#import "ZKMainPlayVideoView.h"
#import "ZKMainPlayNumberTableViewCell.h"

@interface ZKMainSceneryTableViewController ()<ZKMainPlayNumberTableViewCellDelegate>

@property (nonatomic, strong)ZKMainPlayVideoView *playView;

@property (nonatomic, assign) NSInteger index;
@end

@implementation ZKMainSceneryTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configurationParameters];
    [self initSupViews];
    [self.tableView.mj_header beginRefreshing];
    
}
#pragma mark --配置参数--
- (void)configurationParameters
{
    self.index = 0;
    self.params[@"interfaceId"]=@"146";
    self.params[@"method"]=@"sceneryRealMonitor";
    self.params[@"rows"]=@"11";
    self.params[@"page"]=@"1";
    self.cacheFilename = @"ZKMainSceneryTableViewController";
    self.needsPullUpRefreshing = NO;
    self.modelsType = [ZKMainSceneryMode class];
  
}
/**
 *  数据加载完成后
 */
- (void)didFinishedLoading
{


}


/**
 *  视图设置
 */
- (void)initSupViews
{

    self.playView = [[ZKMainPlayVideoView alloc] initWithFrame:CGRectMake(0, 0, _SCREEN_WIDTH, 120)];
    self.tableView.tableHeaderView = self.playView;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ZKMainPlayNumberTableViewCell" bundle:nil] forCellReuseIdentifier:playNumberTableViewCellID];
    
}

#pragma mark----
#pragma mark --ZKMainPlayNumberTableViewCellDelegate--
/**
 *  选中哪个气泡
 *
 *  @param mode 数据
 *  @param row  第几个
 */
- (void)selectAnnotation:(ZKMainSceneryMode*)mode index:(NSInteger)row;
{

    [self.playView updateVideo:mode];
    
    NSLog(@" ----");

}

#pragma mark----
#pragma mark --UITableViewDelageta--

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return self.models.count>0?1:0;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 340;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    ZKMainPlayNumberTableViewCell *numberCell = [tableView dequeueReusableCellWithIdentifier:playNumberTableViewCellID];
    numberCell.delegate = self;
    [numberCell showAnnonViews:self.models selct:self.index];

    cell = numberCell;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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
