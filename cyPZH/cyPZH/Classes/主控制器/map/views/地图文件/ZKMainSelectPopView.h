//
//  ZKMainSelectPopView.h
//  cyPZH
//
//  Created by 小腊 on 16/6/19.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZKMainMapMode;

@protocol ZKMainSelectPopViewDelegate <NSObject>
@optional
/**
 *  点击导航
 */
- (void)navMap:(ZKMainMapMode*)list;
/**
 *  点击详情
 */
- (void)navDetails:(ZKMainMapMode*)list;

@end

/**
 *  选中弹出框
 */
@interface ZKMainSelectPopView : UIView

- (instancetype)initWithFrame:(CGRect)frame;

//更新
- (void)updatePopView:(ZKMainMapMode*)list;

@property (nonatomic, weak)id<ZKMainSelectPopViewDelegate>delegate;

@end
