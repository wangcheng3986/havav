/*
 *  NIMapView.h
 *
 *  Copyright (c) 2014年 Navinfo. All rights reserved.
 *
 */

#import "NIBaseComponent.h"
#import "NITypes.h"
#import "NIAnnotation.h"
#import "NIAnnotationView.h"
#import "NIOverlayView.h"
#import "UIKit/UIKit.h"
#import "NIMapStatus.h"


@protocol NIMapViewDelegate;


///点击地图标注返回数据结构
@interface NIMapPoi : NSObject
///点标注的名称
@property (nonatomic,retain) NSString* text;
///点标注的经纬度坐标
@property (nonatomic,assign) CLLocationCoordinate2D pt;
@end


///地图View类，使用此View可以显示地图窗口，并且对地图进行相关的操作
@interface NIMapView : UIView

/**
 *设置显示放大按钮
 *@param Flag 是否显示按钮
 *@param validName 可选中状态的放大按钮图片名称
 *@param invalidName 不可选中状态的放大按钮图片名称
 *validName 和 invalidName 请成对使用，如果这两个参数都为nil将使用默认按钮。
 */
-(void)setShowZoomOut:(BOOL)Flag valid:(NSString*)validName Invalid:(NSString*)invalidName;

///设置显示缩小按钮
-(void)setShowZoomIn:(BOOL)Flag valid:(NSString*)validName Invalid:(NSString*)invalidName;

///设置显示比例尺及数字
-(void)setShowScale:(BOOL)Flag image:(NSString*)imageName;

///设置显示实时路况按钮
-(void)setShowTraffic:(BOOL)Flag valid:(NSString*)validName Invalid:(NSString*)invalidName;

///设置显示指北针
-(void)setShowDirection:(BOOL)Flag image:(NSString*)imageName;

///设置放大按钮位置
-(void)setZoomOutPoint:(CGPoint)input;

///设置缩小按钮位置
-(void)setZoomInPoint:(CGPoint)input;

///设置比例尺及数字位置
-(void)setScalePoint:(CGPoint)input;

///设置实时路况按钮位置
-(void)setTrafficPoint:(CGPoint)input;

///设置指北针位置
-(void)setDirectionPoint:(CGPoint)input;

///获得地图旋转角度
-(int)GetMapRotation;

///设置地图中心点经纬度 地图显示后设置。
-(void)setCenter:(CLLocationCoordinate2D) centerPosition;

///放大地图一个级别
-(void)MapZoomout;

///缩小地图一个级别
-(void)MapZoomin;

///设置地图缩放级别
-(void)setMapLevel:(float)fLevel;

///设置地图旋转角度
-(void)setMapRotate:(int)Routate;

///设置地图中心点在地图中的屏幕坐标位置
-(void)setCenterToPixel:(int)x newY:(int)y;

///地图的状态,包括中心点、中心点在地图屏幕上的像素坐标、缩放级别、旋转角度、俯视角度
@property(nonatomic, retain) NIMapStatus* mapStatus;

///动画显示设置的地图中心点，角度等。(设置中心点和角度互斥)
- (void)setMapStatus:(NIMapStatus*)mapStatus withAnimation:(BOOL)bAnimation;

///设定地图View能否支持用户移动地图
@property(nonatomic) BOOL scrollEnabled;

///设定地图是否支持用户单指双击（放大）和双指单击（缩小）
@property(nonatomic) BOOL zoomEnabledWithTap;

///设定地图View能否支持用户多点缩放(双指)
@property(nonatomic) BOOL zoomEnabled;

///设定地图View能否支持旋转
@property(nonatomic) BOOL rotateEnabled;

///屏幕坐标转经纬度
- (CLLocationCoordinate2D)convertPoint:(CGPoint)point;

///经纬度转屏幕
- (CGPoint)convertCoordinate:(CLLocationCoordinate2D)coordinate;

/**
 *返回合适的地图级别，和中心点。
 [in]points : 经纬度数组
 [in]count: 经纬度个数
 [in]rect：范围
 [out]center 返回的中心点
 retrun : 合适的地图级别
 */
-(float)MatchingPointsInRegion:(CLLocationCoordinate2D*)points andCount:(int)count andRegion:(CGRect)rect andOutCenter:(CLLocationCoordinate2D*)center;

/// 地图View的Delegate，此处记得不用的时候需要置nil，否则影响内存的释放
@property (nonatomic, retain) id<NIMapViewDelegate> delegate;

///地图渲染对象
@property (nonatomic, readonly) void* mapManager;

/**
 *当mapview即将被显式的时候调用，恢复之前存储的mapview状态。
 */
-(void)viewWillAppear;


/**
 *当mapview即将被隐藏的时候调用，存储当前mapview的状态。
 */
-(void)viewWillDisappear;

@end

///地图View类(和Annotation操作相关的接口)
@interface NIMapView (AnnotationAPI)

/// 当前地图View的已经添加的标注数组
@property (nonatomic, readonly) NSArray *annotations;

/**
 *向地图窗口添加标注，需要实现BMKMapViewDelegate的-mapView:viewForAnnotation:函数来生成标注对应的View
 *@param annotation 要添加的标注
 */
