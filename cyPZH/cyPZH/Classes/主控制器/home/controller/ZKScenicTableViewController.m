//
//  ZKScenicTableViewController.m
//  CYmiangzhu
//
//  Created by 王小腊 on 16/5/18.
//  Copyright © 2016年 WangXiaoLa. All rights reserved.
//

#import "ZKScenicTableViewController.h"
#import "ZKSelectListView.h"
#import "UIBarButtonItem+Custom.h"
#import "ZKMainHeaderMode.h"
#import "ZKScenicListMode.h"
#import "ZKScenicStrategyMode.h"
#import "ZKSceniceAdvertisementView.h"

#import "ZKScenicFoodTableViewCell.h"
#import "ZKScenicStrategyTableViewCell.h"

@interface ZKScenicTableViewController ()<ZKSelectListViewDelegate,ZKSceniceAdvertisementDelegate>

@property (nonatomic, strong) ZKSelectListView *selecView;
@property (nonatomic, strong) ZKSceniceAdvertisementView *adverView;

@property (nonatomic, strong) NSString *time; // 时间
@property (nonatomic, strong) NSString *lat; // 经度
@property (nonatomic, strong) NSString *lon; // 纬度
@property (nonatomic, strong) NSString *key; // 关键字
@property (nonatomic, strong) NSString *type; // 类型
@property (nonatomic, strong) NSString *ztype; // 子类型
@property (nonatomic, strong) NSString *theme; // 主题
@property (nonatomic, strong) NSString *distance; // 主题
@property (nonatomic, strong) NSString *grade; // grade
@property (nonatomic, strong) NSString *sprice; // 开始价格
@property (nonatomic, strong) NSString *eprice; // 结束价格
@property (nonatomic, strong) NSString *isnew; // 按最新
@property (nonatomic, strong) NSString *tui; // tui

@property (nonatomic, strong) NSArray *bannerArray; //广告
@end

@implementation ZKScenicTableViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self uploadView];
    [self initData];
    [self updataParams];
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)setupProperties
{
    [super setupProperties];
    self.tableViewStyle = UITableViewStyleGrouped;
}

#pragma mark 数据准备
/**
 *  初始化数据
 */
- (void)initData
{
    
    self.URLString = POST_ZK_URL;
    
    //1,创建一个日期格式化器
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // 2,设置格式
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    // 3,格式化日期
    self.time = [formatter stringFromDate:[NSDate date]];
    
    self.lat      = [ZKUtil ToTakeTheKey:Latitude];
    self.lon      = [ZKUtil ToTakeTheKey:Longitude];
    self.key      = @"";
    self.ztype    = @"";
    self.theme    = @"";
    self.distance = @"";
    self.grade    = @"";
    self.sprice   = @"";
    self.eprice   = @"";
    self.isnew    = @"";
    self.tui      = @"";
    
    
}
/**
 *  初始化参数
 */
- (void)updataParams
{
    self.params = nil;
    if (self.scenicType == ZKScenicStrategy)
    {
        self.params[@"interfaceId"] = @"137";
        self.params[@"id"] = @"28";
    }
    else
    {
        self.params[@"interfaceId"] = @"133";
        self.params[@"method"] = @"resoureListbyLatLng";
        self.params[@"lat"] = self.lat;
        self.params[@"lon"] = self.lon;
        self.params[@"ztype"] = self.ztype;
        self.params[@"theme"] = self.theme;
        self.params[@"distance"] = self.distance;
        self.params[@"grade"] = self.grade;
        self.params[@"time"] = self.time;
        self.params[@"sprice"] = self.sprice;
        self.params[@"eprice"] = self.eprice;
    }
    self.params[@"rows"] = @"15";
    self.params[@"key"] = self.key;
    self.params[@"type"] = self.type;
    self.params[@"isnew"] = self.isnew;
    self.params[@"tui"] = self.tui;
    
}
- (void)setApplyList:(ZKMainApply *)applyList
{
    _applyList = applyList;
}
/**
 *  创建右边按钮
 */
