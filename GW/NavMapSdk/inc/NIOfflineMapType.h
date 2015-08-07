/*
 *  NIOfflineMapType.h
 *
 *  Copyright 2014 Navinfo Inc. All rights reserved.
 *
 */

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

///离线地图搜索城市记录结构
@interface NIOLSearchRecord : NSObject
{
	NSString *  _cityName;
    int         _cityCode;
    NSString *  _keyword;
    int         _serversize;
    int       _cityType;
    CLLocationCoordinate2D   _pt;
    NSArray*  _childCities;
}
///城市名称
@property (nonatomic, retain) NSString* cityName;
///数据包总大小
@property (nonatomic) int serversize;
///城市ID
@property (nonatomic) int cityCode;
///城市中心点
@property (nonatomic) CLLocationCoordinate2D pt;
///城市名称
@property (nonatomic, retain) NSString* keyword;
///城市类型 城市类型0:直辖市；1：省份；2：城市,如果是省份，可以通过childCities得到子城市列表
@property (nonatomic) int cityType;
///子城市列表
@property (nonatomic, retain) NSArray*  childCities;

@end


///离线地图更新信息
@interface NIOLUpdateElement : NSObject
{
	NSString *  _cityName;
    int         _cityCode;
    CLLocationCoordinate2D         _pt;
    int         _serversize;
    BOOL        _update;
    int         _ratio;
	int         _status;
    BOOL       _bProvince;
}
///城市名称
@property (nonatomic, retain) NSString* cityName;
///城市ID
@property (nonatomic) int cityCode;
///已下载数据大小，单位：字节
//@property (nonatomic) int size;
///服务端数据大小，当update为YES时有效，单位：字节
@property (nonatomic) int serversize;
///下载比率，100为下载完成
@property (nonatomic) int ratio;
///城市名称
//@property (nonatomic, retain) NSString* pinyin;
///下载状态, 1:正在下载　2:网络异常　3:完成　4:已暂停 5:未定义 6:等待下载
@property (nonatomic) int status;
///更新状态
@property (nonatomic) BOOL update;
///城市中心点
@property (nonatomic) CLLocationCoordinate2D pt;

///更新状态
@property (nonatomic) BOOL bProvince;

@end
