//
//  UserInfo.m
//  guide
//
//  Created by 汤亮 on 15/10/8.
//  Copyright © 2015年 daqsoft. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo
singleton_implementation(UserInfo)

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"};
}

- (void)saveUserInfo
{ 
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.ID       forKey:@"id"];

    [defaults setObject:self.name     forKey:@"name"];
    [defaults setObject:self.account forKey:@"account"];
    [defaults setObject:self.phone   forKey:@"phone"];
    [defaults setObject:self.state      forKey:@"state"];

    [defaults synchronize];

}

- (void)loadUserInfo
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    self.ID                  = [defaults objectForKey:@"id"];
    self.name                = [defaults objectForKey:@"name"];
    self.phone               = [defaults objectForKey:@"phone"];
    self.name                = [defaults objectForKey:@"name"];
    self.account = [defaults objectForKey:@"account"];
    
}

- (void)resetUserInfo
{
    self.ID          = nil;
    self.phone       = nil;
    self.name        = nil;
    self.state       = nil;
    self.account     = nil;

    
    [self saveUserInfo];
}


@end

