/*
 *  NICircle.h
 *
 *  Copyright (c) 2014年 Navinfo. All rights reserved.
 *
 */

#import "NIShape.h"
#import "NIMultiPoint.h"
#import "NIOverlay.h"
#import "NIMapView.h"

/// 该类用于定义一个圆
@interface NICircle : NIMultiPoint <NIOverlay> {
@package
    CLLocationCoordinate2D _coordinate;
    CLLocationDistance _radius;
}

/**
 *根据中心点和半径生成圆
 *@param coord 中心点的经纬度坐标
 *@param radius 半径，单位：米
 *@return 新生成的圆
 */
+ (NICircle *)circleWithCenterCoordinate:(CLLocationCoordinate2D)coord
                                  radius:(CLLocationDistance)radius
                                  mapView:(NIMapView*)view;

/**
 *根据指定的直角坐标矩形生成圆，半径由较长的那条边决定，radius = MAX(width, height)/2
 *@param mapRect 指定的直角坐标矩形
 *@return 新生成的圆
 */
+ (NICircle *)circleWithMapRect:(NIMapRect)mapRect mapView:(NIMapView*)view;



/// 中心点坐标
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;


@end
