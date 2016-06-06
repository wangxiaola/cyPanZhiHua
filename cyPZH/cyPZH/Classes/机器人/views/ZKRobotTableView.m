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

@interface ZKRobotTableView()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray <ZKRobotMode *> *modeArray;


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
        
        self.tableView = [[UITableView alloc] initWithFrame:frame];
        self.tableView.tableFooterView = [UIView new];
        self.tableView.separatorStyle = UITableViewStylePlain;
        self.tableView.estimatedRowHeight = 50;
        self.tableView.delegate   = self;
        self.tableView.dataSource = self;
        [self.tableView registerNib:[UINib nibWithNibName:@"ZKRobotTableViewCell" bundle:nil] forCellReuseIdentifier:ZKRobotTableViewCellID];
        [self.tableView registerNib:[UINib nibWithNibName:@"ZKUserTableViewCell" bundle:nil] forCellReuseIdentifier:ZKUserTableViewCellID];
        [self addSubview:self.tableView];
        
        
    }
    
    return self;
}
#pragma mark  ---数据处理---

- (void)addUserMOde:(ZKRobotMode*)list;
{

//    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:13 inSection:0];
//    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
//    这个是指定哪一行的cell，让该行cell滑到tableView的最底端 ！
    
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];[self.tableView beginUpdates];
//    NSArray *indexPaths = @[indexPath];
//    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
//    [self.tableView endUpdates];
    
}
- (void)addRobotMOde:(ZKRobotMode*)list;
{


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
        cell = robotCell;
    }
    else
    {
    
        ZKUserTableViewCell *userCell = [tableView dequeueReusableCellWithIdentifier:ZKUserTableViewCellID ];
        
        cell = userCell;
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
