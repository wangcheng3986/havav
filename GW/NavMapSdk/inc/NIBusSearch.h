/*
*  NIBusSearch.h
*
*  Copyright (c) 2014年 Navinfo. All rights reserved.
*
*/
#import "NIBusSearchOption.h"
#import "NIBusSearchResult.h"

@protocol NIBusSearchDelegate;

/// 公交换乘、公交线路、公交站点查询服务
@interface NIBusSearch : NSObject

/// 检索模块的Delegate，此处记得不用的时候需要置nil，否则影响内存的释放
@property (nonatomic, retain) id<NIBusSearchDelegate> delegate;

/** 
 *公交换乘查询 异步函数，返回结果在NIBusSearchDelegate的onGetBusSearchResult通知
 *@param option 公交换乘查询信息类
 *@return 成功返回YES，否则返回NO
 */
- (BOOL)BusSearch:(NIBusSearchOption*)option;

/** 
 *按ID查公交线路 异步函数，返回结果在NIBusSearchDelegate的onGetBusLineSearchResult通知
 *@param option 根据ID查询公交线路、公交站点信息类
 *@return 成功返回YES，否则返回NO
 */
- (BOOL)BusLineByIDSearch:(NIBusByIDSearchOption*)option;

/** 
 *按名称查公交线路 异步函数，返回结果在NIBusSearchDelegate的onGetBusLineSearchResult通知
 *@param option 根据名称查询公交线路、公交站点信息类
 *@return 成功返回YES，否则返回NO
 */
- (BOOL)BusLineByNameSearch:(NIBusByNameSearchOption*)option;

/** 
 *按ID查公交站点 异步函数，返回结果在NIBusSearchDelegate的onGetBusStationByIDSearchResult通知
 *@param option 根据ID查询公交线路、公交站点信息类
 *@return 成功返回YES，否则返回NO
 */
- (BOOL)BusStationByIDSearch:(NIBusByIDSearchOption*)option;

/** 
 *按名称查公交站点 异步函数，返回结果在NIBusSearchDelegate的onGetBusStationByNameSearchResult通知
 *@param option 根据名称查询公交线路、公交站点信息类
 *@return 成功返回YES，否则返回NO
 */
- (BOOL)BusStationByNameSearch:(NIBusByNameSearchOption*)option;

@end

///公交换乘、公交线路、公交站点查询服务Delegate，用此Delegate来获取查询结果数据
@protocol NIBusSearchDelegate<NSObject>

@optional
/** 
 *返回公交换乘查询结果
 *@param searcher 搜索对象
 *@param result 搜索结果列表
 *@param error 错误代码
 */
- (void)onGetBusSearchResult:(NIBusSearch *)searcher result:(NIBusSearchResult *)result errorCode:(NSInteger)error;

/** 
 *返回公交线路查询结果
 *@param searcher 搜索对象
 *@param result 搜索结果列表
 *@param error 错误代码
 */
- (void)onGetBusLineSearchResult:(NIBusSearch *)searcher result:(NIBusLineSearchResult *)result errorCode:(NSInteger)error;

/** 
 *返回按站点ID查公交站点查询结果
 *@param searcher 搜索对象
 *@param result 搜索结果列表
 *@param error 错误代码
 */
- (void)onGetBusStationByIDSearchResult:(NIBusSearch *)searcher result:(NIBusStationByIDSearchResult *)result errorCode:(NSInteger)error;

/** 
 *返回按站点名称查公交站点查询结果
 *@param searcher 搜索对象
 *@param result 搜索结果列表
 *@param error 错误代码
 */
- (void)onGetBusStationByNameSearchResult:(NIBusSearch *)searcher result:(NIBusStationByNameSearchResult *)result errorCode:(NSInteger)error;

@end
