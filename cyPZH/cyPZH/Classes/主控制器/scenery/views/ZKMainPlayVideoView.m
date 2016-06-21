//
//  ZKMainPlayVideoView.m
//  cyPZH
//
//  Created by 王小腊 on 16/6/20.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import "ZKMainPlayVideoView.h"
#import "WMPlayer.h"
#import "ZKMainSceneryMode.h"

static NSString *const playNormal = @"scenery_icon_play";
static NSString *const playHighlighted = @"scenery_icon_suspend";

@interface ZKMainPlayVideoView ()

@property (nonatomic, strong) WMPlayer * wmPlayer;
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UIButton *playButton;

@end

@implementation ZKMainPlayVideoView
- (WMPlayer *)wmPlayer
{
    if (!_wmPlayer) {
        
        _wmPlayer = [[WMPlayer alloc]initWithFrame:CGRectMake(0, 0, _SCREEN_WIDTH, self.frame.size.height) videoURLStr:@"http:183.221.61.239:83/Movies/pazhihua5/pazhihua5.m3u8"];
        _wmPlayer.closeBtn.hidden = YES;
    }
    return _wmPlayer;
}

- (instancetype)initWithFrame:(CGRect)frame;
{

    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.backImageView.image = [UIImage imageNamed:@"daohuang_ default"];
        self.backImageView.userInteractionEnabled = YES;
        [self addSubview:self.backImageView];
        
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
    
    return self;
}

- (void)updateVideo:(ZKMainSceneryMode*)list;
{
    [self destroyVideo];
    [ZKUtil UIimageView:self.backImageView NSSting:[NSString stringWithFormat:@"%@%@",IMAGE_URL_CSW,list.logosmall] duImage:@"daohuang_ default"];
    NSString *playUrl = [NSString stringWithFormat:@"http:%@",list.url];
   [self.wmPlayer setVideoURLStr:playUrl];
    
}

- (void)destroyVideo;
{
    [_wmPlayer.player pause];
    [_wmPlayer.player.currentItem cancelPendingSeeks];
    [_wmPlayer.player.currentItem.asset cancelLoading];
    [_wmPlayer.playerLayer removeFromSuperlayer];
    [_wmPlayer.player replaceCurrentItemWithPlayerItem:nil];
    [_wmPlayer removeFromSuperview];
    _wmPlayer = nil;
    _wmPlayer.player = nil;
    _wmPlayer.currentItem = nil;
    _wmPlayer.playerLayer = nil;

}
- (void)playSateClick:(UIButton*)sender
{
    if (sender.selected == NO)
    {
        sender.selected = YES;
        [self.wmPlayer.player play];
        self.backImageView.hidden = YES;
    }
    else
    {
        sender.selected = NO;
        [self.wmPlayer.player pause];
    
    }
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

    NSLog(@" --- ");
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
