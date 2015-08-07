/*!
 @header CircumViewController.m
 @abstract 周边搜索类
 @author mengy
 @version 1.00 13-4-24 Creation
 */
#import "CircumViewController.h"
#import "App.h"
#import "SearchResultViewController.h"
#import "MapTabBarViewController.h"
@interface CircumViewController ()
{
    NSString *searchType;
    int searchTypeCode;
    NSString *searchText;
    NSString *searchKeyword;
    UITapGestureRecognizer *gesture;
    POIData *POI;
    BOOL isSetPOI;
    MapPoiData *mCentralPOI;
    CLLocationCoordinate2D centralCoord;

}
@end

@implementation CircumViewController
SearchResultViewController *searchResultViewController;
@synthesize rootController;
@synthesize mapViewController;
@synthesize centralPOI;
@synthesize picUrlString;
@synthesize progressHUD;
@synthesize searchResultMutableArray;
@synthesize searchTotal;
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
    if (gesture) {
        [gesture release];
        gesture = nil;
    }

    if(tableViewBg)
    {
        [tableViewBg removeFromSuperview];
        [tableViewBg release];
    }
    if(searchViewSearchBar)
    {
        [searchViewSearchBar removeFromSuperview];
        [searchViewSearchBar release];
    }
    if (titleLabel) {
        [titleLabel removeFromSuperview];
        [titleLabel release];
    }
    if(searchTypeTableView)
    {
        [searchTypeTableView removeFromSuperview];
        [searchTypeTableView release];
    }
    if (_searchTypeMutableArray) {
        [_searchTypeMutableArray removeAllObjects];
        [_searchTypeMutableArray release];
        _searchTypeMutableArray=nil;
    }
    
    
    if (_progressHUD){
        [_progressHUD removeFromSuperview];
        [_progressHUD release];
        _progressHUD = nil;
    }
    if (searchResultMutableArray) {
        [searchResultMutableArray removeAllObjects];
        [searchResultMutableArray release];
        searchResultMutableArray = nil;
    }
    if (mDisView) {
        [mDisView removeFromSuperview];
        [mDisView release];
        mDisView = nil;
    }
    [super dealloc];
}

/*!
 @method viewDidLoad
 @abstract 初始化界面信息
 @discussion 初始化界面信息
 @param 无
 @result 无
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    Resources *oRes = [Resources getInstance];
    self.view.backgroundColor = [UIColor colorWithRed:231.0/255 green:231.0/255 blue:231.0/255 alpha:1];
    searchViewSearchBar.backgroundColor=[UIColor clearColor];
    searchViewSearchBar.placeholder=[oRes getText:@"common.SearchBar.placeholder"];
//    ios7时用的代码
    UITextField *searchField;
    if([App getVersion]>=IOS_VER_7){
        [App ios7ViewLocation:self];
        for (UIView *searchBarSubview in [searchViewSearchBar subviews])
        {
            for (UIView *subview in searchBarSubview.subviews)
            {
                if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")])
                {
                    [subview removeFromSuperview];
                    break;
                }
                
            }
            for(UITextField *textField in searchBarSubview.subviews)
            {
                if ([textField isKindOfClass:[UITextField class]])
                {
                    textField.font=[UIFont size14];
                    searchField = textField;
                    break;
                }
            }
        }
        
    }
    else
    {
        for (UIView *subview in searchViewSearchBar.subviews)
        {
            if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")])
            {
                [subview removeFromSuperview];
                break;
            }   
        }
        for(UITextField *textField in searchViewSearchBar.subviews)
        {
            
            if ([textField isKindOfClass:[UITextField class]])
            {
                textField.font=[UIFont size14];
                searchField = textField;
                break;
            }
        }
    }
    //        根据设备屏幕大小判断
    
    enum SCREEN_SIZE   deviceSize = [App getScreenSize];
    if (deviceSize == SCREEN_SIZE_960_640)
    {
        [tableViewBg setFrame:CGRectMake(tableViewBg.frame.origin.x, tableViewBg.frame.origin.y, tableViewBg.frame.size.width, tableViewBg.frame.size.height+80)];
        
        [searchTypeTableView setFrame:CGRectMake(searchTypeTableView.frame.origin.x, searchTypeTableView.frame.origin.y, searchTypeTableView.frame.size.width, searchTypeTableView.frame.size.height+80)];
    }
    [self loadSearchType];
    gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backgroundTap)];
    gesture.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:gesture];
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
    self.progressHUD.labelText = [oRes getText:@"map.SearchResultViewController.loadTitle"];
    self.progressHUD.detailsLabelText = [oRes getText:@"common.load.text"];
    [self.progressHUD hide:YES];
    searchResultMutableArray = [[NSMutableArray alloc] initWithCapacity:0];
    searchTotal = 0;
    searchTypeCode = SEARCH_TYPE_ORTHER;
    // Do any additional setup after loading the view from its nib.
}

/*!
 @method viewWillAppear:
 @abstract 重写viewWillAppear，设置导航栏显示按钮和标题
 @discussion 重写viewWillAppear，设置导航栏显示按钮和标题
 @param 无
 @result 无
 */
