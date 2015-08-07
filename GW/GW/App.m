//
//  App.m
//  VW
//
//  Created by kexin on 12-6-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "App.h"
#import "BaseViewController.h"
#import "sys/utsname.h"
#import "BaseNavigationController.h"

#import "pinyin.h"
#import "CherryDBControl.h"

@implementation App
@synthesize mUserData;
@synthesize mCarData;
@synthesize mCarPOI;
@synthesize mCurPOI;
@synthesize mCentralPOI;
@synthesize loginID;
@synthesize bCall;
@synthesize selfPhone;
@synthesize deviceTokenId;
//@synthesize centralLat;
//@synthesize centralLon;
@synthesize userAccountState;
static App *mApp = nil;

static id mAction;
static UINavigationController *mNavController;

/*!
 @method init
 @abstract 初始化数据
 @discussion 初始化数据
 @param 无
 @result self
 */
- (id)init
{
    Resources *oRes = [Resources getInstance];
    //判断当前的语言环境
    NSString* strLanguage = [[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0];
    NSString* sLanguage;
    
    if([strLanguage isEqualToString:@"en"])
    {
        sLanguage = [[NSBundle mainBundle] pathForResource:@"language_english_usa" ofType:@"xml" inDirectory:nil];
        [oRes addTextFromFile:sLanguage];
    }
    else if([strLanguage isEqualToString:@"zh-Hans"])
    {
        sLanguage = [[NSBundle mainBundle] pathForResource:@"language_chinese_simplified" ofType:@"xml" inDirectory:nil];
        [oRes addTextFromFile:sLanguage];
    }
    else
    {
        sLanguage = [[NSBundle mainBundle] pathForResource:@"language_english_usa" ofType:@"xml" inDirectory:nil];
        [oRes addTextFromFile:sLanguage];
    }
    
    mTimer = nil;
    
    mAction = nil;
    mNavController = nil;
    mCherryDBControl = [CherryDBControl sharedCherryDBControl];
    return [super init];
}


/*!
 @method getInstance
 @abstract 实例化app，单例
 @discussion 实例化app，单例
 @param 无
 @result self
 */
+(id)getInstance
{
    if(mApp == nil)
    {
        mApp = [[App alloc]init];
    }
    
    return mApp;
}

- (void)dealloc
{
    //    [requestThread release];
    if (phoneCallWebView) {
        [phoneCallWebView release];
    }
    [mUserData release];
    [mfriendData release];
    if (loginID) {
        [loginID release];
    }
    if (bCall) {
        [bCall release];
    }
    [super dealloc];
}

/*!
 @method setWindow:(UIWindow*)window
 @abstract 设置窗体
 @discussion 设置窗体
 @param window 窗体
 @result 无
 */
- (void)setWindow:(UIWindow*)window
{
    mWindow = window;
}


/*!
 @method pushController:(BaseViewController*)oController animated:(BOOL)animated
 @abstract push一个界面
 @discussion push一个界面
 @param oController 界面
 @param animated 动画
 @result 无
 */
- (void)pushController:(BaseViewController*)oController animated:(BOOL)animated
{
    [self pushController:oController animated:animated backTitle:nil];
}



/*!
 @method pushController:(BaseViewController *)oController animated:(BOOL)animated backTitle:(NSString*)title
 @abstract push一个界面并传入其返回按钮的title
 @discussion push一个界面并传入其返回按钮的title
 @param oController 界面
 @param animated 动画
 @param title 返回按钮文字
 @result 无
 */
- (void)pushController:(BaseViewController *)oController animated:(BOOL)animated backTitle:(NSString*)title
{
    if(oController != nil)
    {
        UINavigationController *oNavigation = (UINavigationController*)mWindow.rootViewController;
        
        if(title != nil)
        {
            UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:title
                                                                           style:UIBarButtonItemStylePlain
                                                                          target:nil action:nil];
            oNavigation.topViewController.navigationItem.backBarButtonItem = backButton;
            [backButton release];
        }
        [self showBar];
        [oNavigation pushViewController:oController animated:animated];
    }
}

/*!
 @method pushController:(BaseViewController *)oController animated:(BOOL)animated backTitle:(NSString*)backtitle Title:(NSString *)title
 @abstract push一个界面并传入其返回按钮的title 以及导航栏的title
 @discussion push一个界面并传入其返回按钮的title 以及导航栏的title
 @param oController 界面
 @param animated 动画
 @param backTitle 返回按钮文字
 @param title 导航栏title
 @result 无
 */
- (void)pushController:(BaseViewController *)oController animated:(BOOL)animated backTitle:(NSString*)backtitle Title:(NSString *)title
{
    if(oController != nil)
    {
        UINavigationController *oNavigation = (UINavigationController*)mWindow.rootViewController;
        
        if(backtitle != nil)
        {
            UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:backtitle
                                                                           style:UIBarButtonItemStylePlain
                                                                          target:nil action:nil];
            oNavigation.topViewController.navigationItem.backBarButtonItem = backButton;
            oNavigation.topViewController.navigationItem.title = title;
            [backButton release];
        }
        [self showBar];
        [oNavigation pushViewController:oController animated:animated];
    }
}

/*!
 @method presentController:(BaseViewController *)oController animated:(BOOL)animated transitionStyle:(int)style
 @abstract 创建一个模态视图，并设置其过渡类型
 @discussion 创建一个模态视图，并设置其过渡类型
 @param oController 界面
 @param animated 是否显示动画
 @param style 动画类型
 @result 无
 */
- (void)presentController:(BaseViewController *)oController animated:(BOOL)animated transitionStyle:(int)style
{
    if(oController != nil)
    {
        oController.modalTransitionStyle = style;
        UINavigationController *newRoot = [[UINavigationController alloc] initWithRootViewController:oController];
        [newRoot.navigationBar setBarStyle:UIBarStyleBlack];
        //modify by wangqiwei for new API at 2014.6.15
        [[self getTopController] presentViewController:newRoot
                           animated:animated
                         completion:^(void){
                             NSLog(@"______>>>>发送成功");
                             
                         }];
       // [[self getTopController] presentModalViewController:newRoot animated:animated];
        [self setNav:newRoot];
        [newRoot release];
    }
}

/*!
 @method popController:(BOOL)animated
 @abstract 移除一个界面
 @discussion 移除一个界面
 @param animated 动画
 @result 无
 */
- (void)popController:(BOOL)animated
{
    UINavigationController *oNavigation = (UINavigationController*)mWindow.rootViewController;
    
    [oNavigation popViewControllerAnimated:animated];
}

/*!
 @method popToRootController:(BOOL)animated
 @abstract 移除界面至root界面
 @discussion 移除界面至root界面
 @param animated 动画
 @result 无
 */
- (void)popToRootController:(BOOL)animated
{
    UINavigationController *oNavigation = (UINavigationController*)mWindow.rootViewController;
    
    [oNavigation popToRootViewControllerAnimated:animated];
}


/*!
 @method setRootController:(BaseViewController*)oController
 @abstract 设置root界面
 @discussion 设置root界面
 @param oController 界面
 @result 无
 */
- (void)setRootController:(BaseViewController*)oController
{
    if(oController != nil)
    {
        BaseNavigationController *oNavigation = [[BaseNavigationController alloc]initWithRootViewController:oController];
        oNavigation.navigationBar.translucent = NO;
        oNavigation.navigationBar.barStyle = UIBarStyleBlack;
        mWindow.rootViewController = oNavigation;
        [oNavigation release];
    }
}

- (void)setGuideRootController:(GuideViewController*)oController
{
    if(oController != nil)
    {
      //  BaseNavigationController *oNavigation = [[BaseNavigationController alloc]initWithRootViewController:oController];
     //   oNavigation.navigationBar.translucent = NO;
      //  oNavigation.navigationBar.barStyle = UIBarStyleBlack;
       // oNavigation.navigationBarHidden = YES;
        mWindow.rootViewController = oController;
      //  [oNavigation release];
    }
}

/*!
 @method getTopController
 @abstract 获取最上方的窗口
 @discussion 获取最上方的窗口
 @param 无
 @result BaseViewController
 */
- (BaseViewController*)getTopController
{
    UINavigationController *oNavigation = (UINavigationController*)mWindow.rootViewController;
    
    if(oNavigation.topViewController.presentedViewController != nil)
    {
        UINavigationController *navi = (UINavigationController*)oNavigation.topViewController.presentedViewController;
        if (navi.topViewController.presentedViewController!=nil) {
            UINavigationController *temp = (UINavigationController*)navi.topViewController.presentedViewController;
            BaseViewController *sc = (BaseViewController*)temp.topViewController;
            return sc;
        }else{
            BaseViewController *subController = (BaseViewController*)navi.topViewController;
            return subController;
        }
        BaseViewController *subController =(BaseViewController*)navi.topViewController;
        return subController;
    }else{
        return (BaseViewController*)oNavigation.topViewController;
    }
    
}

/**
 *方法名称：- (BaseViewController*)getCurController
 *方法说明：获取当前窗口
 **/
- (BaseViewController*)getCurController
{
    UINavigationController *oNavigation = (UINavigationController*)mWindow.rootViewController;
    
    return (BaseViewController*)oNavigation.topViewController;
}

/*!
 @method getTopControllerID
 @abstract 获取最上方的窗口ID
 @discussion 获取最上方的窗口ID
 @param 无
 @result id
 */
- (int)getTopControllerID
{
    UINavigationController *oNavigation = (UINavigationController*)mWindow.rootViewController;
    
    if (oNavigation.topViewController.presentedViewController!=nil) {
        
        UINavigationController *navi = (UINavigationController*)oNavigation.topViewController.presentedViewController;
        if (navi.topViewController.presentedViewController!=nil) {
            UINavigationController *temp = (UINavigationController*)navi.topViewController.presentedViewController;
            BaseViewController *sc = (BaseViewController*)temp.topViewController;
            return sc.mID;
        }else{
            BaseViewController *subController = (BaseViewController*)navi.topViewController;
            return subController.mID;
        }
    }else{
        BaseViewController *controller = (BaseViewController*)oNavigation.topViewController;
        return controller.mID;
    }
}

/*!
 @method hideBar
 @abstract 隐藏导航栏
 @discussion 隐藏导航栏
 @param 无
 @result 无
 */
- (void)hideBar
{
    UINavigationController *oNavigation = (UINavigationController*)mWindow.rootViewController;
    
    oNavigation.navigationBarHidden = YES;
}

/**
 *方法名称：-(void)showBar
 *方法说明：显示导航栏
 **/
