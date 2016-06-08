//
//  ZKRobotMode.h
//  cyPZH
//
//  Created by 王小腊 on 16/6/6.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZKRobotMode : NSObject

@property (nonatomic, strong) UIImage *potoImage;

@property (nonatomic, strong) NSString *info;
/**
 *  0是Robot，1是my 3是坑
 */
@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) CGSize size;

@property (nonatomic, copy) NSDictionary *rootList;



@end








