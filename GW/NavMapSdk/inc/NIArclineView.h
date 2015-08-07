/*
 *  NIArclineView.h
 *
 *  Copyright (c) 2014年 Navinfo. All rights reserved.
 *
 */

#import <UIKit/UIKit.h>

#import "NIArcline.h"
#import "NIOverlayGLBasicView.h"

/// 此类用于定义一个圆弧View
@interface NIArclineView : NIOverlayGLBasicView

/**
 *根据指定的弧线生成一个圆弧View
 *@param arcline 指定的弧线数据对象
 *@return 新生成的弧线View
 */
- (id)initWithArcline:(NIArcline *)arcline;

/// 该View对应的圆弧数据对象
@property (nonatomic, readonly) NIArcline *arcline;

@end
