//
//  SelfDetailViewController.m
//  gratewall
//
//  Created by my on 13-4-25.
//  Copyright (c) 2013年 liutch. All rights reserved.
//

#import "SelfDetailViewController.h"
#import "App.h"
#import "FriendsData.h"
#import "NIOpenUIPHeader.h"
@interface SelfDetailViewController ()
{
    int mSex;
    POIData *poi;
    MapPoiData *carPoi;
    int carPoiCount;
    CarData *mCarData;
    FriendsData *mFriendData;
    
    /*为刷新按钮增加等待框，孟磊 2013年9月5日*/
    MBProgressHUD * progressHUD;
}
@end

@implementation SelfDetailViewController

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
    if (carPoi) {
        [carPoi release];
        carPoi=nil;
    }
    if (mFriendData) {
        [mFriendData release],mFriendData = nil;
    }
    
    [poi release],poi = nil;
    
    /*释放等待框，孟磊 2013年9月5日*/
    [progressHUD release], progressHUD = nil;
    
    
    [mGetLastTrcak release],mGetLastTrcak = nil;
    
    [refreshButton release],refreshButton = nil;
    [photoImageView release],photoImageView = nil;
    [nameLabel release],nameLabel = nil;
    [mMapContext removeFromSuperview];
    [mMapContext release],mMapContext = nil;
   [titleLabel release],titleLabel = nil;
    [backBtn release],backBtn =nil;
    [locationTitleLabel release],locationTitleLabel = nil;
    [phoneTitleLabel release],phoneTitleLabel = nil;
    [locationLabel release],locationLabel = nil;
    [phoneLabel release],phoneLabel = nil;

   
    if (_mapView.POIData) {
        [_mapView.POIData removeAllObjects];
        [_mapView.POIData release];
        _mapView.POIData = nil;
    }
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    mSex=MAN;
    carPoiCount=1;
    
    Resources *oRes = [Resources getInstance];
    App *app = [App getInstance];
    mUserData = [app getUserData];
    [app loadCarData];
    mCarData=[app getCarData];
    
    
    //适配IOS7，替换背景图片
    if([App getVersion]>=IOS_VER_7){
        [App ios7ViewLocation:self];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_ios7_navBar_bg"] forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_ios6_navBar_bg"] forBarMetrics:UIBarMetricsDefault];
    }

    [refreshButton setTitle:[oRes getText:@"friend.FriendTabBarViewController.refresh"] forState:UIControlStateNormal];
    [self selectPhoto];
    [self loadCarData];
    
//    nameLabel.text=[oRes getText:@"friend.FriendList.selfName"];
    nameLabel.text=mFriendData.mfName;
    locationTitleLabel.text=[oRes getText:@"friend.FriendDetailViewController.locationTitleLabelText"];
    locationTitleLabel.textColor = [UIColor colorWithRed:56.0/255.0f green:56.0/255.0f blue:56.0/255.0f alpha:1];
    locationTitleLabel.font = [UIFont size12];
    
    phoneTitleLabel.text=[oRes getText:@"friend.FriendDetailViewController.phoneTitleLabelText"];
    // Do any additional setup after loading the view from its nib.
    /*为刷新按钮增加等待框，孟磊 2013年9月5日*/
    progressHUD = [[MBProgressHUD alloc] initWithView:self.view ];
    progressHUD.tag =  1101;
    [self.view addSubview:progressHUD];
    [self.view bringSubviewToFront:progressHUD];
    progressHUD.delegate = self;
    progressHUD.detailsLabelText  = [oRes getText:@"common.load.text"];
    progressHUD.labelText = [oRes getText:@"friend.FriendTabBarViewController.refreshing"];
    self.navigationItem.title=[oRes getText:@"friend.FriendTabBarViewController.friendDetailTitle"];
    
    backBtn = [[LeftButton alloc]init];
    [backBtn addTarget:self action:@selector(popself)forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:backBtn] autorelease];
    
    self.view.backgroundColor = [UIColor colorWithRed:231.0/255.0f green:231.0/255.0f blue:231.0/255.0f alpha:1];

    
    [self initMapView];
}



