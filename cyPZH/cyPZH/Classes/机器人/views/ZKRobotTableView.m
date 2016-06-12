//
//  ZKRobotTableView.m
//  cyPZH
//
//  Created by 王小腊 on 16/6/6.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import "ZKRobotTableView.h"
#import "ZKRobotMode.h"
#import "ZKRobotTableViewCell.h"
#import "ZKUserTableViewCell.h"
#import "ZKRobotStateTableViewCell.h"
#import <MapKit/MapKit.h>

static NSString *ZKRobotTableViewCellID = @"ZKRobotTableViewCellID";
static NSString *ZKUserTableViewCellID  = @"ZKUserTableViewCellID";
static NSString *ZKRobotStateTableViewCellID  = @"ZKRobotStateTableViewCellID";

@interface ZKRobotTableView()<ZKRobotStateTableViewCellDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray <ZKRobotMode*>*modeArray;

@property (nonatomic, strong) UIActivityIndicatorView *activityView;

@property (nonatomic, strong) UIImage *potoImage;

@property (nonatomic, strong) NSString *robotName;


@end

@implementation ZKRobotTableView

- (NSMutableArray<ZKRobotMode*>*)modeArray
{
    
    if (!_modeArray) {
        
        _modeArray = [NSMutableArray array];
    }
    return _modeArray;
}

- (instancetype)initWithFrame:(CGRect)frame;
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.userInteractionEnabled = YES;
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-24)];
        self.tableView.tableFooterView = [UIView new];
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.separatorStyle = UITableViewStylePlain;
        self.tableView.estimatedRowHeight = 50;
        self.tableView.delegate   = self;
        self.tableView.dataSource = self;
        
        [self.tableView registerClass:[ZKRobotTableViewCell class] forCellReuseIdentifier:ZKRobotTableViewCellID];
        [self.tableView registerClass:[ZKUserTableViewCell class] forCellReuseIdentifier:ZKUserTableViewCellID];
        [self.tableView registerClass:[ZKRobotStateTableViewCell class] forCellReuseIdentifier:ZKRobotStateTableViewCellID];
        
        [self addSubview:self.tableView];
        
        
        _activityView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        _activityView .center = CGPointMake(self.tableView.frame.size.width/2, self.tableView.frame.size.height/2);
        //设置菊花样式
        _activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        _activityView.color =CYBColorGreen;
        [self.tableView addSubview:_activityView];
        
        
    }
    
    return self;
}
#pragma mark  ---数据处理---

- (void)addMOde:(ZKRobotMode*)list post:(BOOL)ps;
{
    
    [self.modeArray addObject:list];
    NSInteger dex = self.modeArray.count-1;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:dex inSection:0];
    
    [self.tableView beginUpdates];
    NSArray *indexPaths = @[indexPath];
    UITableViewRowAnimation state = list.type == 1 ?UITableViewRowAnimationLeft:UITableViewRowAnimationLeft;
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:state];
    [self.tableView endUpdates];
    
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
    
    if (ps == YES)
    {
        NSString *str = list.info;
        
        NSMutableDictionary *dic = [NSMutableDictionary params];
        [dic setObject:@"132" forKey:@"interfaceId"];
        [dic setObject:@"AudioQuery" forKey:@"Method"];
        [dic setObject:str forKey:@"QueryKey"];
        
        MJWeakSelf
        [_activityView startAnimating];
        [ZKHttp postWithURLString:POST_ZK_URL parameters:dic success:^(id responseObject) {
            
            [weakSelf.activityView stopAnimating];
            
            NSDictionary *dic = responseObject;
            NSArray   * array = [dic valueForKey:@"data"];
            
            /**
             *  机器人回复点击状态数据
             */
            
            NSDictionary *root = [[responseObject valueForKey:@"root"] mj_JSONObject];
            NSArray * rows = [root valueForKey:@"rows"];
            
            if (array.count == 0 && rows.count == 0) {
                
                if ([weakSelf.tabelDelegate respondsToSelector:@selector(userMusic:)]) {
                    [weakSelf.tabelDelegate userMusic:@""];
                }
                
            }
            else
            {
                NSDictionary *pic = array[0];
                
                if ([weakSelf.tabelDelegate respondsToSelector:@selector(userMusic:)]) {
                    
                    [weakSelf.tabelDelegate userMusic:[pic valueForKey:@"replyContent"]];
                }
                
                
            }
            
            [weakSelf addCellState:rows];
            
            
            
            
        } failure:^(NSError *error) {
            [weakSelf.activityView stopAnimating];
            if ([weakSelf.tabelDelegate respondsToSelector:@selector(userMusic:)]) {
                [weakSelf.tabelDelegate userMusic:@"主人,你的网络似乎断了。检查一下网络吧。"];
            }
            
            HUDShowFailure
        }];
        
    }
    
}
- (void)addCellState:(NSArray*)array;
{
    
    
    if (self.robotName && array.count > 0)
    {
        
        int64_t delayInSeconds = 1;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            NSDictionary *data = array[0];
            
            ZKRobotMode *list = [[ZKRobotMode alloc] init];
            list.rootList     = data;
            list.potoImage    = self.potoImage;
            list.name         = self.robotName;
            list.type         = ZKRobotStateClick;
            list.size         = CGSizeMake(300, 50);
            [self.modeArray addObject:list];
            
            NSInteger dex = self.modeArray.count-1;
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:dex inSection:0];

            NSArray *indexPaths = @[indexPath];
            
            [self.tableView beginUpdates];
            [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationLeft];
            [self.tableView endUpdates];
            
            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
            
            
        });
        
    }
   
    
}
- (void)updateData:(UIImage*)poto robotName:(NSString*)name;
{
    
    self.potoImage = poto;
    self.robotName = name;
}