- (void)addRitBarItem
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"table_map" highIcon:nil target:self action:@selector(mapClick)];
}
- (void)uploadView;
{
    [self titleView:_applyList.name];
    
    switch (self.scenicType) {
            
        case ZKScenicTicket:
            [self.tableView registerNib:[UINib nibWithNibName:@"ZKScenicFoodTableViewCell" bundle:nil] forCellReuseIdentifier:ZKScenicFoodTableViewCellID];
            self.type = @"scenery";
            self.cacheFilename = @"sceneryList";
            self.modelsType = [ZKScenicListMode class];
            [self setAdvertisementType:@"ticket"];
            [self addRitBarItem];
            break;
        case ZKScenicHotel:
            [self.tableView registerNib:[UINib nibWithNibName:@"ZKScenicFoodTableViewCell" bundle:nil] forCellReuseIdentifier:ZKScenicFoodTableViewCellID];
            self.type = @"hotel";
            self.cacheFilename = @"hotelList";
            self.modelsType = [ZKScenicListMode class];
            [self setAdvertisementType:@"hotel"];
            [self addRitBarItem];
            break;
        case ZKScenicFood:
            self.type = @"dining";
            
            [self.tableView registerNib:[UINib nibWithNibName:@"ZKScenicFoodTableViewCell" bundle:nil] forCellReuseIdentifier:ZKScenicFoodTableViewCellID];
            self.cacheFilename = @"diningList";
            self.modelsType = [ZKScenicListMode class];
            [self setAdvertisementType:@"food"];
            [self addRitBarItem];
            break;
        case ZKScenicStrategy:
            self.type = @"";
            [self.tableView registerNib:[UINib nibWithNibName:@"ZKScenicStrategyTableViewCell" bundle:nil] forCellReuseIdentifier:ZKScenicStrategyTableViewCellID];
            self.modelsType = [ZKScenicStrategyMode class];
            self.cacheFilename = @"recreation";
            self.thmList = YES;
            break;
        case ZKScenicSpecialty:
            self.type = @"";
            self.cacheFilename = @"";
            break;
        default:
            break;

    }
    
}
// 头部文字
- (void)titleView:(NSString*)title;
{
    self.title = title;
    
    float foodH = self.scenicType == ZKScenicFood ?36.0:66.0;
    self.tableView.frame = CGRectMake(0, foodH, _SCREEN_WIDTH, _SCREEN_HEIGHT-foodH);
    
    ZKSelectListView *headerView = [[ZKSelectListView alloc] initWithFrame:CGRectMake(0, 64, _SCREEN_WIDTH,foodH) sceneryType:self.scenicType superView:self.view];
    headerView.delegate = self;
    headerView.backgroundColor = TabelBackCorl;
    [self.view addSubview:headerView];
}

- (void)setAdvertisementType:(NSString*)type
{
    
    NSMutableDictionary *dic = [NSMutableDictionary params];
    [dic setObject:@"122" forKey:@"interfaceId"];
    [dic setObject:type forKey:@"stype"];
    [dic setObject:@"28" forKey:@"id"];
    [dic setObject:@"add" forKey:@"type"];
    dic[@"TimeStamp"] = [ZKUtil timeStamp];
    MJWeakSelf
    [ZKHttp postWithURLString:POST_ZK_URL parameters:dic success:^(id responseObject) {
        
        weakSelf.bannerArray = [[responseObject valueForKey:@"data"] valueForKey:@"add"];
        if (weakSelf.models.count == 0 && weakSelf.bannerArray.count>0)
        {
            [self bannerAdvertisementView];
        }
        else
        {
            [weakSelf.tableView reloadData];
            
        }
        
        
    } failure:^(NSError *error) {
        
        
    }];
    
}

/**
 *  每次拿到最新数据的时候调用，子类覆盖使用
 *
 *  @param responseObject 数据
 *  @param page           页数
 */
- (void)didGetResponse:(id)responseObject atPage:(NSInteger)page;
{
    if (page == 1 && self.bannerArray.count>0)
    {
        [self.models removeAllObjects];
        [self bannerAdvertisementView];
    }
}

#pragma mark ------
#pragma mark table Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.models.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell;
    
    if (self.scenicType == ZKScenicStrategy)
    {
        ZKScenicStrategyMode *mode = self.models[indexPath.section];
        ZKScenicStrategyTableViewCell *strategyCell = [tableView dequeueReusableCellWithIdentifier:ZKScenicStrategyTableViewCellID];
        strategyCell.list = mode;
        cell = strategyCell;
        
    }
    
    else if (self.scenicType == ZKScenicSpecialty)
    {
        
    }
    else
    {
        ZKScenicListMode *mode = self.models[indexPath.section];
        ZKScenicFoodTableViewCell *foodCell = [tableView dequeueReusableCellWithIdentifier:ZKScenicFoodTableViewCellID];
        foodCell.list = mode;
        cell = foodCell;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.scenicType == ZKScenicStrategy)
    {
        return 260;
    }
    else
    {
        return 94;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    if (self.scenicType == ZKScenicStrategy)
    {
        
        return 8;
    }
    else
    {
        if (section == 1)
        {
            return self.bannerArray.count == 0 ?0.01:240;
        }
        else
        {
            return 0.01;
        }
        
    }
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    if (self.scenicType == ZKScenicStrategy)
    {
        
        return [UIView new];
        
    }
    else
    {
        
        if (section == 1)
        {
            if (self.bannerArray.count > 0)
            {
                [self bannerAdvertisementView];
                return self.adverView;
                
            }
            else
            {
                
                return nil;
            }
            
        }
        else
        {
            return nil;
        }
        
    }
}
/**
 *  创建广告
 *
 *  @return 返回广告图
 */
