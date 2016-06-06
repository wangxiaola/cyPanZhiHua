//
//  ZKErrorView.m
//  cyPZH
//
//  Created by 王小腊 on 16/6/6.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import "ZKErrorView.h"

@interface ZKErrorView()

@property (nonatomic, weak) UILabel *promptLabel;

@end

@implementation ZKErrorView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *promptImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_data"]];
        [self addSubview:promptImageView];
        
                UILabel *promptLabel = [[UILabel alloc] init];
                promptLabel.textAlignment = NSTextAlignmentCenter;
                promptLabel.font = [UIFont systemFontOfSize:13];
                [self addSubview:promptLabel];
                self.promptLabel = promptLabel;
        
        MJWeakSelf
        [promptImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf);
        }];
                [promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(promptImageView.mas_bottom);
                    make.bottom.and.left.and.right.equalTo(weakSelf);
                }];


    }
    return self;
}

- (void)setPrompt:(NSString *)prompt
{
    _prompt = prompt;
    self.promptLabel.text = prompt;
}

@end
