/*
*  NIGeoCodeSearch.h
*
*  Copyright (c) 2014年 Navinfo. All rights reserved.
*
*/
#import "NIGeoCodeOption.h"
#import "NIGeoCodeResult.h"

@protocol NIGeoCodeSearchDelegate;

/// 地理编码/逆地理编码搜索服务
@interface NIGeoCodeSearch : NSObject

/// 检索模块的Delegate，此处记得不用的时候需要置nil，否则影响内存的释放
@property (nonatomic, retain) id<NIGeoCodeSearchDelegate> delegate;

/** 
 *根据地址名称获取地理信息 异步函数，返回结果在NIGeoCodeSearchDelegate的onGetGeoCodeResult通知
 *@param geoCodeOption 地理编码请求信息类
 *@return 成功返回YES，否则返回NO
 */
- (BOOL)geoCode:(NIGeoCodeOption*)geoCodeOption;

/** 
 *根据地理坐标获取地址信息 异步函数，返回结果在NIGeoCodeSearchDelegate的onGetReverseGeoCodeResult通知
 *@param reverseGeoCodeOption 逆地理编码请求信息类
 *@return 成功返回YES，否则返回NO
 */
- (BOOL)reverseGeoCode:(NIReverseGeoCodeOption*)reverseGeoCodeOption ;

@end

/// 地理编码/逆地理编码搜索服务Delegate，用此Delegate来获取查询结果数据
@protocol NIGeoCodeSearchDelegate<NSObject>
@optional
/** 
 *返回地理编码查询结果
 *@param searcher 搜索对象
 *@param result 搜索结果列表
 *@param error 错误代码
 */
- (void)onGetGeoCodeResult:(NIGeoCodeSearch *)searcher result:(NIGeoCodeResult *)result errorCode:(NSInteger)error;

/** 
 *返回逆地理编码查询结果
 *@param searcher 搜索对象
 *@param result 搜索结果列表
 *@param error 错误代码
 */
- (void)onGetReverseGeoCodeResult:(NIGeoCodeSearch *)searcher result:(NIReverseGeoCodeResult *)result errorCode:(int)error;

@end
