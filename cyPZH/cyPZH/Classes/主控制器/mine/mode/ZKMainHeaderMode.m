//
//  ZKMainHeaderMode.m
//  cyPZH
//
//  Created by 王小腊 on 16/6/14.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import "ZKMainHeaderMode.h"

@implementation ZKMainHeaderMode
MJCodingImplementation

+ (NSDictionary *)objectClassInArray{
    return @{@"link":[ZKMainLink class], @"topic":[ZKMainTopic class], @"apply":[ZKMainApply class], @"focus":[ZKMainFocus class], @"product":[ZKMainProduct class]};
}

@end




@implementation ZKMainProduct
MJCodingImplementation
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"ID": @"id"};
}

@end

@implementation ZKMainFocus
MJCodingImplementation
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"ID": @"id"};
}

@end

@implementation ZKMainApply
MJCodingImplementation
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"ID": @"id"};
}


@end

@implementation ZKMainTopic
MJCodingImplementation
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"ID": @"id"};
}


@end

@implementation ZKMainLink
MJCodingImplementation
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"ID": @"id"};
}


@end
