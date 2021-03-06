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
    NSArray * listArray;
    NSInteger _type;
    NSArray *dataArray;
    NSMutableArray * _flotWArray;
    UIScrollView * _scollView;
    float _scollW;
    NSMutableArray * _mpButtonArray;
    NSInteger jlSate;
}



- (instancetype)initWithFrame:(CGRect)frame sceneryType:(NSInteger)dex superView:(UIView*)contenView;

{
    
    self = [super initWithFrame:frame];
    
    if (self)
    {

        _type = dex;
        jlSate = -1;
        self.backgroundColor = TabelBackCorl;
        float searchHeight ;
        
        if (dex == 2)
        {
            searchHeight = frame.size.height - 10;
        }
        else
        {
            searchHeight = 26;
        }
        _searchBar = [[YYSearchBar alloc] initWithFrame:CGRectMake(10, 5, _SCREEN_WIDTH-20, searchHeight)];
        _searchBar.backgroundColor = [UIColor clearColor];
        _searchBar.placeString = @"输入搜索";
        _searchBar.isWeeter = YES;
        _searchBar.delegate = self;
        _searchBar.layer.masksToBounds = YES;
        _searchBar.layer.cornerRadius = 18;
        _searchBar.userInteractionEnabled = YES;
        [self addSubview:_searchBar];
        
        
        
        
        if (dex!=2)
        {
            
            _scollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,frame.size.height+64 , _SCREEN_WIDTH, 0)];
            _scollView.backgroundColor = [UIColor whiteColor];
            _scollView.contentOffset =CGPointMake(0, 0);
            _scollView.showsHorizontalScrollIndicator =NO;
            [contenView addSubview:_scollView];
            
            
            listArray = [self setArray:dex];
            _qtButtonArray = [NSMutableArray arrayWithCapacity:4];
            float buttonW = _SCREEN_WIDTH/4;
            
            for (int i = 0; i<4; i++)
            {
                
                UIButton *titleButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonW*i,frame.size.height - 30, buttonW, 30)];
                titleButton.backgroundColor = [UIColor whiteColor];
                [titleButton setImage:[UIImage imageNamed:@"home_xiala"] forState:UIControlStateNormal];
                [titleButton setImageEdgeInsets:UIEdgeInsetsMake(0,buttonW-24, 0, 0)];
                [titleButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 18)];
                [titleButton setTitle:[listArray[i] valueForKey:@"key"] forState:UIControlStateNormal];
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
            
            [self selectBtton:0 isScollView:NO];
            
            
        }
        
        
    }
    
    return self;
}

- (void)showSelectView:(NSArray*)data
{
    dataArray = data;

    [_scollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_flotWArray removeAllObjects];
    [_mpButtonArray removeAllObjects];
    
    _scollW = 0.0f;
    _flotWArray = [NSMutableArray arrayWithCapacity:data.count];
    _mpButtonArray = [NSMutableArray arrayWithCapacity:data.count];
    
    [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSDictionary * dic = obj;
        NSString *name = [dic valueForKey:@"key"];
        float w = [self labelCgsizeFlot:13 Titis:name];
        _scollW = _scollW + w;
        //添加所有的字符宽度
        [_flotWArray addObject:[NSString stringWithFormat:@"%f",w]];
        
    }];
    _scollView.contentSize =CGSizeMake(_scollW+(data.count+1)*8,0);
    
    float addW = 0;
    for (int i = 0 ; i < data.count; i++) {
        
        float w = [_flotWArray[i] doubleValue];
        
        UIButton *titleButton = [[UIButton alloc] initWithFrame:CGRectMake(6+addW+6*i,7.5, w, 15)];
        titleButton.backgroundColor = [UIColor whiteColor];
        NSString *name = [data[i] valueForKey:@"key"];
        [titleButton setTitle:name forState:UIControlStateNormal];
        titleButton.titleLabel.font = [UIFont systemFontOfSize:12];
        titleButton.tag = i;
        [titleButton addTarget:self action:@selector(scollClick:) forControlEvents:UIControlEventTouchUpInside];
        [_scollView addSubview:titleButton];
        [_mpButtonArray addObject:titleButton];
        addW = addW + w;
    }
    
    [self selectBtton:0 isScollView:YES];
    
}

