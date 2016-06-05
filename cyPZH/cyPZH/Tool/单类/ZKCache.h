//
//  ZKCache.h
//  cyPZH
//
//  Created by 小腊 on 16/6/5.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZKCache : NSObject

@property (nonatomic, strong) NSCache *cache; // 目前先用系统的缓存来代替

+ (instancetype)shareInstance;

/**
 *  取出缓存
 *
 *  @param key 标示符
 *
 *  @return 数据
 */
- (id)readForKey:(NSString*)key;

/**
 *  缓存策略
 *
 *  @param data       数据
 *  @param key 标示符
 *
 *  @return 是否存入
 */
- (void)write:(id)data forKey:(NSString*)key;

@end
