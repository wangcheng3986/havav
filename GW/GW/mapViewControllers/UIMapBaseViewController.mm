//
//  UIMapBaseViewController.m
//  GW
//
//  Created by wqw on 14/11/26.
//  Copyright (c) 2014年 Navinfo. All rights reserved.
//

#import "UIMapBaseViewController.h"


#import "App.h"


@interface UIMapBaseViewController ()
{
    //线段、圆、矩形
    NICircle* circle;
    NIPolygon* polygon;
    NIPolyline* polyline;
    
    //线段端点a  自车位置
    NIPointAnnotation* pointA;
    DistanceAnnotation* distanceA;
    //线段端点b  手机位置
    NIPointAnnotation* pointB;
    DistanceAnnotation* distanceB;
    
    //长按大头针
    NIPointAnnotation* pointAnnotation;
    //气泡
    NIActionPaopaoAnnotation* ppAnnotation;
    //地理编码／逆地理编码
    NIGeoCodeSearch *_searcher;
    
    //再地图上添加单个大头针标注
    NIPointAnnotation* point;
    
    //添加单个大头针标注 可以换图片
    NIPointAnnotation* onePoint;
    //定位功能
    NILocationService* _locService;
    
    NIAnnotationView * _myPosView;        //绘制点view
    NIPointAnnotation * _myPosAnnotation;          //绘制点
    
    double _dLocationDirection;                      //罗盘方向
    
    NSMutableArray *pointAnnotationArray;//存储多个大头针
    
    ///add by wangcheng
//    NIAnnotationView *_distanceviewA;
//    NIAnnotationView* _distanceviewB;
//    NIAnnotationView*  _point_A;
//    NIAnnotationView*  _point_B;
//    NIAnnotationView* _one_Point;
//    NIAnnotationView* _viewPoint;
//    NIAnnotationView* viewPaopao;
}
@end

@implementation UIMapBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
    // Do any additional setup after loading the view.
}


-(void)enterBackground
{
    [_mapViewBase viewWillDisappear];
}

-(void)enterForeground
{
    [_mapViewBase viewWillAppear];
}


#pragma mark-基本参数设置
- (void)setMapView:(CustomMapView *)mapView
{
    _mapViewBase = mapView;
    //初始化基本参数
    _ZoomOutFlag = NO;
    _ZoomInFlag = NO;
    _ScaleFlag = YES;
    _TrafficFlag = NO;
    _DirectionFlag =YES;
    _scrollFlag = YES;
    _zoomFlag = YES;
    _zoomEnabledWithTapFlag = YES;
    _rotateFlag = NO;
    _LongPressure =YES;
    _requestReverseGeoFlag =YES;
    _requestLocationFlag = NO;
    _bStart = NO;
}
//地图常用基本设置参
- (void)loadMapBaseParameter
{
    //显示放大按钮
    [_mapViewBase.mapViewShare.mapView setShowZoomOut:_ZoomOutFlag valid:nil Invalid:nil];
    //显示缩小按钮
    [_mapViewBase.mapViewShare.mapView setShowZoomIn:_ZoomInFlag valid:nil Invalid:nil];
    //显示比例尺按钮
    [_mapViewBase.mapViewShare.mapView setShowScale:_ScaleFlag image:nil];
    //显示路况按钮
    [_mapViewBase.mapViewShare.mapView setShowTraffic:_TrafficFlag valid:nil Invalid:nil];
    //显示指南针
    [_mapViewBase.mapViewShare.mapView setShowDirection:_DirectionFlag image:nil];
    //支持移动
    _mapViewBase.mapViewShare.mapView.scrollEnabled = _scrollFlag;
    
    //支持多点缩放
    _mapViewBase.mapViewShare.mapView.zoomEnabled = _zoomFlag;
    
    //支持单指双击（放大）和双指单击（缩小）
    _mapViewBase.mapViewShare.mapView.zoomEnabledWithTap = _zoomEnabledWithTapFlag;
    
    //支持旋转
    _mapViewBase.mapViewShare.mapView.rotateEnabled = _rotateFlag;

}
//将点移动到地图中心点
- (void)moveTo:(CLLocationCoordinate2D)coord
{
    NIMapStatus *ptemp = [[NIMapStatus alloc]init];
    ptemp.fLevel = _mapViewBase.mapViewShare.mapView.mapStatus.fLevel;
    ptemp.targetGeoPt = coord;
    ptemp.fRotation = _mapViewBase.mapViewShare.mapView.mapStatus.fRotation;
    //动画移动到中心点
    [_mapViewBase.mapViewShare.mapView setMapStatus:ptemp withAnimation:YES];
    [ptemp release];
}
//取得地图状态
-(NIMapStatus *)getMapStatus
{
    return _mapViewBase.mapViewShare.mapView.mapStatus;
}
//设置地图状态
-(void)setMapStatus:(NIMapStatus*)mapStatus
{
    //动画移动到中心点
    [_mapViewBase.mapViewShare.mapView setMapStatus:mapStatus withAnimation:NO];

}

