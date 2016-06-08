//
//  ZKRobotTallyTableViewCell.m
//  cyPZH
//
//  Created by 王小腊 on 16/6/8.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import "ZKRobotTallyTableViewCell.h"

@implementation ZKRobotTallyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
       
        self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame] ;
        self.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)layoutSubviews

{
    
    [super layoutSubviews];

    
    if ([super isSelected]) {
        
        //编辑时的需要的frame
        self.backgroundView.frame = CGRectMake(0, 0, 100, 30);
        self.textLabel.frame = CGRectMake(0, 0, 100, 30);
        
    }else {
        
        //取消编辑时的需要的frame
        self.backgroundView.frame = CGRectMake(10, 0, 100-10, 30);
        self.textLabel.frame = CGRectMake(10, 0, 100-10, 30);

    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
