//
//  ZKMainPlayVideoView.h
//  cyPZH
//
//  Created by 王小腊 on 16/6/20.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZKMainSceneryMode;

@interface ZKMainPlayVideoView : UIView

- (instancetype)initWithFrame:(CGRect)frame;
/**
 *  更新视频
 *
 *  @param list 数据
 */
- (void)updateVideo:(ZKMainSceneryMode*)list;
/**
 *  销毁
 */
- (void)destroyVideo;

@end
