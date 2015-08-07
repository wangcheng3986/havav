
/*!
 @header FriendLocationDetailViewController.m
 @abstract 位置请求消息类
 @author mengy
 @version 1.00 13-5-2 Creation
 */
#import "FriendLocationDetailViewController.h"
#import "App.h"
#import "SendToCarViewViewController.h"
@interface FriendLocationDetailViewController ()
{
    NSString *keyID;
    NSString *selfText;
    NSString *timeText;
    NSString *message;
    NSString *uploadTime;
    NSString *carName;
    NSString *uploadAddress;
    NSString *poi;
    POIData *mpoi;
    UIBarButtonItem *leftBarBtn;
    BOOL isFirstShow;
}
@end

@implementation FriendLocationDetailViewController
@synthesize mData;
@synthesize fName;

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
    if (mTinyUrlCreate) {
        [mTinyUrlCreate release];
        mTinyUrlCreate = nil;
    }
    if (mCreateBlack) {
        [mCreateBlack release];
        mCreateBlack = nil;
    }
    if (mpoi) {
        [mpoi release];
        mpoi=nil;
    }
    if (fName) {
        [fName release];
    }
    if (mData) {
        [mData release];
    }
    
    if (backBtn) {
        [backBtn release];
        backBtn = nil;
    }
    
    if (leftBarBtn) {
        [leftBarBtn release];
        leftBarBtn = nil;
    }
    
    [titleLabel release] ,titleLabel =nil;
    [mapImageView release] ,mapImageView =nil;
    [messageView release] ,messageView =nil;
    [locationView release] ,locationView =nil;
    [selfLabel release] ,selfLabel =nil;
    [timeLabel release] ,timeLabel =nil;
    [uploadTimeLabel  release] ,uploadTimeLabel =nil;
    [carNameLabel release] ,carNameLabel =nil;
    [uploadAddressLabel release] ,uploadAddressLabel =nil;
    [uploadTimeTextLabel release] ,uploadTimeTextLabel =nil;
    [carNameTextLabel release] ,carNameTextLabel =nil;
    [uploadAddressTextLabel release] ,uploadAddressTextLabel =nil;
    [uploadAddressText release] ,uploadAddressText =nil;
    [shareLocationButton release] ,shareLocationButton =nil;
    [addBlacklistButton release] ,addBlacklistButton =nil;
    [shareLabel release] ,shareLabel =nil;
    [addBlacklistLabel release] ,addBlacklistLabel =nil;
    [mMessageTextView release] ,mMessageTextView =nil;
    [shareLocationView release] ,shareLocationView =nil;
    [sendToCarLabel release] ,sendToCarLabel =nil;
    [shareByShortMessageLabel release] ,shareByShortMessageLabel =nil;
    [cancelLabel release] ,cancelLabel =nil;
    [bottomPopUpbg  release] ,bottomPopUpbg =nil;
    [sharebyMessage release] ,sharebyMessage =nil;
    [toCar release] ,toCar =nil;
    [cancel release] ,cancel =nil;
    
    
    
    if (_mapView.POIData) {
        [_mapView.POIData removeAllObjects];
        [_mapView.POIData release];
        _mapView.POIData = nil;
    }
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
    
    if([App getVersion]>=IOS_VER_7){
        [App ios7ViewLocation:self];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_ios7_navBar_bg"] forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_ios6_navBar_bg"] forBarMetrics:UIBarMetricsLandscapePhone];
    }
    isFirstShow = YES;
    if (!mTinyUrlCreate) {
        mTinyUrlCreate = [[NItinyUrlCreate alloc]init];
    }
    if (!mCreateBlack) {
        mCreateBlack = [[NICreateBlack alloc]init];
    }
    backBtn = [[LeftButton alloc]init];
    [backBtn addTarget:self action:@selector(popself) forControlEvents:UIControlEventTouchUpInside];
    leftBarBtn = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
    Resources *oRes = [Resources getInstance];
    
    self.navigationItem.title = [oRes getText:@"message.friendLocationViewController.title"];
    
    uploadTimeLabel.text=[oRes getText:@"message.friendLocationViewController.uploadTimeLabel"];
    uploadTimeLabel.textColor = [UIColor colorWithRed:129.0/255.0f green:129.0/255.0f blue:129.0/255.0f alpha:1];
    uploadTimeLabel.font = [UIFont size12];
    
    
    carNameLabel.text=[oRes getText:@"message.friendLocationViewController.carNameLabel"];
    carNameLabel.textColor = [UIColor colorWithRed:129.0/255.0f green:129.0/255.0f blue:129.0/255.0f alpha:1];
    carNameLabel.font = [UIFont size12];
    
    
    uploadAddressLabel.text=[oRes getText:@"message.friendLocationViewController.uploadAddressLabel"];
    uploadAddressLabel.textColor = [UIColor colorWithRed:129.0/255.0f green:129.0/255.0f blue:129.0/255.0f alpha:1];
    uploadAddressLabel.font = [UIFont size12];
    
    shareLabel.text=[oRes getText:@"message.friendLocationViewController.shareButtonTitle"] ;
    addBlacklistLabel.text=[oRes getText:@"message.friendLocationViewController.addBlacklistButtonTitle"] ;
    sendToCarLabel.text=[oRes getText:@"message.friendLocationViewController.sendtocarButtonTitle"];
    shareByShortMessageLabel.text=[oRes getText:@"message.friendLocationViewController.smsButtonTitle"];
    cancelLabel.text=[oRes getText:@"message.friendLocationViewController.sheetcencelButtonTitle"];
    shareLabel.textColor=[UIColor whiteColor];
    addBlacklistLabel.textColor=[UIColor whiteColor];
    [self initData];
    // Do any additional setup after loading the view from its nib.
    bottomPopUpbg.backgroundColor = [UIColor colorWithRed:231.0/255.0f green:231.0/255.0f blue:231.0/255.0f alpha:1];
    
    self.view.backgroundColor = [UIColor colorWithRed:231.0/255.0f green:231.0/255.0f blue:231.0/255.0f alpha:1];
    
    [shareLocationButton setBackgroundImage:[UIImage imageNamed:@"message_common_highlight"] forState:UIControlStateHighlighted];
    [addBlacklistButton setBackgroundImage:[UIImage imageNamed:@"message_common_highlight"] forState:UIControlStateHighlighted];
    
    [sharebyMessage setBackgroundImage:[UIImage imageNamed:@"message_common_highlight"] forState:UIControlStateHighlighted];
    [toCar setBackgroundImage:[UIImage imageNamed:@"message_common_highlight"] forState:UIControlStateHighlighted];
    [cancel setBackgroundImage:[UIImage imageNamed:@"message_common_highlight"] forState:UIControlStateHighlighted];
    
    [self initMapView];
    
}



