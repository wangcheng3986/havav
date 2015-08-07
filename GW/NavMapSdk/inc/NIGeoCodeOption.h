/*
*  NIGeoCodeOption.h
*
*  Copyright (c) 2014年 Navinfo. All rights reserved.
*
*/

#import <CoreLocation/CoreLocation.h>

/// 地理编码请求信息类
@interface NIGeoCodeOption : NSObject
{
     NSString        *_address;
     NSString        *_city;
}
/// 地理编码地址参数
@property (nonatomic, retain) NSString *address;
/// 地理编码城市编码参数
@property (nonatomic, retain) NSString *city;
@end

/// 逆地理编码请求信息类
@interface NIReverseGeoCodeOption : NSObject
{
    CLLocationCoordinate2D        _reverseGeoPoint;
}
/// 位置信息
@property (nonatomic, assign) CLLocationCoordinate2D reverseGeoPoint;
@end
