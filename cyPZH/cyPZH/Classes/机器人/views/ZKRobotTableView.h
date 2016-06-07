//
//  ZKRobotTableView.h
//  cyPZH
//
//  Created by 王小腊 on 16/6/6.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZKRobotMode;


/**
 *  机器对话表
 */
@interface ZKRobotTableView : UIView<UITableViewDelegate,UITableViewDataSource>

- (instancetype)initWithFrame:(CGRect)frame;
/**
 *  添加数据
 *
 *  @param list 数据
 *  @param ps   是否发起请求
 */
- (void)addMOde:(ZKRobotMode*)list post:(BOOL)ps;


@end
