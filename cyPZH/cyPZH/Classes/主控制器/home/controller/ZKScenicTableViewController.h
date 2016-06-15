//
//  ZKScenicTableViewController.h
//  CYmiangzhu
//
//  Created by 王小腊 on 16/5/18.
//  Copyright © 2016年 WangXiaoLa. All rights reserved.
//

/**
 *  景区类型
 */
typedef NS_ENUM(NSInteger,ZKScenicType) {
    /**
     *  门票
     */
    ZKScenicTicket = 0,
    /**
     *  酒店
     */
    ZKScenicHotel,
    /**
     *  食物
     */
    ZKScenicFood,
    /**
     *  攻略
     */
    ZKScenicStrategy,
    /**
     *  特产
     */
    ZKScenicSpecialty
};

#import "ZKTableViewBaseController.h"
@class ZKMainApply;
/**
 *  景区
 */
@interface ZKScenicTableViewController : ZKTableViewBaseController

@property (nonatomic) ZKScenicType scenicType;

@property (nonatomic, strong) ZKMainApply *applyList;

@end
