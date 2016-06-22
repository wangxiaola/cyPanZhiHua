//
//  ZKMainSceneryTableViewController.m
//  cyPZH
//
//  Created by 王小腊 on 16/6/13.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import "ZKMainSceneryTableViewController.h"
#import "WMPlayer.h"
#import "ZKBaseWebViewController.h"

#import "ZKMainSceneryMode.h"
#import "ZKMainPlayInforMode.h"

#import "ZKMainPlayInforTableViewCell.h"
#import "ZKMainPlayNumberTableViewCell.h"
#import "ZKMainPlayMessageTableViewCell.h"
#import "ZKMainPlayHeaderTableViewCell.h"



static NSString *const playHighlighted = @"scenery_icon_suspend";

@interface ZKMainSceneryTableViewController ()<ZKMainPlayNumberTableViewCellDelegate,ZKMainPlayHeaderTableViewCellDelegate>

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UIButton *playButton;
@property (nonatomic, strong) WMPlayer *wmPlayer;
@property (nonatomic, strong) NSString *mvpUrl;
@property (nonatomic, strong) ZKMainPlayInforMode *inforMode;
@property (nonatomic, strong) NSMutableDictionary *commentDic;
//留言
@property (nonatomic, assign) NSInteger tool;
@property (nonatomic, assign) NSInteger lyID;
@end

@implementation ZKMainSceneryTableViewController
{
    
    CGRect playerFrame;
}


- (NSMutableDictionary *)commentDic
{
    if (!_commentDic) {
        
        _commentDic= [NSMutableDictionary params];
        _commentDic[@"type"] = @"video";
        _commentDic[@"page"] = @"1";
        _commentDic[@"interfaceId"] = @"124";
    }
    return _commentDic;
}
- (WMPlayer *)wmPlayer
{
    if (!_wmPlayer) {
        
        _wmPlayer = [[WMPlayer alloc]initWithFrame:playerFrame videoURLStr:@""];
        [_wmPlayer.progressSlider removeFromSuperview];
        _wmPlayer.closeBtn.hidden = YES;
        
        self.backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _wmPlayer.frame.size.width, _wmPlayer.frame.size.height)];
        self.backImageView.image = [UIImage imageNamed:@"daohuang_ default"];
        self.backImageView.userInteractionEnabled = YES;
        [_wmPlayer insertSubview:self.backImageView atIndex:800];
        
        self.playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.playButton.selected = NO;
        [self.playButton setImage:[UIImage imageNamed:playHighlighted] forState:UIControlStateNormal];
        [self.playButton addTarget:self action:@selector(playSateClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.backImageView addSubview:self.playButton];
        [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.mas_equalTo(0);
            make.centerY.mas_equalTo(0);
        }];
        
    }
    return _wmPlayer;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //旋转屏幕通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onDeviceOrientationChange)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
     ];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configurationParameters];
    [self initSupViews];
    [self.tableView.mj_header beginRefreshing];
    
}
/**
 *  重组
 */
- (void)setupProperties
{
    [super setupProperties];
    self.needsPullUpRefreshing = NO;
}

/**
 *  加载完成
 */
- (void)didFinishedLoading;
{
    if (self.models.count >0)
    {
        self.tool  = 5;
        self.index = -1;
        [self.tableView.mj_footer resetNoMoreData];
        [self selectAnnotation:self.models[0] index:0];
    }
    
}
#pragma mark --配置参数--
- (void)configurationParameters
{
    self.tool  = 5;
    self.index = -1;
    self.params[@"interfaceId"]=@"146";
    self.params[@"method"]=@"sceneryRealMonitor";
    self.params[@"rows"]=@"11";
    self.params[@"page"]=@"1";
    self.cacheFilename = @"ZKMainSceneryTableViewController";
    self.needsPullUpRefreshing = NO;
    self.modelsType = [ZKMainSceneryMode class];
    
}

/**
 *  视图设置
 */
