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

#import "ZKRobotDeployList.h"
#import "ZKRobotMode.h"

#import "ZKRobotTableView.h"
#import "ZKRobotTallyView.h"
#import "ZKRobotToolView.h"

@interface ZKRobotViewController ()<WXVoiceDelegate,ZKRobotToolViewDelegate>

@property (nonatomic, strong) ZKRobotDeployList *deployList;//配置数据
@property (nonatomic, strong) NSArray *randomArray;//随机数据
//视图
@property (nonatomic, strong) ZKRobotTableView *robotTableView;
@property (nonatomic, strong) ZKRobotTallyView *robotTallyView;
@property (nonatomic, strong) ZKRobotToolView  *robotToolView;

@property (nonatomic, strong) UIImageView      *backImageView;
@property (nonatomic, strong) UIImage          *robotPortraitImage;
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
    [dic setObject:@"TagConfig" forKey:@"Channel"];
    MJWeakSelf
    HUDShowLoading(@"加载中")
    [ZKHttp postWithURLString:POST_ZK_URL parameters:dic success:^(id responseObject) {
        if (responseObject) {
            
            weakSelf.deployList = [ZKRobotDeployList mj_objectWithKeyValues:responseObject];
            [weakSelf updata];
            
        }
        else
        {
            weakSelf.backImageView.image = [UIImage imageNamed:@"guanggo_ default"];
        }
        HUDDissmiss

        NSLog(@"%@",responseObject);
        
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

    
    self.paoMaTitle = self.deployList.ThemeName;
    
    NSData* robotdata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:self.deployList.RobotLogo]];
    UIImage *robotImage = [UIImage imageWithData:robotdata];
       self.robotPortraitImage = robotImage;
    self.robotPortraitImage = robotImage;
    
    NSData* backdata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:self.deployList.ThemeBackground]];
    UIImage *backImage = [UIImage imageWithData:backdata];
 
    NSString * robotMessg = [NSString stringWithFormat:@"主人,我是%@,请问你有什么吩咐?",self.deployList.RoleName];
    
    self.randomArray = [self.deployList.ReplyList mj_JSONObject];
    
    ZKRobotMode *data = [[ZKRobotMode alloc] init];
    data.info = robotMessg;
    data.potoImage =robotImage;
    data.type = 0;
    
    
    data.size = [ZKUtil contentLabelSize:CGSizeMake(_SCREEN_WIDTH - 40 - 36, MAXFLOAT) labelFont:14 labelText:robotMessg];
    
    [self.robotTableView addMOde:data post:NO];
    

    NSLog(@" 随机 %@",self.randomArray);
    

   self.backImageView.image = backImage;

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
    [self.backImageView insertSubview:self.robotTableView atIndex:100];
//    标签框
    self.robotTallyView = [[ZKRobotTallyView alloc] initWithFrame:CGRectMake(0, 0, _SCREEN_WIDTH, self.backImageView.frame.size.height)];
    self.robotTallyView.backgroundColor = [UIColor clearColor];
    self.robotTallyView.hidden = YES;
    [self.backImageView insertSubview:self.robotTallyView atIndex:101];
    
//    工具栏
    self.robotToolView = [[ZKRobotToolView alloc] initWithFrame:CGRectMake(0,self.view.frame.size.height-80, _SCREEN_WIDTH, 80) objec:self];
    self.robotToolView.backgroundColor = [UIColor clearColor];
    self.robotToolView.toolDelegate = self;
    [self.view insertSubview:self.robotToolView atIndex:200];
    
    
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
    
    ZKRobotMode *data = [[ZKRobotMode alloc] init];
    data.info = str;
    data.potoImage =self.robotPortraitImage;
    data.type = 1;
    
    
    data.size  = [ZKUtil contentLabelSize:CGSizeMake(_SCREEN_WIDTH - 40 - 36, MAXFLOAT) labelFont:14 labelText:str];

    
    [self.robotTableView addMOde:data post:NO];
    

}
/**
 *  声音输入状态
 *
 *  @param state yes开始 no结束
 */
- (void)voiceState:(BOOL)state;
{


}
/**
 *  技能状态
 *
 *  @param state yes打开 no关闭
 */
- (void)skillState:(BOOL)state;
{


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

    
}


#pragma mark -----------WXVoiceDelegate------------
//识别成功，返回结果，元素类型为WXVoiceResult，现阶段数组内只有一个元素
- (void)voiceInputResultArray:(NSArray *)array{
    //一旦此方法被回调，array一定会有一个值，所以else的情况不会发生，但写了会更有安全感的
    if (array && array.count>0) {
//        WXVoiceResult *result=[array objectAtIndex:0];

    }else{
     
    }
}
//出现错误，错误码请参见官方网站
- (void)voiceInputMakeError:(NSInteger)errorCode{
    NSLog(@"%d",errorCode);

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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
