
/*!
 @header LocationRequestDetailViewController.m
 @abstract 位置请求消息类
 @author mengy
 @version 1.00 13-5-2 Creation
 */
#import "LocationRequestDetailViewController.h"
#import "App.h"
@interface LocationRequestDetailViewController ()
{
    NSString *keyID;
    NSString *sender;
    NSString *time;
    NSString *message;
    int requestStatusl;
    UIBarButtonItem *leftBarBtn;
    
}
@end

@implementation LocationRequestDetailViewController
@synthesize fName;
@synthesize mData;
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
    if (self.progressHUD) {
        [self.progressHUD removeFromSuperview];
        [self.progressHUD release];
        self.progressHUD = nil;
        
    }
    
    if (mCreateBlack) {
        [mCreateBlack release];
        mCreateBlack = nil;
    }
    if (mCreateContacts) {
        [mCreateContacts release];
        mCreateContacts = nil;
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
    [titleLabel release],titleLabel =nil;
    [messageView removeFromSuperview];
    [messageView release ],messageView =nil;
    [senderLabel release ],senderLabel =nil;
    [timeLabel release],timeLabel =nil;
    [messageTextView release],messageTextView =nil;
    [descTextView release],descTextView =nil;
    [descView release ],descView =nil;
    [agreeButton release],agreeButton =nil;
    [addFriendButton release],addFriendButton =nil;
    [addBlackListButton  release],addBlackListButton =nil;
    [addBlackListLabel release],addBlackListLabel =nil;
    [resultLabel release],resultLabel =nil;
    [backgroundBottom release],backgroundBottom =nil;
    
    [mRespLocation release],mRespLocation = nil;
    
    [mDisView removeFromSuperview];
    [mDisView release],mDisView = nil;
    [remarkView removeFromSuperview];
    [remarkView release],remarkView = nil;
    [remarkViewTitle release],remarkViewTitle = nil;
    [remarkViewTextField release],remarkViewTextField = nil;
    [remarkViewCancelBtn release],remarkViewCancelBtn = nil;
    [remarkViewAffirmBtn release],remarkViewAffirmBtn = nil;
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
        //[self.navigationController.navigationBar setShadowImage:[UIImage imageNamed:@"common_ios7_shadowImage_bg"]];
    }
    else
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_ios6_navBar_bg"] forBarMetrics:UIBarMetricsLandscapePhone];
         messageTextView.frame = CGRectMake(messageTextView.frame.origin.x-3,messageTextView.frame.origin.y,messageTextView.frame.size.width+3,messageTextView.frame.size.height);
    }
    Resources *oRes = [Resources getInstance];
    self.navigationItem.title = [oRes getText:@"message.locationRequestViewController.title"];
    
    backBtn = [[LeftButton alloc]init];
    [backBtn addTarget:self action:@selector(popself) forControlEvents:UIControlEventTouchUpInside];
    leftBarBtn = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
    addBlackListLabel.text=[oRes getText:@"message.locationRequestViewController.addBlacklistButtonTitle"];
    
    addBlackListLabel.textColor=[UIColor whiteColor];
    agreeLabel.text =  [oRes getText:@"message.locationRequestViewController.agreeButtonTitle"];
     agreeLabel.textColor=[UIColor whiteColor];
    addFriendLabel.text = [oRes getText:@"message.locationRequestViewController.addFriendButtonTitle"];
    addFriendLabel.textColor=[UIColor whiteColor];
    if (!mCreateBlack) {
        mCreateBlack = [[NICreateBlack alloc]init];
    }
    //    初始化修改备注弹出框
    [self InitRemarkView];
    [self loadData];
    mRespLocation = [[NIResponseLocation alloc] init];
    // Do any additional setup after loading the view from its nib.
    if (!mCreateContacts) {
        mCreateContacts = [[NICreateContacts alloc]init];
    }
    self.view.backgroundColor = [UIColor colorWithRed:231.0/255.0f green:231.0/255.0f blue:231.0/255.0f alpha:1];
    
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
    remarkView.hidden = NO;
    mDisView.hidden=NO;
    backBtn.enabled = NO;
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
            if ([app friendExistWhitPhone:mData.mRqUserTel]) {
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
                [app deleteFriendWithPhone:mData.mRqUserTel];
                [app updateFriendData:fkeyid fid:fid fname:[name avoidSingleQuotesForSqLite] fphone:mData.mRqUserTel flon:flon flat:flat fLastRqTime:fLastRqTime fLastUpdate:fLastUpdate sendLocationRqTime:@"" createTime:createTime friendUserID:friendUserID poiName:@"" poiAddress:@"" pinyin:[[App getPinyin:name] avoidSingleQuotesForSqLite]];
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
            [mCreateContacts createRequest:remarkViewTextField.text telNo:mData.mRqUserTel];
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
 @method loadData
 @abstract 初始化消息数据
 @discussion 初始化消息数据
 @param 无
 @result 无
 */
-(void)loadData
{
    //  本地获取数据 未完成
    App *app = [App getInstance];
    Resources *oRes = [Resources getInstance];
    mData = [[app loadMeetRequestFriendLocationMessage:keyID]retain];
    if ([mData.mRpState intValue] == FRIEND_LOCATION_UNTREATED) {
        resultLabel.hidden = YES;
        agreeButton.enabled = YES;
        [agreeIcon setImage:[UIImage imageNamed:@"message_agree_ic"]];
        
    }
    else
    {
        NSString *result = nil;
        if ([mData.mRpState intValue] == FRIEND_LOCATION_AGREE) {
            result = [NSString stringWithFormat:@"%@",[oRes getText:@"message.locationRequestViewController.disposeResultAgree"]];
        }
        if (![mData.mRpTime isEqualToString:@""]) {
            resultLabel.text = [NSString stringWithFormat:@"%@，%@",result,mData.mRpTime];
        }
        else
        {
            resultLabel.text = [NSString stringWithFormat:@"%@",result];
        }
        resultLabel.hidden = NO;
        agreeButton.enabled = NO;
//        message_friend_rq_agree_disable@2x
        [agreeButton setTitle:@"" forState:UIControlStateDisabled];
        [agreeButton setBackgroundImage:[UIImage imageNamed:@"message_button_Disabled"] forState:UIControlStateDisabled];
        [agreeIcon setImage:[UIImage imageNamed:@"message_agree_ic_disabled"]];
        [agreeButton setTitleColor:[UIColor colorWithRed:109.0/255.0f green:109.0/255.0f blue:109.0/255.0f alpha:1] forState:UIControlStateDisabled];
        agreeLabel.textColor =[UIColor colorWithRed:109.0/255.0f green:109.0/255.0f blue:109.0/255.0f alpha:1];
        
        
    }
    
    [agreeButton setBackgroundImage:[UIImage imageNamed:@"message"] forState:UIControlStateHighlighted];
    [addBlackListButton setBackgroundImage:[UIImage imageNamed:@"message"] forState:UIControlStateHighlighted];
    [addFriendButton setBackgroundImage:[UIImage imageNamed:@"message"] forState:UIControlStateHighlighted];
    if (app.mUserData.mType == USER_LOGIN_DEMO) {
        fName=[[NSString alloc]initWithString:mData.mRqUserName];
    }
    else
    {
        if (mData.mRqUserName != nil &&![mData.mRqUserName isEqualToString:@""]) {
            fName = [[NSString alloc]initWithString:mData.mRqUserName];
        }
        else if(mData.mRqUserTel != nil &&![mData.mRqUserTel isEqualToString:@""])
        {
            fName = [[NSString alloc]initWithString:mData.mRqUserTel];
        }
        else
        {
            fName = [[NSString alloc]initWithString:@""];
        }
    }
    sender=fName;
    
    time = [App getDateWithTimeSince1970:mData.mRqTime];
    timeLabel.text= [app getCreateTime:mData.mKeyID];//[dateFormatter stringFromDate:date];
    timeLabel.textColor = [UIColor colorWithRed:1.0/255.0f green:1.0/255.0f blue:1.0/255.0f alpha:1];
    timeLabel.font = [UIFont size10];
    if (fName) {
        NSLog(@"%@",time);
        NSString *messageinfo = [NSString stringWithFormat:@"%@%@%@%@",fName,[oRes getText:@"message.locationRequestViewController.message1"],time,[oRes getText:@"message.locationRequestViewController.message2"]];
        message=messageinfo;
    }
    else
    {
        NSString *messageinfo = [NSString stringWithFormat:@"%@%@%@",[oRes getText:@"message.locationRequestViewController.message2"],time,[oRes getText:@"message.locationRequestViewController.message3"]];
        message=messageinfo;
    }
    
    senderLabel.text=sender;
    senderLabel.textColor = [UIColor colorWithRed:1.0/255.0f green:1.0/255.0f blue:1.0/255.0f alpha:1];
    senderLabel.font = [UIFont boldsize15];
    if (mData.mDescription != nil && ![mData.mDescription isEqualToString:@""]) {
        descTextView.text=mData.mDescription;
        descTextView.textColor = [UIColor colorWithRed:73.0/255.0f green:73.0/255.0f blue:73.0/255.0f alpha:1];
        descTextView.font = [UIFont size12];
        descTitleLabel.text = [oRes getText:@"message.locationRequestViewController.desc"];
        descTitleLabel.textColor = [UIColor colorWithRed:73.0/255.0f green:73.0/255.0f blue:73.0/255.0f alpha:1];
        descTitleLabel.font = [UIFont size12];
    }
    else
    {
        descView.hidden = YES;
    }
    messageTextView.text=message;
    messageTextView.textColor = [UIColor colorWithRed:73.0/255.0f green:73.0/255.0f blue:73.0/255.0f alpha:1];
    messageTextView.font = [UIFont size12];

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
 @method onclickAgree：
 @abstract 同意
 @discussion 同意
 @param 无
 @result 无
 */
-(IBAction)onclickAgree:(id)sender
{
    App *app= [App getInstance];
    requestStatusl = FRIEND_LOCATION_AGREE;
    agreeButton.enabled = NO;
    Resources *oRes = [Resources getInstance];
    if (app.mUserData.mType == USER_LOGIN_DEMO)
    {
        [self MBProgressHUDMessage:[oRes getText:@"message.locationRequestViewController.responseSuccess"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
        [app updateFriendLocationMessageRpState:keyID state:requestStatusl rpTime:[App getSystemTime]];
        [self loadData];
    }
    else
    {
        //向服务器发送同意指令 待接口好用时使用接口
        [self showProgressHUDWithTitle:[oRes getText:@"message.locationRequestViewController.AgreeLoading"] andMessage:[oRes getText:@"common.load.text"]];
        self.navigationItem.leftBarButtonItem.enabled = NO;
        backBtn.enabled = NO;
        [mRespLocation createRequest:mData.mReqUID rpState:2];
        [mRespLocation sendRequestWithAsync:self];
        
    }

}

/*!
 @method onclickRefuse：
 @abstract 拒绝
 @discussion 拒绝
 @param 无
 @result 无
 */
-(IBAction)onclickRefuse:(id)sender
{
    App *app= [App getInstance];
    Resources *oRes = [Resources getInstance];
    requestStatusl = FRIEND_LOCATION_REFUSE;
    agreeButton.enabled = NO;
    if (app.mUserData.mType == USER_LOGIN_DEMO)
    {
        [self MBProgressHUDMessage:[oRes getText:@"message.locationRequestViewController.responseSuccess"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
        [app updateFriendLocationMessageRpState:keyID state:requestStatusl rpTime:[App getSystemTime]];
        [self loadData];
    }
    else
    {
        //向服务器发送同意指令  待接口好用时使用接口
        self.navigationItem.leftBarButtonItem.enabled = NO;
        backBtn.enabled = NO;
        [mRespLocation createRequest:mData.mReqUID rpState:3];
        [mRespLocation sendRequestWithAsync:self];
    }
}

/*!
 @method onResponseLocationResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg
 @abstract 同意或拒绝回调函数
 @discussion 同意或拒绝回调函数
 @param result 返回数据
 @param code 返回码
 @param errorMsg 错误信息
 @result 无
 */
- (void)onResponseLocationResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg
{
    Resources *oRes = [Resources getInstance];
    if (code == NAVINFO_RESULT_SUCCESS) {
        App *app= [App getInstance];
        [self MBProgressHUDMessage:[oRes getText:@"message.locationRequestViewController.responseSuccess"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
        [app updateFriendLocationMessageRpState:keyID state:requestStatusl rpTime:[App getSystemTime]];
        [self loadData];
        
    }
    else if(code == NET_ERROR)
    {
        agreeButton.enabled = YES;
        Resources *oRes = [Resources getInstance];
        [self MBProgressHUDMessage:[oRes getText:@"common.noNetAlert.message"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else if(code == NAVINFO_TOKENID_INVALID)
    {
        agreeButton.enabled = YES;
        [self MBProgressHUDMessage:[oRes getText:@"common.loseTokenID.message"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else
    {
        agreeButton.enabled = YES;
        [self MBProgressHUDMessage:[oRes getText:@"message.locationRequestViewController.operationFailure"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    self.navigationItem.leftBarButtonItem.enabled = YES;
    backBtn.enabled = YES;
    [self.progressHUD hide:YES];
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
    
    NSString *name = mData.mRqUserName;
    if (app.mUserData.mType == USER_LOGIN_DEMO) {
        NSString *uuid = [App createUUID];
        NSString *dTime = [App getTimeSince1970_1000];
        
        if ([app blackExist:mData.mRqUserTel]) {
            [self MBProgressHUDMessage:[oRes getText:@"message.common.addBlackIsExist"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
        }
        else
        {
            [app updateBlackDataWithKeyID:uuid ID:uuid name:[name avoidSingleQuotesForSqLite] mobile:mData.mRqUserTel lastUpdate:dTime createTime:dTime pinyin:[[App getPinyin:name] avoidSingleQuotesForSqLite]];
            [self MBProgressHUDMessage:[oRes getText:@"message.common.addBlacklistSucess"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
        }
        
        
    }
    else
    {
        [self showProgressHUDWithTitle:[oRes getText:@"message.common.addBlackLoading"] andMessage:[oRes getText:@"common.load.text"]];
        self.navigationItem.leftBarButtonItem.enabled = NO;
        backBtn.enabled = NO;
        [mCreateBlack createRequest:name mobile:mData.mRqUserTel userId:mData.mRqUserID];
        [mCreateBlack sendRequestWithAsync:self];
        
    }
    
    
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
 @method onCreateResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg
 @abstract 加入黑名单回调函数
 @discussion 加入黑名单回调函数
 @param result 返回数据
 @param code 返回码
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
                //[app deleteBlackDataWithMobile:tempMobile];
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
    [self.progressHUD hide:YES];
    self.navigationItem.leftBarButtonItem.enabled = YES;
    backBtn.enabled = YES;
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
        if ([toBeString length] > 32) { //如果名字输入框内容大于32则弹出警告
            textField.text = [toBeString substringToIndex:32];
            return NO;
        }
    }
    return YES;
}

@end
