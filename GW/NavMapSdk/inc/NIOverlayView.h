/*
 *  NIOverlayView.h
 *
 *  Copyright (c) 2014年 Navinfo. All rights reserved.
 *
 */
#import <UIKit/UIKit.h>
#import "NIOverlay.h"

/// 该类是地图覆盖物View的基类，提供绘制overlay的接口但本身并无实现，所有地图覆盖物View需要继承自此类
@interface NIOverlayView : UIView
{
@package
    id <NIOverlay> _overlay;
    
}

/// 设置该overlay的GeometryDelegate
- (void)setGeometryDelegate:(id)delegate;

/**
 *初始化并返回一个overlay view
 *@param overlay 关联的overlay对象
 *@return 初始化成功则返回overlay view,否则返回nil
 */
- (id)initWithOverlay:(id <NIOverlay>)overlay;

///关联的overlay对象
@property (nonatomic, readonly) id <NIOverlay> overlay;

/**
 *将直角坐标转为overlay view坐标
 *@param mapPoint 直角坐标
 *@return 对应的view坐标
 */
- (CGPoint)pointForMapPoint:(NIMapPoint)mapPoint;

/**
 *将overlay view坐标转为直角坐标
 *@param point view坐标
 *@return 对应的直角坐标
 */
- (NIMapPoint)mapPointForPoint:(CGPoint)point;

/**
 *将二维地图投影矩形转为overlay view矩形
 *@param mapRect 二维地图投影矩形
 *@return 对应的view矩形
 */
- (CGRect)rectForMapRect:(NIMapRect)mapRect;

/**
 *将overlay view区域转为二维地图投影区域
 *@param rect 指定的view矩形
 *@return 对应的二维地图投影矩形
 */
- (NIMapRect)mapRectForRect:(CGRect)rect;

/**
 *使用OpenGLES 绘制线
 @param points 直角坐标点
 @param pointCount 点个数
 @param strokeColor 线颜色
 @param lineWidth OpenGLES支持线宽尺寸
 @param looped 是否闭合, 如polyline会设置NO, polygon会设置YES.
 */
- (void)renderLinesWithPoints:(NIGeoPoint *)geoPoints pointCount:(NSUInteger)pointCount strokeColor:(UIColor *)strokeColor lineWidth:(CGFloat)lineWidth looped:(BOOL)looped;

/**
 *使用OpenGLES 绘制区域
 @param points 直角坐标点
 @param pointCount 点个数
 @param fillColor 填充颜色
 @param usingTriangleFan YES对应GL_TRIANGLE_FAN, NO对应GL_TRIANGLES
 */
- (void)renderRegionWithPoints:(NIMapPoint *)points pointCount:(NSUInteger)pointCount fillColor:(UIColor *)fillColor;


@end


