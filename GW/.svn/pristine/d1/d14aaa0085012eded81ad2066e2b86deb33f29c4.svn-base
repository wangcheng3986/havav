
/*!
 @header POIDetailViewController.m
 @abstract poi详情界面
 @author mengy
 @version 1.00 13-4-27 Creation
 */
#import "POIDetailViewController.h"
#import "App.h"
#import "CircumViewController.h"
#import "POIMapViewController.h"
#import "SendToCarViewViewController.h"
#import "SearchResultData.h"
#import "SearchResultViewController.h"
#import "CollectViewController.h"
#import "MapMainViewController.h"
#import "MapTabBarViewController.h"
@interface POIDetailViewController ()
{
//    SearchResultData *poi;
    SearchResultData *searchResultPoi;
    Search4SResultData *search4sResultPoi;
    POIData *poiData;
    int collectType;
    int mPOIType;//用于判断显示title
    BOOL exist;
    BOOL goSMS;
    BOOL goShowMap;
    BOOL goSendToCar;
    BOOL pop;
    
    MapPoiData *introducePOI;
    MapPoiData *customPOI;
    POIData *mdata;
    int loginType;
    UIBarButtonItem *leftButton;
    UIBarButtonItem *rightButton;
    int poiDetailViewType;
    NSString *poiPhone;
}
@end

@implementation POIDetailViewController
@synthesize data;
@synthesize searchResultRootController;
@synthesize collectViewRootController;
@synthesize mapViewRootController;
@synthesize mapRootController;
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
    NSLog(@"poiDetail dealloc");
    if (mTinyUrlCreate) {
        [mTinyUrlCreate release];
        mTinyUrlCreate = nil;
    }
    if (mDeletePOI) {
        [mDeletePOI clearDelegate];
        [mDeletePOI release];
    }
    if (data != nil) {
        [data release];
    }
    if (customPOI) {
        [customPOI release];
        customPOI=nil;
    }
    if(fPOIID != nil)
    {
        [fPOIID release];
    }
    if (leftButton) {
        [leftButton release];
    }
    if (rightButton) {
        [rightButton release];
    }
    if (poiNameText) {
        [poiNameText removeFromSuperview];
        [poiNameText release];
    }
    if (poiAddressLabel) {
        [poiAddressLabel removeFromSuperview];
        [poiAddressLabel release];
    }
    if (poiAddressText) {
        [poiAddressText removeFromSuperview];
        [poiAddressText release];
    }
    if (poiPhoneLabel) {
        [poiPhoneLabel removeFromSuperview];
        [poiPhoneLabel release];
    }
    if (poiCallButton) {
        [poiCallButton removeFromSuperview];
        [poiCallButton release];
    }
    if (showMapButton) {
        [showMapButton removeFromSuperview];
        [showMapButton release];
    }
    if (searchAroundButton) {
        [searchAroundButton removeFromSuperview];
        [searchAroundButton release];
    }
    if (collectButton) {
        [collectButton removeFromSuperview];
        [collectButton release];
    }
    if (smsButton) {
        [smsButton removeFromSuperview];
        [smsButton release];
    }
    if (sendToCarButton) {
        [sendToCarButton removeFromSuperview];
        [sendToCarButton release];
    }
    if (titleLabel) {
        [titleLabel removeFromSuperview];
        [titleLabel release];
    }
    if (poiCallLabel) {
        [poiCallLabel removeFromSuperview];
        [poiCallLabel release];
    }
    if (showMapLabel) {
        [showMapLabel removeFromSuperview];
        [showMapLabel release];
    }
    if (searchAroundLabel) {
        [searchAroundLabel removeFromSuperview];
        [searchAroundLabel release];
    }
    if (collectLabel) {
        [collectLabel removeFromSuperview];
        [collectLabel release];
    }
    if (smsLabel) {
        [smsLabel removeFromSuperview];
        [smsLabel release];
    }
    if (sendToCarLabel) {
        [sendToCarLabel removeFromSuperview];
        [sendToCarLabel release];
    }
    if (collectImageView) {
        [collectImageView removeFromSuperview];
        [collectImageView release];
    }
    if (interestPointView) {
        [interestPointView removeFromSuperview];
        [interestPointView release];
    }
    if (backBtn) {
        [backBtn removeFromSuperview];
        [backBtn release];
    }
    if (rightBtn) {
        [rightBtn removeFromSuperview];
        [rightBtn release];
    }
    if (locationView) {
        [locationView removeFromSuperview];
        [locationView release];
    }
    if (locationNameText) {
        [locationNameText removeFromSuperview];
        [locationNameText release];
    }
    if (locationAddressLabel) {
        [locationAddressLabel removeFromSuperview];
        [locationAddressLabel release];
    }
    if (locationAddressText) {
        [locationAddressText removeFromSuperview];
        [locationAddressText release];
    }
    if (locationShowMapButton) {
        [locationShowMapButton removeFromSuperview];
        [locationShowMapButton release];
    }
    if (locationSearchAroundButton) {
        [locationSearchAroundButton removeFromSuperview];
        [locationSearchAroundButton release];
    }
    if (locationCollectButton) {
        [locationCollectButton removeFromSuperview];
        [locationCollectButton release];
    }
    if (locationSmsButton) {
        [locationSmsButton removeFromSuperview];
        [locationSmsButton release];
    }
    if (locationSendToCarButton) {
        [locationSendToCarButton removeFromSuperview];
        [locationSendToCarButton release];
    }
    if (locationShowMapLabel) {
        [locationShowMapLabel removeFromSuperview];
        [locationShowMapLabel release];
    }
    if (locationSearchAroundLabel) {
        [locationSearchAroundLabel removeFromSuperview];
        [locationSearchAroundLabel release];
    }
    if (locationCollectLabel) {
        [locationCollectLabel removeFromSuperview];
        [locationCollectLabel release];
    }
    if (locationSmsLabel) {
        [locationSmsLabel removeFromSuperview];
        [locationSmsLabel release];
    }
    if (locationSendToCarLabel) {
        [locationSendToCarLabel removeFromSuperview];
        [locationSendToCarLabel release];
    }
    if (locationCollectImageView) {
        [locationCollectImageView removeFromSuperview];
        [locationCollectImageView release];
    }
    if (smsImageView) {
        [smsImageView removeFromSuperview];
        [smsImageView release];
    }
    if (send2carImageView) {
        [send2carImageView removeFromSuperview];
        [send2carImageView release];
    }
    if (downBgImageView) {
        [downBgImageView removeFromSuperview];
        [downBgImageView release];
    }
    if (downView) {
        [downView removeFromSuperview];
        [downView release];
    }
    if (upBgImageView) {
        [upBgImageView removeFromSuperview];
        [upBgImageView release];
    }
    if (upView) {
        [upView removeFromSuperview];
        [upView release];
    }
    if (showMapImageView) {
        [showMapImageView removeFromSuperview];
        [showMapImageView release];
    }
    if (searchAroundImageView) {
        [searchAroundImageView removeFromSuperview];
        [searchAroundImageView release];
    }
    if (callImageView) {
        [callImageView removeFromSuperview];
        [callImageView release];
    }
    if (line1ImageView) {
        [line1ImageView removeFromSuperview];
        [line1ImageView release];
    }
    if (line2ImageView) {
        [line2ImageView removeFromSuperview];
        [line2ImageView release];
    }
    if (iconImageView) {
        [iconImageView removeFromSuperview];
        [iconImageView release];
    }
    if (locationSmsImageView) {
        [locationSmsImageView removeFromSuperview];
        [locationSmsImageView release];
    }
    if (locationSend2carImageView) {
        [locationSend2carImageView removeFromSuperview];
        [locationSend2carImageView release];
    }
    if (locationDownBgImageView) {
        [locationDownBgImageView removeFromSuperview];
        [locationDownBgImageView release];
    }
    if (locationDownView) {
        [locationDownView removeFromSuperview];
        [locationDownView release];
    }
    if (locationUpBgImageView) {
        [locationUpBgImageView removeFromSuperview];
        [locationUpBgImageView release];
    }
    if (locationUpView) {
        [locationUpView removeFromSuperview];
        [locationUpView release];
    }
    if (locationShowMapImageView) {
        [locationShowMapImageView removeFromSuperview];
        [locationShowMapImageView release];
    }
    if (locationSearchAroundImageView) {
        [locationSearchAroundImageView removeFromSuperview];
        [locationSearchAroundImageView release];
    }
    if (locationIconImageView) {
        [locationIconImageView removeFromSuperview];
        [locationIconImageView release];
    }
    if (locationlineImageView) {
        [locationlineImageView removeFromSuperview];
        [locationlineImageView release];
    }
    if (self.imageView) {
        [self.imageView removeFromSuperview];
        [self.imageView release];
    }
    [super dealloc];
}

