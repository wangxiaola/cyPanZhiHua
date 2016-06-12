//
//  ZKRobotStateTableViewCell.h
//  cyPZH
//
//  Created by 王小腊 on 16/6/12.
//  Copyright © 2016年 王小腊. All rights reserved.
//
/**
 *  点击类型
 */
typedef NS_ENUM(NSInteger,clickState) {
    /**
     *  导航
     */
    clickStateNav = 0,
    /**
     *  电话
     */
    clickStatephone,
    /**
     *  详情
     */
    clickStateList
};
#import <UIKit/UIKit.h>

@protocol ZKRobotStateTableViewCellDelegate <NSObject>

- (void)touchData:(NSDictionary*)dic clickType:(clickState)type;


@end
@class ZKRobotMode;
@interface ZKRobotStateTableViewCell : UITableViewCell

@property (nonatomic, strong) ZKRobotMode *list;

@property (nonatomic, weak) id<ZKRobotStateTableViewCellDelegate>stateDelegate;

@end