- (void)initSupViews
{
    //注册播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fullScreenBtnClick:) name:@"fullScreenBtnClickNotice" object:nil];
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectTabar:) name:@"selectTabar" object:nil];
    
    playerFrame = CGRectMake(0, 0, self.view.frame.size.width, 140);
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _SCREEN_WIDTH, 26)];
    self.tableView.tableHeaderView = self.wmPlayer;
    [self.tableView registerNib:[UINib nibWithNibName:@"ZKMainPlayInforTableViewCell" bundle:nil] forCellReuseIdentifier:ZKMainPlayInforTableViewCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZKMainPlayNumberTableViewCell" bundle:nil] forCellReuseIdentifier:playNumberTableViewCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZKMainPlayMessageTableViewCell" bundle:nil] forCellReuseIdentifier:PlayMessageTableViewCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZKMainPlayHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:PlayHeaderTableViewCellID];
    
    MJWeakSelf;
    self.tableView.mj_footer = [MJDIYBackFooter footerWithRefreshingBlock:^{
        weakSelf.tool = weakSelf.tool+5;
        [weakSelf commentPost];
        
    }];
    self.tableView.mj_footer.ignoredScrollViewContentInsetBottom = -40;
    
}

#pragma mark----
#pragma mark --ZKMainPlayNumberTableViewCellDelegate--
/**
 *  选中哪个气泡
 *
 *  @param mode 数据
 *  @param row  第几个
 */
- (void)selectAnnotation:(ZKMainSceneryMode*)mode index:(NSInteger)row;
{
    if (row == self.index) {return;}
    self.index = row;
    NSString *playUrl = [NSString stringWithFormat:@"http:%@",mode.url];
    self.mvpUrl = playUrl;
    [self.wmPlayer setVideoURLStr:@""];
    [self.wmPlayer.player pause];
    [ZKUtil UIimageView:self.backImageView NSSting:[NSString stringWithFormat:@"%@%@",IMAGE_URL_CSW,mode.logosmall] duImage:@"daohuang_ default"];
    self.backImageView.hidden = NO;
    /**
     *  重新获取留言
     */
    self.tool = 5 ;
    self.lyID = mode.ID;
    [self commentPost];
    
    
}

/**
 *  全景选中
 *
 *  @param mode
 */
- (void)panoramaData:(ZKMainSceneryMode*)mode;
{
    ZKBaseWebViewController *webView = [[ZKBaseWebViewController alloc] init];
    webView.htmlUrl  = mode.address720;
    webView.htmlName = mode.name;
    [self.navigationController pushViewController:webView animated:YES];
}
/**
 *  分享选中
 *
 *  @param mode
 */
- (void)shareData:(ZKMainSceneryMode*)mode;
{
    
    
}
#pragma mark 评论数据请求
/**
 *  评论数据请求
 *
 *  @param ID
 */
- (void)commentPost
{
    [_commentDic removeAllObjects];
    _commentDic = nil;
    self.commentDic[@"id"]   = [NSString stringWithFormat:@"%ld",(long)self.lyID];
    self.commentDic[@"rows"] = [NSNumber numberWithInteger:self.tool];
    self.commentDic[@"TimeStamp"] = [ZKUtil timeStamp];
    
    [SVProgressHUD showWithStatus:@"正在获取留言"];
    MJWeakSelf;
    [ZKHttp postWithURLString:POST_ZK_URL parameters:self.commentDic success:^(id responseObject) {
        HUDDissmiss
        weakSelf.inforMode = [ZKMainPlayInforMode mj_objectWithKeyValues:responseObject];
        
        [weakSelf commentFootCount:weakSelf.inforMode.total];
        
    } failure:^(NSError *error) {
        weakSelf.tool = 5;
        HUDShowError(@"网路错误!")
    }];
    
}
/**
 *  根据数据来对foot控件做操作
 *
 *  @param dataTotalCount 个数
 */
