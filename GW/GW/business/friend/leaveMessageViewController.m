//
//  leaveMessageViewController.m
//  GW
//
//  Created by wqw on 14-8-25.
//  Copyright (c) 2014年 mengy. All rights reserved.
//

#import "leaveMessageViewController.h"

@interface leaveMessageViewController ()
{
    UIBarButtonItem *leftBarBtn;
    int  remainTextNum;
    NSString *sendTocarResult;
    NSString        *curTime;
     NSString        *mSendRqTime;
    int codeState;
    BOOL            requestIsEnable;

}
@end

@implementation leaveMessageViewController
@synthesize progressHUD = _progressHUD;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        mRequestLocation = [[NIRequestLocation alloc] init];
    Resources *oRes = [Resources getInstance];
    codeState = NAVINFO_RESULT_FAIL;

    self.view.backgroundColor = [UIColor colorWithRed:231.0/255 green:231.0/255 blue:231.0/255 alpha:1];
    _textView.delegate = self;
    _messageTitle.text = [oRes getText:@"friend.leaveMessage.messageTitle"];
    _informationTips.text = [oRes getText:@"friend.leaveMessage.informationTips"];
    _information.text = [oRes getText:@"friend.leaveMessage.information"];
    
    [_sendMessageButton setTitle:[oRes getText:@"friend.leaveMessage.sendMessageButton"] forState:UIControlStateNormal];
    
    _textView.layer.contents = (id)[UIImage imageNamed:@"friend_leaveMessage_textViewContent"].CGImage;
    
    
    _placeHolder.text = [oRes getText:@"friend.leaveMessage.placeHolder"];
    _textNumber.text = [oRes getText:@"friend.leaveMessage.textNumber"];
    _textNumber.text = @"0/40";
    
    _textView.keyboardType = UIKeyboardTypeDefault;
    _textView.returnKeyType = UIReturnKeyDone;

    [_textView becomeFirstResponder];
    
    backBtn = [[LeftButton alloc]init];
    [backBtn addTarget:self action:@selector(popself) forControlEvents:UIControlEventTouchUpInside];
    leftBarBtn = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
    [backBtn release];
    
    
