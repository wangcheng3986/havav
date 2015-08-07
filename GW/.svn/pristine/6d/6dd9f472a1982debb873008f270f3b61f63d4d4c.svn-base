/***********************************
 * 版权所有：北京四维图新科技股份有限公司
 * 文件名称：AddFriendViewController.m
 * 文件标识：
 * 内容摘要：添加车友
 * 其他说明：
 * 当前版本：
 * 作    者：刘铁成，王立琼
 * 完成日期：2013-08-25
 * 修改记录1：
 *	修改日期：2013-08-28
 *	版 本 号：
 *	修 改 人：孟磊
 *	修改内容：取消添加车友后，重置窗体输入框
 **************************************/

#import "AddFriendViewController.h"
#import "App.h"
#import <AddressBookUI/AddressBookUI.h>
#import <AddressBook/AddressBook.h>
#import "FriendTabBarViewController.h"
#import "NSString+Extensions.h"
@interface AddFriendViewController ()
{
    BOOL hideAddFriend;
    UIBarButtonItem *leftButton;
    int mLengthOfContactBook;
    int mLeftLengthOfContactBook;
    NSMutableArray *mLocalContactsList;
    int mAddFriendCount;
}
@end

@implementation AddFriendViewController

@synthesize picUrlString = _picUrlString;
@synthesize imageView = _imageView;
@synthesize progressHUD = _progressHUD;
@synthesize showProgressHUD = _showProgressHUD;

- (id)init
{
    self = [super initWithNibName:@"AddFriendViewController" bundle:nil];
    if (self)
    {
        //是否显示等待框 孟磊 2013年9月9日
        _showProgressHUD = YES;
    }
    return self;
}



- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [mCreateContacts release];
    
    [inputFriendButton release],inputFriendButton = nil;
    [syncContactsButton release],syncContactsButton = nil;
    [nameLabel release],nameLabel = nil;
    [phoneNumberLabel release],phoneNumberLabel = nil;
    [nameTextField release],nameTextField = nil;
    [phoneNumberTextField release],phoneNumberTextField = nil;
    [cencelButton release],cencelButton = nil;
    [confirmButton release],confirmButton = nil;
    [addFriendView removeFromSuperview];
    [addFriendView release],addFriendView = nil;
    [titleLabel release],titleLabel = nil;
    [mDisView removeFromSuperview];
    [mDisView release],mDisView = nil;
    [syncTextLabel release],syncTextLabel = nil;
    [syncTitleLabel release],syncTitleLabel = nil;
    [addFriendTextLabel release],addFriendTextLabel = nil;
    [addFriendTitleLabel release],addFriendTitleLabel = nil;
    
    [_picUrlString release];
    [_imageView release];

    
    if (_progressHUD){
        [_progressHUD removeFromSuperview];
        [_progressHUD release];
        _progressHUD = nil;
    }
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //适配IOS7，替换背景图片
    if([App getVersion]>=IOS_VER_7){
        [App ios7ViewLocation:self];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_ios7_navBar_bg"] forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_ios6_navBar_bg"] forBarMetrics:UIBarMetricsDefault];
    }
    hideAddFriend=YES;
    Resources *oRes = [Resources getInstance];
    //载入文字及图片
    syncTextLabel.text=[oRes getText:@"friend.AddFriendViewController.syncContactsButtonText"];
    syncTextLabel.textColor = [UIColor colorWithRed:164.0/255.0f green:164.0/255.0f blue:164.0/255.0f alpha:1.0f];
    syncTextLabel.font = [UIFont size12];
    
    syncTitleLabel.text=[oRes getText:@"friend.AddFriendViewController.syncContactsButtonTitle"];
    syncTitleLabel.textColor = [UIColor colorWithRed:0.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:1.0f];
    syncTitleLabel.font = [UIFont size14_5];
    
    addFriendTextLabel.text=[oRes getText:@"friend.AddFriendViewController.addFriendButtonText"];
    addFriendTextLabel.textColor = [UIColor colorWithRed:164.0/255.0f green:164.0/255.0f blue:164.0/255.0f alpha:1.0f];
    addFriendTextLabel.font = [UIFont size12];
    
    addFriendTitleLabel.text=[oRes getText:@"friend.AddFriendViewController.addFriendButtonTitle"];
    addFriendTitleLabel.textColor = [UIColor colorWithRed:0.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:1.0f];
     addFriendTitleLabel.font = [UIFont size14];
    
    nameLabel.text=[oRes getText:@"friend.AddFriendViewController.nameLabelText"];
    phoneNumberLabel.text=[oRes getText:@"friend.AddFriendViewController.phoneNumberLabelText"];
    [cencelButton setTitle:[oRes getText:@"friend.AddFriendViewController.cencelButtonTitle"] forState:UIControlStateNormal];
    [confirmButton setTitle:[oRes getText:@"friend.AddFriendViewController.confirmButtonTitle"] forState:UIControlStateNormal];