/*!
 @method initMapView
 @abstract 初始化MapView
 @discussion 初始化MapView
 @result 无
*/
-(void)initMapView
{
    [self setMapView:_mapView];
    self.LongPressure = NO;
    [self loadMapBaseParameter];
    [_mapView initDataDic];
    //设置指南针消失
    [_mapView.mapViewShare.mapView setShowDirection:NO image:nil];
    if([App getScreenSize] == SCREEN_SIZE_960_640)
    {
        
        [_mapView.mapViewShare.mapView setScalePoint:CGPointMake(5.0, _mapView.frame.size.height-110)];
        
    }
    else
    {
        [_mapView.mapViewShare.mapView setScalePoint:CGPointMake(5.0, _mapView.frame.size.height-65)];
    }
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setPOI];
   
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


-(void) viewWillDisappear:(BOOL)animated
{
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setShadowImage)]) {
        [self.navigationController.navigationBar setShadowImage:[[[UIImage alloc] init] autorelease]];
    }
    [self removeOnePoint];
    [self releasePaopao];
    [super viewWillDisappear:animated];
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}


-(void)setFriendData:(FriendsData *)friendData
{
    App *app = [App getInstance];
    if (friendData) {
        mFriendData = [[app getFriendData:friendData.mfID]retain];
    }
}

/*!
 @method popself
 @abstract 返回按钮方法
 @discussion 返回按钮方法
 @result 无
 */
-(void)popself
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

/*!
 @method setPOI
 @abstract 车辆的位置
 @discussion 车辆的位置
 @result 无
 */
-(void)setPOI
{
    double lon;
    double lat;
    Resources *oRes = [Resources getInstance];
    NIMapStatus *ptemp = [[NIMapStatus alloc]init];
    ptemp.fLevel = MAP_DEFAULT_ZOOM;
    App *app = [App getInstance];
    
    if (mCarData.mLon==nil || mCarData.mLat==nil || [mCarData.mLon isEqualToString:@""] || [mCarData.mLat isEqualToString:@""])
    {
        
        lon = MAP_DEFAULT_LPP_LON;
        lat = MAP_DEFAULT_LPP_LAT;
        //modify by wangqiwei for 无最后时间的时候显示“无” at 2014.6.4<<<<<<<<

        locationLabel.text = [oRes getText:@"friend.FriendDetailViewController.selfNoLocation"];
        locationLabel.textColor = [UIColor colorWithRed:56.0/255.0f green:56.0/255.0f blue:56.0/255.0f alpha:1];
        locationLabel.font = [UIFont size12];
        //modify by wangqiwei for 无最后时间的时候显示“无” at 2014.6.4>>>>>>>>
        
    }
    else
    {
        lon = [mCarData.mLon doubleValue];
        lat = [mCarData.mLat doubleValue];
        if (mCarData.mLastRpTime) {
            locationLabel.text = mCarData.mLastRpTime;
            locationLabel.textColor = [UIColor colorWithRed:56.0/255.0f green:56.0/255.0f blue:56.0/255.0f alpha:1];
            locationLabel.font = [UIFont size12];
            
        }
        carPoi = [[MapPoiData alloc] initWithID:ID_POI_CUSTOM];
        carPoi.coordinate = CLLocationCoordinate2DMake(lat, lon);
        carPoi.mName = [NSString stringWithFormat:@"%@(%@)",[oRes getText:@"friend.FriendDetailViewController.selfLocationTitle"],app.mCarData.mCarNumber];


        [self addOneAnnotation:carPoi];
    }
    ptemp.targetGeoPt = carPoi.coordinate;
    CGPoint target;
    target.x =(_mapView.frame.size.width/2)*2;
    target.y = (_mapView.frame.size.height/2)*2;
    ptemp.targetScreenPt = target;
    
    //动画移动到中心点
    [_mapViewBase.mapViewShare.mapView setMapStatus:ptemp withAnimation:NO];
    [ptemp release];

}
/*!
 @method loadCarData
 @abstract 本地获取车辆信息
 @discussion 本地获取车辆信息
 @result 无
 */
-(void)loadCarData
{
//    本地获取车辆信息

    phoneLabel.text = mFriendData.mfPhone;
    //modify by wangqiwei for IOS7 style at 2014 5 20
    phoneLabel.textColor = [UIColor colorWithRed:56.0/255.0f green:56.0/255.0f blue:56.0/255.0f alpha:1];
    phoneLabel.font = [UIFont size14_5];
}

/*!
 @method selectPhoto
 @abstract 选择照片
 @discussion 选择照片
 @result 无
 */
