//
//  ZKRobotViewController.m
//  cyPZH
//
//  Created by 王小腊 on 16/6/6.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import "ZKRobotViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "WXVoiceSDK.h"
#import "WXSpeechSynthesizer.h"
#import "WXSpeechSynthesizerPlayer.h"

#import "ZKRobotDeployList.h"
#import "ZKRobotMode.h"

#import "ZKRobotTableView.h"
#import "ZKRobotTallyView.h"
#import "ZKRobotToolView.h"

@interface ZKRobotViewController ()<WXVoiceDelegate,ZKRobotToolViewDelegate,ZKRobotTallyViewDelegate,WXSpeechSynthesizerPlayerDelegate,WXSpeechSynthesizerDelegate,ZKRobotTableViewDelegate>

@property (nonatomic, strong) ZKRobotDeployList *deployList;//配置数据
@property (nonatomic, strong) NSArray *randomArray;//随机数据
@property (nonatomic, strong) NSString *stateTitiel;
//视图
@property (nonatomic, strong) ZKRobotTableView *robotTableView;
@property (nonatomic, strong) ZKRobotTallyView *robotTallyView;
@property (nonatomic, strong) ZKRobotToolView  *robotToolView;
@property (nonatomic, strong) WXSpeechSynthesizerPlayer *player;
@property (nonatomic, strong) UIImageView      *backImageView;
@property (nonatomic, strong) UIImage          *robotPortraitImage;
@property (nonatomic, strong) UIImage          *userPortraitImage;
@end

@implementation ZKRobotViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"智能机器人";
    [self initWXSDK];
    [self initViews];
    [self postData];
}
#pragma mark  ----
#pragma mark  ---- 数据处理 ----
// 获取配置信息
- (void)postData
{
    
    NSMutableDictionary *dic = [NSMutableDictionary params];
    [dic setObject:@"129" forKey:@"interfaceId"];
    [dic setObject:@"robotConfig" forKey:@"Method"];
    MJWeakSelf
    HUDShowLoading(@"加载中")
    [ZKHttp postWithURLString:POST_ZK_URL parameters:dic success:^(id responseObject) {
        
        if (responseObject) {
            HUDShowSuccess(@"机器人配置成功")
            weakSelf.deployList = [ZKRobotDeployList mj_objectWithKeyValues:responseObject];
            [weakSelf updata];
            
        }
        else
        {
            HUDShowError(@"机器人配置失败")
            weakSelf.backImageView.image = [UIImage imageNamed:@"guanggo_ default"];
        }
        
        
    } failure:^(NSError *error) {
        
        HUDShowError(@"网络出错了");
        weakSelf.backImageView.image = [UIImage imageNamed:@"guanggo_ default"];
    }];
    
}
/**
 *  更新数据
 */
- (void)updata
{
    
    
    self.paoMaTitle  = self.deployList.ThemeName;
    self.stateTitiel = self.deployList.ThemeName;
    
    NSData* robotdata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:self.deployList.RobotLogo]];
    UIImage *robotImage = [UIImage imageWithData:robotdata];
    
    if (robotImage)
    {
        
        self.robotPortraitImage = robotImage;
    }else
    {
      self.robotPortraitImage = [UIImage imageNamed:@"headimage-default"];
    }
  
    self.userPortraitImage  = [UIImage imageNamed:@"cell_ default"];
    NSData* backdata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:self.deployList.ThemeBackground]];
    UIImage *backImage = [UIImage imageWithData:backdata];
    
    NSString * robotMessg = [NSString stringWithFormat:@"主人,我是%@,请问你有什么吩咐?",self.deployList.RoleName];
    
    self.randomArray = [self.deployList.ReplyList mj_JSONObject];
    
    ZKRobotMode *data = [[ZKRobotMode alloc] init];
    data.info = robotMessg;
    data.potoImage =robotImage;
    data.type = ZKRobotStateRobot;
    data.size = [ZKUtil contentLabelSize:CGSizeMake(_SCREEN_WIDTH - 40 - 36, MAXFLOAT) labelFont:14 labelText:robotMessg];
    
    [self.robotTableView addMOde:data post:NO];
    
    [[WXSpeechSynthesizer sharedSpeechSynthesizer] startWithText:robotMessg];
    
    self.backImageView.image = backImage;
    
    [self.robotTableView updateData:robotImage robotName:self.deployList.RoleName];
    
}
/**
 *  返回随机数据
 *
 *  @return 字符串
 */
- (NSString *)randomData
{
    
    
    if (self.randomArray.count > 0) {
        
        NSInteger dex = arc4random()%self.randomArray.count;
        
        NSString *meg = self.randomArray[dex];
        
        return meg;
    }
    else
    {
        
        return @"主人,你的网络出错了!";
    }
}
/**
 *  我发的
 *
 *  @param key     话
 *  @param ps      是否请求
 */
