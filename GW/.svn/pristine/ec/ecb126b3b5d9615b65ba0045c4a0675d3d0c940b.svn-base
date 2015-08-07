/*  NIGeometry.h
 *
 *  Copyright (c) 2014年 Navinfo. All rights reserved.
 *
 */
#import "NITypes.h"
#import <CoreGraphics/CoreGraphics.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

/**
 *计算指定两点之间的距离
 *@param a 第一个坐标点
 *@param b 第二个坐标点
 *@return 两点之间的距离，单位：米
 */
UIKIT_EXTERN CLLocationDistance NIMetersBetweenMapPoints(CLLocationCoordinate2D a, CLLocationCoordinate2D b);

/**
 *构造NIMapPoint对象
 *@param x 水平方向的坐标值
 *@param y 垂直方向的坐标值
 *@return 根据指定参数生成的NIMapPoint对象
 */
UIKIT_STATIC_INLINE NIMapPoint NIMapPointMake(double x, double y) {
    return (NIMapPoint){x, y};
}

/**
 *构造NIMapSize对象
 *@param width 宽度
 *@param height 高度
 *@return 根据指定参数生成的NIMapSize对象
 */
UIKIT_STATIC_INLINE NIMapSize NIMapSizeMake(double width, double height) {
    return (NIMapSize){width, height};
}

/**
 *构造NIMapRect对象
 *@param x 矩形左上顶点的x坐标值
 *@param y 矩形左上顶点的y坐标值
 *@param width 矩形宽度
 *@param height 矩形高度
 *@return 根据指定参数生成的NIMapRect对象
 */
UIKIT_STATIC_INLINE NIMapRect NIMapRectMake(double x, double y, double width, double height) {
    return (NIMapRect){ NIMapPointMake(x, y), NIMapSizeMake(width, height)};
}


/**
 *构造NIAnchor对象
 *@param x 指定图片以左上角为（0，0），x方向值
 *@param y 指定图片以左上角为（0，0），y方向值
 *@return 根据指定参数生成的NIAnchor对象
 */
UIKIT_STATIC_INLINE NIAnchor NIAnchorMake(float x, float y) {
    return (NIAnchor){x, y};
}


/**
 *获取指定矩形的x轴坐标最小值
 *@param rect 指定的矩形
 *@return x轴坐标最小值
 */
UIKIT_STATIC_INLINE double NIMapRectGetMinX(NIMapRect rect) {
    return rect.origin.x;
}

/**
 *获取指定矩形的y轴坐标最小值
 *@param rect 指定的矩形
 *@return y轴坐标最小值
 */
UIKIT_STATIC_INLINE double NIMapRectGetMinY(NIMapRect rect) {
    return rect.origin.y;
}

/**
 *获取指定矩形在x轴中点的坐标值
 *@param rect 指定的矩形
 *@return x轴中点的坐标值
 */
UIKIT_STATIC_INLINE double NIMapRectGetMidX(NIMapRect rect) {
    return rect.origin.x + rect.size.width / 2.0;
}

/**
 *获取指定矩形在y轴中点的坐标值
 *@param rect 指定的矩形
 *@return y轴中点的坐标值
 */
UIKIT_STATIC_INLINE double NIMapRectGetMidY(NIMapRect rect) {
    return rect.origin.y + rect.size.height / 2.0;
}

/**
 *获取指定矩形的x轴坐标最大值
 *@param rect 指定的矩形
 *@return x轴坐标最大值
 */
UIKIT_STATIC_INLINE double NIMapRectGetMaxX(NIMapRect rect) {
    return rect.origin.x + rect.size.width;
}

/**
 *获取指定矩形的y轴坐标最大值
 *@param rect 指定的矩形
 *@return y轴坐标最大值
 */
UIKIT_STATIC_INLINE double NIMapRectGetMaxY(NIMapRect rect) {
    return rect.origin.y + rect.size.height;
}

/**
 *获取指定矩形的宽度
 *@param rect 指定的矩形
 *@return 指定矩形的宽度
 */
UIKIT_STATIC_INLINE double NIMapRectGetWidth(NIMapRect rect) {
    return rect.size.width;
}

/**
 *获取指定矩形的高度
 *@param rect 指定的矩形
 *@return 指定矩形的高度
 */
UIKIT_STATIC_INLINE double NIMapRectGetHeight(NIMapRect rect) {
    return rect.size.height;
}

/**
 *判断两个点是否相等
 *@param point1 第一个点
 *@param point2 第二个点
 *@return 如果两点相等，返回YES，否则返回NO
 */
UIKIT_STATIC_INLINE BOOL NIMapPointEqualToPoint(NIMapPoint point1, NIMapPoint point2) {
    return point1.x == point2.x && point1.y == point2.y;
}

/**
 *判断两个矩形范围是否相等
 *@param size1 范围1
 *@param size2 范围2
 *@return 如果相等，返回YES，否则返回NO
 */
UIKIT_STATIC_INLINE BOOL NIMapSizeEqualToSize(NIMapSize size1, NIMapSize size2) {
    return size1.width == size2.width && size1.height == size2.height;
}

/**
 *判断两个矩形是否相等
 *@param rect1 矩形1
 *@param rect2 矩形2
 *@return 如果相等，返回YES，否则返回NO
 */
UIKIT_STATIC_INLINE BOOL NIMapRectEqualToRect(NIMapRect rect1, NIMapRect rect2) {
    return 
    NIMapPointEqualToPoint(rect1.origin, rect2.origin) &&
    NIMapSizeEqualToSize(rect1.size, rect2.size);
}

/**
 *判断指定矩形是否为NULL
 *@param rect 指定矩形
 *@return 如果矩形为NULL，返回YES，否则返回NO
 */
UIKIT_STATIC_INLINE BOOL NIMapRectIsNull(NIMapRect rect) {
    return isinf(rect.origin.x) || isinf(rect.origin.y);
}

/**
 *判断一个矩形是否为空矩形
 *@param rect 指定矩形
 *@return 如果矩形为空矩形，返回YES，否则返回NO
 */
UIKIT_STATIC_INLINE BOOL NIMapRectIsEmpty(NIMapRect rect) {
    return NIMapRectIsNull(rect) || (rect.size.width == 0.0 && rect.size.height == 0.0);
}

/**
 *将NIMapPoint格式化为字符串
 *@param point 指定的标点
 *@return 返回转换后的字符串
 */
UIKIT_STATIC_INLINE NSString *NIStringFromMapPoint(NIMapPoint point) {
    return [NSString stringWithFormat:@"{%.1f, %.1f}", point.x, point.y];
}

/**
 *将NIMapSize格式化为字符串
 *@param size 指定的size
 *@return 返回转换后的字符串
 */
UIKIT_STATIC_INLINE NSString *NIStringFromMapSize(NIMapSize size) {
    return [NSString stringWithFormat:@"{%.1f, %.1f}", size.width, size.height];
}

/**
 *将NIMapRect格式化为字符串
 *@param rect 指定的rect
 *@return 返回转换后的字符串
 */
UIKIT_STATIC_INLINE NSString *NIStringFromMapRect(NIMapRect rect) {
    return [NSString stringWithFormat:@"{%@, %@}", NIStringFromMapPoint(rect.origin), NIStringFromMapSize(rect.size)];
}



