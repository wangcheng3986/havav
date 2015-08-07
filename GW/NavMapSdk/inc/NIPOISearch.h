/*
*  NIPOISearch.h
*
*  Copyright (c) 2014年 Navinfo. All rights reserved.
*
*/
#import "NIPOISearchOption.h"
#import "NIPOISearchResult.h"

@protocol NIPOISearchDelegate;

/// POI搜索服务
@interface NIPOISearch : NSObject

/// 检索模块的Delegate，此处记得不用的时候需要置nil，否则影响内存的释放
@property (nonatomic, retain) id<NIPOISearchDelegate> delegate;

/** 
 *根据范围和检索词发起范围检索 异步函数，返回结果在NIPOISearchDelegate的onGetPOISearchResult通知
 *@param option POI范围内查询参数
 *@return 成功返回YES，否则返回NO
 */
- (BOOL)searchInBound:(NIPOIBoundSearchOption*)option;

/** 
 *城市POI检索 异步函数，返回结果在NIPOISearchDelegate的onGetPOISearchResult通知
 *@param option POI城市查询参数
 *@return 成功返回YES，否则返回NO
 */
- (BOOL)searchInCity:(NIPOICitySearchOption*)option;

/** 
 *周边搜索查询 异步函数，返回结果在NIPOISearchDelegate的onGetPOISearchResult通知
 *@param NIPOINearbySearchOption 周边搜索查询参数
 *@return 成功返回YES，否则返回NO
 */
- (BOOL)searchNearby:(NIPOINearbySearchOption*)option;

@end

/// POI搜索服务Delegate，用此Delegate来获取查询结果数据
@protocol NIPOISearchDelegate<NSObject>
@optional
/** 
 *返回POI搜索服务查询结果
 *@param searcher 搜索对象
 *@param result 搜索结果列表
 *@param error 错误代码
 */
- (void)onGetPOISearchResult:(NIPOISearch *)searcher result:(NIPOISearchResult *)result errorCode:(NSInteger)error;

@end
