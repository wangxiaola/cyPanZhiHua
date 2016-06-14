//
//  ZKMainHomeTableViewController.m
//  cyPZH
//
//  Created by 王小腊 on 16/6/14.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import "ZKMainHomeTableViewController.h"
#import "BaiduMobStat.h"
#import "ZKMainHeaderMode.h"
#import "ZKNewHomeHeaderView.h"

#import "ZKMainTopicTableViewCell.h"
#import "ZKMainListTableViewCell.h"
#import "ZKMainInforTableViewCell.h"

@interface ZKMainHomeTableViewController ()

@property (nonatomic, strong) ZKMainHeaderMode *headerList;
@property (nonatomic, strong) ZKNewHomeHeaderView *headerView;
@end

@implementation ZKMainHomeTableViewController

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

- (ZKNewHomeHeaderView *)headerView
{
    
    if (!_headerView) {
        
        _headerView = [[ZKNewHomeHeaderView alloc]initWithFrame:CGRectMake(0, 0, _SCREEN_WIDTH, 700/3)];
        _headerView.controller = self;
        
    }
    
    return _headerView;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    self.tableView.tableFooterView    = [UIView new];
    self.tableView.backgroundColor = TabelBackCorl;
    self.tableView.estimatedRowHeight = 80;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.mj_header = [MJDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(postList)];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ZKMainTopicTableViewCell" bundle:nil] forCellReuseIdentifier:ZKMainTopicTableViewCellID];
     [self.tableView registerNib:[UINib nibWithNibName:@"ZKMainListTableViewCell" bundle:nil] forCellReuseIdentifier:ZKMainListTableViewCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZKMainInforTableViewCell" bundle:nil] forCellReuseIdentifier:ZKMainInforTableViewCellID];
    
    [self initViews];
    [self setCache];
    [self postList];
    
    
}
#pragma mark  ------
#pragma mark  ---数据处理---
- (void)postList
{
    NSMutableDictionary * headerDic = [NSMutableDictionary params];
    [headerDic setObject:@"119" forKey:@"interfaceId"];
    [headerDic setObject:@"28" forKey:@"id"];
    
    MJWeakSelf
    if (self.headerList.apply.count == 0)
    {
        
        [SVProgressHUD showWithStatus:@"加载中..."];
    }
 
    [ZKHttp postWithURLString:POST_ZK_URL parameters:headerDic success:^(id responseObject) {
        
        HUDDissmiss
        [weakSelf.tableView.mj_header endRefreshing];
        
        weakSelf.headerList = [ZKMainHeaderMode mj_objectWithKeyValues:[responseObject valueForKey:@"data"]];
        [weakSelf updata];
              //缓存
        [ZKUtil write:weakSelf.headerList forKey:@"mainHeader"];
       
    } failure:^(NSError *error) {
        HUDShowError(@"网路出问题了")
         [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf setCache];
    }];

}
//缓存
- (BOOL)setCache
{

    self.headerList = [ZKUtil readForKey:@"mainHeader"];
 
    if (self.headerList.apply.count == 0)
    {
        
        return NO;
    }
    else
    {
        [self updata];
        return YES;
    }
}
/**
 *  更新数据
 */
- (void)updata

{
    self.headerView.applyList = self.headerList.apply;
    self.headerView.focusList  = self.headerList.focus;
    [self.tableView reloadData];
}
#pragma mark  ------
#pragma mark  ---视图布局---
/**
 *  初始化视图
 */
- (void)initViews
{
    self.tableView.tableHeaderView = self.headerView;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0 ) {
        
        return 1;
    }
    else if(section == 1)
    {
        return self.headerList.topic.count+1;
    }
    else
    {
        return self.headerList.product.count+1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section>0&&indexPath.row == 0)
    {
        
        return 100;
    }
    else
    {
        return 450/3;
    }

    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    UIView *headerView = [UIView new];
    
    return headerView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    
    if (indexPath.section == 0) {
        
        
        ZKMainTopicTableViewCell *ggCell = [tableView dequeueReusableCellWithIdentifier:ZKMainTopicTableViewCellID];
        ggCell.linkList = self.headerList.link;
        cell = ggCell;
    }
    else if (indexPath.section == 1)
    {
        
        if (indexPath.row == 0)
        {
            ZKMainInforTableViewCell *inforCell = [tableView dequeueReusableCellWithIdentifier:ZKMainInforTableViewCellID];
            inforCell.isTopic = YES;
            cell = inforCell;
            
        }
        else
        {
        
            ZKMainTopic  *topMode = self.headerList.topic[indexPath.row-1];
            ZKMainListTableViewCell *topicCell = [tableView dequeueReusableCellWithIdentifier:ZKMainListTableViewCellID];
            topicCell.topicList = topMode;
            cell = topicCell;
            
        }
  
    }
    else if (indexPath.section == 2)
    {
        if (indexPath.row == 0)
        {
            ZKMainInforTableViewCell *inforCell = [tableView dequeueReusableCellWithIdentifier:ZKMainInforTableViewCellID];
            inforCell.isTopic = NO;
            cell = inforCell;
            
        }
        else
        {

            ZKMainProduct  *productMode = self.headerList.product[indexPath.row-1];
            ZKMainListTableViewCell *productCell = [tableView dequeueReusableCellWithIdentifier:ZKMainListTableViewCellID];
            productCell.productList = productMode;
            cell = productCell;
        }

    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}




/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
