//
//  ZKMainMapViewController.m
//  cyPZH
//
//  Created by 王小腊 on 16/6/13.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import "ZKMainMapViewController.h"
#import "UIBarButtonItem+Custom.h"
#import "ZKMainMapSelectView.h"
#import "ZKScenicFoodTableViewCell.h"
#import "ZKErrorView.h"
#import "ZKMianMapView.h"
#import <CoreLocation/CoreLocation.h>
#import "ZKReminderView.h"

@interface ZKMainMapViewController ()<UITableViewDelegate,UITableViewDataSource,ZKMainMapSelectViewDelegate,CLLocationManagerDelegate,ZKReminderViewDelegate>

@property (nonatomic, strong) ZKMainMapSelectView *selectView;

@property (nonatomic, strong) ZKMianMapView *mainMapView;
@property (nonatomic, strong) CLLocationManager  *locationManager;
@property (nonatomic, strong) UITableView *tableView;
// 数据
@property (nonatomic, strong) NSArray<ZKMainMapMode*> *dataArray;
@property (nonatomic, strong)  ZKReminderView *reminder ;
/**
 *  无数据时显示的view,可在子类自定义
 */
@property (nonatomic, weak) ZKErrorView *promptView;

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, assign) double lat; // 经度
@property (nonatomic, assign) double lon; // 纬度

@property (nonatomic, assign) float tabarHeight;

@property (nonatomic, assign) BOOL isMap;

@end

@implementation ZKMainMapViewController

- (ZKReminderView *)reminder
{
    if (_reminder == nil) {
        
        _reminder = [[ZKReminderView alloc] initInfor:[NSString stringWithFormat:@"亲！您当前不在%@,是否切换到%@",ZK_HZ_ADDER,ZK_HZ_ADDER]];
        _reminder.delegate = self;
    }
    
    return _reminder;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"table_map" highIcon:nil target:self action:@selector(mapClick:)];
    self.choose = 0;
    self.isMap = NO;
    self.title = @"身边游";
    self.view.backgroundColor = TabelBackCorl;
    self.tabarHeight = 0;
    if (self.navigationController.childViewControllers.count == 1)
    {
        //注册通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissMap) name:@"dismmMap" object:nil];
        self.tabarHeight = self.tabBarController.tabBar.frame.size.height;
    }
    [self initSupViews];
    [self locan];
    
}
#pragma mark ----
#pragma mark 初始化视图
- (void)initSupViews
{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _SCREEN_WIDTH, self.view.frame.size.height) style:UITableViewStylePlain];
    self.tableView.tableFooterView = [[UIView alloc] init];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _SCREEN_WIDTH, 80)];
    headerView.backgroundColor = TabelBackCorl;
    self.tableView.tableHeaderView = headerView;
    self.tableView.estimatedRowHeight = 94;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorInset = UIEdgeInsetsZero;
    [self.tableView registerNib:[UINib nibWithNibName:@"ZKScenicFoodTableViewCell" bundle:nil] forCellReuseIdentifier:ZKScenicFoodTableViewCellID];
    [self.view insertSubview:self.tableView atIndex:800];
    self.tableView.mj_header = [MJDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(updataData)];
    
    self.mainMapView = [[ZKMianMapView alloc] initWithFrame:CGRectMake(0, 0, _SCREEN_WIDTH, self.view.frame.size.height-self.tabarHeight)];
    self.mainMapView.hidden = YES;
    [self.view insertSubview:self.mainMapView atIndex:900];
    
    /**
     *  错误视图
     */
    MJWeakSelf
    ZKErrorView *promptView = [[ZKErrorView alloc] init];
    promptView.hidden = YES;
    
    [self.tableView addSubview:promptView];
    self.promptView = promptView;
    [promptView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf.tableView);
        make.width.mas_equalTo(82);
        make.height.mas_equalTo(22);
    }];
    
    self.selectView = [[ZKMainMapSelectView alloc] initWithFrame:CGRectMake(0, 64, _SCREEN_WIDTH, 80) selectType:self.mChoose];
    self.selectView.delegate = self;
    [self.view insertSubview:self.selectView atIndex:999];
    
}
/**
 *  加载地图
 *
 *  @param isShowMap 是否显示
 */
- (void)initMaapView:(BOOL)isShowMap
{
    if (isShowMap == YES)
    {
        self.mainMapView.hidden = NO;
        [self.mainMapView addAnnotations:self.dataArray Type:self.mChoose];
    }
    else
    {
        self.mainMapView.hidden = YES;
        [self.mainMapView mapDestroy];
        
    }
}

