//
//  ZKTableViewBaseController.m
//  cyPZH
//
//  Created by 王小腊 on 16/6/6.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import "ZKTableViewBaseController.h"
#import "ZKErrorView.h"

@interface ZKTableViewBaseController ()

/* 当前页码 */
@property (nonatomic, assign) int page;

@end

@implementation ZKTableViewBaseController
@dynamic paoMaTitle;

- (NSMutableArray *)models {
    if (_models == nil) {
        _models = [NSMutableArray array];
    }
    return _models;
}

- (NSMutableDictionary *)params
{
    if (_params == nil) {
        _params = [NSMutableDictionary params];
    }
    return _params;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.title)
    {
        
        [[BaiduMobStat defaultStat] pageviewStartWithName:[NSString stringWithFormat:@"%@",self.title]];
    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    
    [super viewDidDisappear:animated];
    
    if (self.title)
    {
        
        [[BaiduMobStat defaultStat] pageviewEndWithName:[NSString stringWithFormat:@"%@",self.title]];
    }
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupProperties];
    [self setupTableView];
    [self setupRefreshControl];
    [self setupPromptView];

}

- (void)setupProperties
{
    // 默认需要上拉和下拉刷新
    self.needsPullDownRefreshing = YES;
    self.needsPullUpRefreshing = YES;
    // 请求路径
    self.URLString = POST_ZK_URL;
}

- (void)didGetResponse:(id)responseObject atPage:(NSInteger)page {}
- (void)didFailureRequest:(NSError *)error {}
- (void)didFinishedLoading{}

- (void)setupTableView
{
    self.tableView.backgroundColor = ZKViewBackgroundColor;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.tableView.layoutMargins = UIEdgeInsetsZero;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    //去掉plain样式下多余的分割线
    if (self.tableView.style == UITableViewStylePlain) {
        self.tableView.tableFooterView = [UIView new];
    }
}

- (void)setupRefreshControl
{
    // 初始第一页
    self.page = 1;
    MJWeakSelf
    
    //是否集成上拉刷新操作
    if (self.isNeedsPullDownRefreshing) {
        self.tableView.mj_header = [MJDIYHeader headerWithRefreshingBlock:^{
            if (weakSelf.isNeedsPullUpRefreshing) {
                weakSelf.params[@"page"] = @(weakSelf.page = 1);
            }
            [weakSelf loadData];
        }];
    }
    //是否集成上拉刷新操作
    if (self.isNeedsPullUpRefreshing)
    {
        self.tableView.mj_footer = [MJDIYBackFooter footerWithRefreshingBlock:^{
            weakSelf.params[@"page"] = @(++weakSelf.page);
            [weakSelf loadData];
        }];
    }
}

- (void)setupPromptView
{
    ZKErrorView *promptView = [[ZKErrorView alloc] init];
    promptView.hidden = YES;
    [self.tableView addSubview:promptView];
    self.promptView = promptView;
    
    MJWeakSelf
    [promptView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf.tableView);
        make.width.mas_equalTo(82);
        make.height.mas_equalTo(22);
    }];
}


- (void)loadData
{
    MMLog(@"%@\n", self.params);
    self.params[@"TimeStamp"] = [ZKUtil timeStamp];
    [ZKHttp postWithURLString:self.URLString parameters:self.params success:^(id responseObject) {
        MMLog(@"%@", responseObject);
        [self dealWithSuccess:responseObject];
    } failure:^(NSError *error) {
        [self dealWithFailure:error];
    }];
}

- (void)dealWithError:(NSString *)errmsg
{
    //提示错误
    HUDShowError(errmsg)
    //停止刷新
    [self endRefreshingWithDataTotalCount:-1];
    //页面回减
    if (self.page > 1)
    {
        self.page--;
    }
    //根据数据个数决定显示提示状态
    [self showPromptStatus];
}

