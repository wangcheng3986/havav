/*
*  NIOverlayGLBasicView.h
*
*  Copyright (c) 2014年 Navinfo. All rights reserved.
*
*/

#import <UIKit/UIKit.h>
#import "NIOverlayView.h"

/// 该类定义了一个用opengl绘制的OverlayView的基类，如果需要用gdi进行绘制请继承于NIOverlayPathView类
@interface NIOverlayGLBasicView : NIOverlayView {
@package    
    UIColor *_fillColor;
    UIColor *_strokeColor;
    CGFloat _lineWidth;
}

/// 填充颜色
@property (retain) UIColor *fillColor;
/// 画笔颜色
@property (retain) UIColor *strokeColor;
/// 画笔宽度，默认为0
@property CGFloat lineWidth;

@end
