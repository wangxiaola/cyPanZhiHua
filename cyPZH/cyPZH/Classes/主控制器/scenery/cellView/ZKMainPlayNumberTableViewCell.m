//
//  ZKMainPlayNumberTableViewCell.m
//  cyPZH
//
//  Created by 王小腊 on 16/6/20.
//  Copyright © 2016年 王小腊. All rights reserved.
//

NSString *const playNumberTableViewCellID = @"playNumberTableViewCellID";

#import "ZKMainPlayNumberTableViewCell.h"
#import "ZKMainSceneryMode.h"
#import "ZKPlayMapButton.h"

@implementation ZKMainPlayNumberTableViewCell
{
    NSArray *array;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (NSMutableArray<ZKPlayMapButton *> *)annonArray
{
    if (!_annonArray) {
        
        _annonArray = [NSMutableArray array];
    }
    return _annonArray;
}
- (void)updatListIndex:(NSInteger)row;
{
    ZKMainSceneryMode *list = array[row];
    
    if ([self.delegate respondsToSelector:@selector(selectAnnotation:index:)] && row!=0)
    {
        [self.delegate selectAnnotation:list index:row];
    }
    
    self.peopleNumberLabel.text = @"5";
    self.dqPeopelNumberLabel.text = [NSString stringWithFormat:@"%ld",(long)list.rtnumber];
    self.czNumberLabel.text = [NSString stringWithFormat:@"%ld",(long)list.frontmax];
    self.comfortLabel.text = strIsNull(list.yjd);
    self.TemperatureLabel.text = [NSString stringWithFormat:@"%@ ~ %@°C",list.t1,list.t2];
    self.nameLabel.text = strIsNull(list.name);
    
    [self.pmtView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.pmtView.clipsToBounds = YES;
    [self beginAnimationWithTitle:strIsNull(list.name)];
    
    [self.annonArray enumerateObjectsUsingBlock:^(ZKPlayMapButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString *imageName = idx==row ? @"scenery_icon_3":@"scenery_icon_3_pre";
        [obj setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        UIColor *color = idx==row?RGB(244, 86, 9):[UIColor grayColor];
        obj.labelColor = color;
    }];
}

- (void)showAnnonViews:(NSArray<ZKMainSceneryMode*>*)data selct:(NSInteger)row;
{
    array = data;
    NSInteger imageW  = _SCREEN_WIDTH -100;
    NSInteger imageH  = 200;
    [self.annonArray removeAllObjects];
    [self.mapImageView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [data enumerateObjectsUsingBlock:^(ZKMainSceneryMode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        float x = arc4random()%imageW+50;
        float y = arc4random()%imageH+20;
        ZKPlayMapButton *bty = [[ZKPlayMapButton alloc] initWithFrame:CGRectMake(x, y, 16, 20)];
        [bty setImage:[UIImage imageNamed:@"scenery_icon_3_pre"] forState:UIControlStateNormal];
        bty.popName = obj.name;
        bty.tag = idx;
        [bty addTarget:self action:@selector(annonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.mapImageView addSubview:bty];
        [self.annonArray addObject:bty];
        
    }];
    
    [self updatListIndex:row];
}
- (IBAction)sceneryClick {
    
    
}
- (IBAction)shareClick {
    
    
}
/**
 *  气泡点击
 */
- (void)annonClick:(UIButton*)sender
{
    [self updatListIndex:sender.tag];
}

- (void)beginAnimationWithTitle:(NSString *)title
{
    
    NSString *extendedTitle = [NSString stringWithFormat:@"    %@    ", title];
    CGSize labelSize = [extendedTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:0 attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil].size;
    
    for (int i = 0; i < 2; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.text = extendedTitle;
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:15];
        label.frame = CGRectMake(i * labelSize.width, 0, labelSize.width, 30);
        [_pmtView addSubview:label];
        
        CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
        anim.toValue = @(-label.frame.size.width);
        anim.repeatCount = MAXFLOAT;
        anim.duration = title.length / 1.8;
        anim.fillMode = kCAFillModeForwards;
        anim.removedOnCompletion = NO;
        [label.layer addAnimation:anim forKey:nil];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
