//
//  ZKRobotStateTableViewCell.m
//  cyPZH
//
//  Created by 王小腊 on 16/6/12.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import "ZKRobotStateTableViewCell.h"
#import "ZKRobotMode.h"
#import "UIImage+CircleImage.h"

@implementation ZKRobotStateTableViewCell

{
    
    UIImageView *backImageView;
    
    UILabel *infoLabel;
    
    UIImageView *portraitImageView;
    
    UIView *stateViews;
    
    NSMutableArray <UIButton*>*array;
    
    NSMutableArray <NSString*>*titelArray;
    
    NSDictionary *robotDic;
    
    clickState cellState;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        //1.添加子控件
        [self setupUI];
        
    }
    return self;
}

- (void)setupUI
{
    array = [NSMutableArray array];
    titelArray = [NSMutableArray array];
    
    portraitImageView = [[UIImageView alloc] init];
    [self addSubview:portraitImageView];
    
    backImageView = [[UIImageView alloc] init];
    backImageView.backgroundColor = [UIColor clearColor];
    backImageView.userInteractionEnabled = YES;
    UIImage *image = [UIImage imageNamed:@"input"];
    backImageView.image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.8];
    [self addSubview:backImageView];
    
    infoLabel = [[UILabel alloc] init];
    infoLabel.numberOfLines = 0;
    infoLabel.textColor = [UIColor blackColor];
    infoLabel.font = [UIFont systemFontOfSize:13];
    infoLabel.textAlignment = NSTextAlignmentLeft;
    [backImageView addSubview:infoLabel];
    
    [portraitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.height.mas_equalTo(40);
        make.top.mas_equalTo(14);
        make.left.mas_equalTo(self.mas_left).offset(12);
        
    }];
    
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(portraitImageView.mas_right).offset(12);
        make.top.mas_equalTo(14);
        make.left.mas_greaterThanOrEqualTo(12);
    }];
    
    [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(backImageView.mas_left).offset(12);
        make.right.mas_lessThanOrEqualTo(self.mas_right).offset(-24);
        make.right.mas_equalTo(backImageView.mas_right).offset(-12);
        make.top.mas_equalTo(backImageView.mas_top).offset(6);

    }];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
}


- (void)setList:(ZKRobotMode *)list
{
    

    robotDic = list.rootList;
    // NSTextAttachment - 附件
    // 1.创建文本附件包含图片，知道附件 bounds
    NSTextAttachment *attachMent = [[NSTextAttachment alloc] init];
    
    // 设置图片
    attachMent.image = [UIImage imageNamed: @"right"];
    
    // 设置大小
    CGFloat height = infoLabel.font.lineHeight;
    attachMent.bounds = CGRectMake(12, 0, height-10, height-6);
    
    // 添加
    // 2.使用附件创建属性字符串
    NSAttributedString *attrString = [NSAttributedString attributedStringWithAttachment:attachMent];
    
    NSString *makeStr = [NSString stringWithFormat:@"“%@”",[robotDic valueForKey:@"name"]];
    NSString *nameStr = [NSString stringWithFormat:@"%@为您推荐",list.name];
    // 拼接文字
    NSString *str = [NSString stringWithFormat:@"%@%@!   ",nameStr,makeStr];
    // 3.创建可变字符 拼接字符串
    NSMutableAttributedString *strM = [[NSMutableAttributedString alloc] initWithString:str];
    
    NSRange redRange = NSMakeRange(nameStr.length, makeStr.length);
      [strM addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:redRange];
    [strM appendAttributedString:attrString];

    infoLabel.attributedText = strM;
    //计算文本大小
    NSRange range = NSMakeRange(0, strM.length);
    NSDictionary *dic = [strM attributesAtIndex:0 effectiveRange:&range];
    CGSize textSize = [infoLabel.text boundingRectWithSize:CGSizeMake(_SCREEN_WIDTH - 40 - 36, MAXFLOAT) // 用于计算文本绘制时占据的矩形块
                                                        options:NSStringDrawingUsesFontLeading
                                                     attributes:dic        // 文字的属性
                                                        context:nil].size;

    portraitImageView.image = [list.potoImage circleImage];

    
    [array enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [obj removeFromSuperview];
    }];
    
    [titelArray removeAllObjects];
    [array removeAllObjects];
    
    if ([robotDic valueForKey:@"longitude"])
    {
        
        [titelArray addObject:@"导航去"];
    }
    
    if (strIsEmpty([robotDic valueForKey:@"phone"]))
    {
        [titelArray addObject:@"打电话"];
    }
    
    if ([robotDic valueForKey:@"dataid"])
    {
        [titelArray addObject:@"景区详情"];
    }
    
    float cellHeight = titelArray.count<3?32:58;
    
    list.size = CGSizeMake(textSize.width, textSize.height+cellHeight);
    
    [backImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(list.size.height+16);
    }];
    
    for (int i = 0; i<titelArray.count; i++) {
        
        UIButton *bty = [UIButton buttonWithType:UIButtonTypeCustom];
        [bty setBackgroundImage:[UIImage imageNamed:@"icon"] forState:UIControlStateNormal];
        [bty setBackgroundImage:[UIImage imageNamed:@"icon-pre"] forState:UIControlStateHighlighted];
        bty.titleLabel.font = [UIFont systemFontOfSize:13];
        [bty setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [bty setTitle:titelArray[i] forState:UIControlStateNormal];
        [bty addTarget:self action:@selector(stateClick:) forControlEvents:UIControlEventTouchUpInside];
        bty.frame = CGRectMake(12+76*(i%2),(textSize.height+18)+25*(i/2), 70, 20);
        [backImageView addSubview:bty];
        [array addObject:bty];
        
    }
    
}


- (void)stateClick:(UIButton*)sender
{
    NSString *key = sender.titleLabel.text;
   
    if ([key isEqualToString:@"导航去"]) {
        
        cellState = clickStateNav;
    }
    else if ([key isEqualToString:@"打电话"])
    {
         cellState = clickStatephone;
        
    }else if ([key isEqualToString:@"景区详情"])
    {
    
         cellState = clickStateList;
    }
    
    if ([self.stateDelegate respondsToSelector:@selector(touchData:clickType:)]) {
        
        [self.stateDelegate touchData:robotDic clickType:cellState];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
