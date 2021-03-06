/*
 *  NINaviManager.h
 *
 *  Copyright (c) 2014年 Navinfo. All rights reserved.
 *
 */
#import "NIMapView.h"
#import "NINaviKit.h"
#import "NINaviData.h"

/// 当前导航状态
typedef enum {
    NAVISTATUS_DEFAULT,
    NAVISTATUS_PLAN,
    NAVISTATUS_NAVI
} NAVISTATUS;

@protocol NINaviManagerDelegate;
///导航引擎管理类
@interface NINaviManager : NSObject {
    NINaviData* naviData;
    NAVISTATUS iStatus;
}

///构造函数
-(id)initWithMapView:(NIMapView*)mapview;

///路线参数设置
@property (nonatomic, retain) NINaviPara* naviPara;

///导航引擎的Delegate，不用的时候需要置nil
@property (nonatomic, retain) id<NINaviManagerDelegate> delegate;

///起点图标
@property (nonatomic, retain) NSString* startImgName;
///终点图标
@property (nonatomic, retain) NSString* endImgName;
///途经点图标
@property (nonatomic, retain) NSString* passByImgName;
///导航状态数据
@property (nonatomic, retain) NINaviData* naviData;
///当前导航状态
@property (nonatomic) NAVISTATUS iStatus;

/**
 * 计算导航路径
 * @param start 导航起点坐标
 * @param end   导航重点坐标
 * @return 开始计算返回YES，否则返回NO
 */
-(BOOL)showRouteWithStart:(CLLocationCoordinate2D)start andEnd:(CLLocationCoordinate2D)end;

/// 途径点坐标
@property(nonatomic,copy)NSMutableArray *PassByArry;

/// 清空导航路径
-(void)clearRoute;

///设置是否显示起终点图标
-(void)setShowIco:(BOOL)flag;

/**
 * 开始导航
 * @param simulate    YES为模拟导航   NO为实时导航
 * @param routeType   线路类型：0常规，1推荐
 * @return 成功返回YES，否则返回NO
 */
-(BOOL)startNavigation:(BOOL)simulate routeType:(NSInteger)type;

/**
 * 停止导航
 */
-(void)stopNavigation;

/**
 * 设置导航风格
 * @param isNorth      风格类型，　true：地图方向-上为北，false：地图方向-当前行驶道路朝上
 */
-(void)setNavigationStyle:(bool)isNorth;

/**
 * 设置模拟导航速度，速度范围（0.4-1.4）
 * @param bAdd 模拟速度正常情况下为1秒钟更新一次位置，bAdd为true时减少0.2秒，false，增加0.2秒，如果调用2次true，则0.6秒更新一次
 */
-(void)simulatorSpeedUp:(bool)bAdd;

/**
 * 暂行模拟导航
 */
-(void)pauseNavigationSimulator;

/**
 * 继续模拟导航
 */
-(void)resumeNavigationSimulator;

/**
 * 更新真实导航位置信息
 * @param lon     经度
 * @param lat     纬度
 * @param dSpeed  速度
 * @param dCourse 方向
 */
-(void)setNavigationGPS:(double)lon latitude:(double)lat speed:(double)dSpeed course:(double)dCourse;

/**
 * 设置当前车标
 * @param  pMapOverLay - pMapOverLay对象
 * @param  pId - pMapOverlayItem对象id
 */
-(void)setCurrentImage:pMapOverlay id:(int)pId;

/**
 * 设置导航绘制线路属性
 * @param iR      红   （0～1.0）
 * @param iG      绿
 * @param iB      蓝
 * @param iWidth  宽度
 */
-(void)setDrawRouteProperty:(CGFloat) R g:(CGFloat)G b:(CGFloat)B width:(int)iWidth;

/**
 * 设置声音是否正在播放。
 * @param bBusy  YES播放中   NO空闲中
 */
-(void)setVoiceBusy:(BOOL)bBusy;

@end

@protocol NINaviManagerDelegate <NSObject>

/**
 * 路线规划结果回调
 * @param naviManager 对应的导航引擎
 * @param data 规划的路线信息
 * @param error 错误码
 */
- (void)NINaviManager:(NINaviManager *)naviManager andRoute:(NINaviRoute*)data  andError:(int)error;

@optional
/**
 * 导航过程中状态变化回调
 * @param status   状态：0导航网络请求开始； 1导航网络请求结束；2表示错误；3表示导航中；4表示导航中有提示；5表示导航开始；6表示导航结束
 * @param data     导航数据
 * @param error    错误值
 */
-(void)onNavigation:(int)status naviData:(NINaviData*)data andError:(int)error;

@end
