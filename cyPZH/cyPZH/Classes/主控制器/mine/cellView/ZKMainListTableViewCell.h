//
//  ZKMainListTableViewCell.h
//  cyPZH
//
//  Created by 王小腊 on 16/6/14.
//  Copyright © 2016年 王小腊. All rights reserved.
//
extern NSString *const ZKMainListTableViewCellID;
#import <UIKit/UIKit.h>
@class ZKMainTopic,ZKMainProduct;

@interface ZKMainListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;

@property (nonatomic, strong) ZKMainProduct *productList;

@property (nonatomic, strong) ZKMainTopic *topicList;

@end
