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

@interface ZKRobotViewController ()<WXVoiceDelegate>

@end

@implementation ZKRobotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initWXSDK];
    [self initViews];
}
#pragma mark  ----
#pragma mark  ---- 界面布局 ----
/**
 *  初始化视图
 */
- (void)initViews

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