- (void)dealWithFailure:(NSError *)error
{
    
    
    if (self.cacheFilename)
    {
        //有缓存时读取缓存数据
        NSMutableArray *cacheModels = [NSKeyedUnarchiver unarchiveObjectWithFile:[kDocumentPath stringByAppendingPathComponent:self.cacheFilename]];
        //缓存数据不为空时展示缓存数据
        if (cacheModels.count > 0) {
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            
            self.models = cacheModels;
            [self.tableView reloadData];
        }
        else
        {
            
            [self errrorView:error];
        }
    }
    else
    {
        [self errrorView:error];
        
    }
    
    
    
    
}
- (void)errrorView:(NSError *)error
{
    //请求失败,调用子类方法(如果子类有实现)
    [self didFailureRequest:error];
    //提示网络错误
    HUDShowError(@"网络错误")
    //根据上拉或者下拉情况停止刷新
    [self endRefreshingWithDataTotalCount:-1];
    //控制请求数据页码
    if (self.page > 1)
    {
        self.page--;
    }
    self.promptView.prompt = @"网络出错了";
    //根据数据个数决定显示提示状态
    [self showPromptStatus];
}

- (void)dealWithSuccess:(id)responseObject
{

    //拿到最新数据，调用子类方法(如果子类有实现)
    [self didGetResponse:responseObject atPage:self.page];

    //根据上拉或者下拉情况处理请求到的最新数据
    NSMutableArray *dataArray = [self.modelsType mj_objectArrayWithKeyValuesArray:responseObject[@"rows"]] ? : @[].mutableCopy;
    
    [self dealWithLatestDataArray:dataArray];
    //根据上拉或者下拉情况停止刷新
    id total = responseObject[@"total"];
    [self endRefreshingWithDataTotalCount:total ? [total integerValue] : -1];
    //控制请求数据页码
    if (dataArray.count == 0 && self.page > 1)
    {
        self.page--;
    }
    self.promptView.prompt = dataArray.count == 0?@"暂无数据":@"";
    //根据数据个数决定显示提示状态
    [self showPromptStatus];
    [self didFinishedLoading];
}

- (void)dealWithLatestDataArray:(NSMutableArray *)dataArray
{
    if (self.page == 1) {
        //下拉刷新时覆盖数据
        self.models = dataArray;
        //self.cacheFilename有值时表示需要缓存，否则无缓存
        if (self.cacheFilename) {
            [NSKeyedArchiver archiveRootObject:dataArray toFile:[kDocumentPath stringByAppendingPathComponent:self.cacheFilename]];
        }
    }else {
        //上拉刷新时累加数据
        [self.models addObjectsFromArray:dataArray];
    }
    //数据处理后刷新表格
    [self.tableView reloadData];
}

- (void)showPromptStatus
{
    //根据数据个数判断是否要显示提示没有数据的提示控件
    self.promptView.hidden = self.models.count > 0;
    //根据数据个数判断是否要显示尾部刷新控件
    self.tableView.mj_footer.hidden = self.models.count == 0;
}

- (void)endRefreshingWithDataTotalCount:(NSInteger)dataTotalCount
{
    // 停止头部刷新
    [self.tableView.mj_header endRefreshing];
    // 第一页时重置尾部刷新状态
    if (self.page == 1) {
        [self.tableView.mj_footer resetNoMoreData];
    }
    // 如果数据个数达到总数则尾部显示已经加载完毕，否则直接停止刷新
    if (self.models.count == dataTotalCount) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }else {
        [self.tableView.mj_footer endRefreshing];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.models.count;
}

#pragma mark - title

- (void)setPaoMaTitle:(NSString *)paoMaTitle
{
    if ([paoMaTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:0 attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:18]} context:nil].size.width > 225) {
        [self beginAnimationWithTitle:paoMaTitle];
    }else {
        self.title = paoMaTitle;
    }
}

- (NSString *)paoMaTitle
{
    return self.title;
}

- (void)beginAnimationWithTitle:(NSString *)title
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 225, 44)];
    view.backgroundColor = [UIColor clearColor];
    view.clipsToBounds = YES;
    self.navigationItem.titleView = view;
    
    NSString *extendedTitle = [NSString stringWithFormat:@"    %@    ", title];
    CGSize labelSize = [extendedTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:0 attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:18]} context:nil].size;
    
    for (int i = 0; i < 2; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.text = extendedTitle;
        label.textColor = CYBColorGreen;
        label.font = [UIFont systemFontOfSize:18];
        label.frame = CGRectMake(i * labelSize.width, 0, labelSize.width, view.frame.size.height);
        [view addSubview:label];
        
        CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
        anim.toValue = @(-label.frame.size.width);
        anim.repeatCount = MAXFLOAT;
        anim.duration = title.length / 1.8;
        anim.fillMode = kCAFillModeForwards;
        anim.removedOnCompletion = NO;
        [label.layer addAnimation:anim forKey:nil];
    }
}



@end
