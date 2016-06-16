//
//  ZKNewHomeHeaderView.h
//  CYmiangzhu
//
//  Created by 王小腊 on 16/5/11.
//  Copyright © 2016年 WangXiaoLa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"

@class ZKMainApply,ZKMainFocus;

@interface ZKNewHomeHeaderView : UIView<SDCycleScrollViewDelegate,UIScrollViewDelegate>

@property (nonatomic, weak) id controller;

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

@property (nonatomic, strong) NSMutableArray *imageUrlArray;

@property (nonatomic, strong) UIScrollView * toolScrollView;

@property (nonatomic, strong) UIPageControl *pageView;

@property (nonatomic, strong) NSArray <ZKMainApply *> *applyList;

@property (nonatomic, strong) NSArray <ZKMainFocus *> *focusList;

@end
