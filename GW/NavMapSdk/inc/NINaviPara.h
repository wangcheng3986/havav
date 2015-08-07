/*
 *  NINaviPara.h
 *
 *  Copyright (c) 2014年 Navinfo. All rights reserved.
 *
 */
typedef enum
{
    NAVIPLANTYPE_SHORTESTDISTANCE = 0,      //最短距离
    NAVIPLANTYPE_FASTESTTIME,           //最快时间
    NAVIPLANTYPE_HIGHPRIORITY,          //高速优先
    NAVIPLANTYPE_STATEROADPRIORITY      //国道优先
} NaviPlanType;

/// 此类用于定义一段圆弧
@interface NINaviPara : NSObject

///路线规划方式
@property (nonatomic, assign) NaviPlanType planType ;
///是否避开收费道路
@property (nonatomic, assign) BOOL bAvoidTollRoad ;
///是否避开红绿灯(false:不避开 ture:避开)
@property (nonatomic, assign) BOOL bAvoidTrafficLights ;


@end