/*!
 @method viewDidLoad
 @abstract 加载界面，初始化数据
 @discussion 加载界面，初始化数据
 @param 无
 @result 无
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    Resources *oRes = [Resources getInstance];
    if([App getVersion]>=IOS_VER_7){
        [App ios7ViewLocation:self];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_ios7_navBar_bg"] forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_ios6_navBar_bg"] forBarMetrics:UIBarMetricsLandscapePhone];
    }
    if (!mTinyUrlCreate) {
        mTinyUrlCreate = [[NItinyUrlCreate alloc]init];
    }
    App *app=[App getInstance];
    mUserData=[app getUserData];
    loginType=mUserData.mType;
    data=[[POIData alloc]init];
    [self selectPOIFromDb];
    backBtn = [[LeftButton alloc]init];
    [backBtn addTarget:self action:@selector(popself)forControlEvents:UIControlEventTouchUpInside];
    leftButton=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    
   
    
    
    if (mPOIType==POI_TYPE_CUSTOM||mPOIType==POI_TYPE_CAR||mPOIType==POI_TYPE_PHONE) {
        [self loadLocationView];
        poiDetailViewType = POI_DETAIL_VIEW_CUSTOM;
    }
    else
    {
        if (data.mPhone !=nil && ![data.mPhone isEqualToString:@""]) {
            [self loadInterestPointView];
            poiDetailViewType = POI_DETAIL_VIEW_INTEREST;
        }
        else
        {
            [self loadLocationView];
            poiDetailViewType = POI_DETAIL_VIEW_CUSTOM;
        }
    }
    if(mPOIType != POI_TYPE_RESULT)
    {
        rightBtn = [[RightButton alloc]init];
        [rightBtn setTitle:[oRes getText:@"map.POIDetailViewController.editButton"] forState:UIControlStateNormal];
        [rightBtn addTarget:self action:@selector(showRemarkView) forControlEvents:UIControlEventTouchDown];
        rightButton=[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
        self.navigationItem.rightBarButtonItem = rightButton;
        
        [self InitRemarkView];
    }
    [self loadCollectBtn];
    [self selectTitle];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

/*!
 @method InitRemarkView
 @abstract UI界面设置
 @discussion UI界面设置
 @result 无
 */
-(void)InitRemarkView
{
    Resources *oRes         = [Resources getInstance];
    remarkViewTextField.delegate = self;
    remarkViewTitle.text  = [oRes getText:@"map.POIDetailViewController.remarkViewTitle"];
    remarkViewTitle.textColor = [UIColor blackColor];
    remarkViewTitle.font = [UIFont size14_5];
    
    [remarkViewCancelBtn setTitle:[oRes getText:@"friend.FriendTabBarViewController.remarkAlertCancel"] forState:UIControlStateNormal];
    [remarkViewCancelBtn setTitleColor:[UIColor colorWithRed:236.0/255.0f green:236.0/255.0f blue:236.0/255.0f alpha:1] forState:UIControlStateNormal];
    [remarkViewCancelBtn addTarget:self action:@selector(hiddenRemarkView) forControlEvents:UIControlEventTouchUpInside];
    
    [remarkViewAffirmBtn setTitle:[oRes getText:@"friend.FriendTabBarViewController.remarkAlertAffirm"] forState:UIControlStateNormal];
    [remarkViewAffirmBtn setTitleColor:[UIColor colorWithRed:236.0/255.0f green:236.0/255.0f blue:236.0/255.0f alpha:1] forState:UIControlStateNormal];
    [remarkViewAffirmBtn addTarget:self action:@selector(onClickRemarkViewAffirmBtn) forControlEvents:UIControlEventTouchUpInside];
    //        根据设备屏幕大小判断
    
    enum SCREEN_SIZE   deviceSize = [App getScreenSize];
    if (deviceSize == SCREEN_SIZE_960_640)
    {
        remarkView.frame = CGRectMake(25, 45, remarkView.frame.size.width, remarkView.frame.size.height);
    }
    else
    {
        remarkView.frame = CGRectMake(25, 70, remarkView.frame.size.width, remarkView.frame.size.height);
    }
    mDisView.hidden = YES;
    remarkView.hidden = YES;
    [self.view addSubview:mDisView];
    [self.view addSubview:remarkView];
    
}

