//
//  ZKRobotTallyView.h
//  cyPZH
//
//  Created by 王小腊 on 16/6/6.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBSphereView.h"

@protocol ZKRobotTallyViewDelegate <NSObject>
@optional
/**
 *  点击选中谁
 *
 *  @param key
 */
- (void)selectTitel:(NSString*)key;

@end
/**
 *  标签流
 */
@interface ZKRobotTallyView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, retain) DBSphereView *sphereView;

- (instancetype)initWithFrame:(CGRect)frame;

@property (nonatomic, weak) id<ZKRobotTallyViewDelegate>tallyDelegate;
@end
