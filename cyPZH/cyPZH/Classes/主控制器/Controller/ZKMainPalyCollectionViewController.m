//
//  ZKMainPalyCollectionViewController.m
//  cyPZH
//
//  Created by 王小腊 on 16/6/13.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import "ZKMainPalyCollectionViewController.h"
#import "SDCycleScrollView.h"
#import "ZKMainPlayCollectionViewCell.h"
#import "ZKMainPlayMode.h"

@interface ZKMainPalyCollectionViewController ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong)SDCycleScrollView *cycleScrollView;

@end

@implementation ZKMainPalyCollectionViewController


float const sdCycleHeghit = 440/3;

- (SDCycleScrollView *)cycleScrollView
{
    if (!_cycleScrollView) {
        
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 64, _SCREEN_WIDTH, sdCycleHeghit) delegate:self placeholderImage:[UIImage imageNamed:@"daohuang_ default"]];
        _cycleScrollView.autoScrollTimeInterval = 5;
        _cycleScrollView.backgroundColor = TabelBackCorl;
        _cycleScrollView.pageControlDotSize =CGSizeMake(4, 4);
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _cycleScrollView.currentPageDotColor = [UIColor orangeColor]; // 自定义分页控件小圆标颜色
        _cycleScrollView.bannerImageViewContentMode =  UIViewContentModeScaleAspectFill;
        _cycleScrollView.pageDotColor = [UIColor whiteColor];
    }
    
    return _cycleScrollView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initSuperviews];
    [self postData];
    
}
#pragma mark 数据请求
- (void)postData
{

    NSMutableDictionary *dic = [NSMutableDictionary params];
    dic[@"id"] = @"28";
    dic[@"type"] = @"play";
    dic[@"interfaceId"] = @"123";
    MJWeakSelf
    [ZKHttp postWithURLString:POST_ZK_URL parameters:dic success:^(id responseObject) {
        
        [weakSelf.collectionView.mj_header endRefreshing];
        MMLog(@"play = %@",responseObject);
        
    } failure:^(NSError *error) {
        
    }];
    

}

#pragma mark 视图布局
- (void)initSuperviews
{
    [self.view addSubview:self.cycleScrollView];
    float cellw =_SCREEN_WIDTH/2-1;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setItemSize:CGSizeMake(cellw, 80)];//设置cell的尺寸
    [flowLayout setScrollDirection:
     UICollectionViewScrollDirectionVertical];//设置其布局方向
    flowLayout.minimumInteritemSpacing = 1;
    flowLayout.minimumLineSpacing      = 1;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 0, 0, 0);//设置其边界
    self.collectionView.collectionViewLayout = flowLayout;
    self.collectionView.backgroundColor = TabelBackCorl;
    [self.collectionView registerNib:[UINib nibWithNibName:@"ZKMainPlayCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
       self.collectionView.frame = CGRectMake(0, sdCycleHeghit, _SCREEN_WIDTH, self.view.frame.size.height-sdCycleHeghit);
       self.collectionView.mj_header = [MJDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(postData)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ZKMainPlayCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];

    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    

}


@end
