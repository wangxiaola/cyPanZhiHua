//
//  ZKRobotToolView.h
//  cyPZH
//
//  Created by 王小腊 on 16/6/7.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZKRobotToolViewDelegate <NSObject>

@optional
/**
 *  键盘输入
 *
 *  @param str 内容
 */
- (void)textFieldString:(NSString*)str;
/**
 *  声音输入状态
 *
 *  @param state yes开始 no结束
 */
- (void)voiceState:(BOOL)state;
/**
 *  技能状态
 *
 *  @param state yes打开 no关闭
 */
- (void)skillState:(BOOL)state;


@end

@interface ZKRobotToolView : UIView<UITextViewDelegate>


- (instancetype)initWithFrame:(CGRect)frame objec:(UIViewController*)controller;
/**
 *  消失技能
 */
- (void)dismmSkill;
@property (nonatomic,weak) id< ZKRobotToolViewDelegate >toolDelegate;

@end
