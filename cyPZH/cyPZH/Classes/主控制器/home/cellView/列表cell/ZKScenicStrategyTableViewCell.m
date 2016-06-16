//
//  ZKScenicStrategyTableViewCell.m
//  cyPZH
//
//  Created by 王小腊 on 16/6/16.
//  Copyright © 2016年 王小腊. All rights reserved.
//
NSString *const ZKScenicStrategyTableViewCellID = @"ZKScenicStrategyTableViewCellID";

#import "ZKScenicStrategyTableViewCell.h"
#import "ZKScenicStrategyMode.h"

@implementation ZKScenicStrategyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setList:(ZKScenicStrategyMode *)list
{

    [ZKUtil UIimageView:_headerImage NSSting:[NSString stringWithFormat:@"%@%@",IMAGE_URL,list.img]];
    self.makeLabel.text = list.title;
    
    NSString *state = list.column;
    
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@",state,list.stitle]];
    NSRange redRange = NSMakeRange(0,state.length);
    [noteStr addAttribute:NSForegroundColorAttributeName value:CYBColorGreen range:redRange];
    self.sateLabel.attributedText = noteStr;
    
    [self.lavoerButton setTitle:[NSString stringWithFormat:@"%ld",(long)list.zan] forState:UIControlStateNormal];
    [self.scButton setTitle:[NSString stringWithFormat:@"%ld",(long)list.col] forState:UIControlStateNormal];
    [self.lookButton setTitle:[NSString stringWithFormat:@"%ld",(long)list.val] forState:UIControlStateNormal];
    [self.dateButton setTitle:[NSString stringWithFormat:@"%@  ",list.time] forState:UIControlStateNormal];


}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
