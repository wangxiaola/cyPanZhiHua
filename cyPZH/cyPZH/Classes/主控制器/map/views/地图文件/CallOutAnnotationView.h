//
//  CallOutAnnotationView.h
//  cyPZH
//
//  Created by 王小腊 on 16/6/17.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import <MapKit/MapKit.h>

#define  Arror_height 15

@protocol CallOutAnnotationViewDelegate;
@interface CallOutAnnotationView : MKAnnotationView

@property (nonatomic,strong)UIView *contentView;


- (id)initWithAnnotation:(id<MKAnnotation>)annotation
         reuseIdentifier:(NSString *)reuseIdentifier
                delegate:(id<CallOutAnnotationViewDelegate>)delegate;
@end

@protocol CallOutAnnotationViewDelegate <NSObject>

- (void)didSelectAnnotationView:(CallOutAnnotationView *)view;

@end


