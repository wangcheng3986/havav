/*
*  NIUserLocation.h
*
*  Copyright (c) 2014年 Navinfo. All rights reserved.
*
*/

#import <CoreLocation/CLLocation.h>
#import <Foundation/Foundation.h>
@class CLLocation;
@class CLHeading;
@interface NIUserLocation : NSObject

/// 位置信息，如果NIMapView的showsUserLocation为NO，或者尚未定位成功，则该值为nil
@property (nonatomic, retain) CLLocation *location;

/// heading信息，如果NIMapView的showsUserLocation为NO，或者尚未定位成功，则该值为nil
@property (nonatomic, retain) CLHeading *heading;

/// speed信息，如果NIMapView的showsUserLocation为NO，或者尚未定位成功，则该值为0
@property (nonatomic) CLLocationSpeed speed;

@end