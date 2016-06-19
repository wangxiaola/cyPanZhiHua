//
//  ZKMianMapView.h
//  cyPZH
//
//  Created by 王小腊 on 16/6/17.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZKMainMapMode;
/**
 *  地图显示
 */
@interface ZKMianMapView : UIView
/**
 *  销毁
 */
- (void)mapDestroy;
/**
 *  加载数据
 *
 *  @param dataArray 数据
 *  @param type      类型
 */
- (void)addAnnotations:(NSArray<ZKMainMapMode*>*)dataArray Type:(NSInteger)type;
// 更新数据
- (void)updataAddAnnotations:(NSArray<ZKMainMapMode*>*)dataArray Type:(NSInteger)type;
// 更新左标
- (void)mapUpdataMyLat:(float)lat myLon:(float)lon;

- (instancetype)initWithFrame:(CGRect)frame;

@end
