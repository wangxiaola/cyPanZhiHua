//
//  ZKRobotTallyView.m
//  cyPZH
//
//  Created by 王小腊 on 16/6/6.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import "ZKRobotTallyView.h"

@implementation ZKRobotTallyView

- (instancetype)initWithFrame:(CGRect)frame;
{
    self = [super initWithFrame:frame];
    
    if (self) {
      
        self.userInteractionEnabled = YES;
        
        
        UIView *is = [[UIView alloc] initWithFrame:frame];
        is.backgroundColor = [UIColor clearColor];
        [self addSubview:is];
    }
    
    return self;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