#pragma mark-描画函数
////画线 车辆 人
- (void)drawOneLinestartPoint:(CLLocationCoordinate2D)CarCoord endPoint:(CLLocationCoordinate2D)manCoord
{
    if (polyline == nil)
    {
        CLLocationCoordinate2D coors[2] = {0};
        coors[0].latitude = CarCoord.latitude;
        coors[0].longitude = CarCoord.longitude;
        coors[1].latitude = manCoord.latitude;
        coors[1].longitude = manCoord.longitude;
        

        
        if (CarCoord.latitude != 0 || CarCoord.longitude !=0)
        {
            polyline = [NIPolyline polylineWithCoordinates:coors count:2 mapView: _mapViewBase.mapViewShare.mapView];
            [ _mapViewBase.mapViewShare.mapView addOverlay:polyline];
            
            NSLog(@"%@",_mapViewBase.mapViewShare.mapView);
            pointA = [[NIPointAnnotation alloc]initWithMapView:_mapViewBase.mapViewShare.mapView];
            pointA.coordinate = coors[0];
            pointA.annotationID = ID_POI_CAR;
            [_mapViewBase.mapViewShare.mapView addAnnotation:pointA];
            
            distanceA = [[DistanceAnnotation alloc]initWithMapView:_mapViewBase.mapViewShare.mapView];
            CLLocationDistance dis =  NIMetersBetweenMapPoints(coors[0], coors[1]);
            NSString *dist;
            if (dis <1000)
            {
                dist = [NSString stringWithFormat:@"%.fm", dis];
            }
            else
            {
                dist = [NSString stringWithFormat:@"%.1fKm", dis/1000];
                
            }
            distanceA.coordinate = coors[0];
            distanceA.annotationID = 201;
            distanceA.title = [NSString stringWithString:dist];
            [_mapViewBase.mapViewShare.mapView addAnnotation:distanceA];
            
            distanceB = [[DistanceAnnotation alloc]initWithMapView:_mapViewBase.mapViewShare.mapView];
            distanceB.coordinate = coors[1];
            distanceB.annotationID =202;
            distanceB.title = [NSString stringWithString:dist];
            [_mapViewBase.mapViewShare.mapView addAnnotation:distanceB];
            
            


        }
        
        
        pointB = [[NIPointAnnotation alloc]initWithMapView:_mapViewBase.mapViewShare.mapView];
        pointB.coordinate = coors[1];
        pointB.annotationID= ID_POI_CUR;
        [_mapViewBase.mapViewShare.mapView addAnnotation:pointB];

//        mengyue
        
//        if (CarCoord.latitude == 0 || CarCoord.longitude ==0)
//        {
//            
//            [_mapViewBase.mapViewShare.mapView setMapLevel:11];
//            [_mapViewBase.mapViewShare.mapView setCenter:pointB.coordinate];
//        }
        
//        end 

    }
}
//自动适配2个点 在屏幕内
-(void)MatchingPointsInRegionStart:(CLLocationCoordinate2D)CarCoord endPoint:(CLLocationCoordinate2D)manCoord
{
    CLLocationCoordinate2D coors[2] = {0};
    coors[0].latitude = CarCoord.latitude;
    coors[0].longitude = CarCoord.longitude;
    coors[1].latitude = manCoord.latitude;
    coors[1].longitude = manCoord.longitude;
    
    
    //合适的地图级别，和中心点。
    CLLocationCoordinate2D center;
    CGRect rect;
    //        rect.origin = [_mapViewBase.mapViewShare.mapView frame].origin;
    //        if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2)
    //        {
    //            rect.size.width = [_mapViewBase.mapViewShare.mapView frame].size.width*2;
    //            rect.size.height = [_mapViewBase.mapViewShare.mapView frame].size.height*2;
    //        }else {
    //            rect.size.width = [_mapViewBase.mapViewShare.mapView frame].size.width;
    //            rect.size.height = [_mapViewBase.mapViewShare.mapView frame].size.height;
    //        }
    rect.origin.x = 0;
    rect.origin.y = 0;
    rect.size.width = 600;
    rect.size.height = 1100;
    float level = [_mapViewBase.mapViewShare.mapView MatchingPointsInRegion:coors andCount:2 andRegion:rect andOutCenter:&center];
    //设置地图缩放级别和中心点
//    [_mapViewBase.mapViewShare.mapView setMapLevel:level];
//        [_mapViewBase.mapViewShare.mapView setCenter:center];
    
    NIMapStatus *ptemp = [[NIMapStatus alloc]init];
    ptemp.fLevel = level;
    ptemp.targetGeoPt = center;
    CGPoint target;
    target.x =(_mapViewBase.frame.size.width/2)*2;
    target.y = (_mapViewBase.frame.size.height/2)*2;
    
    ptemp.targetScreenPt=target;
    ptemp.fRotation = _mapViewBase.mapViewShare.mapView.mapStatus.fRotation;

    //动画移动到中心点
    [_mapViewBase.mapViewShare.mapView setMapStatus:ptemp withAnimation:NO];

    

}

//设置地图中心点
-(void)setMapCenter:(CLLocationCoordinate2D) centerPosition
{
    [_mapViewBase.mapViewShare.mapView setCenter:centerPosition];
}


#pragma mark- 添加大头针接口
//地图上添加单个大头针标注
- (void)addOneAnnotation:(MapPoiData*)coordData
{
    NSLog(@"开始addOneAnnotation");
    onePoint = [[NIPointAnnotation alloc]initWithMapView:_mapViewBase.mapViewShare.mapView];

    onePoint.title = coordData.mName;
    onePoint.subtitle = coordData.mAddress;
    onePoint.annotationID = coordData.mID;
    onePoint.coordinate = coordData.coordinate;
    
    [_mapViewBase.mapViewShare.mapView setCenter:coordData.coordinate];
    [_mapViewBase.mapViewShare.mapView addAnnotation:onePoint];
    NSLog(@"结束addOneAnnotation");
}
//地图上添加多个大头针标注
- (void)addAnnotations:(NSArray*)Annotations needMatchingPointsInRegion:(BOOL)flag
{
     [self releaseAnnotations];
    BOOL setLocation = NO;
    CLLocationCoordinate2D coors[2] = {0};
    NSInteger count = Annotations.count;
    pointAnnotationArray = [[NSMutableArray alloc] init];
    for (int index = 0; index < count; index++)
    {
        
        NSLog(@"%@",[Annotations objectAtIndex:index]);
        MapPoiData *data =  Annotations[index];
        
        //设置初始化位置
        if (!setLocation)
        {
            setLocation = YES;
            coors[0] = data.coordinate;
            coors[1] = data.coordinate;
        }
        else
        {
            if (data.coordinate.latitude < coors[0].latitude)
                coors[0].latitude = data.coordinate.latitude;
            
            if (data.coordinate.longitude < coors[0].longitude)
                coors[0].longitude = data.coordinate.longitude;
            
            if (data.coordinate.latitude>coors[1].latitude)
                coors[1].latitude = data.coordinate.latitude;
            
            if (data.coordinate.longitude>coors[1].longitude)
                coors[1].longitude = data.coordinate.longitude;
        }
        
        NIPointAnnotation *pointAnnotations = [[NIPointAnnotation alloc]initWithMapView:_mapViewBase.mapViewShare.mapView];

        pointAnnotations.title = data.mName;
        pointAnnotations.subtitle = data.mAddress;
        pointAnnotations.annotationID = data.mID;
        pointAnnotations.coordinate = data.coordinate;
        [pointAnnotationArray addObject:pointAnnotations];
        [_mapViewBase.mapViewShare.mapView addAnnotation:pointAnnotations];
        [pointAnnotations release];
    }
    
    float level =0.0;
    CLLocationCoordinate2D center;
    if (flag)
    {
        //合适的地图级别，和中心点。
        
        CGRect rect;
        rect.origin = [_mapViewBase frame].origin;
        if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2)
        {
            rect.size.width = [_mapViewBase frame].size.width*2;
            rect.size.height = [_mapViewBase frame].size.height*2;
        }else {
            rect.size.width = [_mapViewBase frame].size.width;
            rect.size.height = [_mapViewBase frame].size.height;
        }
        level = [_mapViewBase.mapViewShare.mapView MatchingPointsInRegion:coors andCount:2 andRegion:rect andOutCenter:&center];
    }
    else
    {
        level = _mapViewBase.mapViewShare.mapView.mapStatus.fLevel;
        center = _mapViewBase.mapViewShare.mapView.mapStatus.targetGeoPt;
    }
    

    //设置地图缩放级别和中心点
    [_mapViewBase.mapViewShare.mapView setMapLevel:level];
    [_mapViewBase.mapViewShare.mapView setCenter:center];
}

