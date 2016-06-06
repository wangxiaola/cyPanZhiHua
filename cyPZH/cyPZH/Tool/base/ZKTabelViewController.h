//
//  ZKTabelViewController.h
//  cyPZH
//
//  Created by 王小腊 on 16/6/6.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import "ZKBaseViewController.h"
@class ZKErrorView;
@interface ZKTabelViewController : ZKBaseViewController<UITableViewDataSource,UITableViewDelegate>

/**
 *  列表样式
 */
@property (nonatomic, assign) UITableViewStyle tableViewStyle;
/**
 *  列表
 */
@property (nonatomic, weak, readonly) UITableView *tableView;
/**
 *  无数据时显示的view,可在子类自定义
 */
@property (nonatomic, weak) ZKErrorView *promptView;

/**
 *  数据源数组
 */
@property (nonatomic, strong) NSMutableArray *models;
/**
 *  数据源数组所装模型的类型
 */
@property (nonatomic, strong) Class modelsType;

/**
 *  请求路径
 */
@property (nonatomic, copy) NSString *URLString;
/**
 *  请求参数
 */
@property (nonatomic, copy) NSMutableDictionary *params;
/**
 *  缓存文件名
 */
@property (nonatomic, copy) NSString *cacheFilename;

/**
 *  是否需要下拉刷新
 */
@property (nonatomic, assign, getter=isNeedsPullDownRefreshing) BOOL needsPullDownRefreshing;
/**
 *  是否需要上拉刷新
 */
@property (nonatomic, assign, getter=isNeedsPullUpRefreshing) BOOL needsPullUpRefreshing;

/**
 *  留给子类覆盖，在方法中应设置以上属性
 */
- (void)setupProperties NS_REQUIRES_SUPER;

/**
 *  每次拿到最新数据的时候调用，子类覆盖使用
 *
 *  @param responseObject 数据
 *  @param page           页数
 */
- (void)didGetResponse:(id)responseObject atPage:(NSInteger)page;
/**
 *  每次请求失败的时候调用，子类覆盖使用
 *
 *  @param error error
 */
- (void)didFailureRequest:(NSError *)error;

@end
