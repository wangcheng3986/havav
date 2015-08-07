
/*!
 @header SearchResultViewController.m
 @abstract 搜索结果
 @author mengy
 @version 1.00 13-4-24 Creation
 */
#import "App.h"
#import "SearchResultViewController.h"
#import "POIDetailViewController.h"
#import "SearchResultData.h"
#import "SearchViewController.h"
#import "CircumViewController.h"
#import "SearchPoiAnnotation.h"
@interface SearchResultViewController ()
{

   NSString *mkeyword;
    NSString *msearchType;
    double mLat;
    double mLon;
    CGRect rect;
    int mapViewState;
    int rightButtonState;
    UIBarButtonItem *rightButton;
    UIBarButtonItem *leftButton;
//    int count;
    int firstCount;
    int position;
    UserData *mUser;
    NSString *km;
    NSString *m;
    int page;
    int nowPage;
    int cellNum;
//    SearchResultData *searchResult;
    BOOL isFirstShow;
    
    BOOL needMatchingPointsInRegion;
    BOOL bLoadMapView;
    
    NIPointAnnotation* _pointAnnotation;
    NIAnnotationView* _pointView;
    
    NSMutableArray *posArray;
    
    //add by wangcheng1
    NSMutableArray* _arrayAnnotations;
    NSMutableArray* _arrayAnnotationViews;
}
@end

@implementation SearchResultViewController
@synthesize data;
@synthesize searchViewRootController;
@synthesize circumViewRootController;
@synthesize resultRootType;
@synthesize picUrlString;
@synthesize progressHUD;
@synthesize searchResultMutableArray;
@synthesize total;
@synthesize searchKeyType;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dealloc
{
    NSLog(@"searchResult dealloc");
    if (self.progressHUD){
        [self.progressHUD removeFromSuperview];
        [self.progressHUD release];
        self.progressHUD = nil;
    }
    if (searchResultMutableArray) {
        NSLog(@"清除缓存");
        [searchResultMutableArray removeAllObjects];
        [searchResultMutableArray release];
        searchResultMutableArray=nil;
    }
    if (data) {
        [data release];
    }
    
    if (km) {
        [km release];
    }
    if (m) {
        [m release];
    }
    if (mkeyword) {
        [mkeyword release];
    }
    
    if (mDisView) {
        [mDisView removeFromSuperview];
        [mDisView release];
    }
    
    
    if (searchResultTableView) {
        [searchResultTableView removeFromSuperview];
        [searchResultTableView release];
    }
    if(leftButton)
    {
        [leftButton release];
        leftButton = nil;
    }
    if (rightButton) {
        [rightButton release];
        rightButton = nil;
    }
    if (backBtn) {
        [backBtn removeFromSuperview];
        [backBtn release];
    }
    
    if (footerLabel) {
        [footerLabel release];
        footerLabel = nil;
    }
    
    if (footerView) {
        [footerView removeFromSuperview];
        [footerView release];
    }
    
    if (mapBtn) {
        [mapBtn removeFromSuperview];
        [mapBtn release];
    }
    if (self.imageView) {
        [self.imageView removeFromSuperview];
        [self.imageView release];
    }
    if (_mapView.POIData)
    {
        [_mapView.POIData removeAllObjects];
        [_mapView.POIData release];
        _mapView.POIData =nil;
    }
    
    
    if (posArray) {
        [posArray removeAllObjects];
        [posArray release];
        posArray = nil;
    }
    [self releasePaopao];
    [self releasePois];
    [super dealloc];
}

/*!
 @method viewDidLoad
 @abstract 加载界面信息，初始化数据
 @discussion 加载界面信息，初始化数据
 @param 无
 @result 无
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    isFirstShow = YES;
    needMatchingPointsInRegion = YES;
    km=[[NSString alloc]initWithString:@"Km"];
    m=[[NSString alloc]initWithString:@"m"];
    data=[[POIData alloc]init];
    App *app = [App getInstance];
    mUser=[app getUserData];
    mapViewState=MAPVIEW_HIDE;
    rightButtonState=MAP;
//    count=10;
    position=0;
    page = 2;
    nowPage = 1;
    
    cellNum = 0;
    Resources *oRes = [Resources getInstance];
    if([App getVersion]>=IOS_VER_7){
        [App ios7ViewLocation:self];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_ios7_navBar_bg"] forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_ios6_navBar_bg"] forBarMetrics:UIBarMetricsLandscapePhone];
    }
    self.view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    self.navigationItem.title=[oRes getText:@"map.SearchResultViewController.title"];
    rect = CGRectMake(self.view.frame.origin.x,self.view.frame.origin.y,self.view.frame.size.width,self.view.frame.size.height);
    searchResultTableView.frame = rect;
    footerLabel.text=[oRes getText:@"map.SearchResultViewController.footerlabeltext"];
    footerLabel.font =[UIFont footerSize];
    footerLabel.hidden=YES;
    mapBtn = [[RightButton alloc]init];
    [mapBtn setTitle:[oRes getText:@"map.SearchResultViewController.mapButton"] forState:UIControlStateNormal];
    [mapBtn addTarget:self action:@selector(onclickMapOrList)forControlEvents:UIControlEventTouchUpInside];
    rightButton = [[UIBarButtonItem alloc]initWithCustomView:mapBtn];
    self.navigationItem.rightBarButtonItem = rightButton;
//    rightButton.enabled=NO;
    backBtn = [[LeftButton alloc]init];
    [backBtn addTarget:self action:@selector(popself)forControlEvents:UIControlEventTouchUpInside];
    leftButton=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftButton;
    [self.view addSubview:searchResultTableView];
    mDisView.hidden=YES;
    [self.view addSubview:mDisView];
    //当进入视图时，重新设置imageView
    [self.imageView setImage:nil];
    [self.imageView setFrame:CGRectMake(160, 200, 0, 0)];
    //显示加载等待框
    self.progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.progressHUD];
    [self.view bringSubviewToFront:self.progressHUD];
    self.progressHUD.delegate = self;
    self.progressHUD.labelText = [oRes getText:@"map.SearchResultViewController.loadTitle"];
    self.progressHUD.detailsLabelText = [oRes getText:@"common.load.text"];
    [self loadMapView];
    // Do any additional setup after loading the view from its nib.
}

/*!
 @method loadMapView
 @abstract 加载地图
 @discussion 加载地图
 @param 无
 @result 无
 */
