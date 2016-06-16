//
//  ZKScenicStrategyTableViewCell.h
//  cyPZH
//
//  Created by 王小腊 on 16/6/16.
//  Copyright © 2016年 王小腊. All rights reserved.
//
extern NSString *const ZKScenicStrategyTableViewCellID;

#import <UIKit/UIKit.h>
@class ZKScenicStrategyMode;
@interface ZKScenicStrategyTableViewCell : UITableViewCell

@property (nonatomic, strong) ZKScenicStrategyMode *list;
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *sateLabel;
@property (weak, nonatomic) IBOutlet UILabel *makeLabel;
@property (weak, nonatomic) IBOutlet UIButton *lavoerButton;
@property (weak, nonatomic) IBOutlet UIButton *scButton;
@property (weak, nonatomic) IBOutlet UIButton *lookButton;
@property (weak, nonatomic) IBOutlet UIButton *dateButton;

@end
