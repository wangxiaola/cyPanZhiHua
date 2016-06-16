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

#import "ZKScenicFoodTableViewCell.h"

@interface ZKScenicTableViewController ()<ZKSelectListViewDelegate>

@property (nonatomic, strong) ZKSelectListView *selecView;

@property (nonatomic, strong) NSString *time; // 时间
@property (nonatomic, strong) NSString *lat; // 经度
@property (nonatomic, strong) NSString *lon; // 纬度
@property (nonatomic, strong) NSString *key; // 关键字
@property (nonatomic, strong) NSString *type; // 类型
@property (nonatomic, strong) NSString *ztype; // 子类型
@property (nonatomic, strong) NSString *theme; // 主题
@property (nonatomic, strong) NSString *distance; // 主题
@property (nonatomic, strong) NSString *grade; // grade

@end

@implementation ZKScenicTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"table_map" highIcon:nil target:self action:@selector(mapClick)];
    
    [self uploadView];
    [self initData];
    [self updataParams];
    
    [self.tableView.mj_header beginRefreshing];
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

    

}
/**
 *  初始化参数
 */
- (void)updataParams
{
    self.params = nil;
    self.params[@"interfaceId"] = @"133";
    self.params[@"method"] = @"resoureListbyLatLng";
    self.params[@"rows"] = @"15";
    self.params[@"lat"] = self.lat;
    self.params[@"lon"] = self.lon;
    self.params[@"key"] = self.key;
    self.params[@"ztype"] = self.ztype;
    self.params[@"type"] = self.type;
    self.params[@"theme"] = self.theme;
    self.params[@"distance"] = self.distance;
    self.params[@"grade"] = self.grade;
    self.params[@"time"] = self.time;
    
    
}
- (void)setApplyList:(ZKMainApply *)applyList
{
    _applyList = applyList;
}
- (void)uploadView;
{
     [self titleView:_applyList.name];
    self.modelsType = [ZKScenicListMode class];
    
    switch (self.scenicType) {

        case ZKScenicTicket:
             [self.tableView registerNib:[UINib nibWithNibName:@"ZKScenicFoodTableViewCell" bundle:nil] forCellReuseIdentifier:ZKScenicFoodTableViewCellID];
            self.type = @"scenery";
            self.cacheFilename = @"sceneryList";
            break;
        case ZKScenicHotel:
             [self.tableView registerNib:[UINib nibWithNibName:@"ZKScenicFoodTableViewCell" bundle:nil] forCellReuseIdentifier:ZKScenicFoodTableViewCellID];
            self.type = @"hotel";
            self.cacheFilename = @"hotelList";
            break;
        case ZKScenicFood:
            self.type = @"dining";
            
            [self.tableView registerNib:[UINib nibWithNibName:@"ZKScenicFoodTableViewCell" bundle:nil] forCellReuseIdentifier:ZKScenicFoodTableViewCellID];
            self.cacheFilename = @"diningList";
            
            break;
        case ZKScenicStrategy:
            self.type = @"ruraltourism";
            self.cacheFilename = @"recreation";
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
    UIButton *titleButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    
    [titleButton setImage:[UIImage imageNamed:@"home_xiala_pre"] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"home_xiala"] forState:UIControlStateHighlighted];
    titleButton.titleLabel.font = [UIFont systemFontOfSize:18];
    float w = [ZKUtil contentLabelSize:CGSizeMake(200, 20) labelFont:18 labelText:title].width;
    [titleButton setImageEdgeInsets:UIEdgeInsetsMake(0,w*2, 0, 0)];
    [titleButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    [titleButton setTitle:title forState:UIControlStateNormal];
    [titleButton setTitleColor:CYBColorGreen forState:UIControlStateNormal];
    [titleButton addTarget:self action:@selector(titleClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;

    float foodH = self.scenicType == ZKScenicFood ?0.0:30.0;
    ZKSelectListView *headerView = [[ZKSelectListView alloc] initWithFrame:CGRectMake(0, 0, _SCREEN_WIDTH, 10+26+foodH) sceneryType:self.scenicType];
    headerView.delegate = self;
    self.tableView.tableHeaderView = headerView;
    
}
#pragma mark ------
#pragma mark table Delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell;
    
    NSObject *mode = self.models[indexPath.row];
    

   if (self.scenicType == ZKScenicStrategy)
    {

    }

    else if (self.scenicType == ZKScenicSpecialty)
    {
        
    }
    else
    {
        ZKScenicFoodTableViewCell *foodCell = [tableView dequeueReusableCellWithIdentifier:ZKScenicFoodTableViewCellID];
        foodCell.list = (ZKScenicListMode*)mode;
        cell = foodCell;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 94;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [self.view endEditing:YES];
    
}
#pragma mark 点击事件
- (void)titleClick
{

}
- (void)mapClick
{


}

#pragma mark --ZKSelectListViewDelegate--
/**
 *  搜索
 *
 *  @param key 值
 */
- (void)seekName:(NSString*)key;
{

    self.key = key;
    [self updataParams];
    [self.tableView.mj_header beginRefreshing];
    
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
