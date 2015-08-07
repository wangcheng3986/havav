//
//  UIMapBaseViewController.h
//  GW
//
//  Created by wqw on 14/11/26.
//  Copyright (c) 2014年 mengy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIMapView.h"
#import "CustomMapView.h"
#import "NIGeoCodeSearch.h"
#import "NILocationService.h"
#import "MapPoiData.h"
#import "NILocationAnnotationView.h"
#import "DistanceAnnotation.h"
#import "NIActionPaopaoView.h"
#import "NIActionPaopaoAnnotation.h"
#import "NIMapKit.h"

@interface UIMapBaseViewController : UIViewController<NIMapViewDelegate,NIGeoCodeSearchDelegate,NILocationServiceDelegate,CLLocationManagerDelegate>
{
    CustomMapView *_mapViewBase;
}
//是否支持长压添加大头针标注
@property (nonatomic ,assign) BOOL LongPressure;
//显示放大按钮
@property (nonatomic ,assign) BOOL ZoomOutFlag;
//显示缩小按钮
@property (nonatomic ,assign) BOOL ZoomInFlag;
//显示比例尺按钮
@property (nonatomic ,assign) BOOL ScaleFlag;
//显示路况按钮
@property (nonatomic ,assign) BOOL TrafficFlag;
//显示指南针
@property (nonatomic ,assign) BOOL DirectionFlag;
//支持移动
@property (nonatomic ,assign) BOOL scrollFlag;
//支持多点缩放
@property (nonatomic ,assign) BOOL zoomFlag;
//支持单指双击（放大）和双指单击（缩小）
@property (nonatomic ,assign) BOOL zoomEnabledWithTapFlag;
//支持旋转
@property (nonatomic ,assign) BOOL rotateFlag;
//单击大头针显示的信息，是否需要逆地理
@property (nonatomic ,assign) BOOL requestReverseGeoFlag;
//是否开启定位功能
@property (nonatomic ,assign) BOOL requestLocationFlag;
//定位
@property(nonatomic,assign)BOOL bStart;                                   //开始定位标志

//车辆位置
@property(atomic,assign) CLLocationCoordinate2D carLocation;

//上一次人的位置点
@property(atomic,assign) CLLocationCoordinate2D preManLocation;
//当前人的位置点
@property(atomic,assign) CLLocationCoordinate2D curManLocation;

- (void)setMapView:(CustomMapView *)mapView;


- (void)loadMapBaseParameter;

- (void)drawOneLinestartPoint:(CLLocationCoordinate2D)CarCoord endPoint:(CLLocationCoordinate2D)manCoord;

- (void)addOneAnnotation:(MapPoiData*)coordData;

-(void)startLocation;
-(void)stopLocation;
-(void)test;
-(void)removeLineAndPoint;
//地图上添加多个大头针标注
- (void)addAnnotations:(NSArray*)Annotations needMatchingPointsInRegion:(BOOL)flag;
//将点移动到地图中心点
- (void)moveTo:(CLLocationCoordinate2D)coord;

-(void)MatchingPointsInRegionStart:(CLLocationCoordinate2D)CarCoord endPoint:(CLLocationCoordinate2D)manCoord;

-(NIMapStatus *)getMapStatus;

//移除长按大头针
-(void)removeLongclickPoint;
//移除paopao
-(void)releasePaopao;
//移除自定义大头针
-(void)removeOnePoint;
//设置地图状态
-(void)setMapStatus:(NIMapStatus*)mapStatus;
// show bubble
-(void)showBubble:(MapPoiData *)bubbleInfo;
//设置地图中心点
-(void)setMapCenter:(CLLocationCoordinate2D) centerPosition;

-(void)LaunchSearcher:(CLLocationCoordinate2D)coordinate;

- (void)releaseAnnotations;
@end
