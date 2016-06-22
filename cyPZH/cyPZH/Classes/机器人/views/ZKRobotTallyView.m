//
//  ZKRobotTallyView.m
//  cyPZH
//
//  Created by 王小腊 on 16/6/6.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import "ZKRobotTallyView.h"
#import "ZKRobotLabelMode.h"
#import "ZKRobotTallyTableViewCell.h"


static NSString *identifier = @"cell";

@interface ZKRobotTallyView ()

@property (nonatomic, strong) NSMutableArray <ZKRobotLabelMode *> *listArray;
@property (nonatomic, strong) NSMutableArray <NSString *> *imageArray;
@property (nonatomic, strong) UIView *robotContenView;
@property (nonatomic, strong) UITableView *labelTabelView;
@property (nonatomic, strong) NSString *record;

@end

@implementation ZKRobotTallyView
@synthesize sphereView;

- (NSMutableArray<NSString *> *)imageArray
{

    if (!_imageArray) {
        
        _imageArray = [NSMutableArray array];
        
    }
    
    return _imageArray;
}
- (NSMutableArray<ZKRobotLabelMode *> *)listArray
{
    if (!_listArray) {
        
        _listArray = [NSMutableArray array];
    }
    
    return _listArray;

}
- (instancetype)initWithFrame:(CGRect)frame;
{
    self = [super initWithFrame:frame];
    
    if (self) {
      
        self.userInteractionEnabled = YES;
        
        self.robotContenView = [[UIView alloc] initWithFrame:frame];
        
        self.robotContenView.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.robotContenView];
        
        [self postData];
        
    }
    
    return self;
    
}

#pragma mark  ---- 数据处理 ----
// 获取配置信息
- (void)postData
{
    
    NSMutableDictionary *dic = [NSMutableDictionary params];
    [dic setObject:@"130" forKey:@"interfaceId"];
    [dic setObject:@"TagConfig" forKey:@"Method"];
    dic[@"TimeStamp"] = [ZKUtil timeStamp];
    MJWeakSelf
    [ZKHttp postWithURLString:POST_ZK_URL parameters:dic success:^(id responseObject) {
         weakSelf.listArray = [ZKRobotLabelMode mj_objectArrayWithKeyValuesArray:responseObject];
        [weakSelf initSupViews];
        
    } failure:^(NSError *error) {
        
        HUDShowError(@"网络出错了");

    }];
    
}

#pragma  makr ---初始化视图----

- (void)initSupViews
{

    
    for (int i = 0 ; i<self.listArray.count; i++) {
        
        NSString *imageName = [NSString stringWithFormat:@"lab-%d",arc4random()%8+1];
        [self.imageArray addObject:imageName];
    }
    
    self.labelTabelView = [[UITableView alloc] initWithFrame:CGRectMake(self.robotContenView.frame.size.width - 100, 60, 100, self.robotContenView.frame.size.height-120)];
    self.labelTabelView.tableFooterView = [UIView new];
    self.labelTabelView.backgroundColor = [UIColor clearColor];
    self.labelTabelView.separatorStyle = UITableViewStylePlain;
    self.labelTabelView.estimatedRowHeight = 50;
    self.labelTabelView.delegate   = self;
    self.labelTabelView.dataSource = self;

    [self.labelTabelView registerClass:[ZKRobotTallyTableViewCell class] forCellReuseIdentifier:identifier];
    [self.robotContenView  addSubview:self.labelTabelView];

    //主动选中
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.labelTabelView selectRowAtIndexPath:indexPath animated:YES scrollPosition: UITableViewScrollPositionNone];
    
    if ([self.labelTabelView.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        
        [self.labelTabelView.delegate tableView:self.labelTabelView didSelectRowAtIndexPath:indexPath];
        
    }
}

#pragma mark --table代理---

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.listArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{

    return 6;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ZKRobotTallyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
     cell.backgroundColor = [UIColor clearColor];

    ZKRobotLabelMode *list = self.listArray[indexPath.section];
    
    NSString *imageName = self.imageArray[indexPath.section];
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName] highlightedImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@-pre",imageName]]];
    cell.textLabel.font =[UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = list.TagName;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.listArray.count > 0) {
        
        ZKRobotLabelMode *list = self.listArray[indexPath.section];
        
        //防止点击同一个cell
        if (![self.record isEqualToString:list.TagName]) {
            
            [self updateLabel:list.MinTagClass];
        }
        self.record = list.TagName;
       
    }
    
}

#pragma mark 3D云标签
- (void)updateLabel:(NSArray*)data
{
    [sphereView removeFromSuperview];
    float spW =  _SCREEN_WIDTH - 120;
    
    sphereView = [[DBSphereView alloc] initWithFrame:CGRectMake(0, 0,spW,spW+60)];
    sphereView.center = CGPointMake(spW/2+10, self.center.y);
    sphereView.clipsToBounds = YES;
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (NSInteger i = 0; i < data.count; i ++) {
        
        MinTagClass *list = data[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:list.TagName forState:UIControlStateNormal];
        [btn setTitleColor:[self randomColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        float labelW = [ZKUtil contentLabelSize:CGSizeMake(MAXFLOAT, 20) labelFont:16 labelText:list.TagName].width+6;
        btn.frame = CGRectMake(0, 0,labelW, 20);
        [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [array addObject:btn];
        [sphereView addSubview:btn];
    }
    
    [sphereView setCloudTags:array];
    sphereView.backgroundColor = [UIColor clearColor];
    [self.robotContenView addSubview:sphereView];

    
}

- (UIColor *)randomColor

{
    CGFloat hue = ( arc4random() % 256 / 256.0 );
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    
}
    
- (void)buttonPressed:(UIButton *)btn
{
    [sphereView timerStop];
    
    if ([self.tallyDelegate respondsToSelector:@selector(selectTitel:)]) {
        
        [self.tallyDelegate selectTitel:btn.titleLabel.text];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        btn.transform = CGAffineTransformMakeScale(2., 2.);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            btn.transform = CGAffineTransformMakeScale(1., 1.);
        } completion:^(BOOL finished) {
            [sphereView timerStart];
        }];
    }];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
