//
//  ZKScenicFoodTableViewCell.m
//  cyPZH
//
//  Created by 王小腊 on 16/6/15.
//  Copyright © 2016年 王小腊. All rights reserved.
//
NSString *const ZKScenicFoodTableViewCellID = @"ZKScenicFoodTableViewCellID";

#import "ZKScenicFoodTableViewCell.h"
#import "cyPZH-Swift.h"
#import "ZKScenicListMode.h"
#import "UIImage+CircleImage.h"

@implementation ZKScenicFoodTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _headerImageView.layer.cornerRadius = 3;
}
- (void)setList:(ZKScenicListMode *)list
{
    
    [ZKUtil UIimageView:_headerImageView NSSting:list.logosmall];
    _nameLabel.text = strIsNull(list.name);
    _piceLabel.text = [NSString stringWithFormat:@"%ld分",(long)list.exponent];
    _rating.rating = list.exponent;
    _adderLabel.text = strIsNull(list.address);
    
    _juliLabel.text = [NSString stringWithFormat:@"%.2fkm",list.juli/1000];
    
    self.QJImageView.hidden =  !strIsEmpty(list.address720);
    
    NSString * codeName = list.existproduct == 0?@"err":@"table_icon_booking";
    self.codeListImage.image = [UIImage imageNamed:codeName];
    
    if (strIsEmpty(list.recommend))
    {
        
        self.tjImageView.hidden = NO;
    }
    else
    {
        self.tjImageView.hidden = YES;
    }
    if (strIsEmpty(list.resourcelevelName)) {
        
        NSString *leve = [NSString stringWithFormat:@" %@ ",list.resourcelevelName];
        self.leveName.text = leve;
        self.leveName.layer.borderWidth = 0.5;
        self.leveName.layer.cornerRadius = 4;
        self.leveName.layer.borderColor = [UIColor orangeColor].CGColor;
    }
    if (strIsEmpty(list.price))
    {
        NSString *state = [NSString stringWithFormat:@"¥%@",list.price];
        
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ 起",state]];
        NSRange redRange = NSMakeRange(0,state.length);
        [noteStr addAttribute:NSForegroundColorAttributeName value:CYBColorGreen range:redRange];
        [noteStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:18.0] range:redRange];
        _priceLabel.attributedText = noteStr;
        
    }
    else
    {
        _priceLabel.attributedText = nil;
        
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
