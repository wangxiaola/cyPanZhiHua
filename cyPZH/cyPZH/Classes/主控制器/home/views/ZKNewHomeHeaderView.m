//
//  ZKNewHomeHeaderView.m
//  CYmiangzhu
//
//  Created by 王小腊 on 16/5/11.
//  Copyright © 2016年 WangXiaoLa. All rights reserved.
//

#import "ZKNewHomeHeaderView.h"
#import "ZKMainHeaderMode.h"
#import "ZKBaseWebViewController.h"
#import "ZKScenicTableViewController.h"


@implementation ZKNewHomeHeaderView


@synthesize cycleScrollView;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self initSuperViews];
    }

    return self;
}

- (NSMutableArray *)imageUrlArray
{
    if (!_imageUrlArray) {
        
        _imageUrlArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _imageUrlArray;
}


- (void)initSuperViews

{
    self.backgroundColor = [UIColor whiteColor];
    // 网络加载 --- 创建带标题的图片轮播器
     cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.frame.size.width, 450/3) delegate:self placeholderImage:[UIImage imageNamed:@"daohuang_ default"]];
    cycleScrollView.autoScrollTimeInterval = 5;
    cycleScrollView.backgroundColor = TabelBackCorl;
    cycleScrollView.pageControlDotSize =CGSizeMake(4, 4);
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    cycleScrollView.currentPageDotColor = [UIColor orangeColor]; // 自定义分页控件小圆标颜色
    cycleScrollView.bannerImageViewContentMode =  UIViewContentModeScaleAspectFill;
    cycleScrollView.pageDotColor = [UIColor whiteColor];
    [self addSubview:cycleScrollView];
    

    self.toolScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,cycleScrollView.frame.size.height, _SCREEN_WIDTH, self.frame.size.height- cycleScrollView.frame.size.height - 10)];
    self.toolScrollView.delegate = self;
    self.toolScrollView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.toolScrollView];
    
    self.pageView = [[UIPageControl alloc] init];
    self.pageView.backgroundColor = [UIColor clearColor];
    self.pageView.numberOfPages = 0;
    self.pageView.currentPage   = 0;
    self.pageView.pageIndicatorTintColor = [UIColor grayColor];
    self.pageView.currentPageIndicatorTintColor = [UIColor orangeColor];
    [self addSubview:self.pageView];

    [self.pageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(12);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.bottom.mas_equalTo(-5);
    }];
}
- (void)setApplyList:(NSArray<ZKMainApply *> *)applyList
{
    _applyList = applyList;
    [self.toolScrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj.tag > 2999 && [obj isKindOfClass:[UIButton class]])
        {
            [obj removeFromSuperview];
        }
    }];
            
    self.toolScrollView.contentSize = CGSizeMake(_SCREEN_WIDTH*applyList.count/5+1, self.toolScrollView.frame.size.height);
    self.pageView.numberOfPages = applyList.count/5;
    self.pageView.currentPage    = 0;
    
    NSInteger button_w = 46;
    
    NSInteger jianxi   = (_SCREEN_WIDTH - button_w*5)/6;
    
    float  sJianXi   = (self.toolScrollView.frame.size.height - button_w)/2;
    for (int i = 0; i<applyList.count; i++) {
        
        ZKMainApply *list = applyList[i];
        
        UIButton *bty = [UIButton buttonWithType:UIButtonTypeCustom];
        [bty setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"home_icon_%d",i+1]] forState:UIControlStateNormal];
        bty.titleLabel.font = [UIFont systemFontOfSize:14];
        [bty setTitle:list.name forState:UIControlStateNormal];
        [bty setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        bty.tag = 3000+i;
        [bty addTarget:self action:@selector(btyClick:) forControlEvents:UIControlEventTouchUpInside];
        bty.frame = CGRectMake(jianxi+(jianxi+button_w)*(i%5), sJianXi, button_w, button_w);
        [self.toolScrollView addSubview:bty];
        
    }
    
}
- (void)setFocusList:(NSArray<ZKMainFocus *> *)focusList
{
    _focusList = focusList;
    [self.imageUrlArray removeAllObjects];
    
    [focusList enumerateObjectsUsingBlock:^(ZKMainFocus * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,obj.img]];
        
        [self.imageUrlArray addObject:url];
    }];

      cycleScrollView.imageURLStringsGroup = self.imageUrlArray;
    
}


- (void)btyClick:(UIButton*)sender
{
    NSInteger index = sender.tag - 3000;
    ZKMainApply *list = _applyList[index];
    
    ZKScenicTableViewController *scenicVc = [[ZKScenicTableViewController alloc] init];
    scenicVc.scenicType = index;
    scenicVc.applyList = list;
    [[self.controller navigationController] pushViewController:scenicVc animated:YES];

    

}
#pragma mark UIScrollViewDelegate

//减速结束   停止
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    int num = scrollView.contentOffset.x / _SCREEN_WIDTH ;
    self.pageView.currentPage = num;
    
}
#pragma mark SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index;
{


    ZKMainFocus *list = [_focusList objectAtIndex:index];
    
    ZKBaseWebViewController *web = [[ZKBaseWebViewController alloc]init];
    web.htmlUrl = list.url;
    [[self.controller navigationController] pushViewController:web animated:YES];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