/*!
 @method showRemarkView
 @abstract 显示修改poi名称界面
 @discussion 显示修改poi名称界面
 @param 无
 @result 无
 */
-(void)showRemarkView
{
    remarkViewTextField.text = data.mName;
    backBtn.enabled = NO;
    rightBtn.enabled = NO;
    mDisView.hidden = NO;
    remarkView.hidden = NO;
    [remarkViewTextField becomeFirstResponder];
}

/*!
 @method hiddenRemarkView
 @abstract 隐藏修改poi名称界面
 @discussion 隐藏修改poi名称界面
 @param 无
 @result 无
 */
-(void)hiddenRemarkView
{
    [remarkViewTextField resignFirstResponder];
    backBtn.enabled = YES;
    rightBtn.enabled = YES;
    mDisView.hidden = YES;
    remarkView.hidden = YES;
}

/*!
 @method onClickRemarkViewAffirmBtn
 @abstract UI界面设置
 @discussion UI界面设置
 @result 无
 */
-(void)onClickRemarkViewAffirmBtn
{
    
    App *app = [App getInstance];
    Resources *oRes = [Resources getInstance];
    
    NSString *name = [remarkViewTextField.text stringByTrimmingCharactersInSet:
                      [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if(name.length > 40)
    {
        name = [name substringToIndex:40];
    }
    if (name.length == 0)
    {
        //提示需要添加名称
        
        [self MBProgressHUDMessage:[oRes getText:@"map.POIDetailViewController.remarkViewTitle"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
        
        
    }
    else
    {
        switch (data.mFlag)
        {
            case COLLECT_SYNC_YES:
                [app updatePOINameAndFlag:[name avoidSingleQuotesForSqLite] flag:COLLECT_SYNC_NO_UPDATE ID:data.mID fID:data.mfID createTime:[App getTimeSince1970_1000]];
                data.mFlag = COLLECT_SYNC_NO_UPDATE;
                break;
            case COLLECT_SYNC_NO_ADD:
                [app updatePOINameAndFlag:[name avoidSingleQuotesForSqLite] flag:COLLECT_SYNC_NO_ADD ID:data.mID fID:data.mfID createTime:[App getTimeSince1970_1000]];
                data.mFlag = COLLECT_SYNC_NO_ADD;
                break;
            case COLLECT_SYNC_NO_UPDATE:
                [app updatePOINameAndFlag:[name avoidSingleQuotesForSqLite] flag:COLLECT_SYNC_NO_UPDATE ID:data.mID fID:data.mfID createTime:[App getTimeSince1970_1000]];
                data.mFlag = COLLECT_SYNC_NO_UPDATE;
                break;
            default:
                
                break;
        }
        data.mName = name;
        poiNameText.text = name;
        locationNameText.text = name;
        [self hiddenRemarkView];
    }
    
}


/*!
 @method onClickmDisView
 @abstract UI界面设置
 @discussion UI界面设置
 @param sender 事件参数
 @result 无
 */
-(IBAction)onClickmDisView:(id)sender
{
    [self hiddenRemarkView];
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
 @method loadInterestPointView
 @abstract 加载兴趣点详情界面信息
 @discussion 加载兴趣点详情界面信息
 @param 无
 @result 无
 */
-(void)loadInterestPointView
{
    Resources *oRes = [Resources getInstance];
    //加载界面显示信息
    poiCallLabel.text=[oRes getText:@"map.POIDetailViewController.callButton"];
    smsLabel.text=[oRes getText:@"map.POIDetailViewController.smsButton"];
    sendToCarLabel.text=[oRes getText:@"map.POIDetailViewController.sendButton"];
    showMapLabel.text=[oRes getText:@"map.POIDetailViewController.showMapButton"];
    searchAroundLabel.text=[oRes getText:@"map.POIDetailViewController.searchAroundButton"];
    
    poiAddressLabel.text=[oRes getText:@"map.POIDetailViewController.address"];
    [collectButton setImage:[UIImage imageNamed:@"map_poiDetail_down_btn_select"] forState:UIControlStateHighlighted];
    [smsButton setImage:[UIImage imageNamed:@"map_poiDetail_down_btn_select"] forState:UIControlStateHighlighted];
    [sendToCarButton setImage:[UIImage imageNamed:@"map_poiDetail_down_btn_select"] forState:UIControlStateHighlighted];
    
    [collectButton setImage:[UIImage imageNamed:@"map_poiDetail_down_btn"] forState:UIControlStateNormal];
    [smsButton setImage:[UIImage imageNamed:@"map_poiDetail_down_btn"] forState:UIControlStateNormal];
    [sendToCarButton setImage:[UIImage imageNamed:@"map_poiDetail_down_btn"] forState:UIControlStateNormal];
    collectLabel.font = [UIFont btnTitleSize];
    poiCallLabel.font =[UIFont btnTitleSize];
    smsLabel.font =[UIFont btnTitleSize];
    sendToCarLabel.font =[UIFont btnTitleSize];
    showMapLabel.font =[UIFont btnTitleSize];
    searchAroundLabel.font =[UIFont btnTitleSize];
    poiAddressLabel.font =[UIFont size12];
    if ([App getVersion]<=IOS_VER_6) {
        poiAddressLabel.frame =CGRectMake(poiAddressLabel.frame.origin.x, poiAddressLabel.frame.origin.y+1, poiAddressLabel.frame.size.width, poiAddressLabel.frame.size.height);
    }
    [self.view addSubview:interestPointView];
    
    poiNameText.text=data.mName;
    poiAddressText.text=data.mAddress;
    if ([data.mPhone compare:@""
                     options:NSLiteralSearch]==NSOrderedSame||[data.mPhone compare:@"(null)" options:NSLiteralSearch]==NSOrderedSame)
    {
        poiPhoneLabel.text=@"";
    }
    else
    {
        NSString *trimmedPhone = [data.mPhone stringByTrimmingCharactersInSet:
                                  [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        poiPhoneLabel.text=trimmedPhone;
    }
    
    poiNameText.font =[UIFont size14_5];
    poiAddressText.font =[UIFont size12];
    poiPhoneLabel.font =[UIFont size14_5];
    poiAddressText.editable = NO;
    poiNameText.editable=NO;
}

/*!
 @method loadLocationView
 @abstract 加载poi点详情界面
 @discussion 加载poi点详情界面
 @param 无
 @result 无
 */
-(void)loadLocationView
{
    Resources *oRes = [Resources getInstance];
    locationSmsLabel.text=[oRes getText:@"map.POIDetailViewController.smsButton"];
    locationSendToCarLabel.text=[oRes getText:@"map.POIDetailViewController.sendButton"];
    locationShowMapLabel.text=[oRes getText:@"map.POIDetailViewController.showMapButton"];
    locationSearchAroundLabel.text=[oRes getText:@"map.POIDetailViewController.searchAroundButton"];
    locationAddressLabel.text=[oRes getText:@"map.POIDetailViewController.address"];
    [locationCollectButton setImage:[UIImage imageNamed:@"map_poiDetail_down_btn_select"] forState:UIControlStateHighlighted];
    [locationSmsButton setImage:[UIImage imageNamed:@"map_poiDetail_down_btn_select"] forState:UIControlStateHighlighted];
    [locationSendToCarButton setImage:[UIImage imageNamed:@"map_poiDetail_down_btn_select"] forState:UIControlStateHighlighted];
    [locationCollectButton setImage:[UIImage imageNamed:@"map_poiDetail_down_btn"] forState:UIControlStateNormal];
    [locationSmsButton setImage:[UIImage imageNamed:@"map_poiDetail_down_btn"] forState:UIControlStateNormal];
    [locationSendToCarButton setImage:[UIImage imageNamed:@"map_poiDetail_down_btn"] forState:UIControlStateNormal];
    locationCollectLabel.font = [UIFont btnTitleSize];
    locationSmsLabel.font =[UIFont btnTitleSize];
    locationSendToCarLabel.font =[UIFont btnTitleSize];
    locationShowMapLabel.font =[UIFont btnTitleSize];
    locationSearchAroundLabel.font =[UIFont btnTitleSize];
    locationAddressLabel.font =[UIFont size12];
    if ([App getVersion]<=IOS_VER_6) {
        locationAddressLabel.frame =CGRectMake(locationAddressLabel.frame.origin.x, locationAddressLabel.frame.origin.y+1, locationAddressLabel.frame.size.width, locationAddressLabel.frame.size.height);
        
        locationSearchAroundLabel.frame =CGRectMake(locationSearchAroundLabel.frame.origin.x, locationSearchAroundLabel.frame.origin.y+1, locationSearchAroundLabel.frame.size.width, locationSearchAroundLabel.frame.size.height);
        locationShowMapLabel.frame =CGRectMake(locationShowMapLabel.frame.origin.x, locationShowMapLabel.frame.origin.y+1, locationShowMapLabel.frame.size.width, locationShowMapLabel.frame.size.height);
    }
    [self.view addSubview:locationView];
    
    
    locationNameText.text=data.mName;
    locationAddressText.text=data.mAddress;
    locationNameText.font =[UIFont size14_5];
    locationAddressText.font =[UIFont size12];
    locationAddressText.editable = NO;
    locationNameText.editable=NO;
}



/*!
 @method selectTitle
 @abstract 选择标题
 @discussion 选择标题
 @param 无
 @result 无
 */
-(void)selectTitle
{
    Resources *oRes = [Resources getInstance];
    switch (mPOIType) {
        case POI_TYPE_POI:
            self.navigationItem.title=[oRes getText:@"map.POIDetailViewController.POItitle"];
            break;
        case POI_TYPE_RESULT:
            self.navigationItem.title=[oRes getText:@"map.POIDetailViewController.POItitle"];
            break;
        case POI_TYPE_CAR:
            self.navigationItem.title=[oRes getText:@"map.POIDetailViewController.carTitle"];
            break;
        case POI_TYPE_PHONE:
            self.navigationItem.title=[oRes getText:@"map.POIDetailViewController.phoneTitle"];
            break;
        case POI_TYPE_CUSTOM:
            self.navigationItem.title=[oRes getText:@"map.POIDetailViewController.customtitle"];
            break;
        default:
            break;
    }
    //    titleLabel.font =[UIFont navBarTitleSize];
    //    self.navigationItem.titleView=titleLabel;
}

/*!
 @method setPOI:(SearchResultData *)POI
 @abstract 设置poi，从搜索结果传来
 @discussion 设置poi，从搜索结果传来
 @param POI 搜索结果poi
 @result 无
 */
-(void)setPOI:(id)POI type:(int)type
{
    
    mPOIType=type;
    if (mPOIType == POI_TYPE_4S_RESULT) {
        search4sResultPoi = POI;
    }
    else
    {
        searchResultPoi = POI;
    }
}

/*!
 @method setCollectPOI:(POIData *)POI
 @abstract 设置poi，从收藏夹传来
 @discussion 设置poi，从收藏夹传来
 @param POI 收藏夹poi
 @result 无
 */
-(void)setCollectPOI:(POIData *)POI type:(int)type
{
    poiData=POI;
    
    mPOIType=type;
}

/*!
 @method setCustomPOI:(MapPoiData *)POI
 @abstract 设置poi，从收藏夹传来
 @discussion 设置poi，从收藏夹传来
 @param POI 收藏夹poi
 @result 无
 */
-(void)setCustomPOI:(MapPoiData *)POI type:(int)type
{
    introducePOI=POI;
    mPOIType=type;
}


/*!
 @method selectPOIFromDb
 @abstract 从数据库中查找该poi点
 @discussion 从数据库中查找该poi点
 @param 无
 @result 无
 */
-(void)selectPOIFromDb
{
    App *app=[App getInstance];
    //数据库 该POI是否已收藏
    switch (mPOIType) {
        case POI_TYPE_RESULT:
        {
            data.mID=searchResultPoi.mGid;
            data.mfID=@"";
            data.mAddress=searchResultPoi.mAddress;
            data.mDesc= @"";
            data.mCreateTime=[App getSystemTime];
            //data.mFlag=COLLECT_NO_ADD;
            data.mKeyID=@"";
            data.mLat=searchResultPoi.mLat;
            data.mLon=searchResultPoi.mLon;
            data.mName=searchResultPoi.mName;
            data.mPhone=searchResultPoi.mPhone;
            data.mUserID=searchResultPoi.mUserID;
            data.mPostCode = @"";
            [self setCustomPOI];
            break;
        }
        case POI_TYPE_4S_RESULT:
        {
            data.mID=@"";
            data.mfID=@"";
            data.mAddress=search4sResultPoi.mAddress;
            data.mDesc= @"";
            data.mCreateTime=[App getSystemTime];
            //data.mFlag=COLLECT_NO_ADD;
            data.mKeyID=@"";
            data.mLat=search4sResultPoi.mLat;
            data.mLon=search4sResultPoi.mLon;
            data.mName=search4sResultPoi.mName;
            data.mPhone=search4sResultPoi.mtel;
            data.mUserID=@"";
            data.mPostCode = @"";
            [self setCustomPOI];
            break;
        }
        case POI_TYPE_POI:
        {
            data.mID=poiData.mID;
            data.mfID=poiData.mfID;
            data.mAddress=poiData.mAddress;
            data.mDesc=poiData.mDesc;
            data.mCreateTime=poiData.mCreateTime;
            data.mFlag=poiData.mFlag;
            data.mKeyID=poiData.mKeyID;
            data.mLat=poiData.mLat;
            data.mLon=poiData.mLon;
            data.mName=poiData.mName;
            data.mPhone=poiData.mPhone;
            data.mUserID=poiData.mUserID;
            data.mPostCode = poiData.mPostCode;
            [self setCustomPOI];
            break;
        }
        case POI_TYPE_CAR:
        {
            data.mID=@"";
            data.mfID=@"";
            data.mAddress=introducePOI.mAddress;
            data.mCreateTime=[App getSystemTime];
            data.mDesc=@"";
            //data.mFlag=COLLECT_NO_ADD;
            data.mKeyID=@"";
            data.mLat=[NSString stringWithFormat:@"%f",introducePOI.coordinate.latitude];
            data.mLon=[NSString stringWithFormat:@"%f",introducePOI.coordinate.longitude];
            data.mName=introducePOI.mName;
            data.mPhone=@"";
            data.mUserID=@"";
            data.mPostCode = @"";
            [self setCustomPOI];
            break;
        }
        case POI_TYPE_PHONE:
        {
            data.mID=@"";
            data.mfID=@"";
            data.mAddress=introducePOI.mAddress;
            data.mCreateTime=[App getSystemTime];
            data.mDesc=@"";
            //data.mFlag=COLLECT_NO_ADD;
            data.mKeyID=@"";
            data.mLat=[NSString stringWithFormat:@"%f",introducePOI.coordinate.latitude];
            data.mLon=[NSString stringWithFormat:@"%f",introducePOI.coordinate.longitude];
            data.mName=introducePOI.mName;
            data.mPhone=@"";
            data.mUserID=@"";
            data.mPostCode = @"";
            [self setCustomPOI];
            break;
            
        }
        case POI_TYPE_CUSTOM:
        {
            data.mID=@"";
            data.mfID=fPOIID;
            data.mAddress=introducePOI.mAddress;
            data.mCreateTime=[App getSystemTime];
            data.mDesc=@"";
            //data.mFlag=COLLECT_NO_ADD;
            data.mKeyID=@"";
            data.mLat=[NSString stringWithFormat:@"%f",introducePOI.coordinate.latitude];
            data.mLon=[NSString stringWithFormat:@"%f",introducePOI.coordinate.longitude];
            data.mName=introducePOI.mName;
            data.mPhone=@"";
            data.mUserID=@"";
            data.mPostCode = @"";
            [self setCustomPOI];
            break;
        }
        case POI_TYPE_URL:
        {
            data.mID=@"";
            data.mfID=fPOIID;
            data.mAddress=introducePOI.mAddress;
            data.mCreateTime=[App getSystemTime];
            data.mDesc=@"";
            //data.mFlag=COLLECT_NO_ADD;
            data.mKeyID=@"";
            data.mLat=[NSString stringWithFormat:@"%f",introducePOI.coordinate.latitude];
            data.mLon=[NSString stringWithFormat:@"%f",introducePOI.coordinate.longitude];
            data.mName=introducePOI.mName;
            data.mPhone=poiPhone;
            data.mUserID=@"";
            data.mPostCode = @"";
            [self setCustomPOI];
            break;
        }
        default:
        {
            break;
        }
    }
    exist=[app poiExist:data.mLon lat:data.mLat ID:data.mID fID:data.mfID type:mPOIType];
    if (exist==YES)
    {
        [self loadData];
        if (data.mFlag != COLLECT_SYNC_NO_DEL) {
            [self setCollectType:UNCOLLECT];
        }
        else
        {
            [self setCollectType:COLLECT];
        }
    }
    else
    {
        [self setCollectType:COLLECT];
    }
}


/*!
 @method loadData
 @abstract 加载poi信息
 @discussion 加载poi信息
 @param 无
 @result 无
 */
-(void)loadData
{
    App *app=[App getInstance];
//    POIData *tempPoiData = [[POIData alloc]init];
//    POIData *tempPoiData = [app loadMeetRequestPOIData:data.mLon lat:data.mLat];
    POIData *tempPoiData = [app loadPoi:data.mLon lat:data.mLat ID:data.mID fID:data.mfID type:mPOIType];
    data.mID=tempPoiData.mID;
    data.mfID=tempPoiData.mfID;
    data.mAddress=tempPoiData.mAddress;
    data.mCreateTime=tempPoiData.mCreateTime;
    data.mDesc=tempPoiData.mDesc;
    data.mFlag=tempPoiData.mFlag;
    data.mKeyID=tempPoiData.mKeyID;
    data.mLat=tempPoiData.mLat;
    data.mLon=tempPoiData.mLon;
//    data.mName=tempPoiData.mName;
    data.mPhone=tempPoiData.mPhone;
    data.mUserID=tempPoiData.mUserID;
    data.mPostCode = tempPoiData.mPostCode;
}

/*!
 @method setfPOIID:(NSString *)POIID
 @abstract 设置poiid
 @discussion 设置poiid
 @param POIID poiid
 @result 无
 */
-(void)setfPOIID:(NSString *)POIID
{
    fPOIID=[[NSString alloc]initWithString:POIID];
}


/*!
 @method setPOIPhone:(NSString *)phone
 @abstract 设置poi电话
 @discussion 设置poi电话
 @param phone poi电话
 @result 无
 */
-(void)setPOIPhone:(NSString *)phone
{
    poiPhone = [[NSString alloc]initWithString:phone];
}


/*!
 @method setCustomPOI
 @abstract 将poi信息整理成一个MapPoiData类型的poi信息，留地图显示的时候用
 @discussion 将poi信息整理成一个MapPoiData类型的poi信息，留地图显示的时候用
 @param 无
 @result 无
 */
-(void)setCustomPOI
{
    
    if (customPOI != nil) {
        [customPOI release];
        customPOI = nil;
    }
    
    customPOI = [[MapPoiData alloc]initWithID:ID_POI_CUSTOM];
    customPOI.coordinate = CLLocationCoordinate2DMake([data.mLat doubleValue], [data.mLon doubleValue]);
    customPOI.mName = data.mName;
    customPOI.mAddress = data.mAddress;
    
    
    
}


/*!
 @method loadCollectBtn
 @abstract 根据poi状态加载poi收藏按钮
 @discussion 根据poi状态加载poi收藏按钮
 @param 无
 @result 无
 */
-(void)loadCollectBtn
{
    UIImage *img;
    Resources *oRes = [Resources getInstance];
    if (collectType==UNCOLLECT)
    {
        //显示收藏
        img = [UIImage imageNamed:@"map_poiDetail_collect_ic"];
        if(poiDetailViewType == POI_DETAIL_VIEW_CUSTOM)
        {
            [locationCollectImageView setImage:img];
            locationCollectLabel.text=[oRes getText:@"map.POIDetailViewController.uncollectButton"];
        }
        else
        {
            [collectImageView setImage:img];
            collectLabel.text=[oRes getText:@"map.POIDetailViewController.uncollectButton"];
        }
        
    }
    else
    {
        //显示取消收藏
        img = [UIImage imageNamed:@"map_poiDetail_uncollect_ic"];
        if(poiDetailViewType == POI_DETAIL_VIEW_CUSTOM)
        {
            [locationCollectImageView setImage:img];
            locationCollectLabel.text=[oRes getText:@"map.POIDetailViewController.collectButton"];
        }
        else
        {
            [collectImageView setImage:img];
            collectLabel.text=[oRes getText:@"map.POIDetailViewController.collectButton"];
        }
        
    }
}


/*!
 @method setCollectType:(int)collecttype
 @abstract 设置收藏类型
 @discussion 设置收藏类型
 @param collecttype 获取类型
 @result 无
 */
-(void)setCollectType:(int)collecttype
{
    collectType=collecttype;
}


/*!
 @method collect:(id)sender
 @abstract 点击收藏
 @discussion 点击收藏
 @param 无
 @result 无
 */
-(IBAction)collect:(id)sender
{
    Resources *oRes = [Resources getInstance];
    App *app=[App getInstance];
    int flag;
    switch (loginType)
    {
        case USER_LOGIN_OTHER://游客
        {
            [self MBProgressHUDMessage:[oRes getText:@"map.POIDetailViewController.noLoginAlert"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
            break;
        }
        case USER_LOGIN_DEMO://demo
        {
            if (collectType==COLLECT)
            {
                flag=COLLECT_SYNC_NO_ADD;
                NSString *uuid = [App createUUID];
                [app addPOIData:uuid fID:uuid ID:data.mID name:data.mName createTime:[self getTime] lon:data.mLon lat:data.mLat phone:data.mPhone address:data.mAddress desc:data.mDesc flag:flag level:LEVEL_PRIVATE postCode:data.mPostCode ];
                data.mfID=uuid;
                [mapRootController setfPOIID:uuid];
                collectType=UNCOLLECT;
                [self loadCollectBtn];
                [self MBProgressHUDMessage:[oRes getText:@"map.POIDetailViewController.addSuccessAlert"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
            }
            else
            {
                [app deletePOIData:data.mLon lat:data.mLat ID:data.mID fID:data.mfID];
                collectType=COLLECT;
                [self loadCollectBtn];
                [self MBProgressHUDMessage:[oRes getText:@"map.POIDetailViewController.delSuccessAlert"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
            }
            break;
        }
        default:
        {
            if (collectType==COLLECT)
            {
                [self CreatePOI];
            }
            else
            {
                [self DeletePOI];
            }
             break;
        }
           
    }
    
}

/*!
 @method CreatePOI
 @abstract 创建poi
 @discussion 创建poi
 @param 无
 @result 无
 */
- (void)CreatePOI
{
    Resources *oRes = [Resources getInstance];
    App *app=[App getInstance];
    NSString *uuid;
    uuid=[App createUUID];
    [app addPOIData:uuid fID:uuid ID:data.mID name:data.mName createTime:[App getTimeSince1970_1000] lon:data.mLon lat:data.mLat phone:data.mPhone address:data.mAddress desc:data.mDesc flag:COLLECT_SYNC_NO_ADD level:LEVEL_PRIVATE postCode:data.mPostCode];
    data.mFlag= COLLECT_SYNC_NO_ADD;
    data.mfID=uuid;
    collectType=UNCOLLECT;
    [self loadCollectBtn];
    [self MBProgressHUDMessage:[oRes getText:@"map.POIDetailViewController.addSuccessAlert"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
}


/*!
 @method DeletePOI
 @abstract 删除poi
 @discussion 删除poi
 @param 无
 @result 无
 */
- (void)DeletePOI
{
    Resources *oRes = [Resources getInstance];
    App *app=[App getInstance];
//    本地操作代码
    if (data.mFlag==COLLECT_SYNC_NO_ADD) {
        [app deletePOIData:data.mLon lat:data.mLat ID:data.mID fID:data.mfID];
        collectType=COLLECT;
        [self loadCollectBtn];
    }
    else
    {
        [app updateFlag:data.mLon lat:data.mLat flag:COLLECT_SYNC_NO_DEL ID:data.mID fID:data.mfID ];
        data.mFlag=COLLECT_SYNC_NO_DEL;
        collectType=COLLECT;
        [self loadCollectBtn];
    }
    [self MBProgressHUDMessage:[oRes getText:@"map.POIDetailViewController.delSuccessAlert"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
}


/*!
 @method getTime
 @abstract 获取本地时间
 @discussion 获取本地时间，时间格式yyyy-MM-dd HH:mm:ss
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
 @method call:(id)sender
 @abstract 呼叫
 @discussion 呼叫
 @param 无
 @result 无
 */
-(IBAction)call:(id)sender
{
    NSString *callNumber=poiPhoneLabel.text;
    App *app = [App getInstance];
    [app callPhone:callNumber];
    
}


/*!
 @method showMap:(id)sender
 @abstract 将poi显示在地图上
 @discussion 将poi显示在地图上
 @param 无
 @result 无
 */
-(IBAction)showMap:(id)sender
{
    NSAssert(customPOI, @"customPOI == nil");
    goShowMap=YES;
    Resources *oRes = [Resources getInstance];
    POIMapViewController *poiMapViewController=[[POIMapViewController alloc]init];
    poiMapViewController.rootController=self;
    [poiMapViewController setPOI:customPOI];
    poiMapViewController.title=[oRes getText:@"map.POIMapViewController.title"];
    [self.navigationController pushViewController:poiMapViewController animated:YES];
    [poiMapViewController release];
}


/*!
 @method searchAround:(id)sender
 @abstract 周边搜索
 @discussion 周边搜索
 @param 无
 @result 无
 */
-(IBAction)searchAround:(id)sender
{
    NSLog(@"%@",data.mLon);
    [[self.navigationController.viewControllers objectAtIndex:1 ]  goCircum:data];
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1 ] animated:YES];
}


/*!
 @method smsToShare:(id)sender
 @abstract 短信分享
 @discussion 短信分享
 @param 无
 @result 无
 */
-(IBAction)smsToShare:(id)sender
{
    
    if(data.mLat != nil && data.mLon!= nil && [data.mLat floatValue] != 0 && [data.mLon floatValue] != 0 )
    {
        //    使用接口的代码，现在不访问后台
        backBtn.enabled = NO;
        Resources *oRes = [Resources getInstance];
        [self showProgressHUDWithTitle:[oRes getText:@"tinyUrlCreate.title"] andMessage:[oRes getText:@"common.load.text"]];
        //    拼接链接
        NSString *name = @"";
        NSString *locationAddressString = @"";
        NSString *phoneNumber = @"";
        if (poiDetailViewType == POI_DETAIL_VIEW_CUSTOM)
        {
            //            if (data.mID == nil ||[data.mID isEqualToString:@""])
            //            {
            //                name = [oRes getText:@"sms.customPOIName"];
            //            }
            //            else
            //            {
            //                name = locationNameText.text;
            //            }
            name = locationNameText.text;
            if (!locationAddressText.text||[locationAddressText.text isEqualToString:@""]) {
                locationAddressString = [NSString stringWithFormat:@""];
            }
            else
            {
                locationAddressString = [NSString stringWithString:locationAddressText.text];
            }
            phoneNumber = @"";
        }
        else
        {
            //            if (data.mID == nil ||[data.mID isEqualToString:@""])
            //            {
            //                name = [oRes getText:@"sms.customPOIName"];
            //            }
            //            else
            //            {
            //                name = poiNameText.text;
            //            }
            name = poiNameText.text;
            if (!poiAddressText.text||[poiAddressText.text isEqualToString:@""]) {
                locationAddressString = [NSString stringWithFormat:@""];
            }
            else
            {
                locationAddressString = [NSString stringWithString:poiAddressText.text];
            }
            if (!poiPhoneLabel.text||[poiPhoneLabel.text isEqualToString:@""])
            {
                phoneNumber = @"";
            }
            else
            {
                phoneNumber = poiPhoneLabel.text;
            }
        }
        NSString *longMessage=[NSString stringWithFormat:@"%@/online/mobilemap.xhtml?&lon=%@&lat=%@&title=%@&address=%@&phone=%@&time=%@",PORTAL_SERVER_URL,data.mLon,data.mLat,name,locationAddressString,phoneNumber,[App getSystemTime]];
        NSLog(@"%@",longMessage);
        
        [mTinyUrlCreate createRequest:longMessage];
        [mTinyUrlCreate sendRequestWithAsync:self];
        //    [self smsToShareWithURL:nil];
        
    }
    else
    {
        Resources *oRes = [Resources getInstance];
        [self MBProgressHUDMessage:[oRes getText:@"message.common.noShare"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    
}


/*!
 @method onTinyUrlCreateResult:(NSString *)result code:(int)code errorMsg:(NSString *)errorMsg
 @abstract 获取网址的回调函数
 @discussion 获取网址的回调函数
 @param result 返回数据
 @param code 返回码
 @param errorMsg 错误信息
 @result 无
 */
- (void)onTinyUrlCreateResult:(NSString *)result code:(int)code errorMsg:(NSString *)errorMsg
{
    Resources *oRes = [Resources getInstance];
    [self removeProgressHUD];
    if (code == NAVINFO_RESULT_SUCCESS) {
        [self smsToShareWithURL:result];
    }
    else if(code == NET_ERROR)
    {
        //        网络失败提醒
        [self MBProgressHUDMessage:[oRes getText:@"common.noNetAlert.message"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else
    {
        //        获取失败提醒
        [self MBProgressHUDMessage:[oRes getText:@"tinyUrlCreate.failure"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    backBtn.enabled = YES;
}


/*!
 @method smsToShareWithURL:(NSString *)URL
 @abstract 短信分享
 @discussion 短信分享
 @param URL 调用系统短信界面
 @result 无
 */
-(void)smsToShareWithURL:(NSString *)URL
{
    goSMS=YES;
    NSString *SMSBody;
    NSLog(@"%@",URL);
    //    短信格式  POI名称：XX地址，电话XXXXXXXXXXX，查看地图点击：XX连接-[**应用名称]
    Resources *oRes = [Resources getInstance];
    NSString *locationAddressString = nil;
    NSString *name = nil;
    NSString *mUrl = nil;
    if (URL == nil) {
        mUrl = @"";
    }
    else
    {
        mUrl = URL;
    }
    
    if (poiDetailViewType == POI_DETAIL_VIEW_CUSTOM)
    {
        //        if (data.mID == nil ||[data.mID isEqualToString:@""])
        //        {
        //            name = [oRes getText:@"sms.customPOIName"];
        //        }
        //        else
        //        {
        //            name = locationNameText.text;
        //        }
        name = locationNameText.text;
        if (!locationAddressText.text||[locationAddressText.text isEqualToString:@""]) {
            locationAddressString = [NSString stringWithFormat:@""];
        }
        else
        {
            locationAddressString = [NSString stringWithString:locationAddressText.text];
        }
        SMSBody=[[NSString alloc]initWithFormat:@"%@：%@，%@%@%@",name,locationAddressString,[oRes getText:@"message.SendToCarViewController.poiURLmessage"],mUrl,[oRes getText:@"message.SendToCarViewController.poiURLmessage2"]];
    }
    else
    {
        //        if (data.mID == nil ||[data.mID isEqualToString:@""])
        //        {
        //            name = [oRes getText:@"sms.customPOIName"];
        //        }
        //        else
        //        {
        //            name = poiNameText.text;
        //        }
        name = poiNameText.text;
        if (!poiAddressText.text||[poiAddressText.text isEqualToString:@""]) {
            locationAddressString = [NSString stringWithFormat:@""];
        }
        else
        {
            locationAddressString = [NSString stringWithString:poiAddressText.text];
        }
        if ([poiPhoneLabel.text isEqualToString:@""]) {
            SMSBody=[[NSString alloc]initWithFormat:@"%@：%@，%@%@%@",name,locationAddressString,[oRes getText:@"message.SendToCarViewController.poiURLmessage"],mUrl,[oRes getText:@"message.SendToCarViewController.poiURLmessage2"]];
        }
        else
        {
            SMSBody=[[NSString alloc]initWithFormat:@"%@：%@，%@%@，%@%@%@",name,locationAddressString,[oRes getText:@"message.SendToCarViewController.phoneTitle"],poiPhoneLabel.text,[oRes getText:@"message.SendToCarViewController.poiURLmessage"],mUrl,[oRes getText:@"message.SendToCarViewController.poiURLmessage2"]];
        }
    }
    
    App *app = [App getInstance];
    [app sendSMS:SMSBody];
    [SMSBody release];
    
    
}





/*!
 @method sendToCar:(id)sender
 @abstract 发送至车
 @discussion 发送至车
 @param sender
 @result 无
 */
-(IBAction)sendToCar:(id)sender
{
    if(loginType==USER_LOGIN_OTHER)
    {
        Resources *oRes = [Resources getInstance];
        [self MBProgressHUDMessage:[oRes getText:@"map.POIDetailViewController.noLoginAlert"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else
    {
        if(data.mLat != nil && data.mLon!= nil && [data.mLat floatValue] != 0 && [data.mLon floatValue] != 0 )
        {
            
            goSendToCar=YES;
            SendToCarViewViewController *sendToCarViewViewController=[[SendToCarViewViewController alloc]init];
            sendToCarViewViewController.rootController=self;
            [sendToCarViewViewController setPOI:data];
            [self.navigationController pushViewController:sendToCarViewViewController animated:YES];
            [sendToCarViewViewController release];
        }
        else
        {
            Resources *oRes = [Resources getInstance];
            [self MBProgressHUDMessage:[oRes getText:@"message.common.noShare"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
        }
    }
    
}

/*!
 @method showProgressHUDWithTitle:(NSString *)title andMessage:(NSString *)message
 @abstract 显示等待框
 @discussion 显示等待框
 @param title 标题
 @param message 内容
 @result 无
 */
-(void)showProgressHUDWithTitle:(NSString *)title andMessage:(NSString *)message
{
    //当进入视图时，重新设置imageView
    [self.imageView setImage:nil];
    [self.imageView setFrame:CGRectMake(160, 200, 0, 0)];
    //显示加载等待框
    self.progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.progressHUD];
    [self.view bringSubviewToFront:self.progressHUD];
    self.progressHUD.delegate = self;
    self.progressHUD.labelText = title;
    self.progressHUD.detailsLabelText = message;
    [self.progressHUD show:YES];
}

/*!
 @method removeProgressHUD
 @abstract 移除等待框
 @discussion 移除等待框
 @param 无
 @result 无
 */
-(void)removeProgressHUD
{
    //消除等待框
    [self.imageView setFrame:CGRectMake(160, 200, 0, 0)];
    if (self.progressHUD){
        [self.progressHUD removeFromSuperview];
        [self.progressHUD release];
        self.progressHUD = nil;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


#pragma mark set text length
/*!
 @method textField:shouldChangeCharactersInRange:replacementString
 @abstract UI界面设置
 @discussion UI界面设置
 @result 无
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{  //string就是此时输入的那个字符textField就是此时正在输入的那个输入框返回YES就是可以改变输入框的值NO相反
    
    
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    
    if (remarkViewTextField == textField)  //判断是否时我们想要限定的那个输入框
    {
        if ([toBeString length] > 40) { //如果名字输入框内容大于40则弹出警告
            textField.text = [toBeString substringToIndex:40];
            return NO;
        }
    }
    return YES;
}


- (IBAction)textFieldDownEditing:(id)sender
{
    [remarkViewTextField resignFirstResponder];
}

@end
