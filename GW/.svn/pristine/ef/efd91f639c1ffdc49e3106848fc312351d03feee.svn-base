/*
 *  NIAnnotationView.h
 *
 *  Copyright (c) 2014年 Navinfo. All rights reserved.
 *
 */

#import <UIKit/UIKit.h>
#import "NITypes.h"

@protocol NIAnnotation;
@class NIMapView;

///标注view
@interface NIAnnotationView : NSObject

/**
 *初始化并返回一个annotation view
 *@param mapview NIMapView对象
 *@param reuseIdentifier 如果要重用view,传入一个字符串,否则设为nil,建议重用view
 *@return 初始化成功则返回annotation view,否则返回nil
 */
- (id)initWithNIMapView:(NIMapView*)mapview reuseIdentifier:(NSString *)reuseIdentifier;


///关联的标注
@property (nonatomic, readonly)  NSArray* annotations;

///复用标志
@property (nonatomic, readonly) NSString *reuseIdentifier;

///annotation view显示的图像
@property (nonatomic, retain) UIImage *image;

////设置view显示时的角度（0，359）
@property (nonatomic, getter=getRotate) CGFloat rotate;

///锚点坐标，左上角为（0，0），右下为（1，1）
@property (nonatomic, getter=getAnchor) NIAnchor anchor;
///优先级,默认为1.
@property (nonatomic, assign) NSInteger priority;

///默认为YES,当为NO时view忽略触摸事件
@property (nonatomic, getter=isEnabled) BOOL enabled;
///默认为NO,当为NO时view忽略拖拽事件
@property (nonatomic, assign) BOOL draggable;
///默认为YES,当为NO时view不可见
@property (nonatomic, assign) BOOL visable;


///内部调用
-(BOOL)onClicked:(CGPoint)pt;
-(BOOL)onDragBegin:(CGPoint)pt;
-(void)onDraging:(CGPoint)pt;
-(void)onDragEnd;
-(void)attchAnnotation: (id<NIAnnotation>) annotation;
-(void)detachAnnotation: (id<NIAnnotation>) annotation;
@property (nonatomic, readonly, getter = getAnnotationC)  void* mapOverlay;
@end






