//
//  ZKMainPlayCollectionViewCell.h
//  cyPZH
//
//  Created by 小腊 on 16/6/16.
//  Copyright © 2016年 王小腊. All rights reserved.
//

extern NSString * const reuseIdentifier;

#import <UIKit/UIKit.h>
@class ZKMainPlayMode;

@interface ZKMainPlayCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong)ZKMainPlayMode *list;

@end
