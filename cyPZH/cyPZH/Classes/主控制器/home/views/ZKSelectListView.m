//
//  ZKSelectListView.m
//  CYmiangzhu
//
//  Created by 王小腊 on 16/5/18.
//  Copyright © 2016年 WangXiaoLa. All rights reserved.
//

#import "ZKSelectListView.h"
#import "YYSearchBar.h"

@implementation ZKSelectListView
{
    YYSearchBar * _searchBar;
    NSMutableArray * _qtButtonArray;
}



- (instancetype)initWithFrame:(CGRect)frame sceneryType:(NSInteger)dex;

{
    
    self = [super initWithFrame:frame];
    
    if (self)
    {
        
        self.backgroundColor = TabelBackCorl;
        _searchBar = [[YYSearchBar alloc] initWithFrame:CGRectMake(10, 5, _SCREEN_WIDTH-20, 26)];
        _searchBar.backgroundColor = [UIColor clearColor];
        _searchBar.placeString = @"输入搜索";
        _searchBar.isWeeter = YES;
        _searchBar.layer.masksToBounds = YES;
        _searchBar.layer.cornerRadius = 18;
        _searchBar.userInteractionEnabled = YES;
        [self addSubview:_searchBar];

        if (dex!=2)
        {
            NSArray * listArray = @[@"全部",@"按价格",@"按距离",@"筛选"];
            _qtButtonArray = [NSMutableArray arrayWithCapacity:4];
            float buttonW = _SCREEN_WIDTH/4;
            
            for (int i = 0; i<4; i++)
            {
                
                UIButton *titleButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonW*i,frame.size.height - 30, buttonW, 30)];
                titleButton.backgroundColor = [UIColor whiteColor];
                [titleButton setImage:[UIImage imageNamed:@"home_xiala"] forState:UIControlStateNormal];
                [titleButton setImageEdgeInsets:UIEdgeInsetsMake(0,buttonW-24, 0, 0)];
                [titleButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 18)];
                [titleButton setTitle:listArray[i] forState:UIControlStateNormal];
                [titleButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                titleButton.titleLabel.font = [UIFont systemFontOfSize:13];
                titleButton.tag = i;
                [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:titleButton];
                [_qtButtonArray addObject:titleButton];
                
                if (i < 3)
                {
                    UIView *lin = [[UIView alloc] initWithFrame:CGRectMake(buttonW-1, 8, 1, 30-16)];
                    lin.backgroundColor = TabelBackCorl;
                    [titleButton addSubview:lin];
                    
                }
                
            }
            
            [self selectBtton:0];

            
        }
        
        
    }
    
    return self;
}



/**
 *  选择那个
 *
 *  @param index tag
 */
- (void)selectBtton:(NSInteger)index
{

        [_qtButtonArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            UIButton *bty = obj;
            UIColor *titiColor  = idx == index ? CYBColorGreen:[UIColor grayColor];
            NSString *imageName = idx == index ? @"home_shangla_pre":@"home_xiala";
            [bty setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
            [bty setTitleColor:titiColor forState:UIControlStateNormal];
        }];

}
#pragma mark 点击事件
- (void)titleClick:(UIButton*)sender
{
    
    [self selectBtton:sender.tag];
    
}

#pragma mark - searchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    [_searchBar resignFirstResponder];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_searchBar resignFirstResponder];
    
}



/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
