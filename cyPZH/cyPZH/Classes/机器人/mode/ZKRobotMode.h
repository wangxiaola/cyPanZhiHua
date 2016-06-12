//
//  ZKRobotMode.h
//  cyPZH
//
//  Created by 王小腊 on 16/6/6.
//  Copyright © 2016年 王小腊. All rights reserved.
//

/**
 *  数据状态
 */
typedef NS_ENUM(NSInteger,ZKRobotState) {
    /**
     *  机器人回复
     */
    ZKRobotStateRobot = 0,
    /**
     *  我的回复
     */
    ZKRobotStateUser,
    /**
     *  机器人回复点击
     */
    ZKRobotStateClick
};

#import <Foundation/Foundation.h>

@interface ZKRobotMode : NSObject

@property (nonatomic, strong) UIImage *potoImage;

@property (nonatomic, strong) NSString *info;

@property (nonatomic, strong) NSString *name;

/**
 *  0是Robot，1是my 2是坑
 */
@property (nonatomic) ZKRobotState type;

@property (nonatomic, assign) CGSize size;

@property (nonatomic, copy) NSDictionary *rootList;



@end











