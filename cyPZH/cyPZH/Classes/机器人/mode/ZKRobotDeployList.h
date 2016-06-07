//
//  ZKRobotDeployList.h
//  cyPZH
//
//  Created by 王小腊 on 16/6/7.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZKRobotDeployList : NSObject

@property (nonatomic, copy) NSString *AppSecret;

@property (nonatomic, copy) NSString *MchCode;

@property (nonatomic, copy) NSString *RobotLogo;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *ThemeName;

@property (nonatomic, copy) NSString *GreetingList;

@property (nonatomic, copy) NSString *ReplyList;

@property (nonatomic, copy) NSString *ThemeBackground;

@property (nonatomic, copy) NSString *AppId;

@property (nonatomic, copy) NSString *RoleName;

@end
