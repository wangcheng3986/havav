
/*!
 @header ResetPwdViewController.m
 @abstract 重置密码类
 @author mengy
 @version 1.00 14-7-3 Creation
 */

#import "ResetPwdViewController.h"
#import "App.h"
@interface ResetPwdViewController ()
{
    int secondsCountDown;
    NSTimer *countDownTimer;
    UIBarButtonItem *leftBarBtnItem;
}

@end

@implementation ResetPwdViewController
@synthesize picUrlString = _picUrlString;
@synthesize imageView = _imageView;
@synthesize progressHUD = _progressHUD;
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
    if (mGetCDKEY) {
        [mGetCDKEY release];
        mGetCDKEY = nil;
    }
    
    if (mResetPWDPWD) {
        [mResetPWDPWD release];
        mResetPWDPWD = nil;
    }
    if (leftBtn) {
        [leftBtn release];
        leftBtn = nil;
    }
    if (leftBarBtnItem) {
        [leftBarBtnItem release];
        leftBarBtnItem = nil;
    }
    if (cdkeyTextField) {
        [cdkeyTextField removeFromSuperview];
        [cdkeyTextField release];
        cdkeyTextField = nil;
    }
    if (phoneTextField) {
        [phoneTextField removeFromSuperview];
        [phoneTextField release];
        phoneTextField = nil;
    }
    
    if (pwdTextField) {
        [pwdTextField removeFromSuperview];
        [pwdTextField release];
        pwdTextField = nil;
    }
    if (pwdAgainTextField) {
        [pwdAgainTextField removeFromSuperview];
        [pwdAgainTextField release];
        pwdAgainTextField = nil;
    }
    if (phoneLabel) {
        [phoneLabel removeFromSuperview];
        [phoneLabel release];
        phoneLabel = nil;
    }
    
    if (pwdLabel) {
        [pwdLabel removeFromSuperview];
        [pwdLabel release];
        pwdLabel = nil;
    }
    
    if (pwdAgainLabel) {
        [pwdAgainLabel removeFromSuperview];
        [pwdAgainLabel release];
        pwdAgainLabel = nil;
    }
    if (cdkeyLabel) {
        [cdkeyLabel removeFromSuperview];
        [cdkeyLabel release];
        cdkeyLabel = nil;
    }
    
    if (timeDownLabel) {
        [timeDownLabel removeFromSuperview];
        [timeDownLabel release];
        timeDownLabel = nil;
    }
    
    if (getCDKEYBtn) {
        [getCDKEYBtn removeFromSuperview];
        [getCDKEYBtn release];
        getCDKEYBtn = nil;
    }
    if (openTSeverBtn) {
        [openTSeverBtn removeFromSuperview];
        [openTSeverBtn release];
        openTSeverBtn = nil;
    }
    if (phoneImageView) {
        [phoneImageView removeFromSuperview];
        [phoneImageView release];
        phoneImageView = nil;
    }
    
    if (pwdImageView) {
        [pwdImageView removeFromSuperview];
        [pwdImageView release];
        pwdImageView = nil;
    }
    if (pwdAgainImageView) {
        [pwdAgainImageView removeFromSuperview];
        [pwdAgainImageView release];
        pwdAgainImageView = nil;
    }
    
    if (cdkeyImageView) {
        [cdkeyImageView removeFromSuperview];
        [cdkeyImageView release];
        cdkeyImageView = nil;
    }
    if (titleLabel) {
        [titleLabel removeFromSuperview];
        [titleLabel release];
        titleLabel = nil;
    }
    
    if (control) {
        [control removeFromSuperview];
        [control release];
        control = nil;
    }
    
    if (self.progressHUD) {
        [self.progressHUD removeFromSuperview];
        [self.progressHUD release];
        self.progressHUD = nil;
    }
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
    Resources *oRes = [Resources getInstance];
    mGetCDKEY = [[NIGetCDKEY alloc]init];
    mResetPWDPWD = [[NIResetPWD alloc]init];
