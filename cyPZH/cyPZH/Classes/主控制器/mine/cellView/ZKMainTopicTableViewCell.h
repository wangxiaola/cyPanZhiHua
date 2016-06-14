//
//  ZKMainTopicTableViewCell.h
//  cyPZH
//
//  Created by 王小腊 on 16/6/14.
//  Copyright © 2016年 王小腊. All rights reserved.
//

extern NSString *const ZKMainTopicTableViewCellID;

#import <UIKit/UIKit.h>
@class ZKMainLink;
/**
 *  广告
 */
@interface ZKMainTopicTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *lefButton;
@property (weak, nonatomic) IBOutlet UIButton *topButton;
@property (weak, nonatomic) IBOutlet UIButton *botmLefButton;
@property (weak, nonatomic) IBOutlet UIButton *botmRitButton;

@property (nonatomic, strong) NSArray<ZKMainLink*> *linkList;

@end
