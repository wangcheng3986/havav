/*
 *  NINaviRoute.h
 *
 *  Copyright (c) 2014年 Navinfo. All rights reserved.
 *
 */


///路线信息
@interface NINaviRoute : NSObject
///规划路径长度，单位：米
@property (nonatomic, assign) NSInteger routeLength;
///规划路线时间，单位：秒
@property (nonatomic, assign) NSInteger routeTime;

@end