- (void)viewWillAppear:(BOOL)animated
{
    Resources *oRes = [Resources getInstance];
//    titleLabel.text=[oRes getText:@"map.CircumViewController.title"];
//    self.tabBarController.navigationItem.titleView=titleLabel;
    self.tabBarController.navigationItem.titleView= nil;
    self.tabBarController.navigationItem.title = [oRes getText:@"map.CircumViewController.title"];
    self.tabBarController.navigationItem.rightBarButtonItems=nil;
    [super viewWillAppear:animated];
}

/*!
 @method setPOI:(POIData *)poi
 @abstract 设置周边搜索中心点
 @discussion 设置周边搜索中心点
 @param poi poi信息
 @result 无
 */
-(void)setPOI:(POIData *)poi
{
    isSetPOI=YES;
    POI=poi;
    mCentralPOI=[[MapPoiData alloc]initWithID:ID_POI_CUSTOM];
    mCentralPOI.coordinate=CLLocationCoordinate2DMake([POI.mLat doubleValue], [POI.mLon doubleValue]);
    centralCoord = CLLocationCoordinate2DMake([POI.mLat doubleValue], [POI.mLon doubleValue]);
    rootController.centralCoord=centralCoord;
    NSLog(@"%@",POI.mName);
    NSLog(@"%@",POI.mLon);
    [mCentralPOI release];
}


/*!
 @method backgroundTap
 @abstract 单击搜索框以为位置搜索栏取消焦点，键盘弹回
 @discussion 单击搜索框以为位置搜索栏取消焦点，键盘弹回
 @param 无
 @result 无
 */
-(void)backgroundTap
{
    [searchViewSearchBar resignFirstResponder];
}

/*!
 @method loadSearchType
 @abstract 加载类型
 @discussion 加载类型
 @param 无
 @result 无
 */
