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

static NSString *ZKRobotTableViewCellID = @"ZKRobotTableViewCellID";
static NSString *ZKUserTableViewCellID = @"ZKUserTableViewCellID";

@interface ZKRobotTableView()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray <ZKRobotMode *> *modeArray;

@property (nonatomic, strong) UIActivityIndicatorView *activityView;
@end

@implementation ZKRobotTableView

- (NSMutableArray<ZKRobotMode *> *)modeArray
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
    UITableViewRowAnimation state = list.type == 1 ?UITableViewRowAnimationRight:UITableViewRowAnimationLeft;
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:state];
    [self.tableView endUpdates];
    
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];

    if (ps == YES)
    {
        NSString *str = list.info;
        
        NSMutableDictionary *dic = [NSMutableDictionary params];
        [dic setObject:str forKey:@"messg"];
        
        [ZKHttp postWithURLString:POST_ZK_URL parameters:dic success:^(id responseObject) {
            
            
        } failure:^(NSError *error) {
            
            HUDShowFailure
        }];
        
    }
    
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
    
    
    if (modes.type == 0)
    {
       ZKRobotTableViewCell * robotCell = [tableView dequeueReusableCellWithIdentifier:ZKRobotTableViewCellID ];
        robotCell.list = modes;
        cell = robotCell;
    }
    else
    {
    
        ZKUserTableViewCell *userCell = [tableView dequeueReusableCellWithIdentifier:ZKUserTableViewCellID ];
        userCell.list = modes;
        cell = userCell;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{


    NSLog(@" ------%d ",indexPath.row);
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
