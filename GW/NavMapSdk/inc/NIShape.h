/*
*  NIShape.h
*
*  Copyright (c) 2014年 Navinfo. All rights reserved.
*
*/

#import "NIAnnotation.h"
#import "NIMapView.h"

/// 该类为一个抽象类，定义了基于NIAnnotation的NIShape类的基本属性和行为，不能直接使用，必须子类化之后才能使用
@interface NIShape : NSObject <NIAnnotation> {
}

/// 要显示的标题
@property (copy) NSString *title;
/// 要显示的副标题
@property (copy) NSString *subtitle;


-(id)initWithMapView: (NIMapView*)view;

@end