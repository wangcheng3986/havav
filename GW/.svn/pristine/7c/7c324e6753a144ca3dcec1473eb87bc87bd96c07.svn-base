/*
 *  NIPolylineView.h
 *
 *  Copyright (c) 2014年 Navinfo. All rights reserved.
 *
 */

#import <UIKit/UIKit.h>

#import "NIPolyline.h"
#import "NIOverlayGLBasicView.h"

/// 此类用于定义一个折线View
@interface NIPolylineView : NIOverlayGLBasicView {
    UIColor *_arrowColor;
    bool _showArrow;
}

/**
 *根据指定的折线生成一个折线View
 *@param polyline 指定的折线数据对象
 *@return 新生成的折线View
 */
- (id)initWithPolyline:(NIPolyline *)polyline;

/// 该View对应的折线数据对象
@property (nonatomic, readonly) NIPolyline *polyline;

/// 线方向箭头绘制颜色
@property (retain) UIColor *arrowColor;

/// 是否绘制线方向箭头
@property bool showArrow;

@end
