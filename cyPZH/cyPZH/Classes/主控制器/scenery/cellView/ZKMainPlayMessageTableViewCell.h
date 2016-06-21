//
//  ZKMainPlayMessageTableViewCell.h
//  cyPZH
//
//  Created by 王小腊 on 16/6/21.
//  Copyright © 2016年 王小腊. All rights reserved.
//

extern NSString *const PlayMessageTableViewCellID;

#import <UIKit/UIKit.h>
@class ZKPlayInforRoot;

@interface ZKMainPlayMessageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *potoImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *datelabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@property (nonatomic, strong) ZKPlayInforRoot *rootList;

@end
