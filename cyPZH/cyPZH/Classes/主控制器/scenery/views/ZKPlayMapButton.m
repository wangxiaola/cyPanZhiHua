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
- (void)cjLabel
{
    nameLabel = [[UILabel alloc] init];
    nameLabel.textColor = [UIColor grayColor];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.font = [UIFont systemFontOfSize:10];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:nameLabel];

}
- (instancetype)initWithFrame:(CGRect)frame
{

    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self cjLabel];
    }
    
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        [self cjLabel];
        
    }
    return self;
}
- (void)setPopName:(NSString *)popName
{
    nameLabel.text = strIsNull(popName);
    float lableW = [ZKUtil contentLabelSize:CGSizeMake(300, 16) labelFont:10 labelText:popName].width;
    nameLabel.frame = CGRectMake(0, 0, lableW+2, 16);
    nameLabel.center = CGPointMake(self.frame.size.width/2, -8);
    
}
- (void)setLabelColor:(UIColor *)labelColor
{

    nameLabel.textColor = labelColor;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
