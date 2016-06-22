//
//  ZKMainPlayInforTableViewCell.h
//  cyPZH
//
//  Created by 王小腊 on 16/6/21.
//  Copyright © 2016年 王小腊. All rights reserved.
//

extern NSString *const ZKMainPlayInforTableViewCellID;

#import <UIKit/UIKit.h>
@class ZKMainSceneryMode;

@interface ZKMainPlayInforTableViewCell : UITableViewCell

@property (nonatomic, strong) ZKMainSceneryMode *sceneryList;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *popView;

@property (weak, nonatomic) IBOutlet UITextView *infoTextView;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *numberButton;
@property (weak, nonatomic) IBOutlet UIImageView *backImageViw;

@property (weak, nonatomic)id controller;

//修改头部数子
- (void)updataLick:(NSInteger)lick number:(NSString*)num;

@end