/**
 *  选择那个
 *
 *  @param index tag
 */
- (void)selectBtton:(NSInteger)index isScollView:(BOOL)isScoll
{
    if (isScoll)
    {

        [_mpButtonArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            UIButton *bty = obj;
            
            NSString *imageName = idx == index ? @"table_btn_select_pre":@"table_btn_select";
            UIImage *image = [UIImage imageNamed:imageName];
            
            [bty setBackgroundImage:[image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5] forState:UIControlStateNormal];
            UIColor *titiColor  = idx == index ? [UIColor whiteColor]:[UIColor grayColor];
            [bty setTitleColor:titiColor forState:UIControlStateNormal];
        }];
        
    }
    else
    {
        [_qtButtonArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            UIButton *bty = obj;
            UIColor *titiColor  = idx == index ? CYBColorGreen:[UIColor grayColor];
            NSString *imageName = idx == index ? @"home_shangla_pre":@"home_xiala";
            [bty setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
            [bty setTitleColor:titiColor forState:UIControlStateNormal];
        }];
        
        
    }
    
}
#pragma mark 点击事件
- (void)titleClick:(UIButton*)sender
{
    [self endEditing:YES];
    [self selectBtton:sender.tag isScollView:NO];
    
    NSArray *array = [[listArray objectAtIndex:sender.tag] valueForKey:@"array"];
    
    float scollH = _scollView.frame.size.height == 30?0:30;
    if (array.count == 0)
    {
        scollH = 0;
        if ([self.delegate respondsToSelector:@selector(condition:typeList:index:)])
        {
            
            [self.delegate condition:@"" typeList:_type index:sender.tag];
        }
        
    }
    else
    {
        if (jlSate != sender.tag)
        {
        scollH = 30;
        jlSate = sender.tag;
        [self showSelectView:array];
  
        }
  
   
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        
        _scollView.frame =  CGRectMake(0,self.frame.size.height+64, _SCREEN_WIDTH, scollH);
    }];

    
}
/**
 *  下栏目点击
 *
 *  @param sender
 */
- (void)scollClick:(UIButton*)sender
{
    [self endEditing:YES];
    if ([self.delegate respondsToSelector:@selector(condition:typeList:index:)])
    {
       
        [self.delegate condition:[dataArray[sender.tag] valueForKey:@"type"] typeList:_type index:jlSate];
    }

    
    [UIView animateWithDuration:0.2 animations:^{
        
        _scollView.frame =  CGRectMake(0,self.frame.size.height+64, _SCREEN_WIDTH, 0);
    }];
    
}
#pragma mark - searchBarDelegate

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar;
{
    
    if ([self.delegate respondsToSelector:@selector(seekName:)])
    {
        NSString *str = searchBar.text.length == 0 ? @"":searchBar.text;
        [self.delegate seekName:str];
    }
}

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


#pragma mark  选择参数

// 返回可选数组
- (NSArray*)setArray:(NSInteger)row
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:4];
    
    
    switch (row) {
        case 0:
            
            [array addObject:@{@"key":@"全部",@"array":@[]}];
            [array addObject:@{@"key":@"按等级",@"array":[self ztypeArray]}];
            [array addObject:@{@"key":@"按主题",@"array":[self themeArray]}];
            [array addObject:@{@"key":@"按距离",@"array":[self distanceArray]}];
            
            break;
        case 1:
            
            [array addObject:@{@"key":@"全部",@"array":@[]}];
            [array addObject:@{@"key":@"按价格",@"array":[self priceArray]}];
            [array addObject:@{@"key":@"按星级",@"array":[self gradeArray]}];
            [array addObject:@{@"key":@"按距离",@"array":[self distanceArray]}];
            
            break;
            
        case 3:
            
            [array addObject:@{@"key":@"全部",@"array":@[]}];
            [array addObject:@{@"key":@"按推荐",@"array":@[]}];
            [array addObject:@{@"key":@"按栏目",@"array":[self typeArray]}];
            [array addObject:@{@"key":@"按最新",@"array":@[]}];
            
            break;
            
        default:
            break;
    }
    
    return array;
    
}


