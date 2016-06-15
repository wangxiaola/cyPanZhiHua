//
//  ZKScenicListMode.h
//  cyPZH
//
//  Created by 王小腊 on 16/6/15.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ZKScenicListMode : NSObject
// id
@property (nonatomic, assign) NSInteger ID;
// 名字
@property (nonatomic, copy) NSString *name;
// phone
@property (nonatomic, copy) NSString *phone;
// 经度
@property (nonatomic, assign) CGFloat x;
// 距离
@property (nonatomic, assign) CGFloat juli;
// 纬度
@property (nonatomic, assign) CGFloat y;
//
//@property (nonatomic, strong) NSArray *orderlist;
//
@property (nonatomic, copy) NSString *tag;
// 摘要内容
@property (nonatomic, copy) NSString *summary;
// 推荐指数
@property (nonatomic, assign) NSInteger exponent;
// 价格
@property (nonatomic, copy) NSString *price;
// address
@property (nonatomic, copy) NSString *address;
// logosmall
@property (nonatomic, copy) NSString *logosmall;
// 赞扬
@property (nonatomic, copy) NSString *praise;
//
//@property (nonatomic, strong) NSArray *pics;
//  查看
@property (nonatomic, assign) NSInteger views;
//  等级代码
@property (nonatomic, assign) NSInteger resourceLevel;
//  资源等级名称
@property (nonatomic, assign) NSInteger resourceLevelName;
//  标识是否有产品 1标识有 0标识无
@property (nonatomic, assign) NSInteger existproduct;
//  标识是否推荐 1标识推荐
@property (nonatomic, assign) NSInteger recommend;

@end


