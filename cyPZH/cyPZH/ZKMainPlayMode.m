//
//  ZKMainPlayMode.m
//  cyPZH
//
//  Created by 小腊 on 16/6/16.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import "ZKMainPlayMode.h"

@implementation ZKMainPlayMode
MJCodingImplementation
+ (NSDictionary *)objectClassInArray{
    return @{@"play":[ZKPlayTypeMode class], @"columns":[ZKPlayeColumnsMode class]};
}

@end


@implementation ZKPlayeColumnsMode
MJCodingImplementation
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"ID": @"id"};
}
@end

@implementation ZKPlayTypeMode
MJCodingImplementation
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"ID": @"id"};
}
@end
