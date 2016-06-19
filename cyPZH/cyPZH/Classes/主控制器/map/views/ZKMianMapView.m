//
//  ZKMianMapView.m
//  cyPZH
//
//  Created by 王小腊 on 16/6/17.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import "ZKMianMapView.h"
#import "ZKMainMapMode.h"
#import "MapView.h"
#import "ZKMainSelectPopView.h"

@interface ZKMianMapView ()<MapViewDelegate,ZKMainSelectPopViewDelegate>
@property (nonatomic, strong) NSArray <ZKMainMapMode*>*annotations;

@property (nonatomic,strong) MapView *mapView;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, strong) ZKMainSelectPopView*popView;


@end

@implementation ZKMianMapView
{
    CLLocationCoordinate2D myCoordinate;
}

- (ZKMainSelectPopView *)popView
{
    
    if (_popView == nil)
    {
        _popView = [[ZKMainSelectPopView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-84, _SCREEN_WIDTH, 84)];
        _popView.delegate = self;
        [self insertSubview:_popView atIndex:999];
    }
    
    return _popView;
}
- (instancetype)initWithFrame:(CGRect)frame;
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
    }
    
    return self;
}


-(void)initMapView
{
    self.mapView = [[MapView alloc] initWithDelegate:self];
    [self insertSubview:self.mapView atIndex:100];
    [_mapView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [_mapView shouldGroupAccessibilityChildren];
    [self.mapView myUserLocation:myCoordinate];
    
}
// 更新左标
- (void)mapUpdataMyLat:(float)lat myLon:(float)lon;
{
    myCoordinate.longitude = lon;
    myCoordinate.latitude  = lat;
    
}

#pragma mark -
#pragma mark delegate

- (NSInteger)numbersWithCalloutViewForMapView
{
    
    return [_annotations count];
}

- (CLLocationCoordinate2D)coordinateForMapViewWithIndex:(NSInteger)index
{
    ZKMainMapMode *item =[_annotations objectAtIndex:index];
    CLLocationCoordinate2D coordinate;
    coordinate.longitude = item.longitude;
    coordinate.latitude  = item.latitude;
    return coordinate;
}

- (UIImage *)baseMKAnnotationViewImageWithIndex:(NSInteger)index
{
    NSString *imageName;
    switch (self.type) {
        case 0:
            imageName = @"map_scenic_spot";
            break;
        case 1:
            imageName = @"map_food";
            break;
        case 2:
            imageName = @"map_hotel";
            break;
        case 3:
            imageName = @"map_shopping";
            break;
        case 4:
            imageName = @"map_entertainment";
            break;
        default:
            break;
    }
    
    return [UIImage imageNamed:imageName];
}

- (UIImage *)mapViewCalloutContentViewWithIndex:(NSInteger)index
{
    
    return [UIImage imageNamed:@"map_location"];
}

- (void)calloutViewDidSelectedWithIndex:(NSInteger)index
{
    MMLog(@"%lu",(unsigned long)self.mapView.mapView.annotations.count);
    ZKMainMapMode *mode = [self.annotations objectAtIndex:index];
    [self.popView updatePopView:mode];
}


/**
 *  销毁
 */
- (void)mapDestroy;
{
    [self deletePopView];
    [self.mapView.mapView removeAnnotations:self.mapView.mapView.annotations];
    self.mapView.mapView.showsUserLocation = NO;
    self.mapView.mapView.delegate = nil;
    self.mapView.mapView.userTrackingMode  = MKUserTrackingModeNone;
    [self.mapView.mapView removeFromSuperview];
    [self.mapView removeFromSuperview];
    self.mapView.mapView = nil;
    self.mapView = nil;
}
//销毁popView
- (void)deletePopView
{
    if (_popView)
    {
        _popView.delegate = nil;
        [_popView removeFromSuperview];
        _popView = nil;
    }
    
}
- (void)addAnnotations:(NSArray<ZKMainMapMode*>*)dataArray Type:(NSInteger)type;
{
    self.type = type;
    self.annotations = dataArray;
    
    [self initMapView];
    [self.mapView beginLoad];
}

// 更新数据
- (void)updataAddAnnotations:(NSArray<ZKMainMapMode*>*)dataArray Type:(NSInteger)type;
{
    [self deletePopView];
    self.type = type;
    [self.mapView.mapView removeAnnotations:self.mapView.mapView.annotations];
    [self.mapView.mapView removeAnnotations:self.mapView.mapView.selectedAnnotations];
    self.annotations = dataArray;
    [self.mapView beginLoad];
}

#pragma mark ----
#pragma mark --ZKMainSelectPopViewDelegate--
/**
 *  点击导航
 */
- (void)navMap:(ZKMainMapMode*)list;
{
    
    //  起点
    CLLocationCoordinate2D coordinate;
    coordinate.latitude=list.latitude;
    coordinate.longitude=list.longitude;
    CLLocationCoordinate2D coords2 = coordinate;
    //  当前的位置
    MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coords2 addressDictionary:nil]];
    toLocation.name = strIsNull(list.address);
    NSArray *items = [NSArray arrayWithObjects:currentLocation, toLocation, nil];
    NSDictionary *options = @{ MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving, MKLaunchOptionsMapTypeKey: [NSNumber numberWithInteger:MKMapTypeStandard], MKLaunchOptionsShowsTrafficKey:@YES };
    //打开苹果自身地图应用，并呈现特定的item
    [MKMapItem openMapsWithItems:items launchOptions:options];
}
/**
 *  点击详情
 */
- (void)navDetails:(ZKMainMapMode*)list;
{
    MMLog(@"%ld",(long)list.ID);
    
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
