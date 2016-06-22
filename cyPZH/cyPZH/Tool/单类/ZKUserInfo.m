//
//  ZKUserInfo.m
//  cyPZH
//
//  Created by 王小腊 on 16/6/22.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import "ZKUserInfo.h"

@implementation ZKUserInfo

MJCodingImplementation
+ (nonnull ZKUserInfo*)sharedUserInfo;
{
    
    ZKUserInfo *userInfor = [NSKeyedUnarchiver unarchiveObjectWithFile:[kDocumentPath stringByAppendingPathComponent:@"ZKAccount.data"]];
    
    return userInfor ? : [[ZKUserInfo alloc] init];
}
+ (void)saveAccount:(nullable ZKUserInfo *)account;
{
    
    [NSKeyedArchiver archiveRootObject:account ? : [[ZKUserInfo alloc] init] toFile:[kDocumentPath stringByAppendingPathComponent:@"ZKAccount.data"]];
    
}

@end
