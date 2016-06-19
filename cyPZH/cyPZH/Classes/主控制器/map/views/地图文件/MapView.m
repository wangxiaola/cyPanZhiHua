//
//  MapView.m
//  cyPZH
//
//  Created by 王小腊 on 16/6/17.
//  Copyright © 2016年 王小腊. All rights reserved.
////

#import "MapView.h"
#import "CalloutMapAnnotation.h"
#import "BasicMapAnnotation.h"


@interface MapView ()<MKMapViewDelegate>

@property (nonatomic, weak)id<MapViewDelegate> delegate;

@property (nonatomic, strong)CalloutMapAnnotation *calloutAnnotation;

@property (nonatomic, assign)CLLocationCoordinate2D coordinate2D;

@end

@implementation MapView

@synthesize mapView = _mapView;
@synthesize delegate = _delegate;

- (instancetype)initWithDelegate:(id<MapViewDelegate>)delegate;
{
    if (self = [self init]) {
        
        self.backgroundColor = [UIColor whiteColor];
        MKMapView *mapView = [[MKMapView alloc] initWithFrame:self.bounds];
        mapView.delegate = self;
        [self addSubview:mapView];
        self.mapView =  mapView;
        self.mapView.showsUserLocation = NO;
        self.span = 10000;
        self.delegate = delegate;
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    self.mapView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    [super setFrame:frame];
}

- (void)beginLoad
{
    for (int i = 0; i < [_delegate numbersWithCalloutViewForMapView]; i++) {
        
        CLLocationCoordinate2D location = [_delegate coordinateForMapViewWithIndex:i];
        BasicMapAnnotation *  annotation=[[BasicMapAnnotation alloc] initWithLatitude:location.latitude andLongitude:location.longitude tag:i];
        [_mapView  addAnnotation:annotation];
    }
    [self showUserLocation:_coordinate2D];
    [self.mapView showAnnotations:self.mapView.annotations animated:YES];
}
/**
 * 标记自己
 */

- (void)myUserLocation:(CLLocationCoordinate2D)cllocation;
{
    self.coordinate2D = cllocation;

}

- (void)showUserLocation:(CLLocationCoordinate2D)cllocation;
{
    self.calloutAnnotation = [[CalloutMapAnnotation alloc]
                              initWithLatitude:cllocation.latitude
                              andLongitude:cllocation.longitude
                              tag:0];
    [_mapView addAnnotation:_calloutAnnotation];
    
    [_mapView setCenterCoordinate:cllocation animated:YES];
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(cllocation,_span ,_span );
    MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:region];
    [_mapView setRegion:adjustedRegion animated:YES];
    
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    if ([view.annotation isKindOfClass:[BasicMapAnnotation class]])
    {
        BasicMapAnnotation *annotation = (BasicMapAnnotation *)view.annotation;
        [self.mapView setCenterCoordinate:annotation.coordinate animated:YES];
        if([_delegate respondsToSelector:@selector(calloutViewDidSelectedWithIndex:)])
        {
            [_delegate calloutViewDidSelectedWithIndex:annotation.tag];
        }
    }
}
// 消失弹出框
- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view
{
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKAnnotationView *annotationView =[mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomAnnotation"];
    
    if (!annotationView) {
        
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                                      reuseIdentifier:@"CustomAnnotation"];
    }
    annotationView.canShowCallout = NO;
    
    if ([annotation isKindOfClass:[CalloutMapAnnotation class]])
    {
        CalloutMapAnnotation *calloutAnnotation = (CalloutMapAnnotation *)annotation;
        
        annotationView.image = [_delegate mapViewCalloutContentViewWithIndex:calloutAnnotation.tag];;
        
        return annotationView;
        
    }
    else if ([annotation isKindOfClass:[BasicMapAnnotation class]])
    {
        BasicMapAnnotation *basicMapAnnotation = (BasicMapAnnotation *)annotation;
        annotationView.image = [_delegate baseMKAnnotationViewImageWithIndex:basicMapAnnotation.tag];
        
        return annotationView;
    }
    return nil;
}

@end
