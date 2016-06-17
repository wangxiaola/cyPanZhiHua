//
//  ZKReminderView.h
//  cyPZH
//
//  Created by 王小腊 on 16/6/17.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZKReminderViewDelegate <NSObject>
/**
 *  点击状态
 *
 *  @param state yes 点击确认
 */
-(void)reminderClick:(BOOL)state;

@end
/**
 *  提示弹出框
 */
@interface ZKReminderView : UIView

@property(nonatomic,assign) id<ZKReminderViewDelegate>delegate;
/**
 *  显示试图
 */
-(void)show;

-(instancetype)initInfor:(NSString*)sting;

@end
