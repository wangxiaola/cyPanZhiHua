//
//  UserInfo.h
//  guide
//
//  Created by 汤亮 on 15/10/8.
//  Copyright © 2015年 daqsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
@interface UserInfo : NSObject
singleton_interface(UserInfo)


// id...
@property (nonatomic, copy  ) NSString            *ID;
//账号
@property (nonatomic, copy  ) NSString            *account;
//名字
@property (nonatomic, copy  ) NSString            *name;
//电话...
@property (nonatomic, copy  ) NSString            *phone;
//状态...
@property (nonatomic, copy  ) NSString            *state;


//保存用户信息到沙盒
- (void)saveUserInfo;
//从沙盒加载用户信息
- (void)loadUserInfo;
//重置(清空)用户信息
- (void)resetUserInfo;

@end
