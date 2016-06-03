//
//  ZFUserInfo.m
//  slyjg
//
//  Created by 王小腊 on 16/5/31.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import "ZFUserInfo.h"

@implementation ZFUserInfo
MJCodingImplementation
+ (nonnull ZFUserInfo*)sharedUserInfo;
{
    
    ZFUserInfo *userInfor = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"DYAccount.data"]];
    
    return userInfor ? : [[ZFUserInfo alloc] init];
}
+ (void)saveAccount:(nullable ZFUserInfo *)account;
{
    
    [NSKeyedArchiver archiveRootObject:account ? : [[ZFUserInfo alloc] init] toFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"DYAccount.data"]];
    
}
@end