- (void) releaseAnnotations {
    NSLog(@"开始移除10个点");
    [self releasePaopao];
    if (pointAnnotationArray) {
        for (NIPointAnnotation *tempPoint in pointAnnotationArray) {
            [_mapViewBase.mapViewShare.mapView  removeAnnotation:tempPoint];
        }
        [pointAnnotationArray removeAllObjects];
        [pointAnnotationArray release];
        pointAnnotationArray = nil;
    }
    
    NSLog(@"结束移除10个点");
}
#pragma mark- 定位
-(void)startLocation
{
    [_locService startUserLocationService];
    
    
}
-(void)stopLocation
{
    [_locService stopUserLocationService];
    
}

-(void)test
{
    [_mapViewBase.mapViewShare.mapView setFrame:CGRectMake(0, 0,320,568)];
}

-(void)removeLineAndPoint
{
                NSLog(@"移除目前的线和点");
    if (polyline) {
        [_mapViewBase.mapViewShare.mapView removeOverlay:polyline];
        [polyline release];
        polyline = nil;
    }
    if (pointA) {
        [_mapViewBase.mapViewShare.mapView removeAnnotation:pointA];
        [pointA release];
        pointA = nil;
//        //add by wangcheng
//        [_point_A release];
//        _point_A = nil;
    }
    if (distanceA) {
        [_mapViewBase.mapViewShare.mapView removeAnnotation:distanceA];
        [distanceA release];
        distanceA =nil;
//        //add by wangcheng
//        [_distanceviewA release];
//        _distanceviewA = nil;
    }
    if (pointB) {
        [_mapViewBase.mapViewShare.mapView removeAnnotation:pointB];
        [pointB release];
        pointB = nil;
//        //add by wangcheng
//        [_point_B release];
//        _point_B = nil;
    }
    if (distanceB) {
        [_mapViewBase.mapViewShare.mapView removeAnnotation:distanceB];
        [distanceB release];
        distanceB = nil;
//        //add by wangcheng
//        [_distanceviewB release];
//        _distanceviewB = nil;
    }
}

//用户位置更新后，会调用此函数
- (void)didUpdateUserLocation:(NIUserLocation *)userLocation;
{
    CLLocationCoordinate2D newLocation = userLocation.location.coordinate;//取出gps获取的经纬度
    self.curManLocation = newLocation;
    BOOL result = NO;
    if (self.preManLocation.longitude ==0 && self.preManLocation.latitude ==0)
    {
        self.preManLocation = newLocation;
        [self removeLineAndPoint];
        [self drawOneLinestartPoint:self.carLocation endPoint:newLocation];
        
//        add mengyue
//        第一次返回定位信息不进行自适应
        
//        [self MatchingPointsInRegionStart:self.carLocation endPoint:newLocation];
        
//        end
        
        
        NSLog(@"----didUpdateUserLocation---preManLocation--------1");
    }
    else
    {
        result = [self diffentValuePre:self.preManLocation curValue:newLocation];
        
        if (result)
        {
            [self removeLineAndPoint];
            NSLog(@"移除目前的线和点完毕");
//            CLLocationCoordinate2D a;
//            a.latitude = pointB.coordinate.latitude+1.0;
//            a.longitude = pointB.coordinate.longitude+1.0;
//            pointB.coordinate = a;
//            pointB.title = @"qqqq";
//            NIPinAnnotationView* preView = (NIPinAnnotationView*)[pointB annotationView];
//            [_mapViewBase.mapViewShare.mapView updateAnnotationPositon:pointB];
//             [_mapViewBase.mapViewShare.mapView updateAnnotation:pointB withAnnotationView:preView];
        [self drawOneLinestartPoint:self.carLocation endPoint:newLocation];
//        [self MatchingPointsInRegionStart:self.carLocation endPoint:newLocation];
            NSLog(@"画线完毕");
            self.preManLocation = newLocation;
        }
        NSLog(@"----didUpdateUserLocation-----------2-------%d",result);

    }
//    NSLog(@"----didUpdateUserLocation-----------1");
//    if (_bStart == YES) {
//        [_mapViewBase.mapViewShare.mapView setCenter:newLocation];
//        _bStart = NO;
//    }
//    
//    if (_myPosAnnotation == nil)
//    {
//        _myPosAnnotation = [[NIPointAnnotation alloc]initWithMapView:_mapViewBase.mapViewShare.mapView];
//        _myPosAnnotation.coordinate = newLocation;
//        [self removeLineAndPoint];
//        [self drawOneLinestartPoint:self.carLocation endPoint:newLocation];
////       [_mapViewBase.mapViewShare.mapView addAnnotation:_myPosAnnotation];
//    }else{
//        //如果位置没发生变化就不重新画位置点了。
//        if (_myPosAnnotation.coordinate.longitude == newLocation.longitude &&
//            _myPosAnnotation.coordinate.latitude == newLocation.latitude) {
//            NSLog(@"----didUpdateUserLocation-----------2");
//            return;
//        }
//        _myPosAnnotation.coordinate = newLocation;
////        CLLocationCoordinate2D startPoint;
////        startPoint.latitude = 39.904687;
////        startPoint.longitude = 116.387174;
////        [self releaseOverlay];
//        
//        
//
////        [_mapViewBase.mapViewShare.mapView updateAnnotationPositon:_myPosAnnotation];
//    }
}

