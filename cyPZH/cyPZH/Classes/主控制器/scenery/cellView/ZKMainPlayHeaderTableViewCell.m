//
//  ZKMainPlayHeaderTableViewCell.m
//  cyPZH
//
//  Created by 王小腊 on 16/6/21.
//  Copyright © 2016年 王小腊. All rights reserved.
//

NSString *const PlayHeaderTableViewCellID = @"PlayHeaderTableViewCellID";
#import "ZKMainPlayHeaderTableViewCell.h"

@implementation ZKMainPlayHeaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)sendeClick {
    
    if ([self.delegate respondsToSelector:@selector(ClickOnMessage)]) {
        [self.delegate ClickOnMessage];
    }
    
}
- (void)headerNumber:(NSInteger)num;
{
    
    self.numberLabel.text = [NSString stringWithFormat:@"互动留言 (%ld条)",(long)num];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