//    titleLabel.text = [oRes getText:@"ResetPwd.navTitle"];
//    titleLabel.font = [UIFont navBarTitleSize];
//    self.navigationItem.titleView = titleLabel;
    
    self.navigationItem.title=[oRes getText:@"ResetPwd.navTitle"];
    
    if([App getVersion]>=IOS_VER_7){
        [App ios7ViewLocation:self];
        [self setNeedsStatusBarAppearanceUpdate];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_ios7_navBar_bg"] forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_ios6_navBar_bg"] forBarMetrics:UIBarMetricsDefault];
    }
    
    
    leftBtn = [[HomeButton alloc]init];
    [leftBtn addTarget:self action:@selector(popself) forControlEvents:UIControlEventTouchDown];
    leftBarBtnItem=[[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarBtnItem;
    
    phoneTextField.font = [UIFont inputTextSize];
    pwdTextField.font = [UIFont inputTextSize];
    pwdAgainTextField.font = [UIFont inputTextSize];
    cdkeyTextField.font = [UIFont inputTextSize];
    timeDownLabel.font = [UIFont inputTextSize];
    timeDownLabel.textColor = [UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:1];
    phoneTextField.placeholder = [oRes getText:@"OpenTSevice.phoneTextFeildPlaceholder"];
    pwdTextField.placeholder = [oRes getText:@"OpenTSevice.pwdTextFeildPlaceholder"];
    pwdAgainTextField.placeholder = [oRes getText:@"OpenTSevice.pwdAgainTextFeildPlaceholder"];
    cdkeyTextField.placeholder = [oRes getText:@"OpenTSevice.cdkeyTextFeildPlaceholder"];
    
    phoneLabel.text = [oRes getText:@"OpenTSevice.phoneLabel"];
    pwdLabel.text = [oRes getText:@"OpenTSevice.pwdLabel"];
    pwdAgainLabel.text = [oRes getText:@"OpenTSevice.pwdAgainLabel"];
    cdkeyLabel.text = [oRes getText:@"OpenTSevice.cdkeyLabel"];
    phoneLabel.font = [UIFont size15];
    pwdLabel.font = [UIFont size15];
    pwdAgainLabel.font = [UIFont size15];
    cdkeyLabel.font = [UIFont size15];
    
    [getCDKEYBtn setTitle:[oRes getText:@"OpenTSevice.getCDKEYBtnTitle"] forState:UIControlStateNormal];
    getCDKEYBtn.titleLabel.font = [UIFont size11];
    [getCDKEYBtn setTitleColor:[UIColor colorWithRed:213/255.0 green:14/255.0 blue:20/255.0 alpha:1] forState:UIControlStateNormal];
    
    [openTSeverBtn setTitle:[oRes getText:@"OpenTSevice.openTSeverBtnTitle"] forState:UIControlStateNormal];
    openTSeverBtn.titleLabel.font = [UIFont size17];
    
    enum SCREEN_SIZE deviceSize = [App getScreenSize];
    if (deviceSize == SCREEN_SIZE_960_640)
    {
        [controlBg setImage:[UIImage imageNamed:@"main_openTSever_iphone4_bg"]];
        cdkeyTextField.frame = CGRectMake(cdkeyTextField.frame.origin.x, cdkeyTextField.frame.origin.y-5, cdkeyTextField.frame.size.width, cdkeyTextField.frame.size.height);
        cdkeyLabel.frame = CGRectMake(cdkeyLabel.frame.origin.x, cdkeyLabel.frame.origin.y-5, cdkeyLabel.frame.size.width, cdkeyLabel.frame.size.height);
        cdkeyImageView.frame = CGRectMake(cdkeyImageView.frame.origin.x, cdkeyImageView.frame.origin.y-5, cdkeyImageView.frame.size.width, cdkeyImageView.frame.size.height);
        timeDownLabel.frame = CGRectMake(timeDownLabel.frame.origin.x, timeDownLabel.frame.origin.y-5, timeDownLabel.frame.size.width, timeDownLabel.frame.size.height);
        getCDKEYBtn.frame = CGRectMake(getCDKEYBtn.frame.origin.x, getCDKEYBtn.frame.origin.y-5, getCDKEYBtn.frame.size.width, getCDKEYBtn.frame.size.height);
        
        pwdTextField.frame = CGRectMake(pwdTextField.frame.origin.x, pwdTextField.frame.origin.y-10, pwdTextField.frame.size.width, pwdTextField.frame.size.height);
        
        pwdLabel.frame = CGRectMake(pwdLabel.frame.origin.x, pwdLabel.frame.origin.y-10, pwdLabel.frame.size.width, pwdLabel.frame.size.height);
        
        pwdImageView.frame = CGRectMake(pwdImageView.frame.origin.x, pwdImageView.frame.origin.y-10, pwdImageView.frame.size.width, pwdImageView.frame.size.height);
        
        
        pwdAgainImageView.frame = CGRectMake(pwdAgainImageView.frame.origin.x, pwdAgainImageView.frame.origin.y-15, pwdAgainImageView.frame.size.width, pwdAgainImageView.frame.size.height);
        pwdAgainTextField.frame = CGRectMake(pwdAgainTextField.frame.origin.x, pwdAgainTextField.frame.origin.y-15, pwdAgainTextField.frame.size.width, pwdAgainTextField.frame.size.height);
        pwdAgainLabel.frame = CGRectMake(pwdAgainLabel.frame.origin.x, pwdAgainLabel.frame.origin.y-15, pwdAgainLabel.frame.size.width, pwdAgainLabel.frame.size.height);
        
        openTSeverBtn.frame = CGRectMake(openTSeverBtn.frame.origin.x, openTSeverBtn.frame.origin.y-22, openTSeverBtn.frame.size.width, openTSeverBtn.frame.size.height);

    }
    else
    {
        control.frame = CGRectMake(control.frame.origin.x, control.frame.origin.y+30, control.frame.size.width, control.frame.size.height);
        [controlBg setImage:[UIImage imageNamed:@"main_openTSever_iphone5_bg"]];
        
        
        
    }
    
//    设置等待框
    [self.imageView setImage:nil];
    [self.imageView setFrame:CGRectMake(160, 200, 0, 0)];
    self.progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.navigationController.view addSubview:self.progressHUD];
    [self.view bringSubviewToFront:self.progressHUD];
    self.progressHUD.delegate = self;
    
    phoneTextField.delegate = self;
    cdkeyTextField.delegate = self;
    pwdTextField.delegate = self;
    pwdAgainTextField.delegate = self;
    [phoneTextField becomeFirstResponder];
    // Do any additional setup after loading the view from its nib.
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
 @method backgroundTap:
 @abstract 点击背景，输入框取消焦点，暂时无用
 @discussion 点击背景，输入框取消焦点，暂时无用
 @param 无
 @result 无
 */
-(IBAction)backgroundTap:(id)sender
{
    [phoneTextField resignFirstResponder];
    [cdkeyTextField resignFirstResponder];
    [pwdTextField resignFirstResponder];
    [pwdAgainTextField resignFirstResponder];
    
}


/*!
 @method getCDKEY:
 @abstract 获取短信验证码
 @discussion 获取短信验证码，校验电话号码长度，长度不符合提示alert，长度符合进行网络请求
 @param 无
 @result 无
 */
-(IBAction)getCDKEY:(id)sender
{
    Resources *oRes = [Resources getInstance];
    if (phoneTextField.text.length < 11) {
        [self MBProgressHUDMessage:[oRes getText:@"OpenTSevice.GetCDKPhoneNumError.AlertTitle"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else if (![App isNumText:phoneTextField.text])
    {
        [self MBProgressHUDMessage:[oRes getText:@"OpenTSevice.GetCDKPhoneNumError.AlertTitle"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else
    {
        self.progressHUD.labelText = [oRes getText:@"OpenTSevice.GetCDK.LoadingTitle"];
        self.progressHUD.detailsLabelText= [oRes getText:@"common.load.text"];
        [self.progressHUD show:YES];
        [mGetCDKEY createRequest:phoneTextField.text dealType:@"2"];
        [mGetCDKEY sendRequestWithAsync:self];
    }
    
}


/*!
 @method setPWD:
 @abstract 开通账号
 @discussion 开通账号，校验电话号码长度，验证码长度，密码长度，长度不符合提示alert，长度符合进行网络请求
 @param 无
 @result 无
 */
-(IBAction)setPWD:(id)sender
{
    Resources *oRes = [Resources getInstance];
    if (phoneTextField.text.length < 11) {
        //电话号码不符合要求
        [self MBProgressHUDMessage:[oRes getText:@"OpenTSevice.GetCDKPhoneNumError.AlertTitle"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else if (![App isNumText:phoneTextField.text])
    {
        [self MBProgressHUDMessage:[oRes getText:@"OpenTSevice.GetCDKPhoneNumError.AlertTitle"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else if(cdkeyTextField.text.length < 6)
    {
        //验证码不合法
        [self MBProgressHUDMessage:[oRes getText:@"OpenTSevice.cdkeyInputError.AlertTitle"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else if (![App isNumText:cdkeyTextField.text])
    {
        [self MBProgressHUDMessage:[oRes getText:@"OpenTSevice.cdkeyInputError.AlertTitle"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else if(pwdTextField.text.length < 6)
    {
        //密码不合法
        [self MBProgressHUDMessage:[oRes getText:@"OpenTSevice.OpenPWDError.AlertTitle"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else if(![pwdAgainTextField.text isEqualToString:pwdTextField.text])
    {
        //密码不合法
        [self MBProgressHUDMessage:[oRes getText:@"OpenTSevice.OpenPWDAgainError.AlertTitle"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else
    {
        self.progressHUD.labelText = [oRes getText:@"resetPWD.reset.LoadingTitle"];
        self.progressHUD.detailsLabelText= [oRes getText:@"common.load.text"];
        [self.progressHUD show:YES];
        [mResetPWDPWD createRequest:pwdTextField.text loginName:phoneTextField.text smsCode:cdkeyTextField.text];
        [mResetPWDPWD sendRequestWithAsync:self];
    }
}


/*!
 @method onGetCDKResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg
 @abstract 获取短信验证码回调方法
 @discussion 获取短信验证码回调方法，包括错误提示和倒计时
 @param result 返回数据
 @param code 状态码
 @param errorMsg 错误信息
 @result 无
 */
-(void)onGetCDKResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg
{
    Resources *oRes = [Resources getInstance];
    if (code == NAVINFO_RESULT_SUCCESS) {
        //成功
        [self MBProgressHUDMessage:[oRes getText:@"OpenTSevice.GetCDKSucces.AlertTitle"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
        secondsCountDown = 60;
        countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethid) userInfo:nil repeats:YES];
        [countDownTimer fire];
        getCDKEYBtn.enabled = NO;
        [getCDKEYBtn setTitle:nil forState:UIControlStateNormal];
        
    }
    else if(code == NET_ERROR)
    {
        //网络错误
        [self MBProgressHUDMessage:[oRes getText:@"common.noNetAlert.message"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else if(code == NAVINFO_LOGIN_PRE_PWD_RECOVERY_ACCOUNT_NOEXIST)
    {
        //账号不存在
        [self MBProgressHUDMessage:[oRes getText:@"OpenTSevice.GetCDKAccountNOExit.AlertTitle"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else if(code == NAVINFO_LOGIN_PRE_PWD_RECOVERY_ACCOUNT_NOBOUND_VEHICLE)
    {
        //该账户还未绑定车辆
        [self MBProgressHUDMessage:[oRes getText:@"OpenTSevice.GetCDKAccountNOCAR.AlertTitle"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else if(code == NAVINFO_LOGIN_PRE_PWD_RECOVERY_ACCOUNT_OPENDED)
    {
        //账号已经开通
        [self MBProgressHUDMessage:[oRes getText:@"OpenTSevice.GetCDKAccountOpened.AlertTitle"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else if(code == NAVINFO_LOGIN_PRE_PWD_RECOVERY_ACCOUNT_UNOPEN)
    {
        //账号未开通
        [self MBProgressHUDMessage:[oRes getText:@"OpenTSevice.GetCDKAccountUnopened.AlertTitle"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else
    {
        //验证码获取失败
        [self MBProgressHUDMessage:[oRes getText:@"OpenTSevice.GetCDKAccountOpened.AlertTitle"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    [self.progressHUD hide:YES];
}


/*!
 @method onResetPWDResult:(NSString *)result code:(int)code errorMsg:(NSString *)errorMsg
 @abstract 重置密码回调方法
 @discussion 重置密码回调方法，包括错误提示
 @param result 返回数据
 @param code 状态码
 @param errorMsg 错误信息
 @result 无
 */
-(void)onResetPWDResult:(NSString *)result code:(int)code errorMsg:(NSString *)errorMsg
{
    Resources *oRes = [Resources getInstance];
    if (code == NAVINFO_RESULT_SUCCESS) {
        //重置成功
        
        [self MBProgressHUDMessage:[oRes getText:@"resetPWD.resetSucces.AlertTitle"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
        
    }
    else if(code == NET_ERROR)
    {
        //网络错误
        [self MBProgressHUDMessage:[oRes getText:@"common.noNetAlert.message"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else if(code == NAVINFO_LOGIN_PWD_RECOVERY_SMSCODE_ERROR)
    {
        //验证码错误
        [self MBProgressHUDMessage:[oRes getText:@"OpenTSevice.OpenSmsCodeError.AlertTitle"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else if(code == NAVINFO_LOGIN_PWD_RECOVERY_ACCOUNT_NOEXIST)
    {
        //账户不存在
        [self MBProgressHUDMessage:[oRes getText:@"OpenTSevice.OpenAccountNOExit.AlertTitle"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else if(code == NAVINFO_LOGIN_RESETPWD_RECOVERY_ACCOUNT_UNOPEND)
    {
        //未开通
        [self MBProgressHUDMessage:[oRes getText:@"ResetPwd.AccountUnopened.AlertTitle"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else if(code == NAVINFO_LOGIN_PWD_RECOVERY_ACCOUNT_NO_VEHICLES)
    {
        //没有车
        [self MBProgressHUDMessage:[oRes getText:@"OpenTSevice.OpenAccountNOCAR.AlertTitle"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else
    {
        //未知原因开通失败
        [self MBProgressHUDMessage:[oRes getText:@"resetPWD.resetFail.AlertTitle"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    [self.progressHUD hide:YES];
}

/*!
 @method timeFireMethid
 @abstract 倒计时
 @discussion 倒计时
 @param 无
 @result 无
 */
-(void)timeFireMethid
{
    Resources *oRes = [Resources getInstance];
    if (secondsCountDown == 0) {
        [countDownTimer invalidate];
        countDownTimer =nil;
        timeDownLabel.hidden = YES;
        getCDKEYBtn.enabled = YES;
        [getCDKEYBtn setTitle:[oRes getText:@"OpenTSevice.getCDKEYBtnTitle"] forState:UIControlStateNormal];
    }
    else
    {
        timeDownLabel.text = [NSString stringWithFormat:@"%d %@",secondsCountDown,[oRes getText:@"OpenTSevice.second"]];
        timeDownLabel.hidden = NO;
        secondsCountDown --;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark set text length
/*!
 @method textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
 @abstract 根据业务需求控制各输入框输入内容的长度
 @discussion 根据业务需求控制各输入框输入内容的长度
 @param 无
 @result 无
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{  //string就是此时输入的那个字符textField就是此时正在输入的那个输入框返回YES就是可以改变输入框的值NO相反
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    if (phoneTextField == textField)  //判断是否时我们想要限定的那个输入框
    {
        if ([toBeString length] > 11) { //如果电话号码输入框内容大于11截取
            textField.text = [toBeString substringToIndex:11];
            return NO;
        }
    }
    else if (cdkeyTextField == textField) {
        if ([toBeString length] > 6) { //如果验证码输入框内容大于6截取
            textField.text = [toBeString substringToIndex:6];
            return NO;
        }
    }
    else if (pwdTextField == textField) {
        if ([toBeString length] > 20) { //如果密码输入框内容大于20截取
            textField.text = [toBeString substringToIndex:20];
            return NO;
        }
    }
    else if (pwdAgainTextField == textField) {
        if ([toBeString length] > 20) { //如果密码输入框内容大于20截取
            textField.text = [toBeString substringToIndex:20];
            return NO;
        }
    }
    else
    {
        
    }
    return YES;
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
