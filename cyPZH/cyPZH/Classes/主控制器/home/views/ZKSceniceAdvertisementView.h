//
//  ZKSceniceAdvertisementView.h
//  cyPZH
//
//  Created by 王小腊 on 16/6/16.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZKSceniceAdvertisementDelegate <NSObject>

- (void)sceleAdvertisement:(NSDictionary*)pic;

@end
@interface ZKSceniceAdvertisementView : UIView<UIScrollViewDelegate>

- (instancetype)initWithFrame:(CGRect)frame Data:(NSArray*)array;

@property(nonatomic, strong)UIScrollView  *scrollView;      //声明一个UIScrollView
@property(nonatomic, strong)UIPageControl *pageControl;     //声明一个UIPageControl
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, weak) id<ZKSceniceAdvertisementDelegate>delegate;

@end
