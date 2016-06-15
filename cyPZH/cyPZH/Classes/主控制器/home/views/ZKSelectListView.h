//
//  ZKSelectListView.h
//  CYmiangzhu
//
//  Created by 王小腊 on 16/5/18.
//  Copyright © 2016年 WangXiaoLa. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZKSelectListViewDelegate <NSObject>
@optional
/**
 *  搜索
 *
 *  @param key 值
 */
- (void)seekName:(NSString*)key;


@end
@interface ZKSelectListView : UIView<UISearchBarDelegate>
/**
 *  选择view
 *
 *  @param frame
 *  @param type   类型
 *
 *  @return view
 */
- (instancetype)initWithFrame:(CGRect)frame sceneryType:(NSInteger)dex;
@property (nonatomic, weak) id <ZKSelectListViewDelegate>delegate;


@end
