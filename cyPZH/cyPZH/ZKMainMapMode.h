//
//  ZKMainMapMode.h
//  cyPZH
//
//  Created by 小腊 on 16/6/19.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZKMainMapMode : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, assign) CGFloat juli;

@property (nonatomic, strong) NSString *audiopath;

@property (nonatomic, assign) CGFloat longitude;

@property (nonatomic, assign) CGFloat latitude;

@property (nonatomic, strong) NSString *type;

@property (nonatomic, assign) NSInteger tag;

@property (nonatomic, assign) NSInteger view;

@property (nonatomic, strong) NSString *summary;

@property (nonatomic, assign) NSInteger exponent;

@property (nonatomic, strong) NSString *price;

@property (nonatomic, strong) NSString *address;

@property (nonatomic, strong) NSString *logosmall;

@property (nonatomic, strong) NSString *praise;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign) NSInteger views;


@end