-(void)loadSearchType
{
    Resources *oRes = [Resources getInstance];
    _searchTypeMutableArray =[[NSMutableArray alloc] initWithCapacity:0];
    [_searchTypeMutableArray addObject:[oRes getText:@"map.CircumViewController.repast"]];
    [_searchTypeMutableArray addObject:[oRes getText:@"map.CircumViewController.lodging"]];
    [_searchTypeMutableArray addObject:[oRes getText:@"map.CircumViewController.bank"]];
    [_searchTypeMutableArray addObject:[oRes getText:@"map.CircumViewController.relaxation"]];
    [_searchTypeMutableArray addObject:[oRes getText:@"map.CircumViewController.shopping"]];
    [_searchTypeMutableArray addObject:[oRes getText:@"map.CircumViewController.gasStation"]];
    [_searchTypeMutableArray addObject:[oRes getText:@"map.CircumViewController.4sStores"]];
    [_searchTypeMutableArray addObject:[oRes getText:@"map.CircumViewController.traffic"]];
    [searchTypeTableView reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    _searchTypeMutableArray = nil;
}


/*!
 @method search
 @abstract 点击搜索显示搜索结果并将搜索纪录写入数据库
 @discussion 点击搜索显示搜索结果并将搜索纪录写入数据库
 @param 无
 @result 无
 */
-(void)search
{
    Resources *oRes = [Resources getInstance];
    NSString *trimmedString = [searchText stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (trimmedString.length == 0 && searchType.length == 0) {
        [self MBProgressHUDMessage:[oRes getText:@"map.SearchViewController.noKeyWord"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else
    {

        rootController.keyword=searchText;
        rootController.searchType=searchType;
        if (isSetPOI==NO) {
//            以地图中心点为中心
//            centralCoord=[mapViewController.mapController getCentrePoint];
//            NSLog(@"%f",centralCoord.longitude);
//            以手机位置为中心
//            centralCoord=mapViewController.mapController.CurPosPOI.WGS84Pos;
//            NSLog(@"%f",centralCoord.longitude);
            
            centralCoord=rootController.circumSearchCentralCoord;
            NSLog(@"%f",centralCoord.longitude);
            rootController.centralCoord=centralCoord;
        }
        [searchResultMutableArray removeAllObjects];
        rootController.backBtn.enabled = NO;
        mDisView.hidden=NO;
        [self.progressHUD show:YES];
        if (searchTypeCode == SEARCH_TYPE_4S_STORES) {
            [self addSearchHistory:searchType];
            NSDictionary *para;
            NSString *radius = nil;
            radius = [NSString stringWithFormat:@"1000"];
            para = [NSDictionary dictionaryWithObjectsAndKeys:
                    [NSString stringWithFormat:@"%f",centralCoord.longitude],@"lon",//
                    [NSString stringWithFormat:@"%f",centralCoord.latitude],@"lat",//
                    [NSString stringWithFormat:@"%d",1],@"page",//
                    @"10",@"pagesize",//
                    nil];
            mPOISearch4S = [[NIPOISearch4S alloc]init];
            [mPOISearch4S createRequest:para];
            [mPOISearch4S sendRequestWithAsync:self];
        }
        else if ([trimmedString isEqualToString:[oRes getText:@"map.CircumViewController.4sStores"]])
        {
            searchTypeCode = SEARCH_TYPE_4S_STORES;
            [self addSearchHistory:trimmedString];
            NSDictionary *para;
            NSString *radius = nil;
            radius = [NSString stringWithFormat:@"1000"];
            para = [NSDictionary dictionaryWithObjectsAndKeys:
                    [NSString stringWithFormat:@"%f",centralCoord.longitude],@"lon",//
                    [NSString stringWithFormat:@"%f",centralCoord.latitude],@"lat",//
                    [NSString stringWithFormat:@"%d",1],@"page",//
                    @"10",@"pagesize",//
                    nil];
            mPOISearch4S = [[NIPOISearch4S alloc]init];
            [mPOISearch4S createRequest:para];
            [mPOISearch4S sendRequestWithAsync:self];
        }
        else
        {
            
            NSDictionary *para;
            NSString *radius = nil;
            radius = [NSString stringWithFormat:@"1000"];
            if (searchTypeCode == SEARCH_TYPE_ORTHER) {
                [self addSearchHistory:trimmedString];
                para = [NSDictionary dictionaryWithObjectsAndKeys:
                        [NSString stringWithFormat:@"%f",centralCoord.longitude],@"lon",//
                        [NSString stringWithFormat:@"%f",centralCoord.latitude],@"lat",//
                        radius,@"radius",//
                        [NSString stringWithFormat:@"%@",trimmedString],@"keyword",//
                        [NSString stringWithFormat:@"%d",1],@"page",//
                        @"10",@"pagesize",//
                        nil];
            }
            else
            {
                [self addSearchHistory:searchType];
                
                para = [NSDictionary dictionaryWithObjectsAndKeys:
                        [NSString stringWithFormat:@"%f",centralCoord.longitude],@"lon",//
                        [NSString stringWithFormat:@"%f",centralCoord.latitude],@"lat",//
                        radius,@"radius",//
//                        [NSString stringWithFormat:@"%d",searchTypeCode],@"kind",//
                        [NSString stringWithFormat:@"%@",searchType],@"keyword",//
                        [NSString stringWithFormat:@"%d",1],@"page",//
                        @"10",@"pagesize",//
                        nil];
            }
            mPOISearchJSONServer = [[NIPOISearchJSONServer alloc]init];
            [mPOISearchJSONServer createRequest:para];
            [mPOISearchJSONServer sendRequestWithAsync:self];
        }
        
        
    }
    
}

/*!
 @method addSearchHistory:(NSString *)keyWord
 @abstract 添加搜索历史
 @discussion 添加搜索历史
 @param keyWord 搜索关键字
 @result 无
 */
-(void)addSearchHistory:(NSString *)keyWord
{
    
    App *app=[App getInstance];
    NSString *time=[NSString stringWithFormat:@"%@",[self getTime]];
    NSString * searchWord = [keyWord avoidSingleQuotesForSqLite];
    NSString *uuid = [App createUUID];
    [app addSearchHistory:uuid searchName:searchWord createTime:time];
}

/*!
 @method onSearchResult:(NSMutableDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg
 @abstract 后台poi检索回调函数
 @discussion 后台poi检索回调函数，如果结果为1条数据并且typeCode为AC01、AC02、AC03时判断为直达次，界面跳转至地图主界面并显示当前城市；否则跳转至搜索结果界面
 @param result 返回结果
 @param code 返回码
 @param errorMsg 错误信息
 @result 无
 */
- (void)onSearchResult:(NSMutableDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg
{
    Resources *oRes = [Resources getInstance];
    [mPOISearchJSONServer release];
    if (code == NAVINFO_RESULT_SUCCESS) {
        if ([result objectForKey:@"total"] != nil) {
            searchTotal =[[result objectForKey:@"total"]integerValue];
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
        if (searchResultMutableArray.count == 0) {
            [self MBProgressHUDMessage:[oRes getText:@"map.SearchResultViewController.noResult"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
        }
        else if (searchResultMutableArray.count == 1) {
            SearchResultData *searchResult = [searchResultMutableArray objectAtIndex:0];
            if ([searchResult.mTypeCode isEqualToString:TYPECODE01]) {
                [self MBProgressHUDMessage:[NSString stringWithFormat:@"%@%@",[oRes getText:@"map.SearchResultViewController.cityAlertMessage"],searchResult.mName] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
                [self goMapMainVCWithMapzoom:TYPECODE01_MAPZOOM centralLat:[searchResult.mLat doubleValue] centralLon:[searchResult.mLon doubleValue]];
            }
            else if ([searchResult.mTypeCode isEqualToString:TYPECODE02])
            {
                [self MBProgressHUDMessage:[NSString stringWithFormat:@"%@%@",[oRes getText:@"map.SearchResultViewController.cityAlertMessage"],searchResult.mName] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
                [self goMapMainVCWithMapzoom:TYPECODE02_MAPZOOM centralLat:[searchResult.mLat doubleValue] centralLon:[searchResult.mLon doubleValue]];
            }
            else if ([searchResult.mTypeCode isEqualToString:TYPECODE03])
            {
                [self MBProgressHUDMessage:[NSString stringWithFormat:@"%@%@",[oRes getText:@"map.SearchResultViewController.cityAlertMessage"],searchResult.mName] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
                [self goMapMainVCWithMapzoom:TYPECODE03_MAPZOOM centralLat:[searchResult.mLat doubleValue] centralLon:[searchResult.mLon doubleValue]];
            }
            else
            {
//                [self MBProgressHUDMessage:[oRes getText:@"map.SearchResultViewController.loadSuccess"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
                [self goSearchResultVC:searchTypeCode];
            }
            
        }
        else
        {
//            [self MBProgressHUDMessage:[oRes getText:@"map.SearchResultViewController.loadSuccess"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
            [self goSearchResultVC:searchTypeCode];
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
    rootController.backBtn.enabled = YES;
    mDisView.hidden=YES;
    
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
    if (code == NAVINFO_RESULT_SUCCESS) {
        if ([result objectForKey:@"total"] != nil) {
            searchTotal =[[result objectForKey:@"total"]integerValue];
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
        
        if (searchResultMutableArray.count == 0) {
            [self MBProgressHUDMessage:[oRes getText:@"map.SearchResultViewController.noResult"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
        }
        else
        {
            [self goSearchResultVC:SEARCH_TYPE_4S_STORES];
//            [self MBProgressHUDMessage:[oRes getText:@"map.SearchResultViewController.loadSuccess"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
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
    [mPOISearch4S release];
    [self.imageView setFrame:CGRectMake(160, 200, 0, 0)];
    [self.progressHUD hide:YES];
    rootController.backBtn.enabled = YES;
    mDisView.hidden=YES;
}


/*!
 @method goMapMainVCWithMapzoom:(int)mapzoom centralLat:(float)centralLat centralLon:(float)centralLon
 @abstract 判断为直达词后跳转至地图主界面，并设置缩放比例，中心点经纬度
 @discussion 判断为直达词后跳转至地图主界面，并设置缩放比例，中心点经纬度
 @param mapzoom 地图缩放比例
 @param centralLat 中心点纬度
 @param centralLon 中心点经度
 @result 无
 */
-(void)goMapMainVCWithMapzoom:(int)mapzoom centralLat:(float)centralLat centralLon:(float)centralLon
{
    [rootController goMapMainVCWithMapzoom:mapzoom centralLon:centralLon
                                centralLat:centralLat];
}

/*!
 @method goSearchResultVC:type
 @abstract 搜索结果后，判断为非直达词，跳转到搜索结果列表界面
 @discussion 搜索结果后，判断为非直达词，跳转到搜索结果列表界面
 @param type 搜索类型 是否为4s店
 @result 无
 */
-(void)goSearchResultVC:(int)type
{
    [rootController goSearchWithReault:searchResultMutableArray searchTotal:searchTotal type:type];
}


/*!
 @method getTime
 @abstract 获取本地时间
 @discussion 获取本地时间 格式为yyyy-MM-dd HH:mm:s
 @param 无
 @result time 本地时间
 */
-(NSString *)getTime
{
    NSDate * newDate = [NSDate date];
    NSDateFormatter *dateformat=[[NSDateFormatter alloc] init];
    [dateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * newDateOne = [dateformat stringFromDate:newDate];
    [dateformat setDateStyle:NSDateFormatterFullStyle];
    [dateformat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSLog(@"request start time%@",newDateOne);
    [dateformat release];
    return newDateOne;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Search button methods
/*!
 @method searchBarSearchButtonClicked:(UISearchBar *)searchBar
 @abstract 单击搜索按钮进行搜索
 @discussion 单击搜索按钮进行搜索
 @param 无
 @result 无
 */
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    searchText = [searchViewSearchBar text];
    searchType=@"";
    searchTypeCode = SEARCH_TYPE_ORTHER;
    [searchViewSearchBar resignFirstResponder];
    [self search];
}

/*!
 @method searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchtext
 @abstract 控制搜索栏输入长度
 @discussion 控制搜索栏输入长度
 @param 无
 @result 无
 */
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchtext
{
    if([searchtext length] == 0)
    {

        [searchViewSearchBar resignFirstResponder];
        searchText=@"";
    }
    else
    {
        searchText=searchtext;
    }
    if ([searchText length] > 255) {
        searchBar.text = [[searchViewSearchBar text] substringToIndex:255];
        
    }
}

#pragma mark -
#pragma mark Table View Data Source Methods
//返回行数
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [_searchTypeMutableArray count];
//    return 0;
    
}

#pragma mark - button action

/*!
 @method tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 @abstract 加载分类列表
 @discussion 加载分类列表，新建某一行并返回
 @param 无
 @result cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"naviIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"circumCell" owner:self options:nil] lastObject];
    }
    
    NSUInteger row = [indexPath row];
    UIImageView *image=(UIImageView*)[cell viewWithTag:1];
    UIImageView *lineImage=(UIImageView*)[cell viewWithTag:4];
    UILabel *name = (UILabel*)[cell viewWithTag:2];
    name.text=[_searchTypeMutableArray objectAtIndex:row];
    name.font=[UIFont size14_5];
    switch (row) {
        case 0:
            image.image = [UIImage imageNamed:@"map_circum_repast_ic"];
            break;
        case 1:
            image.image = [UIImage imageNamed:@"map_circum_lodging_ic"];
            break;
        case 2:
            image.image = [UIImage imageNamed:@"map_circum_bank_ic"];
            break;
        case 3:
            image.image = [UIImage imageNamed:@"map_circum_relaxation_ic"];
            break;
        case 4:
            image.image = [UIImage imageNamed:@"map_circum_shopping_ic"];
            break;
        case 5:
            image.image = [UIImage imageNamed:@"map_circum_gasStation_ic"];
            break;
        case 6:
            image.image = [UIImage imageNamed:@"map_circum_4S_ic"];
            break;
        case 7:
        {
            image.image = [UIImage imageNamed:@"map_circum_traffic_ic"];
//            lineImage.hidden =YES;
            break;
        }
        default:
            break;
    }
    return cell;
}

/*!
 @method tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 @abstract 选则列表某行，进行搜索
 @discussion 选则列表某行，进行搜索
 @param indexPath
 @result 无
 */


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    NSString *rowValue = [_searchTypeMutableArray objectAtIndex:row];
    searchText = @"";
    switch (row) {
        case 0:
            searchTypeCode = SEARCH_TYPE_REPAST;
            break;
        case 1:
            searchTypeCode = SEARCH_TYPE_STAY;
            break;
        case 2:
            searchTypeCode = SEARCH_TYPE_BANK;
            break;
        case 3:
            searchTypeCode = SEARCH_TYPE_RELAXATION;
            break;
        case 4:
            searchTypeCode = SEARCH_TYPE_SHOP;
            break;
        case 5:
            searchTypeCode = SEARCH_TYPE_GAS;
            break;
        case 6:
            searchTypeCode = SEARCH_TYPE_4S_STORES;
            break;
        case 7:
            searchTypeCode = SEARCH_TYPE_TRAFFIC;
            break;
        default:
            break;
    }
    searchType=rowValue;
    [searchViewSearchBar resignFirstResponder];
    [self search];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*!
 @method tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 @abstract 设置列表不可编辑
 @discussion 设置列表不可编辑
 @param indexPath
 @result 无
 */
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

#pragma mark -
#pragma mark scroll View Data Source Methods
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    [searchViewSearchBar resignFirstResponder];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [searchViewSearchBar resignFirstResponder];
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

@end
