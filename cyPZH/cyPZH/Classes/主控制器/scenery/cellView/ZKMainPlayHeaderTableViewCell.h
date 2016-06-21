//
//  ZKMainPlayHeaderTableViewCell.h
//  cyPZH
//
//  Created by 王小腊 on 16/6/21.
//  Copyright © 2016年 王小腊. All rights reserved.
//

extern NSString *const PlayHeaderTableViewCellID;

#import <UIKit/UIKit.h>

@interface ZKMainPlayHeaderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
/**
 *  数量
 *
 *  @param num
 */
- (void)headerNumber:(NSInteger)num;
@end
