//
//  ZKMainInforTableViewCell.h
//  cyPZH
//
//  Created by 王小腊 on 16/6/14.
//  Copyright © 2016年 王小腊. All rights reserved.
//
extern NSString *const ZKMainInforTableViewCellID;
#import <UIKit/UIKit.h>

@interface ZKMainInforTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UIImageView *centerImageView;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;

@property (assign, nonatomic) BOOL isTopic;

@end
