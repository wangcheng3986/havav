/*
 *  NIPolyline.h
 *
 *  Copyright (c) 2014年 Navinfo. All rights reserved.
 *
 */

#import "NIMultiPoint.h"
#import "NIOverlay.h"
#import "NIMapView.h"

/// 此类用于定义一段折线
@interface NIPolyline : NIMultiPoint <NIOverlay>

/**
 *根据指定坐标点生成一段折线
 *@param coords 指定的经纬度坐标点数组
 *@param count 坐标点的个数
 *@return 新生成的折线对象
 */
+ (NIPolyline *)polylineWithCoordinates:(CLLocationCoordinate2D *)coords count:(NSUInteger)count mapView:(NIMapView*)view;

/// 更新端点坐标,端点个数
-(void)setPositions:(CLLocationCoordinate2D *)coords andCount:(NSUInteger)count;

@end