- (void)addAnnotation:(id <NIAnnotation>)annotation;

/**
 *向地图窗口添加一组标注，需要实现BMKMapViewDelegate的-mapView:viewForAnnotation:函数来生成标注对应的View
 *@param annotations 要添加的标注数组
 */
- (void)addAnnotations:(NSArray *)annotations;

/**
 *移除标注
 *@param annotation 要移除的标注
 */
- (void)removeAnnotation:(id <NIAnnotation>)annotation;

/**
 *移除一组标注
 *@param annotation 要移除的标注数组
 */
- (void)removeAnnotations:(NSArray *)annotations;

/**
 *更新标注对应的annotation view
 *@param annotation 要更新的标注
 *@param view 标注对应的view
 */
-(void)updateAnnotation:(id <NIAnnotation>)annotation withAnnotationView:(NIAnnotationView*)view;

/**
 *更新标注位置
 *@param annotation 要更新的标注
 */
-(void)updateAnnotationPositon:(id <NIAnnotation>)annotation;

/**
 *根据指定标识查找一个可被复用的标注View，一般在delegate中使用，用此函数来代替新申请一个View
 *@param identifier 指定标识
 *@return 返回可被复用的标注View
 */
- (NIAnnotationView *)dequeueReusableAnnotationViewWithIdentifier:(NSString *)identifier;

@end

///地图View类(和Overlay操作相关的接口)
@interface NIMapView (OverlaysAPI)

/**
 *向地图窗口添加Overlay，需要实现NIMapViewDelegate的-mapView:viewForOverlay:函数来生成标注对应的View
 *@param overlay 要添加的overlay
 */
- (void)addOverlay:(id <NIOverlay>)overlay;

/**
 *向地图窗口添加一组Overlay，需要实现NIMapViewDelegate的-mapView:viewForOverlay:函数来生成标注对应的View
 *@param overlays 要添加的overlay数组
 */
- (void)addOverlays:(NSArray *)overlays;

/**
 *移除Overlay
 *@param overlay 要移除的overlay
 */
- (void)removeOverlay:(id <NIOverlay>)overlay;

/**
 *移除一组Overlay
 *@param overlays 要移除的overlay数组
 */
- (void)removeOverlays:(NSArray *)overlays;

/**
 *更新Overlay，需要实现NIMapViewDelegate的-mapView:viewForOverlay:函数来生成标注对应的View
 *@param overlay 要更新的overlay
 */
- (void)updateOverlayPosition:(id <NIOverlay>)overlay;

/// 当前mapView中已经添加的Overlay数组
@property (nonatomic, readonly) NSArray *overlays;

@end


/// MapView的Delegate，mapView通过此类来通知用户对应的事件
@protocol NIMapViewDelegate <NSObject>
@optional

/**
 *根据overlay生成对应的View
 *@param mapView 地图View
 *@param overlay 指定的overlay
 *@return 生成的覆盖物View
 */
- (NIOverlayView *)mapView:(NIMapView *)mapView viewForOverlay:(id <NIOverlay>)overlay;

/**
 *根据anntation生成对应的View
 *@param mapView 地图View
 *@param annotation 指定的标注
 *@return 生成的标注View
 */
- (NIAnnotationView *)mapView:(NIMapView *)mapView viewForAnnotation:(id <NIAnnotation>)annotation;

/**
 *当点击annotation 气泡时，调用此接口
 *@param mapView 地图View
 *@param view annotation对象
 */
- (void)mapView:(NIMapView *)mapView onClickedAnnotationForBubble:(NSInteger)index;

/**
 *当点击annotation时，调用此接口
 *@param mapView 地图View
 *@param view annotation对象
 */
- (void)mapView:(NIMapView *)mapView onClickedAnnotation:(id <NIAnnotation>)annotation;

/**
 *点中地图标注后会回调此接口
 *@param mapview 地图View
 *@param mapPoi 标注点信息
 */
- (void)mapView:(NIMapView *)mapView onClickedMapPoi:(NIMapPoi*)mapPoi;

/**
 *点中底图空白处会回调此接口
 *@param mapview 地图View
 *@param coordinate 空白处坐标点的经纬度
 */
- (void)mapView:(NIMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate;

/**
 *双击地图时会回调此接口
 *@param mapview 地图View
 *@param coordinate 返回双击处坐标点的经纬度
 */
- (void)mapView:(NIMapView *)mapView onDoubleClick:(CLLocationCoordinate2D)coordinate;

/**
 *长按地图时会回调此接口
 *@param mapview 地图View
 *@param coordinate 返回长按事件坐标点的经纬度
 */
- (void)mapView:(NIMapView *)mapView onLongClick:(CLLocationCoordinate2D)coordinate;

/**
 *地图状态改变完成后会调用此接口
 *@param mapview 地图View
 */
- (void)mapStatusDidChanged:(NIMapView *)mapView;

/**
 *地图加载完成后会调用此接口
 *@param mapview 地图View
 */
- (void)mapLoadFinish:(NIMapView *)mapView;

@end




