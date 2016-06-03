//
//  ZFUserInfo.h
//  slyjg
//
//  Created by 王小腊 on 16/5/31.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZFUserInfo : NSObject

@property (nonatomic, copy, nullable ) NSString            *managerId;
@property (nonatomic, copy, nullable ) NSString            *username;
@property (nonatomic, copy, nullable ) NSString            *password;

+ (nonnull ZFUserInfo*)sharedUserInfo;

+ (void)saveAccount:(nullable ZFUserInfo *)account;

@end
