//
//  ZKMainTopicTableViewCell.m
//  cyPZH
//
//  Created by 王小腊 on 16/6/14.
//  Copyright © 2016年 王小腊. All rights reserved.
//

NSString *const ZKMainTopicTableViewCellID = @"ZKMainTopicTableViewCellID";

#import "ZKMainTopicTableViewCell.h"
#import "ZKMainHeaderMode.h"
#import "ZKBaseWebViewController.h"

@implementation ZKMainTopicTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setLinkList:(NSArray<ZKMainLink *> *)linkList
{
    _linkList = linkList;
    if (linkList.count < 4) {return;}
    
    ZKMainLink *list_0 = linkList[0];
    [self setBackImage:self.lefButton imageUrl:list_0.img];
    
    ZKMainLink *list_1 = linkList[1];
    [self setBackImage:self.topButton imageUrl:list_1.img];
    
    ZKMainLink *list_2 = linkList[2];
    [self setBackImage:self.botmLefButton imageUrl:list_2.img];
    
    ZKMainLink *list_3 = linkList[3];
    [self setBackImage:self.botmRitButton imageUrl:list_3.img];

    
    
}
- (void)setBackImage:(UIButton*)bty imageUrl:(NSString*)url
{
    
    NSString *str = [NSString stringWithFormat:@"%@%@",IMAGE_URL,url];
//
    [ZKUtil UIButtonImage:bty NSSting:str];
    
}
- (IBAction)topicClick:(UIButton *)sender {
    
    NSInteger index = sender.tag - 1000;
    
    if (index == 0)
    {
        
      [[self.controller navigationController] pushViewController:[NSClassFromString(@"ZKRobotViewController") new] animated:YES];
    }
    else
    {
    
        ZKMainLink *list = [_linkList objectAtIndex:index];
        
        ZKBaseWebViewController *web = [[ZKBaseWebViewController alloc]init];
        web.htmlUrl = list.url;
        [[self.controller navigationController] pushViewController:web animated:YES];

    }
    
}

@end
