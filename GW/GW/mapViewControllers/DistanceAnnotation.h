//
//  DistanceAnnotation.h
//  NIMapSDKDemo
//
//  Created by wangcheng on 14-11-6.
//  Copyright (c) 2014年 Navinfo. All rights reserved.
//

#import "NIShape.h"

///绘制距离的annotation
@interface DistanceAnnotation : NIShape

///该点的坐标
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;


@end