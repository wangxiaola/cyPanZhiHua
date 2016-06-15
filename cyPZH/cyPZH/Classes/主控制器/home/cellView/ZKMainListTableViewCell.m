//
//  ZKMainListTableViewCell.m
//  cyPZH
//
//  Created by 王小腊 on 16/6/14.
//  Copyright © 2016年 王小腊. All rights reserved.
//

NSString *const ZKMainListTableViewCellID = @"ZKMainListTableViewCellID";
#import "ZKMainListTableViewCell.h"
#import "ZKMainHeaderMode.h"

@implementation ZKMainListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.cellImageView.contentMode = UIViewContentModeScaleAspectFill;
}
- (void)setTopicList:(ZKMainTopic *)topicList
{
    [self setBackImageUrl:topicList.img];
    
}
- (void)setProductList:(ZKMainProduct *)productList
{
    [self setBackImageUrl:productList.img];
}

- (void)setBackImageUrl:(NSString*)str
{

    NSString *url = [NSString stringWithFormat:@"%@%@",IMAGE_URL,str];
    [ZKUtil UIimageView:self.cellImageView NSSting:url duImage:@"daohuang_ default"];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
