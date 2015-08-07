/***********************************
 * 版权所有：北京四维图新科技股份有限公司
 * 文件名称：FriendDetailViewController.m
 * 文件标识：
 * 内容摘要：车友详情
 * 其他说明：
 * 当前版本：
 * 作    者：刘铁成，王立琼
 * 完成日期：2013-08-25
 * 修改记录1：
 *	修改日期：2013-08-28
 *	版 本 号：
 *	修 改 人：孟磊
 *	修改内容：为黑名单增加请求等待框
 **************************************/

#import "FriendDetailViewController.h"
#import "leaveMessageViewController.h"
#import "App.h"
@interface FriendDetailViewController ()
{
    int             sex;
    int             syncToCarType;
    int             synToCar;
    
    BOOL            requestIsEnable;
    
    UIImage         *img;
    POIData         *poi;
    NSString        *mSendRqTime;
    NSString        *curTime;
    
    int             editBtnType;
    
    MapPoiData *customPOI;
    BOOL isFirstShow;
}
@end

@implementation FriendDetailViewController
@synthesize progressHUD = _progressHUD;
@synthesize mfriendData;

#pragma mark - life cycle
- (id)init
{
    self = [super initWithNibName:@"FriendDetailViewController" bundle:nil];
    if (self)
    {
        
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (mSendRqTime) {
        [mSendRqTime release];
        mSendRqTime = nil;
    }
    if (mDeleteContacts) {
        [mDeleteContacts release];
    }
    if (customPOI) {
        
        [customPOI release];
        customPOI=nil;
    }
    [mDisView removeFromSuperview];
    [mDisView release],mDisView = nil;
    
    [remarkView removeFromSuperview];
     [remarkView release],remarkView = nil;
    
    
    if (mfriendData) {
        [mfriendData release];
    }

    
    
    [photoImageView release],photoImageView = nil;
    [nameLabel release],nameLabel = nil;
    [siteRequestButton release],siteRequestButton = nil;
    [synchroLabel release],synchroLabel = nil;
    [checkVehicleButton release],checkVehicleButton = nil;
    [lastLocationLabel release],lastLocationLabel = nil;
    [locatinLabel release],locatinLabel = nil;
    [timeLabel release],timeLabel = nil;
    [mPhoneNumberLabel release],mPhoneNumberLabel = nil;

    [BackBtn release],BackBtn = nil;
    [editBtn release],editBtn = nil;
    [mCallBtn release],mCallBtn = nil;
    [titleLabel release],titleLabel = nil;
    [friendOtherViewBg release],friendOtherViewBg = nil;
    
    

    [remarkBtn release],remarkBtn = nil;
    
    [remarkViewTitle release],remarkViewTitle = nil;
    [remarkViewTextField release],remarkViewTextField = nil;
    [remarkViewCancelBtn release],remarkViewCancelBtn = nil;
    [remarkViewAffirmBtn release],remarkViewAffirmBtn = nil;
    [remarkBtnTitleLabel release],remarkBtnTitleLabel = nil;
    [callBtnTitleLabel release],callBtnTitleLabel = nil;
    
    
    [nameTextView release],nameTextView = nil;
    
    
    [mUpdateContacts release],mUpdateContacts = nil;
    
    [mRequestLocation release],mRequestLocation = nil;
    
    if (_progressHUD){
        [_progressHUD removeFromSuperview];
        [_progressHUD release];
        _progressHUD = nil;
    }
    
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
    isFirstShow = YES;
    editBtnType = EDIT_BTN_TYPE_EDIT;
    mDisView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:mDisView];
    mDisView.hidden=YES;
    mDeleteContacts = [[NIDeleteContacts alloc]init];
//    初始化修改备注弹出框
    [self InitRemarkView];
    [self.view addSubview:remarkView];
    //初始化导航控制器
    [self InitNavigationController];
    
    //初始化Label的文字
    [self InitLabelTextByResource];
    
    //从FriendData中的数据初始化Label文本
    [self InitByLoadedData];
        
    //数据库获取数据
    [self selectPhoto];
    [self loadLocationData];
    
    syncToCarType   =   SYNC_YES;
    [checkVehicleButton setBackgroundImage:[UIImage imageNamed:@"map_send2car_check_yes"] forState:UIControlStateNormal];
    
//    [siteRequestButton setBackgroundImage:[UIImage imageNamed:@"friend_detail_request_btn"] forState:UIControlStateNormal];
    [siteRequestButton setBackgroundImage:[UIImage imageNamed:@"friend_detail_request_btn_selected"] forState:UIControlStateHighlighted];
    mUpdateContacts = [[NIUpdateContacts alloc] init];
    mRequestLocation = [[NIRequestLocation alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setRequestIsEnable:) name:Notification_Request_Wait_End object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateFriendLoaction:) name:Notification_New_FriendLocation object:nil];
    self.view.backgroundColor = [UIColor colorWithRed:231.0/255.0f green:231.0/255.0f blue:231.0/255.0f alpha:1];
    //        根据设备屏幕大小判断
    
    enum SCREEN_SIZE   deviceSize = [App getScreenSize];
    if (deviceSize == SCREEN_SIZE_960_640)
    {
        friendOtherViewBg.frame =CGRectMake(0, 51, 320, 128);
    }

    [self InitProgressHUD];
    
    
