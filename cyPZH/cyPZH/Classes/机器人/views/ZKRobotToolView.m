//
//  ZKRobotToolView.m
//  cyPZH
//
//  Created by 王小腊 on 16/6/7.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import "ZKRobotToolView.h"

static NSString * ling = @"输入您想问的内容...";

@implementation ZKRobotToolView
{
    
    UIImageView *backImageView;//黑色背景
    
    UIButton *cancelButton;//取消按钮
    
    UIView *popView; //弹出框
    
    UIView *voiceImage;//语音
    
    UIButton *textButton;//键盘
    
    UIButton *skillButton;//技能
    
    UIImageView *rotateImageView;//旋转
    
    UITextView  *infoTextView;
    
    float animationDate;
}

- (instancetype)initWithFrame:(CGRect)frame objec:(UIViewController*)controller;
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.userInteractionEnabled = YES;
        
        float navheghit = 60;
        animationDate = 0.4;
        
        backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64,controller.view.frame.size.width,controller.view.frame.size.height - 64 - 60)];
        backImageView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
        backImageView.hidden = YES;
        backImageView.userInteractionEnabled = YES;
        [controller.view insertSubview:backImageView atIndex:150];
        
        popView = [[UIView alloc] initWithFrame:CGRectMake(30, 60, backImageView.frame.size.width - 60, 220)];
        popView.backgroundColor = [UIColor whiteColor];
        popView.layer.cornerRadius = 4;
        [backImageView addSubview:popView];
        ;
        
        
        infoTextView =[[UITextView alloc]initWithFrame:CGRectMake(10, 10, backImageView.frame.size.width - 80, 220-70)];
        infoTextView.textColor = [UIColor grayColor];//设置textview里面的字体颜色
        infoTextView.font = [UIFont fontWithName:@"Arial" size:13.0];//设置字体名字和字体大小
        infoTextView.delegate = self;//设置它的委托方法
        infoTextView.backgroundColor = [UIColor whiteColor];//设置它的背景颜色
        infoTextView.text = ling;//设置它显示的内容
        infoTextView.returnKeyType = UIReturnKeyDone;//返回键的类型
        infoTextView.keyboardType = UIKeyboardTypeDefault;//键盘类型
        infoTextView.layer.borderColor = TabelBackCorl.CGColor;
        infoTextView.layer.borderWidth = 0.5;
        infoTextView.scrollEnabled = YES;//是否可以拖动
        //    infoTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight;自适应高度
        [popView addSubview: infoTextView];//加入到整个页面中
        
        UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        confirmButton.backgroundColor = CYBColorGreen;
        confirmButton.layer.cornerRadius = 17.5;
        [confirmButton setTitle:@"确认提交" forState:UIControlStateNormal];
        [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        confirmButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [confirmButton addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
        confirmButton.frame = CGRectMake((popView.frame.size.width - 160)/2, 220-35-16, 160, 35);
        [popView addSubview:confirmButton];
        
        
        cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton.backgroundColor = [UIColor clearColor];
        [cancelButton setImage:[UIImage imageNamed:@"icon-close-pre"] forState:UIControlStateHighlighted];
        [cancelButton setImage:[UIImage imageNamed:@"icon-close"] forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
        [backImageView addSubview:cancelButton];
        
        [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(60);
            make.bottom.mas_equalTo(popView.mas_top).offset(10);
            make.right.mas_equalTo(popView.mas_right).offset(0);
            
        }];
        
        
        
        UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - navheghit, frame.size.width, navheghit)];
        navView.backgroundColor = [UIColor whiteColor];
        [self addSubview:navView];
        
        //        icon-jianpan-pre
        textButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [textButton setTitle:@"键盘" forState:UIControlStateNormal];
        textButton.titleLabel.font = [UIFont systemFontOfSize:14];
        textButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        [textButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [textButton setImage:[UIImage imageNamed:@"icon-jianpan"] forState:UIControlStateNormal];
        [textButton addTarget:self action:@selector(textClick:) forControlEvents:UIControlEventTouchUpInside];
        textButton.selected = NO;
        [navView addSubview:textButton];
        
        float jianju = (frame.size.width-70 - 160)/4;
        
        [textButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(45);
            make.centerY.mas_equalTo(navView.mas_centerY);
            make.left.mas_equalTo(navView.mas_left).offset(jianju);
            
        }];
        
        //        icon-question-pre
        skillButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [skillButton setTitle:@"技能" forState:UIControlStateNormal];
        skillButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [skillButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        skillButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        [skillButton setImage:[UIImage imageNamed:@"icon-question"] forState:UIControlStateNormal];
        [skillButton addTarget:self action:@selector(skillClick:) forControlEvents:UIControlEventTouchUpInside];
        skillButton.selected = NO;
        [navView addSubview:skillButton];
        
        [skillButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(45);
            make.centerY.mas_equalTo(navView.mas_centerY);
            make.right.mas_equalTo(navView.mas_right).offset(-jianju);
            
        }];
        
        
        voiceImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-Microphone-bg"]];
        voiceImage.backgroundColor = [UIColor clearColor];
        [navView addSubview:voiceImage];
        voiceImage.userInteractionEnabled = YES;
        [voiceImage mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(70);
            make.centerX.mas_equalTo(navView.mas_centerX);
            make.bottom.mas_equalTo(navView.mas_bottom).offset(-10);
            
        }];
        
        UILongPressGestureRecognizer * longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressToDo:)];
        longPressGr.minimumPressDuration = 0.3;
        [voiceImage addGestureRecognizer:longPressGr];
        
        rotateImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-Microphone-pre"]];
        rotateImageView.userInteractionEnabled = YES;
        rotateImageView.hidden = YES;
        rotateImageView.backgroundColor = [UIColor clearColor];
        [voiceImage addSubview:rotateImageView];
        rotateImageView.frame = CGRectMake(0, 0, 70, 70);
        
        //添加动画
        CABasicAnimation *monkeyAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        monkeyAnimation.toValue = [NSNumber numberWithFloat:2.0 *M_PI];
        monkeyAnimation.duration = 1.5f;
        monkeyAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        monkeyAnimation.cumulative = NO;
        monkeyAnimation.removedOnCompletion = NO; //No Remove
        
        monkeyAnimation.repeatCount = FLT_MAX;
        [rotateImageView.layer addAnimation:monkeyAnimation forKey:@"AnimatedKey"];
        [self stopAnimate];
        
        
        
    }
    
    return self;
    
}

