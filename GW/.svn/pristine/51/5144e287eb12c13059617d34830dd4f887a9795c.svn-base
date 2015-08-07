
/*!
 @header SearchViewController.m
 @abstract 搜索界面
 @author mengy
 @version 1.00 13-4-25 Creation
 */
#import "SearchViewController.h"
#import "SearchResultViewController.h"
#import "App.h"
#import "MapMainViewController.h"
@interface SearchViewController ()
{
    App *app;
    CLLocationCoordinate2D centralCoord;
    UISwipeGestureRecognizer *recognizerUp;
    UISwipeGestureRecognizer *recognizerDown;
    UITapGestureRecognizer *gesture;
    NSMutableArray *searchListMutableArray;
    UIBarButtonItem *leftBtn;
    UIColor *searchBarColor;
}
@end

@implementation SearchViewController
@synthesize mapViewRootController;
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
    NSLog(@"searchView dealloc");
    if (searchBarColor) {
        [searchBarColor release];
    }
    if (leftBtn) {
        [leftBtn release];
    }
    if (backBtn) {
        [backBtn release];
        backBtn = nil;
    }
    if (_searchHistoryMutableArray!=nil) {
        [_searchHistoryMutableArray removeAllObjects];
        [_searchHistoryMutableArray release];
        _searchHistoryMutableArray=nil;
    }
    if (searchListMutableArray!=nil) {
        [searchListMutableArray removeAllObjects];
        [searchListMutableArray release];
        searchListMutableArray=nil;
    }
    if (downBg) {
        [downBg removeFromSuperview];
        [downBg release];
    }
    if (searchHistoryTableView) {
        [searchHistoryTableView removeFromSuperview];
        [searchHistoryTableView release];
    }
    if (searchViewSearchBar) {
        [searchViewSearchBar removeFromSuperview];
        [searchViewSearchBar release];
    }
    
    if (self.progressHUD){
        [self.progressHUD removeFromSuperview];
        [self.progressHUD release];
        self.progressHUD = nil;
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
    [recognizerUp release];
    [recognizerDown release];
    [gesture release];
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
    app=[App getInstance];
    Resources *oRes = [Resources getInstance];
    searchListMutableArray = [[NSMutableArray alloc]initWithCapacity:0];
    self.view.backgroundColor = [UIColor colorWithRed:231.0/255 green:231.0/255 blue:231.0/255 alpha:1];
//    titleLabel.text=[oRes getText:@"map.SearchViewController.Title"];
//    titleLabel.font =[UIFont navBarTitleSize];
//    
//    self.navigationItem.titleView=titleLabel;
    self.navigationItem.title=[oRes getText:@"map.SearchViewController.Title"];
    
    backBtn = [[LeftButton alloc]init];
    [backBtn addTarget:self action:@selector(popself:)forControlEvents:UIControlEventTouchUpInside];
    leftBtn=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftBtn;
//    ios7时留用
    if([App getVersion]>=IOS_VER_7){
        [App ios7ViewLocation:self];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_ios7_navBar_bg"] forBarMetrics:UIBarMetricsDefault];
        searchViewSearchBar.backgroundColor=[UIColor clearColor];
        searchViewSearchBar.placeholder=[oRes getText:@"common.SearchBar.placeholder"];
        UITextField *searchField;
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
            for(UITextField *textField in searchViewSearchBar.subviews)
            {
                if ([textField isKindOfClass:[UITextField class]])
                {
                    textField.font=[UIFont size12];
//                    searchBarColor = [[UIColor alloc] initWithRed:0.45 green:0.45 blue:0.45 alpha:1];
//                    [textField setTextColor:searchBarColor];
                    searchField = textField;
                    break;
                }
            }
            
        }
        
    }
    else
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_ios6_navBar_bg"] forBarMetrics:UIBarMetricsLandscapePhone];
        searchViewSearchBar.backgroundColor=[UIColor clearColor];
        for (UIView *subview in searchViewSearchBar.subviews)
        {
            if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")])
            {
                [subview removeFromSuperview];
                break;
            }
        }
        UITextField *searchField;
        for(UITextField *textField in searchViewSearchBar.subviews)
        {
            if ([textField isKindOfClass:[UITextField class]])
            {
                textField.font=[UIFont size12];
//                searchBarColor = [[UIColor alloc] initWithRed:0.45 green:0.45 blue:0.45 alpha:1];
//                [textField setTextColor:searchBarColor];
                searchField = textField;
                break;
            }
        }
        searchViewSearchBar.placeholder=[oRes getText:@"common.SearchBar.placeholder"];
    }
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
    // Do any additional setup after loading the view from its nib.
}

