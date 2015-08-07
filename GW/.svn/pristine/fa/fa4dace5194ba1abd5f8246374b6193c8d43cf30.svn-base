/*
 *  NIPolygon.h
 *
 *  Copyright (c) 2014年 Navinfo. All rights reserved.
 *
 */
#import <Foundation/Foundation.h>

#import "NIMultiPoint.h"
#import "NIOverlay.h"
#import "NIMapView.h"

/// 此类用于定义一个多边形区域
@interface NIPolygon : NIMultiPoint <NIOverlay>

/**
 *根据多个点生成多边形
 *@param coords 经纬度坐标点数组，这些点将被拷贝到生成的多边形对象中
 *@param count 点的个数
 *@return 新生成的多边形对象
 */
+ (NIPolygon *)polygonWithCoordinates:(CLLocationCoordinate2D *)coords count:(NSUInteger)count mapView:(NIMapView*)view;

/// 更新点坐标,个数
-(void)setPositions:(CLLocationCoordinate2D *)coords andCount:(NSUInteger)count;

@end