//    _titleLabel.text = [oRes getText:@"friend.leaveMessage.Title"];
//    
//    _titleLabel.font =[UIFont navBarTitleSize];
//    self.navigationItem.titleView = _titleLabel;
    
    self.navigationItem.title = [oRes getText:@"friend.leaveMessage.Title"];
    
    [self InitProgressHUD];

    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    UITextRange *selectedRange = [textView markedTextRange];

    NSString * newText = [textView textInRange:selectedRange];
    
    if(newText == nil || [newText isEqualToString:@""])
    {
        if (textView.text.length > 40) {
            textView.text = [textView.text substringToIndex:40];
        }
    }
    
    _textNumber.text = [NSString stringWithFormat:@"%d/40",textView.text.length];
    
    if ([textView.text isEqualToString:@""]) {
        _placeHolder.hidden = NO;
    }
    else
    {
        _placeHolder.hidden = YES;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_messageTitle release];
    [_informationTips release];
    [_information release];
    [_messageTitleImage release];
    [_sendMessageButton release];
    [_textView release];
    [_placeHolder release];
    [_textNumber release];
    [_titleLabel release];
    if (mfriendData) {
        [mfriendData release];
    }
    if (_progressHUD){
        [_progressHUD removeFromSuperview];
        [_progressHUD release];
        _progressHUD = nil;
    }
    [mRequestLocation release],mRequestLocation = nil;
    [super dealloc];
}
- (void)viewDidUnload {
    [_messageTitle release];
    _messageTitle = nil;
    [_informationTips release];
    _informationTips = nil;
    [_information release];
    _information = nil;
    [_messageTitleImage release];
    _messageTitleImage = nil;
    [_sendMessageButton release];
    _sendMessageButton = nil;
    [_textView release];
    _textView = nil;
    [_placeHolder release];
    _placeHolder = nil;
    [_textNumber release];
    _textNumber = nil;
    
    [_titleLabel release];
    
    _titleLabel = nil;
    [super viewDidUnload];
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
- (IBAction)sendMessageButton:(id)sender
{
    
    
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
    if (requestIsEnable)
    {
        if (app.mUserData.mType != USER_LOGIN_DEMO)
        {
            
            /*为等待框增加详细信息提示，提示“正在发送中”，孟磊 2013年9月3日*/
            Resources *oRes = [Resources getInstance];
            self.progressHUD.LabelText = [oRes getText:@"friend.FriendDetailViewController.sendingLocationRequest"];
            [self.progressHUD show:YES];
            
            [mRequestLocation createRequest:@"app"
                                     rqDesc:_textView.text
                                   rpUserId:mfriendData.mFriendUserID
                                        s2c:sendTocarResult];//@"15910838084"];
            
            [mRequestLocation sendRequestWithAsync:self];
        }
        else
        {
            //        线程方法
            //        [app startRequestThread];
            //        requestIsEnable = NO;
            [app updateFriendRqTimeWithFID:mfriendData.mfID rqTime:curTime];
            if (mSendRqTime) {
                [mSendRqTime release];
                mSendRqTime = nil;
            }
            mSendRqTime = [[NSString alloc]initWithFormat:@"%@",curTime];
            Resources *oRes = [Resources getInstance];
            [self MBProgressHUDMessage:[oRes getText:@"friend.FriendDetailViewController.requestLocationSended"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else
    {
        Resources *oRes = [Resources getInstance];
        [self MBProgressHUDMessage:[oRes getText:@"friend.FriendDetailViewController.requestLocationDisable"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];

    }
    
    

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



-(void)setFriendData:(FriendsData *)friendData
{
    App *app = [App getInstance];
    if (friendData) {
        mfriendData = [[app getFriendData:friendData.mfID]retain];
        NSLog(@"!!!!!!!!!!%@",mfriendData);
    }
}

-(void)setsendTocarData:(NSString *)sendTocar
{
    sendTocarResult = [NSString stringWithString:sendTocar];
}

/*!
 @method onRequestLocationResult:code:errorMsg:
 @abstract 车辆位置回调方法
 @discussion 车辆位置回调方法
 @param result 事件参数
 @param code 错误码
 @param errorMsg 错误信息
 @result 无
 */
- (void)onRequestLocationResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg
{
    NSLog(@"receive the result.");
    [self.progressHUD hide:YES];
    Resources *oRes = [Resources getInstance];
    
    if (NAVINFO_RESULT_SUCCESS == code) {
        codeState = code;
        NSLog(@"result is :%@", result);
        App *app = [App getInstance];
        //        线程方法
        //        [app startRequestThread];
        //        requestIsEnable = NO;
        NSLog(@"%@",curTime);
        [app updateFriendRqTimeWithFID:mfriendData.mfID rqTime:curTime];
        if (mSendRqTime) {
            [mSendRqTime release];
            mSendRqTime = nil;
        }
        mSendRqTime = [[NSString alloc]initWithFormat:@"%@",curTime];
        [self MBProgressHUDMessage:[oRes getText:@"friend.FriendDetailViewController.requestLocationSended"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if(code == NET_ERROR)
    {

        [self MBProgressHUDMessage:[oRes getText:@"common.noNetAlert.message"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];

    }
    else if(code == NAVINFO_FRIEND_REQUEST_FREQUENT)
    {

        [self MBProgressHUDMessage:[oRes getText:@"friend.FriendDetailViewController.requestLocationDisable"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];

    }
    else if(code == NAVINFO_FRIEND_REQUEST_FRIEND_NO_CAR)
    {

        [self MBProgressHUDMessage:[oRes getText:@"friend.FriendDetailViewController.requestLocationFriendNoCar"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];

    }
    else if(NAVINFO_TOKENID_INVALID == code)//TokenID失效处理
    {
 
        [self MBProgressHUDMessage:[oRes getText:@"common.loseTokenID.message"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];

    }
    else
    {

        [self MBProgressHUDMessage:[oRes getText:@"friend.FriendDetailViewController.requestLocationSendFailed"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
        NSLog(@"Errors on reveice result.");

    }
    
    
    /*在加入黑名单过程中禁用返回按钮，孟磊 2013年9月5日*/
    self.navigationItem.backBarButtonItem.enabled = YES;
    backBtn.enabled = YES;
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
@end
