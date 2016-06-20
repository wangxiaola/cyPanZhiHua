//
//  ZKMainPlayNumberTableViewCell.m
//  cyPZH
//
//  Created by 王小腊 on 16/6/20.
//  Copyright © 2016年 王小腊. All rights reserved.
//

NSString *const playNumberTableViewCellID = @"playNumberTableViewCellID";

#import "ZKMainPlayNumberTableViewCell.h"
#import "ZKMainSceneryMode.h"

@implementation ZKMainPlayNumberTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setList:(ZKMainSceneryMode *)list
{

    self.peopleNumberLabel.text = @"5";
    self.dqPeopelNumberLabel.text = [NSString stringWithFormat:@"%d",list.rtnumber];
    self.czNumberLabel.text = [NSString stringWithFormat:@"%d",list.frontmax];
    self.comfortLabel.text = strIsNull(list.yjd);
    self.TemperatureLabel.text = [NSString stringWithFormat:@"%@ ~ %@°C",list.t1,list.t2];
    self.nameLabel.text = strIsNull(list.name);
    
    [self.pmtView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.pmtView.clipsToBounds = YES;
    [self beginAnimationWithTitle:strIsNull(list.name)];
}

- (IBAction)sceneryClick {
    
    
}
- (IBAction)shareClick {
    
    
}

- (void)beginAnimationWithTitle:(NSString *)title
{
    
    NSString *extendedTitle = [NSString stringWithFormat:@"    %@    ", title];
    CGSize labelSize = [extendedTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:0 attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil].size;
    
    for (int i = 0; i < 2; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.text = extendedTitle;
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:15];
        label.frame = CGRectMake(i * labelSize.width, 0, labelSize.width, 30);
        [_pmtView addSubview:label];
        
        CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
        anim.toValue = @(-label.frame.size.width);
        anim.repeatCount = MAXFLOAT;
        anim.duration = title.length / 1.8;
        anim.fillMode = kCAFillModeForwards;
        anim.removedOnCompletion = NO;
        [label.layer addAnimation:anim forKey:nil];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
