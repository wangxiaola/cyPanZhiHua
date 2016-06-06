//
//  ZKCache.m
//  cyPZH
//
//  Created by 小腊 on 16/6/5.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import "ZKCache.h"

@implementation ZKCache

static ZKCache *_instance = nil;


+ (instancetype) shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init];

        
    }) ;
    
    return _instance ;
}


+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [ZKCache shareInstance] ;
}

- (instancetype)copyWithZone:(struct _NSZone *)zone
{
    return [ZKCache shareInstance] ;
}

@end
