/*!
 @header MapTabBarViewController.m
 @abstract 地图Tab类
 @author mengy
 @version 1.00 13-4-24 Creation
 */
#import "MapTabBarViewController.h"
#import "App.h"
#import "SearchResultViewController.h"
#import "SearchViewController.h"
#import "SearchResultViewController.h"
#import "POIDetailViewController.h"
@interface MapTabBarViewController ()
{
    UIBarButtonItem *leftButton;
//    NSMutableArray *array;
    int editType;
    int loginType;
    
}
@end

@implementation MapTabBarViewController
SearchViewController *searchViewController;
SearchResultViewController *searchResultViewController;
POIDetailViewController *poiDetailViewController;
@synthesize keyword;
@synthesize searchType;
@synthesize poiLoadType;
@synthesize mDisView;
@synthesize isFirstInCollect;
@synthesize centralCoord;
@synthesize backBtn;
@synthesize tabBarEnabled;
@synthesize urlDic;
@synthesize circumSearchCentralCoord;
- (id)init
{
    self = [super initWithNibName:@"MapTabBarViewController" bundle:nil];
    if (self)
    {
        
    }
    return self;
}
- (void)dealloc
{
    if (self.progressHUD){
        [self.progressHUD removeFromSuperview];
        [self.progressHUD release];
        self.progressHUD = nil;
    }
    if (fPOIID!=nil) {
        [fPOIID release];
    }
    if (mDisView) {
        [mDisView removeFromSuperview];
        [mDisView release];
    }
    if(searchType)
    {
        [searchType release];
    }
    if (mapController) {
        [mapController removeFromParentViewController];
        [mapController release];
    }
    if (circumController) {
        [circumController removeFromParentViewController];
        [circumController release];
    }
    if (collectController) {
        [collectController removeFromParentViewController];
        [collectController release];
    }
    if (backBtn) {
        [backBtn release];
        backBtn = nil;
    }
    
    if (leftButton) {
        [leftButton release];
        leftButton = nil;
    }
    if (urlDic) {
        [urlDic release];
        urlDic = nil;
    }
    [super dealloc];
}

/*!
 @method viewDidLoad
 @abstract 加载界面信息，数据初始化
 @discussion 加载界面信息，数据初始化
 @param 无
 @result 无
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    tabBarEnabled = YES;
    self.delegate = self;
    self.navigationController.delegate=self;
    self.navigationController.navigationBar.delegate=self;
    if([App getVersion]>=IOS_VER_7){
        [App ios7ViewLocation:self];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_ios7_navBar_bg"] forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_ios6_navBar_bg"] forBarMetrics:UIBarMetricsLandscapePhone];
    }
    mapController = [[MapMainViewController alloc] init];
    collectController = [[CollectViewController alloc] init];
    circumController = [[CircumViewController alloc] init];
    backBtn = [[HomeButton alloc]init];
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    leftButton=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftButton;
    Resources *oRes = [Resources getInstance];
    self.tabBar.backgroundImage=[UIImage imageNamed:@"map_tabBar_bg"];
    
    
    
   
    if([App getVersion]>=IOS_VER_7)
    {
        
        UIImage * normalImage = [[UIImage imageNamed:@"map_tabBarItem_map"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage * selectImage = [[UIImage imageNamed:@"map_tabBarItem_map_selected"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        mapController.tabBarItem = [[UITabBarItem alloc]initWithTitle:[oRes getText:@"map.mapTabBarViewController.mapTabBarItem"] image:normalImage selectedImage:selectImage];
        
        normalImage = [[UIImage imageNamed:@"map_tabBarItem_collect"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        selectImage = [[UIImage imageNamed:@"map_tabBarItem_collect_selected"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        collectController.tabBarItem = [[UITabBarItem alloc]initWithTitle:[oRes getText:@"map.mapTabBarViewController.collectTabBarItem"] image:normalImage selectedImage:selectImage];
        
        normalImage = [[UIImage imageNamed:@"map_tabBarItem_circum"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        selectImage = [[UIImage imageNamed:@"map_tabBarItem_circum_selected"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        circumController.tabBarItem = [[UITabBarItem alloc]initWithTitle:[oRes getText:@"map.mapTabBarViewController.circumTabBarItem"] image:normalImage selectedImage:selectImage];
    }
    else
    {
        mapController.tabBarItem.title=[oRes getText:@"map.mapTabBarViewController.mapTabBarItem"];
        collectController.tabBarItem.title=[oRes getText:@"map.mapTabBarViewController.collectTabBarItem"];
        circumController.tabBarItem.title=[oRes getText:@"map.mapTabBarViewController.circumTabBarItem"];
        
        [mapController.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"map_tabBarItem_map_selected"] withFinishedUnselectedImage:[UIImage imageNamed:@"map_tabBarItem_map"]];
        [collectController.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"map_tabBarItem_collect_selected"] withFinishedUnselectedImage:[UIImage imageNamed:@"map_tabBarItem_collect"]];
        [circumController.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"map_tabBarItem_circum_selected"] withFinishedUnselectedImage:[UIImage imageNamed:@"map_tabBarItem_circum"]];
    }

    
    [mapController.tabBarItem setTitleTextAttributes:@{ UITextAttributeFont : [UIFont size12]}forState:UIControlStateNormal];
    [collectController.tabBarItem setTitleTextAttributes:@{ UITextAttributeFont : [UIFont size12]}forState:UIControlStateNormal];
    [circumController.tabBarItem setTitleTextAttributes:@{ UITextAttributeFont : [UIFont size12]}forState:UIControlStateNormal];
    self.tabBar.tintColor = [UIColor whiteColor];
    self.viewControllers = [NSArray arrayWithObjects:mapController,collectController,circumController,nil];
    if (fPOIID) {
        [fPOIID release];
        fPOIID = nil;
    }
    fPOIID=[[NSString alloc]initWithString:@""];
    isFirstInCollect=1;
    editType=FINISH;
    App *app=[App getInstance];
    mUserData=[app getUserData];
    loginType=mUserData.mType;
    mDisView.hidden=YES;
    [self.view addSubview:mDisView];
//    titleLabel.font =[UIFont navBarTitleSize];
    
    
    mapController.rootController=self;
    collectController.rootController=self;
    circumController.rootController=self;
    circumController.mapViewController=mapController;
    
    //当进入视图时，重新设置imageView
    [self.imageView setImage:nil];
    [self.imageView setFrame:CGRectMake(160, 200, 0, 0)];
    //显示加载等待框
    self.progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.progressHUD];
    [self.view bringSubviewToFront:self.progressHUD];
    self.progressHUD.delegate = self;
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

/*!
 @method goBack
 @abstract 返回上个界面
 @discussion 返回上个界面
 @param 无
 @result 无
 */
- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}


/*!
 @method goCircum:(POIData *)poi
 @abstract 进入周边搜索
 @discussion 进入周边搜索
 @param poi 周边搜索中心点
 @result 无
 */
-(void)goCircum:(POIData *)poi
{
    Resources *oRes = [Resources getInstance];
    
    self.navigationItem.title = [oRes getText:@"map.CircumViewController.title"];
    
    self.navigationItem.rightBarButtonItems=nil;
    [circumController setPOI:poi];
    [self setSelectedIndex:2];
}

/*!
 @method search
 @abstract 搜索
 @discussion 搜索
 @param 无
 @result 无
 */
//-(void)search
//{
//    searchResultViewController = [[SearchResultViewController alloc] init];
//    searchResultViewController.resultRootType=RESULT_ROOT_CIRCUM;
//    searchResultViewController.circumViewRootController=circumController;
//    [searchResultViewController setKeyword:keyword];
//    [searchResultViewController setSearchType:searchType];
//    [searchResultViewController setCentreLocation:centralCoord.latitude lon:centralCoord.longitude];
//    [self.navigationController pushViewController:searchResultViewController animated:YES];
//    [searchResultViewController release];
//}

/*!
 @method goMapMainVCWithMapzoom:(int)mapzoom centralLon:(float)centralLon centralLat:(float)centralLat
 @abstract 搜索到直达词后进入地图主界面
 @discussion 搜索到直达词后进入地图主界面
 @param mapzoom 地图缩放比例
 @param centralLon 中心点经度
 @param centralLat 中心点纬度
 @result 无
 */
-(void)goMapMainVCWithMapzoom:(int)mapzoom centralLon:(float)centralLon centralLat:(float)centralLat
{
    mapController.mapZoom = mapzoom;
    mapController.centralLat = centralLat;
    mapController.centralLon = centralLon;
    mapController.isFromSearch = true;
    [self setSelectedIndex:0];
}

/*!
 @method goSearchWithReault:(NSMutableArray *)mutableArray searchTotal:(int)searchTotal
 @abstract 搜索到结果后跳转到搜索列表界面
 @discussion 搜索到结果后跳转到搜索列表界面
 @param mutableArray 搜索结果列表
 @param searchTotal 搜索总条数
 @result 无
 */
-(void)goSearchWithReault:(NSMutableArray *)mutableArray searchTotal:(int)searchTotal  type:(int)type
{
    searchResultViewController = [[SearchResultViewController alloc] init];
    searchResultViewController.resultRootType=RESULT_ROOT_CIRCUM;
    searchResultViewController.circumViewRootController=circumController;
    [searchResultViewController setKeyword:keyword];
    [searchResultViewController setSearchType:searchType];
    searchResultViewController.searchKeyType = type;
    [searchResultViewController setCentreLocation:centralCoord.latitude lon:centralCoord.longitude];
    searchResultViewController.searchResultMutableArray = [[NSMutableArray alloc] initWithArray:mutableArray];
    searchResultViewController.total = searchTotal;
     
     [self.navigationController pushViewController:searchResultViewController animated:YES];
     [searchResultViewController release];
}

/*!
 @method showPOI:(POIData *)poi
 @abstract 显示poi详情
 @discussion 显示poi详情
 @param poi poi信息
 @result 无
 */
