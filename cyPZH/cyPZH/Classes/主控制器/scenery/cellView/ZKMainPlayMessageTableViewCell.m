//
//  ZKMainPlayMessageTableViewCell.m
//  cyPZH
//
//  Created by 王小腊 on 16/6/21.
//  Copyright © 2016年 王小腊. All rights reserved.
//

NSString *const PlayMessageTableViewCellID = @"PlayMessageTableViewCellID";

#import "ZKMainPlayMessageTableViewCell.h"
#import "ZKMainPlayInforMode.h"

@implementation ZKMainPlayMessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.potoImageView.layer.cornerRadius = 32/2;
    // Initialization code
}
- (void)setRootList:(ZKPlayInforRoot *)rootList
{
    [ZKUtil UIimageView:self.potoImageView NSSting:rootList.img];
    self.nameLabel.text = rootList.nick;
    self.datelabel.text = rootList.time;
    self.infoLabel.text = strIsNull(rootList.info);

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
