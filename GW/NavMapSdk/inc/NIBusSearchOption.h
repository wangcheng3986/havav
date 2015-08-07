/*
*  NIBusSearchOption.h
*
*  Copyright (c) 2014年 Navinfo. All rights reserved.
*
*/

#import <CoreLocation/CoreLocation.h>

/// 排序方式
typedef enum {
    NIK_TIME_FIRST      = 0,
    NIK_DISTANCE_FIRST  = 1,
    NIK_TRANSFER_FIRST  = 2,
    NIK_WALK_FIRST      = 3
} NIK_BUS_SORT_TYPE;

/// 公交换乘查询信息类
@interface NIBusSearchOption : NSObject
{
    CLLocationCoordinate2D  _start;
    CLLocationCoordinate2D  _end;
    NSString*               _city;
    BOOL                    _subway;
    NIK_BUS_SORT_TYPE       _sort;
}
/// 起点经纬度坐标
@property (nonatomic, assign) CLLocationCoordinate2D start;
/// 终点经纬度坐标
@property (nonatomic, assign) CLLocationCoordinate2D end;
/// 城市编码(6位数字)
@property (nonatomic, retain) NSString* city;
/// 是否支持地铁换乘(NO:不支持 YES:支持)
@property (nonatomic) BOOL subway;
/// 结果策略排序类型 (0:时间优先 [默认] 1:距离优先 2:少换乘 3:少步行)
@property (nonatomic) NIK_BUS_SORT_TYPE sort;
@end

/// 根据ID查询公交线路、公交站点信息类
@interface NIBusByIDSearchOption : NSObject
{
    NSString*   _id;
    NSString*   _city;
}
/// ID
@property (nonatomic, retain) NSString* id;
/// 城市编码(6位数字)
@property (nonatomic, retain) NSString* city;
@end

/// 根据名称查询公交线路、公交站点信息类
@interface NIBusByNameSearchOption : NSObject
{
    NSString*   _name;
    NSString*   _city;
}
/// 公交线路名称
@property (nonatomic, retain) NSString* name;
/// 城市编码(6位数字)
@property (nonatomic, retain) NSString* city;
@end