/*!
 @method viewWillAppear:(BOOL)animated
 @abstract 每次进入界面，加载搜索历史
 @discussion 每次进入界面，加载搜索历史
 @param 无
 @result 无
 */
- (void)viewWillAppear:(BOOL)animated
{
    [searchViewSearchBar becomeFirstResponder];
    [self tableviewReload];
    
    [super viewWillAppear:animated];
}


/*!
 @method tableviewReload
 @abstract 重新加载数据库，更新列表
 @discussion 重新加载数据库，更新列表
 @param 无
 @result 无
 */
-(void)tableviewReload
{
    
    [self loadSearchHistory];
    if (searchViewSearchBar.text.length!=0) {
        [searchListMutableArray removeAllObjects];
        SearchHistoryData *searchHistory;
        for (int i=0; i < self.searchHistoryMutableArray.count; i++) {
            searchHistory = [_searchHistoryMutableArray objectAtIndex:i];
            if ([searchHistory.mSearchName hasPrefix: searchViewSearchBar.text]) {
                [searchListMutableArray addObject:[self.searchHistoryMutableArray objectAtIndex:i]];
            }
        }
        [searchHistoryTableView reloadData];
    }
    else
    {
        [searchListMutableArray removeAllObjects];
        [searchListMutableArray addObjectsFromArray:self.searchHistoryMutableArray];
        [searchHistoryTableView reloadData];
    }
}


/*!
 @method loadSearchHistory
 @abstract 加载搜索历史纪录
 @discussion 加载搜索历史纪录
 @param 无
 @result 无
 */
-(void)loadSearchHistory
{
    //数据库中获取搜索历史
    [self.searchHistoryMutableArray removeAllObjects];
    self.searchHistoryMutableArray=[app loadMeetRequestSearchHistory];
    [searchHistoryTableView reloadData];
}

/*!
 @method popself：
 @abstract 返回上一页
 @discussion 返回上一页
 @param 无
 @result 无
 */
-(IBAction)popself:(id)sender

{
    [self.navigationController popViewControllerAnimated:YES];
}

/*!
 @method getTime
 @abstract 获取本地时间
 @discussion 获取本地时间，格式yyyy-MM-dd HH:mm:ss
 @param 无
 @result time
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


/*!
 @method clearSearchHistory
 @abstract 清除历史记录
 @discussion 清除历史记录
 @param 无
 @result 无
 */