- (void)showBar
{
    UINavigationController *oNavigation = (UINavigationController*)mWindow.rootViewController;
    
    oNavigation.navigationBarHidden = NO;
}


/*!
 @method callPhone:(NSString*)tel
 @abstract 拨打电话
 @discussion 拨打电话
 @param tel 电话号码
 @result 无
 */
- (void)callPhone:(NSString*)tel
{
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",tel]];
    //    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",tel]];
    if (phoneCallWebView != nil) {
        [phoneCallWebView release];
        phoneCallWebView = nil;
        
    }
    phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
    [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
}

//- (void)sendSMS:(NSString *)bodyOfMessage recipientList:(NSArray *)recipients
//{
//    MFMessageComposeViewController *controller = [[[MFMessageComposeViewController alloc] init] autorelease];
//    if([MFMessageComposeViewController canSendText])
//    {
//        controller.body = bodyOfMessage;
//        controller.recipients = recipients;
//        controller.messageComposeDelegate = self;
//        [self presentModalViewController:controller animated:YES];
//    }
//}

/*!
 @method sendSMS:(NSString *)bodyOfMessage
 @abstract 发送短信
 @discussion 发送短信
 @param bodyOfMessage 短信内容
 @result 无
 */
- (void)sendSMS:(NSString *)bodyOfMessage
{
    MFMessageComposeViewController *controller = [[[MFMessageComposeViewController alloc] init] autorelease];
    if([MFMessageComposeViewController canSendText])
    {
        controller.body = bodyOfMessage;
        controller.recipients = nil;
        controller.messageComposeDelegate = self;
        //modify by wangqiwei for new API at 2014.6.15
        [[self getTopController] presentViewController:controller
                                              animated:YES
                                            completion:^(void){
                                                NSLog(@"______>>>>发送成功");
                                                
                                            }];
        
    }
}

/**
 *方法名称：-(void)messageComposeViewController:
 *方法说明：处理发送完的响应结果
 **/
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    //modify by wangqiwei for new API at 2014.6.15
    [[self getTopController] dismissViewControllerAnimated:YES
                                                completion:^(void){
                                                    NSLog(@"______>>>>视图结束");
                                                }];
    
    if (result == MessageComposeResultCancelled)
        NSLog(@"Message cancelled");
    else if (result == MessageComposeResultSent)
        NSLog(@"Message sent");
    else
        NSLog(@"Message failed");
}


/*!
 @method openBrowser:(NSString*)url
 @abstract 打开网页
 @discussion 打开网页
 @param url 网址
 @result 无
 */
- (void)openBrowser:(NSString*)url
{
    if(url)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        //         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunesconnect.apple.com"]];
    }
}

/*!
 @method clearUser
 @abstract 清除用户信息
 @discussion 清除用户信息
 @param 无
 @result 无
 */
- (void)clearUser
{
    
}




/*!
 @method getSystemVer
 @abstract 获取版本信息
 @discussion 获取版本信息
 @param 无
 @result version
 */
+ (float)getSystemVer
{
    return [[[UIDevice currentDevice]systemVersion]floatValue];
}


/*!
 @method getTimeSince1970
 @abstract 获取本地时间，增量格式
 @discussion 获取本地时间，增量格式
 @param 无
 @result time
 */
+(NSString *)getTimeSince1970
{
    NSDate *date = [NSDate date];
    //    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    //    NSInteger interval = [zone secondsFromGMTForDate: date];
    //    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    NSTimeInterval interv = [date timeIntervalSince1970];
    long long dTime = [[NSNumber numberWithDouble:interv] longLongValue];
    NSLog(@"%llu",dTime);
    return [NSString stringWithFormat:@"%llu",dTime];
}

+(NSString *)getTimeSince1970_1000
{
    NSDate *date = [NSDate date];
    //    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    //    NSInteger interval = [zone secondsFromGMTForDate: date];
    //    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    NSTimeInterval interv = [date timeIntervalSince1970];
    long long dTime = [[NSNumber numberWithDouble:interv] longLongValue]*1000;
    NSLog(@"%llu",dTime);
    return [NSString stringWithFormat:@"%llu",dTime];
}

/*!
 @method getSystemTime
 @abstract 获取本地时间
 @discussion 获取本地时间
 @param 无
 @result time
 */
+(NSString *)getSystemTime
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSDate *date = [NSDate date];
    //    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    //    NSInteger interval = [zone secondsFromGMTForDate: date];
    //    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *timeStr= [dateFormatter stringFromDate:date];
    //    NSLog(@"enddate=%@",localeDate);
    [dateFormatter release];
    return timeStr;
}

+(NSString *)getSystemLastTime
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * reportDate = [format stringFromDate:[NSDate date]];
    NSDate *date = [format dateFromString:reportDate];
    NSDate *newDate = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([date timeIntervalSinceReferenceDate] - 24*3600)];
    reportDate = [format stringFromDate:newDate];
    
    return reportDate;
}

/*!
 @method getDateWithTimeSince1970:(NSString *)time
 @abstract 将Since1970时间格式转换成yyyy-MM-dd HH:mm:ss
 @discussion 将Since1970时间格式转换成yyyy-MM-dd HH:mm:ss
 @param time 增量时间
 @result time yyyy-MM-dd HH:mm:ss格式时间
 */
+(NSString *)getDateWithTimeSince1970:(NSString *)time
{
    if (time != nil && ![time isEqualToString:@""]) {
        NSDate *date = nil;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        date = [NSDate dateWithTimeIntervalSince1970:[time doubleValue]/1000];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *timeStr= [dateFormatter stringFromDate:date];
        [dateFormatter release];
        return timeStr;
    }
    else
    {
        return @"";
    }
    
}


/*!
 @method convertDateToLocalTime:(NSDate *)forDate
 @abstract 将北京时间转换成当前系统类型的时间
 @discussion 将北京时间转换成当前系统类型的时间
 @param forDate 北京时间
 @result date 本地时间
 */
+(NSDate *)convertDateToLocalTime:(NSDate *)forDate
{
    NSTimeZone *nowTimeZone = [NSTimeZone localTimeZone];
    int timeOffset = [nowTimeZone secondsFromGMTForDate:forDate];
    NSDate *newDate = [forDate dateByAddingTimeInterval:timeOffset];
    return newDate;
}


/*!
 @method convertDateToGMT:(NSDate *)forDate
 @abstract 将当前时区的时间转换成北京时区的时间
 @discussion 将当前时区的时间转换成北京时区的时间
 @param forDate 本地时间
 @result date 北京时间
 */
+(NSDate *)convertDateToGMT:(NSDate *)forDate
{
    NSTimeZone *nowTimeZone = [NSTimeZone localTimeZone];
    int timeOffset = [nowTimeZone secondsFromGMTForDate:forDate];
    NSDate *newDate = [forDate dateByAddingTimeInterval:-timeOffset];
    return newDate;
}

/*!
 @method getFirstLetter:(NSString *)keyWord
 @abstract 获取首字母
 @discussion 获取首字母
 @param keyWord 文字
 @result char 首字母
 */
+(NSString *)getFirstLetter:(NSString *)keyWord
{
    NSString *sectionName;
    NSString *firstWord;
    firstWord = [keyWord substringToIndex:1];
    NSLog(@"%@",firstWord);
    
    if ([firstWord isEqualToString:@"曾"]) {
        sectionName = @"Z";
    }
    else if([firstWord isEqualToString:@"解"])
    {
        sectionName = @"X";
    }
    else if([firstWord isEqualToString:@"仇"])
    {
        sectionName = @"Q";
    }
    else if([firstWord isEqualToString:@"朴"])
    {
        sectionName = @"P";
    }
    else if([firstWord isEqualToString:@"查"])
    {
        sectionName = @"Z";
    }
    else if([firstWord isEqualToString:@"能"])
    {
        sectionName = @"N";
    }
    else if([firstWord isEqualToString:@"乐"])
    {
        sectionName = @"Y";
    }
    else if([firstWord isEqualToString:@"单"])
    {
        sectionName = @"S";
    }
    else
    {
        sectionName = [[NSString stringWithFormat:@"%c",pinyinFirstLetter([keyWord characterAtIndex:0])] uppercaseString];
    }
    NSLog(@"%@ 的首字母=%@",keyWord,sectionName);
    return sectionName;
}


/*!
 @method getPinyin:(NSString *)keyWord
 @abstract 获取拼音
 @discussion 获取拼音
 @param keyWord 文字
 @result NSString 拼音
 */
+(NSString *)getPinyin:(NSString *)keyWord
{
    
    if ([keyWord length]) {
        NSMutableString *ms = [[NSMutableString alloc] initWithString:keyWord];
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO)) {
            NSLog(@"pinyin: %@", ms);
        }
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO)) {
            NSLog(@"pinyin: %@", ms);
        }
        return [ms copy];
    }
    else
    {
        return @"";
    }
//    NSString *sectionName;
//    NSString *firstWord;
//    firstWord = [keyWord substringToIndex:1];
//    NSLog(@"%@",firstWord);
//    
//    if ([firstWord isEqualToString:@"曾"]) {
//        sectionName = @"zeng";
//    }
//    else if([firstWord isEqualToString:@"解"])
//    {
//        sectionName = @"xie";
//    }
//    else if([firstWord isEqualToString:@"仇"])
//    {
//        sectionName = @"qiu";
//    }
//    else if([firstWord isEqualToString:@"朴"])
//    {
//        sectionName = @"pu";
//    }
//    else if([firstWord isEqualToString:@"查"])
//    {
//        sectionName = @"zha";
//    }
//    else if([firstWord isEqualToString:@"能"])
//    {
//        sectionName = @"neng";
//    }
//    else if([firstWord isEqualToString:@"乐"])
//    {
//        sectionName = @"yue";
//    }
//    else if([firstWord isEqualToString:@"单"])
//    {
//        sectionName = @"shan";
//    }
//    else
//    {
//        sectionName = [[NSString stringWithFormat:@"%c",pinyinFirstLetter([keyWord characterAtIndex:0])] uppercaseString];
//    }
//    NSLog(@"%@ 的首字母=%@",keyWord,sectionName);
//    return sectionName;
}

/*!
 @method isNumText:(NSString *)str
 @abstract 判断一组字符是否为纯数字
 @discussion 判断一组字符是否为纯数字
 @param str 文字
 @result BOOL
 */
+(BOOL)isNumText:(NSString *)str
{
    NSString * regex        = @"[0-9]+";
    NSPredicate * pred      = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch            = [pred evaluateWithObject:str];
    if (isMatch) {
        return YES;
    }else{
        return NO;
    }
    
}