//    titleLabel.text=[oRes getText:@"friend.FriendTabBarViewController.addFriendTitle"];
//    titleLabel.font =[UIFont navBarTitleSize];
    
    CGRect rect = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
    mDisView.frame = rect;
    mDisView.hidden=YES;
    [self.view addSubview:mDisView];
    rect = CGRectMake(30,-addFriendView.frame.size.height-30,addFriendView.frame.size.width,addFriendView.frame.size.height);
    nameTextField.tag = Add_Friend_View_NameTextField_tag;
    phoneNumberTextField.tag = Add_Friend_View_PhoneTextField_tag;
    nameTextField.delegate = self;
    phoneNumberTextField.delegate = self;
    nameTextField.placeholder=[oRes getText:@"friend.AddFriendViewController.nameTextField.placeholder"];
    phoneNumberTextField.placeholder=[oRes getText:@"friend.AddFriendViewController.phoneNumberTextField.placeholder"];
    addFriendView.frame = rect;
    [self.view addSubview:addFriendView];
    self.view.backgroundColor = [UIColor colorWithRed:231.0/255 green:231.0/255 blue:231.0/255 alpha:1];
    _imageView.backgroundColor = [UIColor colorWithRed:231.0/255.0f green:231.0/255.0f blue:231.0/255.0f alpha:1];
    
    mCreateContacts = [[NICreateContacts alloc]init];
    //监听键盘状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.navigationItem.titleView = nil;
//    self.tabBarController.navigationItem.titleView=titleLabel;
    
    Resources *oRes = [Resources getInstance];
    self.tabBarController.navigationItem.title = [oRes getText:@"friend.FriendTabBarViewController.addFriendTitle"];
    [super viewWillAppear:animated];
}

/*!
 @method goHome
 @abstract 返回首页
 @discussion 返回首页
 @result 无
 */
-(void)goHome
{
    [_rootController goBack];
}
/*!
 @method inputFriend
 @abstract 手动添加好友
 @discussion 手动添加好友
 @param sender 事件参数
 @result 无
 */
//手动添加好友
-(IBAction)inputFriend:(id)sender
{
    [self moveInputFriend];
}
/*!
 @method moveInputFriend
 @abstract 移动好友添加界面
 @discussion 移动好友添加界面
 @param sender 事件参数
 @result 无
 */
-(void)moveInputFriend
{
    int pos_y = 0;
    if (hideAddFriend) {
        
        if ([[App deviceString] isEqualToString:iPhone_4S] ||[[App deviceString] isEqualToString:iPhone_4]) {
            pos_y = 12;
        }else
        {
            pos_y = 62;
        }
        
        
        mDisView.hidden=NO;
        [_rootController displayDisView];
        hideAddFriend= NO;
        //17表示左边距为17
        CGRect rect = CGRectMake(17,pos_y,addFriendView.frame.size.width,addFriendView.frame.size.height);
        addFriendView.frame = rect;
        [nameTextField becomeFirstResponder];
    }else{
        pos_y = -addFriendView.frame.size.height*2;
        mDisView.hidden=YES;
        [_rootController hiddenDisView];
        hideAddFriend= YES;
        //17表示左边距为17
        CGRect rect = CGRectMake(17,pos_y,addFriendView.frame.size.width,addFriendView.frame.size.height);
        addFriendView.frame = rect;
    }
}
/*!
 @method onClickCencel
 @abstract 点击取消按钮
 @discussion 点击取消按钮
 @param sender 事件参数
 @result 无
 */