//初始化地图控制器
    [self InitMapController];

}

/*!
 @method updateFriendLoaction
 @abstract 接收到通知后对车友的位置点进行更新
 @discussion 接收到通知后对车友的位置点进行更新
 @param notification 通知参数
 @result 无
 */
-(void)updateFriendLoaction:(NSNotification*)notification
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:notification.object];
    for (int i = 0; i < array.count; i ++) {
        NSMutableDictionary *dic = [array objectAtIndex:i];
        if ([dic objectForKey:@"phone"]) {
            if ([[dic objectForKey:@"phone"] isEqualToString:mfriendData.mfPhone]) {
//                修改车辆位置信息
                if ([self setPOIWithlon:[dic objectForKey:@"lon"] lat:[dic objectForKey:@"lat"] poiName:[dic objectForKey:@"poiName"] poiAddress:[dic objectForKey:@"poiAddress"] needMoveToCenter:YES])
                {
//                    修改更新时间
                    if ([dic objectForKey:@"locTime"])
                    {
                        timeLabel.text = [App getDateWithTimeSince1970:[dic objectForKey:@"locTime"]];
                        timeLabel.textColor = [UIColor colorWithRed:68.0/255.0f green:68.0/255.0f blue:68.0/255.0f alpha:1];
                        timeLabel.font      = [UIFont size12];
                    }
                    
                }
            }
        }
    
    }
}




/*!
 @method setPOIWithlon:(NSString *)lon lat:(NSString *)lat poiName:(NSString *)poiName poiAddress:(NSString *)poiAddress
 @abstract 由于接口尚未开发完成，此处还需进一步开发  设置POI
 @discussion 由于接口尚未开发完成，此处还需进一步开发  设置POI
 @param lon 经度
 @param lat 纬度
 @param poiName 名称
 @param poiAddress 地址
 @result 无
 */

