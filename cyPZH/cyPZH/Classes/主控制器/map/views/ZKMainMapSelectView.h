//
//  ZKMainMapSelectView.h
//  cyPZH
//
//  Created by 王小腊 on 16/6/17.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKMainMapMode.h"

@protocol ZKMainMapSelectViewDelegate <NSObject>
@optional
/**
 *  返回的数据
 *
 *  @param list 数据
 *  @param type 类型
 */
- (void)updataSelectData:(NSArray<ZKMainMapMode*>*)list selectType:(NSInteger)type;

@end

@interface ZKMainMapSelectView : UIView


@property (nonatomic, weak) id<ZKMainMapSelectViewDelegate>delegate;

/**
 *  初始化地图单选
 *
 *  @param frame Fram
 *  @param type  当前选中哪个
 *
 *  @return view
 */
- (instancetype)initWithFrame:(CGRect)frame selectType:(NSInteger)type;
/**
 *  刷新数据
 */
- (void)selectViewUpdata;

// 更新左标
- (void)selecUpdataMyLat:(float)lat myLon:(float)lon;

@end
