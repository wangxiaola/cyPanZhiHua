//
//  ZKRobotMode.h
//  cyPZH
//
//  Created by 王小腊 on 16/6/6.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZKRobotMode : NSObject

@property (nonatomic, strong) NSString *fotoImageUrl;

@property (nonatomic, strong) NSString *info;
/**
 *  0是Robot，1是my
 */
@property (nonatomic, assign) NSInteger type;

@end
