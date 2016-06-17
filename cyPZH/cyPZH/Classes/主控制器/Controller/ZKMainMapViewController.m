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

@interface ZKMainMapViewController ()<UITableViewDelegate,UITableViewDataSource,ZKMainMapSelectViewDelegate>

@property (nonatomic, strong) ZKMainMapSelectView *selectView;

@property (nonatomic, strong) ZKMianMapView *mainMapView;

@property (nonatomic, strong) UITableView *tableView;
// 数据
@property (nonatomic, strong) NSArray<ZKScenicListMode*> *dataArray;
/**
 *  无数据时显示的view,可在子类自定义
 */
@property (nonatomic, weak) ZKErrorView *promptView;


@end

@implementation ZKMainMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"table_map" highIcon:nil target:self action:@selector(mapClick:)];
    self.choose = 0;
    self.view.backgroundColor = TabelBackCorl;
    [self initSupViews];
    
}
#pragma mark ----
#pragma mark 初始化视图
- (void)initSupViews
{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _SCREEN_WIDTH, self.view.frame.size.height) style:UITableViewStylePlain];
    self.tableView.tableFooterView = [[UIView alloc] init];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _SCREEN_WIDTH, 60)];
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
    
    self.mainMapView = [[ZKMianMapView alloc] initWithFrame:CGRectMake(0, 64, _SCREEN_WIDTH, _SCREEN_HEIGHT - 64 - self.tabBarController.tabBar.frame.size.height)];
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
    
    self.selectView = [[ZKMainMapSelectView alloc] initWithFrame:CGRectMake(0, 64, _SCREEN_WIDTH, 60) selectType:self.mChoose];
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
- (void)updataSelectData:(NSArray<ZKScenicListMode*>*)list selectType:(NSInteger)type;
{
    self.choose = type;
    [self.tableView.mj_header endRefreshing];
    self.dataArray = list;
    self.promptView.prompt = list.count == 0?@"暂无数据":@"";
    //根据数据个数判断是否要显示提示没有数据的提示控件
    self.promptView.hidden = list.count > 0;
    [self.tableView reloadData];
    
}
#pragma mark 点击事件

- (void)mapClick:(UIButton*)sender
{
    
    if (sender.selected == NO) {
        // 地图
        [sender setBackgroundImage:[UIImage imageNamed:@"play_icon_1"] forState:UIControlStateNormal];
        sender.selected = YES;
        [self initMaapView:sender.selected];
    }
    else
    {
        //列表
        sender.selected = NO;
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
    ZKScenicListMode *mode = self.dataArray[indexPath.row];
    ZKScenicFoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ZKScenicFoodTableViewCellID];
    cell.list = mode;
    
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
