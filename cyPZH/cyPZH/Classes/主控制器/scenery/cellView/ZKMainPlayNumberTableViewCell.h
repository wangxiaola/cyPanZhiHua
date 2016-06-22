//
//  ZKMainPlayNumberTableViewCell.h
//  cyPZH
//
//  Created by 王小腊 on 16/6/20.
//  Copyright © 2016年 王小腊. All rights reserved.
//
extern NSString *const playNumberTableViewCellID;



#import <UIKit/UIKit.h>
@class ZKMainSceneryMode,ZKPlayMapButton;
@protocol ZKMainPlayNumberTableViewCellDelegate <NSObject>
@optional
/**
 *  选中哪个气泡
 *
 *  @param mode 数据
 *  @param row  第几个
 */
- (void)selectAnnotation:(ZKMainSceneryMode*)mode index:(NSInteger)row;
/**
 *  全景选中
 *
 *  @param mode
 */
- (void)panoramaData:(ZKMainSceneryMode*)mode;
/**
 *  分享选中
 *
 *  @param mode 
 */
- (void)shareData:(ZKMainSceneryMode*)mode;

@end

@interface ZKMainPlayNumberTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *peopleNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *dqPeopelNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *czNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *comfortLabel;
@property (weak, nonatomic) IBOutlet UILabel *TemperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *pmtView;
@property (weak, nonatomic) IBOutlet UIImageView *mapImageView;

@property (strong, nonatomic) NSMutableArray <ZKPlayMapButton*>*annonArray;
/**
 *  显示气泡
 *
 *  @param data 数据
 */
- (void)showAnnonViews:(NSArray<ZKMainSceneryMode*>*)data selct:(NSInteger)row;

@property (nonatomic, weak) id<ZKMainPlayNumberTableViewCellDelegate>delegate;

@end
