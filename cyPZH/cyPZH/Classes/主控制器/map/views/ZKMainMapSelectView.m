//
//  ZKMainMapSelectView.m
//  cyPZH
//
//  Created by 王小腊 on 16/6/17.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import "ZKMainMapSelectView.h"
#import "ZKSelectListView.h"

static NSString *normalStr = @"map_miss";
static NSString *highlightedStr = @"map_select";

@interface ZKMainMapSelectView ()<ZKSelectListViewDelegate>

@property (nonatomic, strong) NSMutableArray <UIImageView*>*imageArray;

@property (nonatomic, assign) double lat; // 经度
@property (nonatomic, assign) double lon; // 纬度
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *type;

/**
 *  请求参数
 */
@property (nonatomic, copy) NSMutableDictionary *params;

@end

@implementation ZKMainMapSelectView
{
    NSArray *typeArray;
    NSInteger index;
    
    
}

- (NSMutableDictionary *)params
{
    if (_params == nil) {
        _params = [NSMutableDictionary params];
    }
    return _params;
}
- (NSMutableArray<UIImageView *> *)imageArray
{
    
    if (!_imageArray) {
        
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
    
}

- (instancetype)initWithFrame:(CGRect)frame selectType:(NSInteger)type;
{
    
    self = [super initWithFrame:frame];
    
    if (self) {

        UIView *bannerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 40)];
        bannerView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        [self addSubview:bannerView];
        
        NSArray *titis =@[@"景点",@"美食",@"酒店",@"购物",@"娱乐"];
        typeArray =@[@"scenery",@"dining",@"hotel",@"shopping",@"recreation"];
        self.type = @"scenery";
        float gapWidth =self.frame.size.width/5;
        
        for (int i=0; i<5; i++) {
            
            UIImageView* lefView =[[UIImageView alloc]initWithFrame:CGRectMake(8+gapWidth*i,(40-16)/2, 16, 16)];
            lefView.backgroundColor =[UIColor clearColor];
            lefView.tag =i+1000;
            lefView.image =[UIImage imageNamed:normalStr];
            [self addSubview:lefView];
            [self.imageArray addObject:lefView];
            
            UILabel *  name =[[UILabel alloc]initWithFrame:CGRectMake(gapWidth*i+8, 0, gapWidth, 40)];
            name.backgroundColor =[UIColor clearColor];
            name.textColor =[UIColor whiteColor];
            name.textAlignment =NSTextAlignmentCenter;
            name.font =[UIFont systemFontOfSize:13];
            name.text =titis [i];
            [self addSubview:name];
            
            UIButton * button =[[UIButton alloc]initWithFrame:CGRectMake(gapWidth*i, 0, gapWidth, 40)];
            button.backgroundColor =[UIColor clearColor];
            button.tag =i+3000;
            [button addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:button];
        }
        
        ZKSelectListView *headerView = [[ZKSelectListView alloc] initWithFrame:CGRectMake(0, 40, _SCREEN_WIDTH,40) sceneryType:2 superView:nil];
        headerView.delegate = self;
        [self addSubview:headerView];
        headerView.backgroundColor = [UIColor clearColor];
        [self selectType:type];
    }
    
    return self;
}

// 更新左标
- (void)selecUpdataMyLat:(float)lat myLon:(float)lon;
{

    self.lat = lat;
    self.lon = lon;
}

#pragma mark ----
#pragma mark --- 数据请求 ---
- (void)postData
{
    
    self.params = nil;
    self.params[@"rows"] = @"15";
    self.params[@"key"] = self.key;
    self.params[@"type"] = self.type;
    self.params[@"interfaceId"] = @"134";
    self.params[@"method"] = @"resoureNearbyLatLng";
    self.params[@"distance"] = @"5";
    self.params[@"lat"] = [NSNumber numberWithDouble:self.lat];
    self.params[@"lon"] = [NSNumber numberWithDouble:self.lon];
    self.params[@"TimeStamp"] = [ZKUtil timeStamp];
    [SVProgressHUD showWithStatus:@"加载中..."];
    MJWeakSelf
    [ZKHttp postWithURLString:POST_ZK_URL parameters:self.params success:^(id responseObject) {
        HUDDissmiss
        [weakSelf sendData:responseObject];
        MMLog(@"map  %@",responseObject);

    } failure:^(NSError *error) {
        [weakSelf sendData:nil];
        HUDShowFailure
    }];
    
    
}

- (void)sendData:(id)data
{
    if ([self.delegate respondsToSelector:@selector(updataSelectData:selectType:)]) {
        
        [self.delegate updataSelectData:[ZKMainMapMode mj_objectArrayWithKeyValuesArray:[data valueForKey:@"rows"]] selectType:index];
    }
    
}

- (void)selectViewUpdata;
{

    [self postData];
}
#pragma mark button点击事件
- (void)selectButton:(UIButton*)sender
{
    NSInteger row = sender.tag - 3000;
    // 点击同一个不予理会
    if (index != row)
    {
        self.type = typeArray[row];
        [self postData];
        [self selectType:row];
    }

}


/**
 *  选中状态
 *
 *  @param pag 选中哪个
 */
- (void)selectType:(NSInteger)pag
{
    index = pag;
    [self endEditing:YES];
    [self.imageArray enumerateObjectsUsingBlock:^(UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj.image = pag == idx ? [UIImage imageNamed:highlightedStr]:[UIImage imageNamed:normalStr];
    } ];
    
}


#pragma mark --ZKSelectListViewDelegate--
/**
 *  搜索
 *
 *  @param key 值
 */
- (void)seekName:(NSString*)key;
{
    if (self.key != key)
    {
        self.key = key;
        [self postData];
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