#pragma mark 点击事件
//取消
- (void)cancelClick
{
    infoTextView.text = ling;
    [infoTextView resignFirstResponder];
    [self stateTextButton:textButton.selected];
    
}
//键盘
- (void)textClick:(UIButton*)sengder
{
    
    [self stateTextButton:sengder.selected];
    
    
    //判断技能是否高亮
    if (skillButton.selected == YES)
    {
        
        [self stateSkillButton:skillButton.selected];
        
    }
    
    
}
//技能
- (void)skillClick:(UIButton*)sengder
{
    
    [self stateSkillButton:sengder.selected];
    
    // 判断键盘是否高粱
    if (textButton.selected == YES) {
        
        [self stateTextButton:textButton.selected];
        
    }
    
}

// 确认提交
- (void)confirmClick
{

    [infoTextView resignFirstResponder];
    [self stateTextButton:textButton.selected];
    
    if (![infoTextView.text isEqualToString:ling]&&infoTextView.text.length>0) {
        
        if ([self.toolDelegate respondsToSelector:@selector(textFieldString:)]) {
            [self.toolDelegate textFieldString:infoTextView.text];
        }
    }
    
    infoTextView.text = ling;
}

- (void)stateTextButton:(BOOL)state
{
    
    if (state == NO)
    {
        [UIView animateWithDuration:animationDate animations:^{
            
            // 开启键盘
            textButton.selected = YES;
            [textButton setImage:[UIImage imageNamed:@"icon-jianpan-pre"] forState:UIControlStateNormal];
            [textButton setTitleColor:CYBColorGreen forState:UIControlStateNormal];
            backImageView.hidden = NO;
        }];
        
    }
    else
    {
        
        [UIView animateWithDuration:animationDate animations:^{
            
            backImageView.hidden = YES;
            textButton.selected = NO;
            [textButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [textButton setImage:[UIImage imageNamed:@"icon-jianpan"] forState:UIControlStateNormal];
            
        }];
        
        
    }
    
    
}

- (void)stateSkillButton:(BOOL)state
{
    
    if (state == NO)
    {
        // 打开技能
        [UIView animateWithDuration:animationDate animations:^{
            
            skillButton.selected = YES;
            [skillButton setTitleColor:CYBColorGreen forState:UIControlStateNormal];
            [skillButton setImage:[UIImage imageNamed:@"icon-question-pre"] forState:UIControlStateNormal];
            
        }];
        
        
        if ([self.toolDelegate respondsToSelector:@selector(skillState:)])
        {
            [self.toolDelegate skillState:YES];
        }
    }
    else
    {
        [UIView animateWithDuration:animationDate animations:^{
            
            skillButton.selected = NO;
            [skillButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [skillButton setImage:[UIImage imageNamed:@"icon-question"] forState:UIControlStateNormal];
        }];
        
        
        if ([self.toolDelegate respondsToSelector:@selector(skillState:)])
        {
            [self.toolDelegate skillState:NO];
        }
        
    }
    
    
    
}

//开始动画
- (void)startAnimate{
    
    rotateImageView.hidden = NO;
    rotateImageView.layer.speed = 1.0;
    rotateImageView.layer.beginTime = 0.0;
    CFTimeInterval pausedTime = [rotateImageView.layer timeOffset];
    CFTimeInterval timeSincePause = [rotateImageView.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    rotateImageView.layer.beginTime = timeSincePause;
    
    
    
}
//停止动画
- (void)stopAnimate {
    
    rotateImageView.hidden = YES;
    CFTimeInterval pausedTime = [rotateImageView.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    rotateImageView.layer.speed = 0.0;
    rotateImageView.layer.timeOffset = pausedTime;
    
    
}


#pragma mark 手势

-(void)longPressToDo:(UILongPressGestureRecognizer *)gesture
{
    if(gesture.state == UIGestureRecognizerStateBegan)
    {
        skillButton.selected = YES;
        textButton.selected  = YES;
        [self stateSkillButton:skillButton.selected];
        [self stateTextButton:textButton.selected];
        
        if ([self.toolDelegate respondsToSelector:@selector(voiceState:)])
        {
            [self.toolDelegate voiceState:YES];
        }
        [self startAnimate];
    }
    else if (gesture.state == UIGestureRecognizerStateEnded)
    {
        if ([self.toolDelegate respondsToSelector:@selector(voiceState:)])
        {
            [self.toolDelegate voiceState:NO];
        }
        
        [self stopAnimate];
    }
}

#pragma mark   textView 代理

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}


/**
 *  开始编辑
 *
 */
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView;
{
    
    [UIView animateWithDuration:0.4 animations:^{
        
        popView.frame = CGRectMake(30, 10, backImageView.frame.size.width - 60, 220);
        
    }];
    
    if ([textView.text isEqualToString:ling]) {
        
        infoTextView.text = @"";
        
    }
    
    return YES;
    
}

/**
 *  结束编辑
 *
 */
- (BOOL)textViewShouldEndEditing:(UITextView *)textView;
{
    
    [textView resignFirstResponder];
    
    [UIView animateWithDuration:0.4 animations:^{
        
        popView.frame = CGRectMake(30, 60, backImageView.frame.size.width - 60, 220);
        
    }];
    
    if (textView.text.length == 0) {
        infoTextView.text = ling;
        
    }
    
    return YES;
    
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
