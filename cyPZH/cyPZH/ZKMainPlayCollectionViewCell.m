//
//  ZKMainPlayCollectionViewCell.m
//  cyPZH
//
//  Created by 小腊 on 16/6/16.
//  Copyright © 2016年 王小腊. All rights reserved.
//

NSString * const reuseIdentifier = @"Cell";
#import "ZKMainPlayCollectionViewCell.h"
#import "ZKMainPlayMode.h"

@implementation ZKMainPlayCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setList:(ZKPlayeColumnsMode *)list
{

    NSString *const key = list.title;
    NSString *urlName = @"play_icon_5";
    
    if ([key isEqualToString:@"网络投票"])
    {
       urlName = @"play_icon_1";
    }
    else if ([key isEqualToString:@"约伴拼团"])
    {
    
        urlName = @"play_icon_2";
    }
    else if ([key isEqualToString:@"节会活动"])
    {
        
        urlName = @"play_icon_3";
    }

    else if ([key isEqualToString:@"每日签到"])
    {
        urlName = @"play_icon_4";
        
    }
    else if ([key isEqualToString:@"PK活动"])
    {
        urlName = @"play_icon_5";
        
    }
    else if ([key isEqualToString:@"有奖征集"])
    {
        
        urlName = @"play_icon_6";
    }

    else if ([key isEqualToString:@"体验招募"])
    {
        urlName = @"play_icon_7";
        
    }
    else if ([key isEqualToString:@"话题分享"])
    {
        urlName = @"play_icon_8";
        
    }

    else if ([key isEqualToString:@"优惠促进"])
    {
        
        urlName = @"play_icon_9";
    }

    else if ([key isEqualToString:@"TOP榜单"])
    {
        
        urlName = @"play_icon_10";
    }

    self.headerImageView.image = [UIImage imageNamed:urlName];
    self.titleLabel.text = list.title;
    self.stitleLabel.text = list.stitle;

}

@end
