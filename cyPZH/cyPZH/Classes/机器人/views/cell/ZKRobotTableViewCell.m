//
//  ZKRobotTableViewCell.m
//  cyPZH
//
//  Created by 王小腊 on 16/6/7.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import "ZKRobotTableViewCell.h"
#import "ZKRobotMode.h"
#import "UIImage+CircleImage.h"

@implementation ZKRobotTableViewCell

{

    UIImageView *backImageView;
    
    UILabel *infoLabel;
    
    UIImageView *portraitImageView;
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        //1.添加子控件
        [self setupUI];
        
    }
    return self;
}

- (void)setupUI
{

    portraitImageView = [[UIImageView alloc] init];
    [self addSubview:portraitImageView];
    
    backImageView = [[UIImageView alloc] init];
    backImageView.backgroundColor = [UIColor clearColor];
    UIImage *image = [UIImage imageNamed:@"input"];
    backImageView.image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.8];
    [self addSubview:backImageView];
    

    infoLabel = [[UILabel alloc] init];
    infoLabel.numberOfLines = 0;
    infoLabel.textColor = [UIColor blackColor];
    infoLabel.font = [UIFont systemFontOfSize:14];
    infoLabel.textAlignment = NSTextAlignmentLeft;
    [backImageView addSubview:infoLabel];
    
    [portraitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.height.mas_equalTo(40);
        make.top.mas_equalTo(14);
        make.left.mas_equalTo(self.mas_left).offset(12);
        
    }];
    
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(portraitImageView.mas_right).offset(12);
        make.top.mas_equalTo(14);
        make.left.mas_greaterThanOrEqualTo(12);
    }];
    
    [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(backImageView.mas_left).offset(12);
        make.right.mas_lessThanOrEqualTo(self.mas_right).offset(-24);
        make.right.mas_equalTo(backImageView.mas_right).offset(-12);
        make.top.mas_equalTo(backImageView.mas_top).offset(6);
        make.bottom.mas_equalTo(backImageView.mas_bottom).offset(-6);
    }];

}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
}


- (void)setList:(ZKRobotMode *)list
{

    infoLabel.text = list.info;
    
    portraitImageView.image = [list.potoImage circleImage];

    

}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
