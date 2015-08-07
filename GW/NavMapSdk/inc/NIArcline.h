/*
 *  NIArcline.h
 *
 *  Copyright (c) 2014年 Navinfo. All rights reserved.
 *
 */

#import "NIMultiPoint.h"
#import "NIOverlay.h"

/// 此类用于定义一段圆弧
@interface NIArcline : NIMultiPoint <NIOverlay>
{
    NIMapRect _boundingMapRect;
    bool isYouArc;
}

/**
 *根据指定坐标点生成一段圆弧
 *@param points 指定的直角坐标点数组
 *@return 新生成的圆弧对象
 */
+ (NIArcline *)arclineWithPoints:(NIMapPoint *)points;

/**
 *根据指定经纬度生成一段圆弧
 *@param coords 指定的经纬度坐标点数组
 *@return 新生成的圆弧对象
 */
+ (NIArcline *)arclineWithCoordinates:(CLLocationCoordinate2D *)coords;

@end