/*!
 @method isNSNull:(NSString *)str
 @abstract 判断字符串是否为nsnull
 @discussion 判断字符串是否为nsnull
 @param str 字符串
 @result BOOL
 */
+(BOOL)isNSNull:(NSString *)str
{
    if ([NSStringFromClass([str class]) isEqualToString:@"NSNull"]) {
        return YES;
    }
    else
    {
        return NO;
    }
}


//-(NSAttributedString*) getAttributedString:(NSAttributedString*) attributedString isUnderline:(BOOL) isUnderline
//{
//    NSNumber *valuUnderline = [NSNumber numberWithBool:isUnderline];
//    NSRange rangeAll = NSMakeRange(0, attributedString.string.length+1);
//    NSMutableAttributedString *as = [attributedString mutableCopy];
//    [as beginEditing];
//    [as addAttribute:NSUnderlineStyleAttributeName value:valuUnderline range:rangeAll];
//    [as endEditing];
//    return as;
//}

#pragma make -
/*!
 @method setSheet:(id) action
 @abstract 设置action
 @discussion 设置action
 @param action
 @result 无
 */
- (void) setSheet:(id) action
{
    mAction = action;
}

/*!
 @method setNav:(id) nav
 @abstract 设置nav
 @discussion 设置nav
 @param nav
 @result 无
 */
- (void) setNav:(id)nav
{
    [mNavController release];
    mNavController =  [nav retain];
}

/*!
 @method getNav
 @abstract 获取Nav
 @discussion 获取Nav
 @param 无
 @result nav
 */
- (UINavigationController *) getNav
{
    return mNavController;
}

/*!
 @method hideSheet
 @abstract 隐藏Sheet
 @discussion 隐藏Sheet
 @param 无
 @result 无
 */
