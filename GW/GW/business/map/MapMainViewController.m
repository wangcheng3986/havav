
/*!
 @header MapMainViewController.m
 @abstract 地图主界面类
 @author mengy
 @version 1.00 13-4-24 Creation
 */
#import <UIKit/UIKit.h>
#import "MapMainViewController.h"
#import "App.h"
#import "SearchViewController.h"
#import "MapTabBarViewController.h"
#import "POIDetailViewController.h"

#define SCREEN_HIGHT [UIScreen mainScreen].applicationFrame.size.height
#define DURATION_TIME 0.3
#define SHOW_DELAY_TIME 0
@interface MapMainViewController ()
{
    MapPoiData *currentPoi;
    MapPoiData *carPoi;
    int currentPoiCount;
    int carPoiCount;
    int loginType;
    CLLocationCoordinate2D carCoord;
    CLLocationCoordinate2D curCoord;
    BOOL firstShow;
    UIBarButtonItem *leftButton;
    
    CLLocationCoordinate2D routeStartPoint;
    CLLocationCoordinate2D routeEndPoint;
    
    BOOL firstFlag;
    int circumSearchCentralType;
    
    NINaviManager* _naviManager;
    
    BOOL routeFlag;
    
    //线段端点a  自车位置
    NIPointAnnotation* pointA;

    //长按大头针
    NIPointAnnotation* pointAnnotation;

    //定位功能
    NILocationService* _locService;
    
    NILocationAnnotationView * _myPosView;        //绘制点view
    NIPointAnnotation * _myPosAnnotation;          //绘制点
    double _dLocationDirection;                      //罗盘方向
    
    //地理编码／逆地理编码
    NIGeoCodeSearch *_searchGeo;
    //是否回调到逆地理回调函数中的标识位
    BOOL GeoFailureflag;
    
}
@end

