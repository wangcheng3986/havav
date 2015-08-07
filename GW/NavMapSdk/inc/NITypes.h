/*
*  NITypes.h
*
*  Copyright (c) 2014年 Navinfo. All rights reserved.
*
*/

#import <CoreGraphics/CoreGraphics.h>
#import <CoreLocation/CoreLocation.h>

#import <UIKit/UIKit.h>

enum {
    NIMapTypeStandard   = 1,               ///< 标准地图
    NIMapTypeTrafficOn  = 2,               ///< 实时路况
    NIMapTypeSatellite  = 4,               ///< 卫星地图
    NIMapTypeTrafficAndSatellite  = 8,     ///< 同时打开实时路况和卫星地图
};
typedef NSUInteger NIMapType;


///表示一个经纬度范围
typedef struct {
    CLLocationDegrees latitudeDelta;	///< 纬度范围
    CLLocationDegrees longitudeDelta;	///< 经度范围
} NICoordinateSpan;

///表示一个经纬度区域
typedef struct {
    CLLocationCoordinate2D northEast;	///< 东北角点经纬度坐标
    CLLocationCoordinate2D southWest;	///< 西南角点经纬度坐标
} NICoordinateBounds;

///表示一个经纬度区域
typedef struct {
	CLLocationCoordinate2D center;	///< 中心点经纬度坐标
	NICoordinateSpan span;		///< 经纬度范围
} NICoordinateRegion;

///表示一个经纬度坐标点
typedef struct {
	int latitudeE6;		///< 纬度，乘以3.6e6之后的值
	int longitudeE6;	///< 经度，乘以3.6e6之后的值
} NIGeoPoint;

///地理坐标点，用直角地理坐标表示
typedef struct {
    double x;	///< 横坐标
    double y;	///< 纵坐标
} NIMapPoint;

///矩形大小，用直角地理坐标表示
typedef struct {
    double width;	///< 宽度
    double height;	///< 高度
} NIMapSize;

///矩形，用直角地理坐标表示
typedef struct {
    NIMapPoint origin; ///< 屏幕左上点对应的直角地理坐标
    NIMapSize size;	///< 坐标范围
} NIMapRect;

///地图缩放比例(0-15)
typedef CGFloat NIZoomScale;

///标注锚点
typedef struct {
    float x;
	float y;
}NIAnchor;