- (void)commentFootCount:(NSInteger)dataTotalCount
{
    // 停止头部刷新
    [self.tableView.mj_header endRefreshing];
    // 第一页时重置尾部刷新状态
    if (self.tool == 5)
    {
        [self.tableView.mj_footer resetNoMoreData];
    }
    // 如果数据个数达到总数则尾部显示已经加载完毕，否则直接停止刷新
    if (self.inforMode.root.count == dataTotalCount) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }else {
        [self.tableView.mj_footer endRefreshing];
    }
    
    NSIndexSet *setOne = [[NSIndexSet alloc] initWithIndex:2];
    NSIndexSet *setTow = [NSIndexSet indexSetWithIndex:1];
    [self.tableView reloadSections:setOne withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView reloadSections:setTow withRowAnimation:UITableViewRowAnimationAutomatic];
    
    if (self.inforMode.root.count>5)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.inforMode.root.count inSection:2];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

#pragma mark----
#pragma mark --UITableViewDelageta--
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 66;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 3;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section < 2)
    {
        
        return 1;
    }
    else
    {
        return self.inforMode.root.count+1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return 340;
    }
    else if (indexPath.section == 1)
    {
        return UITableViewAutomaticDimension;
    }
    else
    {
        return indexPath.row == 0 ? 38:UITableViewAutomaticDimension;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.01;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 8;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    if (indexPath.section == 0)
    {
        ZKMainPlayNumberTableViewCell *numberCell = [tableView dequeueReusableCellWithIdentifier:playNumberTableViewCellID];
        numberCell.delegate = self;
        if (self.models.count>0)
        {
            [numberCell showAnnonViews:self.models selct:self.index];
        }
        cell = numberCell;
    }
    else if (indexPath.section == 1)
    {
        ZKMainPlayInforTableViewCell *inforCell = [tableView dequeueReusableCellWithIdentifier:ZKMainPlayInforTableViewCellID];
        if (self.models.count>0)
        {
            inforCell.sceneryList = self.models[self.index];
        }
        if (self.inforMode) {
            
            [inforCell updataLick:self.inforMode.score number:self.inforMode.number];
        }
        cell = inforCell;
        
    }
    else if (indexPath.section == 2)
    {
        
        if (indexPath.row == 0)
        {
            
            ZKMainPlayHeaderTableViewCell *headerCell = [tableView dequeueReusableCellWithIdentifier:PlayHeaderTableViewCellID];
            headerCell.delegate = self;
            [headerCell headerNumber:self.inforMode.total];
            cell = headerCell;
        }
        else
        {
            ZKMainPlayMessageTableViewCell *messageCell = [tableView dequeueReusableCellWithIdentifier:PlayMessageTableViewCellID];
            
            ZKPlayInforRoot *root = self.inforMode.root[indexPath.row-1];
            messageCell.rootList = root;
            cell = messageCell;
        }
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark 点击事件

- (void)playSateClick:(UIButton*)sender
{
    [self.wmPlayer setVideoURLStr:self.mvpUrl];
    [self.wmPlayer.player play];
    self.backImageView.hidden = YES;
    
    
}
#pragma mark 视频控制
-(void)toFullScreenWithInterfaceOrientation:(UIInterfaceOrientation )interfaceOrientation{
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    [self.wmPlayer removeFromSuperview];
    self.wmPlayer.transform = CGAffineTransformIdentity;
    if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft) {
        self.wmPlayer.transform = CGAffineTransformMakeRotation(-M_PI_2);
    }else if(interfaceOrientation==UIInterfaceOrientationLandscapeRight){
        self.wmPlayer.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    self.wmPlayer.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.wmPlayer.playerLayer.frame =  CGRectMake(0,0, self.view.frame.size.height,self.view.frame.size.width);
    
    [self.wmPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(self.view.frame.size.width-40);
        make.width.mas_equalTo(self.view.frame.size.height);
    }];
    
    [self.wmPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.wmPlayer).with.offset((-self.view.frame.size.height/2));
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
        make.top.equalTo(self.wmPlayer).with.offset(5);
        
    }];
    [[UIApplication sharedApplication].keyWindow addSubview:self.wmPlayer];
    self.wmPlayer.isFullscreen = YES;
    self.wmPlayer.fullScreenBtn.selected = YES;
    [self.wmPlayer sendSubviewToBack:self.wmPlayer.bottomView];
    self.wmPlayer.activityView.center = CGPointMake(_SCREEN_HEIGHT/2, _SCREEN_WIDTH/2);
}
-(void)toNormal{
    
    
    [self.wmPlayer removeFromSuperview];
    [UIView animateWithDuration:0.5f animations:^{
        self.wmPlayer.transform = CGAffineTransformIdentity;
        self.wmPlayer.frame =CGRectMake(playerFrame.origin.x, playerFrame.origin.y, playerFrame.size.width, playerFrame.size.height);
        self.wmPlayer.playerLayer.frame =  self.wmPlayer.bounds;
        [self.view addSubview:self.wmPlayer];
        [self.wmPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.wmPlayer).with.offset(0);
            make.right.equalTo(self.wmPlayer).with.offset(0);
            make.height.mas_equalTo(40);
            make.bottom.equalTo(self.wmPlayer).with.offset(0);
        }];
        [self.wmPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.wmPlayer).with.offset(5);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(30);
            make.top.equalTo(self.wmPlayer).with.offset(5);
        }];
        
    }completion:^(BOOL finished) {
        self.wmPlayer.isFullscreen = NO;
        self.wmPlayer.fullScreenBtn.selected = NO;
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
        
    }];
    
    self.wmPlayer.activityView.center = self.wmPlayer.center;
    
}
-(void)fullScreenBtnClick:(NSNotification *)notice{
    UIButton *fullScreenBtn = (UIButton *)[notice object];
    if (fullScreenBtn.isSelected) {//全屏显示
        [self toFullScreenWithInterfaceOrientation:UIInterfaceOrientationLandscapeLeft];
    }else{
        [self toNormal];
    }
}
/**
 *  旋转屏幕通知
 */
