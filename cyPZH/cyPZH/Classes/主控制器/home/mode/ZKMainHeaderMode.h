//
//  ZKMainHeaderMode.h
//  cyPZH
//
//  Created by 王小腊 on 16/6/14.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZKMainProduct,ZKMainFocus,ZKMainApply,ZKMainTopic,ZKMainLink;
@interface ZKMainHeaderMode : NSObject


@property (nonatomic, assign) NSInteger shopid;
//产品
@property (nonatomic, strong) NSArray *product;

@property (nonatomic, copy) NSString *area;
//中心
@property (nonatomic, strong) NSArray *focus;

@property (nonatomic, strong) NSArray *apply;

@property (nonatomic, copy) NSString *code;
//主题
@property (nonatomic, strong) NSArray *topic;

@property (nonatomic, strong) NSArray *link;

@property (nonatomic, copy) NSString *name;

@end

@interface ZKMainProduct : NSObject

@property (nonatomic, copy) NSString *img;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *url;

@end

@interface ZKMainFocus : NSObject

@property (nonatomic, copy) NSString *img;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *url;

@end

@interface ZKMainApply : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *name;

@end

@interface ZKMainTopic : NSObject

@property (nonatomic, copy) NSString *img;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *url;

@end

@interface ZKMainLink : NSObject

@property (nonatomic, copy) NSString *img;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *url;

@end


