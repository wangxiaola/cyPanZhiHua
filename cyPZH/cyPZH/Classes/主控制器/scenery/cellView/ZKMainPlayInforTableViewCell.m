//
//  ZKMainPlayInforTableViewCell.m
//  cyPZH
//
//  Created by 王小腊 on 16/6/21.
//  Copyright © 2016年 王小腊. All rights reserved.
//

NSString *const ZKMainPlayInforTableViewCellID = @"ZKMainPlayInforTableViewCellID";

#import "ZKMainPlayInforTableViewCell.h"
#import "ZKMainSceneryMode.h"

@implementation ZKMainPlayInforTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //    self.webView.delegate = self;
    // Initialization code
    UILabel * stateLabel = [[UILabel alloc] init];
    stateLabel.textColor = [UIColor whiteColor];
    stateLabel.font = [UIFont systemFontOfSize:12];
    stateLabel.numberOfLines = 2;
    stateLabel.text = @"用户对平台内景区实景视频的\"喜欢\"热度排名";
    [self.popView addSubview:stateLabel];
    
    [stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(6);
        make.left.right.mas_equalTo(4);
        make.bottom.mas_equalTo(-4);
    }];
}

- (void)setSceneryList:(ZKMainSceneryMode *)sceneryList
{
    
    [ZKUtil UIimageView:self.backImageViw NSSting:[NSString stringWithFormat:@"%@%@",IMAGE_URL_CSW,sceneryList.logosmall] duImage:@"daohuang_ default"];
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[sceneryList.summary dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    self.infoTextView.attributedText = attrStr;
    
    self.nameLabel.text = sceneryList.name;
    
}

- (void)updataLick:(NSInteger)lick number:(NSString*)num;
{
    [self.likeButton setTitle:[NSString stringWithFormat:@"%ld",(long)lick] forState:UIControlStateNormal];
    [self.numberButton setTitle:num forState:UIControlStateNormal];
    
}
- (IBAction)numberClick:(UIButton *)sender {
    
    if (sender.selected == NO)
    {
        self.popView.hidden = NO;
        
        int64_t delayInSeconds = 2;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
          self.popView.hidden = YES;
        });
        
    }
    else
    {
        
        self.popView.hidden = YES;
    }
}

- (IBAction)lickClick {
    
    
}

#pragma mark webDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView;
{
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
