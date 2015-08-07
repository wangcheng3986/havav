/*
*  NIBusSearchResult.h
*
*  Copyright (c) 2014年 Navinfo. All rights reserved.
*
*/

#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>
#import "NItypes.h"

/// 公交换乘节点信息
@interface NIBusSearchStep : NSObject {
    NSString*       _name;
    NSString*       _startstation;
    NSString*       _endstation;
    NSInteger       _type;
    NIMapPoint*     _points;
    NSUInteger      _pointCount;
    NSInteger       _stationcount;
    NSInteger       _distance;
    NSString*       _fwalk;
    NSString*       _ewalk;
    NSString*       _inexit;
    NSString*       _outexit;
}
/// 车次名称
@property (nonatomic, retain) NSString* name;
/// 上车站点名称
@property (nonatomic, retain) NSString* startstation;
/// 下车(换乘)站点名称
@property (nonatomic, retain) NSString* endstation;
/// 车辆类型：0:公交 1:地铁
@property (nonatomic) NSInteger type;
/// 线路坐标点数组
@property (nonatomic) NIMapPoint* points;
/// 线路坐标点的个数
@property (nonatomic) NSUInteger pointCount;
/// 经过站点个数
@property (nonatomic) NSInteger stationcount;
/// 总距离
@property (nonatomic) NSInteger distance;
/// 到达此站点步行信息
@property (nonatomic, retain) NSString* fwalk;
/// 达到终点步行信息
@property (nonatomic, retain) NSString* ewalk;
/// 入口信息
@property (nonatomic, retain) NSString* inexit;
/// 出口信息
@property (nonatomic, retain) NSString* outexit;
-(id)initWithData:(void*)result;
@end

/// 公交换乘方案信息
@interface NIBusSearchPlan : NSObject {
    NSInteger       _totals;
    double          _distance;
    NSInteger       _time;
}
/// 换乘次数
@property (nonatomic) NSInteger totals;
/// 距离
@property (nonatomic) double distance;
/// 估计时间
@property (nonatomic) NSInteger time;
/// 换乘节点信息列表，成员是NIBusSearchStep
@property (nonatomic, readonly) NSArray* step;
-(id)initWithData:(void*)result;
@end

/// 公交换乘搜索结果信息
@interface NIBusSearchResult : NSObject {
    NSInteger   _status;
    NSString*   _errormsg;
    NSInteger   _totals;
    CLLocationCoordinate2D  _startpoint;
    CLLocationCoordinate2D  _endpoint;
}
/// 状态代码\n
/// 0     执行正常\n
/// 600   连接失败\n
/// 601   客户端错误\n
/// 602   http服务器非正常应答\n
/// 700   应答超时\n
/// 701   数据接收超时\n
/// 702   下载的数据长度与服务器返回长度不等
@property (nonatomic) NSInteger status;
/// 结果状态描述信息
@property (nonatomic, retain) NSString* errormsg;
/// 参考结果数, 不能作为分页依据
@property (nonatomic) NSInteger totals;
/// 起点
@property (nonatomic, assign) CLLocationCoordinate2D startpoint;
/// 终点
@property (nonatomic, assign) CLLocationCoordinate2D endpoint;
/// 换乘方式列表，成员是NIBusSearchPlan
@property (nonatomic, readonly) NSArray* plans;
-(id)initWithData:(void*)result;
@end

/// 公交线路上的公交站点信息
@interface NIBusLineStation : NSObject {
    NSInteger               _index;
    CLLocationCoordinate2D  _location;
    NSString*               _name;
}
/// 站点索引
@property (nonatomic) NSInteger index;
/// 站点所在位置
@property (nonatomic, assign) CLLocationCoordinate2D location;
/// 站点名称
@property (nonatomic, retain) NSString* name;
-(id)initWithData:(void*)result;
@end

