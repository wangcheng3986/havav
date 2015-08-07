/*!
 @header MainViewController.m
 @abstract 主界面类
 @author mengy
 @version 1.00 13-4-15 Creation
 */
#import "MainViewController.h"
#import "App.h"
#import "FriendTabBarViewController.h"
#import "MapTabBarViewController.h"
#import "MessageViewController.h"
#import "SetViewController.h"
#import "carTabBarViewController.h"

enum LOGOUT_TYPE
{
    LOGOUT_YES=1,//显示登出按钮
    LOGOUT_NO=0,//显示登录按钮
};

@interface MainViewController ()
{
    NSString *imageName;
    NSString *callNumber;
    UIBarButtonItem *leftButton;
    UIBarButtonItem *rightButton;
    BOOL hiddenKey;
    int errorTime;
    // 用户基本信息属性
    NSString *userKeyID;
    NSString *account;
    NSString *password;
    int loginType;
    int isFirstLogin;
    NSString *carVin;
    NSString *safe_pwd;
    int flag;
    NSString * lon;
    NSString * lat;
    int loginState;
    int logout;
//    int friendLoad;
    NSString *lastNameKey;
    NSString *lastPasswordKey;
    BOOL lastHiddenKey;
    int operate;
    NSString *phone;
    NSString *mSelfPhone;
    UIAlertView *malert;
    NSString *tokenID;
    
    NSString *new_lat;
    NSString *new_lon;
    NSString *loginID;
    BOOL isAutomaticLogin;
    enum SCREEN_SIZE deviceSize;//设备屏幕大小（屏幕大小）
}
@end

@implementation MainViewController
@synthesize picUrlString = _picUrlString;
@synthesize imageView = _imageView;
@synthesize progressHUD = _progressHUD;
@synthesize mMessage;
@synthesize poiLoad;
@synthesize urlDic;
@synthesize urlJump;
@synthesize shouldGoVehicleControl;

- (id)init
{
    self = [super initWithNibName:@"MainViewController" bundle:nil];
    if (self)
    {
    }
    return self;
}
- (void)dealloc
{
    if (mSelectCar) {
        [mSelectCar release];
    }
    if (imageName) {
        [imageName release];
    }
    if (mLogout) {
        [mLogout release];
    }
    if (callNumber) {
        [callNumber release];
    }
    if (leftButton) {
        [leftButton release];
    }
    if (rightButton) {
        [rightButton release];
    }
    if (lastPasswordKey) {
        [lastPasswordKey release];
    }
    if (lastNameKey) {
        [lastNameKey release];
    }
    if (mapController) {
        [mapController release];
    }
    if (tokenID) {
        [tokenID release];
    }
    if (phone) {
        [phone release];
    }
    if (mLogin) {
        [mLogin release];
    }
    if (mDisView) {
        [mDisView removeFromSuperview];
        [mDisView release];
    }
    if (loginView) {
        [loginView removeFromSuperview];
        [loginView release];
    }
    if (carList) {
        [carList removeAllObjects];
        [carList release];
        carList = nil;
    }
    
    if (selectCarPageControl) {
        [selectCarPageControl removeFromSuperview];
        [selectCarPageControl release];
        selectCarPageControl = nil;
    }
    if (selectCarViewBg) {
        [selectCarViewBg removeFromSuperview];
        [selectCarViewBg release];
        selectCarViewBg = nil;
    }
    if (selectCarView) {
        [selectCarView removeFromSuperview];
        [selectCarView release];
        selectCarView = nil;
    }
    
    if (rescueButton) {
        [rescueButton release];
        rescueButton = nil;
    }
    if (friendButton) {
        [friendButton release];
        friendButton = nil;
    }
    if (mapButton) {
        [mapButton release];
        mapButton = nil;
    }
    if (messageButton) {
        [messageButton release];
        messageButton = nil;
    }
    if (setButton) {
        [setButton release];
        setButton = nil;
    }
    if (loveCarButton) {
        [loveCarButton release];
        loveCarButton = nil;
    }
    if (messageCountLabel) {
        [messageCountLabel release];
        messageCountLabel = nil;
    }
    if (messageCountImage) {
        [messageCountImage release];
        messageCountImage = nil;
    }
    if (selectCarScrollView) {
        [selectCarScrollView release];
        selectCarScrollView = nil;
    }
    if (rememberPasswordImageView) {
        [rememberPasswordImageView release];
        rememberPasswordImageView = nil;
    }
    if (nameLable) {
        [nameLable release];
        nameLable = nil;
    }
    if (passwordLable) {
        [passwordLable release];
        passwordLable = nil;
    }
    if (rememberPasswordLable) {
        [rememberPasswordLable release];
        rememberPasswordLable = nil;
    }
    if (nameTextField) {
        [nameTextField release];
        nameTextField = nil;
    }
    if (passwordTextField) {
        [passwordTextField release];
        passwordTextField = nil;
    }
    if (rememberPasswordButton) {
        [rememberPasswordButton release];
        rememberPasswordButton = nil;
    }
    if (loginButton) {
        [loginButton release];
        loginButton = nil;
    }
    if (imitationLoginButton) {
        [imitationLoginButton release];
        imitationLoginButton = nil;
    }
    if (firstLoginBtn) {
        [firstLoginBtn release];
        firstLoginBtn = nil;
    }
    if(resetPwdBtn)
    {
        [resetPwdBtn release];
        resetPwdBtn = nil;
    }
    if (annotationLable) {
        [annotationLable release];
        annotationLable = nil;
    }
    if (annotationLable2) {
        [annotationLable2 release];
        annotationLable2 = nil;
    }
    if (titleView) {
        [titleView release];
        titleView = nil;
    }
    if (titleLabel) {
        [titleLabel release];
        titleLabel = nil;
    }
    if (functionView) {
        [functionView release];
        functionView = nil;
    }
    if (rightBtn) {
        [rightBtn release];
        rightBtn = nil;
    }
    if (leftBtn) {
        [leftBtn release];
        leftBtn = nil;
    }
    if (mainBg) {
        [mainBg release];
        mainBg = nil;
    }
    
    if (self.progressHUD){
        [self.progressHUD removeFromSuperview];
        [self.progressHUD release];
        self.progressHUD = nil;
    }
    

    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}


