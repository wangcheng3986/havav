/*
 *  NIPointAnnotation.h
 *
 *  Copyright (c) 2014年 Navinfo. All rights reserved.
 *
 */


#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocation.h>
#import "NIShape.h"

///表示一个点的annotation
@interface NIPointAnnotation : NIShape

///该点的坐标
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;


@end
