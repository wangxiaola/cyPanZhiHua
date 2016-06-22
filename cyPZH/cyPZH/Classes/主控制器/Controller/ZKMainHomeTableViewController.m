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
#import "ZKBaseWebViewController.h"

#import "ZKMainTopicTableViewCell.h"
#import "ZKMainListTableViewCell.h"
#import "ZKMainInforTableViewCell.h"

#import <CoreLocation/CoreLocation.h>

@interface ZKMainHomeTableViewController ()<CLLocationManagerDelegate>

@property (nonatomic, strong) ZKMainHeaderMode *headerList;
@property (nonatomic, strong) ZKNewHomeHeaderView *headerView;
@property (nonatomic, strong) CLLocationManager  *locationManager;

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
    
    [self locan];
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
    headerDic[@"TimeStamp"] = [ZKUtil timeStamp];
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
    
    if (indexPath.section == 0)
    {
        
        
        ZKMainTopicTableViewCell *ggCell = [tableView dequeueReusableCellWithIdentifier:ZKMainTopicTableViewCellID];
        ggCell.linkList   = self.headerList.link;
        ggCell.controller = self;
        cell = ggCell;
    }
    else if (indexPath.section == 1 && indexPath.row > 0)
    {
        
        ZKMainTopic  *topMode = self.headerList.topic[indexPath.row-1];
        ZKMainListTableViewCell *topicCell = [tableView dequeueReusableCellWithIdentifier:ZKMainListTableViewCellID];
        topicCell.topicList = topMode;
        cell = topicCell;
        
    }
    else if (indexPath.section == 2  && indexPath.row > 0)
    {
        ZKMainProduct  *productMode = self.headerList.product[indexPath.row-1];
        ZKMainListTableViewCell *productCell = [tableView dequeueReusableCellWithIdentifier:ZKMainListTableViewCellID];
        productCell.productList = productMode;
        cell = productCell;
    }
    else
    {
        
        ZKMainInforTableViewCell *inforCell = [tableView dequeueReusableCellWithIdentifier:ZKMainInforTableViewCellID];
        inforCell.isTopic = indexPath.section == 1?YES:NO;
        cell = inforCell;
        
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{

    if (indexPath.section == 1 && indexPath.row > 0)
    {
        
        ZKMainTopic  *topMode = self.headerList.topic[indexPath.row-1];
        [self pushWebUrl:topMode.url];
        
    }
    else if (indexPath.section == 2  && indexPath.row > 0)
    {
        ZKMainProduct  *productMode = self.headerList.product[indexPath.row-1];
        [self pushWebUrl:productMode.url];
    }
    
}
/**
 *  跳转网页
 *
 *  @param str URL
 */
- (void)pushWebUrl:(NSString*)str
{
    ZKBaseWebViewController *web = [[ZKBaseWebViewController alloc]init];
    web.htmlUrl = str;
    [self.navigationController pushViewController:web animated:YES];
    
}

#pragma mark -------
#pragma mark 地理位置相关
- (void)locan
{
    //定位管理器
    _locationManager=[[CLLocationManager alloc]init];
    [SVProgressHUD showWithStatus:@"正在获取实时位置"];
    if (![CLLocationManager locationServicesEnabled])
    {
        [SVProgressHUD showErrorWithStatus:@"定位服务当前可能尚未打开，请设置打开！"];
        return;
    }
    //如果没有授权则请求用户授权
    if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined){
        [_locationManager requestWhenInUseAuthorization];
    }
    else
    {
        //设置代理
        _locationManager.delegate=self;
        //设置定位精度
        _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        [_locationManager requestAlwaysAuthorization];
        //启动跟踪定位
        [_locationManager startUpdatingLocation];
    }
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *currLocation = [locations lastObject];

    [ZKUtil MyValue:[NSString stringWithFormat:@"%f",currLocation.coordinate.latitude] MKey:Latitude];
    [ZKUtil MyValue:[NSString stringWithFormat:@"%f",currLocation.coordinate.longitude] MKey:Longitude];
    [_locationManager stopUpdatingLocation];
    
    //创建位置
    CLGeocoder *revGeo = [[CLGeocoder alloc] init];
    [revGeo reverseGeocodeLocation:currLocation
     //反向地理编码
                 completionHandler:^(NSArray *placemarks, NSError *error) {
                     
                     if (!error && [placemarks count] > 0)
                     {
                         NSDictionary *dict =
                         [[placemarks objectAtIndex:0] addressDictionary];
                         NSString *str =[dict objectForKey:@"Name"];
                         str =[str stringByReplacingOccurrencesOfString:@"中国" withString:@""];
                         [ZKUtil MyValue:str MKey:ADDRESS];
                         [ZKUtil MyValue:[dict objectForKey:@"City"] MKey:CITY];

                     }
                     else
                     {
                     }
                 }];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error;
{

    [ZKUtil MyValue:@"0" MKey:Latitude];
    [ZKUtil MyValue:@"0" MKey:Longitude];
    [ZKUtil MyValue:@"未知" MKey:ADDRESS];
    [ZKUtil MyValue:@"未知" MKey:CITY];
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
