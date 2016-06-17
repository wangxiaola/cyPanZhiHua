//
//  MapView.h
//  cyPZH
//
//  Created by 王小腊 on 16/6/17.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@protocol MapViewDelegate;
@interface MapView : UIView

@property (nonatomic,strong)MKMapView *mapView;
@property (nonatomic,assign)double span;//default 40000

- (id)initWithDelegate:(id<MapViewDelegate>)delegate;
/**
 *  刷新数据
 */
- (void)beginLoad;


@end


@protocol MapViewDelegate <NSObject>

- (NSInteger)numbersWithCalloutViewForMapView;
- (CLLocationCoordinate2D)coordinateForMapViewWithIndex:(NSInteger)index;
- (UIView *)mapViewCalloutContentViewWithIndex:(NSInteger)index;
- (UIImage *)baseMKAnnotationViewImageWithIndex:(NSInteger)index;

@optional
- (void)calloutViewDidSelectedWithIndex:(NSInteger)index;

@end