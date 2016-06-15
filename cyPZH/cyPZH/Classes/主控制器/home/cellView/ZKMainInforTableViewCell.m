//
//  ZKMainInforTableViewCell.m
//  cyPZH
//
//  Created by 王小腊 on 16/6/14.
//  Copyright © 2016年 王小腊. All rights reserved.
//
NSString *const ZKMainInforTableViewCellID = @"ZKMainInforTableViewCellID";
#import "ZKMainInforTableViewCell.h"

@implementation ZKMainInforTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setIsTopic:(BOOL)isTopic
{
    
    NSString *topUrl = isTopic?@"home_icon_11":@"home_icon_12";
    NSString *centerUrl = isTopic?@"home_word":@"home_word_2";
    NSString *infor = isTopic?@"探索时尚花样玩法":@"推荐实惠超值产品";
    
    self.topImageView.image = [UIImage imageNamed:topUrl];
    self.centerImageView.image = [UIImage imageNamed:centerUrl];
    self.stateLabel.text = infor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
