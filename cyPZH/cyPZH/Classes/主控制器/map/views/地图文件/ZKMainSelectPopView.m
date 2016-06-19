//
//  ZKMainSelectPopView.m
//  cyPZH
//
//  Created by 小腊 on 16/6/19.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import "ZKMainSelectPopView.h"
#import "ZKMainMapMode.h"

@implementation ZKMainSelectPopView
{

    UIImageView *headerImage;
    UILabel *nameLabel;
    UIButton *phoneButton;
    UIButton *adderButton;
    ZKMainMapMode *modes;
    
    
}
- (instancetype)initWithFrame:(CGRect)frame;
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        //背景
        UIImageView *backImageView = [[UIImageView alloc] init];
        [backImageView setImage:[UIImage imageNamed:@"map_bg"]];
        backImageView.userInteractionEnabled = YES;
        [self addSubview:backImageView];
        [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.bottom.right.mas_equalTo(0);
            make.height.mas_equalTo(74);
        }];
        
        //头像
        float headerHeight = 74-16;
        headerImage = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, headerHeight, headerHeight)];
        [backImageView addSubview:headerImage];

        //720
        UIImageView *lefImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"map_720"]];
        [headerImage addSubview:lefImageView];
        
        [lefImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(4);
        }];
        
       //导航
        UIButton *bty =[UIButton buttonWithType:UIButtonTypeCustom];
        [backImageView addSubview:bty];
        bty.layer.borderColor = [UIColor whiteColor].CGColor;
        bty.layer.borderWidth = 1.4;
        [bty setBackgroundImage:[UIImage imageNamed:@"map_go"] forState:UIControlStateNormal];
        [bty addTarget:self action:@selector(navMap) forControlEvents:UIControlEventTouchUpInside];
        [bty mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(backImageView.mas_right).offset(-40);
            make.centerY.mas_equalTo(backImageView.mas_top);
            make.width.height.mas_equalTo(60);
        }];
        //名字
        nameLabel = [[UILabel alloc]init];
        nameLabel.font = [UIFont systemFontOfSize:14];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.text = @"1282828";
        [backImageView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(headerImage.mas_right).offset(8);
            make.top.mas_equalTo(backImageView).offset(8);
            make.height.mas_equalTo(21);
            make.right.mas_equalTo(bty.mas_left).offset(-8);
        }];
        //电话
        phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [phoneButton setImage:[UIImage imageNamed:@"map_phone"] forState:UIControlStateNormal];
        [phoneButton addTarget:self action:@selector(phoneClick) forControlEvents:UIControlEventTouchUpInside];
        [phoneButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        phoneButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [backImageView addSubview:phoneButton];
        
        [phoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(headerImage.mas_right).offset(8);
            make.centerY.mas_equalTo(headerImage.mas_centerY);
            make.height.mas_equalTo(16);
            
        }];
        
        //地址
        adderButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [adderButton setImage:[UIImage imageNamed:@"map_address"] forState:UIControlStateNormal];
        [adderButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        adderButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [backImageView addSubview:adderButton];
        
        [adderButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(headerImage.mas_right).offset(8);
            make.bottom.mas_equalTo(headerImage.mas_bottom).offset(0);
            make.height.mas_equalTo(16);
            
        }];
     // 右边点击
        UIButton *ritButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [ritButton addTarget:self action:@selector(ritClick) forControlEvents:UIControlEventTouchUpInside];
        [ritButton setImage:[UIImage imageNamed:@"map_right"] forState:UIControlStateNormal];
        [backImageView addSubview:ritButton];
        [ritButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(8);
            make.height.mas_equalTo(12);
            make.centerY.mas_equalTo(backImageView.mas_centerY);
            make.right.mas_equalTo(backImageView.mas_right).offset(-14);
        }];
    }
    
    return self;
}
//更新
- (void)updatePopView:(ZKMainMapMode*)list;
{
    modes = list;
    NSString *phon = [NSString stringWithFormat:@"  %@",strIsNull(list.phone)];
    NSString *adder = [NSString stringWithFormat:@"  %@",strIsNull(list.address)];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",IMAGE_URL_CSW,list.logosmall];
    [ZKUtil UIimageView:headerImage NSSting:url duImage:@"guanggo_ default"];
    [phoneButton setTitle:phon forState:UIControlStateNormal];
    [adderButton setTitle:adder forState:UIControlStateNormal];
}
#pragma mark 点击
- (void)navMap
{
    if ([self.delegate respondsToSelector:@selector(navMap:)]) {
        [self.delegate navMap:modes];
    }

}
- (void)phoneClick
{
    NSString *ls = modes.phone;
    UIWebView *webView = [[UIWebView alloc]init];
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",[ls stringByReplacingOccurrencesOfString:@"—" withString:@""]];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self addSubview:webView];

}
- (void)ritClick
{
    if ([self.delegate respondsToSelector:@selector(navDetails:)]) {
        [self.delegate navDetails:modes];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