//比较2次更新的经纬度差值
-(BOOL)diffentValuePre:(CLLocationCoordinate2D)preValue curValue:(CLLocationCoordinate2D)curValue
{
    double diffLatValue = fabs(preValue.latitude - curValue.latitude);
    double diffLonValue = fabs(preValue.longitude - curValue.longitude);
    
    NSLog(@"diffLatValue:%f",diffLatValue);
    NSLog(@"diffLonValue:%f",diffLonValue);
    
    if (diffLatValue >0.0001 || diffLonValue>0.0001)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


//用户方向更新后，会调用此函数
-(void)didUpdateUserHeading:(NIUserLocation *)userLocation
{

}
//-(void)didUpdateUserHeading:(NIUserLocation *)userLocation{
//    NSLog(@"===%f======", userLocation.heading.trueHeading);
//    if ( userLocation.heading.headingAccuracy < 0.0 ) {
//        return;
//    }
//    
//    _dLocationDirection = userLocation.heading.trueHeading;
//    if (_myPosAnnotation == nil)
//    {
//        return;
//    }
//    
//    _myPosView.rotate =  int(_dLocationDirection + _mapViewBase.mapViewShare.mapView.mapStatus.fRotation)%360;
//    
//    [_mapViewBase.mapViewShare.mapView updateAnnotation:_myPosAnnotation withAnnotationView:_myPosView];
//}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
    NSLog(@"%@",error);
}

- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"erro = %d",error.code);
//    if (alertStart) {
//        [alertStart dismissWithClickedButtonIndex:0 animated:NO];
//        [alertStart release];
//        alertStart = nil;
//    }
//    
//    showLabel.text = nil;
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"没开定位，或定位错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//    [alert show];
    
}
#pragma mark- delegate


//根据overlay生成对应的View
- (NIOverlayView *)mapView:(NIMapView *)mapView viewForOverlay:(id <NIOverlay>)overlay
{
    if ([overlay isKindOfClass:[NICircle class]])
    {
        NICircleView* circleView = [[[NICircleView alloc] initWithOverlay:overlay] autorelease];
        circleView.fillColor = [[UIColor greenColor] colorWithAlphaComponent:0.5];
        circleView.lineWidth = 5.0;
        return circleView;
    }
    
    if ([overlay isKindOfClass:[NIPolyline class]])
    {
        NIPolylineView* polylineView = [[[NIPolylineView alloc] initWithOverlay:overlay] autorelease];
        polylineView.strokeColor = [UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0];
        polylineView.lineWidth = 3.0;
        
        return polylineView;
    }
    
    if ([overlay isKindOfClass:[NIPolygon class]])
    {
        NIPolygonView* polygonView = [[[NIPolygonView alloc] initWithOverlay:overlay] autorelease];
        polygonView.fillColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
        polygonView.lineWidth =2.0;
        return polygonView;
    }
   	return nil;
}
/**
 
 **/
