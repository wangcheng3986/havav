/*
 *  NIPolygonView.h
 *
 *  Copyright (c) 2014年 Navinfo. All rights reserved.
 *
 */

#import <UIKit/UIKit.h>

#import "NIPolygon.h"
#import "NIOverlayGLBasicView.h"

/// 此类用于定义一个多边形View
@interface NIPolygonView : NIOverlayGLBasicView

/**
 *根据指定的多边形生成一个多边形View
 *@param polygon 指定的多边形数据对象
 *@return 新生成的多边形View
 */
- (id)initWithPolygon:(NIPolygon *)polygon;

/// 该View对应的多边形数据
@property (nonatomic, readonly) NIPolygon *polygon;

@end
