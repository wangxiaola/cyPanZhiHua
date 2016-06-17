//
//  ZKMianMapView.m
//  cyPZH
//
//  Created by 王小腊 on 16/6/17.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import "ZKMianMapView.h"
#import "ZKScenicListMode.h"
#import "MapView.h"


@interface ZKMianMapView ()<MapViewDelegate>
@property (nonatomic, strong) NSArray <ZKScenicListMode*>*annotations;
@property (nonatomic,strong)MapView *mapView;
@property (nonatomic, strong)  NSString *imageName;

@end

@implementation ZKMianMapView


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

}

#pragma mark -
#pragma mark delegate

- (NSInteger)numbersWithCalloutViewForMapView
{
    
    return [_annotations count];
}

- (CLLocationCoordinate2D)coordinateForMapViewWithIndex:(NSInteger)index
{
    ZKScenicListMode *item =[_annotations objectAtIndex:index];
    CLLocationCoordinate2D coordinate;
    coordinate.longitude = item.x ;
    coordinate.latitude  = item.y;
    return coordinate;
}

- (UIImage *)baseMKAnnotationViewImageWithIndex:(NSInteger)index
{
    
    
    return [UIImage imageNamed:_imageName];
    
    
}

- (UIView *)mapViewCalloutContentViewWithIndex:(NSInteger)index
{

    return [UIView new];
}

- (void)calloutViewDidSelectedWithIndex:(NSInteger)index
{
    
   
    
}


/**
 *  销毁
 */
- (void)mapDestroy;
{

    self.mapView.mapView.showsUserLocation =NO;
    [self.mapView.mapView removeAnnotations:self.mapView.mapView.annotations];
    [self.mapView.mapView removeOverlays:self.mapView.mapView.overlays];
    self.mapView.mapView.delegate =nil;
    [self.mapView removeFromSuperview];
}

- (void)addAnnotations:(NSArray<ZKScenicListMode*>*)dataArray Type:(NSInteger)type;
{

    switch (type) {
        case 0:
            self.imageName = @"map_scenic_spot";
            break;
        case 1:
            self.imageName = @"map_food";
            break;
        case 2:
            self.imageName = @"map_hotel";
            break;
        case 3:
            self.imageName = @"map_shopping";
            break;
        case 4:
            self.imageName = @"map_entertainment";
            break;
        default:
            break;
    }
    
    self.annotations = dataArray;
    
    [self initMapView];
    [self.mapView beginLoad];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