- (NIAnnotationView *)mapView:(NIMapView *)mapView viewForAnnotation:(id <NIAnnotation>)annotation
{
    //距离文字view
    if ([annotation isKindOfClass:[DistanceAnnotation class]])
    {
        
        //if([annotation isEqual:distanceA])
        if (annotation.annotationID == 201)
        {
            NSString *AnnotationViewID = @"distanceA";
            
//            if (_distanceviewA == nil)
//            {
            NIAnnotationView * _distanceviewA = [[[NIAnnotationView alloc] initWithNIMapView:mapView reuseIdentifier:AnnotationViewID]autorelease];
                UILabel * label = [[UILabel alloc] init];
                UIFont *font = [UIFont systemFontOfSize:14.0f];
                [label setFont:font];
                CGSize size = [annotation.title sizeWithFont:font];
                [label setFrame:CGRectMake(0, 0, size.width, size.height)];
                label.text = [annotation title];
                label.backgroundColor = [UIColor clearColor];
                label.textAlignment = NSTextAlignmentCenter;
                label.textColor = [UIColor colorWithRed:170.0/255.0 green:89.0/255.0 blue:47.0/255.0 alpha:1];
                _distanceviewA.image=[self getImageFromView:label];
                [label release];
                _distanceviewA.priority = 11;
                _distanceviewA.enabled = NO; //设置不弹出气泡
                [_distanceviewA setAnchor:NIAnchorMake(1.0f, 0.0f)];
                NSLog(@"》》》》》》》》》》》》》A进去了》》》》》》》》》》");
//            }
            
            return _distanceviewA;
            
        }
        else if (annotation.annotationID == 202)//if([annotation isEqual:distanceB])
        {
            NSString *AnnotationViewID = @"distanceB";
            
//            if (_distanceviewB == nil) {
                NIAnnotationView *_distanceviewB = [[[NIAnnotationView alloc] initWithNIMapView:mapView reuseIdentifier:AnnotationViewID]autorelease];
                UILabel * label = [[UILabel alloc] init];
                UIFont *font = [UIFont systemFontOfSize:14.0f];
                [label setFont:font];
                CGSize size = [annotation.title sizeWithFont:font];
                [label setFrame:CGRectMake(0, 0, size.width, size.height)];
                label.text = [annotation title];
                label.textColor = [UIColor colorWithRed:170.0/255.0 green:89.0/255.0 blue:47.0/255.0 alpha:1];
                label.textAlignment = NSTextAlignmentCenter;
                label.backgroundColor = [UIColor clearColor];
                _distanceviewB.image=[self getImageFromView:label];
                [label release];
                _distanceviewB.priority = 11;
                _distanceviewB.enabled = NO; //设置不弹出气泡
                [_distanceviewB setAnchor:NIAnchorMake(0.0f, 0.0f)];
                NSLog(@"》》》》》》》》》》》》》B进去了》》》》》》》》》》");
//            }
            
            return _distanceviewB;
        }
        NSLog(@"A和B都没进去");
        
    }
    else if([annotation isEqual:pointA])
    {
        NSString *AnnotationViewID = @"pointA";
//        _point_A = [mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];

//        if (_point_A == nil) {
            NIAnnotationView* _point_A = [[[NIAnnotationView alloc] initWithNIMapView:mapView reuseIdentifier:AnnotationViewID]autorelease];
            
            _point_A.priority = 11;
            _point_A.image = [UIImage imageNamed:@"map_lpp_ic"];
//        }
        
        
        return _point_A;

    }
    else if([annotation isEqual:pointB])
    {
        NSString *AnnotationViewID = @"pointB";
//        _point_B = [mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
//        if (_point_B == nil) {
            NIAnnotationView* _point_B = [[[NIAnnotationView alloc] initWithNIMapView:mapView reuseIdentifier:AnnotationViewID]autorelease];
            _point_B.priority = 11;
            _point_B.image = [UIImage imageNamed:@"map_cdp_ic"];
//        }
       

        return _point_B;
        
    }
    else if([annotation isEqual:onePoint])
    {
        NSString *AnnotationViewID = @"onePoint";
//        _one_Point = [mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
//        if (_one_Point == nil) {
        
        NIPinAnnotationView * _one_Point = [[[NIPinAnnotationView alloc] initWithNIMapView:mapView reuseIdentifier:AnnotationViewID]autorelease];
        
            _one_Point.priority = 11;
            _one_Point.image = [UIImage imageNamed:[NSString stringWithFormat:@"map_position_ic"]];
//        }
        
        return _one_Point;

    }
    else if ([annotation isEqual:_myPosAnnotation])
    {
        NSString *AnnotationViewID = @"Location";
//        _myPosView = [mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
//        if (_myPosView == nil) {
            NILocationAnnotationView * posView = [[[NILocationAnnotationView alloc]initWithNIMapView:mapView reuseIdentifier:AnnotationViewID]autorelease];
            ((NILocationAnnotationView*)posView).LocationImage = @"common_icon_location.png";//如果不设置，会用默认的图片。
            posView.rotate = _dLocationDirection;
            posView.anchor = NIAnchorMake(0.5f,0.5f);
            
//        }
        return posView;
    }
    else if ([annotation isKindOfClass:[NIPointAnnotation class]] )
    {
        NSString *AnnotationViewID = @"pointMark";
//        _viewPoint = [mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
//        if (_viewPoint == nil) {
            NIPinAnnotationView *_viewPoint = [[[NIPinAnnotationView alloc] initWithNIMapView:mapView reuseIdentifier:AnnotationViewID]autorelease];
            _viewPoint.priority = 11;
            int pointID = annotation.annotationID;
            if (pointID == ID_POI_CUSTOM || pointID == ID_POI_URL) {
                _viewPoint.image = [UIImage imageNamed:[NSString stringWithFormat:@"map_position_ic"]];
            }
            else
            {
                _viewPoint.image = [UIImage imageNamed:[NSString stringWithFormat:@"map_result_map_ic_%d",pointID]];
            }
//        }
        
        

        return _viewPoint;
   }
    else if ([annotation isKindOfClass:[NIActionPaopaoAnnotation class]] ) {
        
        NSString *AnnotationViewID = @"paopaoMark";
//        if (viewPaopao == nil) {
        
            NIActionPaopaoView* viewPaopao = [[[NIActionPaopaoView alloc] initWithNIMapView:mapView reuseIdentifier:AnnotationViewID]autorelease];
            UIImage *imageNormal;
            
            if([App getVersion]<=IOS_VER_5)
            {
                imageNormal = [[UIImage imageNamed:@"icon_paopao_middle_left.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0,10,0,8)];
            }
            else
            {
                imageNormal = [[UIImage imageNamed:@"icon_paopao_middle_left.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0,10,0,8)resizingMode:UIImageResizingModeStretch];
            }
            NSLog(@"%f",imageNormal.size.height);
            UIImageView *leftBgd = [[UIImageView alloc]initWithImage:imageNormal];
            
            
            if([App getVersion]<=IOS_VER_5)
            {
                imageNormal = [[UIImage imageNamed:@"icon_paopao_middle_right.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0,8,0,10)];
            }
            else
            {
                imageNormal = [[UIImage imageNamed:@"icon_paopao_middle_right.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0,8,0,10)resizingMode:UIImageResizingModeStretch];
            }
            UIImageView *rightBgd = [[UIImageView alloc] initWithImage:imageNormal];
            
            NSString* textlable = annotation.subtitle;
            NSString *titleTextlable =annotation.title;

            NSInteger textCount =textlable.length;
            CGFloat width = 0;
            if (textCount > 15)
            {
                width = 15*15;//(textlable.length)*15;
            }
            else
            {
                width =(textlable.length)*15;
            }
            
            if (textlable.length < titleTextlable.length)
            {
                 width =(titleTextlable.length)*17;
                
            }
            
            UIView *viewForImage = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width,imageNormal.size.height)];
            leftBgd.frame = CGRectMake(0, 0, width/2,imageNormal.size.height);
            rightBgd.frame = CGRectMake(width/2, 0, width/2,imageNormal.size.height);
            [viewForImage addSubview:leftBgd];
            [viewForImage sendSubviewToBack:leftBgd];
            [viewForImage addSubview:rightBgd];
            [viewForImage sendSubviewToBack:rightBgd];
            [leftBgd release];
            [rightBgd release];
            UILabel *title;
            if (textCount > 15)
            {
                title =[[UILabel alloc]initWithFrame:CGRectMake(15,0,width-20,imageNormal.size.height/2)];
            } else {
                title =[[UILabel alloc]initWithFrame:CGRectMake(0,0,width,imageNormal.size.height/2)];
            }
            
            title.textColor = [UIColor blackColor];
            title.backgroundColor=[UIColor clearColor];
            title.font = [UIFont systemFontOfSize:15.0];
            title.text=annotation.title;
            title.textAlignment = NSTextAlignmentCenter;
            [viewForImage addSubview:title];
            [title release];
            
            UILabel *label;
            if (textCount > 15)
            {
                label=[[UILabel alloc]initWithFrame:CGRectMake(15,imageNormal.size.height/2-10,width-20,imageNormal.size.height/2)];
            } else {
                label=[[UILabel alloc]initWithFrame:CGRectMake(0,imageNormal.size.height/2-10,width,imageNormal.size.height/2)];
            }
            
            if (textlable.length < titleTextlable.length)
            {
                label.text= @"";
            }
            else
            {
                label.text=annotation.subtitle;
            }
            
            label.font = [UIFont systemFontOfSize:13.0];
            label.textColor = [UIColor blackColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.backgroundColor=[UIColor clearColor];
            label.lineBreakMode = NSLineBreakByTruncatingTail;
            [viewForImage addSubview:label];
            [label release];
            
            //其中30是气泡的偏移量，上为正，下为负
            if (annotation.annotationID == ID_POI_CUSTOM ||annotation.annotationID == ID_POI_URL)
            {
                [viewPaopao setAnchor:NIAnchorMake(0.5f,1.6)];
            } else {
                [viewPaopao setAnchor:NIAnchorMake(0.5f,(54.0f+45.0f)/54.0f)];
            }
            
            viewPaopao.priority = 20;
            viewPaopao.image = [self getImageFromView:viewForImage];
            [viewForImage release];
            NSLog(@"%f",viewPaopao.image.size.height);
//        }
        
        return viewPaopao;
        
    }

    
    return nil;
}

- (void)mapStatusDidChanged:(NIMapView *)mapView{
    if (_myPosAnnotation != nil && _myPosView != nil) {
        _myPosView.rotate =  int(_dLocationDirection + mapView.mapStatus.fRotation)%360;
        
        NSLog(@"%d++++",int(_dLocationDirection+ mapView.mapStatus.fRotation)%360);
        
        
        // [_mapViewBase updateAnnotationPositon:_myPosAnnotation];
        [_mapViewBase.mapViewShare.mapView updateAnnotation:_myPosAnnotation withAnnotationView:_myPosView];
        
    }
}

//- (UIImage *)getImageFromView:(UIView *)view
//{
//    UIGraphicsBeginImageContext(view.bounds.size);
//    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return image;
//}
-(UIImage *)getImageFromView:(UIView *)view{
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2)
        UIGraphicsBeginImageContextWithOptions(view.bounds.size,NO,2);
    else
        UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//移除长按大头针
-(void)removeLongclickPoint{
    if (pointAnnotation != nil)
    {
        [_mapViewBase.mapViewShare.mapView removeAnnotation:pointAnnotation];
        [pointAnnotation release];
        pointAnnotation=nil;
        //add by wangcheng
//        [_viewPoint release];
//        _viewPoint = nil;
    }
}

//移除气泡
-(void)releasePaopao{
    if (ppAnnotation != nil)
    {
        [_mapViewBase.mapViewShare.mapView removeAnnotation:ppAnnotation];
        [ppAnnotation release];
        ppAnnotation=nil;
//        //add by wangcheng
//        [viewPaopao release];
//        viewPaopao = nil;
    }
}
//移除自定义大头针
-(void)removeOnePoint
{
    if (onePoint != nil)
    {
        [_mapViewBase.mapViewShare.mapView removeAnnotation:onePoint];
        [onePoint release];
        onePoint=nil;
//        //add by wangcheng
//        [_one_Point release];
//        _one_Point = nil;
    }

}

//获取地址信息
-(void)LaunchSearcher:(CLLocationCoordinate2D)coordinate{
    //调用逆地理编码接口，获取当前位置的逆地理编码
    NIReverseGeoCodeOption *reverseGeoCodeSearchOption = [[NIReverseGeoCodeOption alloc] init];
    reverseGeoCodeSearchOption.reverseGeoPoint = coordinate;
    [_searcher reverseGeoCode:reverseGeoCodeSearchOption];
    [reverseGeoCodeSearchOption release];
}
//弹出泡泡
-(void)showBubble:(MapPoiData *)bubbleInfo
{
    if (ppAnnotation == nil)
    {
        ppAnnotation = [[NIActionPaopaoAnnotation alloc]initWithMapView:_mapViewBase.mapViewShare.mapView];
    }
    
    ppAnnotation.annotationID = bubbleInfo.mID;
    ppAnnotation.title = bubbleInfo.mName;
    ppAnnotation.subtitle = bubbleInfo.mAddress;
    ppAnnotation.coordinate = bubbleInfo.coordinate;
    
    [_mapViewBase.mapViewShare.mapView addAnnotation:ppAnnotation];
}

// 当点击annotation view时，调用此接口
- (void)mapView:(NIMapView *)mapView onClickedAnnotation:(id <NIAnnotation>)annotation
{
    
    Resources *oRes = [Resources getInstance];
    App *app = [App getInstance];
//    update by mengyue
//    除车辆位置和手机位置以及需要你地理界面的自定义位置外，点击相同点不重复弹出泡泡
    BOOL needPopAgain = YES;
    
    if ([_mapViewBase.POIData objectForKey:BUBBLE_INFO_KEY]) {
        MapPoiData* tempPOIData = [_mapViewBase.POIData objectForKey:BUBBLE_INFO_KEY];
        if (tempPOIData.mID != annotation.annotationID ||[annotation isEqual:pointA]||[annotation isEqual:pointB]) {
            needPopAgain = YES;
        }
        else if (_requestReverseGeoFlag && annotation.annotationID==ID_POI_CUSTOM)
        {
            needPopAgain = YES;
        }
        else
        {
            needPopAgain = NO;
        }
    }
    else
    {
        needPopAgain = YES;
    }
    
    if (needPopAgain) {
        //先隐藏已有气泡
        [self releasePaopao];
        
        if (ppAnnotation == nil)
        {
            ppAnnotation = [[NIActionPaopaoAnnotation alloc]initWithMapView:_mapViewBase.mapViewShare.mapView];
        }
        
        if ([annotation isEqual:pointA])
        {
            ppAnnotation.title = [NSString stringWithFormat:@"%@(%@)",[oRes getText:@"friend.FriendDetailViewController.selfLocationTitle"],app.mCarData.mCarNumber];
            ppAnnotation.annotationID = annotation.annotationID;
        }
        else if([annotation isEqual:pointB])
        {
            ppAnnotation.title = @"当前位置";
            ppAnnotation.annotationID = annotation.annotationID;
        }
        else
        {
            
            if (annotation.title == nil|| [annotation.title isEqualToString:@""] )
            {
                ppAnnotation.title = @"自定义位置";
            }
            else
            {
                ppAnnotation.title = annotation.title;
            }
            
            ppAnnotation.annotationID = annotation.annotationID;
        }
        
        //    NIMapStatus *ptemp = [[NIMapStatus alloc]init];
        //    ptemp.fLevel = _mapViewBase.mapViewShare.mapView.mapStatus.fLevel;
        //    ptemp.targetGeoPt = [annotation coordinate];
        //    ptemp.fRotation = _mapViewBase.mapViewShare.mapView.mapStatus.fRotation;
        //    //动画移动到中心点
        //    [_mapViewBase.mapViewShare.mapView setMapStatus:ptemp withAnimation:YES];
        //    [ptemp release];
        
        //    mengyue
        [_mapViewBase.mapViewShare.mapView setCenter:[annotation coordinate]];
        //    end
        
        //是否需要单击大头针进行你地理信息请求
        if (_requestReverseGeoFlag)
        {
            if (annotation.annotationID == ID_POI_URL)
            {
                
                ppAnnotation.title = annotation.title;
                ppAnnotation.subtitle =annotation.subtitle;
                ppAnnotation.coordinate = [annotation coordinate];
                ppAnnotation.annotationID = annotation.annotationID;
                [_mapViewBase.mapViewShare.mapView addAnnotation:ppAnnotation];
            }
            else
            {
                
                [self LaunchSearcher:[annotation coordinate]];
            }
            
        }
        else
        {
            ppAnnotation.title = annotation.title;
            ppAnnotation.subtitle =annotation.subtitle;
            ppAnnotation.coordinate = [annotation coordinate];
            [_mapViewBase.mapViewShare.mapView addAnnotation:ppAnnotation];
        }
        
        
        //data
        if ([_mapViewBase.POIData objectForKey:BUBBLE_INFO_KEY])
        {
            [_mapViewBase.POIData removeObjectForKey:BUBBLE_INFO_KEY];
        }
        
        MapPoiData* tempData = [[MapPoiData alloc]init];
        tempData.mID = annotation.annotationID;
        tempData.coordinate = [annotation coordinate];
        tempData.mName = annotation.title;
        tempData.mAddress = annotation.subtitle;
        
        [_mapViewBase.POIData setObject:tempData forKey:BUBBLE_INFO_KEY];
        [tempData release];
    }
    else
    {
        
        [_mapViewBase.mapViewShare.mapView setCenter:[annotation coordinate]];
    }
    
    
    

}

// 当点击气泡view时，调用此接口
- (void)mapView:(NIMapView *)mapView onClickedAnnotationForBubble:(NSInteger)index;
{
    NSLog(@"buble click %d.", index);
    
    
}

// 当点击地图空白处时，调用此接口
- (void)mapView:(NIMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate{
    if ([_mapViewBase.POIData objectForKey:BUBBLE_INFO_KEY])
    {
        [_mapViewBase.POIData removeObjectForKey:BUBBLE_INFO_KEY];
    }
    [self releasePaopao];
}

// 长按地图时会回调此接口
- (void)mapView:(NIMapView *)mapView onLongClick:(CLLocationCoordinate2D)coordinate{
    NSLog(@"长按%f,%f",coordinate.latitude,coordinate.longitude);
    if (_LongPressure)
    {
        //先隐藏已有气泡
        if ([_mapViewBase.POIData objectForKey:BUBBLE_INFO_KEY])
        {
            [_mapViewBase.POIData removeObjectForKey:BUBBLE_INFO_KEY];
        }
        [self releasePaopao];
        [self removeLongclickPoint];
        [self removeOnePoint];
        //data
        if ([_mapViewBase.POIData objectForKey:ID_POI_CUSTOM_KEY])
        {
            [_mapViewBase.POIData removeObjectForKey:ID_POI_CUSTOM_KEY];
        }
        
        if ([_mapViewBase.POIData objectForKey:ID_POI_URL_KEY])
        {
            [_mapViewBase.POIData removeObjectForKey:ID_POI_URL_KEY];
        }
        
        MapPoiData* tempData = [[MapPoiData alloc]init];
        tempData.mID = ID_POI_CUSTOM;
        tempData.coordinate = coordinate;
        
        [_mapViewBase.POIData setObject:tempData forKey:ID_POI_CUSTOM_KEY];
        NSLog(@"%@",_mapViewBase.POIData);
        if (pointAnnotation == nil) {
            pointAnnotation = [[NIPointAnnotation alloc]initWithMapView:_mapViewBase.mapViewShare.mapView];
            pointAnnotation.coordinate = coordinate;
            pointAnnotation.annotationID = ID_POI_CUSTOM;
            [_mapViewBase.mapViewShare.mapView addAnnotation:pointAnnotation];
            
        }
    }

}

// 逆地理编码的Delegate
- (void)onGetReverseGeoCodeResult:(NIGeoCodeSearch *)searcher result:(NIReverseGeoCodeResult *)result  errorCode:(int)error {
    //显示气泡
    //0表示逆地理没有错误
        if (error == 0)
        {
            ppAnnotation.coordinate = result.location;
            NSLog(@"%f %f", ppAnnotation.coordinate.latitude, ppAnnotation.coordinate.longitude);
            
            NSMutableString *address = [[NSMutableString alloc]initWithCapacity:0];
            if (!([result.adminregion.provname isEqualToString:@""] || result.adminregion.provname == nil))
            {
                [address appendString:result.adminregion.provname];
            }
            
            if (!([result.adminregion.provname isEqualToString:result.adminregion.cityname] || result.adminregion.provname == nil || result.adminregion.cityname == nil))
            {
                [address appendString:result.adminregion.cityname];
            }
            
            if (!([result.adminregion.distname isEqualToString:@""] || result.adminregion.distname == nil))
            {
                [address appendString:result.adminregion.distname];
            }
            
            
            
            if (!([result.address isEqualToString:@""] || result.address == nil))
            {
                [address appendString:result.address];
            }
            
            
            if (result.shortdescription == nil||[result.shortdescription isEqualToString:@""]  )
            {
                [address appendString:result.shortdescription];
            }
            
            
            
            ppAnnotation.subtitle = [NSString stringWithString:address];
            
            
            //data
            if ([_mapViewBase.POIData objectForKey:BUBBLE_INFO_KEY])
            {
                [_mapViewBase.POIData removeObjectForKey:BUBBLE_INFO_KEY];
            }
            
            MapPoiData* tempData = [[MapPoiData alloc]init];
            tempData.mID = ppAnnotation.annotationID;
            tempData.coordinate = ppAnnotation.coordinate;
            tempData.mName = ppAnnotation.title;
            tempData.mAddress = ppAnnotation.subtitle;
            
            [_mapViewBase.POIData setObject:tempData forKey:BUBBLE_INFO_KEY];
            
            [_mapViewBase.mapViewShare.mapView addAnnotation:ppAnnotation];
            
            
        }
        else
        {
            ppAnnotation.coordinate = result.location;
            ppAnnotation.subtitle = @"";
            
            
            //data
            if ([_mapViewBase.POIData objectForKey:BUBBLE_INFO_KEY])
            {
                [_mapViewBase.POIData removeObjectForKey:BUBBLE_INFO_KEY];
            }
            
            MapPoiData* tempData = [[MapPoiData alloc]init];
            tempData.mID = ppAnnotation.annotationID;
            tempData.coordinate = ppAnnotation.coordinate;
            tempData.mName = ppAnnotation.title;
            tempData.mAddress = ppAnnotation.subtitle;
            
            [_mapViewBase.POIData setObject:tempData forKey:BUBBLE_INFO_KEY];
            [_mapViewBase.mapViewShare.mapView addAnnotation:ppAnnotation];

        }
    
    
}

-(void)releaseOverlay{
    if (circle) {
        [_mapViewBase.mapViewShare.mapView removeOverlay:circle];
        [circle release];
        circle = nil;
    }
    if (polygon) {
        [_mapViewBase.mapViewShare.mapView removeOverlay:polygon];
        [polygon release];
        polygon = nil;
    }
    if (polyline) {
        [_mapViewBase.mapViewShare.mapView removeOverlay:polyline];
        [polyline release];
        polyline = nil;
    }
    if (pointA) {
        [_mapViewBase.mapViewShare.mapView removeAnnotation:pointA];
        [pointA release];
        pointA = nil;
        //add by wangcheng
//        [_point_A release];
//        _point_A = nil;
    }
    if (distanceA) {
        [_mapViewBase.mapViewShare.mapView removeAnnotation:distanceA];
        [distanceA release];
        distanceA =nil;
//        //add by wangcheng
//        [_distanceviewA release];
//        _distanceviewA = nil;
    }
    if (pointB) {
        [_mapViewBase.mapViewShare.mapView removeAnnotation:pointB];
        [pointB release];
        pointB = nil;
//        //add by wangcheng
//        [_point_B release];
//        _point_B = nil;
    }
    if (distanceB) {
        [_mapViewBase.mapViewShare.mapView removeAnnotation:distanceB];
        [distanceB release];
        distanceB = nil;
        //add by wangcheng
//        [_distanceviewB release];
//        _distanceviewB = nil;
    }
    if (pointAnnotation) {
        [_mapViewBase.mapViewShare.mapView removeAnnotation:pointAnnotation];
        [pointAnnotation release];
        pointAnnotation =nil;
//        //add by wangcheng
//        [_viewPoint release];
//        _viewPoint = nil;
    }
    if (ppAnnotation) {
        [_mapViewBase.mapViewShare.mapView removeAnnotation:ppAnnotation];
        [ppAnnotation release];
        ppAnnotation =nil;
        //add by wangcheng
//        [viewPaopao release];
//        viewPaopao = nil;
    }

    if (onePoint) {
        [_mapViewBase.mapViewShare.mapView removeAnnotation:onePoint];
        [onePoint release];
        onePoint =nil;
//        //add by wangcheng
//        [_one_Point release];
//        _one_Point = nil;
    }

    


    
}




#pragma mark-系统函数
-(void)viewWillAppear:(BOOL)animated
{
    
    [_mapViewBase viewWillAppear];
    
    _mapViewBase.mapViewShare.mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放

//    [_mapViewBase.mapViewShare.mapView setFrame:CGRectMake(0, 0,320,568)];
    //地理信息
    _searcher = [[NIGeoCodeSearch alloc] init];
     _searcher.delegate = self;
    if (_requestLocationFlag)
    {
        if (!_locService)
        {
            _locService = [[NILocationService alloc]init];
            
            
        }
        _locService.delegate = self;
//        [_locService viewWillAppear:YES];
        
    }

    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
//    [_locService viewWillDisappear];
    _locService.delegate = nil;
//    [_locService release];
//    _locService = nil;

    
    [self releaseOverlay];
    if (_myPosAnnotation) {
        [_mapViewBase.mapViewShare.mapView removeAnnotation:_myPosAnnotation];
        [_myPosAnnotation release];
        _myPosAnnotation =nil;
    }
    if (_myPosView) {
        [_myPosView release];
        _myPosView =nil;
    }
    _mapViewBase.mapViewShare.mapView.delegate = nil; // 不用时，置nil
    _searcher.delegate = nil;
    [_searcher release];
    _searcher = nil;
    [_mapViewBase viewWillDisappear];
    
    self.preManLocation = CLLocationCoordinate2DMake(0, 0);
    

    
    [super viewWillDisappear:animated];
}

//- (void)viewDidUnload {
//    [_mapViewBase release];
//    _mapViewBase = nil;
//    [super viewDidUnload];
//    // Release any retained subviews of the main view.
//    // e.g. self.myOutlet = nil;
//}
#pragma mark-MemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