-(void)clearSearchHistory
{
    BOOL result=[app deleteSearchHistory];
    Resources *oRes = [Resources getInstance];
    if (!result) {
        [self MBProgressHUDMessage:[oRes getText:@"set.clearAlert.clearfail"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    [self.searchHistoryMutableArray removeAllObjects];
    [searchListMutableArray removeAllObjects];
    self.searchHistoryMutableArray=[app loadMeetRequestSearchHistory];
    [searchListMutableArray addObjectsFromArray:self.searchHistoryMutableArray];
    [searchHistoryTableView reloadData];
}


/*!
 @method search:(NSString *)searchText
 @abstract 点击搜索显示搜索结果并将搜索纪录写入数据库
 @discussion 点击搜索显示搜索结果并将搜索纪录写入数据库
 @param 无
 @result 无
 */
-(void)search:(NSString *)searchText
{
    //        以手机位置为中心
    
    Resources *oRes = [Resources getInstance];
    
    centralCoord=CLLocationCoordinate2DMake([app.mUserData.mLat doubleValue], [app.mUserData.mLon doubleValue]);
    //将搜索关键字存入数据库中未实现
    [searchResultMutableArray removeAllObjects];
    NSLog(@"%@",searchText);
    NSString *name;
    name=searchText;
    NSString *trimmedString = [name stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *trimmedString2 = [trimmedString avoidSingleQuotesForSqLite];
    if (trimmedString.length!=0) {
        NSString *uuid = [App createUUID];
        [app addSearchHistory:uuid searchName:trimmedString2 createTime:[App getSystemTime]];
        backBtn.enabled=NO;
        mDisView.hidden=NO;
        [self.progressHUD show:YES];
        if ([trimmedString isEqualToString:[oRes getText:@"map.CircumViewController.4sStores"]]) {
            NSDictionary *para;
            NSString *radius = nil;
            radius = [NSString stringWithFormat:@"-1"];
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
            radius = [NSString stringWithFormat:@"-1"];
            para = [NSDictionary dictionaryWithObjectsAndKeys:
                    [NSString stringWithFormat:@"%f",centralCoord.longitude],@"lon",//
                    [NSString stringWithFormat:@"%f",centralCoord.latitude],@"lat",//
                    radius,@"radius",//
                    [NSString stringWithFormat:@"%@",trimmedString],@"keyword",//
                    [NSString stringWithFormat:@"%d",1],@"page",//
                    @"10",@"pagesize",//
                    nil];
            mPOISearchJSONServer = [[NIPOISearchJSONServer alloc]init];
            [mPOISearchJSONServer createRequest:para];
            [mPOISearchJSONServer sendRequestWithAsync:self];
        }
        [self tableviewReload];
    }
    else
    {
        searchViewSearchBar.text=@"";
        [self MBProgressHUDMessage:[oRes getText:@"map.SearchViewController.noKeyWord"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
}

/*!
 @method onSearchResult:(NSMutableDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg
 @abstract 后台poi检索回调函数
 @discussion 后台poi检索回调函数
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
                [self goSearchResultVC:SEARCH_TYPE_ORTHER];
            }
            
        }
        else
        {
            [self goSearchResultVC:SEARCH_TYPE_ORTHER];
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
    
    [self.imageView setFrame:CGRectMake(160, 200, 0, 0)];
    [self.progressHUD hide:YES];
    backBtn.enabled=YES;
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
    [mPOISearch4S release];
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
    [self.imageView setFrame:CGRectMake(160, 200, 0, 0)];
    [self.progressHUD hide:YES];
    backBtn.enabled=YES;
    mDisView.hidden=YES;
}


/*!
 @method goMapMainVCWithMapzoom:(int)mapzoom centralLat:(float)centralLat centralLon:(float)centralLon
 @abstract 检索到城市直达词后，跳转到地图首界面
 @discussion 检索到城市直达词后，跳转到地图首界面
 @param mapzoom 地图缩放比例
 @param centralLon 中心点经度
 @param centralLat 中心点纬度
 @result 无
 */
-(void)goMapMainVCWithMapzoom:(int)mapzoom centralLat:(float)centralLat centralLon:(float)centralLon
{
    mapViewRootController.mapZoom = mapzoom;
    mapViewRootController.centralLat = centralLat;
    mapViewRootController.centralLon = centralLon;
    mapViewRootController.isFromSearch = true;
    [self.navigationController popViewControllerAnimated:YES];
}

/*!
 @method goSearchResultVC:(int)type
 @abstract 进入搜索结果界面
 @discussion 进入搜索结果界面
 @param type 搜索类型 是否为4s店搜索
 @result 无
 */
-(void)goSearchResultVC:(int)type
{
    SearchResultViewController *searchResultViewController = [[SearchResultViewController alloc] init];
    searchResultViewController.searchViewRootController=self;
    searchResultViewController.resultRootType=RESULT_ROOT_SEARCH;
    searchResultViewController.searchKeyType = type;
    [searchResultViewController setKeyword:[[searchViewSearchBar text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    [searchResultViewController setCentreLocation:centralCoord.latitude  lon:centralCoord.longitude];
    searchResultViewController.searchResultMutableArray = [[NSMutableArray alloc] initWithArray:searchResultMutableArray];
    searchResultViewController.total = searchTotal;
    [self.navigationController pushViewController:searchResultViewController animated:YES];
    [searchResultViewController release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*!
 @method backgroundTap:(id)sender
 @abstract 取消搜索框焦点
 @discussion 取消搜索框焦点
 @param 无
 @result 无
 */
-(IBAction)backgroundTap:(id)sender
{
    [searchViewSearchBar resignFirstResponder];
}


#pragma mark -
#pragma mark Search button methods
/*!
 @method searchBarSearchButtonClicked:(UISearchBar *)searchBar
 @abstract 单击搜索按钮，进行搜索
 @discussion 单击搜索按钮，进行搜索
 @param 无
 @result 无
 */
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    NSString *searchText = [NSString stringWithFormat:@"%@",[searchViewSearchBar text]];
    [searchViewSearchBar resignFirstResponder];
    [self search:searchText];
}

/*!
 @method searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
 @abstract 搜索框信息改变时触发，限制搜索框输入最大长度，刷新搜索历史列表
 @discussion 搜索框信息改变时触发，限制搜索框输入最大长度，刷新搜索历史列表
 @param 无
 @result 无
 */
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if([searchText length] == 0)
    {
        [searchViewSearchBar resignFirstResponder];
    }
    if ([searchText length] > 255) {
        searchBar.text = [[searchViewSearchBar text] substringToIndex:255];

    }
    
    if (searchViewSearchBar.text.length!=0) {
        [searchListMutableArray removeAllObjects];
        SearchHistoryData *searchHistory;
        for (int i=0; i < self.searchHistoryMutableArray.count; i++) {
            searchHistory = [_searchHistoryMutableArray objectAtIndex:i];
            if ([searchHistory.mSearchName hasPrefix: searchViewSearchBar.text]) {
                [searchListMutableArray addObject:[self.searchHistoryMutableArray objectAtIndex:i]];
            }
        }
        [searchHistoryTableView reloadData];
    }
    else
    {
        [searchListMutableArray removeAllObjects];
        [searchListMutableArray addObjectsFromArray:self.searchHistoryMutableArray];
        [searchHistoryTableView reloadData];
    }
    
}

/*!
 @method searchBarTextDidBeginEditing:(UISearchBar *)searchBar
 @abstract 搜索框信息改变时触发，限制搜索框输入最大长度，刷新搜索历史列表
 @discussion 搜索框信息改变时触发，限制搜索框输入最大长度，刷新搜索历史列表
 @param 无
 @result 无
 */
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    if (searchViewSearchBar.text.length!=0) {
        [searchListMutableArray removeAllObjects];
        SearchHistoryData *searchHistory;
        for (int i=0; i < self.searchHistoryMutableArray.count; i++) {
            searchHistory = [_searchHistoryMutableArray objectAtIndex:i];
            if ([searchHistory.mSearchName hasPrefix: searchViewSearchBar.text]) {
                [searchListMutableArray addObject:[self.searchHistoryMutableArray objectAtIndex:i]];
            }
        }
        [searchHistoryTableView reloadData];
    }
    else
    {
        [searchListMutableArray removeAllObjects];
        [searchListMutableArray addObjectsFromArray:self.searchHistoryMutableArray];
        [searchHistoryTableView reloadData];
    }
}

#pragma mark -
#pragma mark Table View Data Source Methods
//返回行数
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    if([searchListMutableArray count]==0)
    {
        return [searchListMutableArray count];
    }
    else
    {
        return [searchListMutableArray count]+1;
    }
}


/*!
 @method tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 @abstract 新建某一行并返回
 @discussion 新建某一行并返回
 @param 无
 @result cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    SearchHistoryData *searchHistory;
    static NSString *identifier = @"naviIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"searchcell" owner:self options:nil] lastObject];
    }
    UIView * contentView= (UIView*)[cell viewWithTag:20];
    UIView * clearView= (UIView*)[cell viewWithTag:10];
     UIButton *clearButton= (UIButton*)[cell viewWithTag:11];
    if (row==[searchListMutableArray count]) {
        Resources *oRes = [Resources getInstance];
        clearView.hidden=NO;
        contentView.hidden=YES;
        clearButton.titleLabel.font=[UIFont footerSize];
        [clearButton addTarget:self action:@selector(clearSearchHistory) forControlEvents:UIControlEventTouchDown];
        [clearButton  setTitle:[oRes getText:@"map.SearchViewController.clearHistoryBtnTitle"] forState:UIControlStateNormal];
        
        
    }
    else
    {
        clearView.hidden=YES;
        contentView.hidden=NO;
        searchHistory=[searchListMutableArray objectAtIndex:row];
        UIImageView *image=(UIImageView*)[cell viewWithTag:1];
        UILabel *name = (UILabel*)[cell viewWithTag:2];
        name.text=searchHistory.mSearchName;
        name.font=[UIFont size14_5];
        image.image = [UIImage imageNamed:@"map_searchView_history_ic"];
    }
    return cell;
}

/*!
 @method tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 @abstract 设置列表是否可编辑
 @discussion 设置列表是否可编辑
 @param 无
 @result bool
 */
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

/*!
 @method tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 @abstract 选择某行，进行搜索
 @discussion 选择某行，进行搜索
 @param tableView，indexPath
 @result 无
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    SearchHistoryData *searchHistory;
    searchHistory = [searchListMutableArray objectAtIndex:row];
    searchViewSearchBar.text=searchHistory.mSearchName;
    [searchViewSearchBar resignFirstResponder];
    [self search:searchHistory.mSearchName];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
