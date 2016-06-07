//
//  WXLDefine.h
//  slyjg
//
//  Created by 汤亮 on 16/3/3.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Masonry.h"
#ifndef _WXLDEFINE_H_
#define _WXLDEFINE_H_

//判断是非为 null
#define strIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length]<1 ? NO : YES )
#define strIsNull(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length]<1 ? @"暂无信息" : str )

#define kDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
//颜色
#define TabelBackCorl [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1]
#define CYBColorGreen [UIColor colorWithRed:51/255.0 green:202/255.0 blue:171/255.0 alpha:1]

#define CellBackCorl  [UIColor colorWithRed:25/255.0 green:199/255.0 blue:168/255.0 alpha:1]

//获取系统版本
#define IOS7 ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0)
#define IOS8 ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] doubleValue] >= 8.0)

//获取AppDelegate
#define APPDELEGATE (AppDelegate *)([UIApplication sharedApplication].delegate)
#define UPDATA_CELL_IOS_8 [[[UIDevice currentDevice] systemVersion] floatValue] < 9 ? [self updateConstraintsIfNeeded]:NO

/**
 *  请求地址
 */
FOUNDATION_EXPORT NSString *const POST_ZK_URL;

/**
 *  错误图片
 */
FOUNDATION_EXPORT NSString *const ZK_ERR;
/**
 *  配置参数
 */
FOUNDATION_EXPORT NSString *const BAIDU_ID;

/* shareSDK */
//    腾讯
FOUNDATION_EXPORT NSString *const tenxunQQID;
FOUNDATION_EXPORT NSString *const tenxunQQKEY;
//    微信
FOUNDATION_EXPORT NSString *const weixinID;
FOUNDATION_EXPORT NSString *const weixinSecret;
//   新浪微博
FOUNDATION_EXPORT NSString *const xinlangweipoID;
FOUNDATION_EXPORT NSString *const xinlangweipoSecret;

/* 支付SDK */
//   支付宝
FOUNDATION_EXPORT NSString *const PARTNER;
FOUNDATION_EXPORT NSString *const SELLER;
FOUNDATION_EXPORT NSString *const PRIVATEKEY;
// 微信支付

#endif