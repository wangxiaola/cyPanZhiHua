//
//  ZKMianMapView.h
//  cyPZH
//
//  Created by 王小腊 on 16/6/17.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZKScenicListMode;
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
- (void)addAnnotations:(NSArray<ZKScenicListMode*>*)dataArray Type:(NSInteger)type;

- (instancetype)initWithFrame:(CGRect)frame;

@end
