//
//  ZKMainPlayeRemindView.m
//  cyPZH
//
//  Created by 王小腊 on 16/6/20.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import "ZKMainPlayeRemindView.h"
static float contentWidth = 270;

@implementation ZKMainPlayeRemindView
{
    
    UIView *contentView;
    
}
-(instancetype)initInfor:(NSString*)sting;
{
    
    self =[super initWithFrame:[APPDELEGATE window].bounds];
    if (self) {
        
        UIImage *centerImage = [UIImage imageNamed:@"register_No-record_default"];
        float strHeight = [ZKUtil contentLabelSize:CGSizeMake(contentWidth-20, 200) labelFont:14 labelText:sting].height;
        
        float contentHeight = centerImage.size.height+60+strHeight;
        
        UIButton *hideButton = [[UIButton alloc] initWithFrame:self.bounds];
        hideButton.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        [hideButton addTarget:self action:@selector(hideButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:hideButton];
        
        contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, contentWidth, contentHeight)];
        contentView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        contentView.backgroundColor = [UIColor whiteColor];
        contentView.layer.cornerRadius = 5;
        [self addSubview:contentView];

        UIImageView *centerImageView = [[UIImageView alloc] initWithImage:centerImage];
        [contentView addSubview:centerImageView];
        [centerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(centerImage.size.height);
            make.left.mas_equalTo((contentWidth - centerImage.size.width)/2);
            make.top.mas_equalTo(contentView.mas_top).offset(20);
        }];
        
        UILabel *label =[[UILabel alloc]init];
        label.text =sting;
        label.backgroundColor = [UIColor whiteColor];
        label. numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor =[UIColor grayColor];
        label.font =[UIFont systemFontOfSize:14];
        [contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.mas_equalTo(contentView.mas_left).offset(10);
            make.width.mas_equalTo(contentWidth-20);
            make.top.mas_equalTo(centerImageView.mas_bottom).offset(20);

        }];

        int64_t delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            if (self)
            {
                [self dismmView];
            }
        });

        
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


-(void)hideButtonClick{
    

    
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
