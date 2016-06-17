//
//  ZKMainPlayMode.h
//  cyPZH
//
//  Created by 小腊 on 16/6/16.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZKPlayeColumnsMode,ZKPlayTypeMode;
@interface ZKMainPlayMode : NSObject

@property (nonatomic, strong) NSArray *columns;

@property (nonatomic, strong) NSArray *play;

@end

@interface ZKPlayeColumnsMode : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *img;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *stitle;

@end

@interface ZKPlayTypeMode : NSObject

@property (nonatomic, copy) NSString *img;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *url;

@end
