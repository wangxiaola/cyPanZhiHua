//
//  ZKScenicFoodTableViewCell.h
//  cyPZH
//
//  Created by 王小腊 on 16/6/15.
//  Copyright © 2016年 王小腊. All rights reserved.
//

extern NSString *const ZKScenicFoodTableViewCellID;
#import <UIKit/UIKit.h>
@class RatingBar,ZKScenicListMode;

@interface ZKScenicFoodTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *tjImageView;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet RatingBar *rating;
@property (weak, nonatomic) IBOutlet UILabel *piceLabel;
@property (weak, nonatomic) IBOutlet UILabel *adderLabel;
@property (weak, nonatomic) IBOutlet UILabel *juliLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (strong, nonatomic) ZKScenicListMode *list;
@end
