//
//  ZKPlayMapButton.m
//  cyPZH
//
//  Created by 王小腊 on 16/6/20.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import "ZKPlayMapButton.h"

@implementation ZKPlayMapButton
{
    
    UILabel *nameLabel;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        nameLabel = [[UILabel alloc] init];
        nameLabel.textColor = [UIColor grayColor];
        nameLabel.font = [UIFont systemFontOfSize:12];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:nameLabel];
        
    }
    return self;
}
- (void)setPopName:(NSString *)popName
{
    nameLabel.text = strIsNull(popName);
    float lableW = [ZKUtil contentLabelSize:CGSizeMake(300, 16) labelFont:12 labelText:popName].width;
    nameLabel.frame = CGRectMake(0, 0, lableW+2, 16);
    nameLabel.center = CGPointMake(self.frame.size.width/2, -8);
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