-(IBAction)onClickCencel:(id)sender
{
    [self moveInputFriend];
    [nameTextField resignFirstResponder];
    [phoneNumberTextField resignFirstResponder];
    
    [nameTextField setText:@""];
    [phoneNumberTextField setText:@""];
}
/*!
 @method onClickConfirm
 @abstract 点击确认按钮
 @discussion 点击确认按钮
 @param sender 事件参数
 @result 无
 */
-(IBAction)onClickConfirm:(id)sender
{
    //与服务器交互添加车友
    App *app = [App getInstance];
    NSString *fname = [nameTextField.text stringByTrimmingCharactersInSet:
                       [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *fphone = [phoneNumberTextField.text stringByTrimmingCharactersInSet:
                        [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [nameTextField resignFirstResponder];
    [phoneNumberTextField resignFirstResponder];
    Resources *oRes = [Resources getInstance];
    if (fname.length == 0) {
        //名字为空
        [self MBProgressHUDMessage:[oRes getText:@"friend.AddFriendViewController.nameTextNeeded"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
        
    }
    else if([fphone isEqualToString:app.mUserData.mAccount])
    {
        //添加自己
        [self MBProgressHUDMessage:[oRes getText:@"friend.AddFriendViewController.addSelfAlert"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];

    }
    else if(![App isNumText:fphone] || fphone.length != 11)
    {
        //手机号不是11位
        [self MBProgressHUDMessage:[oRes getText:@"friend.AddFriendViewController.phoneError"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];

    }
    else if(![App isNumText:fphone])
    {
        [self MBProgressHUDMessage:[oRes getText:@"friend.AddFriendViewController.phoneError"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else
    {
        if (app.mUserData.mType == USER_LOGIN_DEMO)//判断是否DEMO用户
        {
            
            App *app = [App getInstance];
            if ([app friendExistWhitPhone:fphone]) {
                [self MBProgressHUDMessage:[oRes getText:@"friend.AddFriendViewController.addContactsIsExist"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
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
                
                NSString *createTime =[App getTimeSince1970_1000];
                NSString *friendUserID = uuid;
                
                
                NSString *fPoiName=@"";
                NSString *fPoiAddress=@"";
                NSString *fPinyin=[App getPinyin:fname];
                
                [app updateFriendData:fkeyid fid:fid fname:[fname avoidSingleQuotesForSqLite] fphone:fphone flon:flon flat:flat fLastRqTime:fLastRqTime fLastUpdate:fLastUpdate sendLocationRqTime:@"" createTime:createTime friendUserID:friendUserID poiName:fPoiName poiAddress:fPoiAddress pinyin:[fPinyin avoidSingleQuotesForSqLite]];
                
                [self MBProgressHUDMessage:[oRes getText:@"friend.AddFriendViewController.addContactsSuccess"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
                
                
                [self moveInputFriend];
                
                //创建结束后，跳转到friend list界面
                [_rootController goFriendListAndJumptoNew:nameTextField.text];
                nameTextField.text=@"";
                phoneNumberTextField.text=@"";
                [nameTextField resignFirstResponder];
                [phoneNumberTextField resignFirstResponder];
            }
            
        }
        else
        {
            //使用创建车友接口，NICreateContacts
            self.progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
            [self.view addSubview:self.progressHUD];
            [self.view bringSubviewToFront:self.progressHUD];
            self.progressHUD.delegate = self;
            [self.imageView setImage:nil];
            [self.imageView setFrame:CGRectMake(160, 200, 0, 0)];
            Resources *oRes = [Resources getInstance];
            self.progressHUD.labelText = [oRes getText:@"friend.AddFriendViewController.addFriendLoading"];
            self.progressHUD.detailsLabelText= [oRes getText:@"common.load.text"];
            [self.progressHUD show:YES];
            self.tabBarController.navigationItem.leftBarButtonItem.enabled = NO;
            _rootController.backBtn.enabled = NO;
            [mCreateContacts createRequest:fname telNo:fphone];
            [mCreateContacts sendRequestWithAsync:self];
        }
        
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
    [self.progressHUD hide:YES];
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
                NSString *tempPinyin  = [[result valueForKey:@"friend"]objectForKey:@"pinyin"];
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
                [app updateFriendData:uuid fid:tempID fname:tempName fphone:tempMobile  flon:@"" flat:@"" fLastRqTime:@"" fLastUpdate:tempLastUpdate sendLocationRqTime:@"" createTime:tempCreateTime friendUserID:tempFriendUserID poiName:@"" poiAddress:@"" pinyin:[tempPinyin avoidSingleQuotesForSqLite]];
                //创建结束后，跳转到friend list界面
                [_rootController goFriendListAndJumptoNew:nameTextField.text];
                nameTextField.text=@"";
                phoneNumberTextField.text=@"";
                [self moveInputFriend];
                [self MBProgressHUDMessage:[oRes getText:@"friend.AddFriendViewController.addContactsSuccess"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
            }
            else
            {
                [self MBProgressHUDMessage:[oRes getText:@"friend.AddFriendViewController.addContactsFailed"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];

            }
            
        }
        else
        {
            [self MBProgressHUDMessage:[oRes getText:@"friend.AddFriendViewController.addContactsFailed"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];

        }
    }
    else if (NAVINFO_FRIEND_ADD_EXIST == code)//所添加的车友已存在
    {
        [self MBProgressHUDMessage:[oRes getText:@"friend.AddFriendViewController.addContactsIsExist"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];

    }
    else if (NAVINFO_FRIEND_ADD_NO_T_SERVER == code)//所添加的手机号没有开通长城T服务
    {
        [self MBProgressHUDMessage:[oRes getText:@"friend.AddFriendViewController.addContactsNoTServer"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];

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
        [self MBProgressHUDMessage:[oRes getText:@"friend.AddFriendViewController.addContactsFailed"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];

    }
    [self.imageView setFrame:CGRectMake(160, 200, 0, 0)];

    self.tabBarController.navigationItem.leftBarButtonItem.enabled = YES;
    _rootController.backBtn.enabled = YES;
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
/*!
 @method syncContacts
 @abstract 点击通讯录同步按钮
 @discussion 点击通讯录同步按钮
 @param sender 事件参数
 @result 无
 */
-(IBAction)syncContacts:(id)sender
{
    ABAddressBookRef addressBook = ABAddressBookCreate();
    __block BOOL accessGranted = NO;
    if (ABAddressBookRequestAccessWithCompletion != NULL) {
        
        // we're on iOS 6
        //NSLog(@"on iOS 6 or later, trying to grant access permission");
        
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            accessGranted = granted;
            dispatch_semaphore_signal(sema);
        });
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        dispatch_release(sema);
    }
    else { // we're on iOS 5 or older
        
        //NSLog(@"on iOS 5 or older, it is OK");
        accessGranted = YES;
    }
    
    if (accessGranted) {
        
        
        /*直接调用friendListView的同步方法 孟磊 2013年9月10日*/
        [_rootController goFriendList:YES];
    }
    else
    {
        Resources *oRes = [Resources getInstance];
        [self MBProgressHUDMessage:[oRes getText:@"friend.FriendListViewController.getLocalContactsFailAlert"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
}

-(void)logContact:person
{
    CFStringRef name = ABRecordCopyCompositeName(person);ABRecordID recId = ABRecordGetRecordID(person);
    NSLog(@"Person Name: %@ RecordID:%d",name, recId);
    ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
    for (int k = 0; k<ABMultiValueGetCount(phone); k++)
    {
        //获取电话Label
        NSString * personPhoneLabel = (NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(phone, k));
        //获取該Label下的电话值
        NSString * personPhone = (NSString*)ABMultiValueCopyValueAtIndex(phone, k);
        NSLog(@"Person phone: %@" ,personPhone);
        NSLog(@"personPhoneLabel phone: %@" ,personPhoneLabel);
        [personPhoneLabel release];
        [personPhone release];
    }
    
}

/*!
 @method backgroundTap
 @abstract 键盘相应
 @discussion 键盘相应
 @param sender 事件参数
 @result 无
 */
-(IBAction)backgroundTap:(id)sender
{
    [nameTextField resignFirstResponder];
    [phoneNumberTextField resignFirstResponder];
}
/*!
 @method mDisTap
 @abstract 键盘相应
 @discussion 键盘相应
 @param sender 事件参数
 @result 无
 */
-(IBAction)mDisTap:(id)sender
{
    [self moveInputFriend];
    [nameTextField resignFirstResponder];
    [phoneNumberTextField resignFirstResponder];
}



#pragma mark set text length
/*!
 @method textField:shouldChangeCharactersInRange:replacementString
 @abstract 设置文字长度
 @discussion 设置文字长度
 @param sender 事件参数
 @result 无
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    
    if (nameTextField == textField)  //判断是否时我们想要限定的那个输入框
    {
        if ([toBeString length] > 32) { //如果名字输入框内容大于32则弹出警告
            textField.text = [toBeString substringToIndex:32];
            return NO;
        }
    }
//    if (phoneNumberTextField == textField)  //判断是否时我们想要限定的那个输入框
//    {
//        toBeString = [toBeString deleteIllegalCharacter];
//        if ([toBeString length] > 11) { //如果手机号输入框内容大于11则弹出警告
//            textField.text = [toBeString substringToIndex:11];
//            return NO;
//        }
//        else
//        {
//            textField.text = toBeString;
//            return NO;
//        }
//        
//    }
    return YES;
}
/*!
 @method textFieldDoneEditing
 @abstract 键盘相应
 @discussion 键盘相应
 @param sender 事件参数
 @result 无
 */
-(IBAction)textFieldDoneEditing:(id)sender
{
    
    [sender resignFirstResponder];
    
}

/*!
 @method keyboardWillShow
 @abstract 键盘显示
 @discussion 键盘显示
 @param sender 事件参数
 @result 无
 */
- (void)keyboardWillShow:(NSNotification *)notification
{
    NSLog(@"开始弹出");
    
    //        根据设备屏幕大小判断
    
    enum SCREEN_SIZE   deviceSize = [App getScreenSize];
    if (deviceSize == SCREEN_SIZE_960_640)
    {
        if (addFriendView.frame.origin.y == 29) {
            [UIView animateWithDuration:0.25 animations:^{
                addFriendView.frame = CGRectMake(addFriendView.frame.origin.x, addFriendView.frame.origin.y-32, addFriendView.frame.size.width, addFriendView.frame.size.height);
            } completion:nil];
        }
    }
}


/*!
 @method keyboardWillHide
 @abstract 键盘消失
 @discussion 键盘消失
 @param sender 事件参数
 @result 无
 */
- (void)keyboardWillHide:(NSNotification *)notification
{
    NSLog(@"键盘收回");
    //        根据设备屏幕大小判断
    
    enum SCREEN_SIZE   deviceSize = [App getScreenSize];
    if (deviceSize == SCREEN_SIZE_960_640)
    {
        if (addFriendView.frame.origin.y == -3) {
            [UIView animateWithDuration:0.25 animations:^{
                addFriendView.frame = CGRectMake(addFriendView.frame.origin.x, addFriendView.frame.origin.y+32, addFriendView.frame.size.width, addFriendView.frame.size.height);
            } completion:nil];
        }
    }
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
