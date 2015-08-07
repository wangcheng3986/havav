/*
*  NIPOISearchOption.h
*
*  Copyright (c) 2014年 Navinfo. All rights reserved.
*
*/

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "NITypes.h"

/// 排序方式
typedef enum {
    NIK_ASC = 2,    // 生序
    NIK_DESC = 1    // 降序
} NIK_SEARCH_ORDERBY_TYPE;

/// 排序方法
typedef enum {
    NIK_COMPREHENSIVE = 0,  // 综合排序
    NIK_DISTANCE = 20       // 距离排序
} NIK_SEARCH_SORT_TYPE;

/// POI范围内查询参数
@interface NIPOIBoundSearchOption : NSObject
{
    NICoordinateBounds      _bound;
    NSString*               _keyword;
    NIK_SEARCH_ORDERBY_TYPE _orderby;
    NSInteger               _pagecapacity;
    NSInteger               _pagenum;
    NIK_SEARCH_SORT_TYPE    _sorttype;
}
/// 地理范围
@property (nonatomic) NICoordinateBounds bound;
/// 关键字
@property (nonatomic, retain) NSString *keyword;
/// 排序方式
@property (nonatomic) NIK_SEARCH_ORDERBY_TYPE orderby;
/// 每页容量
@property (nonatomic) NSInteger pagecapacity;
/// 分页编号
@property (nonatomic) NSInteger pagenum;
/// 排序方法
@property (nonatomic) NIK_SEARCH_SORT_TYPE sorttype;
@end

/// POI城市查询参数
@interface NIPOICitySearchOption : NSObject
{
    NSString*               _city;
    NSString*               _keyword;
    NIK_SEARCH_ORDERBY_TYPE _orderby;
    NSInteger               _pagecapacity;
    NSInteger               _pagenum;
    NIK_SEARCH_SORT_TYPE    _sorttype;
}
/// 查询城市
@property (nonatomic, assign) NSString* city;
/// 关键字
@property (nonatomic, retain) NSString *keyword;
/// 排序方式
@property (nonatomic) NIK_SEARCH_ORDERBY_TYPE orderby;
/// 每页容量
@property (nonatomic) NSInteger pagecapacity;
/// 分页编号
@property (nonatomic) NSInteger pagenum;
/// 排序方法
@property (nonatomic) NIK_SEARCH_SORT_TYPE sorttype;
@end

/// POI周边搜索查询参数
@interface NIPOINearbySearchOption : NSObject
{
    CLLocationCoordinate2D  _location;
    NSInteger               _radius;
    NSString*               _keyword;
    NIK_SEARCH_ORDERBY_TYPE _orderby;
    NSInteger               _pagecapacity;
    NSInteger               _pagenum;
    NIK_SEARCH_SORT_TYPE    _sorttype;
}
/// 查询位置
@property (nonatomic, assign) CLLocationCoordinate2D location;
/// 查询半径
@property (nonatomic) NSInteger radius;
/// 关键字
@property (nonatomic, retain) NSString *keyword;
/// 排序方式
@property (nonatomic) NIK_SEARCH_ORDERBY_TYPE orderby;
/// 每页容量
@property (nonatomic) NSInteger pagecapacity;
/// 分页编号
@property (nonatomic) NSInteger pagenum;
/// 排序方法
@property (nonatomic) NIK_SEARCH_SORT_TYPE sorttype;
@end
