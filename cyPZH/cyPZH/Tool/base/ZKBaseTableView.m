//
//  ZKBaseTableView.m
//  语言Demo
//
//  Created by 王小腊 on 16/6/3.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import "ZKBaseTableView.h"

@implementation ZKBaseTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.autoresizingMask =  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.separatorColor = [UIColor clearColor];
        self.showsVerticalScrollIndicator = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.sectionHeaderHeight = 0;
        self.sectionFooterHeight = 0;
        self.backgroundColor = TabelBackCorl;
        self.tableFooterView = [[UIView alloc] init];
        self.isNeedPullDownToRefreshAction = NO;
        self.isNeedPullUpToRefreshAction = NO;
    }
    return self;
}



#pragma mark - 上拉加载和下拉刷新
- (void)setIsNeedPullDownToRefreshAction:(BOOL)isEnable {
    if (_isNeedPullDownToRefreshAction == isEnable) {
        return;
    }
    _isNeedPullDownToRefreshAction = isEnable;
    __block typeof(self) weakSelf = self;
    if (_isNeedPullDownToRefreshAction) {
        self.mj_header = [MJDIYHeader headerWithRefreshingBlock:^{
            if ([weakSelf.ZKPullDelegate respondsToSelector:@selector(pullDownToRefreshAction)]) {
                [weakSelf.ZKPullDelegate pullDownToRefreshAction];
            }
        }];
        
    }
}

- (void)setIsNeedPullUpToRefreshAction:(BOOL)isEnable
{
    if (_isNeedPullUpToRefreshAction == isEnable) {
        return;
    }
    _isNeedPullUpToRefreshAction = isEnable;
    __block typeof(self) weakSelf = self;
    if (_isNeedPullUpToRefreshAction) {
        self.mj_footer = [MJDIYBackFooter footerWithRefreshingBlock:^{
            if ([weakSelf.ZKPullDelegate respondsToSelector:@selector(pullUpToRefreshAction)]) {
                [weakSelf.ZKPullDelegate pullUpToRefreshAction];
            }
        }];
    }
}

- (void)stopRefreshingAnimation {
    
    if ([self.mj_header isRefreshing]) {
        [self.mj_header endRefreshing];
    }
    if ([self.mj_footer isRefreshing]) {
        [self.mj_footer endRefreshing];
    }
}

- (void)triggerRefreshing {
    [self.mj_header beginRefreshing];
}

@end
