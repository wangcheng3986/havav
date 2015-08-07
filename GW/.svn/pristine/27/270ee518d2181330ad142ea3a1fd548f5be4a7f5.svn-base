
/*!
 @header SetViewController.m
 @abstract 设置类
 @author mengy
 @version 1.00 13-5-3 Creation
 */
#import "SetViewController.h"
#import "App.h"
@interface SetViewController ()
{
    BOOL mOpenAboutView;
    BOOL mOpenOpinionView;
    BOOL mOpenClearView;
    BOOL mOpenVersionView;
    int operateType;
    int loginType;
    UserData *mUserData;
    UITextView *activeView;
    UIBarButtonItem *leftButton;
}
@end

@implementation SetViewController
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
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (titleLabel) {
        [titleLabel removeFromSuperview];
        [titleLabel release];
    }
    if (clearLabel) {
        [clearLabel removeFromSuperview];
        [clearLabel release];
    }
    if (versionLabel) {
        [versionLabel removeFromSuperview];
        [versionLabel release];
    }
    if (feedbackLabel) {
        [feedbackLabel removeFromSuperview];
        [feedbackLabel release];
    }
    if (aboutLabel) {
        [aboutLabel removeFromSuperview];
        [aboutLabel release];
    }
    if (aboutView) {
        [aboutView removeFromSuperview];
        [aboutView release];
    }
    if (aboutBg) {
        [aboutBg removeFromSuperview];
        [aboutBg release];
    }
    if (mDisImageView) {
        [mDisImageView removeFromSuperview];
        [mDisImageView release];
    }
    if (mDisView) {
        [mDisView removeFromSuperview];
        [mDisView release];
    }
    if (opinionView) {
        [opinionView removeFromSuperview];
        [opinionView release];
    }
    if (opinionBg) {
        [opinionBg removeFromSuperview];
        [opinionBg release];
    }
    if (opinionInputUpBg) {
        [opinionInputUpBg removeFromSuperview];
        [opinionInputUpBg release];
    }
    if (opinionInputDownBg) {
        [opinionInputDownBg removeFromSuperview];
        [opinionInputDownBg release];
    }
    if (opinionTitleLabel) {
        [opinionTitleLabel removeFromSuperview];
        [opinionTitleLabel release];
    }
    if (opinionTitleTextView) {
        [opinionTitleTextView removeFromSuperview];
        [opinionTitleTextView release];
    }
    if (opinionTextView) {
        [opinionTextView removeFromSuperview];
        [opinionTextView release];
    }
    if (opinionLabel) {
        [opinionLabel removeFromSuperview];
        [opinionLabel release];
    }
    if (cencelButton) {
        [cencelButton removeFromSuperview];
        [cencelButton release];
    }
    if (submitButton) {
        [submitButton removeFromSuperview];
        [submitButton release];
    }
    if (versionsTitleLabel) {
        [versionsTitleLabel removeFromSuperview];
        [versionsTitleLabel release];
    }
    if (versionsTextLabel) {
        [versionsTextLabel removeFromSuperview];
        [versionsTextLabel release];
    }
    if (phoneTitleLabel) {
        [phoneTitleLabel removeFromSuperview];
        [phoneTitleLabel release];
    }
    if (ownerTitleLabel) {
        [ownerTitleLabel removeFromSuperview];
        [ownerTitleLabel release];
    }
    if (ownerTextLabel) {
        [ownerTextLabel removeFromSuperview];
        [ownerTextLabel release];
    }
    if (supportTitleLabel) {
        [supportTitleLabel removeFromSuperview];
        [supportTitleLabel release];
    }
    if (supportTextLabel) {
        [supportTextLabel removeFromSuperview];
        [supportTextLabel release];
    }
    if (describeTitleLabel) {
        [describeTitleLabel removeFromSuperview];
        [describeTitleLabel release];
    }
    if (describeTextLabel) {
        [describeTextLabel removeFromSuperview];
        [describeTextLabel release];
    }
    if (phoneTextButton) {
        [phoneTextButton removeFromSuperview];
        [phoneTextButton release];
    }
    if (ownerURLTextButton) {
        [ownerURLTextButton removeFromSuperview];
        [ownerURLTextButton release];
    }
    if (supportURLTextButton) {
        [supportURLTextButton removeFromSuperview];
        [supportURLTextButton release];
    }
    if (versionNumberLabel) {
        [versionNumberLabel removeFromSuperview];
        [versionNumberLabel release];
    }
    if (versionInformationLabel) {
        [versionInformationLabel removeFromSuperview];
        [versionInformationLabel release];
    }
    if (versionView) {
        [versionView removeFromSuperview];
        [versionView release];
    }
    if (versionBg) {
        [versionBg removeFromSuperview];
        [versionBg release];
    }
    if (clearView) {
        [clearView removeFromSuperview];
        [clearView release];
    }
    if (clearBg) {
        [clearBg removeFromSuperview];
        [clearBg release];
    }
    if (clearContentLabel) {
        [clearContentLabel removeFromSuperview];
        [clearContentLabel release];
    }
    if (clearCencelBtn) {
        [clearCencelBtn removeFromSuperview];
        [clearCencelBtn release];
    }
    if (clearConfirmBtn) {
        [clearConfirmBtn removeFromSuperview];
        [clearConfirmBtn release];
    }
    if (versionBtn) {
        [versionBtn removeFromSuperview];
        [versionBtn release];
    }
    if (versionCancelBtn) {
        [versionCancelBtn removeFromSuperview];
        [versionCancelBtn release];
    }
    if (versionConfirmBtn) {
        [versionConfirmBtn removeFromSuperview];
        [versionConfirmBtn release];
    }
    if (leftBtn) {
        [leftBtn removeFromSuperview];
        [leftBtn release];
    }
    if (clearBtn) {
        [clearBtn removeFromSuperview];
        [clearBtn release];
    }
    if (clearBtnIcon) {
        [clearBtnIcon removeFromSuperview];
        [clearBtnIcon release];
    }
    if (clearBtnDetailIcon) {
        [clearBtnDetailIcon removeFromSuperview];
        [clearBtnDetailIcon release];
    }
    if (settingDownBg) {
        [settingDownBg removeFromSuperview];
        [settingDownBg release];
    }
    if (aboutBtn) {
        [aboutBtn removeFromSuperview];
        [aboutBtn release];
    }
    if (aboutBtnIcon) {
        [aboutBtnIcon removeFromSuperview];
        [aboutBtnIcon release];
    }
    if (aboutBtnDetailIcon) {
        [aboutBtnDetailIcon removeFromSuperview];
        [aboutBtnDetailIcon release];
    }
    if (opinionBtn) {
        [opinionBtn removeFromSuperview];
        [opinionBtn release];
    }
    if (opinionBtnIcon) {
        [opinionBtnIcon removeFromSuperview];
        [opinionBtnIcon release];
    }
    if (opinionBtnDetailIcon) {
        [opinionBtnDetailIcon removeFromSuperview];
        [opinionBtnDetailIcon release];
    }
    if (settingVersionBtn) {
        [settingVersionBtn removeFromSuperview];
        [settingVersionBtn release];
    }
    if (versionBtnIcon) {
        [versionBtnIcon removeFromSuperview];
        [versionBtnIcon release];
    }
    if (versionBtnDetailIcon) {
        [versionBtnDetailIcon removeFromSuperview];
        [versionBtnDetailIcon release];
    }
    if (settingLine1) {
        [settingLine1 removeFromSuperview];
        [settingLine1 release];
    }
    if (settingLine2) {
        [settingLine2 removeFromSuperview];
        [settingLine2 release];
    }
    if (leftButton) {
        [leftButton release];
        leftButton = nil;
    }
    if (opinionTitlePlaceHolderLabel) {
        [opinionTitlePlaceHolderLabel release];
        opinionTitlePlaceHolderLabel = nil;
    }
    if (opinionMessagePlaceHolderLabel) {
        [opinionMessagePlaceHolderLabel release];
        opinionMessagePlaceHolderLabel = nil;
    }
    if (self.progressHUD){
        [self.progressHUD removeFromSuperview];
        [self.progressHUD release];
        self.progressHUD = nil;
    }
    if (textCountLabel) {
        [textCountLabel release];
        textCountLabel = nil;
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
    App *app=[App getInstance];
    mUserData=[app getUserData];
    loginType=mUserData.mType;
    self.view.backgroundColor = [UIColor colorWithRed:231.0/255 green:231.0/255 blue:231.0/255 alpha:1];
    //适配IOS7，替换背景图片
    if([App getVersion]>=IOS_VER_7){
        [App ios7ViewLocation:self];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_ios7_navBar_bg"] forBarMetrics:UIBarMetricsDefault];
        opinionMessagePlaceHolderLabel.frame = CGRectMake(opinionMessagePlaceHolderLabel.frame.origin.x-4, opinionMessagePlaceHolderLabel.frame.origin.y-2, opinionMessagePlaceHolderLabel.frame.size.width, opinionMessagePlaceHolderLabel.frame.size.height);
        opinionTitlePlaceHolderLabel.frame = CGRectMake(opinionTitlePlaceHolderLabel.frame.origin.x-4, opinionTitlePlaceHolderLabel.frame.origin.y-2, opinionTitlePlaceHolderLabel.frame.size.width, opinionTitlePlaceHolderLabel.frame.size.height);
    }
    else
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_ios6_navBar_bg"] forBarMetrics:UIBarMetricsDefault];
    }

    Resources *oRes = [Resources getInstance];
    mOpenAboutView=NO;
    mOpenOpinionView=NO;
    mOpenClearView=NO;
    mOpenVersionView=NO;
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height);
    mDisView.frame = rect;
    [self.view addSubview:mDisView];
    mDisView.hidden=YES;
    rect = CGRectMake(18, -aboutView.frame.size.height*2, aboutView.frame.size.width, aboutView.frame.size.height);
    aboutView.frame = rect;
    [self.view addSubview:aboutView];
    rect = CGRectMake(18, -opinionView.frame.size.height*2, opinionView.frame.size.width, opinionView.frame.size.height);
    opinionView.frame = rect;
    [self.navigationController.view addSubview:opinionView];
