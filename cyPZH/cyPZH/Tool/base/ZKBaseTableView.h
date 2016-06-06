//
//  ZKBaseTableView.h
//  语言Demo
//
//  Created by 王小腊 on 16/6/3.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZKTableViewPullDelegate<UITableViewDelegate>

@optional
/**
 *  下拉刷新触发的方法
 */
- (void)pullDownToRefreshAction;

/**
 *  上拉加载触发的方法
 */
- (void)pullUpToRefreshAction;


@end

@interface ZKBaseTableView : UITableView

@property (nonatomic, assign) id<ZKTableViewPullDelegate> ZKPullDelegate;

// 是否需要下拉刷新和上拉加载
@property (nonatomic, assign) BOOL isNeedPullDownToRefreshAction;

@property (nonatomic, assign) BOOL isNeedPullUpToRefreshAction;

- (void)stopRefreshingAnimation;
- (void)triggerRefreshing;
@end
