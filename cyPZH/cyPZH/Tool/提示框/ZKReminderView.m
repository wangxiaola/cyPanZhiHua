//
//  ZKReminderView.m
//  cyPZH
//
//  Created by 王小腊 on 16/6/17.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import "ZKReminderView.h"
static float contentWidth = 270;

@implementation ZKReminderView
{
    
    UIView *contentView;
    
}
-(instancetype)initInfor:(NSString*)sting;
{
    
    self =[super initWithFrame:[APPDELEGATE window].bounds];
    if (self) {
        
        float strHeight = [ZKUtil contentLabelSize:CGSizeMake(contentWidth-20, 200) labelFont:14 labelText:sting].height;
        
        float contentHeight = 110+strHeight+20;
        
        UIButton *hideButton = [[UIButton alloc] initWithFrame:self.bounds];
        hideButton.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        //        [hideButton addTarget:self action:@selector(hideButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:hideButton];
        
        contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, contentWidth, contentHeight)];
        contentView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        contentView.backgroundColor = [UIColor whiteColor];
        contentView.layer.cornerRadius = 5;
        [self addSubview:contentView];
        
        UILabel *reminderLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, contentWidth, 60)];
        reminderLabel.backgroundColor =[UIColor clearColor];
        reminderLabel.text =@"  温馨提示";
        reminderLabel.textColor =CYBColorGreen;
        reminderLabel.font =[UIFont systemFontOfSize:18];
        [contentView addSubview:reminderLabel];
        
        UIView *inview =[[UIView alloc]initWithFrame:CGRectMake(3, 59, contentView.frame.size.width -6, 1)];
        inview.backgroundColor =CYBColorGreen;
        [contentView addSubview:inview];
        
        UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(10, 70,contentView.frame.size.width -20, strHeight)];
        label.text =sting;
        label. numberOfLines =2;
        label.textColor =[UIColor grayColor];
        label.font =[UIFont systemFontOfSize:14];
        [contentView addSubview:label];
        
        UIView *viewH =[[UIView alloc]initWithFrame:CGRectMake(3,  contentHeight - 50, contentView.frame.size.width - 6,1)];
        viewH.backgroundColor =[UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1];
        [contentView addSubview:viewH];
        
        UIView *viewZ =[[UIView alloc]initWithFrame:CGRectMake(contentView.frame.size.width/2, contentHeight - 50, 1, 50)];
        viewZ.backgroundColor =[UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1];
        [contentView addSubview:viewZ];
        
        UIButton *confirmButton =[[UIButton alloc]initWithFrame:CGRectMake(contentWidth/2, contentHeight - 50, contentWidth/2, 50)];
        confirmButton .backgroundColor =[UIColor clearColor];
        [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        confirmButton.titleLabel.font =[UIFont systemFontOfSize:15];
        [confirmButton addTarget:self action:@selector(didSelect) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:confirmButton];
        
        UIButton *abrogateButton =[[UIButton alloc]initWithFrame:CGRectMake(0, contentHeight - 50, contentWidth/2, 50)];
        abrogateButton .backgroundColor =[UIColor clearColor];
        [abrogateButton setTitle:@"取消" forState:UIControlStateNormal];
        [abrogateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        abrogateButton.titleLabel.font =[UIFont systemFontOfSize:15];
        [abrogateButton addTarget:self action:@selector(hideButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:abrogateButton];
        
        
    }
    
    return self;
    
}

-(void)show;
{
    self.alpha = 1;
    [[APPDELEGATE window] addSubview:self];
    contentView.transform = CGAffineTransformMakeScale(0, 0);
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        contentView.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            contentView.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL finished) {
            
        }];
    }];
    
}

-(void)didSelect{
    
    if ([self.delegate respondsToSelector:@selector(reminderClick:)]) {
        [self.delegate reminderClick:YES];
    }
    
    [self dismmView];
}
-(void)hideButtonClick{
    
    if ([self.delegate respondsToSelector:@selector(reminderClick:)]) {
        [self.delegate reminderClick:NO];
    }
    
    [self dismmView];
}
/**
 *  消失
 */
- (void)dismmView
{
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
    
}
@end