-(void)selectPhoto
{
    UIImage *img;
    if (mSex==MAN) {
        //img = [UIImage imageNamed:@"common_friend_detail_ic"];
        //modify by wangqiwei for IOS7 at 2014 5 20
        img = [UIImage imageNamed:@"friend_detail_ic"];
        [photoImageView setImage:img];
    }
    else
    {
        //img = [UIImage imageNamed:@"friend_woman_icon"];
        //modify by wangqiwei for IOS7 at 2014 5 20
        img = [UIImage imageNamed:@"friend_detail_ic"];
        [photoImageView setImage:img];
    }
}
/*!
 @method selectPhoto
 @abstract 选择性别
 @discussion 选择性别
 @result 无
 */
-(void)setSex:(int)sex
{
    mSex=sex;
}
/*!
 @method reload
 @abstract 重载数据
 @discussion 重载数据
 @result 无
 */
-(IBAction)reload:(id)sender
{
    App *app = [App getInstance];
    Resources *oRes = [Resources getInstance];
    if (app.mUserData.mType == USER_LOGIN_DEMO)
    {
        NSLog(@"%@",[App getSystemTime]);
//        locationLabel.text = [App getSystemTime];
        locationLabel.textColor = [UIColor colorWithRed:56.0/255.0f green:56.0/255.0f blue:56.0/255.0f alpha:1];
        locationLabel.font = [UIFont size12];
        [self MBProgressHUDMessage:[oRes getText:@"friend.FriendTabBarViewController.refreshSuccessed"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else
    {
        [progressHUD show:YES];
        self.navigationItem.leftBarButtonItem.enabled = NO;
        backBtn.enabled = NO;
        mGetLastTrcak = [[NIGetLastTrack alloc]init];
        [mGetLastTrcak createRequest:mCarData.mVin type:@"vin"];
        [mGetLastTrcak sendRequestWithAsync:self];
    }

}
/*!
 @method onResult:code:errorMsg:
 @abstract 回调函数
 @discussion 回调函数
 @param sender 事件参数
 @param code 错误码
 @param errorMsg 错误信息
 @result 无
 */
- (void)onResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg
{
    NSLog(@"receive the result.");
    NSString *lon;
    NSString *lat;
    NSString *lastRpTime = @"";
    [progressHUD hide:YES];
    
    /*刷新失败后，给出提示，孟磊 2013年9月5日*/
    Resources *oRes = [Resources getInstance];
    
    if (NAVINFO_RESULT_SUCCESS == code)
    {
        if (result)
        {
            NSLog(@"result is :%@", result);
            lon=[result objectForKey:@"lon"];
            lat=[result objectForKey:@"lat"];
            if ([result objectForKey:@"time"]) {
                lastRpTime=[NSString stringWithFormat:@"%@",[result objectForKey:@"time"]];
            }
            NSLog(@"lastRpTime=%@",lastRpTime);
            //NSLog(@"%@",lon);
            if (lon != nil && lat != nil)
            {
                App *app = [App getInstance];
                [self setCarPOI:lon lat:lat];
                if (lastRpTime) {
                    [app updateCarLocation:lon lat:lat lastRpTime:[App getDateWithTimeSince1970:lastRpTime]];
                    if ([App getDateWithTimeSince1970:lastRpTime].length>0)
                    {
                        locationLabel.text = [App getDateWithTimeSince1970:lastRpTime];
                        locationLabel.textColor = [UIColor colorWithRed:56.0/255.0f green:56.0/255.0f blue:56.0/255.0f alpha:1];
                        locationLabel.font = [UIFont size12];
                        
                    }
                }
                else
                {
                    [app updateCarLocation:lon lat:lat lastRpTime:@""];
                }
                [self MBProgressHUDMessage:[oRes getText:@"friend.FriendTabBarViewController.refreshSuccessed"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
                
            }
            else
            {
                [self MBProgressHUDMessage:[oRes getText:@"friend.FriendTabBarViewController.refreshFailed"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
            }
           
        }
        
    }
    else if(NAVINFO_TOKENID_INVALID == code)//TokenID失效处理
    {
        [self MBProgressHUDMessage:[oRes getText:@"common.loseTokenID.message"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];

    }
    else
    { 
        /*刷新失败后，给出提示，孟磊 2013年9月5日*/
        [self MBProgressHUDMessage:[oRes getText:@"friend.FriendTabBarViewController.refreshFailed"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    
    self.navigationItem.leftBarButtonItem.enabled = YES;
    backBtn.enabled = YES;
}
/*!
 @method setCarPOI:code:errorMsg:
 @abstract 设置poi
 @discussion 设置poi
 @param lon 经度
 @param lat 错纬度
 @result 无
 */
-(void)setCarPOI:(NSString *)lon lat:(NSString *)lat
{
    Resources *oRes = [Resources getInstance];
    if (carPoi == nil) {
        
        carPoi = [[MapPoiData alloc] initWithID:ID_POI_CUSTOM];
        carPoi.coordinate = CLLocationCoordinate2DMake([lat doubleValue], [lon doubleValue]);
        carPoi.mName = [oRes getText:@"friend.FriendDetailViewController.selfLocationTitle"];
        [self addOneAnnotation:carPoi];

    }
    else
    {
        [self removeOnePoint];
        [self releasePaopao];
        carPoi.coordinate = CLLocationCoordinate2DMake([lat doubleValue], [lon doubleValue]);
        [self addOneAnnotation:carPoi];
        carPoiCount++;
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
    progressHUDMessage.OffsetFlag = 1;
    progressHUDMessage.mode = MBProgressHUDModeText;
	progressHUDMessage.labelText = message;
	progressHUDMessage.margin = 10.f;
    progressHUDMessage.xOffset = xOffset;
    progressHUDMessage.yOffset = yOffset;
	progressHUDMessage.removeFromSuperViewOnHide = YES;
	[progressHUDMessage hide:YES afterDelay:time];
    
}



#pragma 复写父类方法，为了改变泡泡位置
- (NIAnnotationView *)mapView:(NIMapView *)mapView viewForAnnotation:(id <NIAnnotation>)annotation
{
    if ([annotation isKindOfClass:[NIPointAnnotation class]] )
    {
        NSString *AnnotationViewID = @"pointMark";
        NIAnnotationView* viewPoint = [[[NIPinAnnotationView alloc] initWithNIMapView:mapView reuseIdentifier:AnnotationViewID]autorelease];
        viewPoint.priority = 11;
        int pointID = annotation.annotationID;
        if (pointID == ID_POI_CUSTOM || pointID == ID_POI_URL) {
            viewPoint.image = [UIImage imageNamed:[NSString stringWithFormat:@"map_position_ic"]];
        }
        else
        {
            viewPoint.image = [UIImage imageNamed:[NSString stringWithFormat:@"map_result_map_ic_%d",pointID]];
        }
        
        
        return viewPoint;
    }
    else if ([annotation isKindOfClass:[NIActionPaopaoAnnotation class]] ) {
        
        NSString *AnnotationViewID = @"paopaoMark";
        //        if (viewPaopao == nil) {
        
        NIActionPaopaoView* viewPaopao = [[[NIActionPaopaoView alloc] initWithNIMapView:mapView reuseIdentifier:AnnotationViewID]autorelease];
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
        
        if (titleCount > 15 )
        {
            title =[[UILabel alloc]initWithFrame:CGRectMake(15,0,width-20,imageNormal.size.height/2)];
        }
        else
        {
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
        if (textCount>15)
        {
            label=[[UILabel alloc]initWithFrame:CGRectMake(15,imageNormal.size.height/2-10,width-20,imageNormal.size.height/2)];
        } else {
            label=[[UILabel alloc]initWithFrame:CGRectMake(0,imageNormal.size.height/2-10,width,imageNormal.size.height/2)];
        }
        
        label.text=annotation.subtitle;
        label.font = [UIFont systemFontOfSize:13.0];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor=[UIColor clearColor];
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        [viewForImage addSubview:label];
        [label release];
        
        //其中30是气泡的偏移量，上为正，下为负
        [viewPaopao setAnchor:NIAnchorMake(0.5f,MAP_DEFAULT_PAOPAO_HIGHT)];
        
        viewPaopao.priority = 20;
        viewPaopao.image = [self getImageFromView:viewForImage];
        NSLog(@"%f",viewPaopao.image.size.height);
        //        }
        NSLog(@"%@",viewPaopao);
        return viewPaopao;
        
    }
    
    
    return nil;
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