//等级
- (NSArray*)ztypeArray
{
    NSArray *array = [NSArray arrayWithObjects:
                      @{@"key":@"不限",@"type":@""},
                      @{@"key":@"5A",@"type":@"viewType_16"},
                      @{@"key":@"4A",@"type":@"viewType_15"},
                      @{@"key":@"3A",@"type":@"viewType_14"},
                      @{@"key":@"2A",@"type":@"viewType_13"},
                      @{@"key":@"1A",@"type":@"viewType_12"}, nil];
    return array;
}
//主题
- (NSArray*)themeArray
{
    NSArray *array = [NSArray arrayWithObjects:
                      @{@"key":@"不限",@"type":@""},
                      @{@"key":@"世界文化遗产",@"type":@"viewType_18"},
                      @{@"key":@"世界自然遗产",@"type":@"viewType_19"},
                      @{@"key":@"国家级-风景名胜",@"type":@"viewType_21"},
                      @{@"key":@"省级-风景名胜",@"type":@"viewType_22"},
                      @{@"key":@"国家级-森林公园",@"type":@"viewType_23"},
                      @{@"key":@"省级-森林公园",@"type":@"viewType_24"},nil];
    return array;
}
//距离
- (NSArray*)distanceArray
{
    NSArray *array = [NSArray arrayWithObjects:
                      @{@"key":@"不限",@"type":@""},
                      @{@"key":@"1km",@"type":@"1"},
                      @{@"key":@"2km",@"type":@"2"},
                      @{@"key":@"3km",@"type":@"3"},
                      @{@"key":@"4km",@"type":@"4"},
                      @{@"key":@"5km",@"type":@"5"},
                      @{@"key":@"6km",@"type":@"6"},
                      @{@"key":@"7km",@"type":@"7"},
                      @{@"key":@"8km",@"type":@"8"},
                      @{@"key":@"9km",@"type":@"9"},
                      @{@"key":@"10km",@"type":@"10"},nil];
    return array;
}
//价格
- (NSArray*)priceArray
{
    NSArray *array = [NSArray arrayWithObjects:
                      @{@"key":@"不限",@"type":@""},
                      @{@"key":@"100以下",@"type":@"100-0"},
                      @{@"key":@"100-150",@"type":@"100-150"},
                      @{@"key":@"150-200",@"type":@"150-200"},
                      @{@"key":@"200-300",@"type":@"200-300"},
                      @{@"key":@"300以上",@"type":@"300-1000"},nil];
    return array;
}
//星级
- (NSArray*)gradeArray
{
    NSArray *array = [NSArray arrayWithObjects:
                      @{@"key":@"不限",@"type":@""},
                      @{@"key":@"5星",@"type":@"hotelStarLevel_5"},
                      @{@"key":@"4星",@"type":@"hotelStarLevel_4"},
                      @{@"key":@"3星",@"type":@"hotelStarLevel_3"},
                      @{@"key":@"2星",@"type":@"hotelStarLevel_2"},
                      @{@"key":@"1星",@"type":@"hotelStarLevel_1"},
                      @{@"key":@"未评星",@"type":@"hotelStarLevel_6"},nil];
    return array;
}

//按主题
- (NSArray*)typeArray
{
    NSArray *array = [NSArray arrayWithObjects:
                      @{@"key":@"不限",@"type":@""},
                      @{@"key":@"自驾游攻略",@"type":@"自驾游攻略"},
                      @{@"key":@"康养指南",@"type":@"康养指南"},
                      @{@"key":@"周边游指南",@"type":@"周边游指南"},
                      @{@"key":@"爱吃玩指南",@"type":@"爱吃玩指南"},
                      nil];
    return array;
}


//返回label状态
- (float)labelCgsizeFlot:(float)flot Titis:(NSString*)str
{
    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:flot]};
    CGSize size = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, 18) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    return size.width + 18;
    
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
