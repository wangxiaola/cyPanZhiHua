//
//  ZKMainPlayCollectionViewCell.h
//  cyPZH
//
//  Created by 小腊 on 16/6/16.
//  Copyright © 2016年 王小腊. All rights reserved.
//

extern NSString * const reuseIdentifier;

#import <UIKit/UIKit.h>
@class ZKPlayeColumnsMode;

@interface ZKMainPlayCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *stitleLabel;
@property (nonatomic, strong)ZKPlayeColumnsMode *list;

@end
