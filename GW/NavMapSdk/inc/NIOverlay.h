/*
*  NIOverlay.h
*
*  Copyright (c) 2014年 Navinfo. All rights reserved.
*
*/

#import "NItypes.h"


@class NIOverlayView;
/// 该类是地图覆盖物的基类，所有地图的覆盖物需要继承自此类
@protocol NIOverlay <NSObject>

@required
///覆盖物的信息
@property (nonatomic, readonly) void* overlayItem;
@property (nonatomic, readonly) void* updateItem;
@property (nonatomic, readonly) NIOverlayView* view;

@end