#pragma mark --table代理---

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.modeArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    ZKRobotMode *modes = self.modeArray[indexPath.row];
    
    if (modes.type == ZKRobotStateRobot)
    {
        ZKRobotTableViewCell * robotCell = [tableView dequeueReusableCellWithIdentifier:ZKRobotTableViewCellID ];
        robotCell.list = modes;
        cell = robotCell;
    }
    else if(modes.type == ZKRobotStateUser)
    {
        
        ZKUserTableViewCell *userCell = [tableView dequeueReusableCellWithIdentifier:ZKUserTableViewCellID ];
        userCell.list = modes;
        cell = userCell;
    }
    else if(modes.type == ZKRobotStateClick)
    {
        
        ZKRobotStateTableViewCell *stateCell = [tableView dequeueReusableCellWithIdentifier:ZKRobotStateTableViewCellID];
        stateCell.list = modes;
        stateCell.stateDelegate = self;
        cell = stateCell;
        
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ZKRobotMode *modes = self.modeArray[indexPath.row];
    
    return modes.size.height+40;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20;
}
- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSLog(@" ------%ld ",(long)indexPath.row);
    
    
}

#pragma mark  ----
#pragma mark  ---- ZKRobotStateTableViewCellDelegate ----

- (void)touchData:(NSDictionary*)dic clickType:(clickState)type;
{
    NSLog(@"%@",dic);
    
    if (type == clickStateNav )
    {
        [self nav:dic];
        
    }
    else if (type == clickStatephone)
    {
        NSString *ls = [[dic valueForKey:@"phone"] componentsSeparatedByString:@"/"][0];
        UIWebView *webView = [[UIWebView alloc]init];
        
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",[ls stringByReplacingOccurrencesOfString:@"—" withString:@""]];
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
       [self addSubview:webView];
    }
    else
    {
    
        
//        详情
    }

    
}

- (void)nav:(NSDictionary*)pic
{
    //  起点
    CLLocationCoordinate2D coordinate;
    
    coordinate.latitude=[[pic objectForKey:@"latitude"] floatValue];
    
    coordinate.longitude=[[pic objectForKey:@"longitude"] floatValue];

    CLLocationCoordinate2D coords2 = coordinate;
    
    //  当前的位置
    
    MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
    
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coords2 addressDictionary:nil]];
    
    toLocation.name = [pic objectForKey:@"address"];
    
    
    NSArray *items = [NSArray arrayWithObjects:currentLocation, toLocation, nil];
    
    NSDictionary *options = @{ MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving, MKLaunchOptionsMapTypeKey: [NSNumber numberWithInteger:MKMapTypeStandard], MKLaunchOptionsShowsTrafficKey:@YES };
    //打开苹果自身地图应用，并呈现特定的item
    
    [MKMapItem openMapsWithItems:items launchOptions:options];
    
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end