//    [[UIApplication sharedApplication].keyWindow addSubview:opinionView];
    rect = CGRectMake(18, -clearView.frame.size.height*2, clearView.frame.size.width, clearView.frame.size.height);
    clearView.frame = rect;
    [self.view addSubview:clearView];
    rect = CGRectMake(18, -versionView.frame.size.height*2, versionView.frame.size.width, versionView.frame.size.height);
    versionView.frame = rect;
    [self.view addSubview:versionView];
//    titleLabel.text=[oRes getText:@"set.setViewController.title"];
//    titleLabel.font =[UIFont navBarTitleSize];
//    titleLabel.textColor=[UIColor whiteColor];
//    self.navigationItem.titleView=titleLabel;
    
    
    self.navigationItem.title=[oRes getText:@"set.setViewController.title"];
    
    opinionTitleLabel.text=[oRes getText:@"set.opinion.title"];
    opinionLabel.text=[oRes getText:@"set.opinion.content"];
    opinionLabel.font=[UIFont inputTitleSize];
    opinionTitleLabel.font=[UIFont inputTitleSize];
    [cencelButton setTitle:[oRes getText:@"set.opinion.cencel"] forState:UIControlStateNormal];
    [submitButton setTitle:[oRes getText:@"set.opinion.submit"] forState:UIControlStateNormal];
    submitButton.titleLabel.font = [UIFont btnTitleSize];
    cencelButton.titleLabel.font = [UIFont btnTitleSize];
    textCountLabel.text = @"0/255";
    textCountLabel.hidden = YES;
    clearContentLabel.text=[oRes getText:@"set.clearAlert.message"];
    clearContentLabel.font=[UIFont size14_5];
    versionInformationLabel.font=[UIFont size14_5];
    [clearCencelBtn setTitle:[oRes getText:@"set.setViewController.clearCencelButton"] forState:UIControlStateNormal];
    [clearConfirmBtn setTitle:[oRes getText:@"set.setViewController.clearConfirmButton"] forState:UIControlStateNormal];
    clearCencelBtn.titleLabel.font = [UIFont btnTitleSize];
    clearConfirmBtn.titleLabel.font = [UIFont btnTitleSize];
    [versionBtn setTitle:[oRes getText:@"set.setViewController.versionButton"] forState:UIControlStateNormal];
    [versionCancelBtn setTitle:[oRes getText:@"set.setViewController.versionCancelButton"] forState:UIControlStateNormal];
    [versionConfirmBtn setTitle:[oRes getText:@"set.setViewController.versionButton"] forState:UIControlStateNormal];
    versionBtn.titleLabel.font = [UIFont btnTitleSize];
    versionCancelBtn.titleLabel.font = [UIFont btnTitleSize];
    versionConfirmBtn.titleLabel.font = [UIFont btnTitleSize];
    
    leftBtn = [[HomeButton alloc]init];
    [leftBtn addTarget:self action:@selector(popself) forControlEvents:UIControlEventTouchDown];
    leftButton=[[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftButton;
//    opinionTextView.text=[oRes getText:@"set.opinion.contentPlaceholder"];
//    opinionTitleTextView.text=[oRes getText:@"set.opinion.titlePlaceholder"];
    opinionMessagePlaceHolderLabel.text = [oRes getText:@"set.opinion.contentPlaceholder"];
    opinionTitlePlaceHolderLabel.text = [oRes getText:@"set.opinion.titlePlaceholder"];
    opinionTitleTextView.font =[UIFont inputTextSize];
    opinionTextView.font =[UIFont inputTextSize];
    opinionMessagePlaceHolderLabel.font = [UIFont inputTextSize];
    opinionTitlePlaceHolderLabel.font = [UIFont inputTextSize];
    opinionTextView.delegate=self;
    opinionTitleTextView.delegate=self;
    versionNumberLabel.hidden=YES;
    [self load];
    [self loadAboutView];
    
    //当进入视图时，重新设置imageView
    [self.imageView setImage:nil];
    [self.imageView setFrame:CGRectMake(160, 200, 0, 0)];
    //显示加载等待框
    self.progressHUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.view addSubview:self.progressHUD];
    [self.view bringSubviewToFront:self.progressHUD];
    self.progressHUD.delegate = self;
    //监听键盘状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillDisappear:(BOOL)animated
{
    [opinionTextView resignFirstResponder];
    [opinionTitleTextView resignFirstResponder];
    opinionView.hidden = YES;
    [super viewWillDisappear:animated];
}

/*!
 @method popself
 @abstract 返回上个界面
 @discussion 加返回上个界面
 @param 无
 @result 无
 */
-(void)popself
{
    [self.navigationController popViewControllerAnimated:YES]; 
}

/*!
 @method load
 @abstract 加载界面
 @discussion 加载界面
 @param 无
 @result 无
 */
-(void)load
{
    Resources *oRes = [Resources getInstance];
    NSString *str1 = [[NSString alloc]initWithString:[oRes getText:@"set.setViewController.clearButton"]];
    NSString *str2 = [[NSString alloc]initWithString:[oRes getText:@"set.setViewController.detectionButton"]];
    NSString *str3 = [[NSString alloc]initWithString:[oRes getText:@"set.setViewController.opinionButton"]];
    NSString *str4 = [[NSString alloc]initWithString:[oRes getText:@"set.setViewController.aboutButton"]];
    clearLabel.text=str1;
    versionLabel.text=str2;
    feedbackLabel.text=str3;
    aboutLabel.text=str4;
    clearLabel.font=[UIFont size14_5];
    versionLabel.font=[UIFont size14_5];
    feedbackLabel.font=[UIFont size14_5];
    aboutLabel.font=[UIFont size14_5];
    [str1 release];
    [str2 release];
    [str3 release];
    [str4 release];
}

/*!
 @method loadAboutView
 @abstract 加载关于界面
 @discussion 加载关于界面
 @param 无
 @result 无
 */
-(void)loadAboutView
{
    Resources *oRes = [Resources getInstance];
    versionsTitleLabel.text=[oRes getText:@"set.about.versionsTitleLabel"];
    versionsTextLabel.text= [NSString stringWithFormat:@"V%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]];
    phoneTitleLabel.text=[oRes getText:@"set.about.phoneTitleLabel"];
    ownerTitleLabel.text=[oRes getText:@"set.about.ownerTitleLabel"];
    ownerTextLabel.text=[oRes getText:@"set.about.ownerTextLabel"];
    supportTitleLabel.text=[oRes getText:@"set.about.supportTitleLabel"];
    supportTextLabel.text=[oRes getText:@"set.about.supportTextLabel"];
    describeTitleLabel.text=[oRes getText:@"set.about.describeTitleLabel"];
    describeTextLabel.text=[NSString stringWithFormat:@"%@%@",SERVER_URL,ADD_URL];
    UIColor *titleColor = [[UIColor alloc] initWithRed:0 green:0.306 blue:0.784 alpha:1];
//    设置没有下划线
//    phoneTextButton.noLine = YES;
//    ownerURLTextButton.noLine = YES;
//    supportURLTextButton.noLine = YES;
    phoneTextButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    ownerURLTextButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    supportURLTextButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [phoneTextButton setTitle:[oRes getText:@"set.about.phoneTextLabel"] forState:UIControlStateNormal];
    phoneTextButton.titleLabel.font=[UIFont size14_5];
    [phoneTextButton setTitleColor:titleColor forState:UIControlStateNormal];
    [ownerURLTextButton setTitle:[oRes getText:@"set.about.ownerURLTextLabel"] forState:UIControlStateNormal];
    ownerURLTextButton.titleLabel.font=[UIFont size14_5];
    [ownerURLTextButton setTitleColor:titleColor forState:UIControlStateNormal];
    
    
    [supportURLTextButton setTitle:[oRes getText:@"set.about.supportURLTextLabel"] forState:UIControlStateNormal];
    supportURLTextButton.titleLabel.font=[UIFont size14_5];
    [supportURLTextButton setTitleColor:titleColor forState:UIControlStateNormal];
    versionsTitleLabel.font=[UIFont size14_5];
    versionsTextLabel.font=[UIFont size14_5];
    phoneTitleLabel.font=[UIFont size14_5];
    ownerTitleLabel.font=[UIFont size14_5];
    ownerTextLabel.font=[UIFont size14_5];
    supportTitleLabel.font=[UIFont size14_5];
    supportTextLabel.font=[UIFont size14_5];
    describeTitleLabel.font=[UIFont size14_5];
    describeTextLabel.font=[UIFont size14_5];

    [titleColor release];
}

/*!
 @method aboutView:(id)sender
 @abstract 显示关于界面
 @discussion 显示关于界面
 @param 无
 @result 无
 */
-(IBAction)aboutView:(id)sender
{
   
    [self showAboutView];
}

/*!
 @method call:
 @abstract 拨打电话
 @discussion 拨打电话
 @param 无
 @result 无
 */
-(IBAction)call:(id)sender
{
    Resources *oRes = [Resources getInstance];
    NSString *phoneNumber=[oRes getText:@"set.about.phoneTextLabel"];
    App *app = [App getInstance];
    [app callPhone:phoneNumber];
    
}

/*!
 @method goOwnerURL:
 @abstract 打开链接
 @discussion 打开链接
 @param 无
 @result 无
 */
-(IBAction)goOwnerURL:(id)sender
{
    Resources *oRes = [Resources getInstance];
    NSString *url=[oRes getText:@"set.about.ownerURLTextLabel"];
    App *app = [App getInstance];
    [app openBrowser:url];
}

/*!
 @method goSupportURL:
 @abstract 打开链接
 @discussion 打开链接
 @param 无
 @result 无
 */
-(IBAction)goSupportURL:(id)sender
{
    Resources *oRes = [Resources getInstance];
    NSString *url=[oRes getText:@"set.about.supportURLTextLabel"];
    App *app = [App getInstance];
    [app openBrowser:url];
    
}

/*!
 @method showAboutView
 @abstract 打开或关闭关于界面
 @discussion 打开或关闭关于界面
 @param 无
 @result 无
 */
- (void)showAboutView
{
    if (mOpenAboutView == NO) {
        aboutView.center=self.view.center;
        CGRect rect = CGRectMake(18,45, aboutView.frame.size.width, aboutView.frame.size.height);
        aboutView.frame = rect;
        mOpenAboutView = YES;
        mDisView.hidden = NO;
    }else{
        CGRect rect = CGRectMake(18, -aboutView.frame.size.height*2, aboutView.frame.size.width, aboutView.frame.size.height);
        aboutView.frame = rect;
        mOpenAboutView = NO;
        mDisView.hidden = YES;
    }

}

/*!
 @method clearView:
 @abstract 打开或关闭清除历史记录界面
 @discussion 打开或关闭清除历史记录界面
 @param 无
 @result 无
 */
-(IBAction)clearView:(id)sender
{
    [self showClearView];
}

/*!
 @method showClearView
 @abstract 打开或关闭清除历史记录界面
 @discussion 打开或关闭清除历史记录界面
 @param 无
 @result 无
 */
- (void)showClearView
{
    ClearHistoryViewController *clearVC = [[ClearHistoryViewController alloc]init];
    [self.navigationController pushViewController:clearVC animated:YES];
    [clearVC release];
//    if (mOpenClearView == NO) {
//        CGRect rect = CGRectMake(18, 92, clearView.frame.size.width, clearView.frame.size.height);
//        clearView.frame = rect;
//        mOpenClearView = YES;
//        mDisView.hidden = NO;
//    }else{
//        CGRect rect = CGRectMake(18, -clearView.frame.size.height*2, clearView.frame.size.width, clearView.frame.size.height);
//        clearView.frame = rect;
//        mOpenClearView = NO;
//        mDisView.hidden = YES;
//    }
    
}

/*!
 @method goAppStore:
 @abstract 链接打开商店
 @discussion 链接打开商店
 @param 无
 @result 无
 */
-(IBAction)goAppStore:(id)sender
{
    [self versionView];
    NSString *str = [NSString stringWithFormat:@"https://itunes.apple.com/us/app/"];
//    大众app连接
//     NSString *str = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/da-zhong-qi-che-che-lian-wang/id671462563?mt=8"];
    App *app = [App getInstance];
    [app openBrowser:str];
}

/*!
 @method cancelVersionView:
 @abstract 单击取消，版本检测界面消失
 @discussion 单击取消，版本检测界面消失
 @param 无
 @result 无
 */
-(IBAction)cancelVersionView:(id)sender
{
    [self versionView];
}

/*!
 @method versionView
 @abstract 打开会关闭版本检测界面
 @discussion 打开会关闭版本检测界面
 @param 无
 @result 无
 */
- (void)versionView
{
    if (mOpenVersionView == NO) {
        CGRect rect = CGRectMake(18, 92, versionView.frame.size.width, versionView.frame.size.height);
        versionView.frame = rect;
        mOpenVersionView = YES;
        mDisView.hidden = NO;
    }else{
        CGRect rect = CGRectMake(18, -versionView.frame.size.height*2, versionView.frame.size.width, versionView.frame.size.height);
        versionView.frame = rect;
        mOpenVersionView = NO;
        mDisView.hidden = YES;
    }
    
}

/*!
 @method opinionView:
 @abstract 意见反馈
 @discussion 意见反馈
 @param 无
 @result 无
 */
-(IBAction)opinionView:(id)sender
{
    [self showOpinionView];
}

/*!
 @method showOpinionView
 @abstract 打开或关闭意见反馈界面
 @discussion 打开或关闭意见反馈界面
 @param 无
 @result 无
 */
- (void)showOpinionView
{
    
    if (mOpenOpinionView == NO) {
//        opinionTextView.text=[oRes getText:@"set.opinion.contentPlaceholder"];
//        opinionTitleTextView.text=[oRes getText:@"set.opinion.titlePlaceholder"];
        CGRect rect = CGRectMake(18, 109, opinionView.frame.size.width, opinionView.frame.size.height);
        opinionView.frame = rect;
        opinionView.hidden = NO;
        mOpenOpinionView = YES;
        mDisView.hidden = NO;
        [opinionTitleTextView becomeFirstResponder];
    }else{
        [opinionTextView resignFirstResponder];
        [opinionTitleTextView resignFirstResponder];
        CGRect rect = CGRectMake(18, -opinionView.frame.size.height*2, opinionView.frame.size.width, opinionView.frame.size.height);
        opinionView.frame = rect;
        opinionView.hidden = YES;
        mOpenOpinionView = NO;
        mDisView.hidden = YES;
    }
    
}

/*!
 @method onClickClear:
 @abstract 清除搜索历史记录，现在不用了
 @discussion 清除搜索历史记录，现在不用了
 @param 无
 @result 无
 */
-(IBAction)onClickClear:(id)sender
{
    
    App *app=[App getInstance];
    Resources *oRes = [Resources getInstance];
    [self showClearView];
    if ([app deleteSearchHistory]) {
        [self MBProgressHUDMessage:[oRes getText:@"set.clearAlert.clearSuccess"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else
    {
        [self MBProgressHUDMessage:[oRes getText:@"set.clearAlert.clearfail"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
}

/*!
 @method onclickOpinionCencel:
 @abstract 意见反馈取消
 @discussion 意见反馈取消
 @param 无
 @result 无
 */
-(IBAction)onclickOpinionCencel:(id)sender
{
//    opinionTitleTextView.text=[oRes getText:@"set.opinion.titlePlaceholder"] ;
//    opinionTextView.text=[oRes getText:@"set.opinion.contentPlaceholder"];
    opinionTextView.text = @"";
    opinionTitleTextView.text = @"";
    opinionTitlePlaceHolderLabel.hidden = NO;
    opinionMessagePlaceHolderLabel.hidden = NO;
    [self showOpinionView];
}

/*!
 @method onclickOpinionSubmit:
 @abstract 意见反馈提交
 @discussion 意见反馈提交
 @param 无
 @result 无
 */
-(IBAction)onclickOpinionSubmit:(id)sender
{
    
    Resources *oRes = [Resources getInstance];
    if ([[opinionTitleTextView.text stringByTrimmingCharactersInSet:
                                   [NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
                [self MBProgressHUDMessage:[oRes getText:@"set.opinion.alertTitleNill"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else
    {
        if ([[opinionTextView.text stringByTrimmingCharactersInSet:
              [NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
            
            [self MBProgressHUDMessage:[oRes getText:@"set.opinion.alertContentNill"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
        }
        else
        {
            [self showOpinionView];
//            demo也与服务器交互
            [self feedBack];
//            if (loginType==USER_LOGIN_DEMO) {
//                [self submitOpinion];
//                [self MBProgressHUDMessage:[oRes getText:@"set.opinion.submitYesAlert"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
//            }
//            else
//            {
//                [self feedBack];
//            }
            
        }
    }
}

/*!
 @method submitOpinion
 @abstract 意见反馈提交
 @discussion 意见反馈提交
 @param 无
 @result 无
 */
-(void)submitOpinion
{
    Resources *oRes = [Resources getInstance];
//    opinionTitleTextView.text=[oRes getText:@"set.opinion.titlePlaceholder"] ;
//    opinionTextView.text=[oRes getText:@"set.opinion.contentPlaceholder"];
    opinionTextView.text = @"";
    opinionTitleTextView.text = @"";
    opinionTitlePlaceHolderLabel.hidden = NO;
    opinionMessagePlaceHolderLabel.hidden = NO;
}

/*!
 @method getProfile
 @abstract 获取版本信息
 @discussion 获取版本信息
 @param 无
 @result 无
 */
- (void)getProfile
{
    Resources *oRes = [Resources getInstance];
    leftBtn.enabled=NO;
    
    self.progressHUD.labelText = [oRes getText:@"set.version.searchTitle"];
    self.progressHUD.detailsLabelText=[oRes getText:@"common.load.text"];
    [self.progressHUD show:YES];
    operateType=OPERATE_PROFILE;
    mGetProfileApp = [[[NIGetProfileApp alloc]init] autorelease];
    [mGetProfileApp createRequest:1];
    [mGetProfileApp sendRequestWithAsync:self];
    
}

/*!
 @method feedBack
 @abstract 意见反馈，网络请求
 @discussion 意见反馈，网络请求
 @param 无
 @result 无
 */
- (void)feedBack
{
    Resources *oRes = [Resources getInstance];
    leftBtn.enabled=NO;
    
    self.progressHUD.labelText = [oRes getText:@"set.opinion.loading"];
    self.progressHUD.detailsLabelText=[oRes getText:@"common.load.text"];
    [self.progressHUD show:YES];
    operateType=OPERATE_FEEDBACK;
    mFeedBack = [[[NIFeedBack alloc]init] autorelease];
    [mFeedBack createRequest:opinionTitleTextView.text content:opinionTextView.text type:2];
    [mFeedBack sendRequestWithAsync:self];
}

/*!
 @method onProfileResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg
 @abstract 版本检测，回调函数
 @discussion 版本检测，回调函数
 @param result 返回数据
 @param code 返回码
 @param errorMsg 错误信息
 @result 无
 */
- (void)onProfileResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg
{
    Resources *oRes = [Resources getInstance];
    if (code == NAVINFO_RESULT_SUCCESS) {
        NSLog(@"result is :%@", result);
        if ([result valueForKey:@"version"] == nil ||[result valueForKey:@"versionUrl"] == nil || [[result valueForKey:@"versionUrl"]isEqualToString:@""])
        {
            [self MBProgressHUDMessage:[oRes getText:@"set.version.upsateFail"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
        }
        else
        {
            if ([[result valueForKey:@"version"]integerValue] > APP_VERSION) {
                versionInformationLabel.text=[oRes getText:@"set.setViewController.versionUpdate"];
                versionConfirmBtn.hidden = YES;
                versionCancelBtn.hidden = NO;
                versionBtn.hidden = NO;
            }
            else
            {
                versionInformationLabel.text=[oRes getText:@"set.setViewController.versionNoUpdate"];
                versionConfirmBtn.hidden = NO;
                versionCancelBtn.hidden = YES;
                versionBtn.hidden = YES;
            }
            
            [self versionView];
        }
    }
    else if(code == NET_ERROR)
    {
        
        [self MBProgressHUDMessage:[oRes getText:@"common.noNetAlert.message"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else
    {
        [self MBProgressHUDMessage:[oRes getText:@"set.version.upsateFail"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    [self.imageView setFrame:CGRectMake(160, 200, 0, 0)];
    [self.progressHUD hide:YES];
    leftBtn.enabled=YES;
}

/*!
 @method onFeedBackResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg
 @abstract 意见反馈，回调函数
 @discussion 意见反馈，回调函数
 @param result 返回数据
 @param code 返回码
 @param errorMsg 错误信息
 @result 无
 */
- (void)onFeedBackResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg
{
    Resources *oRes = [Resources getInstance];
    if (code == NAVINFO_RESULT_SUCCESS) {
        [self submitOpinion];
        [self MBProgressHUDMessage:[oRes getText:@"set.opinion.submitYesAlert"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
        
    }
    else if(code == NET_ERROR)
    {
        [self MBProgressHUDMessage:[oRes getText:@"common.noNetAlert.message"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else
    {
        [self MBProgressHUDMessage:[oRes getText:@"set.opinion.failAlert"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    leftBtn.enabled=YES;
    [self.progressHUD hide:YES];
}


/*!
 @method mDisbackgroundTap:(id)sender
 @abstract 单击背景，关于/意见反馈/清除历史/版本检测键盘弹回
 @discussion 单击背景，关于/意见反馈/清除历史/版本检测键盘弹回
 @param 无
 @result 无
 */
-(IBAction)mDisbackgroundTap:(id)sender
{
    if(mOpenAboutView==YES)
    {
        [self showAboutView];
    }
    if(mOpenClearView==YES)
    {
        [self showClearView];
    }
    if(mOpenOpinionView==YES)
    {
        [self showOpinionView];
    }
    if(mOpenVersionView==YES)
    {
        [self versionView];
    }
    [opinionTextView resignFirstResponder];
    [opinionTitleTextView resignFirstResponder];
    
}

-(IBAction)textFieldDidEndEditing:(id)sender
{
     [sender resignFirstResponder];
}
-(IBAction)textFieldDoneEditing:(id)sender
{

    [sender resignFirstResponder];

}

/*!
 @method opinionBackgroundTap:
 @abstract 单击意见反馈界面除输入框外的地方
 @discussion 单击意见反馈界面除输入框外的地方，输入框取消焦点
 @param 无
 @result 无
 */
-(IBAction)opinionBackgroundTap:(id)sender
{
    [opinionTextView resignFirstResponder];
    [opinionTitleTextView resignFirstResponder];
}

/*!
 @method onclickVersion:
 @abstract 获取版本信息
 @discussion 获取版本信息
 @param 无
 @result 无
 */
-(IBAction)onclickVersion:(id)sender
{
    //获取版本信息
    [self getProfile];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*!
 @method textViewDidBeginEditing:
 @abstract 根据屏幕大小，意见反馈上移
 @discussion 根据屏幕大小，意见反馈上移
 @param textView
 @result 无
 */
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    enum SCREEN_SIZE   deviceSize = [App getScreenSize];
    if (opinionTextView.isFirstResponder ) {
        //        根据设备屏幕大小判断
        if (deviceSize == SCREEN_SIZE_960_640)
        {
            [UIView animateWithDuration:0.25 animations:^{
                opinionView.frame = CGRectMake(opinionView.frame.origin.x, 20, opinionView.frame.size.width, opinionView.frame.size.height);
            } completion:nil];
        }
        else
        {
            [UIView animateWithDuration:0.25 animations:^{
                opinionView.frame = CGRectMake(opinionView.frame.origin.x, 30, opinionView.frame.size.width, opinionView.frame.size.height);
            } completion:nil];
        }
        
    }
    else if(opinionTitleTextView.isFirstResponder)
    {
        //        根据设备屏幕大小判断
        if (deviceSize == SCREEN_SIZE_960_640)
        {
            [UIView animateWithDuration:0.25 animations:^{
                opinionView.frame = CGRectMake(opinionView.frame.origin.x, 64, opinionView.frame.size.width, opinionView.frame.size.height);
            } completion:nil];
        }
        else
        {
            [UIView animateWithDuration:0.25 animations:^{
                opinionView.frame = CGRectMake(opinionView.frame.origin.x, 109, opinionView.frame.size.width, opinionView.frame.size.height);
            } completion:nil];
        }
        
    }
    activeView = textView;
}

#pragma mark -
#pragma mark uiTextView methods

/*!
 @method textViewDidChange:
 @abstract 输入框内容改变时执行
 @discussion 输入框内容改变时执行
 @param textView
 @result 无
 */
- (void)textViewDidChange:(UITextView *)textView
{
    UITextRange *selectedRange = [textView markedTextRange];
    NSString * newText = [textView textInRange:selectedRange];
    if (textView==opinionTextView) {
        if ([textView.text isEqualToString:@""]){
            opinionMessagePlaceHolderLabel.hidden = NO;
        }
        else
        {
            opinionMessagePlaceHolderLabel.hidden = YES;
        }
        
        if(newText == nil || [newText isEqualToString:@""])
        {
            if (opinionTextView.text.length > 255) {
                opinionTextView.text = [opinionTextView.text substringToIndex:255];
            }
        }
        textCountLabel.text = [NSString stringWithFormat:@"%d/255",textView.text.length];
        
    }
    else if(textView==opinionTitleTextView)
    {
        if ([textView.text isEqualToString:@""]) {
            opinionTitlePlaceHolderLabel.hidden = NO;
        }
        else
        {
            opinionTitlePlaceHolderLabel.hidden = YES;
        }
        if(newText == nil || [newText isEqualToString:@""])
        {
            if (opinionTitleTextView.text.length > 32) {
                opinionTitleTextView.text = [opinionTitleTextView.text substringToIndex:32];
            }
        }
        
    }
}

/*!
 @method keyboardWillHide:
 @abstract 键盘消失，意见反馈位置下移
 @discussion 键盘消失，意见反馈位置下移
 @param notification
 @result 无
 */
- (void)keyboardWillHide:(NSNotification *)notification
{
    NSLog(@"键盘收回");
    if (mDisView.hidden == NO) {
        [UIView animateWithDuration:0.25 animations:^{
            opinionView.frame = CGRectMake(opinionView.frame.origin.x, 109, opinionView.frame.size.width, opinionView.frame.size.height);
        } completion:nil];
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

@end
