/*
 *  NILocationService.h
 *
 *  Copyright (c) 2014年 Navinfo. All rights reserved.
 *
 */
#import <Foundation/Foundation.h>
#import "NIUserLocation.h"
#import <CoreLocation/CoreLocation.h>

@class CLLocation;
/// 定位服务Delegate,调用startUserLocationService定位成功后，用此Delegate来获取定位数据
@protocol NILocationServiceDelegate <NSObject>
@optional
/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(NIUserLocation *)userLocation;

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserLocation:(NIUserLocation *)userLocation;

/**
 *定位失败后，会调用此函数
 *@param error 错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error;
@end

///定位服务类
@interface NILocationService : NSObject

/// 当前用户位置，返回坐标为四维图新坐标
@property (nonatomic, readonly) CLLocationManager * locMgr;

/// 当前用户位置，返回坐标为四维图新坐标
@property (nonatomic, readonly) NIUserLocation *userLocation;

/// 设置定位精度
@property(assign, nonatomic) CLLocationAccuracy desiredAccuracy;

/// 设置距离过滤器,单位:米
@property(assign, nonatomic) CLLocationDistance distanceFilter;

/// 定位服务Delegate,调用startUserLocationService定位成功后，用此Delegate来获取定位数据
@property (nonatomic, assign) id<NILocationServiceDelegate> delegate;

/**
 *打开定位服务
 */
-(void)startUserLocationService;
/**
 *关闭定位服务
 */
-(void)stopUserLocationService;

@end
