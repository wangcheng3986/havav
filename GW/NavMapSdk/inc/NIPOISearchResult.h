/*
*  NIPOISearchResult.h
*
*  Copyright (c) 2014年 Navinfo. All rights reserved.
*
*/

#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>

/// POI类别信息
@interface NIPOIKind : NSObject {
    NSString*   _code;
    NSString*   _name;
}
/// POI类别编码
@property (nonatomic, retain) NSString* code;
/// POI类别名称
@property (nonatomic, retain) NSString* name;
-(id)initWithData:(void*)result;
@end

/// POI点经纬度信息以及类别信息
@interface NIPOIGeo : NSObject {
    NSInteger   _type;
    NSString*   _value;
    CLLocationCoordinate2D  _location;
}
/// POI类别信息(0:点 1:线 2:面)
@property (nonatomic) NSInteger type;
/// WTK字符串
@property (nonatomic, retain) NSString* value;
/// 点位置
@property (nonatomic, assign) CLLocationCoordinate2D location;
-(id)initWithData:(void*)result;
@end

/// POI行政区划信息
@interface NIPOIAdminRegion : NSObject {
	NSString*   _country;
	NSString*   _provcode;
	NSString*   _provname;
	NSString*   _citycode;
	NSString*   _cityname;
	NSString*   _distcode;
	NSString*   _distname;
}
/// 国家
@property (nonatomic, retain) NSString* country;
/// 省编码
@property (nonatomic, retain) NSString* provcode;
/// 省名称
@property (nonatomic, retain) NSString* provname;
/// 市编码
@property (nonatomic, retain) NSString* citycode;
/// 市名称
@property (nonatomic, retain) NSString* cityname;
/// 行政区划编码
@property (nonatomic, retain) NSString* distcode;
/// 行政区划名称
@property (nonatomic, retain) NSString* distname;
@end

/// POI信息
@interface NIPOIInfo : NSObject {
    NSString*   _id;
    NSString*   _name;
    NSString*   _py;
    NSString*   _address;
    NSString*   _postcode;
    double      _distance;
    NSString*   _telephone;
    BOOL        _rpst;
    NSInteger   _flag;
    NSString*   _rem;
    NSString*   _relpid;
    NSString*   _tran;
    NSString*   _data;
    NIPOIKind*  _kind;
    NIPOIGeo*   _geo;
    NIPOIAdminRegion* _adminregion;
}
/// POI永久ID
@property (nonatomic, retain) NSString* id;
/// POI名称
@property (nonatomic, retain) NSString* name;
/// POI名称拼音
@property (nonatomic, retain) NSString* py;
/// POI地址信息
@property (nonatomic, retain) NSString* address;
/// 邮政编码
@property (nonatomic, retain) NSString* postcode;
/// 距中心的距离
@property (nonatomic) double distance;
/// POI电话信息
@property (nonatomic, retain) NSString* telephone;
/// 深度信息标识
@property (nonatomic) BOOL rpst;
/// POI类型(0:普通POI，3:行政区划，4:公交站点，5:公交线路，6:道路)
@property (nonatomic) NSInteger flag;
/// 补充信息
@property (nonatomic, retain) NSString* rem;
/// 聚合点id列表
@property (nonatomic, retain) NSString* relpid;
/// 转义标识
@property (nonatomic, retain) NSString* tran;
/// 数据来源
@property (nonatomic, retain) NSString* data;
/// POI类别信息
@property (nonatomic, assign) NIPOIKind* kind;
/// POI点经纬度信息以及类别信息
@property (nonatomic, assign) NIPOIGeo* geo;
/// POI行政区划信息
@property (nonatomic, assign) NIPOIAdminRegion* adminregion;
-(id)initWithData:(void*)result;
@end

/// POI搜索结果
@interface NIPOISearchResult : NSObject {
    NSInteger   _status;
    long        _time;
    NSInteger   _total;
}
/// 状态代码\n
/// 0      执行正常\n
/// 201    无效查询关键字\n
/// 202    查询关键字重复\n
/// 203    该行政区划或城市没有数据或行政区划输入错误\n
/// 204    设置起始页错误\n
/// 205    空间范围越界\n
/// 206    输入WTK字串错误\n
/// 207    在道路中，没有指定的行政区划\n
/// 208    类别值错误\n
/// 209    行政区域值错误\n
/// 20>=20 系统错误,如2021、2022\n
/// 501    访问合法性验证错误\n
/// 502    权限验证错误\n
/// 503    参数格式错误\n
/// 504    地图API出现异常\n
/// 600    连接失败\n
/// 601    客户端错误\n
/// 602    http服务器非正常应答\n
/// 700    应答超时\n
/// 701    数据接收超时\n
/// 702    下载的数据长度与服务器返回长度不等
@property (nonatomic) NSInteger status;
/// 搜索总用时，单位毫秒
@property (nonatomic) long time;
/// 匹配结果数量0～n
@property (nonatomic) NSInteger total;
/// 搜索结果列表，成员是NIPOIInfo
@property (nonatomic, readonly) NSArray* pois;
-(id)initWithData:(void*)result;
@end