- (void) hideSheet
{
    if (mAction) {
        
        @try {
            [mAction retain];
            [mAction dismissWithClickedButtonIndex:[mAction cancelButtonIndex] animated:YES];
        }
        @catch (NSException *exception) {
            NSLog(@"hide action error");
        }
        @finally {
            
        }
        
    }
    
    
    if(mNavController)
    {
        @try {
            [mNavController retain];
            //modify by wangqiwei for new API at 2014.6.15
            [mNavController dismissViewControllerAnimated:YES
                                     completion:^(void){
                                         NSLog(@"______>>>>视图结束");
                                     }];
            //[mNavController dismissModalViewControllerAnimated:YES];
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
    }
    else
    {
        mNavController = nil;
    }
}

/*!
 @method showSheet
 @abstract 显示Sheet
 @discussion 显示Sheet
 @param 无
 @result 无
 */
- (void) showSheet
{
    if (mAction) {
        @try {
            if([[[mAction class] description] isEqualToString:@"UIAlertView"])
            {
                [mAction show];
            }
            else
            {
                [mAction showInView:[[App getInstance] getTopController].view];
            }
            [mAction release];
        }
        @catch (NSException *exception) {
            NSLog(@"show action error");
        }
        @finally {
            
        }
        
    }
    
    if (mNavController) {
        @try {
          //  [[self getTopController] presentModalViewController:mNavController animated:YES];
            //modify by wangqiwei for new API at 2014.6.15
            [[self getTopController] presentViewController:mNavController
                               animated:YES
                             completion:^(void){
                                 NSLog(@"______>>>>发送成功");
                                 
                             }];
            [mNavController release];
        }
        @catch (NSException *exception) {
            //            NSLog(@"%@", [exception account]);
        }
        @finally {
            
        }
        
    }
}

#pragma mark checknodata
- (void)checkNoData:(int)checktype
{
    //    switch (checktype) {
    //        case CHECK_NODATA_ALL:
    //            <#statements#>
    //            break;
    //        case CHECK_NODATA_SERVICE_DISABLE:
    //            break;
    //        case CHECK_NODATA_DATA_CONNECTION_DISABLE:
    //            break;
    //        case CHEc
    //        default:
    //            break;
    //    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self setSheet:nil];
}

#pragma mark - getdevice
/*!
 @method deviceString
 @abstract 获取当前设备信息
 @discussion 获取当前设备信息
 @param 无
 @result str
 */
+ (NSString*)deviceString
{
    // 需要
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([deviceString isEqualToString:@"iPhone1,1"])    return iPhone_1G;
    if ([deviceString isEqualToString:@"iPhone1,2"])    return iPhone_3G;
    if ([deviceString isEqualToString:@"iPhone2,1"])    return iPhone_3GS;
    if ([deviceString isEqualToString:@"iPhone3,1"])    return iPhone_4;
    if ([deviceString isEqualToString:@"iPhone4,1"])    return iPhone_4S;
    if ([deviceString isEqualToString:@"iPhone5,2"])    return iPhone_5;
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    NSLog(@"NOTE: Unknown device type: %@", deviceString);
    return deviceString;
}

/*!
 @method ios7ViewLocation:(UIViewController *)sender
 @abstract 设置ios7下界面显示位置
 @discussion 设置ios7下界面显示位置
 @param sender 界面
 @result 无
 */
+(void)ios7ViewLocation:(UIViewController *)sender
{
    sender.edgesForExtendedLayout = UIRectEdgeNone;
}

/*!
 @method getVersion
 @abstract 获取当前版本信息
 @discussion 获取当前版本信息
 @param 无
 @result ver
 */
+ (double)getVersion
{
    // 需要
    double version = [[UIDevice currentDevice].systemVersion doubleValue];//判定系统版本。
    if (version>=8.0f) {
        return IOS_VER_8;
    }
    else if (version>=7.0f) {
        return IOS_VER_7;
    }
    else if(version>=6.0f)
    {
        return IOS_VER_6;
    }
    else
    {
        return IOS_VER_5;
    }
    
    
}

static NSString *uuidString;

#pragma mark - createUUID
/*!
 @method createUUID
 @abstract 创建uuid
 @discussion 创建uuid
 @param 无
 @result uuid
 */
+(NSString *)createUUID
{
    CFUUIDRef uuidObj = CFUUIDCreate(nil);
    uuidString = (NSString *)CFUUIDCreateString(nil, uuidObj);
    //    NSString *uuidString = (NSString *)CFUUIDCreateString(nil, uuidObj);
    CFRelease(uuidObj); // uuidString就是唯一得了
    return uuidString;
}

#pragma mark - getScreenSize
/*!
 @method getScreenSize
 @abstract 获取屏幕分辨率
 @discussion 获取屏幕分辨率
 @param 无
 @result size 屏幕分辨率
 */
+(int)getScreenSize
{
    //    得到当前屏幕的尺寸：
    CGRect rect_screen = [[UIScreen mainScreen]bounds];
    CGSize size_screen = rect_screen.size;
    if (size_screen.width==320&&size_screen.height==480) {
        return SCREEN_SIZE_960_640;
    }
    else if(size_screen.width==320&&size_screen.height==568)
    {
        return SCREEN_SIZE_1136_640;
    }
    else
    {
        return SCREEN_SIZE_1136_640;
    }
    //    获得scale：
    //    CGFloat scale_screen = [UIScreen mainScreen].scale;
}

#pragma mark 下边为业务方法
#pragma mark userdata
/*!
 @method initUserData
 @abstract 初始化用户信息
 @discussion 初始化用户信息
 @param 无
 @result 无
 */
-(void)initUserData
{
    mUserData=[[UserData alloc] initWithName:@"" account:@"" password:@"" type:USER_LOGIN_OTHER carVin:@"" safe_pwd:@"" flag:0 lon:@"" lat:@"" lastreqtime:@"" userID:@""];
}

/*!
 @method logout
 @abstract 登出，重置账号信息
 @discussion 登出，重置账号信息
 @param 无
 @result 无
 */
-(void)logout
{
    if (mUserData != nil) {
        [mUserData release];
    }
    [self initUserData];
    loginID = @"";
    bCall = @"";
    selfPhone = @"";
}

/*!
 @method updateIsFirstLogin
 @abstract 更新是否同步车友
 @discussion 更新是否同步车友
 @param 无
 @result 无
 */
-(void)updateIsFirstLogin
{
    [mUserData updateIsFirstLogin:mUserData.mUserID];
}

/*!
 @method getIsFirstLogin
 @abstract 获取是否为首次进入车友
 @discussion 获取是否为首次进入车友
 @param 无
 @result 是否首次进入车友标记
 */
-(int)getIsFirstLogin
{
    return mUserData.mIsFirstLogin;
}

/*!
 @method login:(NSString *)userKeyID account:(NSString*)account password:(NSString*)password type:(int)type safe_pwd:(NSString *)safe_pwd flag:(int)flag lon:(NSString *)lon lat:(NSString *)lat lastreqtime:(NSString *)lastreqtime vin:(NSString *)vin userID:(NSString *)userID
 @abstract 登录后将登录信息存储到本地数据库
 @discussion 登录后将登录信息存储到本地数据库
 @param userData
 @result 无
 */
- (void)login:(NSString *)userKeyID
      account:(NSString*)account
     password:(NSString*)password
         type:(int)type
     safe_pwd:(NSString *)safe_pwd
         flag:(int)flag
          lon:(NSString *)lon
          lat:(NSString *)lat
  lastreqtime:(NSString *)lastreqtime
          vin:(NSString *)vin
       userID:(NSString *)userID
{
    [mUserData updateUserData:userKeyID account:account password:password type:type safe_pwd:safe_pwd flag:flag lon:lon lat:lat lastreqtime:lastreqtime vin:vin userID:userID];
    NSLog(@"muserdata.userkeyid=%@",mUserData.mUserID);
    [mUserData getUserLastReqTime:mUserData.mUserID];
}

/*!
 @method getPassword:(NSString *)userID
 @abstract 获取密码
 @discussion 获取密码
 @param userID 用户id
 @result pwd 密码
 */
- (NSString *)getPassword:(NSString *)userID
{
    NSString *password;
    password=[mUserData getUserPassword:userID];
    NSLog(@"%@",password);
    return password;
}

/*!
 @method updateLocation:(NSString *)lon lat:(NSString *)lat
 @abstract 更新位置信息
 @discussion 更新位置信息
 @param 无
 @result 无
 */
-(void)updateLocation:(NSString *)lon
                  lat:(NSString *)lat
{
    [mUserData updateLocation:mUserData.mUserID lon:lon lat:lat];
}

/*!
 @method updateLastReqTime:(NSString *)userID lastreqtime:(NSString *)lastreqtime
 @abstract 更新用户的最后请求时间
 @discussion 更新用户的最后请求时间
 @param 无
 @result 无
 */
-(void)updateLastReqTime:(NSString *)userID
             lastreqtime:(NSString *)lastreqtime
{
    [mUserData updateLastReqTime:mUserData.mUserID lastreqtime:lastreqtime];
}

/*!
 @method updateVinWithUserID:(NSString *)userID vin:(NSString *)vin
 @abstract 更新用户选择车辆的vin
 @discussion 更新用户选择车辆的vin
 @param 无
 @result 无
 */
-(void)updateVinWithUserID:(NSString *)userID
                        vin:(NSString *)vin
{
    [mUserData updateVinWithUserID:mUserData.mUserID vin:vin];
}

/*!
 @method getUserData
 @abstract 获取账户数据
 @discussion 获取账户数据
 @param 无
 @result UserData 账户数据
 */
-(UserData *)getUserData
{
    return mUserData;
}

/*!
 @method initCarData
 @abstract 初始化车辆信息
 @discussion 初始化车辆信息
 @param 无
 @result 无
 */
- (void)initCarData
{
    mCarData=[[CarData alloc]init];
    [mCarData initCarDatabase];
}



/*!
 @method updateCarData:(NSString*)keyID carID:(NSString*)carID vin:(NSString*)vin type:(NSString*)type name:(NSString*)name carRegisCode:(NSString*)carRegisCode carNumber:(NSString*)carNumber motorCode:(NSString*)motorCode userID:(NSString*)userID sim:(NSString*)sim lon:(NSString *)lon lat:(NSString *)lat lastRpTime:(NSString *)lastRpTime
 @abstract 更新或添加车辆信息
 @discussion 更新或添加车辆信息
 @param carData
 @result 无
 */
- (void)updateCarData:(NSString*)keyID
                carID:(NSString*)carID
                  vin:(NSString*)vin
                 type:(NSString*)type
                 name:(NSString*)name
         carRegisCode:(NSString*)carRegisCode
            carNumber:(NSString*)carNumber
            motorCode:(NSString*)motorCode
               userID:(NSString*)userID
                  sim:(NSString*)sim
                  lon:(NSString *)lon
                  lat:(NSString *)lat
           lastRpTime:(NSString *)lastRpTime
              service:(NSString *)service

{
    [mCarData updateCarData:keyID carID:carID vin:vin type:type name:name carRegisCode:carRegisCode carNumber:carNumber motorCode:motorCode userID:userID sim:sim lon:lon lat:lat lastRpTime:lastRpTime service:service];
}


/*!
 @method updateCarLocation:(NSString *)lon lat:(NSString *)lat lastRpTime:(NSString *)lastRpTime
 @abstract 更新车辆位置和时间
 @discussion 更新车辆位置和时间
 @param lon 经度
 @param lat 纬度
 @param lastRpTime 车辆最后位置
 @result 无
 */
-(void)updateCarLocation:(NSString *)lon
                     lat:(NSString *)lat
              lastRpTime:(NSString *)lastRpTime
{
    [mCarData updateCarLocation:mUserData.mUserID vin:mUserData.mCarVin lon:lon lat:lat lastRpTime:lastRpTime];
}

/**
 *方法名称：-(CarData *)getCarData
 *方法说明：返回mCarData
 **/
-(CarData *)getCarData
{
    return mCarData;
}

/*!
 @method loadCarData
 @abstract 加载车辆信息
 @discussion 加载车辆信息
 @param 无
 @result 无
 */
- (void)loadCarData
{
    [mCarData loadCarData:mUserData.mUserID vin:mUserData.mCarVin];
}

/*!
 @method existCarDataWithCarVin:(NSString *)carVin
 @abstract 根据vin判断车辆是否存在
 @discussion 根据vin判断车辆是否存在
 @param carVin 车架号
 @result bool
 */
- (BOOL)existCarDataWithCarVin:(NSString *)carVin
{
    return [mCarData carExistWithUserID:mUserData.mUserID vin:carVin];
}


/*!
 @method deleteCarWithUserID:(NSString *)userID
 @abstract 删除当前账户下的车辆信息
 @discussion 删除当前账户下的车辆信息
 @param userID 用户id
 @result 无
 */
-(void)deleteCarWithUserID:(NSString *)userID
{
    [mCarData deleteCarWithUserID:userID];
}

/*!
 @method deleteCarWithUserID:(NSString *)userID
 @abstract 获取当前账户下的车辆信息
 @discussion 获取当前账户下的车辆信息
 @param userID 用户id
 @result carlist 车辆列表
 */
- (NSMutableArray*)loadCarDataWithUserID:(NSString *)userID
{
    return [mCarData loadCarDataWithUserID:userID];
}

//friendData
#pragma mark friendData
/*!
 @method initmfriendData
 @abstract 初始化mfriendData，及创建表
 @discussion 初始化mfriendData，及创建表
 @param 无
 @result 无
 */
- (void)initmfriendData
{
    mfriendData=[[FriendsData alloc]init];
    [mfriendData initFriendDatabase];
}


/*!
 @method loadFriendUserIDWithPhoneList:(NSArray *)phoneList
 @abstract 通过手机号list获取车友userid
 @discussion 通过手机号list获取车友userid
 @param phoneList 电话列表
 @result NSMutableDictionary 电话为key userid 为value
 */
-(NSMutableDictionary *)loadFriendUserIDWithPhoneList:(NSArray *)phoneList
{
    return [mfriendData loadFriendUserIDWithPhoneList:phoneList userID:mUserData.mUserID];
}

/*!
 @method loadFriendNameWithFriendUserID:(NSMutableArray *)friendUserIDList
 @abstract 通过车友用户id获取车友名字
 @discussion 通过车友用户id获取车友名字
 @param friendUserIDList 车友用户idList
 @result NSMutableDictionary KEY UserIDList value friendName
 */
-(NSMutableDictionary *)loadFriendNameWithFriendUserID:(NSMutableArray *)friendUserIDList
{
    return [mfriendData loadFriendNameWithFriendUserID:friendUserIDList userID:mUserData.mUserID];
}

/*!
 @method friendExistWhitPhone:
 @abstract 查找车友表中是否存在所属用户为fUserID电话为phone的车友
 @discussion 查找车友表中是否存在所属用户为fUserID电话为phone的车友
 @param fUserID 所属用户id
 @param phone 电话
 @result bool
 */
- (BOOL)friendExistWhitPhone:(NSString *)phone
{
    return [mfriendData friendExistWhitUserID:mUserData.mUserID phone:phone];
}

/*!
 @method initBlackData
 @abstract 初始化黑名单，包括建表
 @discussion 初始化黑名单，包括建表
 @param 无
 @result 无
 */
- (void)initBlackData
{
    mBlackData=[[BlackData alloc]init];
    [mBlackData initBlackDatabase];
}

/*!
 @method updateBlackDataWithKeyID:(NSString*)KeyID ID:(NSString*)ID name:(NSString*)name mobile:(NSString *)mobile lastUpdate:(NSString *)lastUpdate
 createTime:(NSString *)createTime pinyin:(NSString *)pinyin
 @abstract 添加或修改黑名单
 @discussion 添加或修改黑名单
 @param BlackData 黑名单数据
 @result 无
 */
- (void)updateBlackDataWithKeyID:(NSString*)KeyID
                              ID:(NSString*)ID
                            name:(NSString*)name
                          mobile:(NSString *)mobile
                      lastUpdate:(NSString *)lastUpdate
                      createTime:(NSString *)createTime
                          pinyin:(NSString *)pinyin
{
    [mBlackData updateBlackDataWithKeyID:KeyID ID:ID name:name mobile:mobile lastUpdate:lastUpdate createTime:createTime userKeyID:mUserData.mUserID pinyin:pinyin];
}

/*!
 @method deleteBlackDataWithMobile:(NSString*)mobile
 @abstract 根据电话和用户id删除黑名单
 @discussion 根据电话和用户id删除黑名单
 @param mobile 电话
 @result 无
 */
- (void)deleteBlackDataWithMobile:(NSString*)mobile
{
    [mBlackData deleteBlackDataWithMobile:mobile userKeyID:mUserData.mUserID];
}

/*!
 @method deleteAllBlackData
 @abstract 删除当前用户下所有黑名单
 @discussion 删除当前用户下所有黑名单
 @param 无
 @result 无
 */
- (void)deleteAllBlackData
{
    [mBlackData deleteAllBlackDataWithUserKeyID:mUserData.mUserID];
}

/*!
 @method addBlackDataWithSqls:(NSMutableArray *)sql
 @abstract 通过sql语句添加黑名单
 @discussion 通过sql语句添加黑名单
 @param sql sqllist
 @result 无
 */
- (void)addBlackDataWithSqls:(NSMutableArray *)sql
{
    [mBlackData addBlackDataWithSqls:sql];
}

/*!
 @method deleteBlackDataWithIDs:(NSArray *)IDs
 @abstract 根据ids删除黑名单
 @discussion 根据ids删除黑名单
 @param IDs idlist
 @result 无
 */
- (void)deleteBlackDataWithIDs:(NSArray *)IDs
{
    [mBlackData deleteBlackDataWithIDs:IDs userKeyID:mUserData.mUserID];
}

/*!
 @method loadBlackData
 @abstract 加载黑名单列表
 @discussion 加载黑名单列表
 @param 无
 @result balckList 黑名单列表
 */
- (NSMutableArray*)loadBlackData
{
    return [mBlackData loadBlackDataWithUserKeyID:mUserData.mUserID];
}

/*!
 @method blackExist:
 @abstract 根据mobile，userKeyID判断黑名单是否在数据库表中存在
 @discussion 根据mobile，userKeyID判断黑名单是否在数据库表中存在
 @param userKeyID　黑名单所属用户ｉｄ
 @param database　数据库
 @param mobile　电话号码
 @result BOOL
 */
- (BOOL)blackExist:(NSString *)mobile
{
    return [mBlackData blackExist:mUserData.mUserID mobile:mobile];
}

/*!
 @method updateFriendData:(NSString*)fKeyID fid:(NSString *)fID fname:(NSString*)fName fphone:(NSString*)fPhone flon:(NSString *)flon flat:(NSString *)flat fLastRqTime:(NSString *)fLastRqTime fLastUpdate:(NSString*)fLastUpdate sendLocationRqTime:(NSString*)sendLocationRqTime createTime:(NSString *)createTime friendUserID:(NSString *)friendUserID poiName:(NSString *)poiName poiAddress:(NSString *)poiAddress pinyin:(NSString*)pinyin
 @abstract 更新或添加车友信息
 @discussion 更新或添加车友信息
 @param friendData 车友信息
 @result 无
 */
- (void)updateFriendData:(NSString*)fKeyID
                     fid:(NSString *)fID
                   fname:(NSString*)fName
                  fphone:(NSString*)fPhone
                    flon:(NSString *)flon
                    flat:(NSString *)flat
             fLastRqTime:(NSString *)fLastRqTime
             fLastUpdate:(NSString*)fLastUpdate
      sendLocationRqTime:(NSString*)sendLocationRqTime
              createTime:(NSString *)createTime
            friendUserID:(NSString *)friendUserID
                 poiName:(NSString *)poiName
              poiAddress:(NSString *)poiAddress
                  pinyin:(NSString*)pinyin

{
    [mfriendData updateFriendData:fKeyID fid:fID fname:fName fphone:fPhone fUserID:mUserData.mUserID flon:flon flat:flat fLastRqTime:fLastRqTime fLastUpdate:fLastUpdate sendLocationRqTime:sendLocationRqTime createTime:createTime friendUserID:friendUserID poiName:poiName poiAddress:poiAddress pinyin:pinyin];
}

/*!
 @method deleteFriendWithPhone:(NSString *)phone
 @abstract 根据电话号码和用户id删除车友信息
 @discussion 根据电话号码和用户id删除车友信息
 @param phone 电话
 @result 无
 */
-(void)deleteFriendWithPhone:(NSString *)phone
{
    [mfriendData deleteFriendWithPhone:phone fUserID:mUserData.mUserID];
}


 /*!
 @method addFriendDataWithSqls:(NSMutableArray *)sql
 @abstract 通过sql添加车友
 @discussion 通过sql添加车友
 @param sql sqllist
 @result 无
 */
- (void)addFriendDataWithSqls:(NSMutableArray *)sql
{
    [mfriendData addFriendDataWithSqls:sql];
}


/*!
 @method getFriendName:(NSString *)fID
 @abstract 通过车友id，获取车友名字
 @discussion 通过车友id，获取车友名字
 @param fID 车友id
 @result name
 */
- (NSString *)getFriendName:(NSString *)fID
{
    return [mfriendData getFriendName:fID fUserID:mUserData.mUserID];
}

/*!
 @method getFriendNameWithPhone:(NSString *)phone
 @abstract 通过车友电话，获取车友名字
 @discussion 通过车友电话，获取车友名字
 @param phone 车友电话
 @result name
 */
- (NSString *)getFriendNameWithPhone:(NSString *)phone
{
     return [mfriendData getFriendNameWithPhone:phone fUserID:mUserData.mUserID];
}


/*!
 @method updateFriendLocation:(NSString *)fID flon:(NSString *)flon flat:(NSString *)flat lastRqTime:(NSString *)lastRqTime  poiName:(NSString *)poiName  poiAddress:(NSString *)poiAddress
 @abstract 通过车友id，更新车友位置
 @discussion 通过车友id，更新车友位置
 @param fID 车友id
 @param flon 经度
 @param flat 纬度
 @param lastRqTime 最后时间
 @result 无
 */
- (void)updateFriendLocation:(NSString *)fID
                        flon:(NSString *)flon
                        flat:(NSString *)flat
                  lastRqTime:(NSString *)lastRqTime
                     poiName:(NSString *)poiName
                  poiAddress:(NSString *)poiAddress
{
    [mfriendData updateFriendLocation:fID flon:flon flat:flat fUserID:mUserData.mUserID lastRqTime:lastRqTime poiName:poiName poiAddress:poiAddress];
}



/*!
 @method updateFriendDataWithID:(NSString *)fID mobile:(NSString *)mobile name:(NSString *)name createTime:(NSString *)createTime lastUpdate:(NSString *)lastUpdate pinyin:(NSString *)pinyin
 @abstract 更新车友名字
 @discussion 更新车友名字
 @param fID 车友id
 @param fName 名字
 @result 无
 */
- (void)updateFriendDataWithID:(NSString *)fID
                        mobile:(NSString *)mobile
                          name:(NSString *)name
                    createTime:(NSString *)createTime
                    lastUpdate:(NSString *)lastUpdate
                        pinyin:(NSString *)pinyin
{
    [mfriendData updateFriendDataWithID:fID mobile:mobile name:name createTime:createTime lastUpdate:lastUpdate fUserID:mUserData.mUserID pinyin:pinyin];
}


/*!
 @method getFriendData:(NSString *)fID
 @abstract 获取车友信息
 @discussion 获取车友信息
 @param fID 车友id
 @result FriendData 车友信息
 */
- (FriendsData *)getFriendData:(NSString *)fID
{
    return [mfriendData getFriendData:fID fUserID:mUserData.mUserID];
}

/*!
 @method getRqTimeWithFID:(NSString *)fID
 @abstract 获取请求时间
 @discussion 获取请求时间
 @param fID 车友id
 @result time
 */
- (NSString *)getRqTimeWithFID:(NSString *)fID
{
    return [mfriendData getRqTimeWithFID:fID fUserID:mUserData.mUserID];
}

/*!
 @method updateFriendRqTimeWithFID:(NSString *)fID rqTime:(NSString *)rqTime
 @abstract 修改请求时间
 @discussion 修改请求时间
 @param fID 车友id
 @param rqTime 请求时间
 @result 无
 */
- (void)updateFriendRqTimeWithFID:(NSString *)fID
                           rqTime:(NSString *)rqTime
{
    [mfriendData updateFriendRqTimeWithFID:fID rqTime:rqTime  fUserID:mUserData.mUserID];
}


/*!
 @method deleteFriendData:(NSString *)fID
 @abstract 删除车友信息
 @discussion 删除车友信息
 @param fID 车友id
 @result 无
 */
- (void)deleteFriendData:(NSString *)fID
{
    [mfriendData deleteFriendData:fID fUserID:mUserData.mUserID];
}

/*!
 @method deleteMutiFriendsData:(NSArray *)fIDs
 @abstract 删除多条车友信息
 @discussion 删除多条车友信息
 @param fIDs 车友id列表
 @result 无
 */
- (void)deleteMutiFriendsData:(NSArray *)fIDs
{
    [mfriendData deleteMutiFriendsData:fIDs fUserID:mUserData.mUserID];
}

/**
 *方法名称：- (void)deleteDemo
 *方法说明：删除该用户的所有车友
 **/
- (void)deleteDemo
{
    [mUserData deleteDemo];
}
/*!
 @method initCarSetPara
 @abstract 初始化远程控制的设置初始参数
 @discussion 初始化远程控制的设置初始参数
 @param 无
 @result 无
 */
- (void)initCarSetPara
{
    NSUserDefaults *setData = [NSUserDefaults standardUserDefaults];
    NSDictionary *setParaDic = [setData objectForKey:[mApp getCarData].mVin];
    
    int engineDuration =[[setParaDic objectForKey:@"engineTimeKey"]intValue];
    int iTemperature = [[setParaDic objectForKey:@"temperatureKey"]intValue];
    int coolAirDuration = [[setParaDic objectForKey:@"coolAirTimeKey"]intValue];
    if (engineDuration == 0 && iTemperature == 0 && coolAirDuration == 0)
    {
        NSMutableDictionary *setparaDic = [NSMutableDictionary dictionary];
        [setparaDic setObject:@"25" forKey:@"temperatureKey"];
        [setparaDic setObject:@"15" forKey:@"engineTimeKey"];
        [setparaDic setObject:@"15" forKey:@"coolAirTimeKey"];
        [setData setObject:setparaDic forKey:[mApp getCarData].mVin];
        [setData synchronize];
    }
    

}

/*!
 @method deleteAllFriend
 @abstract 删除当前账户所有车友信息
 @discussion 删除当前账户所有车友信息
 @param 无
 @result 无
 */
- (void)deleteAllFriend
{
    [mfriendData deleteAllFriendData:mUserData.mUserID];
}

/*!
 @method deleteDemoVehicle
 @abstract 删除demo账户的车友信息
 @discussion 删除demo账户的车友信息
 @param 无
 @result 无
 */
-(void)deleteDemoVehicle
{
    [mCarData deleteCarWithUserID:@"demo_admin"];
}


/*!
 @method loadMeetRequestFriendData
 @abstract 加载车友信息
 @discussion 加载车友信息
 @param 无
 @result friendList 车友列表
 */
- (NSMutableArray*)loadMeetRequestFriendData
{
    NSMutableArray *array;
    array=[mfriendData loadMeetRequestFriendDataWithUserKeyID:mUserData.mUserID];
    return array;
}


//message
#pragma mark deleteUserMessage


/*!
 @method deleteMessageWithType:(enum CLEAR_TYPE)type
 @abstract 通过消息类型删除消息
 @discussion 通过消息类型删除消息
 @param type 类型
 @result bool
 */
- (BOOL)deleteMessageWithType:(enum CLEAR_TYPE)type
{
    BOOL state = NO;
    state = [mMessageInfoData deleteMessageWithUserID:mUserData.mUserID type:type];
    return state;
}

/*!
 @method deleteMessageWithTypes:(NSMutableArray *)types
 @abstract 通过消息类型删除几种消息
 @discussion 通过消息类型删除几种消息
 @param type 类型数组
 @result bool
 */
- (BOOL)deleteMessageWithTypes:(NSMutableArray *)types
{
    BOOL state = NO;
    state = [mMessageInfoData deleteMessageWithUserID:mUserData.mUserID types:types];
    return state;
}

#pragma mark MessageInfoDatabase

/*!
 @method initMessageInfoDatabase
 @abstract 初始化消息主表
 @discussion 初始化消息主表
 @param 无
 @result 无
 */
- (void)initMessageInfoDatabase
{
    mMessageInfoData=[[MessageInfoData alloc]init];
    [mMessageInfoData initMessageInfoDatabase];
}

/*!
 @method deleteMessageInfo:(NSString *)ID
 @abstract 根据消息id删除消息主表中数据
 @discussion 根据消息id删除消息主表中数据
 @param ID 消息id
 @result 无
 */
- (void)deleteMessageInfo:(NSString *)ID
{
    [mMessageInfoData deleteMessageInfo:ID userID:mUserData.mUserID];
}


/*!
 @method deleteMessageInfoWithIDs:(NSString *)ID
 @abstract 根据id删除多条消息
 @discussion 根据id删除多条消息
 @param ID 消息ids
 @result 无
 */
- (void)deleteMessageInfoWithIDs:(NSString *)ID
{
    [mMessageInfoData deleteMessageInfoWithIDs:ID userID:mUserData.mUserID];
}


/*!
 @method loadMessageTypeData:(char)type status:(char)status userID:(NSString *)userID
 @abstract 根据类型，状态，用户id，获取消息
 @discussion 根据类型，状态，用户id，获取消息
 @param type 类型
 @param status 状态
 @param userID 用户id
 @result messagelist 消息列表
 */
- (NSMutableArray*)loadMessageTypeData:(char)type status:(char)status userID:(NSString *)userID
{
    NSMutableArray *array;
    array=[mMessageInfoData loadMessageTypeData:type status:status userID:userID];
    return array;
}


/*!
 @method loadMessageInfoData:(char)status userID:(NSString *)userID
 @abstract 根据类型，状态，用户id，获取消息主表中数据
 @discussion 根据类型，状态，用户id，获取消息主表中数据
 @param type 类型
 @param status 状态
 @param userID 用户id
 @result messagelist 消息列表
 */
- (NSMutableArray*)loadMessageInfoData:(char)status userID:(NSString *)userID
{
    NSMutableArray *array;
    NSLog(@"mUserData.mUserID %@",mUserData.mUserID);
    array=[mMessageInfoData loadMessageInfoData:status userID:userID];
    return array;
}


/*!
 @method loadMessageCountWithType:(enum MESSAGE_TYPE)type
 @abstract 获取某类消息未读数量
 @discussion 获取某类消息未读数量
 @param 无
 @result count
 */
- (int)loadMessageCountWithType:(enum MESSAGE_TYPE)type
{
    return[mMessageInfoData loadMessageCountWithType:type userID:mUserData.mUserID];
}

/*!
 @method deleteAllMessage
 @abstract 删除所有消息
 @discussion 删除所有消息
 @param 无
 @result 无
 */
- (void)deleteAllMessage
{
    [mMessageInfoData deleteAllMessage:mUserData.mUserID];
}


/*!
 @method setMessageAsReaded:(NSString *)KeyID
 @abstract 将消息置为已读状态
 @discussion 将消息置为已读状态
 @param KeyID 消息id
 @result 无
 */
- (void)setMessageAsReaded:(NSString *)KeyID
{
    [mMessageInfoData setMessageAsReaded:KeyID userID:mUserData.mUserID];
}

/*!
 @method getMessageStatus:(NSString *)KeyID
 @abstract 获取消息状态
 @discussion 获取消息状态
 @param KeyID 消息id
 @result Status 消息状态
 */
- (int)getMessageStatus:(NSString *)KeyID
{
    return [mMessageInfoData getMessageStatus:KeyID userID:mUserData.mUserID];
}


/*!
 @method getCreateTime:(NSString *)KeyID
 @abstract 获取消息创建时间
 @discussion 获取消息创建时间
 @param KeyID 消息id
 @result time
 */
- (NSString *)getCreateTime:(NSString *)KeyID
{
    return [mMessageInfoData getCreateTime:KeyID userID:mUserData.mUserID];
}

/*!
 @method addMessageWithSqls:(NSMutableArray *)sqls
 @abstract 传入sql语句插入多条消息，在messageInfoData中进行
 @discussion 传入sql语句插入多条消息，在messageInfoData中进行
 @param sqls sql语句
 @result 无
 */
- (void)addMessageWithSqls:(NSMutableArray *)sqls
{
    [mMessageInfoData addMessageWithSqls:sqls];
}



/*!
 @method searchCarLicense:(NSString*)messageKeyID
 @abstract 根据消息id获取车牌号
 @discussion 根据消息id获取车牌号
 @param messageKeyID 消息id
 @result carLicense
 */
- (NSString *)searchCarNum:(NSString *)messageKeyID
{
    return [mMessageInfoData searchCarNum:messageKeyID];
}


/*!
 @method getNewVehicleDiagnosisReportId
 @abstract 根据userid,vin获取最新的reportid
 @discussion 根据userid,vin获取最新的reportid
 @param 无
 @result ReportId 诊断id
 */
- (NSString *)getNewVehicleDiagnosisReportId
{
    return [mMessageInfoData getNewVehicleDiagnosisReportIdWithUserID:mUserData.mUserID vin:mCarData.mVin];
}


#pragma mark LocationRequest
//位置请求

/*!
 @method initFriendLocationMessageDatabase
 @abstract 初始化位置请求表
 @discussion 初始化位置请求表
 @param 无
 @result 无
 */
- (void)initFriendLocationMessageDatabase
{
    mFriendLocationData = [[FriendLocationData alloc] init];
    [mFriendLocationData initFriendLocationMessageDatabase];
}

/*!
 @method initFriendLocationMessageDatabase
 @abstract 修改请求应答状态及时间
 @discussion 修改请求应答状态及时间
 @param MESSAGE_KEYID 消息id
 @param state 应答状态
 @param rpTime 应答时间
 @result 无
 */
- (void)updateFriendLocationMessageRpState:(NSString *)MESSAGE_KEYID state:(int)state rpTime:(NSString *)rpTime
{
    [mFriendLocationData updateFriendLocationMessageRpState:MESSAGE_KEYID state:state rpTime:rpTime];
}

/*!
 @method deleteFriendLocationMessage:(NSString *)messageID
 @abstract 删除位置请求消息
 @discussion 删除位置请求消息
 @param messageID 消息id
 @result 无
 */
- (void)deleteFriendLocationMessage:(NSString *)messageID
{
    [mFriendLocationData deleteFriendLocationMessage:messageID];
}


/*!
 @method deleteFriendLocationMessage:(NSString *)messageID
 @abstract 根据id删除多个消息
 @discussion 根据id删除多个消息
 @param MESSAGE_KEYID 多条消息id
 @result 无
 */
- (void)deleteFriendLocationMessageWithIDs:(NSString *)MESSAGE_KEYID
{
    [mFriendLocationData deleteFriendLocationMessageWithIDs:MESSAGE_KEYID];
}

/*!
 @method deleteDemoFriendLocationMessage
 @abstract 删除demo的位置请求消息
 @discussion 删除demo的位置请求消息
 @param 无
 @result 无
 */
- (void)deleteDemoFriendLocationMessage
{
    [mFriendLocationData deleteDemoFriendLocationMessage:@"2"];
}


/*!
 @method loadMeetRequestFriendLocationMessage:(NSString *)messageID
 @abstract 加载位置请求消息
 @discussion 加载位置请求消息
 @param messageID 消息id
 @result FriendLocationData 消息数据
 */
- (FriendLocationData *)loadMeetRequestFriendLocationMessage:(NSString *)messageID
{
    return [mFriendLocationData loadMeetRequestFriendLocationMessage:messageID];
}

/*!
 @method loadAllMeetRequestFriendLocationMessage
 @abstract 加载位置请求消息
 @discussion 加载位置请求消息
 @param 无
 @result messagelist 消息列表
 */
- (NSMutableArray *)loadAllMeetRequestFriendLocationMessage
{
    NSMutableArray *array;
    NSLog(@"mUserData.mUserID %@",mUserData.mUserID);
    array=[mFriendLocationData loadAllMeetRequestFriendLocationMessage:mUserData.mUserID];
    return array;
    
}


#pragma mark SendtoCarMessage
/*!
 @method initSendToCarMessageDatabase
 @abstract 初始化发送到车数据库表
 @discussion 初始化发送到车数据库表
 @param 无
 @result 无
 */
- (void)initSendToCarMessageDatabase
{
    mSendToCarMessageData = [[SendToCarMessageData alloc] init];
    [mSendToCarMessageData initSendToCarMessageDatabase];
}



/*!
 @method deleteSendToCarMessage:(NSString *)MESSAGE_KEYID
 @abstract 删除发送到车消息
 @discussion  删除发送到车消息
 @param MESSAGE_KEYID 消息id
 @result 无
 */
- (void)deleteSendToCarMessage:(NSString *)MESSAGE_KEYID
{
    [mSendToCarMessageData deleteSendToCarMessage:MESSAGE_KEYID];
}


/*!
 @method deleteSendToCarMessage:(NSString *)MESSAGE_KEYID
 @abstract 根据id删除多个消息
 @discussion  根据id删除多个消息
 @param MESSAGE_KEYID 消息ids
 @result 无
 */
- (void)deleteSendToCarMessageWithIDs:(NSString *)MESSAGE_KEYID
{
    [mSendToCarMessageData deleteSendToCarMessageWithIDs:MESSAGE_KEYID];
}

/*!
 @method deleteDemoSendToCarMessage
 @abstract 删除demo的发送到车消息
 @discussion 删除demo的发送到车消息
 @param 无
 @result 无
 */
- (void)deleteDemoSendToCarMessage
{
    [mSendToCarMessageData deleteDemoSendToCarMessage:@"4"];
}


/*!
 @method loadMeetRequestSendToCarMessage:(NSString *)MESSAGE_KEYID
 @abstract 加载发送到车消息
 @discussion 加载发送到车消息
 @param MESSAGE_KEYID 消息id
 @result SendToCarMessageData 消息数据
 */
- (SendToCarMessageData *)loadMeetRequestSendToCarMessage:(NSString *)MESSAGE_KEYID
{
    return [mSendToCarMessageData loadMeetRequestSendToCarMessage:MESSAGE_KEYID];
}


/*!
 @method loadAllMeetRequestSendToCarMessage
 @abstract 加载当前账户下发送到车消息
 @discussion 加载当前账户下发送到车消息
 @param 无
 @result messageList 发送到车列表
 */
- (NSMutableArray *)loadAllMeetRequestSendToCarMessage
{
    //NSMutableArray *array = [[[NSMutableArray alloc]initWithCapacity:0]autorelease];
    NSMutableArray *array;
    NSLog(@"mUserData.mUserID %@",mUserData.mUserID);
    array=[mSendToCarMessageData loadAllMeetRequestSendToCarMessage:mUserData.mUserID];
    return array;
}

#pragma mark FriendRequestLocation

/*!
 @method initFriendRequestLocationMessageDatabase
 @abstract 初始化车友网位置表
 @discussion  初始化车友网位置表
 @param 无
 @result 无
 */
- (void)initFriendRequestLocationMessageDatabase
{
    mFriendReqLocationData = [[FriendRequestLocationMessageData alloc] init];
    [mFriendReqLocationData initFriendRequestLocationMessageDatabase];
}


/*!
 @method deleteFriendRequestLocationMessage:(NSString *)MESSAGE_KEYID
 @abstract 删除车友位置消息
 @discussion 删除车友位置消息
 @param MESSAGE_KEYID 消息id
 @result 无
 */
- (void)deleteFriendRequestLocationMessage:(NSString *)MESSAGE_KEYID
{
    [mFriendReqLocationData deleteFriendRequestLocationMessage:MESSAGE_KEYID];
}

/*!
 @method deleteFriendRequestLocationMessageWithIDs:(NSString *)MESSAGE_KEYID
 @abstract 根据id删除多个消息
 @discussion 根据id删除多个消息
 @param MESSAGE_KEYID 消息ids
 @result 无
 */
- (void)deleteFriendRequestLocationMessageWithIDs:(NSString *)MESSAGE_KEYID
{
    [mFriendReqLocationData deleteFriendRequestLocationMessageWithIDs:MESSAGE_KEYID];
}

/*!
 @method deleteDemoFriendRequestLocationMessage
 @abstract 删除demo车友位置消息
 @discussion 删除demo车友位置消息
 @param 无
 @result 无
 */
- (void)deleteDemoFriendRequestLocationMessage
{
    [mFriendReqLocationData deleteDemoFriendRequestLocationMessage:@"3"];
}



/*!
 @method loadMeetRequestFriendRequestLocationMessage:(NSString *)MESSAGE_KEYID
 @abstract 加载车友位置消息
 @discussion 加载车友位置消息
 @param MESSAGE_KEYID 消息id
 @result MessageData 消息数据
 */
- (FriendRequestLocationMessageData *)loadMeetRequestFriendRequestLocationMessage:(NSString *)MESSAGE_KEYID
{
    return [mFriendReqLocationData loadMeetRequestFriendRequestLocationMessage:MESSAGE_KEYID];
}


/*!
 @method loadAllMeetRequestFriendRequestLocationMessage
 @abstract 加载车友位置消息
 @discussion 加载车友位置消息
 @param 无
 @result MessageList 消息列表
 */
- (NSMutableArray *)loadAllMeetRequestFriendRequestLocationMessage
{
    NSMutableArray *array;
    NSLog(@"mUserData.mUserID %@",mUserData.mUserID);
    array=[mFriendReqLocationData loadAllMeetRequestFriendRequestLocationMessage:mUserData.mUserID];
    return array;
    
}


//system message
#pragma mark system message

/*!
 @method initSystemMessageDatabase
 @abstract 初始化系统消息表
 @discussion 初始化系统消息表
 @param 无
 @result 无
 */
- (void)initSystemMessageDatabase
{
    mSystemMessageData = [[SystemMessageData alloc] init];
    [mSystemMessageData initSystemMessageDatabase];
}


/*!
 @method updateSystemMessage:(NSString *)keyID sendDate:(NSString *)sendDate content:(NSString *)content messageID:(NSString *)messageID
 @abstract 更新或添加系统消息
 @discussion 更新或添加系统消息
 @param message 系统消息
 @result 无
 */
- (void)updateSystemMessage:(NSString *)keyID
                   sendDate:(NSString *)sendDate
                    content:(NSString *)content
                  messageID:(NSString *)messageID
{
    [mSystemMessageData updateSystemMessage:keyID sendDate:sendDate content:content messageID:messageID];
}

/*!
 @method deleteSystemMessage:(NSString *)messageID
 @abstract 删除系统消息
 @discussion 删除系统消息
 @param messageID 系统消息id
 @result 无
 */
- (void)deleteSystemMessage:(NSString *)messageID
{
    [mSystemMessageData deleteSystemMessage:messageID];
}

/*!
 @method deleteDemoSystemMessage
 @abstract 删除demo用户系统消息
 @discussion 删除demo用户系统消息
 @param 无
 @result 无
 */
- (void)deleteAllSystemMessage
{
    [mSystemMessageData deleteAllSystemMessage:@"5"];
}


/*!
 @method loadAllMeetRequestSystemMessage
 @abstract 获取系统消息列表
 @discussion 获取系统消息列表
 @param 无
 @result messageList
 */
- (NSMutableArray *)loadAllMeetRequestSystemMessage
{
    //NSMutableArray *array = [[[NSMutableArray alloc]initWithCapacity:0]autorelease];
    NSMutableArray *array;
    NSLog(@"mUserData.mUserID %@",mUserData.mUserID);
    array=[mSystemMessageData loadAllMeetRequestSystemMessage:mUserData.mUserID];
    return array;
}


//searchHistory
#pragma mark searchHistory
/*!
 @method initSearchHistoryDatabase
 @abstract 初始化搜索历史表
 @discussion 初始化搜索历史表
 @param 无
 @result 无
 */
- (void)initSearchHistoryDatabase
{
    mSearchHistory=[[SearchHistoryData alloc]init];
    [mSearchHistory initSearchHistoryDatabase];
}

/*!
 @method addSearchHistory:(NSString *)keyID searchName:(NSString *)searchName createTime:(NSString *)createTime
 @abstract 添加搜索历史
 @discussion 添加搜索历史
 @param keyID id
 @param searchName 搜索关键字
 @param createTime 创建时间
 @result 无
 */
-(void)addSearchHistory:(NSString *)keyID
             searchName:(NSString *)searchName
             createTime:(NSString *)createTime
{
    NSLog(@"search_muserdata.mUserID%@",mUserData.mUserID);
    [mSearchHistory addSearchHistory:keyID searchName:searchName createTime:createTime userID:mUserData.mUserID];
}


/*!
 @method deleteSearchHistory
 @abstract 删除搜索历史
 @discussion 删除搜索历史
 @param 无
 @result bool
 */
- (BOOL)deleteSearchHistory
{
    BOOL state = NO;
    state=[mSearchHistory deleteSearchHistory:mUserData.mUserID];
    return state;
}

/*!
 @method loadMeetRequestSearchHistory
 @abstract 加载搜索历史
 @discussion 加载搜索历史
 @param 无
 @result HistoryList 历史列表
 */
- (NSMutableArray*)loadMeetRequestSearchHistory
{
    NSMutableArray *array;
    array=[mSearchHistory loadMeetRequestSearchHistory:mUserData.mUserID];
    return array;
}


/*!
 @method loadMeetRequestSearchHistoryWithText:(NSString *)searchText
 @abstract 根据关键字加载搜索历史
 @discussion 根据关键字加载搜索历史
 @param 无
 @result HistoryList 历史列表
 */
- (NSMutableArray*)loadMeetRequestSearchHistoryWithText:(NSString *)searchText
{
    NSMutableArray *array;
    array=[mSearchHistory loadMeetRequestSearchHistoryWithText:mUserData.mUserID searchText:searchText];
    return array;
}
//poi

#pragma mark poi

/*!
 @method loadMeetRequestCollectTableData
 @abstract 获取收藏夹列表要显示的数据
 @discussion 获取收藏夹列表要显示的数据
 @param 无
 @result poiList poi列表
 */
- (NSMutableArray*)loadMeetRequestCollectTableData
{
    return [mPOIData loadMeetRequestCollectTableData:mUserData.mUserID];
}

/*!
 @method loadMeetRequestPOIDataSyncNO
 @abstract 获取未同步的poi列表
 @discussion 获取未同步的poi列表
 @param 无
 @result poiList poi列表
 */
- (NSMutableArray*)loadMeetRequestPOIDataSyncNO
{
    NSMutableArray *array;
    array=[mPOIData loadMeetRequestPOIDataSyncNO:mUserData.mUserID];
    return array;
}


/*!
 @method loadMeetRequestPOIDataSyncAdd
 @abstract 获取添加未同步的列表
 @discussion 获取添加未同步的列表
 @param 无
 @result poiList poi列表
 */
- (NSMutableArray*)loadMeetRequestPOIDataSyncAdd
{
    NSMutableArray *array;
    array=[mPOIData loadMeetRequestPOIDataSyncAdd:mUserData.mUserID];
    return array;
}


/*!
 @method loadMeetRequestPOIDataSyncYES
 @abstract 获取已同步的poi列表
 @discussion 获取已同步的poi列表
 @param 无
 @result poiList poi列表
 */
- (NSMutableArray*)loadMeetRequestPOIDataSyncYES
{
    NSMutableArray *array;
    array=[mPOIData loadMeetRequestPOIDataSyncYES:mUserData.mUserID];
    return array;
}


/*!
 @method loadMeetRequestPOIData:(NSString *)lon lat:(NSString *)lat
 @abstract 加载poi信息
 @discussion 加载poi信息
 @param lon 经度
 @param lat 纬度
 @result POIData poi信息
 */
- (POIData*)loadMeetRequestPOIData:(NSString *)lon lat:(NSString *)lat
{
    POIData *poi=[mPOIData loadMeetRequestPOIData:mUserData.mUserID lon:lon lat:lat];
    return poi;
}



/*!
 @method loadPoi:(NSString *)lon lat:(NSString *)lat ID:(NSString *)ID fID:(NSString *)fID type:(int)type
 @abstract 根据不同类型的poi信息，通过不同的sql语句，判断该poi是否已经收藏
 @discussion 根据不同类型的poi信息，通过不同的sql语句，判断该poi是否已经收藏
 @param userID 所属用户id
 @param ID poiid
 @param fID 收藏id
 @param lon 经度暂时无用
 @param lat 纬度暂时无用
 @param type poi类型（手机位置、车机位置、自定义位置、收藏夹poi、搜索poi）
 @result POIData
 */
- (POIData*)loadPoi:(NSString *)lon lat:(NSString *)lat ID:(NSString *)ID fID:(NSString *)fID type:(int)type
{
    return [mPOIData loadPoi:lon lat:lat userID:mUserData.mUserID ID:ID fID:fID type:type];
}

/*!
 @method initPOIDatabase
 @abstract 初始化poi表
 @discussion 初始化poi表
 @param 无
 @result 无
 */
- (void)initPOIDatabase
{
    mPOIData=[[POIData alloc]init];
    [mPOIData initPOIDatabase];
}

/*!
 @method addPOIData:(NSString *)keyID fID:(NSString *)fID ID:(NSString *)ID
 name:(NSString *)name createTime:(NSString *)createTime lon:(NSString *)lon
 lat:(NSString *)lat phone:(NSString *)phone address:(NSString *)address
 desc:(NSString *)desc flag:(int)flag level:(int)level postCode:(NSString *)postCode
 @abstract 添加poi信息
 @discussion 添加poi信息
 @param poidata poi信息
 @result 无
 */
- (void)addPOIData:(NSString *)keyID
               fID:(NSString *)fID
                ID:(NSString *)ID
              name:(NSString *)name
        createTime:(NSString *)createTime
               lon:(NSString *)lon
               lat:(NSString *)lat
             phone:(NSString *)phone
           address:(NSString *)address
              desc:(NSString *)desc
              flag:(int)flag
             level:(int)level
          postCode:(NSString *)postCode;
{
    [mPOIData addPOIData:keyID fID:fID ID:ID name:name createTime:createTime lon:lon lat:lat phone:phone address:address desc:desc flag:flag userID:mUserData.mUserID level:level postCode:postCode];
}


/*!
 @method updatePOIData:(NSString *)keyID fID:(NSString *)fID ID:(NSString *)ID
 name:(NSString *)name createTime:(NSString *)createTime lon:(NSString *)lon
 lat:(NSString *)lat phone:(NSString *)phone address:(NSString *)address
 desc:(NSString *)desc flag:(int)flag level:(int)level postCode:(NSString *)postCode
 @abstract 修改poi信息
 @discussion 修改poi信息
 @param poidata poi信息
 @result 无
 */
- (void)updatePOIData:(NSString *)keyID
                  fID:(NSString *)fID
                   ID:(NSString *)ID
                 name:(NSString *)name
           createTime:(NSString *)createTime
                  lon:(NSString *)lon
                  lat:(NSString *)lat
                phone:(NSString *)phone
              address:(NSString *)address
                 desc:(NSString *)desc
                 flag:(int)flag
                level:(int)level
             postCode:(NSString *)postCode;
{
    [mPOIData updatePOIData:keyID fID:fID ID:ID name:name createTime:createTime lon:lon lat:lat phone:phone address:address desc:desc flag:flag userID:mUserData.mUserID level:level postCode:postCode];
    
}


/*!
 @method updateFlag:(NSString *)lon lat:(NSString *)lat flag:(int)flag
 ID:(NSString *)ID fID:(NSString *)fID
 @abstract 修改poi状态
 @discussion 修改poi状态
 @param lon 经度
 @param lat 纬度
 @param flag 状态
 @param id poiid
 @param fid 收藏id
 @result 无
 */
- (void)updateFlag:(NSString *)lon
               lat:(NSString *)lat
              flag:(int)flag
                ID:(NSString *)ID
               fID:(NSString *)fID

{
    [mPOIData updateFlag:lon lat:lat flag:flag userID:mUserData.mUserID ID:ID fID:fID];
}

/*!
 @method updateFlag:(int)flag IDs:(NSMutableArray *)IDs
 @abstract 根据userID，ID更新poi状态
 @discussion 根据userID，ID更新poi状态
 @param userID 所属用户id
 @param ID poiid
 @param flag 状态
 @result 无
 */
- (void)updateFlag:(int)flag
               IDs:(NSMutableArray *)IDs
{
    [mPOIData updateFlag:flag userID:mUserData.mUserID IDs:IDs];
}

/*!
 @method updatePOINameAndFlag:(NSString *)name flag:(int)flag ID:(NSString *)ID fID:(NSString *)fID createTime:(NSString *)createTime
 @abstract 根据userID，ID，fID更新poi状态
 @discussion 根据userID，ID，fID更新poi状态
 @param ID poiid
 @param fID 收藏id
 @param flag 状态
 @param name poiname
 @result 无
 */
- (void)updatePOINameAndFlag:(NSString *)name
                        flag:(int)flag
                          ID:(NSString *)ID
                         fID:(NSString *)fID
                  createTime:(NSString *)createTime
{
    [mPOIData updatePOINameAndFlag:name flag:flag userID:mUserData.mUserID ID:ID fID:fID createTime:createTime];
}


/*!
 @method deletePOIData:(NSString *)lon lat:(NSString *)lat ID:(NSString *)ID fID:(NSString *)fID
 @abstract 删除poi信息
 @discussion 删除poi信息
 @param lon 经度
 @param lat 纬度
 @param id poiid
 @param fid 收藏id
 @result 无
 */
- (void)deletePOIData:(NSString *)lon
                  lat:(NSString *)lat
                   ID:(NSString *)ID
                  fID:(NSString *)fID
{
    [mPOIData deletePOIData:lon lat:lat userID:mUserData.mUserID ID:ID fID:fID];
}


/*!
 @method poiExist:(NSString *)lon lat:(NSString *)lat ID:(NSString *)ID fID:(NSString *)fID type:(int)type
 @abstract 判断poi是否已存在
 @discussion 判断poi是否已存在
 @param lon 经度
 @param lat 纬度
 @param id poiid
 @param fid 收藏id
 @param type 类型
 @result bool
 */
- (BOOL)poiExist:(NSString *)lon lat:(NSString *)lat ID:(NSString *)ID fID:(NSString *)fID type:(int)type
{
    BOOL exist;
    exist=[mPOIData poiExist:lon lat:lat userID:mUserData.mUserID ID:ID fID:fID type:type];
    return exist;
}

/*!
 @method deleteAllPOIData
 @abstract 删除当前账户下所有poi信息
 @discussion 删除当前账户下所有poi信息
 @param 无
 @result 无
 */
- (void)deleteAllPOIData
{
    [mPOIData deleteAllPOIData:mUserData.mUserID];
}



/*!
 @method deleteSycnPOIData
 @abstract 删除当前账户下所有已同步的poi信息
 @discussion 删除当前账户下所有已同步的poi信息
 @param 无
 @result 无
 */
- (void)deleteSycnPOIData
{
    [mPOIData deleteSycnPOIData:mUserData.mUserID];
}


/*!
 @method deletePOIDataWithFID:(NSString *)fID
 @abstract 一次性删除多个poi信息 以及修改标识flag
 @discussion 一次性删除多个poi信息 以及修改标识flag
 @param fID poiid
 @result 无
 */
- (void)deletePOIDataWithFID:(NSString *)fID
{
    [mPOIData deletePOIDataWithFID:fID userID:mUserData.mUserID];
}

/*!
 @method addPOIDataWithSqls:(NSMutableArray *)sqls
 @abstract 传入sql语句插入poi信息
 @discussion 传入sql语句插入poi信息
 @param sqls sqllist
 @result 无
 */
- (void)addPOIDataWithSqls:(NSMutableArray *)sql
{
    [mPOIData addPOIDataWithSqls:sql];
}




#pragma mark loadDemoData

/*!
 @method loadDemoData
 @abstract 载入DEMO数据
 @discussion 载入DEMO数据
 @param 无
 @result 无
 */
- (void)loadDemoData
{
    mUserData.mAccount = @"demo_admin";
    mUserData.mUserID = @"demo_admin";
    [self deleteDemo];
    
    [self deleteDemoVehicle];
    [self deleteAllFriend];
    [self deleteAllBlackData];
    [self deleteAllPOIData];
//    [self deleteAllMessage];
//    [self deleteDemoElectronicFenceMessage];
//    [self deleteDemoFriendLocationMessage];
//    [self deleteDemoSendToCarMessage];
//    [self deleteAllSystemMessage];
//    [self deleteDemoFriendRequestLocationMessage];
//    [self deleteDemoFriendRequestLocationMessage];
    [self removeAllElecFence];
    
    [self clearDemoData];
    [mCherryDBControl deleteVehicleStatusWithVin:@"demo_vin"];
    
    if (mDemoData) {
        [mDemoData release];
        mDemoData = nil;
    }
    mDemoData = [[NIDemoData alloc] init];
    [mDemoData loadDemoDatabase];
    //    [mfriendData loadDemoFriendDatabase];
}


#pragma mark loadDemoData

/*!
 @method initDatabase
 @abstract 初始化数据库
 @discussion 初始化数据库
 @param 无
 @result 无
 */

- (void)initDatabase
{
    [self initUserData];
    [self initCarData];
    [self initmfriendData];
    [self initBlackData];
    [self initMessageInfoDatabase];
    [self initPOIDatabase];
    [self initSearchHistoryDatabase];
//    [self initElectronicFenceMessageDatabase];
    [self initFriendLocationMessageDatabase];
    [self initSendToCarMessageDatabase];
    [self initSystemMessageDatabase];
    [self initFriendRequestLocationMessageDatabase];
    [mCherryDBControl initCherryDB];
}


/*!
 @method loadDemoUserData
 @abstract 载入DEMO账户数据
 @discussion 载入DEMO账户数据
 @param 无
 @result 无
 */
- (void)loadDemoUserData
{
    [mUserData loadDemoUserData];
}

/*!
 @method setExclusiveTouchForButtons:(UIView *)myView
 @abstract 控制不可多触点
 @discussion 控制不可多触点
 @param myView 要控制的view
 @result 无
 */
+ (void)setExclusiveTouchForButtons:(UIView *)myView
{
//    for (UIView * view in [myView subviews]) {
//        if([view isKindOfClass:[UIButton class]])
//            [((UIButton *)view) setExclusiveTouch:YES];
//        else if ([view isKindOfClass:[UIView class]]){
//            [self setExclusiveTouchForButtons:view];
//        }
//    }
}
//}
/*!
 @method clearDemoData
 @abstract 清除demo消息数据
 @discussion 清除demo消息数据
 @param 无
 @result 无
 */
-(void)clearDemoData
{
    NSMutableArray *array = [[NSMutableArray alloc]initWithObjects:[NSString stringWithFormat:@"%d",CLEAR_MESSAGE_ELECTRONIC], [NSString stringWithFormat:@"%d",CLEAR_MESSAGE_SEND_TO_CAR],[NSString stringWithFormat:@"%d",CLEAR_MESSAGE_FRIEND_LOCATION],[NSString stringWithFormat:@"%d",CLEAR_MESSAGE_FRIEND_REQUEST_LOCATION],[NSString stringWithFormat:@"%d",CLEAR_MESSAGE_VEHICLE_CONTROL],[NSString stringWithFormat:@"%d",CLEAR_MESSAGE_VEHICLE_ABNORMAL_ALARM],[NSString stringWithFormat:@"%d",CLEAR_MESSAGE_MAINTENANCE_ALARM],[NSString stringWithFormat:@"%d",CLEAR_MESSAGE_VEHICLE_DIAGNOSIS],nil];
    [mMessageInfoData deleteMessageWithUserID:DEMO_LOGINID types:array];
}

/*!
 @method clearHistoryData:
 @abstract 清除历史数据
 @discussion 清除历史数据
 @param 无
 @result 无
 */
-(BOOL)clearHistoryData:(NSMutableArray *)array
{
    return [mMessageInfoData deleteMessageWithUserID:mUserData.mUserID types:array];
}
#pragma mark - cherry - elecFence
//- (void)initElecFenceData
//{
//    elecFenceData=[[ElecFenceData alloc]init];
//    [elecFenceData initElecFenceDatabase];
//}

- (void)removeAllElecFence
{
    [mCherryDBControl removeWithAllDBVin:@"demo_vin"];
}
@end

