
/*!
 @header SendToCarDetailViewController.m
 @abstract 发送到车消息类
 @author mengy
 @version 1.00 13-5-3 Creation
 */
#import "SendToCarDetailViewController.h"
#import "SendToCarViewViewController.h"
@interface SendToCarDetailViewController ()
{
    
    NSString *keyID;
    NSString *sender;
    NSString *time;
    NSString *message;
//    NSString *poi;
    POIData *mpoi;
    UIBarButtonItem *leftBarBtn;
    BOOL isFirstShow;
}
@end

@implementation SendToCarDetailViewController
@synthesize fName;
@synthesize mData;

- (void)dealloc
{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (mTinyUrlCreate) {
        [mTinyUrlCreate release];
        mTinyUrlCreate = nil;
    }
    if (mCreateBlack) {
        [mCreateBlack release];
        mCreateBlack = nil;
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
    [mpoi release];
    
    if (mCreateContacts) {
        [mCreateContacts release];
    }
    
    [titleLabel release],titleLabel = nil;
    [mapImageView release],mapImageView = nil;
    [messageView removeFromSuperview];
    [messageView release],messageView = nil;
    [buttonView removeFromSuperview];
    [buttonView release],buttonView = nil;
    [senderLabel release],senderLabel = nil;
    [timeLabel release],timeLabel = nil;
    [messageLabel release],messageLabel = nil;
    [shareLocationButton release],shareLocationButton = nil;
    [addBlacklistButton release],addBlacklistButton = nil;
    [shareLabel release],shareLabel = nil;
    [addBlackListLabel release],addBlackListLabel = nil;
    [addFriendlistButton release],addFriendlistButton = nil;
    [addFriendListLabel release],addFriendListLabel = nil;
    [shareLocationView removeFromSuperview];
    [shareLocationView release],shareLocationView = nil;
    [shareByShortMessage release],shareByShortMessage = nil;
    [sendToCar release],sendToCar = nil;
    [cancelShare release],cancelShare = nil;
    [sendToCarLabel release],sendToCarLabel = nil;
    [shareByShortMessageLabel release],shareByShortMessageLabel = nil;
    [cancelLabel release],cancelLabel = nil;
    [bottomPopUpbg release],bottomPopUpbg = nil;
    
    
    [mDisView removeFromSuperview];
    [mDisView release],mDisView = nil;
    [remarkView removeFromSuperview];
    [remarkView release],remarkView = nil;
    [remarkViewTitle release],remarkViewTitle = nil;
    [remarkViewTextField release],remarkViewTextField = nil;
    [remarkViewCancelBtn release],remarkViewCancelBtn = nil;
    [remarkViewAffirmBtn release],remarkViewAffirmBtn = nil;
    if (_mapView.POIData) {
        [_mapView.POIData removeAllObjects];
        [_mapView.POIData release];
        _mapView.POIData = nil;
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
    isFirstShow = YES;
    if (!mTinyUrlCreate) {
        mTinyUrlCreate = [[NItinyUrlCreate alloc]init];
    }
    backBtn = [[LeftButton alloc]init];
    [backBtn addTarget:self action:@selector(popself) forControlEvents:UIControlEventTouchUpInside];
    leftBarBtn = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
    mpoi=[[POIData alloc]init];
    if([App getVersion]>=IOS_VER_7){
        [App ios7ViewLocation:self];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_ios7_navBar_bg"] forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_ios6_navBar_bg"] forBarMetrics:UIBarMetricsLandscapePhone];
    }
    Resources *oRes = [Resources getInstance];
    self.navigationItem.title=[oRes getText:@"message.sendToCarViewController.title"];
    
    shareLabel.text=[oRes getText:@"message.friendLocationViewController.shareButtonTitle"];
    addBlackListLabel.text=[oRes getText:@"message.friendLocationViewController.addBlacklistButtonTitle"];
    addFriendListLabel.text=[oRes getText:@"message.friendLocationViewController.addFriendlistButtonTitle"];
    sendToCarLabel.text=[oRes getText:@"message.friendLocationViewController.sendtocarButtonTitle"];
    shareByShortMessageLabel.text=[oRes getText:@"message.friendLocationViewController.smsButtonTitle"];
    cancelLabel.text=[oRes getText:@"message.friendLocationViewController.sheetcencelButtonTitle"];
    mCreateBlack = [[NICreateBlack alloc]init];
    [self InitRemarkView];
    [self initMessage];
    [self getPOIInformation];
    [shareLocationButton setBackgroundImage:[UIImage imageNamed:@"message"] forState:UIControlStateHighlighted];
    [addBlacklistButton setBackgroundImage:[UIImage imageNamed:@"message"] forState:UIControlStateHighlighted];
    [addFriendlistButton setBackgroundImage:[UIImage imageNamed:@"message"] forState:UIControlStateHighlighted];
    [shareByShortMessage setBackgroundImage:[UIImage imageNamed:@"message"] forState:UIControlStateHighlighted];
    [sendToCar setBackgroundImage:[UIImage imageNamed:@"message"] forState:UIControlStateHighlighted];
    [cancelShare setBackgroundImage:[UIImage imageNamed:@"message"] forState:UIControlStateHighlighted];
    
    bottomPopUpbg.backgroundColor = [UIColor colorWithRed:231.0/255.0f green:231.0/255.0f blue:231.0/255.0f alpha:1];
    self.view.backgroundColor = [UIColor colorWithRed:231.0/255.0f green:231.0/255.0f blue:231.0/255.0f alpha:1];
    if (!mCreateContacts) {
        mCreateContacts = [[NICreateContacts alloc]init];
    }
    //    初始化地图
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
            ptemp.targetGeoPt = CLLocationCoordinate2DMake(MAP_DEFAULT_CENTER_LAT, MAP_DEFAULT_CENTER_LAT);
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
 @method InitRemarkView
 @abstract UI界面设置
 @discussion UI界面设置
 @result 无
 */
-(void)InitRemarkView
{
    Resources *oRes         = [Resources getInstance];
    
    [self.view addSubview:mDisView];
    [self.view addSubview:remarkView];
    mDisView.hidden = YES;
    remarkView.hidden = YES;
    remarkViewTextField.delegate = self;
    remarkViewTitle.text  = [oRes getText:@"message.remarkAlertTitle"];
    remarkViewTitle.textColor = [UIColor blackColor];
    remarkViewTitle.font = [UIFont size14_5];
    
    [remarkViewCancelBtn setTitle:[oRes getText:@"friend.FriendTabBarViewController.remarkAlertCancel"] forState:UIControlStateNormal];
    [remarkViewCancelBtn setTitleColor:[UIColor colorWithRed:236.0/255.0f green:236.0/255.0f blue:236.0/255.0f alpha:1] forState:UIControlStateNormal];
    [remarkViewCancelBtn addTarget:self action:@selector(onClickRemarkViewCancelBtn) forControlEvents:UIControlEventTouchUpInside];
    
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
    
    
}

/*!
 @method onclickAddFriend：
 @abstract 加为车友
 @discussion 加为车友
 @param 无
 @result 无
 */
-(IBAction)onclickAddFriend:(id)sender
{
    Resources *oRes         = [Resources getInstance];
    App *app = [App getInstance];
    if (mData.mSendUserID == nil || [mData.mSendUserID isEqualToString:@""])
    {
        //        号码为空时的处理
        [self MBProgressHUDMessage:[oRes getText:@"message.common.addFriend.phoneError"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else if ([mData.mSendUserID isEqualToString:app.mUserData.mUserID])
    {
        [self MBProgressHUDMessage:[oRes getText:@"message.common.addSelfFriendAlert"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else
    {
        remarkView.hidden = NO;
        mDisView.hidden=NO;
        backBtn.enabled = NO;
        [remarkViewTextField becomeFirstResponder];
    }
    
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
    
    if(name.length > 32)
    {
        name = [name substringToIndex:32];
    }
    if (name.length == 0)
    {
        
        [self MBProgressHUDMessage:[oRes getText:@"message.common.nameTextNeeded"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
        
    }
    else
    {
        [remarkViewTextField resignFirstResponder];
        
        if (app.mUserData.mType == USER_LOGIN_DEMO)
        {
            if ([app friendExistWhitPhone:mData.mSendUserTel]) {
                [self MBProgressHUDMessage:[oRes getText:@"message.common.addContactsIsExist"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
            }
            else
            {
                //此处的keyID尚未确定如何设置
                NSString *uuid = [App createUUID];
                NSString *fkeyid=uuid;
                NSString *fid=uuid;
                NSString *flat=@"";
                NSString *flon=@"";
                NSString *fLastRqTime=@"";
                
                NSString *fLastUpdate=@"0";
                
                NSString *name = remarkViewTextField.text;
                NSString *createTime =[App getTimeSince1970_1000];
                NSString *friendUserID = uuid;
                [app updateFriendData:fkeyid fid:fid fname:[name avoidSingleQuotesForSqLite] fphone:mData.mSendUserTel flon:flon flat:flat fLastRqTime:fLastRqTime fLastUpdate:fLastUpdate sendLocationRqTime:@"" createTime:createTime friendUserID:friendUserID poiName:@"" poiAddress:@"" pinyin:[[App getPinyin:name] avoidSingleQuotesForSqLite]];
                [self MBProgressHUDMessage:[oRes getText:@"message.common.addContactsSuccess"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
            }
            
            remarkView.hidden = YES;
            mDisView.hidden=YES;
            backBtn.enabled = YES;
            
        }
        else
        {
            [self showProgressHUDWithTitle:[oRes getText:@"message.common.addFriendLoading"] andMessage:[oRes getText:@"common.load.text"]];
            self.navigationItem.leftBarButtonItem.enabled = NO;
            backBtn.enabled = NO;
            [mCreateContacts createRequest:remarkViewTextField.text telNo:mData.mSendUserTel];
            [mCreateContacts sendRequestWithAsync:self];
        }
    }
}
/*!
 @method onClickRemarkViewCancelBtn
 @abstract UI界面设置
 @discussion UI界面设置
 @result 无
 */
-(void)onClickRemarkViewCancelBtn
{
    remarkViewTextField.text = @"";
    [remarkViewTextField resignFirstResponder];
    remarkView.hidden = YES;
    mDisView.hidden=YES;
    backBtn.enabled = YES;
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
    [remarkViewTextField resignFirstResponder];
    remarkView.hidden = YES;
    mDisView.hidden=YES;
    backBtn.enabled = YES;
}
/*!
 @method onClickRemarkViewBackground
 @abstract 键盘设置
 @discussion 键盘设置
 @param sender 事件参数
 @result 无
 */
-(IBAction)onClickRemarkViewBackground:(id)sender
{
    [remarkViewTextField resignFirstResponder];
}


/*!
 @method getPOIInformation
 @abstract 封装poi信息
 @discussion 封装poi信息
 @param 无
 @result 无
 */
-(void)getPOIInformation
{
    Resources *oRes = [Resources getInstance];
    mpoi.mDesc=@"";
    mpoi.mfID=@"";
    mpoi.mFlag=POI_LOAD_YES;
    mpoi.mID=@"";
    mpoi.mLat =[NSString stringWithFormat:@"%f",mData.mLat];
    mpoi.mLon =[NSString stringWithFormat:@"%f",mData.mLon];
//    初始化poiName，待定
    if (mData.mPoiName) {
        mpoi.mName = [NSString stringWithString:mData.mPoiName];
    }
    else
    {
        mpoi.mName=[oRes getText:@"message.MessageViewController.send2carLocationNOTitle"];
    }
    //    初始化poiAddress，待定
    if (mData.mPoiAddress) {
        mpoi.mAddress = [NSString stringWithString:mData.mPoiAddress];
    }
    else
    {
        mpoi.mAddress = @"";
    }
}

/*!
 @method setPOI
 @abstract 将poi点显示在地图上
 @discussion 将poi点显示在地图上
 @param 无
 @result 无
 */
-(void)setPOIWithNeedMoveToCenter:(BOOL)status
{
    MapPoiData *customPoi = [[MapPoiData alloc]initWithID:ID_POI_CUSTOM];
    customPoi.mName = mpoi.mName;
    customPoi.mAddress = mpoi.mAddress;
    customPoi.coordinate = CLLocationCoordinate2DMake(mData.mLat, mData.mLon);
    [self addOneAnnotation:customPoi];
    if (status) {
        [self setMapCenter:customPoi.coordinate];
    }
    [customPoi release];
    
}


/*!
 @method initMessage
 @abstract 初始化消息数据
 @discussion 初始化消息数据
 @param 无
 @result 无
 */
-(void)initMessage
{
    //本地获取数据
    App *app = [App getInstance];
    Resources *oRes = [Resources getInstance];
    mData = [[app loadMeetRequestSendToCarMessage:keyID]retain];
  
    if (mData) {
//        NSDate *date = nil;
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        if (app.mUserData.mType == USER_LOGIN_DEMO) {
//            [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
//            date = [dateFormatter dateFromString:mData.mSendTime];
//            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//            time= [dateFormatter stringFromDate:date];
//            //modify for locationTime by wangqiwei 2014 6 13
//            timeLabel.text=[app getCreateTime:mData.mKeyID];//[dateFormatter stringFromDate:date];
//            timeLabel.textColor = [UIColor colorWithRed:129.0/255.0f green:129.0/255.0f blue:129.0/255.0f alpha:1];
//            timeLabel.font = [UIFont size10];
//        }
//        else
//        {
//            time = [App getDateWithTimeSince1970:mData.mSendTime];
//            //modify for locationTime by wangqiwei 2014 6 13
//            timeLabel.text=[app getCreateTime:mData.mKeyID];//[dateFormatter stringFromDate:date];
//            timeLabel.textColor = [UIColor colorWithRed:129.0/255.0f green:129.0/255.0f blue:129.0/255.0f alpha:1];
//            timeLabel.font = [UIFont size10];
//        }
//        [dateFormatter release];
        
        time = [App getDateWithTimeSince1970:mData.mSendTime];
        //modify for locationTime by wangqiwei 2014 6 13
        timeLabel.text=[app getCreateTime:mData.mKeyID];//[dateFormatter stringFromDate:date];
        timeLabel.textColor = [UIColor colorWithRed:129.0/255.0f green:129.0/255.0f blue:129.0/255.0f alpha:1];
        timeLabel.font = [UIFont size10];
        if (app.mUserData.mType == USER_LOGIN_DEMO) {
            fName=[[NSString alloc]initWithString:mData.mSendUserName];
        }
        else
        {
            if ([mData.mSendUserID isEqualToString:app.mUserData.mUserID]) {
                fName = [[NSString alloc]initWithString:[oRes getText:@"friend.FriendList.selfName"]];
            }
            else
            {
                if (mData.mSendUserName != nil &&![mData.mSendUserName isEqualToString:@""]) {
                    fName = [[NSString alloc]initWithString:mData.mSendUserName];
                }
                else if(mData.mSendUserTel != nil &&![mData.mSendUserTel isEqualToString:@""])
                {
                    fName = [[NSString alloc]initWithString:mData.mSendUserTel];
                }
                else
                {
                    fName = [[NSString alloc]initWithString:@""];
                }
            }
            
        }
        sender = fName;
        if (mData.mPoiName != nil && ![mData.mPoiName isEqualToString:@""]&& ![mData.mPoiName isEqualToString:@"(null)"]) {
            fLocName = [[NSString alloc]initWithString:mData.mPoiName];
        }
        else
        {
            fLocName = @"";
        }

        NSString *messageinfo;
        if (sender) {
            messageinfo = [NSString stringWithFormat:@"%@%@%@%@%@%@",sender,[oRes getText:@"message.SendToCarViewController.message1"],time,[oRes getText:@"message.SendToCarViewController.message2"],fLocName,[oRes getText:@"message.SendToCarViewController.message3"]];
        }
        else
        {
            messageinfo = [NSString stringWithFormat:@"%@%@%@%@%@",[oRes getText:@"message.SendToCarViewController.message1"],time,[oRes getText:@"message.SendToCarViewController.message2"],fLocName,[oRes getText:@"message.SendToCarViewController.message3"]];
        }
        
        message = messageinfo;
        senderLabel.text=sender;
        senderLabel.textColor = [UIColor blackColor];
        senderLabel.font = [UIFont boldsize15];

        messageLabel.text=message;
        messageLabel.textColor = [UIColor colorWithRed:87.0/255.0f green:87.0/255.0f blue:87.0/255.0f alpha:1];
        messageLabel.font = [UIFont size12];
        
    }

    
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

/*!
 @method onclickShareLocation:
 @abstract 点击分享
 @discussion 点击分享
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
        rect.origin.y = height/2-40;
        
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
    //    GET_SMS_URL为测试用，真正的地址为SERVER_URL
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
 @param code 返回码
 @param result 返回数据
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
    self.navigationItem.leftBarButtonItem.enabled = YES;
    backBtn.enabled = YES;
}

/*!
 @method onCreateContactsResult:code:errorMsg:
 @abstract 收到创建contacts的result
 @discussion 收到创建contacts的result
 @param sender 事件参数
 @param code 错误码
 @param errorMsg 错误信息
 @result 无
 */
- (void)onCreateContactsResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg
{
    NSLog(@"receive the result.");
    
    Resources *oRes = [Resources getInstance];
    if (NAVINFO_RESULT_SUCCESS == code)
    {
        if (nil != result)
        {
            NSLog(@"result is :%@", result);
            if([result valueForKey:@"friend"])
            {
                NSString *tempID = [[result valueForKey:@"friend"]objectForKey:@"id"];
                NSLog(@"tempID = %@",tempID);
                NSString *tempMobile  = [[result valueForKey:@"friend"]objectForKey:@"phone"];
                if (tempMobile == nil) {
                    tempMobile = @"";
                }
                NSString *tempName =[[result valueForKey:@"friend"]objectForKey:@"name"];
                
                if (tempName == nil) {
                    tempName = @"";
                }
                
                NSString *tempLastUpdate = [[result valueForKey:@"friend"]objectForKey:@"lastUpdate"];
                if (tempLastUpdate == nil) {
                    tempLastUpdate = @"";
                }
                NSString *tempCreateTime = [[result valueForKey:@"friend"]objectForKey:@"createTime"];
                if (tempCreateTime == nil) {
                    tempCreateTime = @"";
                }
                NSString *tempFriendUserID = [[result valueForKey:@"friend"]objectForKey:@"friendUserId"];
                if (tempFriendUserID == nil) {
                    tempFriendUserID = @"";
                }
                
                NSString *tempPinyin = [[result valueForKey:@"friend"]objectForKey:@"pinyin"];
                if (tempPinyin == nil) {
                    tempPinyin = @"";
                }
                //NSLog(@"the desc is :%@, the version is :%@", [result valueForKey:@"desc"], [result valueForKey:@"version"]);
                
                //与服务器交互添加车友
                App *app = [App getInstance];
                //此处的keyID用uuid来填充
                NSString *uuid = [App createUUID];
                //                删除已经存在的车友，现接口返回车友存在错误码，无需对已经存在的车友进行删除
                //                [app deleteFriendWithPhone:tempMobile];
                //        更新车友数据库
                tempName = [tempName avoidSingleQuotesForSqLite];
                tempPinyin = [tempPinyin avoidSingleQuotesForSqLite];
                [app updateFriendData:uuid fid:tempID fname:tempName fphone:tempMobile  flon:@"" flat:@"" fLastRqTime:@"" fLastUpdate:tempLastUpdate sendLocationRqTime:@"" createTime:tempCreateTime friendUserID:tempFriendUserID poiName:@"" poiAddress:@"" pinyin:tempPinyin];
                
                [self MBProgressHUDMessage:[oRes getText:@"message.common.addContactsSuccess"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
                remarkViewTextField.text = @"";
                remarkView.hidden = YES;
                mDisView.hidden=YES;
                backBtn.enabled = YES;
            }
            else
            {
                [self MBProgressHUDMessage:[oRes getText:@"message.common.addContactsFailed"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
            }
            
        }
        else
        {
            [self MBProgressHUDMessage:[oRes getText:@"message.common.addContactsFailed"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
        }
    }
    else if (NAVINFO_FRIEND_ADD_EXIST == code)//所添加的车友已存在
    {
        [self MBProgressHUDMessage:[oRes getText:@"message.common.addContactsIsExist"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else if (NAVINFO_FRIEND_ADD_NO_T_SERVER == code)//所添加的手机号没有开通长城T服务
    {
        [self MBProgressHUDMessage:[oRes getText:@"message.common.addContactsNoTServer"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
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
        [self MBProgressHUDMessage:[oRes getText:@"message.common.addContactsFailed"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    [self.progressHUD hide:YES];
}


/*!
 @method send2car
 @abstract 发送到车
 @discussion 发送到车
 @param 无
 @result 无
 */
- (IBAction)sendToCar:(id)sender {
    [self sendToCar];
}

/*!
 @method cancelShare：
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
 @abstract 发送到车，跳转到发送到车界面
 @discussion 发送到车，跳转到发送到车界面
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

#pragma mark send short message

/*!
 @method smsToShareWithURL:
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
    
    NSString *shortMessage=[NSString stringWithFormat:@"%@：%@，%@%@%@",name,locationAddressString,[oRes getText:@"message.SendToCarViewController.poiURLmessage"],mUrl,[oRes getText:@"message.SendToCarViewController.poiURLmessage2"]];
    App *app = [App getInstance];
    [app sendSMS:shortMessage];
}

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
 @abstract 返回上个界面
 @discussion 返回上个界面
 @param 无
 @result 无
 */
-(void)popself
{
    [self.navigationController popViewControllerAnimated:YES];
    
}


/*!
 @method createCancelButton
 @abstract 创建返回按钮
 @discussion 创建返回按钮
 @param 无
 @result UIBarButtonItem
 */
-(UIBarButtonItem*)createCancelButton
{
    Resources *oRes = [Resources getInstance];
    return [[[UIBarButtonItem alloc]
            initWithTitle:[oRes getText:@"sendToCarViewController.cencelButton"]
            style:UIBarButtonItemStyleBordered
            target:self
            action:@selector(popself)] autorelease];
}


/*!
 @method onclickAddBlacklist：
 @abstract 加入黑名单
 @discussion 加入黑名单，发送网络请求
 @param 无
 @result 无
 */
-(IBAction)onclickAddBlacklist:(id)sender
{
    Resources *oRes = [Resources getInstance];
    App *app = [App getInstance];
    NSString *name = nil;
    name = mData.mSendUserName;
    if ([mData.mSendUserID isEqualToString:app.mUserData.mUserID])
    {
        [self MBProgressHUDMessage:[oRes getText:@"message.common.addSelfAlert"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else
    {
        if (app.mUserData.mType == USER_LOGIN_DEMO) {
            NSString *uuid = [App createUUID];
            NSString *ID=uuid;
            NSString *dTime = [App getTimeSince1970_1000];
            if ([app blackExist:mData.mSendUserTel]) {
                [self MBProgressHUDMessage:[oRes getText:@"message.common.addBlackIsExist"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
            }
            else
            {
                [app updateBlackDataWithKeyID:uuid ID:ID name:[name avoidSingleQuotesForSqLite] mobile:mData.mSendUserTel lastUpdate:dTime createTime:dTime pinyin:[[App getPinyin:name] avoidSingleQuotesForSqLite]];
                [self MBProgressHUDMessage:[oRes getText:@"message.common.addBlacklistSucess"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
            }
            
        }
        else
        {
            
            if (mData.mSendUserID == nil || [mData.mSendUserID isEqualToString:@""])
            {
                //        号码为空时的处理
                [self MBProgressHUDMessage:[oRes getText:@"message.common.addBlack.phoneError"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
            }
            else
            {
                [self showProgressHUDWithTitle:[oRes getText:@"message.common.addBlackLoading"] andMessage:[oRes getText:@"common.load.text"]];
                self.navigationItem.leftBarButtonItem.enabled = NO;
                backBtn.enabled = NO;
                [mCreateBlack createRequest:name mobile:mData.mSendUserTel userId:mData.mSendUserID];
                [mCreateBlack sendRequestWithAsync:self];
            }
            
        }
    }
    
    
}

/*!
 @method onclickAddBlacklist：
 @abstract 收到加入黑名单的result
 @discussion 收到加入黑名单的result
 @param code 返回码
 @param result 返回数据
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
                //NSLog(@"the desc is :%@, the version is :%@", [result valueForKey:@"desc"], [result valueForKey:@"version"]);
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
 @param message 内容
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
        if ([toBeString length] > 32) { //如果名字输入框内容大于32则弹出警告
            textField.text = [toBeString substringToIndex:32];
            return NO;
        }
    }
    return YES;
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
