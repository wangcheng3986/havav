/*
*  NIAnnotation.h
*
*  Copyright (c) 2014年 Navinfo. All rights reserved.
*
*/

#import <CoreGraphics/CoreGraphics.h>
#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>
#import "NIAnnotationView.h"


/// 该类为标注点的protocol，提供了标注类的基本信息函数
@protocol NIAnnotation <NSObject>

@required

///标注view中心坐标.
@property(nonatomic, readonly) CLLocationCoordinate2D coordinate;

//单个poi信息点
@property(nonatomic, readonly) void*  mapOverlayItem;

//分组poi引擎
@property(nonatomic, readonly) void*  mapOverlay;

//地图控制引擎
@property(nonatomic, readonly) void*  pCoreObject;

///所属的NIAnnotation view
@property(nonatomic, readonly) NIAnnotationView*  annotationView;

///默认为NO,当view被点中时被设为YES,用户不要直接设置这个属性.
@property (nonatomic, getter=isSelected) BOOL selected;

@optional

//默认为NO,设置为YES时标注会随地图进行缩放。
@property(nonatomic, assign) BOOL rasterScaleEnable;

///用户自行设置的id
@property(nonatomic, assign) NSInteger annotationID;

/**
 *获取annotation标题
 *@return 返回annotation的标题信息
 */
- (NSString *)title;

/**
 *获取annotation副标题
 *@return 返回annotation的副标题信息
 */
- (NSString *)subtitle;


/**
 *设置标注的坐标，在拖拽时会被调用.
 *@param newCoordinate 新的坐标值
 */
- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;

/**
 *sdk内部调用，用于更新标注
 */
-(void*)updateAnnotation;

///设置是否可见
-(void)setVisable:(BOOL)visable;
@end