-(BOOL)setPOIWithlon:(NSString *)lon lat:(NSString *)lat poiName:(NSString *)poiName poiAddress:(NSString *)poiAddress needMoveToCenter:(BOOL)status
{
    if (lon != nil && lat != nil && ![lon isEqualToString:@""] && ![lat isEqualToString:@""]) {
        double mlon = [lon doubleValue];
        double mlat = [lat doubleValue];
        if (customPOI == nil) {
            customPOI = [[MapPoiData alloc]initWithID:ID_POI_CUSTOM];
            customPOI.mName = poi.mName;
            customPOI.mAddress = poiAddress;
            customPOI.coordinate = CLLocationCoordinate2DMake(mlat, mlon);
            [self addOneAnnotation:customPOI];
        }
        else
        {
            [self removeOnePoint];
            [self releasePaopao];
            customPOI.coordinate  = CLLocationCoordinate2DMake(mlat, mlon);
            customPOI.mAddress     = poiAddress;
            [self addOneAnnotation:customPOI];
            
        }
        
        if (status)
        {
            NIMapStatus *ptemp = [[NIMapStatus alloc]init];
            ptemp.fLevel = 11.0;
            ptemp.targetGeoPt = customPOI.coordinate;
            CGPoint target;
            target.x =(_mapView.frame.size.width/2)*2;
            target.y = (_mapView.frame.size.height/2)*2;
            ptemp.targetScreenPt = target;

            //动画移动到中心点
            [_mapViewBase.mapViewShare.mapView setMapStatus:ptemp withAnimation:NO];
            [ptemp release];
            //[self setMapCenter:customPOI.coordinate];
        }
        return YES;
    }
    else
    {
        if (status)
        {
            NIMapStatus *ptemp = [[NIMapStatus alloc]init];
            ptemp.fLevel = 11.0;
            ptemp.targetGeoPt = CLLocationCoordinate2DMake(MAP_DEFAULT_CENTER_LAT, MAP_DEFAULT_CENTER_LON);
            CGPoint target;
            target.x =(_mapView.frame.size.width/2)*2;
            target.y = (_mapView.frame.size.height/2)*2;
            ptemp.targetScreenPt = target;
            
            //动画移动到中心点
            [_mapViewBase.mapViewShare.mapView setMapStatus:ptemp withAnimation:NO];
            [ptemp release];
            //[self setMapCenter:customPOI.coordinate];
        }
        return NO;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //设置指南针消失
    [_mapView.mapViewShare.mapView setShowDirection:NO image:nil];
//    [_mapView.mapViewShare.mapView setShowScale:NO image:nil];
    [_mapView.mapViewShare.mapView setScalePoint:CGPointMake(5.0, _mapView.frame.size.height-25)];
    remarkView.hidden = YES;
    [self nameTextViewCenter];
    
    //设置地图位置
    if (isFirstShow) {
        
        [self setPOIWithlon:poi.mLon lat:poi.mLat poiName:poi.mName poiAddress:poi.mAddress needMoveToCenter:YES];
    }
    else
    {
        [self setPOIWithlon:poi.mLon lat:poi.mLat poiName:poi.mName poiAddress:poi.mAddress needMoveToCenter:NO];
        if ([_mapView.POIData objectForKey:BUBBLE_INFO_KEY]) {
            MapPoiData *popPoi = [_mapView.POIData objectForKey:BUBBLE_INFO_KEY];
            [self showBubble:popPoi];
        }
        
        if ([_mapView.POIData objectForKey:MAP_STATUS_KEY]) {
            [self setMapStatus:[_mapView.POIData objectForKey:MAP_STATUS_KEY]];
        }
    }
    isFirstShow =NO;
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


-(void)nameTextViewCenter
{
    //这里调整车友名称UItextview的居中效果 孟磊 2013年9月24日
    CGSize textSize = nameTextView.contentSize;
    if(textSize.height < nameTextView.frame.size.height)
    {
        CGFloat offsetY = (nameTextView.frame.size.height - textSize.height)/2;
        UIEdgeInsets insets = UIEdgeInsetsMake(offsetY, 0, 0, 0);
        [nameTextView setContentInset:insets];
    }
    else
    {
        [nameTextView setContentInset:UIEdgeInsetsZero];
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
 @method onClickRemarkBtn
 @abstract 点击修改备注按钮执行的任务
 @discussion 点击修改备注按钮执行的任务
 @param sender 事件参数
 @result 无
 */
-(IBAction)onClickRemarkBtn:(id)sender
{
//    弹出键盘暂时取消20140314孟月
//    [self showKeyBoard];
    remarkViewTextField.text = nameTextView.text;
    remarkView.hidden = NO;
    mDisView.hidden=NO;
    BackBtn.enabled = NO;
    [remarkViewTextField becomeFirstResponder];
    
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
    [self hiddenKeyBoard];
    
    NSString *name = [remarkViewTextField.text stringByTrimmingCharactersInSet:
                       [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if(name.length > 32)
    {
        name = [name substringToIndex:32];
    }
    if (name.length == 0)
    {
        
        [self MBProgressHUDMessage:[oRes getText:@"friend.AddFriendViewController.nameTextNeeded"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];

    }
    else
    {
        
        if (app.mUserData.mType == USER_LOGIN_DEMO)
        {
            App *app = [App getInstance];
            [app updateFriendDataWithID:mfriendData.mfID mobile:mfriendData.mfPhone name:[name avoidSingleQuotesForSqLite] createTime:mfriendData.mCreateTime lastUpdate:mfriendData.mfLastUpdate pinyin:[[App getPinyin:name] avoidSingleQuotesForSqLite]];
            nameTextView.text = name;
            remarkView.hidden = YES;
            mDisView.hidden=YES;
            BackBtn.enabled = YES;
            [self MBProgressHUDMessage:[oRes getText:@"friend.FriendDetailViewController.remarkSuccess"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
        }
        else
        {
            Resources *oRes = [Resources getInstance];
            self.progressHUD.LabelText = [oRes getText:@"friend.FriendDetailViewController.remarkFriend"];
            [self.progressHUD show:YES];
//            修改时：传入 id 、手机号、 备注姓名（修改后）。
            //使用更新车友接口，NIUpdateContacts ，修改备注名
            NSDictionary *temp = [NSDictionary dictionaryWithObjectsAndKeys:
                    mfriendData.mfID,@"id",mfriendData.mfPhone,@"phone",name,@"name",nil];
            [mUpdateContacts createRequest:temp];
            [mUpdateContacts sendRequestWithAsync:self];
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
    [self hiddenKeyBoard];
    remarkView.hidden = YES;
    mDisView.hidden=YES;
    BackBtn.enabled = YES;
    editBtn.enabled = YES;
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
    [self hiddenKeyBoard];
    remarkView.hidden = YES;
    mDisView.hidden=YES;
    BackBtn.enabled = YES;
    editBtn.enabled = YES;
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
    [self hiddenKeyBoard];
}
/*!
 @method onClickViewBackground
 @abstract UI界面设置
 @discussion UI界面设置
 @param sender 事件参数
 @result 无
 */
-(IBAction)onClickViewBackground:(id)sender
{
    if (editBtnType == EDIT_BTN_TYPE_FINISH) {
//        [self hiddenEditView];
        editBtnType = EDIT_BTN_TYPE_EDIT;
    }
    
}

/*!
 @method hiddenKeyBoard
 @abstract 隐藏键盘
 @discussion 隐藏键盘
 @result 无
 */
-(void)hiddenKeyBoard
{
    [remarkViewTextField resignFirstResponder];
}
/*!
 @method showKeyBoard
 @abstract 显示键盘
 @discussion 显示键盘
 @result 无
 */
-(void)showKeyBoard
{
    [remarkViewTextField becomeFirstResponder];
}

/*!
 @method loadLocationData
 @abstract 加载本地数据
 @discussion 加载本地数据
 @result 无
 */
-(void)loadLocationData
{
    //后台获取数据
    poi = [[POIData alloc]init];
    App *app = [App getInstance];
    Resources *oRes = [Resources getInstance];
    poi.mLat=mfriendData.mfLat;
    poi.mLon=mfriendData.mfLon;
    poi.mName= [oRes getText:@"friend.FriendDetailViewController.selfLocationTitle"];
    poi.mAddress= mfriendData.mPoiAddress;
    if (app.mUserData.mType == USER_LOGIN_DEMO)
    {
        timeLabel.text = mfriendData.mfLastRqTime;
        timeLabel.textColor = [UIColor colorWithRed:68.0/255.0f green:68.0/255.0f blue:68.0/255.0f alpha:1];
        timeLabel.font      = [UIFont size12];
    }
    else
    {
        if (mfriendData.mfLastRqTime.length == 0)
        {
            timeLabel.text = [oRes getText:@"friend.FriendDetailViewController.friendNoLocation"];
        }
        else
        {
            timeLabel.text = [App getDateWithTimeSince1970:mfriendData.mfLastRqTime];
            timeLabel.textColor = [UIColor colorWithRed:68.0/255.0f green:68.0/255.0f blue:68.0/255.0f alpha:1];
            timeLabel.font      = [UIFont size12];
        }
    }
}

-(void)setFriendData:(FriendsData *)friendData
{
    App *app = [App getInstance];
    if (friendData) {
        mfriendData = [[app getFriendData:friendData.mfID]retain];
    }
}

/*!
 @method selectPhoto
 @abstract 男女图标区分，暂不区分
 @discussion 男女图标区分，暂不区分
 @result 无
 */
-(void)selectPhoto
{
   if (sex==MAN) {
       img = [UIImage imageNamed:@"friend_detail_ic"];

        [photoImageView setImage:img];
   }
    else
    {
        img = [UIImage imageNamed:@"friend_detail_ic"];
        [photoImageView setImage:img];
    }
}
/*!
 @method callToFreind
 @abstract UI界面设置
 @discussion UI界面设置
 @param sender 事件参数
 @result 无
 */
- (IBAction)callToFreind:(id)sender
{
    NSString *callNumber=mPhoneNumberLabel.text;
    if ([callNumber isEqual:@""]) {
        Resources *oRes = [Resources getInstance];
        [self MBProgressHUDMessage:[oRes getText:@"map.POIDetailViewController.callAlert"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];

    }
    else
    {
        App *app = [App getInstance];
        [app callPhone:callNumber];
    }
}
/*!
 @method replaceUnicode
 @abstract unicode转NSString
 @discussion unicode转NSString
 @param unicodeStr uicode编码
 @result 无
 */
- (NSString *)replaceUnicode:(NSString *)unicodeStr
{
    
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}

/*!
 @method onUpdateResult:code:errorMsg:
 @abstract 修改备注回调方法
 @discussion 修改备注回调方法
 @param sender 事件参数
 @param code 错误码
 @param errorMsg 错误信息
 @result 无
 */
- (void)onUpdateResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg
{
    NSLog(@"receive the result.");
    [self.progressHUD hide:YES];
    Resources *oRes = [Resources getInstance];
    if (NAVINFO_RESULT_SUCCESS == code) {
        NSLog(@"result is :%@", result);
        //修改本机数据
        NSDictionary *contactsDic = [result valueForKey:@"friend"];
        if (contactsDic) {
            NSString *tempID = @"";
            if([contactsDic objectForKey:@"id"])
            {
                tempID = [contactsDic objectForKey:@"id"];
            }
            NSString *tempMobile  = @"";
            if ([contactsDic valueForKey:@"phone"]) {
                tempMobile  = [contactsDic valueForKey:@"phone"];
            }
            NSString *tempName  = @"";
            if ([contactsDic valueForKey:@"name"]) {
                tempName  = [contactsDic valueForKey:@"name"];
            }
            NSString *tempLastUpdate  = @"";
            if ([contactsDic valueForKey:@"lastUpdate"]) {
                tempLastUpdate  = [contactsDic valueForKey:@"lastUpdate"];
            }
            NSString *tempCreateTime  = @"";
            if ([contactsDic valueForKey:@"createTime"]) {
                tempCreateTime  = [contactsDic valueForKey:@"createTime"];
            }
            NSString *tempPinyin  = @"";
            if ([contactsDic valueForKey:@"pinyin"]) {
                tempPinyin  = [contactsDic valueForKey:@"pinyin"];
            }
            App *app = [App getInstance];
            nameTextView.text = tempName;
            [self nameTextViewCenter];
            tempName = [tempName avoidSingleQuotesForSqLite];
            tempPinyin = [tempPinyin avoidSingleQuotesForSqLite];
            [app updateFriendDataWithID:mfriendData.mfID mobile:tempMobile name:tempName createTime:tempCreateTime lastUpdate:tempLastUpdate pinyin:tempPinyin];
            [self MBProgressHUDMessage:[oRes getText:@"friend.FriendDetailViewController.remarkSuccess"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
            
            remarkView.hidden = YES;
            mDisView.hidden=YES;
            BackBtn.enabled = YES;
        }
        else
        {
            
            [self MBProgressHUDMessage:[oRes getText:@"friend.FriendDetailViewController.remarkFailed"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
        }
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
        NSLog(@"Errors on reveice result.");
        [self MBProgressHUDMessage:[oRes getText:@"friend.FriendDetailViewController.remarkFailed"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];

    }
    
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

-(IBAction)textFieldDoneEditing:(id)sender
{
    
    [sender resignFirstResponder];
    
}

#pragma mark request friend locate
/*!
 @method siteRequest
 @abstract 请求查看车辆位置
 @discussion 请求查看车辆位置
 @param sender 事件参数
 @result 无
 */
-(IBAction)siteRequest:(id)sender
{
    NSString * sendTocar;
    if (syncToCarType==SYNC_YES)
    {
        sendTocar = @"1";
    }
    else
    {
        sendTocar = @"0";
    }
    [self moveToLeaveMessageView:sendTocar];
    /*
     *去掉时间限制
     //    获取位置请求时间
     App *app = [App getInstance];
     if (mSendRqTime) {
     [mSendRqTime release];
     mSendRqTime = nil;
     }
     mSendRqTime = [[NSString alloc]initWithFormat:@"%@",[app getRqTimeWithFID:mfriendData.mfID]];
     
     NSDate *nowTime =  [NSDate date];
     NSTimeInterval time = [nowTime timeIntervalSince1970];
     long long dTime = [[NSNumber numberWithDouble:time] longLongValue]; // 将double转为long long型
     if (curTime) {
     [curTime release];
     curTime = nil;
     }
     curTime = [[NSString alloc]initWithFormat:@"%llu",dTime];// 输出long long型
     NSLog(@"%@",curTime);
     //    long long newTime = [nowTime longLongValue];
     long long lastTime = [mSendRqTime longLongValue];
     if (dTime - lastTime > 120)
     {
     requestIsEnable = YES;
     }
     else
     {
     requestIsEnable = NO;
     }
     if (requestIsEnable) {
     
     //向系统提交查看车辆位置请求
     App *app = [App getInstance];
     NSString * sendTocar;
     if (syncToCarType==SYNC_YES)
     {
     sendTocar = @"true";
     }
     else
     {
     sendTocar = @"false";
     }
     [self moveToLeaveMessageView:sendTocar];
     //        if (app.mUserData.mType != USER_LOGIN_DEMO)
     //        {
     //            //在加入黑名单过程中禁用返回按钮，孟磊 2013年9月5日
     //            self.navigationItem.backBarButtonItem.enabled =NO;
     //            BackBtn.enabled = NO;
     //            //为等待框增加详细信息提示，提示“正在发送中”，孟磊 2013年9月3日
     //            Resources *oRes = [Resources getInstance];
     //            self.progressHUD.LabelText = [oRes getText:@"friend.FriendDetailViewController.sendingLocationRequest"];
     //            [self.progressHUD show:YES];
     //
     //            [mRequestLocation createRequest:@"app"
     //                                     rqDesc:@""
     //                                      rpUserId:mfriendData.mFriendUserID
     //                                        s2c:sendTocar];//@"15910838084"];
     //
     //            [mRequestLocation sendRequestWithAsync:self];
     //        }
     //        else
     //        {
     //            //        线程方法
     //            //        [app startRequestThread];
     //            //        requestIsEnable = NO;
     //            [app updateFriendRqTimeWithFID:mfriendData.mfID rqTime:curTime];
     //            if (mSendRqTime) {
     //                [mSendRqTime release];
     //                mSendRqTime = nil;
     //            }
     //            mSendRqTime = [[NSString alloc]initWithFormat:@"%@",curTime];
     //            Resources *oRes = [Resources getInstance];
     //            UIAlertView *alert;
     //            alert = [[UIAlertView alloc] initWithTitle:nil message:[oRes getText:@"friend.FriendDetailViewController.requestLocationSended"]delegate:self cancelButtonTitle:[oRes getText:@"friend.AddFriendViewController.alertCencel"] otherButtonTitles:nil];
     //            [alert show];
     //            [alert release];
     //        }
     }
     else
     {
     Resources *oRes = [Resources getInstance];
     UIAlertView *alert;
     alert = [[UIAlertView alloc] initWithTitle:nil message:[oRes getText:@"friend.FriendDetailViewController.requestLocationDisable"]delegate:self cancelButtonTitle:[oRes getText:@"friend.AddFriendViewController.alertCencel"] otherButtonTitles:nil];
     [alert show];
     [alert release];
     }
     */
}


/*!
 @method syncToCar
 @abstract 同步至车
 @discussion 同步至车
 @param sender 事件参数
 @result 无
 */
-(IBAction)syncToCar:(id)sender
{
    if (syncToCarType==SYNC_YES)
    {
        syncToCarType=SYNC_NO;
        CGSize msize;
        msize.height=23;
        msize.width=23;
        img = [self reSizeImage:[UIImage imageNamed:@"map_send2car_check_no"] toSize:msize];
    }
    else
    {
        syncToCarType=SYNC_YES;
        CGSize msize;
        msize.height=23;
        msize.width=23;
        img = [self reSizeImage:[UIImage imageNamed:@"map_send2car_check_yes"] toSize:msize];
        
    }
    [checkVehicleButton setBackgroundImage:img forState:UIControlStateNormal];
}


- (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize

{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
    
}

# pragma mark - 获取当前时间
/*!
 @method getTime
 @abstract 获得本地时间
 @discussion 获得本地时间
 @result 无
 */
-(NSString *)getTime
{
    NSDate * newDate = [NSDate date];
    NSDateFormatter *dateformat=[[NSDateFormatter alloc] init];
    [dateformat setDateFormat:@"yyyyMMddHHmmss"];
    NSString * newDateOne = [dateformat stringFromDate:newDate];
    [dateformat setDateStyle:NSDateFormatterFullStyle];
    [dateformat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSLog(@"request start time%@",newDateOne);
    [dateformat release];
    return newDateOne;
    
}

# pragma mark - 处理内存警告，适用于4.3以上版本
- (void)didReceiveMemoryWarning
{
    //调用父类的内存警告处理函数
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [BackBtn release];
    BackBtn = nil;
    [super viewDidUnload];
}

#pragma mark - 私有方法
/*!
 @method InitNavigationController
 @abstract UI界面设置
 @discussion UI界面设置
 @result 无
 */
- (void) InitNavigationController
{
    //适配IOS7，替换背景图片
    Resources *oRes = [Resources getInstance];
    if([App getVersion]>=IOS_VER_7){
        [App ios7ViewLocation:self];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_ios7_navBar_bg"] forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_ios6_navBar_bg"] forBarMetrics:UIBarMetricsDefault];
    }
//    titleLabel.text=[oRes getText:@"friend.FriendTabBarViewController.friendDetailTitle"];
//    titleLabel.font =[UIFont navBarTitleSize];
//    self.navigationItem.titleView = titleLabel;
    
    self.navigationItem.title = [oRes getText:@"friend.FriendTabBarViewController.friendDetailTitle"];
    
    BackBtn = [[LeftButton alloc]init];
    [BackBtn addTarget:self action:@selector(popself)forControlEvents:UIControlEventTouchUpInside];
    BackBtn.titleLabel.font =[UIFont navBarItemSize];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc]initWithCustomView:BackBtn]autorelease];
    
}
/*!
 @method InitLabelTextByResource
 @abstract UI界面设置
 @discussion UI界面设置
 @result 无
 */
-(void) InitLabelTextByResource
{
    Resources *oRes         = [Resources getInstance];
    
    synchroLabel.text      = [oRes getText:@"friend.FriendDetailViewController.synchroLabelText"];
    synchroLabel.textColor = [UIColor colorWithRed:94.0/255.0f green:94.0/255.0f blue:94.0/255.0f alpha:1];
    synchroLabel.font      = [UIFont size12];
    
    locatinLabel.text       = [oRes getText:@"friend.FriendDetailViewController.siteRequestButtonTitle"];
    locatinLabel.font = [UIFont size13];
    
    lastLocationLabel.text  = [oRes getText:@"friend.FriendDetailViewController.lastLocationTitle"];
    lastLocationLabel.textColor = [UIColor colorWithRed:68.0/255.0f green:68.0/255.0f blue:68.0/255.0f alpha:1];
    lastLocationLabel.font      = [UIFont size12];
    
    callBtnTitleLabel.font =[UIFont size12];
    callBtnTitleLabel.textColor = [UIColor whiteColor];
    callBtnTitleLabel.text =[oRes getText:@"friend.FriendDetailViewController.callToFriend"];
    
    
    remarkBtnTitleLabel.text = [oRes getText:@"friend.FriendTabBarViewController.remarkBtnTitle"];
    remarkBtnTitleLabel.font =[UIFont size12];
    remarkBtnTitleLabel.textColor = [UIColor whiteColor];
    

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
    remarkViewTitle.text  = [oRes getText:@"friend.FriendTabBarViewController.remarkAlertTitle"];
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
 @method InitByLoadedData
 @abstract UI界面设置
 @discussion UI界面设置
 @result 无
 */
-(void) InitByLoadedData
{
    //modify by wangqiwei for IOS7 style at 2014 5 20
    mPhoneNumberLabel.text  =   mfriendData.mfPhone;
    mPhoneNumberLabel.textColor =[UIColor colorWithRed:241.0/255.0f green:57.0/255.0f blue:61.0/255.0f alpha:1];
    mPhoneNumberLabel.font = [UIFont size14_5];
    
    nameLabel.text          =   mfriendData.mfName;
    
    /*联系人姓名自动换行，联系人姓名两行显示 孟磊 2013年9月11日*/
    [nameLabel setNumberOfLines:0];
    nameLabel.lineBreakMode = UILineBreakModeWordWrap;
    nameLabel.hidden = YES;
    
    nameTextView.text = mfriendData.mfName;
}


/*!
 @method InitMapController
 @abstract 初始化地图
 @discussion 初始化地图
 @result 无
 */
-(void) InitMapController
{
    [self setMapView:_mapView];
    self.requestReverseGeoFlag = NO;
    self.LongPressure = NO;
    [self loadMapBaseParameter];
    [_mapView initDataDic];
}


/*!
 @method InitProgressHUD
 @abstract UI界面设置
 @discussion UI界面设置
 @result 无
 */
-(void) InitProgressHUD
{
    Resources *oRes         = [Resources getInstance];
    self.progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.progressHUD];
    [self.view bringSubviewToFront:self.progressHUD];
    self.progressHUD.delegate = self;
    self.progressHUD.detailsLabelText  = [oRes getText:@"common.load.text"];
}
/*!
 @method formatDataTime
 @abstract 时间设置
 @discussion 时间设置
 @result 无
 */
-(NSString *) formatDataTime:(NSString *)dateString
{
    NSString * returnString ;
    NSDate * date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    date = [dateFormatter dateFromString:dateString];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    returnString = [dateFormatter stringFromDate:date];
    [dateFormatter release];
    return returnString;
}

#pragma mark - 留言板功能 wangqiwei
- (void) moveToLeaveMessageView:(NSString *)sendTocar
{
    leaveMessageViewController *message = [[leaveMessageViewController alloc] init];
    [message setFriendData:mfriendData];
    [message setsendTocarData:sendTocar];
    [self.navigationController pushViewController:message animated:YES];
    [message release];
    
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