- (void)bannerAdvertisementView
{
    
    [self.adverView.timer invalidate];
    self.adverView.timer = nil;
    self.adverView.delegate = nil;
    [self.adverView removeFromSuperview];
    
    self.adverView = [[ZKSceniceAdvertisementView alloc] initWithFrame:CGRectMake(0, 1, _SCREEN_WIDTH, 239) Data:_bannerArray];
    self.adverView.delegate = self;
    
    if (self.models.count<2) {
        
        self.tableView.tableHeaderView = self.adverView;
        
    }
    else
    {
        self.tableView.tableHeaderView = [UIView new];
        
    }
    
}

- (void)resourc
{
    
    NSLog(@" ---- ");
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.view endEditing:YES];
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
#pragma mark 点击事件

- (void)mapClick
{
    [self.navigationController pushViewController:[NSClassFromString(@"ZKMainMapViewController") new] animated:YES];
    
}

#pragma mark --ZKSelectListViewDelegate--
/**
 *  搜索
 *
 *  @param key 值
 */
- (void)seekName:(NSString*)key;
{
    if (self.key != key)
    {
        self.key = key;
        [self updataParams];
        [self.tableView.mj_header beginRefreshing];
    }
    
}

/**
 *  按条件搜索
 *
 *  @param key 值
 *  @param type 类型
 *  @param row 第几个
 */
- (void)condition:(NSString*)key typeList:(NSInteger)type index:(NSInteger)row;
{
    
    MMLog(@"%@",key);
    
    switch (type) {
        case 0://门票
            
            switch (row) {
                case 0:
                    self.ztype    = @"";
                    self.theme    = @"";
                    self.distance = @"";
                    break;
                case 1:
                    self.ztype    = key;
                    self.theme    = @"";
                    self.distance = @"";
                    break;
                case 2:
                    self.ztype    = @"";
                    self.theme    = key;
                    self.distance = @"";
                    break;
                case 3:
                    self.ztype    = @"";
                    self.theme    = @"";
                    self.distance = key;
                    break;
                default:
                    break;
            }
            break;
        case 1://酒店
            switch (row) {
                case 0:
                    self.sprice   = @"";
                    self.eprice   = @"";
                    self.grade    = @"";
                    self.distance = @"";
                    break;
                case 1:
                    if (key.length == 0)
                    {
                        self.sprice   = @"";
                        self.eprice   = @"";
                    }
                    else
                    {
                        self.sprice   = [key componentsSeparatedByString:@"-"][0];
                        self.eprice   = [key componentsSeparatedByString:@"-"][1];
                    }
                    self.grade    = @"";
                    self.distance = @"";
                    break;
                case 2:
                    self.sprice   = @"";
                    self.eprice   = @"";
                    self.grade    = key;
                    self.distance = @"";
                    break;
                case 3:
                    self.sprice   = @"";
                    self.eprice   = @"";
                    self.grade    = @"";
                    self.distance = key;
                    break;
                default:
                    break;
            }
            break;
        case 3://攻略
            switch (row) {
                case 0:
                    self.type  = @"";
                    self.isnew = @"";
                    self.tui   = @"";
                    break;
                case 1:
                    self.type  = @"";
                    self.isnew = @"";
                    self.tui   = self.tui.length == 0 ? @"key":@"";
                    break;
                case 2:
                    self.type  = key;
                    self.isnew = @"";
                    self.tui   = @"";
                    break;
                case 3:
                    self.type  = @"";
                    self.isnew = self.isnew.length == 0 ?@"key":@"";
                    self.tui   = @"";
                    break;
                default:
                    break;
            }
            
            break;
        default:
            break;
    }
    
    [self updataParams];
    [self.tableView.mj_header beginRefreshing];
    
}

#pragma mark --
#pragma mark ZKSceniceAdvertisementDelegate
- (void)sceleAdvertisement:(NSDictionary*)pic;
{
    
    MMLog(@"%@",pic);
}

- (void)dealloc
{
    [self.adverView.timer invalidate];
    self.adverView.timer = nil;
    self.adverView.delegate = nil;
    
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
