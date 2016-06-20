//
//  ZKMainPlayNumberTableViewCell.h
//  cyPZH
//
//  Created by 王小腊 on 16/6/20.
//  Copyright © 2016年 王小腊. All rights reserved.
//
extern NSString *const playNumberTableViewCellID;

#import <UIKit/UIKit.h>
@class ZKMainSceneryMode;

@interface ZKMainPlayNumberTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *peopleNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *dqPeopelNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *czNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *comfortLabel;
@property (weak, nonatomic) IBOutlet UILabel *TemperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *pmtView;

@property (strong, nonatomic) ZKMainSceneryMode *list;

@end