/*!
 @method initMapView
 @abstract 初始化地图
 @discussion 初始化地图
 @param 无
 @result 无
 */
-(void)initMapView
{
    [self setMapView:_mapView];
    self.requestReverseGeoFlag = NO;
    self.LongPressure = NO;
    [self loadMapBaseParameter];
    [_mapView initDataDic];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //设置指南针消失
    [_mapView.mapViewShare.mapView setShowDirection:NO image:nil];
    [_mapView.mapViewShare.mapView setScalePoint:CGPointMake(5.0,10.0)];
    if (isFirstShow) {
        
        NIMapStatus *ptemp = [[NIMapStatus alloc]init];
        ptemp.fLevel = MAP_DEFAULT_ZOOM;
        
        CGPoint target;
        target.x =(_mapView.frame.size.width/2)*2;
        target.y = (_mapView.frame.size.height/2)*2;
        ptemp.targetScreenPt = target;
        if(mData.mLat != 0 && mData.mLon != 0 )
        {
            
            [self setPOIWithNeedMoveToCenter:YES];
            
            ptemp.targetGeoPt = CLLocationCoordinate2DMake(mData.mLat, mData.mLon);
        }
        else
        {
            ptemp.targetGeoPt = CLLocationCoordinate2DMake(MAP_DEFAULT_LPP_LAT, MAP_DEFAULT_LPP_LON);
        }
        
        //动画移动到中心点
        [_mapViewBase.mapViewShare.mapView setMapStatus:ptemp withAnimation:NO];
        [ptemp release];
    }
    else
    {
        if(mData.mLat != 0 && mData.mLon != 0 )
        {
            [self setPOIWithNeedMoveToCenter:NO];
            if ([_mapView.POIData objectForKey:BUBBLE_INFO_KEY]) {
                MapPoiData *popPoi = [_mapView.POIData objectForKey:BUBBLE_INFO_KEY];
                [self showBubble:popPoi];
            }
        }
        if ([_mapView.POIData objectForKey:MAP_STATUS_KEY]) {
            [self setMapStatus:[_mapView.POIData objectForKey:MAP_STATUS_KEY]];
        }
    }
    
    isFirstShow = NO;
    
    CGRect rec;
    rec=uploadAddressText.frame;
    if ([App getScreenSize]==SCREEN_SIZE_960_640)
    {
        if ([App getVersion] == IOS_VER_8)
        {
            uploadAddressLabel.frame = CGRectMake(uploadAddressLabel.frame.origin.x, uploadAddressLabel.frame.origin.y+2, uploadAddressLabel.frame.size.width, uploadAddressLabel.frame.size.height);
            rec.origin.y=rec.origin.y-4;
            rec.size.height = rec.size.height+4;
            uploadAddressText.frame = rec;
            
        }
        else
        {
            CGRect rec;
            rec=uploadAddressText.frame;
            if(uploadAddressText.contentSize.height <= 31)
            {
                rec.origin.y=rec.origin.y-6;
                uploadAddressText.frame = rec;
            }
            else
            {
                [uploadAddressText scrollRectToVisible:CGRectMake(rec.origin.x, rec.origin.y, uploadAddressText.contentSize.width, 3) animated:NO];
            }
        }
        
    }
    else if ([App getScreenSize]==SCREEN_SIZE_1136_640) {
        if ([App getVersion] == IOS_VER_8) {
            uploadAddressLabel.frame = CGRectMake(uploadAddressLabel.frame.origin.x, uploadAddressLabel.frame.origin.y+2, uploadAddressLabel.frame.size.width, uploadAddressLabel.frame.size.height);
            rec.origin.y=rec.origin.y-4;
            rec.size.height = rec.size.height+4;
            uploadAddressText.frame = rec;
        }
        else
        {
            
            if(uploadAddressText.contentSize.height <= 31)
            {
                rec.origin.y=rec.origin.y-6;
                uploadAddressText.frame = rec;
            }
            else
            {
                [uploadAddressText scrollRectToVisible:CGRectMake(rec.origin.x, rec.origin.y, uploadAddressText.contentSize.width, 3) animated:NO];
            }
        }
        
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self removeOnePoint];
    [self releasePaopao];
    [self saveMapStatus];
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
 @method setPOI
 @abstract 向地图上描点
 @discussion 向地图上描点
 @param 无
 @result 无
 */
-(void)setPOIWithNeedMoveToCenter:(BOOL)status
{
    
    
    Resources *oRes = [Resources getInstance];
    mpoi=[[POIData alloc]init];
    mpoi.mAddress=[NSString stringWithString:mData.mPoiAddress];
    //    poi.mCreateTime=[self getTime];
    mpoi.mDesc=@"";
    mpoi.mfID=@"";
    mpoi.mFlag=POI_LOAD_YES;
    mpoi.mID=@"";
    mpoi.mLat =[NSString stringWithFormat:@"%f",mData.mLat];
    mpoi.mLon =[NSString stringWithFormat:@"%f",mData.mLon];
    
    if(mData.mPoiName && ![mData.mPoiName isEqualToString:@""] && ![mData.mPoiName isEqualToString:@"null"])
    {
        mpoi.mName = mData.mPoiName;
    }
    else
    {
         mpoi.mName=[oRes getText:@"message.MessageViewController.selfLocationTitle"];
    }
    mpoi.mPhone=@"";
    
    MapPoiData *customPoi = [[MapPoiData alloc]initWithID:ID_POI_CUSTOM];
    customPoi.mName = mpoi.mName;
    customPoi.mAddress = mpoi.mAddress;
    customPoi.coordinate = CLLocationCoordinate2DMake(mData.mLat, mData.mLon);
    
    [self addOneAnnotation:customPoi];
    if (status)
    {
        [self setMapCenter:customPoi.coordinate];
    }
    [customPoi release];
    
    
    
}

/*!
 @method initData
 @abstract 加载消息信息
 @discussion 加载消息信息
 @param 无
 @result 无
 */
-(void)initData
{
    //本地获取数据
    App *app = [App getInstance];
    Resources *oRes = [Resources getInstance];
    mData = [[app loadMeetRequestFriendRequestLocationMessage:keyID]retain];
    //显示好友名字
    if (app.mUserData.mType == USER_LOGIN_DEMO) {
        fName=[[NSString alloc]initWithString:mData.mFriendUserName];
    }
    else
    {
        if (mData.mFriendUserName != nil &&![mData.mFriendUserName isEqualToString:@""]) {
            fName = [[NSString alloc]initWithString:mData.mFriendUserName];
        }
        else if(mData.mFriendUserTel != nil &&![mData.mFriendUserTel isEqualToString:@""])
        {
            fName = [[NSString alloc]initWithString:mData.mFriendUserTel];
        }
        else
        {
            fName = [[NSString alloc]initWithString:@""];
        }
    }
    selfText=fName;
    
    
    timeText = [App getDateWithTimeSince1970:mData.mResponseTime];
    //modify for locationTime by wangqiwei 2014 6 13
    timeLabel.text=[app getCreateTime:mData.mKeyID];//[dateFormatter stringFromDate:date];
    timeLabel.textColor = [UIColor colorWithRed:129.0/255.0f green:129.0/255.0f blue:129.0/255.0f alpha:1];
    timeLabel.font = [UIFont size10];
    carName=mData.mLicenseNumber;
    if(mData.mLat != 0 && mData.mLon != 0 )
    {
        uploadAddress=mData.mPoiAddress;
    }
    else
    {
        uploadAddress=[oRes getText:@"message.friendLocationDetailViewController.noAddress"];
        uploadAddressText.textColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
    }
    uploadTime=[App getDateWithTimeSince1970:mData.mUploadTime];
    uploadAddressText.text=uploadAddress;
    uploadAddressText.editable=NO;
    
    if (fName) {
        NSString *messageinfo=[NSString stringWithFormat:@"%@%@%@%@",fName,[oRes getText:@"message.friendLocationDetailViewController.message1"],timeText,[oRes getText:@"message.friendLocationDetailViewController.message2"]];
        message = messageinfo;
    }
    else
    {
        NSString *messageinfo = [NSString stringWithFormat:@"%@%@%@",[oRes getText:@"message.friendLocationDetailViewController.message1"],timeText,[oRes getText:@"message.friendLocationDetailViewController.message2"]];
        message = messageinfo;
    }
    selfLabel.text=selfText;
    selfLabel.textColor = [UIColor blackColor];
    selfLabel.font = [UIFont boldsize15];

    
    
    
    mMessageTextView.text=message;
    mMessageTextView.textColor =[UIColor colorWithRed:87.0/255.0f green:87.0/255.0f blue:87.0/255.0f alpha:1];
    mMessageTextView.font = [UIFont size12];
    
    uploadTimeTextLabel.text=uploadTime;
    uploadTimeTextLabel.textColor = [UIColor colorWithRed:129.0/255.0f green:129.0/255.0f blue:129.0/255.0f alpha:1];
    uploadTimeTextLabel.font = [UIFont size12];
    
    carNameTextLabel.text=carName;
    carNameTextLabel.textColor = [UIColor colorWithRed:129.0/255.0f green:129.0/255.0f blue:129.0/255.0f alpha:1];
    carNameTextLabel.font = [UIFont size12];
    
    uploadAddressTextLabel.text=uploadAddress;
    uploadAddressTextLabel.textColor = [UIColor colorWithRed:129.0/255.0f green:129.0/255.0f blue:129.0/255.0f alpha:1];
    uploadAddressTextLabel.font = [UIFont size12];
    
    
    if ([mData.mFriendUserTel isEqualToString:app.selfPhone])
    {
        addBlacklistButton.enabled = NO;
    }
}

/*!
 @method onclickShareLocation:
 @abstract 点击分享按钮
 @discussion 点击分享按钮
 @param 无
 @result 无
 */
-(IBAction)onclickShareLocation:(id)sender
{
    if(mData.mLat != 0 && mData.mLon != 0 )
    {
        shareLocationView.hidden = NO;
        CGContextRef context = UIGraphicsGetCurrentContext();
        [UIView beginAnimations:@"Curl" context:context];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.3];
        CGRect rect = [shareLocationView frame];
        CGRect rect1 = [[UIScreen mainScreen] bounds];
        CGSize size = rect1.size;
        CGFloat height = size.height;
        rect.origin.y = height/2-42;
        [shareLocationView setFrame:rect];
        [UIView commitAnimations];
    }
    else
    {
        Resources *oRes = [Resources getInstance];
        [self MBProgressHUDMessage:[oRes getText:@"message.common.noShare"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    
    
}

/*!
 @method shareByShortMessage:
 @abstract 短信分享
 @discussion 短信分享
 @param 无
 @result 无
 */
- (IBAction)shareByShortMessage:(id)sender {
    //    使用接口的代码，现在不访问后台
    self.navigationItem.leftBarButtonItem.enabled = NO;
    backBtn.enabled = NO;
    Resources *oRes = [Resources getInstance];
    [self showProgressHUDWithTitle:[oRes getText:@"tinyUrlCreate.title"] andMessage:[oRes getText:@"common.load.text"]];
    
    //    拼接链接
    NSString *name = @"";
    if (mpoi.mName) {
        name = mpoi.mName;
    }
    NSString *locationAddressString = @"";
    if (mpoi.mAddress) {
        locationAddressString = mpoi.mAddress;
    }
    else
    {
        locationAddressString = @"";
    }
    
    NSString *phoneNumber = @"";
    
    NSString *longMessage=[NSString stringWithFormat:@"%@/online/mobilemap.xhtml?&lon=%@&lat=%@&title=%@&address=%@&phone=%@&time=%@",PORTAL_SERVER_URL,mpoi.mLon,mpoi.mLat,name,locationAddressString,phoneNumber,[App getSystemTime]];
    NSLog(@"%@",longMessage);
    [mTinyUrlCreate createRequest:longMessage];
    [mTinyUrlCreate sendRequestWithAsync:self];
    //    [self smsToShareWithURL:nil];
}

/*!
 @method onTinyUrlCreateResult:(NSString *)result code:(int)code errorMsg:(NSString *)errorMsg
 @abstract 获取网址的回调函数
 @discussion 获取网址的回调函数
 @param result 返回数据
 @param code 错误码
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
        [self MBProgressHUDMessage:[oRes getText:@"common.noNetAlert.message"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else
    {
        [self MBProgressHUDMessage:[oRes getText:@"tinyUrlCreate.failure"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    self.navigationItem.leftBarButtonItem.enabled = YES;
    backBtn.enabled = YES;
}


/*!
 @method sendToCar:
 @abstract 发送倒车
 @discussion 发送倒车
 @param 无
 @result 无
 */
- (IBAction)sendToCar:(id)sender {
    [self sendToCar];
}

/*!
 @method cancelShare:
 @abstract 取消分享
 @discussion 取消分享
 @param 无
 @result 无
 */
- (IBAction)cancelShare:(id)sender {
    shareLocationView.hidden = NO;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:@"Curl" context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.6];
    CGRect rect = [shareLocationView frame];
    CGRect rect1 = [[UIScreen mainScreen] bounds];
    CGSize size = rect1.size;
    CGFloat height = size.height;
    rect.origin.y = height;
    [shareLocationView setFrame:rect];
    [UIView commitAnimations];
    shareLocationView.hidden = YES;
}

/*!
 @method sendToCar
 @abstract 发送至车
 @discussion 发送至车
 @param 无
 @result 无
 */
-(void)sendToCar
{
    SendToCarViewViewController *sendToCarViewViewController=[[SendToCarViewViewController alloc]init];
    [sendToCarViewViewController setPOI:mpoi];
    [self.navigationController pushViewController:sendToCarViewViewController animated:YES];
    [sendToCarViewViewController release];
}

/*!
 @method smsToShareWithURL：
 @abstract 短信分享
 @discussion 短信分享
 @param URL
 @result 无
 */
-(void)smsToShareWithURL:(NSString *)URL
{
    Resources *oRes = [Resources getInstance];
    NSString *mUrl = nil;
    if (URL == nil) {
        mUrl = @"";
    }
    else
    {
        mUrl = URL;
    }
    NSString *name = @"";
    if (mpoi.mName) {
        name = mpoi.mName;
    }
    NSString *locationAddressString = @"";
    if (mpoi.mAddress) {
        locationAddressString = mpoi.mAddress;
    }
    else
    {
        locationAddressString = @"";
    }
    NSString *SMSBody=[NSString stringWithFormat:@"%@：%@，%@%@%@",name, locationAddressString,[oRes getText:@"message.SendToCarViewController.poiURLmessage"],mUrl,[oRes getText:@"message.SendToCarViewController.poiURLmessage2"]];
    App *app = [App getInstance];
    [app sendSMS:SMSBody];
    
    
}

///*!
// @method sendSMS:
// @abstract 组建短信
// @discussion 组建短信
// @param bodyOfMessage 消息内容
// @result 无
// */
//- (void)sendSMS:(NSString *)bodyOfMessage
//{
//    MFMessageComposeViewController *controller = [[[MFMessageComposeViewController alloc] init] autorelease];
//    if([MFMessageComposeViewController canSendText])
//    {
//        controller.body = bodyOfMessage;
//        controller.recipients = nil;
//        controller.messageComposeDelegate = self;
//        //modify by wangqiwei for new API at 2014.6.15
//        [self presentViewController:controller
//                           animated:YES
//                         completion:^(void){
//                             NSLog(@"______>>>>发送成功");
//                             
//                         }];
//      //  [self presentModalViewController:controller animated:YES];
//    }
//}
//
///*!
// @method messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
// @abstract 处理发送完的响应结果
// @discussion 处理发送完的响应结果
// @param controller 短信界面
// @param result 处理结果
// @result 无
// */
//- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
//{
//   // [self dismissModalViewControllerAnimated:YES];
//    //modify by wangqiwei for new API at 2014.6.15
//    [self dismissViewControllerAnimated:YES
//                             completion:^(void){
//                                 NSLog(@"______>>>>视图结束");
//                             }];
//    if (result == MessageComposeResultCancelled)
//        NSLog(@"Message cancelled");
//    else if (result == MessageComposeResultSent)
//        NSLog(@"Message sent");
//    else
//        NSLog(@"Message failed");
//}

/*!
 @method getTime
 @abstract 获取本地时间
 @discussion 获取本地时间
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
 @method onclickAddBlacklist：
 @abstract 加入黑名单
 @discussion 加入黑名单
 @param 无
 @result 无
 */
-(IBAction)onclickAddBlacklist:(id)sender
{
    Resources *oRes = [Resources getInstance];
    App *app = [App getInstance];
    NSString *name = mData.mFriendUserName;
    if (app.mUserData.mType == USER_LOGIN_DEMO) {
        NSString *uuid = [App createUUID];
        NSString *ID=uuid;
        NSString *dTime = [App getTimeSince1970_1000];
        if ([app blackExist:mData.mFriendUserTel]) {
            [self MBProgressHUDMessage:[oRes getText:@"message.common.addBlackIsExist"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
        }
        else
        {
            [app updateBlackDataWithKeyID:uuid ID:ID name:[name avoidSingleQuotesForSqLite] mobile:mData.mFriendUserTel lastUpdate:dTime createTime:dTime  pinyin:[[App getPinyin:name]avoidSingleQuotesForSqLite]];
            [self MBProgressHUDMessage:[oRes getText:@"message.common.addBlacklistSucess"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
        }
        
    }
    else
    {
        [self showProgressHUDWithTitle:[oRes getText:@"message.common.addBlackLoading"] andMessage:[oRes getText:@"common.load.text"]];
        self.navigationItem.leftBarButtonItem.enabled = NO;
        backBtn.enabled = NO;
        [mCreateBlack createRequest:name mobile:mData.mFriendUserTel userId:mData.mFriendUserID];
        [mCreateBlack sendRequestWithAsync:self];
    }
}

/*!
 @method onCreateResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg
 @abstract 加入黑名单回调函数
 @discussion 加入黑名单回调函数
 @param result 返回数据
 @param code 错误码
 @param errorMsg 错误信息
 @result 无
 */
- (void)onCreateResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg
{
    NSLog(@"receive the result.");
    
    Resources *oRes = [Resources getInstance];
    if (NAVINFO_RESULT_SUCCESS == code)
    {
        if (nil != result)
        {
            NSLog(@"result is :%@", result);
            NSDictionary * blackDic = [result objectForKey:@"black"];
            if (blackDic) {
//                NSString *tempID = [blackDic valueForKey:@"id"];
//                NSString *tempMobile  = [blackDic valueForKey:@"mobile"];
//                NSString *tempName = [blackDic valueForKey:@"name"];
//                NSString *tempLastUpdate = [blackDic valueForKey:@"lastUpdate"];
//                NSString *tempCreateTime = [blackDic valueForKey:@"createTime"];
//                NSLog(@"id is :%@", tempID);
                
                NSString *tempID = @"";
                if([blackDic objectForKey:@"id"])
                {
                    tempID = [blackDic objectForKey:@"id"];
                }
                NSString *tempMobile  = @"";
                if ([blackDic valueForKey:@"mobile"]) {
                    tempMobile  = [blackDic valueForKey:@"mobile"];
                }
                NSString *tempName  = @"";
                if ([blackDic valueForKey:@"name"]) {
                    tempName  = [blackDic valueForKey:@"name"];
                }
                NSString *tempPinyin  = @"";
                if ([blackDic valueForKey:@"pinyin"]) {
                    tempPinyin  = [blackDic valueForKey:@"pinyin"];
                }
                NSString *tempLastUpdate  = @"";
                if ([blackDic valueForKey:@"lastUpdate"]) {
                    tempLastUpdate  = [blackDic valueForKey:@"lastUpdate"];
                }
                NSString *tempCreateTime  = @"";
                if ([blackDic valueForKey:@"createTime"]) {
                    tempCreateTime  = [blackDic valueForKey:@"createTime"];
                }
                //NSLog(@"the desc is :%@, the version is :%@", [result valueForKey:@"desc"], [result valueForKey:@"version"]);
                
                //与服务器交互添加车友
                App *app = [App getInstance];
                NSString *uuid = [App createUUID];
//                [app deleteBlackDataWithMobile:tempMobile];
                tempName = [tempName avoidSingleQuotesForSqLite];
                tempPinyin = [tempPinyin avoidSingleQuotesForSqLite];
                [app updateBlackDataWithKeyID:uuid ID:tempID name:tempName mobile:tempMobile lastUpdate:tempLastUpdate createTime:tempCreateTime pinyin:tempPinyin];
                [self MBProgressHUDMessage:[oRes getText:@"message.common.addBlacklistSucess"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
            }
            else
            {
                [self MBProgressHUDMessage:[oRes getText:@"message.common.addBlackFailed"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
            }
            
            //            加入黑名单后续操作
        }
    }
    else if (NAVINFO_FRIEND_BLACKLIST_RESULT == code)
    {
        [self MBProgressHUDMessage:[oRes getText:@"message.common.addBlackIsExist"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else if(code == NET_ERROR)
    {
        [self MBProgressHUDMessage:[oRes getText:@"common.noNetAlert.message"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else if(NAVINFO_TOKENID_INVALID == code)//TokenID失效处理
    {
        [self MBProgressHUDMessage:[oRes getText:@"common.loseTokenID.message"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else
    {
        [self MBProgressHUDMessage:[oRes getText:@"message.common.addBlackFailed"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    [self removeProgressHUD];
    self.navigationItem.leftBarButtonItem.enabled = YES;
    backBtn.enabled = YES;
}

/*!
 @method setKeyID:(NSString *)keyid
 @abstract 设置keyid
 @discussion 设置keyid
 @param keyid
 @result 无
 */
-(void)setKeyID:(NSString *)keyid
{
    keyID=keyid;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*!
 @method showProgressHUDWithTitle:(NSString *)title andMessage:(NSString *)message
 @abstract 显示等待框
 @discussion 显示等待框
 @param title 标题
 @param message 消息
 @result 无
 */
-(void)showProgressHUDWithTitle:(NSString *)title andMessage:(NSString *)message
{
    //当进入视图时，重新设置imageView
    [self.imageView setImage:nil];
    [self.imageView setFrame:CGRectMake(160, 200, 0, 0)];
    //显示加载等待框
    if (self.progressHUD == nil) {
        self.progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:self.progressHUD];
        self.progressHUD.delegate = self;
    }
    [self.view bringSubviewToFront:self.progressHUD];
    self.progressHUD.labelText = title;
    self.progressHUD.detailsLabelText = message;
    [self.progressHUD show:YES];
}


/*!
 @method removeProgressHUD
 @abstract 移除等待
 @discussion 移除等待
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
