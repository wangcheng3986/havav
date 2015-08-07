/*
*  NIMultiPoint.h
*
*  Copyright (c) 2014年 Navinfo. All rights reserved.
*
*/

#import <Foundation/Foundation.h>
#import "NIShape.h"
#import "NIMapView.h"
#import "NITypes.h"

/// 该类定义多个点，是个由多个点组成的虚基类, 不能直接实例化对象, 要使用其子类NIPolyline,NIPolygon来实例化
@interface NIMultiPoint : NIShape {
    @package
    NIGeoPoint *_points;
    NSUInteger _pointCount;
    NIMapView* _mapView;
    
}

/// 坐标点数组
@property (nonatomic, readonly) NIGeoPoint *points;

/// 坐标点的个数
@property (nonatomic, readonly) NSUInteger pointCount;

@end