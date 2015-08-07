/*
 *  NIOfflineMap.h
 *
 *  Copyright 2014 Navinfo Inc. All rights reserved.
 *
 */

#import <Foundation/Foundation.h>
#import "NIOfflineMapType.h"


@protocol NIOfflineMapDelegate;

///离线地图事件类型
enum  {
	NI_DL_REQUSET = 0, ///<提交地图下载请求   null
    NI_DL_RESPONSE = 1, ///<地图下载的总大小  size
    NI_DL_NO_SPACE_SIZE = 2,///<判断空间是否足够大   null
    NI_DL_PROGRESS = 3, ///<地图下载的百分比  20,30
    NI_DL_COMPLETED = 4, ///<地图下载完成  null
    NI_DL_ERR = 5,      ///<地图下载错误
    NI_IS_START = 6, ///<地图下载完成后 开始安装 null
    NI_IS_DONE = 7, ///<地图下载完成后 安装完成 null
    NI_IS_ERR = 8,      ///<地图安装错误 null
    NI_DATE = 9        ///< 给平台发date
};

///离线地图服务
@interface NIOfflineMap : NSObject

@property (nonatomic, retain) id<NIOfflineMapDelegate> delegate;

/**
 *启动下载指定城市id的离线地图
 *@param cityID 指定的城市id
 *@return 成功返回YES，否则返回NO
 */
- (BOOL)start:(int)cityID;

/**
 *启动更新指定城市id的离线地图
 *@param cityID 指定的城市id
 *@return 成功返回YES，否则返回NO
 */
- (BOOL)update:(int)cityID;

/**
 *暂停下载指定城市id的离线地图
 *@param cityID 指定的城市id
 *@return 成功返回YES，否则返回NO
 */
- (BOOL)pause:(int)cityID;

/**
 *删除下载指定城市id的离线地图
 *@param cityID 指定的城市id
 *@return 成功返回YES，否则返回NO
 */
- (BOOL)remove:(int)cityID;

/**
 *返回所有支持离线地图的城市列表
 *@return 支持离线地图的城市列表,用户需要显示释放该数组，数组元素为NIOLSearchRecord
 */
- (NSArray*)getOfflineCityList;

/**
 *根据城市名搜索该城市离线地图记录
 *@param cityName 城市名
 *@return 该城市离线地图记录,用户需要显示释放该数组，数组元素为NIOLSearchRecord
 */
- (NSArray*)searchCity:(NSString*)cityName;

/**
 *返回各城市离线地图更新信息
 *@return 各城市离线地图更新信息,用户需要显示释放该数组，数组元素为NIOLUpdateElement
 */
- (NSArray*)getAllUpdateInfo;

/**
 *返回指定城市id离线地图更新信息
 *@param cityID 指定的城市id
 *@return 指定城市id离线地图更新信息,用户需要显示释放该数据
 */
- (NIOLUpdateElement*)getUpdateInfo:(int)cityID;

@end


///离线地图delegate，用于获取通知
@protocol NIOfflineMapDelegate<NSObject>
/**
 *返回通知结果
 *@param type 事件类型：  NI_DL_REQUSET,NI_DL_RESPONSE,NI_DL_NO_SPACE_SIZE,NI_DL_PROGRESS,NI_DL_COMPLETED,NI_DL_ERR,NI_IS_START,NI_IS_DONE,NI_IS_ERR,NI_DATE.
 *@param state 事件返回值，当type为NI_DL_REQUSET时，state ＝ nil.当type为NI_DL_RESPONSE时，state ＝ nil.当type为NI_DL_NO_SPACE_SIZE时，state = nil。当type为NI_DL_PROGRESS时，state = 百分比  20,30.当type为NI_DL_COMPLETED时，state = nil，当type为NI_DL_ERR时，state = nil，当type为NI_IS_START时，state = nil. 当type为NI_IS_DONE时，state = nil，当type为NI_IS_ERR时，state = nil. 当type为NI_DATE时，state = .
 */
- (void)onGetOfflineMapState:(int)type withState:(void*)state;

@end


