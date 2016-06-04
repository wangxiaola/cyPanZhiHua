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
#define CYBColorGreen [UIColor colorWithRed:78/255.0 green:147/255.0 blue:232/255.0 alpha:1]
#define CellBackCorl  [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1]

//获取系统版本
#define IOS7 ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0)
#define IOS8 ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] doubleValue] >= 8.0)

//获取AppDelegate
#define APPDELEGATE (AppDelegate *)([UIApplication sharedApplication].delegate)
#define UPDATA_CELL_IOS_8 [[[UIDevice currentDevice] systemVersion] floatValue] < 9 ? [self updateConstraintsIfNeeded]:NO

/**
 *  请求地址
 */
FOUNDATION_EXPORT NSString *const POST_QY_URL;
FOUNDATION_EXPORT NSString *const POST_LIST_URL;
FOUNDATION_EXPORT NSString *const POST_ZF_URL;
FOUNDATION_EXPORT NSString *const POST_ZF_LIST_URL;
/**
 *  错误图片
 */
FOUNDATION_EXPORT NSString *const QY_ERR;
FOUNDATION_EXPORT NSString *const ZF_ERR;

FOUNDATION_EXPORT NSString *const BAIDU_ID;


#endif