- (void)onDeviceOrientationChange{
    
    
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)orientation;
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortraitUpsideDown:{
            //            第3个旋转方向---电池栏在下
        }
            break;
        case UIInterfaceOrientationPortrait:{
            //            第0个旋转方向---电池栏在上
            if (self.wmPlayer.isFullscreen) {
                [self toNormal];
            }
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:{
            //           第2个旋转方向---电池栏在左
            if (self.wmPlayer.isFullscreen == NO) {
                [self toFullScreenWithInterfaceOrientation:interfaceOrientation];
            }
        }
            break;
        case UIInterfaceOrientationLandscapeRight:{
            //            第1个旋转方向---电池栏在右
            if (self.wmPlayer.isFullscreen == NO) {
                [self toFullScreenWithInterfaceOrientation:interfaceOrientation];
            }
        }
            break;
        default:
            break;
    }
}

// 通知恢复
-(void)selectTabar:(NSNotification *)text{
    
    NSInteger dex = [text.object integerValue];
    
    if (dex != 2 && self.backImageView.hidden == YES)
    {
        [self.wmPlayer setVideoURLStr:@"r"];
        [self.wmPlayer.player pause];
        self.backImageView.hidden = NO;
        
    }
    
}
/**
 *  销毁
 */
-(void)releaseWMPlayer{
    
    [self.wmPlayer.player.currentItem cancelPendingSeeks];
    [self.wmPlayer.player.currentItem.asset cancelLoading];
    
    [self.wmPlayer.player pause];
    [self.wmPlayer removeFromSuperview];
    [self.wmPlayer.playerLayer removeFromSuperlayer];
    [self.wmPlayer.player replaceCurrentItemWithPlayerItem:nil];
    self.wmPlayer = nil;
    self.wmPlayer.player = nil;
    self.wmPlayer.currentItem = nil;
    
    self.wmPlayer.playOrPauseBtn = nil;
    self.wmPlayer.playerLayer = nil;
    
    
}

-(void)dealloc{
    [self releaseWMPlayer];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -----
#pragma mark --ZKMainPlayHeaderTableViewCellDelegate--
/**
 *  留言点击
 */
- (void)ClickOnMessage;
{
    
    
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
