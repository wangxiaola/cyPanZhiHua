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
#import "ZKErrorView.h"

@interface ZKMainPalyCollectionViewController ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong)SDCycleScrollView *cycleScrollView;

@property (nonatomic, strong) ZKMainPlayMode *playModes;

@property (nonatomic, strong) NSMutableArray *imageUrlArray;

/**
 *  无数据时显示的view,可在子类自定义
 */
@property (nonatomic, weak) ZKErrorView *promptView;

@end

@implementation ZKMainPalyCollectionViewController


float const sdCycleHeghit = 440/3;

- (NSMutableArray *)imageUrlArray
{

    if (!_imageUrlArray) {
        
        _imageUrlArray = [NSMutableArray array];
    }
    
    return _imageUrlArray;
}

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
    [self.collectionView.mj_header beginRefreshing];
    
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
        
        MMLog(@"play = %@",responseObject);
        [weakSelf dealWithSuccess:responseObject];
        
    } failure:^(NSError *error) {
        
        [weakSelf dealWithFailure:error];
    }];
    
    
}
// 无数据操作
- (void)dealWithFailure:(NSError *)error
{
    [self.collectionView.mj_header endRefreshing];
    //有缓存时读取缓存数据
    self.playModes = [NSKeyedUnarchiver unarchiveObjectWithFile:[kDocumentPath stringByAppendingPathComponent:@""]];
    //缓存数据不为空时展示缓存数据
    if (self.playModes.columns.count > 0) {
        [self.collectionView reloadData];
         [self showBanner:self.playModes.play];
    }
    else
    {
        
        [self errrorView:error];
    }
    
}
// 错误信息提示
- (void)errrorView:(NSError *)error
{
    HUDShowError(@"网络错误")
    self.promptView.prompt = @"网络出错了";
    //根据数据个数决定显示提示状态
    [self showPromptStatus];
}
// 获取数据
- (void)dealWithSuccess:(id)responseObject
{
    [self.collectionView.mj_header endRefreshing];
    //下拉刷新时覆盖数据
    self.playModes = [ZKMainPlayMode mj_objectWithKeyValues:[responseObject valueForKey:@"data"]];
    
    [NSKeyedArchiver archiveRootObject:_playModes toFile:[kDocumentPath stringByAppendingPathComponent:@""]];
    //数据处理后刷新表格
    [self.collectionView reloadData];
    self.promptView.prompt = self.playModes.columns.count == 0?@"暂无数据":@"";
    [self showBanner:self.playModes.play];
    //根据数据个数决定显示提示状态
    [self showPromptStatus];
}

//显示错误图片
- (void)showPromptStatus
{
    //根据数据个数判断是否要显示提示没有数据的提示控件
    self.promptView.hidden = self.playModes.columns > 0;
    
}
//显示横幅
- (void)showBanner:(NSArray*)data
{
    
    [self.imageUrlArray removeAllObjects];
    
    [data enumerateObjectsUsingBlock:^(ZKPlayTypeMode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,obj.img]];
        
        [self.imageUrlArray addObject:url];
    }];
    
    self.cycleScrollView.imageURLStringsGroup = self.imageUrlArray;
    
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
- (void)setupPromptView
{
    MJWeakSelf
    ZKErrorView *promptView = [[ZKErrorView alloc] init];
    promptView.hidden = YES;
    
    [self.collectionView addSubview:promptView];
    self.promptView = promptView;
    
    [promptView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf.collectionView);
        make.width.mas_equalTo(82);
        make.height.mas_equalTo(22);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.playModes.columns.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ZKMainPlayCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.list = self.playModes.columns[indexPath.row];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
}
#pragma mark <SDCycleScrollViewDelegate>

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index;
{


}


@end
