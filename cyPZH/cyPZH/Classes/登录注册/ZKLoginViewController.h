//
//  ZKLoginViewController.h
//  yjPingTai
//
//  Created by 王小腊 on 16/4/7.
//  Copyright © 2016年 WangXiaoLa. All rights reserved.
//

#import "ZKBaseViewController.h"

typedef void (^UpdateAlertBlock)();

@interface ZKLoginViewController : ZKBaseViewController

@property (nonatomic, copy) UpdateAlertBlock updateAlertBlock;
/**
 *  登录成功
 *
 */
-(void)dengluCG:(UpdateAlertBlock)pk;

@end
