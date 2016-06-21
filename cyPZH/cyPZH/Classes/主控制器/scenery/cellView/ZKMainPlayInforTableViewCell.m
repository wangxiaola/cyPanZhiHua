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

}

- (void)setSceneryList:(ZKMainSceneryMode *)sceneryList
{
   
    [ZKUtil UIimageView:self.backImageViw NSSting:[NSString stringWithFormat:@"%@%@",IMAGE_URL_CSW,sceneryList.logosmall] duImage:@"daohuang_ default"];
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[sceneryList.summary dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    self.infoLabel.attributedText = attrStr;

    self.nameLabel.text = sceneryList.name;

}

- (void)updataLick:(NSInteger)lick number:(NSString*)num;
{
    [self.likeButton setTitle:[NSString stringWithFormat:@"%d",lick] forState:UIControlStateNormal];
    [self.numberButton setTitle:num forState:UIControlStateNormal];

}
- (IBAction)numberClick {
    
    
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
