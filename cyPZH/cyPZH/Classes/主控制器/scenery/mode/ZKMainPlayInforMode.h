//
//  ZKMainPlayInforMode.h
//  cyPZH
//
//  Created by 王小腊 on 16/6/21.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZKPlayInforRoot;
@interface ZKMainPlayInforMode : NSObject

@property (nonatomic, copy) NSString *number;

@property (nonatomic, assign) NSInteger score;

@property (nonatomic, strong) NSArray *root;

@property (nonatomic, assign) NSInteger total;

@end

@interface ZKPlayInforRoot : NSObject

@property (nonatomic, copy) NSString *img;

@property (nonatomic, copy) NSString *nick;

@property (nonatomic, copy) NSString *info;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, assign) NSInteger star;

@end