-(void)loadMapView
{
    if (bLoadMapView == NO) {
        [self setMapView:_mapView];
        self.requestReverseGeoFlag = NO;
        self.LongPressure = NO;
        [self loadMapBaseParameter];
        [_mapView initDataDic];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //设置指南针消失'
//    [_mapView.mapViewShare.mapView setRotateEnabled:YES];
    [_mapView.mapViewShare.mapView setShowDirection:NO image:nil];
    [_mapView.mapViewShare.mapView setScalePoint:CGPointMake(5.0,10.0)];
    [self mapViewWillAppear];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    
    [self setAnnotationViewVisable:NO andCount:10];
    [self mapViewWillDisappear];
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}




-(void)mapViewWillAppear
{
    if (mapViewState==MAPVIEW_SHOW) {
        
        if (needMatchingPointsInRegion == NO) {
            if ([_mapView.POIData objectForKey:MAP_STATUS_KEY]) {
                
                NIMapStatus *status = [_mapView.POIData objectForKey:MAP_STATUS_KEY];
                [self setMapStatus:status];
            }
        }
//        [_mapView viewWillAppear];
        _mapView.mapViewShare.mapView.delegate = self;
        [_mapView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) ];
        [self.view addSubview:_mapView];
    }
    
}


-(void)mapViewWillDisappear
{
    if (mapViewState==MAPVIEW_SHOW) {
        
        [self saveMapStatus];
        [self hidePaopao];
//        [self releasePaopao];
        
//        [_mapView viewWillDisappear];
        _mapView.mapViewShare.mapView.delegate = nil;
        [_mapView removeFromSuperview];
    }
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
 @method setKeyword:(NSString *)keyword
 @abstract 设置关键字
 @discussion 设置关键字
 @param keyword 关键字
 @result 无
 */
-(void)setKeyword:(NSString *)keyword
{
    mkeyword=[[NSString alloc]initWithFormat:@"%@",keyword];
}

/*!
 @method setSearchType:(NSString *)searchType
 @abstract 设置搜索类型
 @discussion 设置搜索类型
 @param searchType 搜索类型
 @result 无
 */
-(void)setSearchType:(NSString *)searchType
{
    msearchType=searchType;
}

/*!
 @method setCentreLocation:(double)lat lon:(double)lon
 @abstract 设置搜索中心点
 @discussion 设置搜索中心点
 @param lat 纬度
 @param lon 经度
 @result 无
 */
-(void)setCentreLocation:(double)lat lon:(double)lon
{
    mLat=lat;
    mLon=lon;
}


/*!
 @method search
 @abstract 搜索
 @discussion 搜索
 @param 无
 @result 无
 */
- (void)search
{
    backBtn.enabled=NO;
    mDisView.hidden=NO;
    rightButton.enabled=NO;
    [self.progressHUD show:YES];
    if (searchKeyType == SEARCH_TYPE_4S_STORES) {
        NSDictionary *para;
        para = [NSDictionary dictionaryWithObjectsAndKeys:
                [NSString stringWithFormat:@"%f",mLon],@"lon",//
                [NSString stringWithFormat:@"%f",mLat],@"lat",//
                [NSString stringWithFormat:@"%d",page],@"page",//
                @"10",@"pagesize",//
                nil];
        mPOISearch4S = [[NIPOISearch4S alloc]init];
        [mPOISearch4S createRequest:para];
        [mPOISearch4S sendRequestWithAsync:self];
    }
    else
    {
        
        NSDictionary *para;
        NSLog(@"%@",mkeyword);
        NSLog(@"%@",msearchType);
        NSString *radius = nil;
        if (resultRootType == RESULT_ROOT_SEARCH) {
            radius = [NSString stringWithFormat:@"-1"];
        }
        else
        {
            radius = [NSString stringWithFormat:@"1000"];
        }
        if (searchKeyType == SEARCH_TYPE_ORTHER)
        {
            para = [NSDictionary dictionaryWithObjectsAndKeys:
                    [NSString stringWithFormat:@"%f",mLon],@"lon",//
                    [NSString stringWithFormat:@"%f",mLat],@"lat",//
                    radius,@"radius",//
                    [NSString stringWithFormat:@"%@",mkeyword],@"keyword",//
                    [NSString stringWithFormat:@"%d",page],@"page",//
                    @"10",@"pagesize",//
                    nil];
        }
        else
        {
            para = [NSDictionary dictionaryWithObjectsAndKeys:
                    [NSString stringWithFormat:@"%f",mLon],@"lon",//
                    [NSString stringWithFormat:@"%f",mLat],@"lat",//
                    radius,@"radius",//
//                    [NSString stringWithFormat:@"%d",searchKeyType],@"kind",//
                    [NSString stringWithFormat:@"%@",msearchType],@"keyword",//
                    [NSString stringWithFormat:@"%d",page],@"page",//
                    @"10",@"pagesize",//
                    nil];
        }
        mPOISearchJSONServer = [[NIPOISearchJSONServer alloc]init];
        [mPOISearchJSONServer createRequest:para];
        [mPOISearchJSONServer sendRequestWithAsync:self];
    }
    
    
    
}



/*!
 @method onSearchResult:(NSMutableDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg
 @abstract 后台poi检索回调函数
 @discussion 后台poi检索回调函数
 @param result 返回数据
 @param code 返回码
 @param errorMsg 错误信息
 @result 无
 */
- (void)onSearchResult:(NSMutableDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg
{
    [mPOISearchJSONServer release];
    Resources *oRes = [Resources getInstance];
    if (code == NAVINFO_RESULT_SUCCESS) {
        if ([result objectForKey:@"total"] != nil) {
            total =[[result objectForKey:@"total"]integerValue];
        }
        if ([result objectForKey:@"poiList"]) {
            NSArray *temp = [result objectForKey:@"poiList"];
            NSLog(@"temp is :%@", temp);
            for (int i=0; i<temp.count; i++) {
                NSDictionary *dict = [temp objectAtIndex:i];
                if (dict) {
                    SearchResultData *searchResult=[[SearchResultData alloc]init];
                    if ([dict valueForKey:@"poiId"]) {
                        searchResult.mGid=[dict valueForKey:@"poiId"] ;
                    }
                    else
                    {
                        searchResult.mGid=@"";
                    }
                    if ([dict valueForKey:@"lon"]) {
                        searchResult.mLon=[dict valueForKey:@"lon"];
                    }
                    else
                    {
                        searchResult.mLon=@"";
                    }
                    if ([dict valueForKey:@"lat"]) {
                        searchResult.mLat= [dict valueForKey:@"lat"];
                    }
                    else
                    {
                        searchResult.mLat=@"";
                    }
                    if ([dict valueForKey:@"poiAddress"]) {
                        searchResult.mAddress=[dict valueForKey:@"poiAddress"] ;
                    }
                    else
                    {
                        searchResult.mAddress=@"";
                    }
                    NSLog(@"%@",searchResult.mAddress);
                    if ([dict valueForKey:@"poiName"]) {
                        searchResult.mName=[dict valueForKey:@"poiName"];
                    }
                    else
                    {
                        searchResult.mName = @"";
                    }
                    if ([dict valueForKey:@"adminregionCode"]) {
                        searchResult.mTypeCode=[dict valueForKey:@"adminregionCode"];
                    }
                    else
                    {
                        searchResult.mTypeCode=@"";
                    }
                    if ([dict valueForKey:@"tel"]) {
                        searchResult.mPhone=[dict valueForKey:@"tel"];
                    }
                    else
                    {
                        searchResult.mPhone=@"";
                    }
                    if ([dict valueForKey:@"distance"]) {
                        searchResult.mDistance=[dict valueForKey:@"distance"];
                    }
                    else
                    {
                        searchResult.mDistance=@"";
                    }
                    [searchResultMutableArray addObject:searchResult];
                    [searchResult release];
                }
                
            }
            
        
        }
        if (searchResultMutableArray.count > 0) {
            searchResultTableView.sectionFooterHeight = 0;
        }
        if (searchResultMutableArray.count==0) {
            footerView.hidden = NO;
            footerLabel.hidden=NO;
        }
        else
        {
            footerView.hidden = YES;
            footerLabel.hidden=YES;
        }
        page++;
        nowPage ++;
        [searchResultTableView reloadData];
        [self tableViewScrollToTop];
        
    }
    else if( code == NET_ERROR )
    {
        
        [self MBProgressHUDMessage:[oRes getText:@"common.noNetAlert.message"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else
    {
        [self MBProgressHUDMessage:[oRes getText:@"map.SearchResultViewController.loadFailAlert"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    
    [self.imageView setFrame:CGRectMake(160, 200, 0, 0)];
    [self.progressHUD hide:YES];
    backBtn.enabled=YES;
    mDisView.hidden=YES;
    rightButton.enabled=YES;
}

/*!
 @method onSearch4SResult:(NSMutableDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg
 @abstract 后台poi检索回调函数
 @discussion 后台poi检索回调函数
 @param result 返回结果
 @param code 返回码
 @param errorMsg 错误信息
 @result 无
 */
- (void)onSearch4SResult:(NSMutableDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg
{
    
    
    Resources *oRes = [Resources getInstance];
    [mPOISearch4S release];
    if (code == NAVINFO_RESULT_SUCCESS) {
        if ([result objectForKey:@"total"] != nil) {
            total =[[result objectForKey:@"total"]integerValue];
        }
        if ([result objectForKey:@"dealerList"]) {
            NSArray *temp = [result objectForKey:@"dealerList"];
            NSLog(@"temp is :%@", temp);
            for (int i=0; i<temp.count; i++) {
                NSDictionary *dict = [temp objectAtIndex:i];
                if (dict) {
                    Search4SResultData *searchResult=[[Search4SResultData alloc]init];
                    if ([dict valueForKey:@"address"]) {
                        searchResult.mAddress=[dict valueForKey:@"address"] ;
                    }
                    else
                    {
                        searchResult.mAddress=@"";
                    }
                    NSLog(@"%@",searchResult.mAddress);
                    if ([dict valueForKey:@"name"]) {
                        searchResult.mName=[dict valueForKey:@"name"];
                    }
                    else
                    {
                        searchResult.mName = @"";
                    }
                    if ([dict valueForKey:@"lon"]) {
                        searchResult.mLon=[dict valueForKey:@"lon"];
                    }
                    else
                    {
                        searchResult.mLon=@"";
                    }
                    if ([dict valueForKey:@"lat"]) {
                        searchResult.mLat=[dict valueForKey:@"lat"];
                    }
                    else
                    {
                        searchResult.mLat=@"";
                    }
                    if ([dict valueForKey:@"distance"]) {
                        searchResult.mDistance=[dict valueForKey:@"distance"];
                    }
                    else
                    {
                        searchResult.mDistance=@"";
                    }
                    if ([dict valueForKey:@"tel"]) {
                        searchResult.mtel=[dict valueForKey:@"tel"];
                    }
                    else
                    {
                        searchResult.mtel=@"";
                    }
                    if ([dict valueForKey:@"level"]) {
                        searchResult.mLevel=[dict valueForKey:@"level"];
                    }
                    else
                    {
                        searchResult.mLevel=@"";
                    }
                    if ([dict valueForKey:@"startOpenTime"]) {
                        searchResult.mStartOpenTime=[dict valueForKey:@"startOpenTime"];
                    }
                    else
                    {
                        searchResult.mStartOpenTime=@"";
                    }
                    if ([dict valueForKey:@"endOpenTime"]) {
                        searchResult.mEndOpenTime=[dict valueForKey:@"endOpenTime"];
                    }
                    else
                    {
                        searchResult.mEndOpenTime=@"";
                    }
                    
                    if ([dict valueForKey:@"brandAgent"]) {
                        searchResult.mBrandAgent=[dict valueForKey:@"brandAgent"];
                    }
                    else
                    {
                        searchResult.mBrandAgent=@"";
                    }
                    [searchResultMutableArray addObject:searchResult];
                    [searchResult release];
                }
                
            }
        }
    }
    else if( code == NET_ERROR )
    {
        [self MBProgressHUDMessage:[oRes getText:@"common.noNetAlert.message"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else
    {
        
        [self MBProgressHUDMessage:[oRes getText:@"map.SearchResultViewController.loadFailAlert"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    [self.imageView setFrame:CGRectMake(160, 200, 0, 0)];
    [self.progressHUD hide:YES];
    backBtn.enabled=YES;
    mDisView.hidden=YES;
}



/*!
 @method setPOI
 @abstract 将列表的10个poi点显示在地图上
 @discussion 将列表的10个poi点显示在地图上
 @param 无
 @result 无
 */
-(void)setPOIWithNeedMatchingPointsInRegion:(BOOL)status
{
    if (cellNum == 0) {
//        [self setZoom:MAP_ZOOM_DEFAULT_SIZE];
    }
    else
    {
        NSLog(@"%d",cellNum);
        int num=0;
        num = cellNum - 1;
        if (posArray) {
            [posArray removeAllObjects];
            [posArray release];
            posArray = nil;
        }
        posArray = [[NSMutableArray alloc]initWithCapacity:0];
        SearchResultData *searchResult;
        MapPoiData *customPOI;
        for (int i=0; i<num; i++) {
            
            int tempNum = (nowPage - 1)*10 + i;
            searchResult=[searchResultMutableArray objectAtIndex:tempNum];
            
            customPOI = [[MapPoiData alloc] initWithID:i];
            customPOI.coordinate = CLLocationCoordinate2DMake([searchResult.mLat doubleValue], [searchResult.mLon doubleValue]);
            customPOI.mImageName = [NSString stringWithFormat:@"map_result_map_ic_%d",i+1];
            customPOI.mName = searchResult.mName;
            customPOI.mAddress = searchResult.mAddress;
            [posArray addObject:customPOI];
            [_mapView.POIData setValue:customPOI forKey:[NSString stringWithFormat:@"%d",i]];
            [customPOI release];
            customPOI = nil;
        }
        [self showPois:posArray withMatch:status];
    }
}

//add by wangcheng
-(void)releasePois{
    if (_arrayAnnotations) {
        for (int i =0; i< 10; i++) {
            [_mapView.mapViewShare.mapView removeAnnotation:[_arrayAnnotations objectAtIndex:i]];
        }
        [_arrayAnnotations removeAllObjects];
        [_arrayAnnotations release];
        _arrayAnnotations = nil;
    }
    if (_arrayAnnotationViews) {
        for (int i =0; i< 10; i++) {
            [[_arrayAnnotationViews objectAtIndex:i] release];
        }
        [_arrayAnnotationViews removeAllObjects];
        [_arrayAnnotationViews release];
        _arrayAnnotationViews = nil;
    }
}


-(void)setAnnotationViewVisable:(BOOL)visable andCount:(NSInteger)count{
    if (_arrayAnnotationViews) {
        for (int i = 0; i< count; i++) {
            NIAnnotationView* v = [_arrayAnnotationViews objectAtIndex:i];
            v.visable = visable;
            v.enabled = visable;
            NSLog(@"poi.priority>>>>>>>>>>>>>>>%d",v.priority);
        }
    }
}


//add by wangcheng2
-(void)showPois:(NSMutableArray*)mapPoiDatas withMatch:(BOOL)match{
    
    if(_arrayAnnotations == nil){
        //初始化10个点的数据对象
        _arrayAnnotations = [[NSMutableArray alloc]init];
        for(int i =0; i < 10; i++){
            SearchPoiAnnotation *point = [[SearchPoiAnnotation alloc]initWithMapView:_mapView.mapViewShare.mapView];
            point.coordinate = CLLocationCoordinate2DMake(0, 0);
            point.annotationID = i;
            [_mapView.mapViewShare.mapView addAnnotation:point];
            [_arrayAnnotations addObject:point];
            
            [self setAnnotationViewVisable:NO andCount:10];
        }
    }
    //更新
    int count = [mapPoiDatas count];
    [self setAnnotationViewVisable:YES andCount:count];
    CLLocationCoordinate2D points[count];
    for (int i=0; i< count; i++) {
        MapPoiData*  temp = [mapPoiDatas objectAtIndex:i];
        NIPointAnnotation *point = [_arrayAnnotations objectAtIndex:temp.mID];
        point.coordinate = temp.coordinate;
        point.title = temp.mName;
        point.subtitle = temp.mAddress;
        [_mapView.mapViewShare.mapView updateAnnotationPositon:point];
        
        if (match == YES) {
            points[i] = temp.coordinate;
        }
    }
    
    if (match == YES) {
        
        CGRect region = CGRectMake(0, 0, 0, 0);
        if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2)
        {
            region.size.width = [_mapViewBase frame].size.width*2;
            region.size.height = [_mapViewBase frame].size.height*2;
        }else {
            region.size.width = [_mapViewBase frame].size.width;
            region.size.height = [_mapViewBase frame].size.height;
        }
        //合适的地图级别，和中心点。
        CLLocationCoordinate2D center;
        float level = [_mapViewBase.mapViewShare.mapView MatchingPointsInRegion:points andCount:count andRegion:region andOutCenter:&center];
        
        
        //设置地图缩放级别和中心点
        [_mapViewBase.mapViewShare.mapView setMapLevel:level];
        [_mapViewBase.mapViewShare.mapView setCenter:center];
    }
}

/*!
 @method onclickLoad
 @abstract 点击下一页
 @discussion 点击下一页
 @param 无
 @result 无
 */
-(void)onclickLoad
{
    
    if (page - nowPage == 1) {
        [self search];
    }
    else
    {
        nowPage++;
        [searchResultTableView reloadData];
        [self tableViewScrollToTop];
    }
    if ([_mapView.POIData objectForKey:BUBBLE_INFO_KEY])
    {
        [_mapView.POIData removeObjectForKey:BUBBLE_INFO_KEY];
    }
    needMatchingPointsInRegion = YES;

}

/*!
 @method onclickLoadUpBtn
 @abstract 点击上一页
 @discussion 点击上一页
 @param 无
 @result 无
 */
-(void)onclickLoadUpBtn
{
    nowPage--;
    [searchResultTableView reloadData];
    [self tableViewScrollToTop];
    if ([_mapView.POIData objectForKey:BUBBLE_INFO_KEY])
    {
        [_mapView.POIData removeObjectForKey:BUBBLE_INFO_KEY];
    }
    needMatchingPointsInRegion = YES;
}

/*!
 @method tableViewScrollToTop
 @abstract 列表滚动到最上方
 @discussion 列表滚动到最上方
 @param 无
 @result 无
 */
-(void)tableViewScrollToTop
{
    if (cellNum != 0) {
        //滚动最上方
        NSIndexPath *firstRow = [NSIndexPath indexPathForRow:(0) inSection:0];
        [searchResultTableView scrollToRowAtIndexPath:firstRow
                                     atScrollPosition:UITableViewScrollPositionTop
                                             animated:YES];
    }
   
}


/*!
 @method onclickMapOrList
 @abstract 点击地图或列表的操作
 @discussion 点击地图或列表的操作
 @param 无
 @result 无
 */
-(void)onclickMapOrList
{
    Resources *oRes = [Resources getInstance];
    if (rightButtonState==MAP)
    {
        [mapBtn setTitle:[oRes getText:@"map.SearchResultViewController.listButton"] forState:UIControlStateNormal];
        rightButtonState=LIST;
        [self moveMapView];
    }
    else
    {
        [mapBtn setTitle:[oRes getText:@"map.SearchResultViewController.mapButton"] forState:UIControlStateNormal];
        rightButtonState=MAP;
        [self moveMapView];
    }
}



/*!
 @method popself
 @abstract 返回上一页
 @discussion 返回上一页
 @param 无
 @result 无
 */
-(void)popself

{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


/*!
 @method showPOI:(id)searchResultData
 @abstract 显示详情
 @discussion 显示详情
 @param 无
 @result 无
 */
-(void)showPOI:(id)searchResultData
{
    
    POIDetailViewController *poiDetailViewController=[[POIDetailViewController alloc]init];
    poiDetailViewController.searchResultRootController=self;
    if (searchKeyType == SEARCH_TYPE_4S_STORES) {
        [poiDetailViewController setPOI:searchResultData type:POI_TYPE_4S_RESULT];
    }
    else
    {
        [poiDetailViewController setPOI:searchResultData type:POI_TYPE_RESULT];
    }
    
    
    [self.navigationController pushViewController:poiDetailViewController animated:YES];
    [poiDetailViewController release];
}


-(void)moveMapView
{
    if (mapViewState==MAPVIEW_SHOW)
    {
        [self saveMapStatus];
//        [self releasePaopao];
        [self hidePaopao];
        
        [self setAnnotationViewVisable:NO andCount:10];
        
        
        [_mapView viewWillDisappear];
        _mapView.mapViewShare.mapView.delegate = nil;
        [_mapView removeFromSuperview];
        
        searchResultTableView.hidden = NO;
        mapViewState=MAPVIEW_HIDE;
    }
    else
    {
        mapViewState=MAPVIEW_SHOW;
        searchResultTableView.hidden = YES;
        [_mapView viewWillAppear];
        
        if (needMatchingPointsInRegion == NO) {
            if ([_mapView.POIData objectForKey:MAP_STATUS_KEY]) {
                
                NIMapStatus *status = [_mapView.POIData objectForKey:MAP_STATUS_KEY];
                [self setMapStatus:status];
            }
        }
        //设置指南针消失
        [_mapView.mapViewShare.mapView setShowDirection:NO image:nil];
        [_mapView.mapViewShare.mapView setScalePoint:CGPointMake(5.0,10.0)];
        
        _mapView.mapViewShare.mapView.delegate = self;
        _mapView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        [self.view addSubview:_mapView];

    }
}


//先注释掉，此函数用来画大头针
- (void)mapLoadFinish:(NIMapView *)mapView{
    
    [self setPOIWithNeedMatchingPointsInRegion:needMatchingPointsInRegion];
    
    
    if ([_mapView.POIData objectForKey:BUBBLE_INFO_KEY]) {
        MapPoiData *customPOI = [_mapView.POIData objectForKey:BUBBLE_INFO_KEY];
        [self showPaopao:customPOI];
    }
    needMatchingPointsInRegion = NO;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark mapDelegate

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
    
    if (searchKeyType == SEARCH_TYPE_4S_STORES) {
        Search4SResultData *searchResult=[searchResultMutableArray objectAtIndex:((nowPage - 1)*10 + poiData.mID)];
        
        [self showPOI:searchResult];
    }
    else
    {
        SearchResultData *searchResult=[searchResultMutableArray objectAtIndex:((nowPage - 1)*10 + poiData.mID)];
        
        [self showPOI:searchResult];
    }
    
}

#pragma mark -
#pragma mark Table View Data Source Methods

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    if (searchResultMutableArray.count > 0) {
        searchResultTableView.sectionFooterHeight = 0;
    }
    if (searchResultMutableArray.count==0) {
        footerView.hidden = NO;
        footerLabel.hidden=NO;
    }
    else
    {
        footerView.hidden = YES;
        footerLabel.hidden=YES;
    }
    if([searchResultMutableArray count]==0)
    {
        cellNum = 0;
    }
    else
    {
        if (page - nowPage == 1) {
            int tempNum = [searchResultMutableArray count] % 10;
            if (tempNum ==0) {
                cellNum = 11;
            }
            else
            {
                cellNum = tempNum + 1;
            }
        }
        else
        {
            cellNum = 11;
        }
        
    }
    NSLog(@"%d",cellNum);
    return cellNum;

}

#pragma mark - button action

/*!
 @method tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 @abstract 新建某一行并返回
 @discussion 新建某一行并返回
 @param tableView，indexPath
 @result cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Resources *oRes = [Resources getInstance];
    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             TableSampleIdentifier];
    NSUInteger row = [indexPath row];
    if (row == cellNum - 1)
    {
        if (cell==nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"searchResultPageCell" owner:self options:nil] lastObject];
        }
    }
    else
    {
        if (cell==nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"searchResultCell" owner:self options:nil] lastObject];
        }
    }
    
    if (row == cellNum - 1) {
        UIButton *tabelLoadDownBtn= (UIButton*)[cell viewWithTag:11];
        UIButton *tabelLoadUpBtn= (UIButton*)[cell viewWithTag:12];
       
        [tabelLoadDownBtn setTitle:[oRes getText:@"map.SearchResultViewController.loadDownButton"] forState:UIControlStateNormal];
        [tabelLoadUpBtn setTitle:[oRes getText:@"map.SearchResultViewController.loadUpButton"] forState:UIControlStateNormal];
        tabelLoadDownBtn.titleLabel.font=[UIFont btnTitleSize];
        tabelLoadUpBtn.titleLabel.font=[UIFont btnTitleSize];
        [tabelLoadDownBtn setTitleColor:[UIColor colorWithRed:176.0/255.0 green:176.0/255.0 blue:176.0/255.0 alpha:1] forState:UIControlStateDisabled];
        [tabelLoadDownBtn setTitleColor:[UIColor colorWithRed:97.0/255.0 green:97.0/255.0 blue:97.0/255.0 alpha:1] forState:UIControlStateNormal];
        [tabelLoadDownBtn setBackgroundImage:[UIImage imageNamed:@"map_result_bottom_btn_disabled"] forState:UIControlStateDisabled];
        [tabelLoadDownBtn setBackgroundImage:[UIImage imageNamed:@"map_result_bottom_btn"] forState:UIControlStateNormal];
        
        [tabelLoadUpBtn setTitleColor:[UIColor colorWithRed:176.0/255.0 green:176.0/255.0 blue:176.0/255.0 alpha:1] forState:UIControlStateDisabled];
        [tabelLoadUpBtn setTitleColor:[UIColor colorWithRed:97.0/255.0 green:97.0/255.0 blue:97.0/255.0 alpha:1] forState:UIControlStateNormal];
        [tabelLoadUpBtn setBackgroundImage:[UIImage imageNamed:@"map_result_bottom_btn_disabled"] forState:UIControlStateDisabled];
        [tabelLoadUpBtn setBackgroundImage:[UIImage imageNamed:@"map_result_bottom_btn"] forState:UIControlStateNormal];
        if (page - nowPage == 1)
        {
            if (searchResultMutableArray.count == total) {
                tabelLoadDownBtn.enabled = NO;
                if (nowPage == 1)
                {
                    tabelLoadDownBtn.hidden = YES;
                    tabelLoadUpBtn.hidden = YES;
                }
            }
            else
            {
                tabelLoadDownBtn.enabled = YES;
                [tabelLoadDownBtn addTarget:self action:@selector(onclickLoad) forControlEvents:UIControlEventTouchDown];
            }
        }
        else
        {
            tabelLoadDownBtn.enabled = YES;
            [tabelLoadDownBtn addTarget:self action:@selector(onclickLoad) forControlEvents:UIControlEventTouchDown];
        }
        if (nowPage == 1) {
            
            tabelLoadUpBtn.enabled = NO;
        }
        else
        {
            
            tabelLoadUpBtn.enabled = YES;
            [tabelLoadUpBtn addTarget:self action:@selector(onclickLoadUpBtn) forControlEvents:UIControlEventTouchDown];
        }
        
        
    }
    else
    {
        UIImageView *imageView = (UIImageView *)[cell viewWithTag:1];
        UILabel *name = (UILabel*)[cell viewWithTag:2];
        UILabel *distance = (UILabel*)[cell viewWithTag:3];
        UILabel *explain = (UILabel*)[cell viewWithTag:4];
//        UIImageView *lineImageView = (UIImageView *)[cell viewWithTag:5];
        UILabel *tabelCount = (UILabel*)[cell viewWithTag:6];
        [imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"map_result_ic_%d",row+1]]];
        int nowRow = 10 * (nowPage-1) + row;
        if (searchKeyType == SEARCH_TYPE_4S_STORES)
        {
            Search4SResultData *searchResult=[searchResultMutableArray objectAtIndex:nowRow];
            name.text=searchResult.mName;
            //        if (row == cellNum - 2) {
            //            lineImageView.hidden = YES;
            //        }
            if (searchResult.mDistance == nil || [searchResult.mDistance integerValue]==0) {
                NSString *text=[[NSString alloc]initWithFormat:@"%@",m];
                distance.text=text;
                [text release];
            }
            else
            {
                NSString *text;
                if ([searchResult.mDistance intValue]>=1000) {
                    float space=round([searchResult.mDistance floatValue]/100)/10;
                    text=[[NSString alloc]initWithFormat:@"%0.1f%@",space,km];
                }
                else
                {
                    text=[[NSString alloc]initWithFormat:@"%d%@",[searchResult.mDistance integerValue],m];
                }
                distance.text=text;
                [text release];
            }
            explain.text=searchResult.mAddress;
        }
        else
        {
            SearchResultData *searchResult=[searchResultMutableArray objectAtIndex:nowRow];
            name.text=searchResult.mName;
            //        if (row == cellNum - 2) {
            //            lineImageView.hidden = YES;
            //        }
            if (searchResult.mDistance == nil || [searchResult.mDistance integerValue]==0) {
                NSString *text=[[NSString alloc]initWithFormat:@"%@",m];
                distance.text=text;
                [text release];
            }
            else
            {
                NSString *text;
                if ([searchResult.mDistance intValue]>=1000) {
                    float space=round([searchResult.mDistance floatValue]/100)/10;
                    text=[[NSString alloc]initWithFormat:@"%0.1f%@",space,km];
                }
                else
                {
                    text=[[NSString alloc]initWithFormat:@"%d%@",[searchResult.mDistance integerValue],m];
                }
                distance.text=text;
                [text release];
            }
            explain.text=searchResult.mAddress;
        }
        
        name.font=[UIFont size14_5];
        distance.font=[UIFont size10];
        explain.font=[UIFont size12];
        tabelCount.font=[UIFont size9];
    }
    
	return cell;
}


/*!
 @method tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
 @abstract 设置Footer的高度，和footerView
 @discussion 设置Footer的高度，和footerView
 @param tableView，section
 @result view
 */
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if ([searchResultMutableArray count]==0) {
        searchResultTableView.sectionFooterHeight = 36;
    }
    else
    {
        searchResultTableView.sectionFooterHeight = 0;
    }
    return footerView;
}

/*!
 @method tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
 @abstract 设置行高
 @discussion 设置行高
 @param tableView，indexPath
 @result view
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    if (row ==  (cellNum - 1)) {
        return 51;
    }
    else
    {
        return 62;
    }
}

/*!
 @method tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 @abstract 选择某行
 @discussion 选择某行
 @param tableView，indexPath
 @result 无
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    if (row != (cellNum - 1)) {
        
        if (searchKeyType == SEARCH_TYPE_4S_STORES) {
            Search4SResultData *searchResult=[searchResultMutableArray objectAtIndex:10 * (nowPage-1) + row];
            
            [self showPOI:searchResult];
        }
        else
        {
            SearchResultData *searchResult=[searchResultMutableArray objectAtIndex:10 * (nowPage-1) + row];
            
            [self showPOI:searchResult];
        }
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
}

/*!
 @method tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 @abstract 设置列表不可编辑
 @discussion 设置列表不可编辑
 @param tableView，indexPath
 @result bool
 */
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
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


/**
#pragma 复写父类方法，为了改变泡泡位置
- (NIAnnotationView *)mapView:(NIMapView *)mapView viewForAnnotation:(id <NIAnnotation>)annotation
{
    
    if ([annotation isKindOfClass:[SearchPoiAnnotation class]] )
    {
        //add by wangcheng3
        
        //此annotationID需要从0开始 0-9
        if(_arrayAnnotationViews == nil){
            _arrayAnnotationViews = [[NSMutableArray alloc]init];
            for (int i = 0; i< 10; i++) {
                NSString *AnnotationViewID = [NSString stringWithFormat:@"searchResultPoint%d",i];
                NIAnnotationView* v = [[NIAnnotationView alloc] initWithNIMapView:mapView reuseIdentifier:AnnotationViewID];
                v.priority = 3+i;
                v.image = [UIImage imageNamed:[NSString stringWithFormat:@"map_result_map_ic_%d",i+1]];
                v.anchor = NIAnchorMake(0.5f, 1.0f);
                [_arrayAnnotationViews addObject:v];
            }
        }
        NIAnnotationView* viewPoint  = nil;
        if (_arrayAnnotationViews != nil && [_arrayAnnotationViews count] > annotation.annotationID) {
            viewPoint = [_arrayAnnotationViews objectAtIndex:annotation.annotationID];
        }
        return viewPoint;
    }
    else if ([annotation isKindOfClass:[NIActionPaopaoAnnotation class]] ) {
        
        NSString *AnnotationViewID = @"paopaoMark";
        if (viewPaopao == nil) {
            
            viewPaopao = [[NIActionPaopaoView alloc] initWithNIMapView:mapView reuseIdentifier:AnnotationViewID];
            UIImage *imageNormal;
            
            if([App getVersion]<=IOS_VER_5)
            {
                imageNormal = [[UIImage imageNamed:@"icon_paopao_middle_left.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0,18,0,15)];
            }
            else
            {
                imageNormal = [[UIImage imageNamed:@"icon_paopao_middle_left.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0,10,0,8)resizingMode:UIImageResizingModeStretch];
            }
            NSLog(@"%f",imageNormal.size.height);
            UIImageView *leftBgd = [[UIImageView alloc]initWithImage:imageNormal];
            
            
            if([App getVersion]<=IOS_VER_5)
            {
                imageNormal = [[UIImage imageNamed:@"icon_paopao_middle_right.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0,12,0,20)];
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
            [viewPaopao setAnchor:NIAnchorMake(0.5f,MAP_DEFAULT_PAOPAO_HIGHT)];
            
            viewPaopao.priority = 2;
            viewPaopao.image = [self getImageFromView:viewForImage];
            NSLog(@"%f",viewPaopao.image.size.height);
        }
        
        return viewPaopao;
        
    }
    
    
    return nil;
}


// 当点击annotation view时，调用此接口
- (void)mapView:(NIMapView *)mapView onClickedAnnotation:(id <NIAnnotation>)annotation
{
    //先隐藏已有气泡
    [self releasePaopao];
    
    if (ppAnnotation == nil)
    {
        ppAnnotation = [[NIActionPaopaoAnnotation alloc]initWithMapView:_mapView.mapViewShare.mapView];
    }
    
    
    NIMapStatus *ptemp = [[NIMapStatus alloc]init];
    ptemp.fLevel = _mapView.mapViewShare.mapView.mapStatus.fLevel;
    ptemp.targetGeoPt = [annotation coordinate];
    ptemp.fRotation = _mapView.mapViewShare.mapView.mapStatus.fRotation;
    //动画移动到中心点
    [_mapView.mapViewShare.mapView setMapStatus:ptemp withAnimation:YES];
    [ptemp release];
    
    ppAnnotation.annotationID = annotation.annotationID;
    ppAnnotation.title = annotation.title;
    ppAnnotation.subtitle =annotation.subtitle;
    ppAnnotation.coordinate = [annotation coordinate];
    [_mapView.mapViewShare.mapView addAnnotation:ppAnnotation];
    
    
    //data
    if ([_mapView.POIData objectForKey:BUBBLE_INFO_KEY])
    {
        [_mapView.POIData removeObjectForKey:BUBBLE_INFO_KEY];
    }
    
    MapPoiData* tempData = [[MapPoiData alloc]init];
    tempData.mID = annotation.annotationID;
    tempData.coordinate = [annotation coordinate];
    tempData.mName = annotation.title;
    tempData.mAddress = annotation.subtitle;
    
    [_mapView.POIData setObject:tempData forKey:BUBBLE_INFO_KEY];
    [tempData release];
    
}



//移除气泡
-(void)releasePaopao{
    if (ppAnnotation != nil)
    {
        [_mapView.mapViewShare.mapView removeAnnotation:ppAnnotation];
        [ppAnnotation release];
        ppAnnotation=nil;
        //add by wangcheng
        [viewPaopao release];
        viewPaopao = nil;
    }
}


//弹出泡泡
-(void)showBubble:(MapPoiData *)bubbleInfo
{
    if (ppAnnotation == nil)
    {
        ppAnnotation = [[NIActionPaopaoAnnotation alloc]initWithMapView:_mapView.mapViewShare.mapView];
    }
    
    ppAnnotation.annotationID = bubbleInfo.mID;
    ppAnnotation.title = bubbleInfo.mName;
    ppAnnotation.subtitle = bubbleInfo.mAddress;
    ppAnnotation.coordinate = bubbleInfo.coordinate;
    
    [_mapView.mapViewShare.mapView addAnnotation:ppAnnotation];
}


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
 
 **/





#pragma 复写父类方法，为了改变泡泡位置
- (NIAnnotationView *)mapView:(NIMapView *)mapView viewForAnnotation:(id <NIAnnotation>)annotation
{
    NSLog(@"开始执行viewForAnnotation");
    if ([annotation isKindOfClass:[SearchPoiAnnotation class]] )
    {
        //add by wangcheng3
        
        //此annotationID需要从0开始 0-9
        if(_arrayAnnotationViews == nil){
            _arrayAnnotationViews = [[NSMutableArray alloc]init];
            for (int i = 0; i< 10; i++) {
                NSString *AnnotationViewID = [NSString stringWithFormat:@"searchResultPoint%d",i];
                NIAnnotationView* v = [[NIAnnotationView alloc] initWithNIMapView:mapView reuseIdentifier:AnnotationViewID];
                v.priority = 11;
                v.image = [UIImage imageNamed:[NSString stringWithFormat:@"map_result_map_ic_%d",i+1]];
                v.anchor = NIAnchorMake(0.5f, 1.0f);
                [_arrayAnnotationViews addObject:v];
            }
        }
        NIAnnotationView* viewPoint  = nil;
        if (_arrayAnnotationViews != nil && [_arrayAnnotationViews count] > annotation.annotationID) {
            viewPoint = [_arrayAnnotationViews objectAtIndex:annotation.annotationID];
        }
        
        NSAssert(viewPoint.image, @"viewPoint.image must not be nil.");
        NSAssert(viewPoint, @"viewPoint must not be nil.");
        NSLog(@"结束执行viewForAnnotation");
        return viewPoint;
    }
    else if ([annotation isKindOfClass:[NIActionPaopaoAnnotation class]] ) {
        
        NSString *AnnotationViewID = @"paopaoMark";
        
        
        if (viewPaopao == nil) {
            
            viewPaopao = [[NIActionPaopaoView alloc] initWithNIMapView:mapView reuseIdentifier:AnnotationViewID];
            
            //其中30是气泡的偏移量，上为正，下为负
            [viewPaopao setAnchor:NIAnchorMake(0.5f,MAP_DEFAULT_PAOPAO_HIGHT)];
            viewPaopao.priority = 20;
            viewPaopao.image = [self getPaoPaoImage:annotation];
            NSLog(@"%f",viewPaopao.image.size.height);
        }
        NSAssert(viewPaopao.image, @"viewPaopao.image must not be nil.");
        NSAssert(viewPaopao, @"viewPaopao must not be nil.");
        NSLog(@"结束执行viewForAnnotation");
        return viewPaopao;
        
    }
    
    
    NSLog(@"结束执行viewForAnnotation");
    return nil;
}


// 当点击annotation view时，调用此接口
- (void)mapView:(NIMapView *)mapView onClickedAnnotation:(id <NIAnnotation>)annotation
{
    [self showBubble:annotation];
    
    MapPoiData* tempData = [[MapPoiData alloc]init];
    tempData.mID = annotation.annotationID;
    tempData.coordinate = [annotation coordinate];
    tempData.mName = annotation.title;
    tempData.mAddress = annotation.subtitle;
    
    [_mapView.POIData setObject:tempData forKey:BUBBLE_INFO_KEY];
    [tempData release];
    
    
    [_mapView.mapViewShare.mapView setCenter:tempData.coordinate];
    
//    NIMapStatus *ptemp = [[NIMapStatus alloc]init];
//    ptemp.fLevel = _mapView.mapViewShare.mapView.mapStatus.fLevel;
//    ptemp.targetGeoPt = [annotation coordinate];
//    ptemp.fRotation = _mapView.mapViewShare.mapView.mapStatus.fRotation;
//    //动画移动到中心点
//    [_mapView.mapViewShare.mapView setMapStatus:ptemp withAnimation:YES];
//    [ptemp release];
    
}

/**
 *点中底图空白处会回调此接口
 *@param mapview 地图View
 *@param coordinate 空白处坐标点的经纬度
 */
- (void)mapView:(NIMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate{
    [self hidePaopao];
    
    if ([_mapView.POIData objectForKey:BUBBLE_INFO_KEY])
    {
        [_mapView.POIData removeObjectForKey:BUBBLE_INFO_KEY];
    }
}



-(UIImage*)getPaoPaoImage:(id <NIAnnotation>)annotation{
    UIImage *imageNormal;
    
    if([App getVersion] <= IOS_VER_5)
    {
        imageNormal = [[UIImage imageNamed:@"icon_paopao_middle_left.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0,10,0,8)];
    }
    else
    {
        imageNormal = [[UIImage imageNamed:@"icon_paopao_middle_left.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0,10,0,8)resizingMode:UIImageResizingModeStretch];
    }
    NSLog(@"%f",imageNormal.size.height);
    UIImageView *leftBgd = [[UIImageView alloc]initWithImage:imageNormal];
    
    
    if([App getVersion] <= IOS_VER_5)
    {
        imageNormal = [[UIImage imageNamed:@"icon_paopao_middle_right.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0,8,0,10)];
    }
    else
    {
        imageNormal = [[UIImage imageNamed:@"icon_paopao_middle_right.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0,8,0,10)resizingMode:UIImageResizingModeStretch];
    }
    UIImageView *rightBgd = [[UIImageView alloc] initWithImage:imageNormal];
    
    
    //》》》》    mengy
    
    
    NSString* textlable = annotation.subtitle;
    NSString *titleTextlable =annotation.title;
    
    NSInteger textCount =textlable.length;
    NSInteger titleCount = titleTextlable.length;
    CGFloat width = 0;
    
    if (titleCount >= 15) {
        width =15*17;
    }
    else if (titleCount > textCount)
    {
        width =titleCount*17;
    }
    else
    {
        if (textCount>=15) {
            width = (15*15 >= titleCount*17)?15*15:titleCount*17;
        }
        else
        {
            width = (textCount*15 >= titleCount*17)?textCount*15:titleCount*17;
        }
    }
    
    //《《《《      mengy
    
    
    // 》》》》    wangcheng
//    NSString* textlable = annotation.subtitle;
//    CGFloat width = (textlable.length)*15;
    //《《《《      wangcheng
    
    
    UIView *viewForImage = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width,imageNormal.size.height)];
    leftBgd.frame = CGRectMake(0, 0, width/2,imageNormal.size.height);
    rightBgd.frame = CGRectMake(width/2, 0, width/2,imageNormal.size.height);
    [viewForImage addSubview:leftBgd];
    [viewForImage sendSubviewToBack:leftBgd];
    [viewForImage addSubview:rightBgd];
    [viewForImage sendSubviewToBack:rightBgd];
    [leftBgd release];
    [rightBgd release];
//》》》》    mengy
    
    UILabel *title;
    
    if (titleCount > 15 )
    {
        title =[[UILabel alloc]initWithFrame:CGRectMake(15,0,width-20,imageNormal.size.height/2)];
    }
    else
    {
        title =[[UILabel alloc]initWithFrame:CGRectMake(0,0,width,imageNormal.size.height/2)];
    }
    
//《《《《      mengy
    
    //》》》》    wangcheng
//    UILabel *title =[[UILabel alloc]initWithFrame:CGRectMake(0,0,width,imageNormal.size.height/2)];
    //《《《《      wangcheng
    title.textColor = [UIColor blackColor];
    title.backgroundColor=[UIColor clearColor];
    title.font = [UIFont systemFontOfSize:15.0];
    title.text=annotation.title;
    title.textAlignment = NSTextAlignmentCenter;
    [viewForImage addSubview:title];
    [title release];
    
    //》》》》    mengy
//    UILabel *label;
    UILabel *label;
    if (textCount>15)
    {
        label=[[UILabel alloc]initWithFrame:CGRectMake(15,imageNormal.size.height/2-10,width-20,imageNormal.size.height/2)];
    } else {
        label=[[UILabel alloc]initWithFrame:CGRectMake(0,imageNormal.size.height/2-10,width,imageNormal.size.height/2)];
    }
    
    label.text=annotation.subtitle;
    //《《《《      mengy
    
    
    //》》》》    wangcheng
//    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0,imageNormal.size.height/2-10,width,imageNormal.size.height/2)];
    //《《《《      wangcheng
    label.text=annotation.subtitle;
    label.font = [UIFont systemFontOfSize:13.0];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor=[UIColor clearColor];
    [viewForImage addSubview:label];
    [label release];
    return [self getImageFromView:viewForImage];
}

-(void)releasePaopao{
    if (ppAnnotation) {
        [_mapView.mapViewShare.mapView removeAnnotation:ppAnnotation];
        [ppAnnotation release];
        ppAnnotation = nil;
    }
    if (viewPaopao) {
        [viewPaopao release];
        viewPaopao = nil;
    }
}

//隐藏气泡
-(void)hidePaopao{
    if (viewPaopao != nil)
    {
        viewPaopao.visable = NO;
        viewPaopao.enabled = NO;
    }
}


//弹出泡泡
-(void)showBubble:(id <NIAnnotation>)annotation
{
    if (ppAnnotation == nil)
    {
        ppAnnotation = [[NIActionPaopaoAnnotation alloc]initWithMapView:_mapView.mapViewShare.mapView];
        ppAnnotation.annotationID = annotation.annotationID;
        ppAnnotation.title = annotation.title;
        ppAnnotation.subtitle =annotation.subtitle;
        ppAnnotation.coordinate = [annotation coordinate];
        [_mapView.mapViewShare.mapView addAnnotation:ppAnnotation];
        NSLog(@"showBubble -init");
    }
    else{
        NSLog(@"showBubble -update");
        ppAnnotation.annotationID = annotation.annotationID;
        ppAnnotation.title = annotation.title;
        ppAnnotation.subtitle = annotation.subtitle;
        ppAnnotation.coordinate = [annotation coordinate];
        
        viewPaopao.image = [self getPaoPaoImage:ppAnnotation];
        [_mapView.mapViewShare.mapView updateAnnotation:ppAnnotation withAnnotationView:viewPaopao];
        viewPaopao.visable = YES;
        viewPaopao.enabled = YES;
        NSLog(@"viewPaopao.priority>>>>>>>>>>>>%d",viewPaopao.priority);
    }
}


//弹出泡泡
-(void)showPaopao:(MapPoiData *)annotation
{
    if (ppAnnotation == nil)
    {
        ppAnnotation = [[NIActionPaopaoAnnotation alloc]initWithMapView:_mapView.mapViewShare.mapView];
        ppAnnotation.annotationID = annotation.mID;
        ppAnnotation.title = annotation.mName;
        ppAnnotation.subtitle =annotation.mAddress;
        ppAnnotation.coordinate = annotation.coordinate;
        [_mapView.mapViewShare.mapView addAnnotation:ppAnnotation];
        NSLog(@"showBubble -init");
    }
    else{
        NSLog(@"showBubble -update");
        ppAnnotation.annotationID = annotation.mID;
        ppAnnotation.title = annotation.mName;
        ppAnnotation.subtitle =annotation.mAddress;
        ppAnnotation.coordinate = annotation.coordinate;
        
        viewPaopao.image = [self getPaoPaoImage:ppAnnotation];
        [_mapView.mapViewShare.mapView updateAnnotation:ppAnnotation withAnnotationView:viewPaopao];
        viewPaopao.visable = YES;
        viewPaopao.enabled = YES;
        NSLog(@"viewPaopao.priority>>>>>>>>>>>>%d",viewPaopao.priority);
    }
}


-(UIImage *)getImageFromView:(UIView *)view{
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2)
        UIGraphicsBeginImageContextWithOptions(view.bounds.size,NO,2);
    else
        UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    [view release];
    UIGraphicsEndImageContext();
    return image;
}


@end