#pragma mark ---
#pragma mark -- ZKMainMapSelectViewDelegate ---

/**
 *  返回的数据
 *
 *  @param list 数据
 *  @param type 类型
 */
- (void)updataSelectData:(NSArray<ZKMainMapMode*>*)list selectType:(NSInteger)type;
{
    self.choose = type;
    self.dataArray = list;
    [self.tableView.mj_header endRefreshing];
    
    if (self.isMap)
    {
        [self.mainMapView updataAddAnnotations:self.dataArray Type:type];
    }
    else
    {
        self.promptView.prompt = list.count == 0?@"暂无数据":@"";
        //根据数据个数判断是否要显示提示没有数据的提示控件
        self.promptView.hidden = list.count > 0;
        [self.tableView reloadData];
        
    }
    
    
}
#pragma mark 点击事件

- (void)mapClick:(UIButton*)sender
{
    
    if (sender.selected == NO)
    {
        // 地图
        [sender setBackgroundImage:[UIImage imageNamed:@"play_icon_1"] forState:UIControlStateNormal];
        sender.selected = YES;
        self.isMap = YES;
        [self initMaapView:sender.selected];
    }
    else
    {
        //列表
        sender.selected = NO;
        self.isMap = NO;
        [sender setBackgroundImage:[UIImage imageNamed:@"table_map"] forState:UIControlStateNormal];
        [self initMaapView:sender.selected];
    }
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
/**
 *  刷新数据
 */
- (void)updataData
{
    [self.selectView selectViewUpdata];
}
// 通知恢复列表
- (void)dismissMap
{
    if (self.isMap == YES)
    {
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"table_map" highIcon:nil target:self action:@selector(mapClick:)];
        [self initMaapView:NO];
        self.isMap = NO;
    }
}
#pragma mark ------
#pragma mark table Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataArray.count;
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZKMainMapMode *mode = self.dataArray[indexPath.row];
    
    ZKScenicFoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ZKScenicFoodTableViewCellID];
    cell.mapList = mode;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.view endEditing:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 94;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
#pragma mark -------
#pragma mark 地理位置相关
- (void)locan
{

    self.lat = [[ZKUtil ToTakeTheKey:Latitude] doubleValue];
    self.lon = [[ZKUtil ToTakeTheKey:Longitude] doubleValue];
    NSString *city = [ZKUtil ToTakeTheKey:CITY];
    
    if ([city isEqualToString:@"未知"])
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
    else
    {
    [self verdictLocationAddress:city];
    
    }
   
    
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *currLocation = [locations lastObject];
    
    self.lat = currLocation.coordinate.latitude;
    self.lon = currLocation.coordinate.longitude;
    //创建位置
    CLGeocoder *revGeo = [[CLGeocoder alloc] init];
    [revGeo reverseGeocodeLocation:currLocation
     //反向地理编码
                 completionHandler:^(NSArray *placemarks, NSError *error) {
                     
                     if (!error && [placemarks count] > 0)
                     {
                         NSDictionary *dict =
                         [[placemarks objectAtIndex:0] addressDictionary];
                         
                         [self verdictLocationAddress:[dict objectForKey:@"City"]];
                     }
                     
                 }];
    [SVProgressHUD showSuccessWithStatus:@"为正常获取成功!"];
    [_locationManager stopUpdatingLocation];
}
// 定位失败
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error;
{
    [SVProgressHUD showErrorWithStatus:@"亲！实时位置获取失败"];
    self.promptView.hidden = NO;
}

/**
 *  判断是否在攀枝花
 *
 *  @param adder 地址
 */
- (void)verdictLocationAddress:(NSString*)adder
{
    if ([adder containsString:ZK_HZ_ADDER]||[[adder lowercaseString] containsString:ZK_PY_ADDER]) {
        
        [self reminderClick:NO];
    }
    else
    {
        if (_reminder == nil)
        {
            [self.reminder show];
        }
    }
    
}

#pragma mark ----
#pragma mark -- ZKReminderViewDelegate --
/**
 *  点击状态
 *
 *  @param state yes 点击确认
 */
-(void)reminderClick:(BOOL)state;
{
    if (state)
    {
        //切换坐标
        self.lat = 26.58228;
        self.lon = 101.71872;
    }
    
    [self.mainMapView mapUpdataMyLat:self.lat myLon:self.lon];
    [self.selectView selecUpdataMyLat:self.lat myLon:self.lon];
    [self.selectView selectViewUpdata];
    
}
- (void)dealloc
{
    [self initMaapView:NO];
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