- (void)userData:(NSString*)key post:(BOOL)ps
{
    
    ZKRobotMode *data = [[ZKRobotMode alloc] init];
    data.info = key;
    data.potoImage = self.userPortraitImage;
    data.type = ZKRobotStateUser;
    
    data.size  = [ZKUtil contentLabelSize:CGSizeMake(_SCREEN_WIDTH - 40 - 36, MAXFLOAT) labelFont:14 labelText:key];
    
    [self.robotTableView addMOde:data post:ps];
    
}

#pragma mark  ----
#pragma mark  ---- 界面布局 ----
/**
 *  初始化视图
 */
- (void)initViews
{
    float toolHeghit = 60;
    
    self.backImageView = [[UIImageView alloc] init];
    self.backImageView.userInteractionEnabled = YES;
    self.backImageView.backgroundColor = [UIColor whiteColor];
    self.backImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.backImageView.frame = CGRectMake(0, 64,_SCREEN_WIDTH, _SCREEN_HEIGHT-toolHeghit-64);
    [self.view insertSubview:self.backImageView atIndex:99];
    
    //    对话框
    self.robotTableView = [[ZKRobotTableView alloc] initWithFrame:CGRectMake(0, 0, _SCREEN_WIDTH, self.backImageView.frame.size.height)];
    self.robotTableView.backgroundColor = [UIColor clearColor];
    self.robotTableView.tabelDelegate = self;
    self.robotTableView.controller    = self;
    [self.backImageView insertSubview:self.robotTableView atIndex:100];
    //    标签框
    self.robotTallyView = [[ZKRobotTallyView alloc] initWithFrame:CGRectMake(0, 0, _SCREEN_WIDTH, self.backImageView.frame.size.height)];
    self.robotTallyView.backgroundColor = [UIColor clearColor];
    self.robotTallyView.hidden = YES;
    self.robotTallyView.tallyDelegate = self;
    [self.backImageView insertSubview:self.robotTallyView atIndex:101];
    
    //    工具栏
    self.robotToolView = [[ZKRobotToolView alloc] initWithFrame:CGRectMake(0,self.view.frame.size.height-80, _SCREEN_WIDTH, 80) objec:self];
    self.robotToolView.backgroundColor = [UIColor clearColor];
    self.robotToolView.toolDelegate = self;
    [self.view insertSubview:self.robotToolView atIndex:200];
    
    
}

#pragma mark  ----
#pragma mark  ---- ZKRobotTallyViewDelegate ----

/**
 *  点击选中谁
 *
 *  @param key
 */
- (void)selectTitel:(NSString*)key;
{
    
    [self.robotToolView dismmSkill];
    
    if (strIsEmpty(key)) {
        
        [self userData:key post:YES ];
        
    }
    
}


#pragma mark  ----
#pragma mark  ---- ZKRobotTableViewDelegate ----

/**
 *  翻译
 *
 *  @param string
 */
- (void)userMusic:(NSString*)string;
{
    NSString * key;
    
    if (strIsEmpty(string))
    {
        key = string;
      [[WXSpeechSynthesizer sharedSpeechSynthesizer] startWithText:string];
    }
    else
    {
        key = [self randomData];
      [[WXSpeechSynthesizer sharedSpeechSynthesizer] startWithText:key];
        
    }
    
    ZKRobotMode *data = [[ZKRobotMode alloc] init];
    data.info = key;
    data.potoImage = self.robotPortraitImage;
    data.type = ZKRobotStateRobot;
    data.size = [ZKUtil contentLabelSize:CGSizeMake(_SCREEN_WIDTH - 40 - 36, MAXFLOAT) labelFont:14 labelText:key];
    [self.robotTableView addMOde:data post:NO];

    
    
    
    
}

#pragma mark  ----
#pragma mark  ---- ZKRobotToolViewDelegate ----

/**
 *  键盘输入
 *
 *  @param str 内容
 */
- (void)textFieldString:(NSString*)str;
{
    
    
    if (!self.deployList) {
        HUDShowError(@"数据加载失败")
        return;
    }
    
    
    NSString *contenStr;
    NSInteger state;
    UIImage  *handerImage;
    BOOL    isPost;
    if (strIsEmpty(str)) {
        
        state       = 1;
        contenStr   = str;
        handerImage = self.userPortraitImage;
        isPost      = YES;
    }
    else
    {
        contenStr   = [NSString stringWithFormat:@"刚才什么也没有听到,难道是%@走神了?请重新再说一次吧!",self.deployList.RoleName];
        state = 0;
        handerImage = self.robotPortraitImage;
        isPost      = NO;
        [[WXSpeechSynthesizer sharedSpeechSynthesizer] startWithText:contenStr];
        
    }
    
    ZKRobotMode *data = [[ZKRobotMode alloc] init];
    data.info = contenStr;
    data.potoImage = handerImage;
    data.type = ZKRobotStateRobot;
    
    data.size  = [ZKUtil contentLabelSize:CGSizeMake(_SCREEN_WIDTH - 40 - 36, MAXFLOAT) labelFont:14 labelText:str];
    
    [self.robotTableView addMOde:data post:isPost];
    
    
}