/*!
 @method viewDidLoad
 @abstract 重写viewDidLoad方法，初始化界面显示以及数据信息
 @discussion 重写viewDidLoad方法，初始化界面显示以及数据信息
 @param 无
 @result 无
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //初始化
    safe_pwd=@"";
    flag=0;
    lon=@"0";
    lat=@"0";
    CGRect rect;
    logout=LOGOUT_NO;
    App *app=[App getInstance];
    [app initDatabase];
    messageCountLabel.hidden=YES;
    messageCountLabel.font = [UIFont size13];
    titleView.hidden=YES;
    lastNameKey=[[NSString alloc]init];
    lastPasswordKey=[[NSString alloc]init];
    tokenID=[[NSString alloc]init];
    mLogin = [[NILogin alloc]init];
    mLogout = [[NILogout alloc]init];
    mSelectCar = [[NISelectCar alloc]init];
    carList = [[NSMutableArray alloc]initWithCapacity:0];
    rememberPasswordImageView.hidden=YES;
    deviceSize = [App getScreenSize] ;
    Resources *oRes = [Resources getInstance];
    mOpenSelectCar=NO;
    errorTime=0;
    rect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:mDisView];
    mDisView.hidden=YES;
    
    if([App getVersion]>=IOS_VER_7){
        [App ios7ViewLocation:self];
        [self setNeedsStatusBarAppearanceUpdate];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_ios7_navBar_bg"] forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_ios6_navBar_bg"] forBarMetrics:UIBarMetricsDefault];
    }
    //        根据设备屏幕大小调整按钮位置
    if (deviceSize == SCREEN_SIZE_960_640)
    {
        [rescueButton setImage:[UIImage imageNamed:@"main_iphone4_bcall_btn_bg"] forState:UIControlStateNormal];
        [friendButton setImage:[UIImage imageNamed:@"main_iphone4_friend_btn_bg"] forState:UIControlStateNormal];
        [mapButton setImage:[UIImage imageNamed:@"main_iphone4_map_btn_bg"] forState:UIControlStateNormal];
        [loveCarButton setImage:[UIImage imageNamed:@"main_iphone4_loveCar_btn_bg"] forState:UIControlStateNormal];
        mainBg.image=[UIImage imageNamed:@"main_iphone4_bg"];
        [mapButton setFrame:CGRectMake(24, mapButton.frame.origin.y+75, 86, 101)];
        [loveCarButton setFrame:CGRectMake(210, loveCarButton.frame.origin.y+75, 86,101)];
        [friendButton setFrame:CGRectMake(24, friendButton.frame.origin.y+44, 86, 101)];
        [rescueButton setFrame:CGRectMake(210, rescueButton.frame.origin.y+44, 86,101)];
        
        selectCarView = [[UIView alloc]initWithFrame:CGRectMake(0, -2*240, 320, 240)];
        selectCarViewBg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 240)];
        selectCarScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 240)];
        [selectCarViewBg setImage:[UIImage imageNamed:@"main_iPhone4_selectCar_bg"]];
    }
    else
    {
        [rescueButton setImage:[UIImage imageNamed:@"main_iphone5_bcall_btn_bg"] forState:UIControlStateNormal];
        [friendButton setImage:[UIImage imageNamed:@"main_iphone5_friend_btn_bg"] forState:UIControlStateNormal];
        [mapButton setImage:[UIImage imageNamed:@"main_iphone5_map_btn_bg"] forState:UIControlStateNormal];
        [loveCarButton setImage:[UIImage imageNamed:@"main_iphone5_loveCar_btn_bg"] forState:UIControlStateNormal];
        mainBg.image=[UIImage imageNamed:@"main_iphone5_bg"];
        selectCarView = [[UIView alloc]initWithFrame:CGRectMake(0, -2*284, 320, 284)];
        selectCarViewBg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 284)];
        selectCarScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 284)];
        [selectCarViewBg setImage:[UIImage imageNamed:@"main_iPhone5_selectCar_bg"]];
    }
    [selectCarScrollView setShowsHorizontalScrollIndicator:NO];
    selectCarScrollView.delegate = self;
    [selectCarView addSubview:selectCarViewBg];
    [selectCarView addSubview:selectCarScrollView];
    [self.view addSubview:selectCarView];
    rect = CGRectMake(14,51, loginView.frame.size.width, loginView.frame.size.height);
    loginView.frame = rect;
    loginView.hidden = YES;
    
    [self.view addSubview:loginView];
    rightBtn = [[RightButton alloc]init];
    [rightBtn setTitle:[oRes getText:@"Main.MainViewController.loginButton.title"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(loginView) forControlEvents:UIControlEventTouchDown];
    rightButton=[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightButton;

    leftBtn = [[LeftButton alloc]init];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"main_selectcar_btn_unselected"] forState:UIControlStateNormal];
    [leftBtn setTitle:nil forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(onClickSelectCar) forControlEvents:UIControlEventTouchDown];
    leftButton=[[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftButton;
    leftBtn.hidden = YES;
    
    nameLable.text=[oRes getText:@"Main.MainViewController.nameLable.text"];
    passwordLable.text=[oRes getText:@"Main.MainViewController.passwordLable.text"];
    nameLable.textColor = [UIColor whiteColor];
    passwordLable.textColor = [UIColor whiteColor];
    
    //正常
    nameLable.font = [UIFont inputTitleSize];
    passwordLable.font = [UIFont inputTitleSize];
    nameTextField.delegate = self;
    passwordTextField.delegate = self;
    nameTextField.placeholder=[oRes getText:@"Main.MainViewController.nameTextField.placeholder"];
    passwordTextField.placeholder=[oRes getText:@"Main.MainViewController.passwordTextField.placeholder"];
    rememberPasswordLable.text=[oRes getText:@"Main.MainViewController.rememberPasswordLable.text"];
    rememberPasswordLable.textColor = [UIColor whiteColor];
    nameTextField.font=[UIFont inputTextSize];
    passwordTextField.font=[UIFont inputTextSize];
    rememberPasswordLable.font=[UIFont inputTextSize];
    
    annotationLable.text=[NSString stringWithFormat:@"%@",[oRes getText:@"Main.MainViewController.annotationLable1.text"]];
    annotationLable2.text=[NSString stringWithFormat:@"%@",[oRes getText:@"Main.MainViewController.annotationLable2.text"]];
    annotationLable.textColor = [UIColor colorWithRed:0.255 green:0.255 blue:0.255 alpha:1];
    annotationLable2.textColor = [UIColor colorWithRed:0.255 green:0.255 blue:0.255 alpha:1];
    annotationLable.font=[UIFont size11];
    annotationLable2.font=[UIFont size11];
//    设置没有下划线
//    firstLoginBtn.noLine = YES;
    firstLoginBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [firstLoginBtn setTitle:[oRes getText:@"Main.MainViewController.firstLoginButton.title"] forState:UIControlStateNormal];
    firstLoginBtn.titleLabel.font=[UIFont size12];
    UIColor *titleColor = [[UIColor alloc] initWithRed:0 green:0.306 blue:0.784 alpha:1];
    [firstLoginBtn setTitleColor:titleColor forState:UIControlStateNormal];
    resetPwdBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [resetPwdBtn setTitle:[oRes getText:@"Main.MainViewController.forgetPwdButton.title"] forState:UIControlStateNormal];
    resetPwdBtn.titleLabel.font=[UIFont size12];
    [resetPwdBtn setTitleColor:titleColor forState:UIControlStateNormal];
    
    [titleColor release];
     [loginButton setTitle:[oRes getText:@"Main.MainViewController.loginButton.title"] forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont btnTitleSize];
    [imitationLoginButton setTitle:[oRes getText:@"Main.MainViewController.imitationLoginButton.title"] forState:UIControlStateNormal];
    imitationLoginButton.titleLabel.font = [UIFont btnTitleSize];
    loginType = USER_LOGIN_OTHER;
    messageCountImage.hidden=YES;
    titleLabel.font =[UIFont size15];
    
    self.navigationController.navigationBarHidden = NO;
    [self changeNavItemLoc];
    isAutomaticLogin = NO;
    
    
    //当进入视图时，重新设置imageView
    [self.imageView setImage:nil];
    [self.imageView setFrame:CGRectMake(160, 200, 0, 0)];
    //显示加载等待框
    self.progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.progressHUD];
    [self.view bringSubviewToFront:self.progressHUD];
    self.progressHUD.delegate = self;
    [self loginView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNewMessage:) name:Notification_New_Message object:nil];
}


/*!
 @method viewWillAppear:
 @abstract 重写viewWillAppear方法，重新获取未读消数目，并显示在界面上
 @discussion 重写viewWillAppear方法，重新获取未读消数目，并显示在界面上
 @param 无
 @result 无
 */
- (void)viewWillAppear:(BOOL)animated
{
    
    App *app=[App getInstance];
    UserData *curUserData = [app getUserData];
//    刷新消息数量
    if (curUserData.mUserID.length > 0)
    {
        messageCount=[[app loadMessageInfoData:0 userID:curUserData.mUserID ] count];
        [self loadMessageCount];
    }
    
    [super viewWillAppear:animated];
}

/*!
 @method viewDidAppear:
 @abstract 重写viewDidAppear方法，
 @discussion 重写viewDidAppear方法，在界面显示的时候，判断是否为点击链接打开的手机app，如果是打开地图界面并扎点
 @param 无
 @result 无
 */
