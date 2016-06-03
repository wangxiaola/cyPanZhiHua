//
//  HHLocationManger.h
//  slyjg
//
//  Created by 王小腊 on 16/4/8.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import "HHLocationManger.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
@implementation HHLocationManger

+ (HHLocationManger *)shareLocation;
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

- (id)init {
    self = [super init];
    if (self) {

    }
    return self;
}


- (void)getLocationCoordinate:(LocationBlock) locaiontBlock
{
    self.locationBlock = [locaiontBlock copy];
    [self getUserLocation];
}
- (void)getAddress:(AddressBlock)addressBlock
{
    self.addressBlock = [addressBlock copy];
    [self getUserLocation];
}
- (void)getCityBlock:(CityBlock)cityBlock
{
    self.cityBlock = [cityBlock copy];
    [self getUserLocation];
}

- (void)getDictBlock:(DictBlock)dictBlock
{
    self.dictBlock = [dictBlock copy];
    [self getUserLocation];
}

- (void)getUserLocation
{
    //判断位置服务是否可用
    if (![CLLocationManager locationServicesEnabled]) {
        return;
    }
    
    if (nil == _locationManager)
    {
        _locationManager = [[CLLocationManager alloc] init];
    }

    //设置代理
    _locationManager.delegate = self;
    
    //desired 要求  想得到的    Accuracy 精确度
    //定位的水平精确度
    _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    
    //distance距离 Filter过滤器
    //触发定位事件的最小距离， 单位是米
    _locationManager.distanceFilter = 1;
    if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
    {
        [_locationManager requestWhenInUseAuthorization];
    }
    if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
    {
        [_locationManager requestAlwaysAuthorization];
    }
    if (IOS8) {
        [_locationManager requestAlwaysAuthorization];        //NSLocationAlwaysUsageDescription
        [_locationManager requestWhenInUseAuthorization];
    }
    //开始定位服务_locationManager
    [_locationManager startUpdatingLocation];
    
}

#pragma mark CLLocationManagerDelegate Methods
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *newLocation = [locations lastObject];
    
    CLGeocoder *clGeoCoder = [[CLGeocoder alloc] init];
    __block NSString *lastAddress ;
    __block NSString *cityStr;
    CLGeocodeCompletionHandler handle = ^(NSArray *placemarks,NSError *error)
    
    {
        for (CLPlacemark * placeMark in placemarks)
        {
            NSDictionary *addressDic=placeMark.addressDictionary;
            
            NSString *state=[addressDic objectForKey:@"State"];
            NSString *city=[addressDic objectForKey:@"City"];
            NSString *subLocality=[addressDic objectForKey:@"SubLocality"];
            NSString *street=[addressDic objectForKey:@"Street"];

            lastAddress=[NSString stringWithFormat:@"%@%@%@%@",state,city,subLocality,street];
            cityStr = city;

            if (_dictBlock)
            {
                _dictBlock(addressDic);
                _dictBlock = nil;
            }

             [_locationManager stopUpdatingLocation];
        }
       
        if (_locationBlock) {
            _locationBlock(newLocation.coordinate);
            _locationBlock = nil;
        }
        
        if (_addressBlock) {
            _addressBlock(lastAddress);
            _addressBlock = nil;
        }
        if (_cityBlock) {
            
            if ([cityStr hasSuffix:@"市"]||[cityStr hasSuffix:@"省"]||[cityStr hasSuffix:@"区"]) {
                cityStr = [cityStr substringWithRange:NSMakeRange(0, cityStr.length -1)];
            }
            _cityBlock(cityStr);
            _cityBlock = nil;
        }
           };
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [clGeoCoder reverseGeocodeLocation:newLocation completionHandler:handle];
    
    self.latitude = newLocation.coordinate.latitude;
    self.longitude = newLocation.coordinate.longitude;
    [_locationManager stopUpdatingLocation];
}

@end