/**
 *  声音输入状态
 *
 *  @param state yes开始 no结束
 */
- (void)voiceState:(BOOL)state;
{
    
    if (!self.deployList) {
        HUDShowError(@"数据加载失败")
        return;
    }
    
    
    if (state == YES)
    {
        self.paoMaTitle  = @"开始录音了";
        [[WXVoiceSDK sharedWXVoice] startOnce];
        
    }
    else
    {
        self.paoMaTitle = self.stateTitiel;
        [[WXVoiceSDK sharedWXVoice] finish];
        
    }
    
}
/**
 *  技能状态
 *
 *  @param state yes打开 no关闭
 */
- (void)skillState:(BOOL)state;
{
    
    self.robotTallyView.hidden = !state;
    

}

#pragma mark  ----
#pragma mark  ---- 微信栏 ----
/**
 *  初始化微信
 */
- (void)initWXSDK
{
    
    // SDK
    WXVoiceSDK *speechRecognizer = [WXVoiceSDK sharedWXVoice];
    //可选设置
    speechRecognizer.silTime = 1.5f;
    //必选设置
    speechRecognizer.delegate = self;
    [speechRecognizer setAppID:weixinID];
    [speechRecognizer setDomain:20];
    [speechRecognizer setResultType:1];//1有标点，0无标点
    
    
    _player = [[WXSpeechSynthesizerPlayer alloc] init];
    _player.delegate = self;
    
    WXSpeechSynthesizer * speechSynthesizer = [WXSpeechSynthesizer sharedSpeechSynthesizer];
    [speechSynthesizer setDelegate:self];
    [speechSynthesizer setAppID:weixinID];
    [speechSynthesizer setVolumn:1.3];
    
    
    
}


#pragma mark -----------WXVoiceDelegate------------
//识别成功，返回结果，元素类型为WXVoiceResult，现阶段数组内只有一个元素
- (void)voiceInputResultArray:(NSArray *)array{
    //一旦此方法被回调，array一定会有一个值，所以else的情况不会发生，但写了会更有安全感的
    NSString *key;
    BOOL state;
    ZKRobotState dex;
    
    if (array && array.count>0)
    {
        WXVoiceResult *result=[array objectAtIndex:0];
        key = result.text;
        state = YES;
        dex = ZKRobotStateUser;
        
    }else{
        
        key = [NSString stringWithFormat:@"刚才什么也没有听到,难道是%@走神了?请重新再说一次吧!",self.deployList.RoleName];;
        dex = ZKRobotStateRobot;
        state = NO;
    }
    
    
    ZKRobotMode *data = [[ZKRobotMode alloc] init];
    data.info = key;
    data.potoImage = self.userPortraitImage;
    data.type = dex;
    
    data.size  = [ZKUtil contentLabelSize:CGSizeMake(_SCREEN_WIDTH - 40 - 36, MAXFLOAT) labelFont:14 labelText:key];
    [self.robotTableView addMOde:data post:state];
    
}
//出现错误，错误码请参见官方网站
- (void)voiceInputMakeError:(NSInteger)errorCode{
    HUDShowError(@"语音录取失败");
    
}
//音量，界限为0-30，通常音量范围在0-15之间
- (void)voiceInputVolumn:(float)volumn{
    
    
    
}
//录音完成，等待服务器返回识别结果。此时不会再接受新的语音
- (void)voiceInputWaitForResult{
    
    
}
//在手动调用的cancel后，取消完成时回调
- (void)voiceInputDidCancel{
    
}

#pragma mark -----------WXSpeechSynthesizerDelegate------------

- (void)speechSynthesizerResultSpeechData:(NSData *)speechData speechFormat:(int)speechFormat{
    //amr格式无法直接播放，请自行转码
    [_player playNewData:speechData];
    
    
}
- (void)speechSynthesizerMakeError:(NSInteger)error{
    
    HUDShowError(@"语音解析失败")
}
- (void)speechSynthesizerDidCancel{
    
}


#pragma mark -----------PlayerDelegate------------
- (void)playerDidFinishPlaying{
    
}
- (void)playerError{
    
     HUDShowError(@"语音播放失败")
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [WXSpeechSynthesizer sharedSpeechSynthesizer].delegate = nil;
    [WXSpeechSynthesizer releaseSpeechSynthesizer];
    [[WXVoiceSDK sharedWXVoice] cancel];
    [WXVoiceSDK sharedWXVoice].delegate = nil;;
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