/// 公交线路信息
@interface NIBusLine : NSObject {
    NSString*       _name;
    NSString*       _start_time;
    NSString*       _end_time;
    NSInteger       _ticket_cal;
    NSInteger       _price;
    NSInteger       _preferential_type;
    NSInteger       _total;
    NIMapPoint*     _points;
    NSUInteger      _pointCount;
}
/// 线路名称
@property (nonatomic, retain) NSString* name;
/// 首班车时间
@property (nonatomic, retain) NSString* start_time;
/// 末班车时间
@property (nonatomic, retain) NSString* end_time;
/// 计票次数
@property (nonatomic) NSInteger ticket_cal;
/// 票价，单位：分
@property (nonatomic) NSInteger price;
/// 优惠类型
@property (nonatomic) NSInteger preferential_type;
/// 线路站点数
@property (nonatomic) NSInteger total;
/// 线路站点列表，成员是NIBusLineStation
@property (nonatomic, readonly) NSArray* stations;
/// 线路坐标点数组
@property (nonatomic) NIMapPoint* points;
/// 线路坐标点的个数
@property (nonatomic) NSUInteger pointCount;
-(id)initWithData:(void*)result;
@end

/// 公交线路搜索结果
@interface NIBusLineSearchResult : NSObject {
    NSInteger   _status;
    NSString*   _errormsg;
    NSInteger   _totals;
}
/// 状态代码\n
/// 0     执行正常\n
/// 600   连接失败\n
/// 601   客户端错误\n
/// 602   http服务器非正常应答\n
/// 700   应答超时\n
/// 701   数据接收超时\n
/// 702   下载的数据长度与服务器返回长度不等
@property (nonatomic) NSInteger status;
/// 结果状态描述信息
@property (nonatomic, retain) NSString* errormsg;
/// 参考结果数, 不能作为分页依据
@property (nonatomic) NSInteger totals;
/// 公交线路详情列表，成员是NIBusLine
@property (nonatomic, readonly) NSArray* lines;
-(id)initWithData:(void*)result;
@end

/// 公交站点的线路信息
@interface NIBusStationLine : NSObject {
    NSString*   _id;
    NSString*   _name;
    NSInteger   _order;
}
/// ID
@property (nonatomic, retain) NSString* id;
/// 站点名称
@property (nonatomic, retain) NSString* name;
/// order
@property (nonatomic) NSInteger order;
-(id)initWithData:(void*)result;
@end

/// 根据ID查公交站点的线路信息结果
@interface NIBusStationByIDSearchResult : NSObject {
    NSInteger   _status;
    NSInteger   _totals;
    NSString*   _errormsg;
}
/// 状态代码\n
/// 0     执行正常\n
/// 600   连接失败\n
/// 601   客户端错误\n
/// 602   http服务器非正常应答\n
/// 700   应答超时\n
/// 701   数据接收超时\n
/// 702   下载的数据长度与服务器返回长度不等
@property (nonatomic) NSInteger status;
/// 参考结果数, 不能作为分页依据
@property (nonatomic) NSInteger totals;
/// 结果状态描述信息
@property (nonatomic, retain) NSString* errormsg;
/// 公交站点的线路信息列表，成员是NIBusStationLine
@property (nonatomic, readonly) NSArray* lines;
-(id)initWithData:(void*)result;
@end

/// 公交站点信息
@interface NIBusStation : NSObject {
    NSString*   _id;
    NSString*   _name;
}
/// ID
@property (nonatomic, retain) NSString* id;
/// 站点名称
@property (nonatomic, retain) NSString* name;
-(id)initWithData:(void*)result;
@end

/// 根据名称查公交站点的结果
@interface NIBusStationByNameSearchResult : NSObject {
    NSInteger   _status;
    NSInteger   _totals;
    NSString*   _errormsg;
}
/// 状态代码\n
/// 0     执行正常\n
/// 600   连接失败\n
/// 601   客户端错误\n
/// 602   http服务器非正常应答\n
/// 700   应答超时\n
/// 701   数据接收超时\n
/// 702   下载的数据长度与服务器返回长度不等
@property (nonatomic) NSInteger status;
/// 参考结果数, 不能作为分页依据
@property (nonatomic) NSInteger totals;
/// 结果状态描述信息
@property (nonatomic, retain) NSString* errormsg;
/// 公交站点信息列表，成员是NIBusStation
@property (nonatomic, readonly) NSArray* stations;
-(id)initWithData:(void*)result;
@end
