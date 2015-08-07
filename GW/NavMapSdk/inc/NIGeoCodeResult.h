/*
*  NIGeocodeResult.h
*
*  Copyright (c) 2014年 Navinfo. All rights reserved.
*
*/

#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>

/// 国家区域信息
@interface NIAdminRegion : NSObject
{
	NSString* _country;
	NSString* _provcode;
	NSString* _provname;
	NSString* _citycode;
	NSString* _cityname;
	NSString* _distcode;
	NSString* _distname;
}
/// 国家
@property (nonatomic, retain) NSString* country;
/// 省份代码
@property (nonatomic, retain) NSString* provcode;
/// 省份名称
@property (nonatomic, retain) NSString* provname;
/// 市代码
@property (nonatomic, retain) NSString* citycode;
/// 市名称
@property (nonatomic, retain) NSString* cityname;
/// 区代码
@property (nonatomic, retain) NSString* distcode;
/// 区名称
@property (nonatomic, retain) NSString* distname;
-(id)initWithData:(void*)result;
@end

/// 道路信息
@interface NIRoad : NSObject
{
    double _distance;
    NSString* _name;
}
/// 道路距离
@property (nonatomic) double distance;
/// 道路名称
@property (nonatomic, retain) NSString* name;
-(id)initWithData:(void*)result;
@end

/// 地标信息
@interface NILand : NSObject
{
    NSString* _name;
    double _distance;
    NSString* _direction;
    CLLocationCoordinate2D _point;
}
/// 地标名称
@property (nonatomic, retain) NSString* name;
/// 地标距离
@property (nonatomic) double distance;
/// 方向信息
@property (nonatomic, retain) NSString* direction;
/// 地标坐标
@property (nonatomic) CLLocationCoordinate2D point;
-(id)initWithData:(void*)result;
@end

/// 交叉口信息
@interface NIAC : NSObject
{
    NSString* _name1;
    NSString* _name2;
    double _distance;
    NSString* _direction;
}
/// 交叉口道路一名称
@property (nonatomic, retain) NSString* name1;
/// 交叉口道路二名称
@property (nonatomic, retain) NSString* name2;
/// 交叉口距离
@property (nonatomic) double distance;
/// 方向信息
@property (nonatomic, retain) NSString* direction;
-(id)initWithData:(void*)result;
@end

/// 匹配到兴趣点信息
@interface NIPOI : NSObject
{
    NSString* _name;
    NSString* _direction;
    NSInteger distance;
}
/// 兴趣点名称
@property (nonatomic, retain) NSString* name;
/// 兴趣点方向信息
@property (nonatomic, retain) NSString* direction;
/// 兴趣点距离
@property (nonatomic) NSInteger distance;
-(id)initWithData:(void*)result;
@end

/// 逆地址编码结果
@interface NIReverseGeoCodeResult : NSObject
{
    NSInteger _status;
    NSInteger _detail;
    NSString* _longdescription;
    NSString* _shortdescription;
    NSString* _address;
	NIAdminRegion *_adminregion;
    NIRoad *_road;
    NILand *_land;
    NIAC *_ac;
    NIPOI *_poi;
    CLLocationCoordinate2D _point;
}
/// 逆地理编码解析状态码\n
/// 0     正常，查询未发生任何错误，返回0个或多个匹配结果obj\n
/// 501   访问合法性验证错误\n
/// 502   权限验证错误\n
/// 503   参数格式错误\n
/// 504   地图API出现异常\n
/// 600   连接失败\n
/// 601   客户端错误\n
/// 602   http服务器非正常应答\n
/// 700   应答超时\n
/// 701   数据接收超时\n
/// 702   下载的数据长度与服务器返回长度不等
@property (nonatomic) NSInteger status;
/// 匹配到的级别
@property (nonatomic) NSInteger detail;
/// 查询结果详细描述信息
@property (nonatomic, retain) NSString* longdescription;
/// 查询结果简单描述信息
@property (nonatomic, retain) NSString* shortdescription;
/// 地址信息
@property (nonatomic, retain) NSString* address;
/// 国家区域信息
@property (nonatomic, retain) NIAdminRegion* adminregion;
/// 道路信息
@property (nonatomic, retain) NIRoad* road;
/// 地标信息
@property (nonatomic, retain) NILand* land;
/// 交叉口信息
@property (nonatomic, retain) NIAC* ac;
/// 匹配到兴趣点信息
@property (nonatomic, retain) NIPOI* poi;
/// 对应的位置信息，与输入的一致
@property (nonatomic) CLLocationCoordinate2D location;
-(id)initWithData:(void*)result;
@end

/// 地理编码地址组成对象
@interface NIGeoAddressComponent : NSObject {
    NSString*   _name;
    NSString*   _code;
    NSInteger   _type;
}
/// 地址组成名称
@property (nonatomic, retain) NSString* name;
/// 地址组成编码
@property (nonatomic, retain) NSString* code;
/// 地址组成类型(0:国家，default=中国(cn) 1:省级 2:市级 3:区县级 4:商圈、乡镇、街道 5:道路 6:社区、小区、村、庄、屯、店、堡等 7:门牌号 8:POI名称(标志物))
@property (nonatomic) NSInteger type;
-(id)initWithData:(void*)result;
@end

/// 地理编码匹配对象
@interface NIGeoObj : NSObject {
    NSInteger _matchacc;
    CLLocationCoordinate2D _point;
    double _confidence;
    NSString* _address;
    NSString* _name;
}
/// 查询结果匹配级别
@property (nonatomic) NSInteger matchacc;
/// 查询结果位置坐标
@property (nonatomic) CLLocationCoordinate2D point;
/// 查询结果匹配度0～100，数值越大匹配度越高
@property (nonatomic) double confidence;
/// 查询结果地址
@property (nonatomic, retain) NSString* address;
/// 查询结果名称
@property (nonatomic, retain) NSString* name;
/// 地址组成列表，成员是NIGeoAddressComponent
@property (nonatomic, readonly) NSArray* coms;
-(id)initWithData:(void *)result;
@end

/// 地理编码结果
@interface NIGeoCodeResult : NSObject {
    NSInteger _status;
    NSInteger _total;
    NSInteger _inputacc;
}
/// 状态代码\n
/// 0     正常，查询未发生任何错误，返回0个或多个匹配结果obj\n
/// 301   无查询关键字\n
/// 302   查询关键字重复\n
/// 501   访问合法性验证错误\n
/// 502   权限验证错误\n
/// 503   参数格式错误\n
/// 504   地图API出现异常\n
/// 600   连接失败\n
/// 601   客户端错误\n
/// 602   http服务器非正常应答\n
/// 700   应答超时\n
/// 701   数据接收超时\n
/// 702   下载的数据长度与服务器返回长度不等
@property (nonatomic) NSInteger status;
/// 匹配结果数据0～n
@property (nonatomic) NSInteger total;
/// 匹配级别
@property (nonatomic) NSInteger inputacc;
/// 匹配结果对象列表，成员是NIGeoObj
@property (nonatomic, readonly)  NSArray* obj;
-(id)initWithData:(void *)result;
@end
