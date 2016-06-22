//
//  ZKUserInfo.h
//  cyPZH
//
//  Created by 王小腊 on 16/6/22.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZKUserInfo : NSObject
/**
 *  我的ID
 */
@property (nonatomic, copy, nullable ) NSString  *managerId;
/**
 *  我的名字
 */
@property (nonatomic, copy, nullable ) NSString  *nick;
/**
 *  我的帐号
 */
@property (nonatomic, copy, nullable ) NSString  *account;
/**
 *  我的头像
 */
@property (nonatomic, copy, nullable ) NSString  *img;
/**
 *  我的微信ID
 */
@property (nonatomic, copy, nullable ) NSString  *wxID;

+ (nonnull ZKUserInfo*)sharedUserInfo;

+ (void)saveAccount:(nullable ZKUserInfo *)account;


@end