-(void)showPOI:(POIData *)poi
{
    poiDetailViewController=[[POIDetailViewController alloc]init];
    poiDetailViewController.collectViewRootController=collectController;
    poiDetailViewController.mapViewRootController=mapController;
    poiDetailViewController.mapRootController=self;
    [poiDetailViewController setCollectPOI:poi type:POI_TYPE_POI];
    [self.navigationController pushViewController:poiDetailViewController animated:YES];
    [poiDetailViewController release];
    
}

/*!
 @method setfPOIID:(NSString *)POIID
 @abstract 设置自定义位置点id
 @discussion 设置自定义位置点id
 @param POIID id
 @result 无
 */
-(void)setfPOIID:(NSString *)POIID
{
    if (fPOIID) {
        [fPOIID release];
        fPOIID = nil;
    }
    fPOIID=[[NSString alloc]initWithString:POIID];
    NSLog(@"%@",fPOIID);
}

/*!
 @method showCustomPOI:(MapPoiData *)poi type:(int)type
 @abstract 车辆，手机或自定义位置详情
 @discussion 车辆，手机或自定义位置详情
 @param poi poi信息
 @param type 位置类型
 @result 无
 */
-(void)showCustomPOI:(MapPoiData *)poi type:(int)type
{
    poiDetailViewController=[[POIDetailViewController alloc]init];
    poiDetailViewController.collectViewRootController=collectController;
    poiDetailViewController.mapViewRootController=mapController;
    poiDetailViewController.mapRootController=self;
    [poiDetailViewController setfPOIID:fPOIID];
    [poiDetailViewController setCustomPOI:poi type:type];
    
    if (type == POI_TYPE_URL) {
        [poiDetailViewController setPOIPhone:[urlDic objectForKey:@"phone"]];
    }
    [self.navigationController pushViewController:poiDetailViewController animated:YES];
    [poiDetailViewController release];
}

/*!
 @method createBackButton
 @abstract 创建返回按钮
 @discussion 创建返回按钮
 @param 无
 @result UIBarButtonItem
 */
-(UIBarButtonItem*) createBackButton

{
    Resources *oRes = [Resources getInstance];
    [backBtn setTitle:[oRes getText:@"common.BackButtonTitle"] forState:UIControlStateNormal];
    backBtn.contentEdgeInsets = UIEdgeInsetsMake(0,BACKBTN_TEXT_LOCATION, 0, 0);
    backBtn.titleLabel.font=[UIFont navBarItemSize];
    return [[[UIBarButtonItem alloc]initWithCustomView:backBtn]autorelease];
}

/*!
 @method onclickSearch
 @abstract 点击地图上搜索栏进入搜索界面
 @discussion 点击地图上搜索栏进入搜索界面
 @param 无
 @result 无
 */
-(void)onclickSearch
{
    searchViewController =[[SearchViewController alloc]init];
    searchViewController.mapViewRootController=mapController;
    [self.navigationController pushViewController:searchViewController animated:YES];
    [searchViewController release];
}

/*!
 @method setPOILoad:(int)poiLoad
 @abstract 设置收藏夹获取方式，现均未本地获取
 @discussion 设置收藏夹获取方式，现均未本地获取
 @param poiLoad 获取方式
 @result 无
 */
-(void)setPOILoad:(int)poiLoad
{
    poiLoadType=poiLoad;
}

/*!
 @method setIsFirstInCollect:(int)data
 @abstract 设置是否第一次进入收藏夹
 @discussion 设置是否第一次进入收藏夹
 @param data 第几次进入收藏夹
 @result 无
 */
-(void)setIsFirstInCollect:(int)data
{
    isFirstInCollect=data;
    _mainRootViewController.poiLoad=POI_LOAD_NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*!
 @method setPOI:(NSString *)lon lat:(NSString *)lat
 @abstract 设置经纬度
 @discussion 设置经纬度
 @param lon 经度
 @param lat 纬度
 @result 无
 */
//-(void)setPOI:(NSString *)lon lat:(NSString *)lat
//{
////    mlon=[[NSString alloc]initWithString:lon];
////    mlat=[[NSString alloc]initWithString:lat];
//    mlon = lon;
//    mlat = lat;
//}

/*!
 @method setURLDic:(NSMutableDictionary *)urlDic
 @abstract 从短信url中获取的poi信息
 @discussion 从短信url中获取的poi信息
 @param 无
 @result 无
 */
-(void)setURLDic:(NSMutableDictionary *)URLDic
{
    urlDic = [[NSMutableDictionary alloc]initWithDictionary:URLDic];
}

#pragma mark -
#pragma mark UITabBarControllerDelegate
/*!
 @method tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
 @abstract 控制收藏tabBar是否可点
 @discussion 从短信url中获取的poi信息
 @param 无
 @result 无
 */
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if (tabBarEnabled) {
        if (mUserData.mType==USER_LOGIN_OTHER && viewController.tabBarItem==collectController.tabBarItem) {
            Resources *oRes = [Resources getInstance];
            [self MBProgressHUDMessage:[oRes getText:@"map.mapTabBarViewController.accessAlertMessage"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
            return NO;
        }
        else
        {
            return YES;
        }
    }
    else
    {
        return NO;
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

@end