- (void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    [self urlShouldGoMap];
    /**
     *跳转至车辆控制界面，暂时无用
    if (shouldGoVehicleControl) {
        [self goVehicleControlVC];
    }
     */

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

/*!
 @method loadMessageCount
 @abstract 将最新消息数目显示在界面上，
 @discussion 将最新消息数目显示在界面上
 @param 无
 @result 无
 */
-(void)loadMessageCount
{
    if (messageCount > 0)
    {
        messageCountLabel.hidden=NO;
        messageCountImage.hidden=NO;
        if (messageCount>=100) {
            messageCountLabel.text=[NSString stringWithFormat:@"99+"];
            messageCountImage.frame = CGRectMake(messageCountImage.frame.origin.x, messageCountImage.frame.origin.y, 36, messageCountImage.frame.size.height);
            messageCountLabel.frame = CGRectMake(messageCountLabel.frame.origin.x, messageCountLabel.frame.origin.y, 46, messageCountLabel.frame.size.height);
        }
        else
        {
            messageCountLabel.text=[NSString stringWithFormat:@"%d",messageCount];
            messageCountImage.frame = CGRectMake(messageCountImage.frame.origin.x, messageCountImage.frame.origin.y, 26, messageCountImage.frame.size.height);
            messageCountLabel.frame = CGRectMake(messageCountLabel.frame.origin.x, messageCountLabel.frame.origin.y, 36, messageCountLabel.frame.size.height);
        }
    }
    else
    {
        messageCountLabel.hidden=YES;
        messageCountImage.hidden=YES;
    }
}


/*!
 @method changeNavItemLoc
 @abstract 改变导航栏按钮位置
 @discussion 改变导航栏按钮位置
 @param 无
 @result 无
 */
-(void)changeNavItemLoc
{
    if (self.navigationItem.rightBarButtonItems.count>0) {
		UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
		if([App getVersion]<IOS_VER_7) {
			space.width = -5.0;
		} else {
			space.width = -16.0;
		}
		self.navigationItem.rightBarButtonItems = [@[space] arrayByAddingObjectsFromArray:self.navigationItem.rightBarButtonItems];
	}
    if (self.navigationItem.leftBarButtonItems.count>0) {
		UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
		if([App getVersion]<IOS_VER_7) {
			space.width = -5.0;
		} else {
			space.width = -16.0;
		}
		self.navigationItem.leftBarButtonItems = [@[space] arrayByAddingObjectsFromArray:self.navigationItem.leftBarButtonItems];
	}
}

/*!
 @method urlShouldGoMap
 @abstract 判断url是否符合格式标准
 @discussion 判断url是否符合格式标准，若符合调用urlGoMap:方法打开地图并扎点
 @param 无
 @result 无
 */
-(void)urlShouldGoMap
{
    if ([urlDic objectForKey:@"lat"]!=nil && [urlDic objectForKey:@"lon"]!=nil && [urlDic objectForKey:@"title"]!=nil && [urlDic objectForKey:@"address"]!=nil && urlJump==1) {
        [self urlGoMap:urlDic];
        urlJump=0;
        loginView.hidden = YES;
        mDisView.hidden = YES;
        rightButton.enabled=YES;
    }
}


/*!
 @method urlError
 @abstract url错误时调用方法
 @discussion url错误时调用方法，弹出alert
 @param 无
 @result 无
 */
-(void)urlError
{
    Resources *oRes = [Resources getInstance];
    [self MBProgressHUDMessage:[oRes getText:@"Main.MainViewController.urlError.alertMessage"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
}


/*!
 @method goVehicleControlVC
 @abstract 跳转至车辆控制界面
 @discussion 跳转至车辆控制界面，暂时无用
 @param 无
 @result 无
 */
-(void)goVehicleControlVC
{
    NSLog(@"跳转至车辆控制界面");
    [self goloveCar:nil];
    shouldGoVehicleControl = 0;
}

/*!
 @method goOpenAccountWebView
 @abstract 打开开通T服务界面
 @discussion 打开开通T服务界面
 @param 无
 @result 无
 */
-(IBAction)goOpenAccountWebView:(id)sender
{
//    NSString *url = [NSString stringWithFormat:@"%@",PORTAL_SERVER_URL];
//    App *app = [App getInstance];
//    [app openBrowser:url];
    OpenTSeviceViewController *openTSeviceVC = [[OpenTSeviceViewController alloc]init];
    [self.navigationController pushViewController:openTSeviceVC animated:YES];
    [openTSeviceVC release];
    
}
/*!
 @method goResetPwd
 @abstract 打开重置密码界面
 @discussion 打开重置密码界面
 @param 无
 @result 无
 */
-(IBAction)goResetPwd:(id)sender
{
    ResetPwdViewController *resetPwdVC = [[ResetPwdViewController alloc]init];
    [self.navigationController pushViewController:resetPwdVC animated:YES];
    [resetPwdVC release];
    
}


/*!
 @method login
 @abstract 点击登录执行方法
 @discussion 点击登录执行方法，包括对输入框校验，若校验无误弹出等待框并进行网络请求，若有问题弹出alert
 @param 无
 @result 无
 */
-(IBAction)login:(id)sender
{
    isAutomaticLogin = NO;
    account  = [nameTextField.text copy];
    Resources *oRes = [Resources getInstance];
    
    if(account == nil || account.length == 0 || account.length < 11 || ![App isNumText:account])
    {
        //账号格式错误
        [self MBProgressHUDMessage:[oRes getText:@"Login.UserInputViewController.nameFailAlert.Title"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else if(password == nil || password.length == 0 || password.length < 6)
    {
        //密码格式错误
        [self MBProgressHUDMessage:[oRes getText:@"Login.UserInputViewController.passwordFailAlert.Title"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else
    {
        self.progressHUD.labelText = [oRes getText:@"Login.loading.text"];
        self.progressHUD.detailsLabelText= [oRes getText:@"common.load.text"];
        [self.progressHUD show:YES];
        [nameTextField resignFirstResponder];
        [passwordTextField resignFirstResponder];
        //后台登陆验证
        operate=OPERATE_LOGIN;
        NSDictionary *para;
        para = [NSDictionary dictionaryWithObjectsAndKeys:
                account,@"loginName",// 用户名
                password,@"password",// 密码
                nil];
        [mLogin createRequest:para];
        [mLogin sendRequestWithAsync:self];
    }
}

/*!
 @method automaticLogin
 @abstract 重新登录
 @discussion 重新登录，若账号密码有误弹出错误提示
 @param 无
 @result 无
 */
-(void)automaticLogin
{
    isAutomaticLogin = YES;
    Resources *oRes = [Resources getInstance];
    //后台登陆验证
    operate=OPERATE_LOGIN;
//    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    account = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserDefaultLastNameKey"];
    password =[[NSUserDefaults standardUserDefaults] objectForKey:@"UserDefaultLastPasswordKey"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"UserDefaultLogin"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSLog(@"automaticLogin name= %@ pwd= %@",account,password);
    if (account != nil && password != nil) {
        
        rightBtn.enabled = NO;
        leftBtn.enabled = NO;
        self.progressHUD.labelText = [oRes getText:@"Login.loading.text"];
        self.progressHUD.detailsLabelText= [oRes getText:@"common.load.text"];
        [self.progressHUD show:YES];
        NSDictionary *para;
        para = [NSDictionary dictionaryWithObjectsAndKeys:
                account,@"loginName",// 用户名
                password,@"password",// 密码
                nil];
        [mLogin createRequest:para];
        [mLogin sendRequestWithAsync:self];
    }
    else
    {
        [self loginFailure];
    }
}




/*!
 @method Logout
 @abstract 点击登出执行方法
 @discussion 点击登出执行方法，非demo进行网络请求，停止消息轮询，重置缓存信息
 @param 无
 @result 无
 */
-(void)Logout
{
    App *app=[App getInstance];
    if (loginType == USER_LOGIN_CAR)
    {
        [mLogout createRequest];
        [mLogout sendRequestWithAsync:self];
        //消息接收停止
        NSLog(@"停止额消息获取");
//        [mMessage stop];
    }
    //初始化数据
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"UserDefaultLogin"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [NIOpenUIPRequest setTokenID:@""];
    loginType = USER_LOGIN_OTHER;
    logout=LOGOUT_NO;
    [app setFriendLoadType:FRIEND_LOAD_YES];
    [app setBlackLoadType:BLACK_LOAD_YES];
    [app setElecLoadType:ELEC_LOAD_YES];
    loginState=0;
    messageCount=0;
    messageCountLabel.hidden=YES;
    messageCountImage.hidden=YES;
    titleLabel.text = @"";
    titleView.hidden=YES;
    titleLabel.hidden=YES;
    leftBtn.hidden = YES;
    [app logout];
    
    //设置登录按钮的标签内容 孟磊  2013年9月24日
    Resources *oRes = [Resources getInstance];
    [rightBtn setTitle:[oRes getText:@"Main.MainViewController.loginButton.title"] forState:UIControlStateNormal];
}

/*!
 @method addDemoData
 @abstract 添加demo数据
 @discussion demo登录时，添加demo数据
 @param 无
 @result 无
 */
-(void)addDemoData
{
    App *app=[App getInstance];
    [app loadDemoData];
    [app loadDemoUserData];
    app.loginID = DEMO_LOGINID;
    
}

/*!
 @method LoginState
 @abstract 登录状态
 @discussion 登录结果返回后，根据登录状态进行相应操作
 @param 无
 @result 无
 */
-(void)LoginState
{
    switch (loginState)
    {
        case USER_LOGIN_WRONG_PASSWORD://用户密码错误
            [self nameOrPasswordError];
            break;
        case USER_LOGIN_SUCCESS://正常登陆
        {
//            NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
            Resources *oRes = [Resources getInstance];
            [self MBProgressHUDMessage:[oRes getText:@"Main.MainViewController.loginSuccess.title"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"UserDefaultLogin"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self userLogin];
            if (!mMessage) {
                mMessage = [[NIMessagePoll alloc] init];
            }
            //获取消息
            NSLog(@"------>登录完毕即将获取消息");
            [mMessage getMessage];
            /**
             *
            if (!mMessage) {
                mMessage = [[NIMessagePoll alloc] init];
            }
            //开始消息的心跳式接收
            [mMessage start];
             */
            break;
        }
        case USER_LOGIN_WITHOTHER:
            NSLog(@"//有其他用户正在使用");
            break;
        case USER_LOGIN_NO_NET:
        {
            NSLog(@"//网络连接失败");
            [self noNetwork];
            break;
        }
        case USER_LOGIN_FAILURE:
        {
            NSLog(@"//登录失败");
            [self loginFailure];
            break;
        }
        case USER_LOGIN_ACCOUNT_NOEXIST:
        {
            NSLog(@"//账户不存在");
            [self loginAccountNOExist];
            break;
        }
        case USER_LOGIN_NO_VEHICLES:
        {
            NSLog(@"//没有车");
            [self loginNOVehicles];
            break;
        }
        case USER_LOGIN_NO_DREDGE_OR_CLOSE:
        {
            NSLog(@"//未开通t服务或服务停止");
            [self loginNoDredgeOrClose];
            break;
        }
        default:
            break;
    }
}


/*!
 @method onLoginResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg
 @abstract 登录回调函数
 @discussion 登录结果返回后，根据结果进行操作，如果登录成功，将用户数据和车辆数据存入本地数据库
 @param result 登录返回结果
 @param code 状态code
 @param errorMsg 错误信息
 @result 无
 */
//1	tokenId	string	token-id	◎
//2	userId	string	记录id	◎
//3	vehicleList	list<object>	车辆信息	◎
//3-1	vin	string	车架号	◎
//3-2	licenseNumber	string	车牌号
//3-3	vtype	string	车型名称	◎
//3-4	lon	double	经度
//3-5	lat	double	纬度
//3-6	lastUpdate	time	最后位置上传时间
//3-7	serviceType	string	车辆服务类型。0：lemon;1:cherry	◎
//4	selectedVin	string	车主上次操作车辆车架号
//5	b-call	string	救援电话	◎
- (void)onLoginResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg
{
    NSLog(@"%@",account);
    App *app=[App getInstance];
    if ( code == NAVINFO_RESULT_SUCCESS )
    {
        if (result != nil) {
            //存储tokenid，后续网络请求留用
            if ([result objectForKey:@"tokenId"])
            {
                tokenID=[result objectForKey:@"tokenId"];
                [NIOpenUIPRequest setTokenID:tokenID];
            }
            else
            {
                [NIOpenUIPRequest setTokenID:@""];
            }
            loginID=[NSString stringWithFormat:@"%@",[result objectForKey:@"userId"]];
            app.loginID = loginID;
            if ([result objectForKey:@"vehicleList"]) {
                NSLog(@"%@",[result objectForKey:@"vehicleList"]);
                NSString *str=[NSString stringWithFormat:@"%@",[result objectForKey:@"vehicleList"]];
                NSArray *temp;
                if ([[str stringByTrimmingCharactersInSet:
                      [NSCharacterSet whitespaceAndNewlineCharacterSet]]isEqualToString:@"{\n}"]||[[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]isEqualToString:@"{}"])
                {
                    temp=[[NSArray alloc]init];
                }
                else
                {
                    temp =[[NSArray alloc]initWithArray:[result objectForKey:@"vehicleList"]];
                }
                if (temp.count==0) {
                    //                当无车辆列表的时候视为登录失败
                    loginState = USER_LOGIN_NO_VEHICLES;  //没有车
                }
                else
                {
                    int cherryCar = 0;
                    //存储车辆信息
                    [app deleteCarWithUserID:loginID];
                    loginType = USER_LOGIN_CAR;//有车注册用户USER_LOGIN_WITHCAR，由于取消注册有车账户种类，现将其视为车辆用户
                    for (int i=0; i<temp.count; i++) {
                        NSString *uuid = [App createUUID];
                        NSString *ID = @"";
                        NSString *vin = @"";
                        NSString *name = @"";
                        NSString *licenseNumber = @"";
                        NSString *engineNo = @"";
                        NSString *terminalId = @"";
                        NSString *type = @"";
                        NSString *carLon = @"0.0";
                        NSString *carLat = @"0.0";
                        NSString *lastUpdateTime = @"";
                        NSString *service = @"";
                        if ([[temp objectAtIndex:i]objectForKey:@"vin"]) {
                            vin = [[temp objectAtIndex:i]objectForKey:@"vin"];
                        }
                        else
                        {
                            vin = @"";
                        }
                        if ([[temp objectAtIndex:i]objectForKey:@"licenseNumber"]) {
                            licenseNumber = [[temp objectAtIndex:i]objectForKey:@"licenseNumber"];
                        }
                        else
                        {
                            int length = [vin length];
                            if (length >= 4) {
                                licenseNumber = [vin substringFromIndex:length-4];
                            }
                            else
                            {
                                licenseNumber =@"";
                            }
                            
                        }
                        if ([[temp objectAtIndex:i]objectForKey:@"vtype"]) {
                            type = [[temp objectAtIndex:i]objectForKey:@"vtype"];
                        }
                        if ([[temp objectAtIndex:i]objectForKey:@"lon"]) {
                            carLon = [[temp objectAtIndex:i]objectForKey:@"lon"];
                        }
                        if ([[temp objectAtIndex:i]objectForKey:@"lat"]) {
                            carLat = [[temp objectAtIndex:i]objectForKey:@"lat"];
                        }
                        if ([[temp objectAtIndex:i]objectForKey:@"lastUpdate"])
                        {
                            lastUpdateTime = [App getDateWithTimeSince1970:[NSString stringWithFormat:@"%@",[[temp objectAtIndex:i]objectForKey:@"lastUpdate"]]];
                        }
                        if ([[temp objectAtIndex:i]objectForKey:@"serviceType"])
                        {
                            service = [[temp objectAtIndex:i]objectForKey:@"serviceType"];
                            if([service intValue] == 1)
                            {
                                cherryCar = 1;
                            }
                        }
                        [app updateCarData:uuid carID:ID vin:vin type:type name:name carRegisCode:@"" carNumber:licenseNumber motorCode:engineNo userID:loginID sim:terminalId lon:carLon lat:carLat lastRpTime:lastUpdateTime service:service];
                    }
                    
                    if (cherryCar == 1) {
                        app.userAccountState = USER_ACCOUNT_STATE_ALL_FUNCTION;
                    }
                    else
                    {
                        app.userAccountState = USER_ACCOUNT_STATE_PART_FUNCTION;
                    }
                    
                    if([result objectForKey:@"selectedVin"])
                    {
                        carVin =[result objectForKey:@"selectedVin"];
                    }
                    else
                    {
                        carVin = @"";
                    }
                    
                    mSelfPhone = account;
                    app.selfPhone = mSelfPhone;
                    if ([result objectForKey:@"b-call"]) {
                        app.bCall = [result objectForKey:@"b-call"];
                    }
                    else
                    {
                        app.bCall = @"";
                    }
                    loginState = USER_LOGIN_SUCCESS;//登陆成功
                    logout=LOGOUT_YES;
                }
                
                [temp release];
                temp=nil;
            }
            else
            {
                //            返回数据错误
                loginState =USER_LOGIN_FAILURE;//登录失败
            }

        }
        else
        {
            //            返回数据错误
            loginState =USER_LOGIN_FAILURE;//登录失败
        }
    }
    else if(code == NET_ERROR)
    {
        loginState =USER_LOGIN_NO_NET;//网络连接失败
        
    }
    else if(code == NAVINFO_LOGIN_PWD_ERROR)//用户名密码错误
    {
        loginState =USER_LOGIN_WRONG_PASSWORD;
    }
    else if(code == NAVINFO_LOGIN_ACCOUNT_NOEXIST)//账户不存在
    {
        loginState =USER_LOGIN_ACCOUNT_NOEXIST;
    }
    else if(code == NAVINFO_LOGIN_NO_VEHICLES)//没有车
    {
        loginState =USER_LOGIN_NO_VEHICLES;
    }
    else if(code == NAVINFO_LOGIN_NO_DREDGE_OR_CLOSE)//未开通服务或服务停止
    {
        loginState =USER_LOGIN_NO_DREDGE_OR_CLOSE;
    }
    else
    {
        loginState =USER_LOGIN_FAILURE;//登录失败
        NSLog(@"Errors on reveice result.");
    }
    
    rightBtn.enabled = YES;
    leftBtn.enabled = YES;
    [self.progressHUD hide:YES];
    
    [self LoginState];
}


/**
- (void)onLoginResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg
{
    NSLog(@"%@",account);
    App *app=[App getInstance];
    if ( code == NAVINFO_RESULT_SUCCESS )
    {
        //存储tokenid，后续网络请求留用
        if ([result objectForKey:@"tokenId"])
        {
            tokenID=[result objectForKey:@"tokenId"];
            [NIOpenUIPRequest setTokenID:tokenID];
        }
        else
        {
            [NIOpenUIPRequest setTokenID:@""];
        }
        
        if ([result objectForKey:@"user"]) {
            loginID=[NSString stringWithFormat:@"%@",[[result objectForKey:@"user"] objectForKey:@"id"]];
            app.loginID = loginID;
            NSLog(@"%@",loginID);
            if ([result objectForKey:@"vehicleList"]) {
                NSLog(@"%@",[result objectForKey:@"vehicleList"]);
                NSString *str=[NSString stringWithFormat:@"%@",[result objectForKey:@"vehicleList"]];
                NSArray *temp;
                if ([[str stringByTrimmingCharactersInSet:
                      [NSCharacterSet whitespaceAndNewlineCharacterSet]]isEqualToString:@"{\n}"]||[[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]isEqualToString:@"{}"])
                {
                    temp=[[NSArray alloc]init];
                }
                else
                {
                    temp =[[NSArray alloc]initWithArray:[result objectForKey:@"vehicleList"]];
                }
                if (temp.count==0) {
                    //                当无车辆列表的时候视为登录失败
                    loginState = USER_LOGIN_NO_VEHICLES;  //没有车
                }
                else
                {
                    //存储车辆信息
                    [app deleteCarWithUserID:account];
                    loginType = USER_LOGIN_CAR;//有车注册用户USER_LOGIN_WITHCAR，由于取消注册有车账户种类，现将其视为车辆用户
                    for (int i=0; i<temp.count; i++) {
                        NSString *uuid = [App createUUID];
                        NSString *ID = @"";
                        NSString *vin = @"";
                        NSString *name = @"";
                        NSString *licenseNumber = @"";
                        NSString *engineNo = @"";
                        NSString *terminalId = @"";
                        NSString *type = @"";
                        NSString *carLon = @"0.0";
                        NSString *carLat = @"0.0";
                        NSString *lastUpdateTime = @"";
                        if ([[temp objectAtIndex:i]objectForKey:@"id"]) {
                            ID =[[temp objectAtIndex:i]objectForKey:@"id"];
                        }
                        if ([[temp objectAtIndex:i]objectForKey:@"name"]) {
                            name = [[temp objectAtIndex:i]objectForKey:@"name"];
                        }
                        if ([[temp objectAtIndex:i]objectForKey:@"vin"]) {
                            vin = [[temp objectAtIndex:i]objectForKey:@"vin"];
                        }
                        else
                        {
                            vin = @"";
                        }
                        if ([[temp objectAtIndex:i]objectForKey:@"licenseNumber"]) {
                            licenseNumber = [[temp objectAtIndex:i]objectForKey:@"licenseNumber"];
                        }
                        else
                        {
                            int length = [vin length];
                            if (length >= 4) {
                                licenseNumber = [vin substringFromIndex:length-4];
                            }
                            else
                            {
                                licenseNumber =@"";
                            }
                            
                        }
                        if ([[temp objectAtIndex:i]objectForKey:@"engineNo"]) {
                            engineNo = [[temp objectAtIndex:i]objectForKey:@"engineNo"];
                        }
                        if ([[temp objectAtIndex:i]objectForKey:@"terminalId"]) {
                            terminalId = [[temp objectAtIndex:i]objectForKey:@"terminalId"];
                        }
                        if ([[temp objectAtIndex:i]objectForKey:@"vtype"]) {
                            type = [[temp objectAtIndex:i]objectForKey:@"vtype"];
                        }
                        if ([[temp objectAtIndex:i]objectForKey:@"lon"]) {
                            carLon = [[temp objectAtIndex:i]objectForKey:@"lon"];
                        }
                        if ([[temp objectAtIndex:i]objectForKey:@"lat"]) {
                            carLat = [[temp objectAtIndex:i]objectForKey:@"lat"];
                        }
                        if ([[temp objectAtIndex:i]objectForKey:@"lastUpdateTime"])
                        {
                            lastUpdateTime = [App getDateWithTimeSince1970:[NSString stringWithFormat:@"%@",[[temp objectAtIndex:i]objectForKey:@"lastUpdateTime"]]];
                        }
                        [app updateCarData:uuid carID:ID vin:vin type:type name:name carRegisCode:@"" carNumber:licenseNumber motorCode:engineNo userID:account sim:terminalId lon:carLon lat:carLat lastRpTime:lastUpdateTime];
                    }
                    if ([result objectForKey:@"user"] && [[result objectForKey:@"user"] objectForKey:@"tel"]) {
                        mSelfPhone = [NSString stringWithString:[[result objectForKey:@"user"] objectForKey:@"tel"]];
                    }
                    else
                    {
                        mSelfPhone = @"";
                    }
                    app.selfPhone = mSelfPhone;
                    loginState = USER_LOGIN_SUCCESS;//登陆成功
                    logout=LOGOUT_YES;
                    [temp release];
                    temp=nil;
                    
                }
            }
            else
            {
                //            返回数据错误
                loginState =USER_LOGIN_FAILURE;//登录失败
            }
        }
        else
        {
//            返回数据错误
            loginState =USER_LOGIN_FAILURE;//登录失败
        }
    }
    else if(code == NET_ERROR)
    {
        loginState =USER_LOGIN_NO_NET;//网络连接失败
        
    }
    else if(code == NAVINFO_LOGIN_PWD_ERROR)//用户名密码错误
    {
        loginState =USER_LOGIN_WRONG_PASSWORD;
    }
    else if(code == NAVINFO_LOGIN_ACCOUNT_NOEXIST)//账户不存在
    {
        loginState =USER_LOGIN_ACCOUNT_NOEXIST;
    }
    else if(code == NAVINFO_LOGIN_NO_VEHICLES)//没有车
    {
        loginState =USER_LOGIN_NO_VEHICLES;
    }
    else if(code == NAVINFO_LOGIN_NO_DREDGE_OR_CLOSE)//未开通服务或服务停止
    {
        loginState =USER_LOGIN_NO_DREDGE_OR_CLOSE;
    }
    else
    {
        loginState =USER_LOGIN_FAILURE;//登录失败
        NSLog(@"Errors on reveice result.");
    }
    
    rightBtn.enabled = YES;
    leftBtn.enabled = YES;
    [self.progressHUD hide:YES];
    [self LoginState];
}
*/

/*!
 @method showNewMessage:(NSNotification*) notification
 @abstract 获取新消息通知，执行方法
 @discussion 重新从本地获取消息数目，并更新界面
 @param notification 通知
 @result 无
 */
- (void)showNewMessage:(NSNotification*) notification
{
    id obj = [notification object];
    NSLog(@"NewMessage = %@",obj);
    App *app = [App getInstance];
    NSLog(@"app.mUserData.mUserID = %@",app.mUserData.mUserID);
    if ([obj integerValue]!=0 && logout == LOGOUT_YES) {
        messageCount = [[app loadMessageInfoData:0 userID:app.mUserData.mUserID ] count];
        [self loadMessageCount];
    }
    
}


/*!
 @method onLogoutResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg
 @abstract 登出的回调函数
 @discussion 登出的回调函数
 @param result 返回数据
 @param code 状态码
 @param errorMsg 错误信息
 @result 无
 */
- (void)onLogoutResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg
{
    
//    App *app = [App getInstance];
    if (code == NAVINFO_RESULT_SUCCESS) {
//        loginType = USER_LOGIN_OTHER;
//        logout=LOGOUT_NO;
//        [app setFriendLoadType:FRIEND_LOAD_YES];
//        [app setBlackLoadType:BLACK_LOAD_YES];
    }
    else if(code == NET_ERROR)
    {
//        网络失败提醒
//        Resources *oRes = [Resources getInstance];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[oRes getText:@"common.noNetAlert.message"]delegate:self cancelButtonTitle:[oRes getText:@"common.noNetAlert.cancelButtonTitle"] otherButtonTitles:nil];
//        [alert show];
//        [alert release];
    }
    else
    {
//        登出失败提醒
//        Resources *oRes = [Resources getInstance];
//        alert = [[UIAlertView alloc] initWithTitle:[oRes getText:@"Main.MainViewController.logoutAlert.title"] message:[oRes getText:@"Main.MainViewController.logoutAlert.message"] delegate:self cancelButtonTitle:[oRes getText:@"Main.MainViewController.logoutAlert.cancelButtonTitle"] otherButtonTitles:nil];
//        [alert show];
    }
    //消息接收停止
//    [mMessage stop];
}

/*!
 @method onRescueResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg
 @abstract 救援回调函数
 @discussion 救援回调函数，成功弹出拨打电话界面，失败弹出失败提醒alert
 @param result 返回数据
 @param code 状态码
 @param errorMsg 错误信息
 @result 无
 */
- (void)onRescueResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg
{
    Resources *oRes = [Resources getInstance];
    [self.progressHUD hide:YES];
    if (code == NAVINFO_RESULT_SUCCESS) {
        if ([result valueForKey:@"b-call"]) {
            phone=[[NSString alloc]initWithFormat:@"%@",[result valueForKey:@"b-call"]];
            NSLog(@"%@",phone);
            App *app = [App getInstance];
            [app callPhone:phone];
            [phone release];
        }
        else
        {
            [self MBProgressHUDMessage:[oRes getText:@"Main.MainViewController.rescueFailAlert.message"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
        }
        
    }
    else if(code == NET_ERROR)
    {
        [self MBProgressHUDMessage:[oRes getText:@"common.noNetAlert.message"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else if(code == NAVINFO_TOKENID_INVALID)
    {
        [self MBProgressHUDMessage:[oRes getText:@"common.loseTokenID.message"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else
    {
        
        [self MBProgressHUDMessage:[oRes getText:@"Main.MainViewController.rescueFailAlert.message"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    [mRescue release];
    rightBtn.enabled = YES;
    leftBtn.enabled = YES;
}



/*!
 @method userLogin
 @abstract 用户登录
 @discussion 登录成功后，将用户信息存到用户表中，将自己存到车友表中，加载选择车辆的信息。
 @param 无
 @result 无
 */
-(void)userLogin
{
    App *app = [App getInstance];
    NSString *uuid = [App createUUID];
    [app setFriendLoadType:FRIEND_LOAD_YES];
    [app setBlackLoadType:BLACK_LOAD_YES];
    [app setElecLoadType:ELEC_LOAD_YES];
    poiLoad=POI_LOAD_YES;
    if (isAutomaticLogin) {
//        NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
        lastHiddenKey=[[NSUserDefaults standardUserDefaults] boolForKey:@"UserDefaultLastHiddenKey"];
        if (lastHiddenKey)
        {
            password = @"";
        }
        [app login:uuid account:account password:password type:loginType safe_pwd:safe_pwd flag:flag lon:@"" lat:@"" lastreqtime:@"0" vin:carVin userID:loginID];
    }
    else
    {
        [self nameAndPasswordSave];//保存最后一次登录的用户名密码

        if (rememberPasswordImageView.hidden)
        {
            password = @"";
        }
        [app login:uuid account:account password:password type:loginType safe_pwd:safe_pwd flag:flag lon:@"" lat:@"" lastreqtime:@"0" vin:carVin userID:loginID];
    }
    
//    获取车辆列表
    [carList removeAllObjects];
    [carList addObjectsFromArray:[app loadCarDataWithUserID:loginID]];
//    判断上次选中的车辆是否还存在
    if (carList.count > 0) {
        if ([app existCarDataWithCarVin:app.mUserData.mCarVin]) {
            carVin = app.mUserData.mCarVin;
        }
        else
        {
            CarData *car = [carList objectAtIndex:0];
            carVin = car.mVin;
            [app updateVinWithUserID:loginID vin:carVin];
        }
    }
    if (![app.mUserData.mCarVin isEqualToString:@""]) {
//        更新app中的车辆信息
        [app loadCarData];
    }
//    一辆车也可以点击选车
    leftBtn.enabled = YES;
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"main_selectcar_btn_unselected"] forState:UIControlStateNormal];
    
    /*
    // 先删除自己
    FriendsData *friend = [app getFriendData:loginID];
    NSLog(@"%@",friend.mfName);
    if (friend != nil) {
        [app deleteFriendData:loginID];
    }
     */
    NSLog(@"loginID = %@",loginID);
    Resources *oRes = [Resources getInstance];
    uuid = [App createUUID];
    [app updateFriendData:uuid fid:loginID fname:[oRes getText:@"friend.FriendList.selfName"] fphone:mSelfPhone flon:@"" flat:@"" fLastRqTime:app.mUserData.mLastReqTime fLastUpdate:@"" sendLocationRqTime:@"" createTime:[App getTimeSince1970_1000] friendUserID:loginID poiName:@"" poiAddress:@"" pinyin:@""];
    [self formalUser];
}



/*!
 @method formalUser
 @abstract 续用户登录
 @discussion 登录成功后，加载界面信息，包括消息数目，车牌号，登出按钮，登录界面移除以及选车界面加载
 @param 无
 @result 无
 */
-(void)formalUser
{
    //消息数量获取预留
    //将服务器端是否登录的状态置为登录，未实现，预留。
    App *app = [App getInstance];
    messageCount = [[app loadMessageInfoData:0 userID:app.mUserData.mUserID ] count];
    [self loadMessageCount];
    Resources *oRes = [Resources getInstance];
//    判定是否该显示title
    if (logout==LOGOUT_YES) {
        titleView.hidden=NO;
        self.navigationItem.titleView=titleView;
        titleLabel.text = app.mCarData.mCarNumber;
        if (![titleLabel.text isEqualToString:@""]) {
            titleLabel.hidden = NO;
            titleView.hidden=NO;
        }
        else
        {
            titleLabel.hidden=YES;
            titleView.hidden=YES;
        }
    }
    
    if (logout==LOGOUT_YES) {
        [rightBtn setTitle:[oRes getText:@"Main.MainViewController.logoutButton.title"]forState:UIControlStateNormal];
    }
    
    [self loginViewRemove];
    [self loadSelectCarView];
}

/*!
 @method demoUser
 @abstract  demo账号登录
 @discussion demo账户登录，加载界面信息，包括消息数目，车牌号，登出按钮，登录界面移除以及选车界面加载
 @param 无
 @result 无
 */
-(void)demoUser
{
    logout=LOGOUT_YES;
    App *app=[App getInstance];
    app.userAccountState = USER_ACCOUNT_STATE_ALL_FUNCTION;
    [app setDemoIsFirstLoginFriend:USER_FIRSTLOGIN];
    messageCount=[[app loadMessageInfoData:0 userID:@"demo_admin"] count];
    [self loadMessageCount];
    //    获取车辆列表
    [carList removeAllObjects];
    [carList addObjectsFromArray:[app loadCarDataWithUserID:@"demo_admin"]];
    if (carList.count != 0) {
        carVin = @"";
        if (carList.count == 1) {
            CarData *car = [carList objectAtIndex:0];
            selectCar = 0;
            carVin = car.mVin;
            
        }
        else
        {
            for (int i = 0; i < carList.count; i++) {
                CarData *car = [carList objectAtIndex:i];
                if (![car.mCarNumber isEqualToString:@""]) {
                    selectCar = i;
                    carVin = car.mVin;
                    break;
                }
                
            }
        }
        if (![carVin isEqualToString:@""]) {
            //            更新用户表中的vin
            [app updateVinWithUserID:@"demo_admin" vin:carVin];
        }
        
        if (![app.mUserData.mCarVin isEqualToString:@""]) {
            //        更新app中的车辆信息
            [app loadCarData];
        }
        leftBtn.enabled = YES;
        [leftBtn setBackgroundImage:[UIImage imageNamed:@"main_selectcar_btn_unselected"] forState:UIControlStateNormal];
        
        [self loadSelectCarView];
    }
    Resources *oRes = [Resources getInstance];
    if (logout==LOGOUT_YES) {
        titleView.hidden=NO;
        titleLabel.hidden=NO;
        self.navigationItem.titleView=titleView;
        titleLabel.text = app.mCarData.mCarNumber;
        [rightBtn setTitle:[oRes getText:@"Main.MainViewController.logoutButton.title"]forState:UIControlStateNormal];
    }
    [self loginViewRemove];
    [self MBProgressHUDMessage:[oRes getText:@"Main.MainViewController.demoLoginSuccess.title"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
}

/*!
 @method loginView
 @abstract  点击主界面登录或登出按钮，执行方法
 @discussion 点击主界面登录或登出按钮，执行方法，包括弹出登录界面，初始化用户名密码，或执行登出方法
 @param 无
 @result 无
 */
-(void)loginView
{
    
    if (logout==LOGOUT_YES) {
        [self Logout];
    }
    
    [self initNameAndPassword];
    loginView.hidden = NO;
    mDisView.hidden = NO;
    rightButton.enabled=NO;
    
}


/*!
 @method initNameAndPassword
 @abstract  初始化用户名和密码
 @discussion 初始化用户名和密码
 @param 无
 @result 无
 */
-(void)initNameAndPassword
{
//    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    lastNameKey=[[NSUserDefaults standardUserDefaults] objectForKey:@"UserDefaultLastNameKey"];
    lastPasswordKey=[[NSUserDefaults standardUserDefaults] objectForKey:@"UserDefaultLastPasswordKey"];
    lastHiddenKey=[[NSUserDefaults standardUserDefaults] boolForKey:@"UserDefaultLastHiddenKey"];
    if (lastNameKey==nil)
    {
        nameTextField.text=@"";
        passwordTextField.text=@"";
        password = @"";
        rememberPasswordImageView.hidden=YES;
    }
    else if(lastHiddenKey==YES)
    {
        nameTextField.text=lastNameKey;
        passwordTextField.text=@"";
        password = @"";
        rememberPasswordImageView.hidden=YES;
    }
    else
    {
        nameTextField.text=lastNameKey;
        passwordTextField.text=PWD_PLACEHOLDER;
        password = lastPasswordKey;
        rememberPasswordImageView.hidden=NO;
    }
    
}

/*!
 @method clickRememberPasswordButton：
 @abstract  单击记住密码，执行方法
 @discussion 单击记住密码，执行方法
 @param 无
 @result 无
 */
-(IBAction)clickRememberPasswordButton:(id)sender
{
    if (rememberPasswordImageView.hidden) {
        rememberPasswordImageView.hidden=NO;
    }
    else
    {
        rememberPasswordImageView.hidden=YES;
    }
}

/*!
 @method loginBackgroundTap：
 @abstract  登录界面弹出后，单击除登录界面中除输入框之外区域，输入框取消焦点，弹回键盘
 @discussion 登录界面弹出后，单击除登录界面中除输入框之外区域，输入框取消焦点，弹回键盘
 @param 无
 @result 无
 */
-(IBAction)loginBackgroundTap:(id)sender
{
    [nameTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
}

/*!
 @method textFieldDoneEditing：
 @abstract  登录界面弹出后，单击软键盘完成按钮，取消焦点
 @discussion 登录界面弹出后，单击软键盘完成按钮，取消焦点
 @param 无
 @result 无
 */
-(IBAction)textFieldDoneEditing:(id)sender
{

    if ([nameTextField isFirstResponder]) {
        [nameTextField resignFirstResponder];
        [passwordTextField isFirstResponder];
    }
    else if([passwordTextField isFirstResponder])
    {
        [passwordTextField resignFirstResponder];
    }
}



/*!
 @method nameOrPasswordError：
 @abstract  用户名或密码错误，弹出alert
 @discussion 用户名或密码错误，弹出alert
 @param 无
 @result 无
 */
-(void)nameOrPasswordError
{
    errorTime++;
     Resources *oRes = [Resources getInstance];
    [self MBProgressHUDMessage:[oRes getText:@"Main.MainViewController.loginAlert.title"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    [nameTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
    if (errorTime==3) {
        //等待3分钟
    }
}

/*!
 @method noNetwork
 @abstract  网络错误，弹出alert
 @discussion  网络错误，弹出alert
 @param 无
 @result 无
 */
-(void)noNetwork
{
    Resources *oRes = [Resources getInstance];
    [self MBProgressHUDMessage:[oRes getText:@"common.noNetAlert.message"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    [nameTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
}

/*!
 @method loginFailure
 @abstract  登录失败，弹出alert
 @discussion  登录失败，弹出alert
 @param 无
 @result 无
 */
-(void)loginFailure
{
    Resources *oRes = [Resources getInstance];
    [self MBProgressHUDMessage:[oRes getText:@"Main.MainViewController.loginFailure.message"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    [nameTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
}


/*!
 @method loginAccountNOExist
 @abstract  账号不存在，弹出alert
 @discussion  账号不存在，弹出alert
 @param 无
 @result 无
 */
-(void)loginAccountNOExist
{
    Resources *oRes = [Resources getInstance];
    [self MBProgressHUDMessage:[oRes getText:@"Main.MainViewController.loginAccountNOExist.message"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    [nameTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
}

/*!
 @method loginNOVehicles
 @abstract  没有车，弹出alert
 @discussion  没有车，弹出alert
 @param 无
 @result 无
 */
-(void)loginNOVehicles
{
    Resources *oRes = [Resources getInstance];
    [self MBProgressHUDMessage:[oRes getText:@"Main.MainViewController.loginNOVehicles.message"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    [nameTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
}


/*!
 @method loginNoDredgeOrClose
 @abstract  未开通，弹出alert
 @discussion  未开通，弹出alert
 @param 无
 @result 无
 */
-(void)loginNoDredgeOrClose
{
    Resources *oRes = [Resources getInstance];
    [self MBProgressHUDMessage:[oRes getText:@"Main.MainViewController.loginNoDredgeOrClose.message"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    [nameTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
}



/*!
 @method nameAndPasswordSave
 @abstract  保存登录信息
 @discussion  保存登录信息
 @param 无
 @result 无
 */
-(void)nameAndPasswordSave
{
//    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    [[NSUserDefaults standardUserDefaults] setObject:nameTextField.text forKey:@"UserDefaultLastNameKey"];
    /**
     *修改密码存储，留自动登录时用
    if (rememberPasswordImageView.hidden==NO)
    {
//        if ([passwordTextField.text isEqualToString:PWD_PLACEHOLDER]) {
//            [accountDefaults setObject:passwordTextField.text forKey:@"UserDefaultLastPasswordKey"];
//        }
//        else
//        {
//            [accountDefaults setObject:lastPasswordKey forKey:@"UserDefaultLastPasswordKey"];
//        }
        [accountDefaults setObject:password forKey:@"UserDefaultLastPasswordKey"];
    }
    else
    {
        [accountDefaults setObject:@"" forKey:@"UserDefaultLastPasswordKey"];
    }
     */
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"UserDefaultLastPasswordKey"];
    [[NSUserDefaults standardUserDefaults] setBool:rememberPasswordImageView.hidden forKey:@"UserDefaultLastHiddenKey"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

/*!
 @method mDisViewBackgroundTap：
 @abstract  选车弹出后或登录界面弹出后，单击背景，选车弹回或登录框消失
 @discussion  选车弹出后或登录界面弹出后，单击背景，选车弹回或登录框消失
 @param 无
 @result 无
 */
-(IBAction)mDisViewBackgroundTap:(id)sender
{
    if (selectCarView.frame.origin.y==0) {
        [self showSelectCar:mOpenSelectCar];
    }
    else
    {
        [self loginViewRemove];
    }
    mDisView.hidden = YES;
    rightButton.enabled=YES;
}


/*!
 @method demo：
 @abstract  点击模拟执行方法
 @discussion  点击模拟执行方法
 @param 无
 @result 无
 */
-(IBAction)demo:(id)sender
{
    loginState=USER_LOGIN_SUCCESS;
    loginType=USER_LOGIN_DEMO;
    [self addDemoData];
    [self demoUser];
}

/*!
 @method loginViewRemove
 @abstract  隐藏登录界面
 @discussion  隐藏登录界面
 @param 无
 @result 无
 */
-(void)loginViewRemove
{
    [nameTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
    loginView.hidden = YES;
    
    mDisView.hidden = YES;
    rightButton.enabled=YES;
}

/*!
 @method rescue
 @abstract 主界面点击救援按钮执行方法，获取救援电话
 @discussion 主界面点击救援按钮执行方法，获取救援电话
 @param sender
 @result 无
 */
-(IBAction)rescue:(id)sender
{
    Resources *oRes = [Resources getInstance];
    switch (loginType) {
        case USER_LOGIN_OTHER:
        {
            //未登录用户点击时提示
            [self MBProgressHUDMessage:[oRes getText:@"Login.UserInputViewController.unenabelAlert.message"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
            
        }
            break;
        case USER_LOGIN_DEMO:
        {
            //demo账户点击时提示
            [self MBProgressHUDMessage:[oRes getText:@"Login.UserInputViewController.demoAlert.message"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
            
        }
            break;
        case USER_LOGIN_CAR:
        {
            /**
             *获取救援电话，走接口
            self.progressHUD.labelText = [oRes getText:@"Main.MainViewController.rescueLoading.title"];
            self.progressHUD.detailsLabelText= [oRes getText:@"common.load.text"];
            [self.progressHUD show:YES];
            rightBtn.enabled = NO;
            leftBtn.enabled = NO;
//            救援去掉获取经纬度
//            [self getCurPOI];
            mRescue = [[NIRescue alloc]init];
            [mRescue createRequest];
            [mRescue sendRequestWithAsync:self];
             */
            App *app = [App getInstance];
            [app callPhone:app.bCall];
            
        }
            break;
        default:
            break;
    }
    
}

/**
 *通过gps获取经纬度
//GPS获取当前位置
-(void)getCurPOI
{
    //初始化位置管理器
    locManager = [[CLLocationManager alloc]init];
    //设置代理
    locManager.delegate = self;
    //设置位置经度
    locManager.desiredAccuracy = kCLLocationAccuracyBest;
    //设置每隔100米更新位置
    //    locManager.distanceFilter = 100;

    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        NSLog(@"拒绝");
        mRescue = [[NIRescue alloc]init];
        //    获取GPS失败，现使用默认经纬度
//        [mRescue createRequest:116.387174 lat:39.904687];
//        现，获取失败以-1标记，接口处理：不上传经纬度
        [mRescue createRequest:-1 lat:-1];
        [mRescue sendRequestWithAsync:self];
    }
    else
    {
        //开始定位服务
        [locManager startUpdatingLocation];
    }
}
*/

/**
 *通过gps获取经纬度回调方法
//Gps用
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


//协议中的方法，作用是每当位置发生更新时会调用的委托方法
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    //结构体，存储位置坐标
    CLLocationCoordinate2D loc = [newLocation coordinate];
    float longitude = loc.longitude;
    float latitude = loc.latitude;
    lon=[NSString stringWithFormat:@"%f",longitude];
    lat=[NSString stringWithFormat:@"%f",latitude];
    //停止定位服务
    [locManager stopUpdatingLocation];
    locManager.delegate = nil;
    [locManager release];
    App *app = [App getInstance];
    [app updateLocation:lon lat:lat];
    mRescue = [[NIRescue alloc]init];
    [mRescue createRequest:longitude lat:latitude];
    [mRescue sendRequestWithAsync:self];
}

//当位置获取或更新失败会调用的方法
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
//    总开关的状态
//    locManager.locationServicesEnabled
//    当前应用程序使用GPS的状态
//    [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied
//    当前应用程序GPS的开关状态
//    kCLAuthorizationStatusRestricted
//    测试
//    NSLog(@"%d",locManager.locationServicesEnabled);
//    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
//        NSLog(@"拒绝");
//    }
//    NSLog(@"限制，%d",kCLAuthorizationStatusRestricted);
    [locManager stopUpdatingLocation];
    locManager.delegate = nil;
    [locManager release];
    mRescue = [[NIRescue alloc]init];
//    获取GPS失败，现使用默认经纬度
//    [mRescue createRequest:116.387174 lat:39.904687];
//        现，获取失败以-1标记，接口处理：不上传经纬度
    [mRescue createRequest:-1 lat:-1];
    [mRescue sendRequestWithAsync:self];
    
}
 
 */


-(void)alertView:(UIAlertView *)malert clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        App *app = [App getInstance];
        [app callPhone:phone];
    }
}

/*!
 @method friend
 @abstract 主界面点击车友按钮执行方法，进入车友界面
 @discussion 主界面点击车友按钮执行方法，进入车友界面
 @param sender
 @result 无
 */
-(IBAction)friend:(id)sender
{
    App *app = [App getInstance];
    if (loginType == USER_LOGIN_OTHER) {
        Resources *oRes = [Resources getInstance];
        [self MBProgressHUDMessage:[oRes getText:@"Login.UserInputViewController.unenabelAlert.message"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else if (loginType == USER_LOGIN_DEMO)
    {
        FriendTabBarViewController *friendTabBarViewController = [[FriendTabBarViewController alloc] init];
        [self.navigationController pushViewController:friendTabBarViewController animated:YES];
        [friendTabBarViewController release];
        [app setFriendLoadType:FRIEND_LOAD_NO];
        if ([self.navigationController.navigationBar respondsToSelector:@selector(setShadowImage)]) {
            [self.navigationController.navigationBar setShadowImage:[[[UIImage alloc] init] autorelease]];
        }
    }
    else
    {
        FriendTabBarViewController *friendTabBarViewController = [[FriendTabBarViewController alloc] init];
        [self.navigationController pushViewController:friendTabBarViewController animated:YES];
        [friendTabBarViewController release];
        [app setFriendLoadType:FRIEND_LOAD_NO];
        if ([self.navigationController.navigationBar respondsToSelector:@selector(setShadowImage)]) {
            [self.navigationController.navigationBar setShadowImage:[[[UIImage alloc] init] autorelease]];
        }        
    }
    
}

/*!
 @method goloveCar：
 @abstract 点击爱车
 @discussion 点击爱车
 @param sender
 @result 无
 */
-(IBAction)goloveCar:(id)sender
{
    App *app = [App getInstance];
    Resources *oRes = [Resources getInstance];

    if (loginType == USER_LOGIN_OTHER) {
        [self MBProgressHUDMessage:[oRes getText:@"Login.UserInputViewController.unenabelAlert.message"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else if (loginType == USER_LOGIN_DEMO)
    {
       [app initCarSetPara];
        CarTabBarViewController *carTabBar = [[CarTabBarViewController alloc] init];
        [self.navigationController pushViewController:carTabBar animated:YES];
        [carTabBar release];
    }
    else
    {
        if ([app.mCarData.mService intValue] == SERVICE_TYPE_CHERRY)
        {
           [app initCarSetPara];
            CarTabBarViewController *carTabBar = [[CarTabBarViewController alloc] init];
            [self.navigationController pushViewController:carTabBar animated:YES];
            [carTabBar release];
        }
       else
       {
           [self MBProgressHUDMessage:[oRes getText:@"Main.MainViewController.loveCarAlert"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
       }
    }

}

/*!
 @method goMap
 @abstract 主界面点击地图按钮执行方法，进入地图界面
 @discussion 主界面点击地图按钮执行方法，进入地图界面
 @param sender
 @result 无
 */
-(IBAction)goMap:(id)sender
{
    MapTabBarViewController *mapTabBarViewController = [[MapTabBarViewController alloc] init];
    mapTabBarViewController.mainRootViewController=self;
    [mapTabBarViewController setPOILoad:poiLoad];
    [self.navigationController pushViewController:mapTabBarViewController animated:YES];
    [mapTabBarViewController release];
}

/*!
 @method urlGoMap:
 @abstract 点击短信分享链接进入到应用程序，从主界面进入地图界面，将poi点扎在地图上
 @discussion 点击短信分享链接进入到应用程序，从主界面进入地图界面，将poi点扎在地图上
 @param URLLon 经度
 @param URLLat 纬度
 @param title 标题
 @param address 地址
 @result 无
 */
-(void)urlGoMap:(NSMutableDictionary *)URLDic
{
    MapTabBarViewController *mapTabBarViewController = [[[MapTabBarViewController alloc] init]autorelease];
    mapTabBarViewController.mainRootViewController=self;
    [mapTabBarViewController setPOILoad:poiLoad];
    [mapTabBarViewController setURLDic:URLDic];
    [self.navigationController pushViewController:mapTabBarViewController animated:YES];
}

/*!
 @method goMessage
 @abstract 主界面点击消息按钮执行方法，进入消息界面
 @discussion 主界面点击消息按钮执行方法，进入消息界面
 @param sender
 @result 无
 */
-(IBAction)goMessage:(id)sender
{
    if (loginType == USER_LOGIN_OTHER) {
        Resources *oRes = [Resources getInstance];
        [self MBProgressHUDMessage:[oRes getText:@"Login.UserInputViewController.unenabelAlert.message"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else
    {
        MessageViewController *messageViewController = [[MessageViewController alloc] init];
        messageViewController.navigationItem.leftBarButtonItem =[self createBackButton];
        [self.navigationController pushViewController:messageViewController animated:YES];
        [messageViewController release];
    }
}


/*!
 @method goSet
 @abstract 主界面点击设置按钮执行方法，进入设置界面
 @discussion 主界面点击设置按钮执行方法，进入设置界面
 @param sender
 @result 无
 */
-(IBAction)goSet:(id)sender
{
    if (loginType == USER_LOGIN_OTHER) {
        Resources *oRes = [Resources getInstance];
        [self MBProgressHUDMessage:[oRes getText:@"Login.UserInputViewController.unenabelAlert.message"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else
    {
        SetViewController *setViewController = [[SetViewController alloc] init];
        [self.navigationController pushViewController:setViewController animated:YES];
        [setViewController release];
    }
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
 @method createBackButton
 @abstract 创建返回按钮
 @discussion 创建返回按钮
 @param 无
 @result UIBarButtonItem
 */
-(UIBarButtonItem*) createBackButton
{
    Resources *oRes = [Resources getInstance];

    return [[[UIBarButtonItem alloc]
            
            initWithTitle:[oRes getText:@"common.HomeButtonTitle"]
            
            style:UIBarButtonItemStyleBordered
            
            target:self
            
            action:@selector(popself)] autorelease];
    
}

/*!
 @method setButtonDisable
 @abstract 选车框弹出后禁用一些button，根据业务定
 @discussion 选车框弹出后禁用一些button，根据业务定
 @param 无
 @result 无
 */
-(void)setButtonDisable
{
    rescueButton.enabled = NO;
    friendButton.enabled = NO;
    mapButton.enabled = NO;
    messageButton.enabled = NO;
    setButton.enabled = NO;
    rightButton.enabled = NO;
}


/*!
 @method setButtonEnable
 @abstract 选车框消失后启用一些button，根据业务定
 @discussion 选车框消失后启用一些button，根据业务定
 @param 无
 @result 无
 */
-(void)setButtonEnable
{
    rescueButton.enabled = YES;
    friendButton.enabled = YES;
    mapButton.enabled = YES;
    messageButton.enabled = YES;
    setButton.enabled = YES;
    rightButton.enabled = YES;
}

#pragma mark 选车
/*!
 @method loadSelectCarView
 @abstract 加载选车界面
 @discussion 加载选车界面
 @param 无
 @result 无
 */
-(void)loadSelectCarView
{
    
//    根据车辆型号加载车辆图片，现只有HAVALH6一种车型
    leftBtn.hidden = NO;
    
    selectCarScrollView.contentSize = CGSizeMake([carList count]* selectCarScrollView.frame.size.width, selectCarScrollView.frame.size.height);
    selectCarScrollView.pagingEnabled = YES;
    //    设置ScrollView的位置
//    selectCarScrollView.contentOffset = CGPointMake( selectCar* selectCarScrollView.frame.size.width, 0);
    if (!selectCarPageControl) {
        selectCarPageControl= [[BasePageControl alloc] init];
        selectCarPageControl.userInteractionEnabled = NO;
//        根据机型来调整翻页的位置
        //        根据设备屏幕大小判断
        if (deviceSize == SCREEN_SIZE_960_640)
        {
            [selectCarPageControl setFrame:CGRectMake(34,192, 252, 36)];
        }
        else
        {
            [selectCarPageControl setFrame:CGRectMake(34, 231, 252, 36)];
        }
        
        [selectCarView addSubview:selectCarPageControl];
    }
    selectCarPageControl.numberOfPages = [carList count];
//    selectCarPageControl.currentPage = selectCar;
}

/*!
 @method onClickSelectCar
 @abstract 点击选车按钮
 @discussion 点击选车按钮
 @param 无
 @result 无
 */
- (void)onClickSelectCar
{
    [self showSelectCar:mOpenSelectCar];
}


/*!
 @method showSelectCar：
 @abstract 显示或隐藏选车
 @discussion 显示或隐藏选车
 @param bHideSelectCar 显示或隐藏标识
 @result 无
 */
- (void)showSelectCar:(BOOL)bHideSelectCar
{
    if (!bHideSelectCar) {
        [self loadCarDataToSelectCarScrollView];
//        selectCarScrollView.contentOffset = CGPointMake( selectCar* selectCarScrollView.frame.size.width, 0);
//        selectCarPageControl.currentPage = selectCar;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        int pos_y = 0;
        if (bHideSelectCar) {
            //隐藏选车界面
            pos_y = -selectCarView.frame.size.height;
            mOpenSelectCar = NO;
            //使用单击背景弹回选车况时使用
            mDisView.hidden = YES;
            //使用禁用button方法
            //[self setButtonEnable];
            rightButton.enabled = YES;
            [leftBtn setBackgroundImage:[UIImage imageNamed:@"main_selectcar_btn_unselected"] forState:UIControlStateNormal];
            
        }
        else{
            //显示选车界面
            pos_y = 0;
            mOpenSelectCar = YES;
            //使用单击背景弹出选车况时使用
            mDisView.hidden = NO;
            //使用禁用button方法
            //[self setButtonDisable];
            rightButton.enabled = NO;
            [leftBtn setBackgroundImage:[UIImage imageNamed:@"main_selectcar_btn_selected"] forState:UIControlStateNormal];
        }
        CGRect rect = CGRectMake(selectCarView.frame.origin.x,pos_y,selectCarView.frame.size.width,selectCarView.frame.size.height);
        selectCarView.frame = rect;
    } completion:nil];
    
}


/*!
 @method removeViewFromSelectCarScrollView
 @abstract 将选车界面中的view移除
 @discussion 将选车界面中的view移除
 @param 无
 @result 无
 */
-(void)removeViewFromSelectCarScrollView
{
    for(id tmpView in [selectCarScrollView subviews])
    {
        //找到要删除的子视图的对象
        if([tmpView isKindOfClass:[UIButton class]])
        {
            UIButton *button = (UIButton *)tmpView;
            if(button.tag >= 10)   //判断是否满足自己要删除的子视图的条件
            {
                [button removeFromSuperview]; //删除子视图
            }
        }
        if([tmpView isKindOfClass:[UILabel class]])
        {
            UILabel *label = (UILabel *)tmpView;
            if(label.tag == 101)   //判断是否满足自己要删除的子视图的条件
            {
                [label removeFromSuperview]; //删除子视图
                
            }
        }
        if([tmpView isKindOfClass:[UIImageView class]])
        {
            UIImageView *image = (UIImageView *)tmpView;
            if(image.tag == 201)   //判断是否满足自己要删除的子视图的条件
            {
                [image removeFromSuperview]; //删除子视图
                
            }
        }
        
    }
}

/*!
 @method loadCarDataToSelectCarScrollView
 @abstract 加载选车界面信息
 @discussion 加载选车界面信息
 @param 无
 @result 无
 */
-(void)loadCarDataToSelectCarScrollView
{
    //移除选车界面中的数据
    [self removeViewFromSelectCarScrollView];
    //添加选车界面中的数据
    App *app = [App getInstance];
    int pos_x = -selectCarScrollView.frame.size.width;
    for (int i=0; i<carList.count; i++) {
        //        设置以车辆图片为背景的button
        pos_x += selectCarScrollView.frame.size.width;
        CarData *car = [carList objectAtIndex:i];
        //        根据车辆型号选着车辆图片，现仅有HAVALH6一种车型，后续可能会增加车辆型号
        UIImage * image = nil;
        if ([car.mVin isEqualToString:app.mCarData.mVin])
        {
            image = [UIImage imageNamed:@"main_selectCar_carImg_selected"];
            selectCar = i;
            selectCarScrollView.contentOffset = CGPointMake( selectCar* selectCarScrollView.frame.size.width, 0);
            selectCarPageControl.currentPage = selectCar;
        }
        else
        {
            image = [UIImage imageNamed:@"main_selectCar_carImg"];
        }
        
        
         CGRect rect;
        
        
        //加载图片
        UIButton * imgBtn = [[UIButton alloc] init];
        //        根据机型的不同来设置lebel框的位置
        //        根据设备屏幕大小判断
        if (deviceSize == SCREEN_SIZE_960_640)
        {
            rect = CGRectMake(pos_x + 24,8,267,150);
        }
        else
        {
            rect = CGRectMake(pos_x + 24,35,267,150);
        }
        
        imgBtn.frame = rect;
        imgBtn.userInteractionEnabled=YES;
        imgBtn.tag = 10 + i;
        NSLog(@" ---------tag= %d",imgBtn.tag);
        [imgBtn setBackgroundImage:image forState:UIControlStateNormal];
        
        [imgBtn addTarget:self action:@selector(onSelectCar:) forControlEvents:UIControlEventTouchUpInside];
        [selectCarScrollView addSubview:imgBtn];
        [imgBtn release];
        
        
        //        设置车牌号的label
        UILabel *licenseNumber = [[UILabel alloc]init];
        [licenseNumber setBackgroundColor:[UIColor clearColor]];
        licenseNumber.textAlignment = UITextAlignmentCenter;
//        根据机型的不同来设置lebel框的位置
        //        根据设备屏幕大小判断
        if (deviceSize == SCREEN_SIZE_960_640)
        {
            rect = CGRectMake(i * selectCarScrollView.frame.size.width + 90,178,139,21);
        }
        else
        {
            rect = CGRectMake(i * selectCarScrollView.frame.size.width + 90,220,139,21);
        }
        
        
        licenseNumber.frame = rect;
        licenseNumber.tag = 101;
        licenseNumber.text = car.mCarNumber;
        [selectCarScrollView addSubview:licenseNumber];
        [licenseNumber release];
        //        设置车辆已选择的标志图片
        UIImageView *selectCarImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"main_selectCar_selected"]];
        //        根据机型的不同来设置车辆图片的位置
        //        根据设备屏幕大小判断
        if (deviceSize == SCREEN_SIZE_960_640)
        {
            rect = CGRectMake(i * selectCarScrollView.frame.size.width + 254,100,53,53);
        }
        else
        {
            rect = CGRectMake(i * selectCarScrollView.frame.size.width + 254,133,53,53);
        }
        selectCarImage.frame = rect;
        selectCarImage.tag = 201;
        if ([car.mVin isEqualToString:app.mUserData.mCarVin])
        {
            selectCarImage.hidden = NO;
        }
        else
        {
            selectCarImage.hidden = YES;
            
        }
        [selectCarScrollView addSubview:selectCarImage];
        [selectCarImage release];
    }
}



/*!
 @method onSelectCar：
 @abstract 选车
 @discussion 选车
 @param 无
 @result 无
 */
-(void)onSelectCar:(id)sender
{
    UIButton *imgBtn = (UIButton*)sender;
    CarData *car = [carList objectAtIndex:imgBtn.tag - 10];
    if ([car.mCarNumber isEqualToString:@""]) {
//        提示用户激活
        titleView.hidden = YES;
    }
    else
    {
        selectCarCount = imgBtn.tag - 10;
        App *app = [App getInstance];
        if (loginType == USER_LOGIN_DEMO) {
            [app updateVinWithUserID:@"demo_admin" vin:car.mVin];
            [app loadCarData];
            [self showSelectCar:mOpenSelectCar];
            titleLabel.text=car.mCarNumber;
            self.navigationItem.titleView=titleView;
            if (![titleLabel.text isEqualToString:@""]) {
                titleView.hidden = NO;
            }
            else
            {
                titleView.hidden = YES;
            }
        }
        else
        {
            [self selectCarWithVin:car.mVin];
            
        }
    }
    
    NSLog(@"-------select car");
}


#pragma mark ScrollViewDelegate
/*!
 @method scrollViewDidEndDecelerating:
 @abstract 根据scrollView的位置改变PageControl的选中位置
 @discussion 根据scrollView的位置改变PageControl的选中位置
 @param 无
 @result 无
 */
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(scrollView == selectCarScrollView)
    {
        selectCarPageControl.currentPage = scrollView.contentOffset.x * selectCarPageControl.numberOfPages / scrollView.contentSize.width;
        
//        titleLabel.text=carName;
    }
}

/*!
 @method nameTextFiedChange:
 @abstract 根据nameTextFied改变passwordTextField的内容
 @discussion 根据nameTextFied改变passwordTextField的内容
 @param sender
 @result 无
 */
-(IBAction)nameTextFiedChange:(id)sender
{
    if ([nameTextField.text isEqualToString:lastNameKey]) {
        passwordTextField.text = PWD_PLACEHOLDER;
        password = lastPasswordKey;
        rememberPasswordImageView.hidden=NO;
    }
    else
    {
        passwordTextField.text = @"";
        password = @"";
        rememberPasswordImageView.hidden=YES;
    }
}

/*!
 @method pwdTextFiedChange:
 @abstract 将passwordTextField的内容存储到password中
 @discussion 将passwordTextField的内容存储到password中
 @param sender
 @result 无
 */
-(IBAction)pwdTextFiedChange:(id)sender
{
    password = [passwordTextField.text copy];
}

#pragma mark set text length
/*!
 @method textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
 @abstract 控制输入框输入内容的长度
 @discussion 控制输入框输入内容的长度
 @param 无
 @result 无
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    
    if (nameTextField == textField)  //判断是否时我们想要限定的那个输入框
    {
        if ([toBeString length] > 11) { //如果账号输入框内容大于11则不允许输入
            textField.text = [toBeString substringToIndex:11];
            return NO;
        }
    }
    if (passwordTextField == textField)  //判断是否时我们想要限定的那个输入框
    {
        if ([toBeString length] > 20) { //如果密码输入框内容大于20则不允许输入
            textField.text = [toBeString substringToIndex:20];
            return NO;
        }
    }
    return YES;
}

/*!
 @method selectCarWithVin:
 @abstract 选车网络请求
 @discussion 选车网络请求
 @param 无
 @result 无
 */
-(void)selectCarWithVin:(NSString *)vin
{
    Resources *oRes = [Resources getInstance];
    self.progressHUD.labelText = [oRes getText:@"Main.MainViewController.selectCarLoading"];
    self.progressHUD.detailsLabelText= [oRes getText:@"common.load.text"];
    [self.progressHUD show:YES];
    [mSelectCar createRequest:vin];
    [mSelectCar sendRequestWithAsync:self];
}

/*!
 @method showCarNum
 @abstract 显示车牌号
 @discussion 显示车牌号
 @param 无
 @result 无
 */
-(void)showCarNum
{
    
}

/*!
 @method onSelectCarResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg
 @abstract 选车的回调函数
 @discussion 选车的回调函数
 @param result 返回数据
 @param code 状态码
 @param errorMsg 错误信息
 @result 无
 */
- (void)onSelectCarResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg
{
    Resources *oRes = [Resources getInstance];
    App *app = [App getInstance];
    if (code == NAVINFO_RESULT_SUCCESS)
    {
        //        登出失败提醒
        
        CarData *car = [carList objectAtIndex:selectCarCount];
        
        selectCar = selectCarCount;
        titleLabel.text=car.mCarNumber;
        self.navigationItem.titleView=titleView;
        if (![titleLabel.text isEqualToString:@""]) {
            titleView.hidden = NO;
        }
        else
        {
            titleView.hidden = YES;
        }
        [app updateVinWithUserID:loginID vin:car.mVin];
        [app loadCarData];
        [self showSelectCar:mOpenSelectCar];
        [self MBProgressHUDMessage:[oRes getText:@"Main.MainViewController.selectCarSuccess"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
//        刷新选车界面
//        [self loadCarDataToSelectCarScrollView];
    }
    else if(code == NET_ERROR)
    {
//        网络失败提醒
        [self MBProgressHUDMessage:[oRes getText:@"common.noNetAlert.message"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else if(code == NAVINFO_TOKENID_INVALID)
    {
        [self MBProgressHUDMessage:[oRes getText:@"common.loseTokenID.message"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else
    {
//        登出失败提醒
        
        [self MBProgressHUDMessage:[oRes getText:@"Main.MainViewController.selectCarFail"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    [self.progressHUD hide:YES];
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
