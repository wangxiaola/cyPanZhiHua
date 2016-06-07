//
//  NSDictionary+FixedParams.m
//  slyjg
//
//  Created by 汤亮 on 16/5/16.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import "NSDictionary+FixedParams.h"

@implementation NSDictionary (FixedParams)

+ (instancetype)params
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"format"]    = @"json";
    params[@"AppId"]     = @"55eHah35hBee";
    params[@"AppKey"]    = @"28042b6d24d343dca5216d9f06295ba2";
    params[@"TimeStamp"] = [ZKUtil timeStamp];
    return params;
}

@end
