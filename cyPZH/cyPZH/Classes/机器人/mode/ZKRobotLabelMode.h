//
//  ZKRobotLabelMode.h
//  cyPZH
//
//  Created by 王小腊 on 16/6/8.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MinTagClass;
@interface ZKRobotLabelMode : NSObject

@property (nonatomic, copy) NSString *StatrTime;

@property (nonatomic, copy) NSString *UrlPath;

@property (nonatomic, strong) NSArray *MinTagClass;

@property (nonatomic, assign) NSInteger Key;

@property (nonatomic, assign) NSInteger Disable;

@property (nonatomic, copy) NSString *EndTime;

@property (nonatomic, copy) NSString *TagName;

@end



@interface MinTagClass : NSObject

@property (nonatomic, copy) NSString *StatrTime;

@property (nonatomic, copy) NSString *UrlPath;

@property (nonatomic, copy) NSString *MinTagClass;

@property (nonatomic, assign) NSInteger Key;

@property (nonatomic, assign) NSInteger Disable;

@property (nonatomic, copy) NSString *EndTime;

@property (nonatomic, copy) NSString *TagName;

@end