@implementation MapMainViewController
@synthesize rootController;
@synthesize mapZoom;
@synthesize centralLat;
@synthesize centralLon;
@synthesize isFromSearch;
SearchViewController *searchViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)dealloc
{
    if (currentPoi) {
        [currentPoi release];
        currentPoi=nil;
    }
    if (carPoi) {
        [carPoi release];
        carPoi=nil;
    }
    
    if (mGetLastTrcak) {
        mGetLastTrcak.mDelegate = nil;
        [mGetLastTrcak release];
        mGetLastTrcak = nil;
    }
    if (searchButton) {
        [searchButton removeFromSuperview];
        [searchButton release];
    }
    if (titleLabel) {
        [titleLabel removeFromSuperview];
        [titleLabel release];
    }
    if (compassImageView) {
        [compassImageView removeFromSuperview];
        [compassImageView release];
    }
    
    if (self.progressHUD){
        [self.progressHUD removeFromSuperview];
        [self.progressHUD release];
        self.progressHUD = nil;
    }
    
    
    if (mDisView) {
        [mDisView removeFromSuperview];
        [mDisView release];
        mDisView = nil;
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [leftButton release];
    
    if([_mapView.POIData objectForKey:ID_POI_URL_KEY])
    {
        [_mapView.POIData removeObjectForKey:ID_POI_URL_KEY];
    }
     [_naviManager clearRoute];
    [_naviManager release];
    _naviManager = nil;
    

    [routeView release];
    [paopaoVIew release];
    [routeBtn release];
    [disNum release];
    [paopaoInfoTitle release];
    [paopaoInfoSubTitle release];
    [paopaoInfoText release];
    [super dealloc];
    
    
}


/*!
 @method viewDidLoad
 @abstract 加载地图，界面，初始化数据
 @discussion 加载地图，界面，初始化数据
 @param 无
 @result 无
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    Resources *oRes = [Resources getInstance];
    isFromSearch = false;
    App *app = [App getInstance];
    mUserData=[app getUserData];
    mCarData=[app getCarData];
    mGetLastTrcak = [[NIGetLastTrack alloc]init];
    loginType=mUserData.mType;
    currentPoiCount=1;
    firstShow=YES;
    circumSearchCentralType = CIRCUM_SEARCH_CENTRAL_TYPE_CUR;
    if([App getVersion]>=IOS_VER_7){
        [App ios7ViewLocation:self];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_ios7_navBar_bg"] forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_ios6_navBar_bg"] forBarMetrics:UIBarMetricsDefault];
    }

    [self.view addSubview:mDisView];
    mDisView.hidden = YES;
    //当进入视图时，重新设置imageView
    [self.imageView setImage:nil];
    [self.imageView setFrame:CGRectMake(160, 200, 0, 0)];
    //显示加载等待框
    self.progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.progressHUD];
    [self.view bringSubviewToFront:self.progressHUD];
    self.progressHUD.delegate = self;

    [self.progressHUD hide:YES];
    
    [self loadMapView];
    
    paopaoInfoText.text = [oRes getText:@"Map.paopaoInfo.detailText"];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goDetail:)];
    tap.numberOfTapsRequired = 1;
    [paopaoVIew addGestureRecognizer:tap];
    
}

-(void)goDetail:(UIGestureRecognizer *)tap
{
    NSMutableDictionary *mapDataDic =  _mapView.POIData;
    MapPoiData *poiData = [mapDataDic objectForKey:BUBBLE_INFO_KEY];
    if (poiData.mID == ID_POI_CUR) {
        [rootController showCustomPOI:poiData type:POI_TYPE_PHONE];
    }
    else if (poiData.mID == ID_POI_CAR)
    {
        [rootController showCustomPOI:poiData type:POI_TYPE_CAR];
    }
    else if(poiData.mID == ID_POI_URL)
    {
        [rootController showCustomPOI:poiData type:POI_TYPE_URL];
        
    }
    else
    {
        [rootController showCustomPOI:poiData type:POI_TYPE_CUSTOM];
        
    }
}


/*!
 @method loadMapView
 @abstract 加载地图界面
 @discussion 加载地图界面
 @param 无
 @result 无
 */
-(void)loadMapView
{
    [self setMapView:_mapView];
    self.requestLocationFlag = YES;
    self.bStart =YES;
    [self loadMapBaseParameter];
     _naviManager = [[NINaviManager alloc]initWithMapView:_mapView.mapViewShare.mapView];
    NINaviPara* para = [[NINaviPara alloc]init];
    para.planType = NAVIPLANTYPE_SHORTESTDISTANCE;
    para.bAvoidTollRoad = YES;
    para.bAvoidTrafficLights = YES;
    _naviManager.naviPara = para;
    //此处设置起终点图标
    _naviManager.startImgName = @"map_start_icon";
//    _naviManager.endImgName = @"icon_nav_end";
 //   _naviManager.passByImgName = @"icon_nav_waypoint";
    //此处设置是否显示起终点图标
    [_naviManager setShowIco:YES];
    
    [_mapView initDataDic];
}

/*!
 @method viewWillAppear:(BOOL)animated
 @abstract 设置导航栏按钮，开启gps，或将地图移到某城市
 @discussion 加载地图界面
 @param 无
 @result 无
 */
- (void)viewWillAppear:(BOOL)animated
{
   
    
    self.tabBarController.navigationItem.rightBarButtonItems=nil;
    self.tabBarController.navigationItem.titleView=searchButton;
    searchButton.exclusiveTouch = YES;
    _naviManager.delegate = self;
    
    //地理信息
    _searchGeo = [[NIGeoCodeSearch alloc] init];
    _searchGeo.delegate = self;
    //>>>>>>>>>new map>>>>>>>by wangqiwei
    [super viewWillAppear:animated];
    
    //    设置车辆和手机位置
    if (firstShow) {
        
        if ([rootController.urlDic objectForKey:@"lon"] && [rootController.urlDic objectForKey:@"lat"] &&[rootController.urlDic objectForKey:@"title"] &&[rootController.urlDic objectForKey:@"address"])
        {
            [self setCarAndCurLocWithNeedAdapt:NO];
            
            [self setUrlPOI];
        }
        else
        {
            [self setCarAndCurLocWithNeedAdapt:YES];
        }
        
    }
    else
    {
        [self setCarAndCurLocWithNeedAdapt:NO];
        if([_mapView.POIData objectForKey:ID_POI_URL_KEY])
        {
            MapPoiData *urlPOI = [_mapView.POIData objectForKey:ID_POI_URL_KEY];
            [self addOneAnnotation:urlPOI];
        }
        if([_mapView.POIData objectForKey:ID_POI_CUSTOM_KEY])
        {
            MapPoiData *customPOI = [_mapView.POIData objectForKey:ID_POI_CUSTOM_KEY];
            [self addOneAnnotation:customPOI];
        }
        
        
        if ([_mapView.POIData objectForKey:MAP_STATUS_KEY]) {
            [self setMapStatus:[_mapView.POIData objectForKey:MAP_STATUS_KEY]];
        }

    }
    //设置指南针消失
    [_mapView.mapViewShare.mapView setShowDirection:NO image:nil];
    NSLog(@"%f%f",_mapView.frame.size.width, _mapView.frame.size.height);
    [_mapView.mapViewShare.mapView setScalePoint:CGPointMake(45.0, 37.0)];
//    //仅第一次不调用
//    if (firstFlag)
//    {
//        [self startLocation];
//        
//    }
    
    
    //单例模式下，每次添加新图层前，需要先完成viewWillAppear操作
    if (isFromSearch) {
        NIMapStatus *status = [[NIMapStatus alloc]init];
        status.fLevel = mapZoom;
        status.targetGeoPt = CLLocationCoordinate2DMake(centralLat, centralLon);
        CGPoint target;
        target.x =(_mapView.frame.size.width/2)*2;
        target.y = (_mapView.frame.size.height/2)*2;
        status.targetScreenPt = target;
        [self setMapStatus:status];
        isFromSearch = false;
        [status release];
    }
    
    
    firstShow=NO;
    
    
    if (GeoFailureflag)
    {
        MapPoiData* tempData = [_mapViewBase.POIData objectForKey:BUBBLE_INFO_KEY];
        [self LaunchSearcher:tempData.coordinate];
        
    }
    
}

- (void)mapLoadFinish:(NIMapView *)mapView
{
    [self startLocation];
//    firstFlag = YES;
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

/*!
 @method viewWillDisappear:(BOOL)animated
 @abstract 停止gps，更新手机位置
 @discussion 停止gps，更新手机位置
 @param 无
 @result 无
 */
- (void)viewWillDisappear:(BOOL)animated
{
    _searchGeo.delegate = nil;
    [_searchGeo release];
    _searchGeo = nil;
    
    curCoord = self.curManLocation;
    _naviManager.delegate = nil;
    if (curCoord.latitude > 0.0 || curCoord.longitude > 0.0) {
        App *app = [App getInstance];
        [app updateLocation:[NSString stringWithFormat:@"%f",curCoord.longitude] lat:[NSString stringWithFormat:@"%f",curCoord.latitude]];
    }
    if (circumSearchCentralType == CIRCUM_SEARCH_CENTRAL_TYPE_CUR) {
        
        rootController.circumSearchCentralCoord = curCoord;
    }
    else
    {
        
        rootController.circumSearchCentralCoord = carCoord;
    }
    
    //标识算路是否开启
    if (routeFlag)
    {
        if (paopaoVIew.frame.origin.y < SCREEN_HIGHT-93)
        {
            [self cancelRouteForHideInfoView];
        }
        else
        {
            [self setInfoView:NO];
        }
        [_naviManager clearRoute];
        routeFlag = NO;
        routeBtn.selected = NO;
    }

    
    [self stopLocation];
    
    [self saveMapStatus];
    //移除地图图层上的长按自定义大头针
    if (pointAnnotation)
    {
        [_mapViewBase.mapViewShare.mapView removeAnnotation:pointAnnotation];
        [pointAnnotation release];
        pointAnnotation =nil;
    
    }
    //移除地图图层上的车辆位置大头针
    [self removeCarLoc];
    //移除地图图层上的手机位置大头针
    [self removeLoc];

    [super viewWillDisappear:animated];

}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}


/*!
 @method saveMapStatus
 @abstract 存储地图状态
 @discussion 存储地图状态
 @result 无
 */

-(void)saveMapStatus
{
    NIMapStatus *temp = [self getMapStatus];
    NIMapStatus *status = [[NIMapStatus alloc]init];
    status.fLevel = temp.fLevel;
    status.fRotation = temp.fRotation;
    CGPoint target;
    target.x =(_mapView.frame.size.width/2)*2;
    target.y = (_mapView.frame.size.height/2)*2;
    status.targetScreenPt=target;
    status.targetGeoPt = temp.targetGeoPt;
    [_mapView.POIData setObject:status forKey:MAP_STATUS_KEY];
    [status release];
}



/*!
 @method getMapCenterCoord
 @abstract 获取地图主界面中心坐标
 @discussion 获取地图主界面中心坐标
 @param 无
 @result centerCoor 中心坐标
 */
-(CLLocationCoordinate2D)getMapCenterCoord
{
    NIMapStatus *status = [self getMapStatus];
    CLLocationCoordinate2D centerCoor = status.targetGeoPt;
    return centerCoor;
}


/*!
 @method goBack
 @abstract 返回上一界面
 @discussion 返回上一界面
 @param 无
 @result 无
 */
- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

/*!
 @method search：
 @abstract 点击导航栏上方的搜索按钮，触发事件
 @discussion 点击导航栏上方的搜索按钮，触发事件
 @param 无
 @result 无
 */
-(IBAction)search:(id)sender
{
    [rootController onclickSearch];
}

/*!
 @method setUrlPOI
 @abstract 点击短信分享链接打开地图描点
 @discussion 点击短信分享链接打开地图描点
 @param 无
 @result 无
 */
-(void)setUrlPOI
{
    if ([rootController.urlDic objectForKey:@"lon"] && [rootController.urlDic objectForKey:@"lat"] &&[rootController.urlDic objectForKey:@"title"] &&[rootController.urlDic objectForKey:@"address"]) {
        
        MapPoiData *urlPoi = [[MapPoiData alloc]initWithID:ID_POI_URL];
        urlPoi.coordinate = CLLocationCoordinate2DMake([[rootController.urlDic objectForKey:@"lat"] doubleValue], [[rootController.urlDic objectForKey:@"lon"] doubleValue]);
        urlPoi.mName = [rootController.urlDic objectForKey:@"title"];
        urlPoi.mAddress = [rootController.urlDic objectForKey:@"address"];
        urlPoi.mImageName = @"map_position_ic";
        [self addOneAnnotation:urlPoi];
        NIMapStatus *temp = [self getMapStatus];
        NIMapStatus *status = [[NIMapStatus alloc]init];
        status.fLevel = MAP_DEFAULT_ZOOM;
        status.fRotation = temp.fRotation;
        CGPoint target;
        target.x =(_mapView.frame.size.width/2)*2;
        target.y = (_mapView.frame.size.height/2)*2;
        status.targetScreenPt=target;
        status.targetGeoPt = urlPoi.coordinate;
        [self setMapStatus:status];
        [status release];
        [_mapView.POIData setObject:urlPoi forKey:ID_POI_URL_KEY];
        [urlPoi release];
    }
    
}


/*!
 @method setCarAndCurLocWithNeedAdapt:(BOOL)status
 @abstract 向地图上描点
 @discussion 向地图上描点，包括车机位置和手机位置，并设置是否需要将点适应到一个屏幕内
 @param 无
 @result 无
 */
-(void)setCarAndCurLocWithNeedAdapt:(BOOL)status
{
   
    //本地的手机位置为空的时候，将地图上手机位置定到一个固定值,否则将本地手机位置作为当前点
    if (mUserData.mLon == nil || mUserData.mLat == nil || [mUserData.mLon isEqualToString:@""]||[mUserData.mLat isEqualToString:@""])
    {
        
        curCoord.latitude = MAP_DEFAULT_CDP_LAT;
        curCoord.longitude = MAP_DEFAULT_CDP_LON;
    }
    else
    {
        
        curCoord.latitude = [mUserData.mLat doubleValue];
        curCoord.longitude = [mUserData.mLon doubleValue];

    }
    
    [self setCurManLocation:curCoord];
    
    if (loginType==USER_LOGIN_CAR||loginType==USER_LOGIN_DEMO)
    {
        if ([mCarData.mLon isEqualToString:@""]||[mCarData.mLat isEqualToString:@""])
        {
            carCoord.latitude = MAP_DEFAULT_LPP_LAT;
            carCoord.longitude = MAP_DEFAULT_LPP_LON;
        }
        else
        {
            carCoord.latitude = [mCarData.mLat doubleValue];
            carCoord.longitude = [mCarData.mLon doubleValue];
        }
        
        [self setCarLocation:carCoord];
        //首次描画人的位置
        [self drawManLoc:curCoord];
        [self drawCarLoc:carCoord];
        if(status)
        {
            [self MatchingPointsInRegionStart:carCoord endPoint:curCoord];
        }
    }
    else
    {
        carBtn.hidden = YES;
    }
    
    
}



/*!
 @method getLastTrack
 @abstract 服务器获取车辆位置
 @discussion 服务器获取车辆位置
 @param 无
 @result 无
 */
- (IBAction)getLastTrack:(id)sender
{
    Resources *oRes = [Resources getInstance];
    self.progressHUD.labelText = [oRes getText:@"map.mapMainViewController.getCarLocLoading"];
    self.progressHUD.detailsLabelText = [oRes getText:@"common.load.text"];
    circumSearchCentralType = CIRCUM_SEARCH_CENTRAL_TYPE_CAR;
    if (loginType==USER_LOGIN_DEMO) {
        
        [self setMapCenter:carCoord];
        [self MBProgressHUDMessage:[oRes getText:@"map.mapMainViewController.getCarLocSuccess"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else
    {
        
        rootController.backBtn.enabled = NO;
        [self.progressHUD show:YES];
        [mGetLastTrcak createRequest:mCarData.mVin type:@"vin"];
        [mGetLastTrcak sendRequestWithAsync:self];
    }
}

/*!
 @method getLastTrack
 @abstract 服务器获取车辆位置
 @discussion 服务器获取车辆位置
 @param 无
 @result 无
 */
- (IBAction)moveToPhone:(id)sender
{
    curCoord = self.curManLocation;
    if (curCoord.latitude > 0.0 || curCoord.longitude > 0.0) {
        App *app = [App getInstance];
        [app updateLocation:[NSString stringWithFormat:@"%f",curCoord.longitude] lat:[NSString stringWithFormat:@"%f",curCoord.latitude]];
        [self setMapCenter:curCoord];
        
        circumSearchCentralType = CIRCUM_SEARCH_CENTRAL_TYPE_CUR;
    }
}


/*!
 @method onResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg
 @abstract 服务器获取车辆位置的回调函数
 @discussion 服务器获取车辆位置的回调函数，返回位置后，更新本地车辆位置信息，更新地图上车辆位置信息
 @param result 返回数据
 @param code 错误码
 @param errorMsg 错误信息
 @result 无
 */
- (void)onResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg
{
    Resources *oRes = [Resources getInstance];
    NSLog(@"receive the result.");
    NSString *lon;
    NSString *lat;
    NSString *lastRpTime;
    if (NAVINFO_RESULT_SUCCESS == code) {
        NSLog(@"result is :%@", result);
        lon=[result objectForKey:@"lon"];
        lat=[result objectForKey:@"lat"];
        if ([result objectForKey:@"time"]) {
            lastRpTime=[NSString stringWithFormat:@"%@",[result objectForKey:@"time"]];
        }
        else
        {
            lastRpTime=@"";
        }

        //服务器返回的经纬度不为空
        if (lon != nil && lat != nil)
        {
           if (self.carLocation.latitude != [lat doubleValue] || self.carLocation.longitude != [lon doubleValue])
            {
                App *app = [App getInstance];
                [app updateCarLocation:lon lat:lat lastRpTime:[App getDateWithTimeSince1970:lastRpTime]];

                carCoord.longitude = [lon doubleValue];
                carCoord.latitude = [lat doubleValue];

                [self setCarLocation:carCoord];
                
                //更新 车辆位置
                pointA.coordinate = carCoord;
                [_mapView.mapViewShare.mapView updateAnnotationPositon:pointA];
            }
            [self setMapCenter:self.carLocation];
            [self MBProgressHUDMessage:[oRes getText:@"map.mapMainViewController.getCarLocSuccess"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
        }
        else
        {
            [self MBProgressHUDMessage:[oRes getText:@"map.mapMainViewController.getCarLocError"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
        }
    }
    else if(NAVINFO_TOKENID_INVALID == code)//TokenID失效处理
    {
        [self MBProgressHUDMessage:[oRes getText:@"common.loseTokenID.message"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else
    {
        [self MBProgressHUDMessage:[oRes getText:@"map.mapMainViewController.getCarLocError"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
//    mDisView.hidden = YES;
    rootController.backBtn.enabled = YES;
    [self.progressHUD hide:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*!
 @method mapView:(NIMapView *)mapView onClickedAnnotationForBubble:(NSInteger)index
 @abstract 点击pop，进入详情
 @discussion 点击pop，进入详情
 @param mpoi poi信息
 @result 无
 */
- (void)mapView:(NIMapView *)mapView onClickedAnnotationForBubble:(NSInteger)index
{
    NSMutableDictionary *mapDataDic =  _mapView.POIData;
    MapPoiData *poiData = [mapDataDic objectForKey:BUBBLE_INFO_KEY];
    if (poiData.mID == ID_POI_CUR) {
        [rootController showCustomPOI:poiData type:POI_TYPE_PHONE];
    }
    else if (poiData.mID == ID_POI_CAR)
    {
        [rootController showCustomPOI:poiData type:POI_TYPE_CAR];
    }
    else if(poiData.mID == ID_POI_URL)
    {
        [rootController showCustomPOI:poiData type:POI_TYPE_URL];
        
    }
    else
    {
        [rootController showCustomPOI:poiData type:POI_TYPE_CUSTOM];
        
    }
    
}


#pragma mark -MBProgressHUDMessage
//message:提示内容 time：消失延迟时间（s） xOffset:相对屏幕中心点的X轴偏移 yOffset:相对屏幕中心点的Y轴偏移
- (void)MBProgressHUDMessage:(NSString *)message delayTime:(int)time xOffset:(float)xOffset yOffset:(float)yOffset
{
    MBProgressHUD *progressHUDMessage = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    progressHUDMessage.OffsetFlag =1;
    progressHUDMessage.mode = MBProgressHUDModeText;
	progressHUDMessage.labelText = message;
	progressHUDMessage.margin = 10.f;
    progressHUDMessage.xOffset = xOffset;
    progressHUDMessage.yOffset = yOffset;
	progressHUDMessage.removeFromSuperViewOnHide = YES;
	[progressHUDMessage hide:YES afterDelay:time];
    
}
#pragma mark -route
- (IBAction)showRoute:(id)sender
{
    if (!routeFlag)
    {
        
        Resources *oRes = [Resources getInstance];
        routeStartPoint = self.curManLocation;
        routeEndPoint = carCoord;
        self.progressHUD.labelText = [oRes getText:@"map.mapMainViewController.routeLoading"];
        self.progressHUD.detailsLabelText = [oRes getText:@"common.load.text"];
        [self.progressHUD show:YES];
        [_naviManager setDrawRouteProperty:12.0/255.0 g:255.0/255.0 b:128.0/255.0 width:4];
        [_naviManager showRouteWithStart:routeStartPoint andEnd:routeEndPoint];
        
        routeFlag = YES;
        
        
        
    }
    else
    {
        if (paopaoVIew.frame.origin.y < SCREEN_HIGHT-93)
        {
            [self cancelRouteForHideInfoView];
        }
        else
        {
            [self setInfoView:NO];
        }
        
        [_naviManager clearRoute];
        routeFlag = NO;
        routeBtn.selected = NO;
    }

}
//改变phone按钮位置，以便显示InfoView
- (void)changePhoneBtnCoordForShowInfoView
{
    CGRect bf = phoneBtn.frame;
    bf.origin.y = SCREEN_HIGHT-93-CGRectGetHeight(phoneBtn.frame)-55;
    phoneBtn.frame = bf;
}
//改变phone按钮位置，以便隐藏InfoView
- (void)changePhoneBtnCoordForHideInfoView
{
    CGRect f = phoneBtn.frame;
    f.origin.y = SCREEN_HIGHT-93-35-10;
    phoneBtn.frame = f;
}

//改变phone按钮位置，以便显示paopaoView
- (void)changePhoneBtnCoordForShowPaopaoView
{
    CGRect bf = phoneBtn.frame;
    bf.origin.y = SCREEN_HIGHT-93-CGRectGetHeight(phoneBtn.frame)-60;
    phoneBtn.frame = bf;
}

//改变phone按钮位置，以便隐藏paopaoView
- (void)changePhoneBtnCoordForHidePaopaoView
{
    CGRect f = phoneBtn.frame;
    f.origin.y = SCREEN_HIGHT-93-35-10;
    phoneBtn.frame = f;
}


//改变InfoView位置，以便显示InfoView
-(void)showInfoViewCoord
{
    CGRect f = routeView.frame;
    f.origin.y = SCREEN_HIGHT-93-CGRectGetHeight(routeView.frame);
    routeView.frame = f;
}

//改变InfoView位置，以便隐藏InfoView
-(void)hideInfoViewCoord
{
    CGRect f = routeView.frame;
    f.origin.y = SCREEN_HIGHT-93;
    routeView.frame = f;
}
//改变PaopaoView位置，以便显示PaopaoView
-(void)showPaopaoViewCoord
{
    CGRect f = paopaoVIew.frame;
    f.origin.y = SCREEN_HIGHT - 93 - CGRectGetHeight(paopaoVIew.frame);
    paopaoVIew.frame = f;
}
//改变PaopaoView位置，以便隐藏PaopaoView
-(void)hidePaopaoViewCoord
{
    CGRect f = paopaoVIew.frame;
    f.origin.y = SCREEN_HIGHT - 93;
    paopaoVIew.frame = f;
}

- (void)setInfoView:(BOOL)isShow
{
    if (isShow)
    {
        [UIView animateWithDuration:DURATION_TIME delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            
            [self changePhoneBtnCoordForShowInfoView];
            
            [self showInfoViewCoord];
        }
        completion:^(BOOL finished) {
            
        }];

    }
    else
    {
        [UIView animateWithDuration:DURATION_TIME delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            
            [self changePhoneBtnCoordForHideInfoView];
            

            [self hideInfoViewCoord];
        
        } completion:^(BOOL finished) {
            
        }];
    }
}
//当泡泡信息View显示的时候，并且算路也显示的时候，这时取消算路，隐藏算路信息View，但iphoneBtn不动
-(void)cancelRouteForHideInfoView
{
    [UIView animateWithDuration:DURATION_TIME delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
    
        [self hideInfoViewCoord];
        
    } completion:^(BOOL finished) {
        
    }];

}

-(void)setPaopaoView:(BOOL)isShow
{
    if (isShow)
    {
        //如果routeView的坐标等于SCREEN_HIGHT-93，表示routeView没有显示在屏幕上，那么直接弹出泡泡信息view
        NSLog(@"routeView.frame.origin.y:%f",routeView.frame.origin.y);
        NSLog(@"SCREEN_HIGHT-93:%f",SCREEN_HIGHT-93);
        NSLog(@"paopaoVIew.frame.origin.y:%f",paopaoVIew.frame.origin.y);
        //routeView为隐藏状态，那么直接弹出paopaoVIew
        if ((routeView.frame.origin.y > SCREEN_HIGHT-93) && (paopaoVIew.frame.origin.y > SCREEN_HIGHT-93))
        {
            [UIView animateWithDuration:DURATION_TIME delay:SHOW_DELAY_TIME options:UIViewAnimationOptionCurveLinear animations:^{
                
                [self showPaopaoViewCoord];
                
                [self changePhoneBtnCoordForShowPaopaoView];
                
                
            } completion:^(BOOL finished) {
                
            }];
        }
        else if(paopaoVIew.frame.origin.y < SCREEN_HIGHT-93)//paopaoVIew已经显示出来了，需要先隐藏在显示
        {
            [UIView animateWithDuration:DURATION_TIME delay:SHOW_DELAY_TIME options:UIViewAnimationOptionCurveLinear animations:^{
                
                [self changePhoneBtnCoordForHidePaopaoView];
                [self hidePaopaoViewCoord];
                
                
            }
            completion:^(BOOL finished)
            {
                
                
                [UIView animateWithDuration:DURATION_TIME delay:SHOW_DELAY_TIME options:UIViewAnimationOptionCurveLinear animations:^{
                    
                    [self showPaopaoViewCoord];
                    
                    [self changePhoneBtnCoordForShowPaopaoView];
                    
                } completion:^(BOOL finished) {
                    
                }];
            }];
        }
        else
        {
            [UIView animateWithDuration:DURATION_TIME delay:SHOW_DELAY_TIME options:UIViewAnimationOptionCurveLinear animations:^{
                
                [self changePhoneBtnCoordForHideInfoView];
                [self hideInfoViewCoord];
                
                
            } completion:^(BOOL finished) {
                
                
                [UIView animateWithDuration:DURATION_TIME delay:SHOW_DELAY_TIME options:UIViewAnimationOptionCurveLinear animations:^{
                    
                    [self showPaopaoViewCoord];
                    
                    [self changePhoneBtnCoordForShowPaopaoView];
                    
                } completion:^(BOOL finished) {
                    
                }];
                
                
                

            }];
        }
        
    }
    else
    {
        [self changePhoneBtnCoordForHidePaopaoView];
        [self hidePaopaoViewCoord];
    }
}

- (void)NINaviManager:(NINaviManager *)naviManager andRoute:(NINaviRoute*)data  andError:(int)error
{
    Resources *oRes = [Resources getInstance];
    if (error == 0)
    {
        [self.progressHUD hide:YES];
        if (paopaoVIew.frame.origin.y < SCREEN_HIGHT-93)
        {
            [UIView animateWithDuration:DURATION_TIME delay:SHOW_DELAY_TIME options:UIViewAnimationOptionCurveLinear animations:^{
                
                [self changePhoneBtnCoordForHidePaopaoView];
                [self hidePaopaoViewCoord];
                
                
            }
            completion:^(BOOL finished)
            {
                 
                 
                 [UIView animateWithDuration:DURATION_TIME delay:SHOW_DELAY_TIME options:UIViewAnimationOptionCurveLinear animations:^{
                     
                     [self setInfoView:YES];
                     
                 } completion:^(BOOL finished) {
                     
                 }];
             }];

        }
        else
        {
            [self setInfoView:YES];
        }
        
        routeBtn.selected = YES;
        
        disNum.text = [NSString stringWithFormat:@"%.2f",round(data.routeLength/1000.0*100)/100];
        NSLog(@"%@",disNum.text);
    }
    else
    {
        [self.progressHUD hide:YES];
        [self MBProgressHUDMessage:[oRes getText:@"map.mapMainViewController.routeFailure"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
        NSLog(@"路径规划失败");
    }
    

   
}

#pragma mark - map
//绘制人的位置
- (void)drawManLoc:(CLLocationCoordinate2D)newLocation
{
    if (_myPosAnnotation == nil) {
        _myPosAnnotation = [[NIPointAnnotation alloc]initWithMapView:_mapView.mapViewShare.mapView];
        _myPosAnnotation.coordinate = newLocation;
        _myPosAnnotation.annotationID = ID_POI_CUR;
        [_mapView.mapViewShare.mapView addAnnotation:_myPosAnnotation];
    }
}
//绘制车辆位置
- (void)drawCarLoc:(CLLocationCoordinate2D)carLocation
{
    if (pointA == nil)
    {
        pointA = [[NIPointAnnotation alloc]initWithMapView:_mapViewBase.mapViewShare.mapView];
    }
    
    pointA.coordinate = carLocation;
    pointA.annotationID = ID_POI_CAR;
    [_mapViewBase.mapViewShare.mapView addAnnotation:pointA];
}

//移除车辆位置
- (void)removeCarLoc
{
    if (pointA) {
        [_mapViewBase.mapViewShare.mapView removeAnnotation:pointA];
        [pointA release];
        pointA = nil;

    }
}

- (void)removeLoc
{
    if (_myPosAnnotation) {
        [_mapViewBase.mapViewShare.mapView removeAnnotation:_myPosAnnotation];
        [_myPosAnnotation release];
        _myPosAnnotation = nil;
    }
}


- (NIAnnotationView *)mapView:(NIMapView *)mapView viewForAnnotation:(id <NIAnnotation>)annotation
{
    if([annotation isEqual:pointA])
    {
        NSString *AnnotationViewID = @"pointA";

        NIAnnotationView* _point_A = [[[NIAnnotationView alloc] initWithNIMapView:mapView reuseIdentifier:AnnotationViewID]autorelease];
        
        _point_A.priority = 11;
        _point_A.image = [UIImage imageNamed:@"map_carPoi_icon"];
        
        return _point_A;
        
    }
    else if ([annotation isEqual:_myPosAnnotation])
    {
        NSString *AnnotationViewID = @"Location";

        if (_myPosView == nil)
        {
            _myPosView = [[NILocationAnnotationView alloc]initWithNIMapView:mapView reuseIdentifier:AnnotationViewID];
            _myPosView.LocationImage = @"map_location";//如果不设置，会用默认的图片。
            _myPosView.rotate = _dLocationDirection;
            _myPosView.anchor = NIAnchorMake(0.5f,0.5f);
            
        }
        return _myPosView;
    }
    else if ([annotation isKindOfClass:[NIPointAnnotation class]] )
    {
        NSString *AnnotationViewID = @"pointMark";

        NIPinAnnotationView *_viewPoint = [[[NIPinAnnotationView alloc] initWithNIMapView:mapView reuseIdentifier:AnnotationViewID]autorelease];
        _viewPoint.priority = 11;
        _viewPoint.image = [UIImage imageNamed:[NSString stringWithFormat:@"map_customPoi_icon"]];

        return _viewPoint;
    }

    
    
    return nil;
}

//地图上添加单个大头针标注
- (void)addOneAnnotation:(MapPoiData*)coordData
{
    
    pointAnnotation = [[NIPointAnnotation alloc]initWithMapView:_mapViewBase.mapViewShare.mapView];
    
    pointAnnotation.title = coordData.mName;
    pointAnnotation.subtitle = coordData.mAddress;
    pointAnnotation.annotationID = coordData.mID;
    pointAnnotation.coordinate = coordData.coordinate;
    
    [_mapViewBase.mapViewShare.mapView setCenter:coordData.coordinate];
    [_mapViewBase.mapViewShare.mapView addAnnotation:pointAnnotation];
    
}

//移除长按大头针
-(void)removeLongclickPoint{
    if (pointAnnotation != nil)
    {
        [_mapViewBase.mapViewShare.mapView removeAnnotation:pointAnnotation];
        [pointAnnotation release];
        pointAnnotation=nil;

    }
}

- (void)mapView:(NIMapView *)mapView onLongClick:(CLLocationCoordinate2D)coordinate
{
    NSLog(@"长按---》%f,%f",coordinate.latitude,coordinate.longitude);
    
    if ([_mapViewBase.POIData objectForKey:BUBBLE_INFO_KEY])
    {
        [_mapViewBase.POIData removeObjectForKey:BUBBLE_INFO_KEY];
    }
    
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
    
    
    [self removeLongclickPoint];
    if (pointAnnotation == nil)
    {
        pointAnnotation = [[NIPointAnnotation alloc]initWithMapView:_mapViewBase.mapViewShare.mapView];
        pointAnnotation.coordinate = coordinate;
        pointAnnotation.annotationID = ID_POI_CUSTOM;
        [_mapViewBase.mapViewShare.mapView addAnnotation:pointAnnotation];
        
    }

}

// 当点击annotation view时，调用此接口
- (void)mapView:(NIMapView *)mapView onClickedAnnotation:(id <NIAnnotation>)annotation
{
    
    Resources *oRes = [Resources getInstance];
    App *app = [App getInstance];
    NSLog(@"annotation.annotationID %d",annotation.annotationID);
    //如果是车辆位置大头针，设置相应标题
    if([annotation isEqual:pointA])
    {
        paopaoInfoTitle.text = [NSString stringWithFormat:@"%@(%@)",[oRes getText:@"Map.paopaoInfo.carLocText"],app.mCarData.mCarNumber];
    }
    //如果是手机位置大头针，设置相应标题
    if ([annotation isEqual:_myPosAnnotation])
    {
        paopaoInfoTitle.text = [oRes getText:@"Map.paopaoInfo.phoneLocText"];
    }
    //如果是自定义位置大头针，设置相应标题
    if (annotation.annotationID == ID_POI_CUSTOM)
    {
       paopaoInfoTitle.text = [oRes getText:@"Map.paopaoInfo.poiLocText"];
    }
    
    
    if (annotation.annotationID == ID_POI_URL)
    {
        paopaoInfoTitle.text = annotation.title;
        paopaoInfoSubTitle.text = annotation.subtitle;
    }
    else
    {
        paopaoInfoSubTitle.text = [oRes getText:@"Map.paopaoInfo.waitText"];
        [self LaunchSearcher:[annotation coordinate]];
    }
    
    [self setPaopaoView:YES];

        
        
        //data
        if ([_mapViewBase.POIData objectForKey:BUBBLE_INFO_KEY])
        {
            [_mapViewBase.POIData removeObjectForKey:BUBBLE_INFO_KEY];
        }
        
        MapPoiData* tempData = [[MapPoiData alloc]init];
        tempData.mID = annotation.annotationID;
        tempData.coordinate = [annotation coordinate];
        tempData.mName = paopaoInfoTitle.text;
        tempData.mAddress = annotation.subtitle;
        
        [_mapViewBase.POIData setObject:tempData forKey:BUBBLE_INFO_KEY];
        [tempData release];
    

    [_mapViewBase.mapViewShare.mapView setCenter:[annotation coordinate]];
    
    
}

// 当点击地图空白处时，调用此接口
- (void)mapView:(NIMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate{
    if ([_mapViewBase.POIData objectForKey:BUBBLE_INFO_KEY])
    {
        [_mapViewBase.POIData removeObjectForKey:BUBBLE_INFO_KEY];
    }
    
    if (paopaoVIew.frame.origin.y < SCREEN_HIGHT-93)
    {
        [UIView animateWithDuration:DURATION_TIME delay:SHOW_DELAY_TIME options:UIViewAnimationOptionCurveLinear animations:^{
            
            [self changePhoneBtnCoordForHidePaopaoView];
            [self hidePaopaoViewCoord];
            
        } completion:^(BOOL finished) {
            
            if (routeBtn.selected)
            {
                [UIView animateWithDuration:DURATION_TIME delay:SHOW_DELAY_TIME options:UIViewAnimationOptionCurveLinear animations:^{
                    
                    [self showInfoViewCoord];
                    [self changePhoneBtnCoordForShowInfoView];
                    
                } completion:^(BOOL finished) {
                    
                }];
            }
            
        }];
    }
    
}
#pragma nark - ReverseGeo
//获取地址信息
-(void)LaunchSearcher:(CLLocationCoordinate2D)coordinate{
    //调用逆地理编码接口，获取当前位置的逆地理编码
    GeoFailureflag =YES;
    NIReverseGeoCodeOption *reverseGeoCodeSearchOption = [[NIReverseGeoCodeOption alloc] init];
    reverseGeoCodeSearchOption.reverseGeoPoint = coordinate;
    [_searchGeo reverseGeoCode:reverseGeoCodeSearchOption];
    [reverseGeoCodeSearchOption release];
}
// 逆地理编码的Delegate
- (void)onGetReverseGeoCodeResult:(NIGeoCodeSearch *)searcher result:(NIReverseGeoCodeResult *)result  errorCode:(int)error {
    Resources *oRes = [Resources getInstance];
    GeoFailureflag = NO;
    //0表示逆地理没有错误
    if (error == 0)
    {
        
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
        
        
        
        paopaoInfoSubTitle.text = [NSString stringWithString:address];
        
        //data
        
        MapPoiData* tempData = [_mapViewBase.POIData objectForKey:BUBBLE_INFO_KEY];
        tempData.mAddress = paopaoInfoSubTitle.text;
        
        [_mapViewBase.POIData setObject:tempData forKey:BUBBLE_INFO_KEY];
        
        
    }
    else
    {
        paopaoInfoSubTitle.text = [oRes getText:@"Map.paopaoInfo.failureText"];
        
    }
    
    
}
#pragma mark - location
//用户位置更新后，会调用此函数
- (void)didUpdateUserLocation:(NIUserLocation *)userLocation;
{
    CLLocationCoordinate2D newLocation = userLocation.location.coordinate;//取出gps获取的经纬度
    self.curManLocation = newLocation;

    if (_myPosAnnotation == nil) {
        _myPosAnnotation = [[NIPointAnnotation alloc]initWithMapView:_mapView.mapViewShare.mapView];
        _myPosAnnotation.coordinate = newLocation;
        [_mapView.mapViewShare.mapView addAnnotation:_myPosAnnotation];
    }else{
        //如果位置没发生变化就不重新画位置点了。
        if (_myPosAnnotation.coordinate.longitude == newLocation.longitude &&
            _myPosAnnotation.coordinate.latitude == newLocation.latitude) {
            NSLog(@"----didUpdateUserLocation-----------2");
            return;
        }
        _myPosAnnotation.coordinate = newLocation;
        [_mapView.mapViewShare.mapView updateAnnotationPositon:_myPosAnnotation];
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

-(void)didUpdateUserHeading:(NIUserLocation *)userLocation{
    if ( userLocation.heading.headingAccuracy < 0.0 ) {
        return;
    }
    
    _dLocationDirection = userLocation.heading.trueHeading;
    if (_myPosAnnotation == nil)
    {
        return;
    }
    
    _myPosView.rotate =  (int)(_dLocationDirection + _mapView.mapViewShare.mapView.mapStatus.fRotation)%360;
    
    [_mapView.mapViewShare.mapView updateAnnotation:_myPosAnnotation withAnnotationView:_myPosView];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
    NSLog(@"%@",error);
}

- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"erro = %d",error.code);

    
}

- (void)mapStatusDidChanged:(NIMapView *)mapView{
    if (_myPosAnnotation != nil && _myPosView != nil) {
        _myPosView.rotate =  (int)(_dLocationDirection + mapView.mapStatus.fRotation)%360;
        
        NSLog(@"%d++++",(int)(_dLocationDirection+ mapView.mapStatus.fRotation)%360);
        
        
        // [_mapViewBase updateAnnotationPositon:_myPosAnnotation];
        [_mapView.mapViewShare.mapView updateAnnotation:_myPosAnnotation withAnnotationView:_myPosView];
        
    }
}

- (void)viewDidUnload {

    [routeView release];
    routeView = nil;
    [paopaoVIew release];
    paopaoVIew = nil;
    [routeBtn release];
    routeBtn = nil;
    [disNum release];
    disNum = nil;
    [paopaoInfoTitle release];
    paopaoInfoTitle = nil;
    [paopaoInfoSubTitle release];
    paopaoInfoSubTitle = nil;
    [paopaoInfoText release];
    paopaoInfoText = nil;
[super viewDidUnload];
}
@end
