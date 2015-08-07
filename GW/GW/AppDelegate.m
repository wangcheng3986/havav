//
//  AppDelegate.m
//  gratewall
//
//  Created by liutch on 13-4-9.
//  Copyright (c) 2013年 liutch. All rights reserved.
//

#import "AppDelegate.h"

#import "App.h"
#import "MainViewController.h"
#import "MapTabBarViewController.h"
#import "NIMessagePoll.h"
#import <AudioToolbox/AudioToolbox.h>

#import "NIMapManager.h"
@class AppDelegate;
@class MainViewController;
static int isGetMessage;
static int isFromURL;
@implementation AppDelegate
NIMapManager* _mapManager;
- (void)dealloc
{
    [_window release];
    [_oMainViewController release];
    [_messagePool release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    
    //地图初始化操作>>>>>>>>>>>>>>>>>>>>start>>>by wangqiwei
    _mapManager = [[NIMapManager alloc]init];
    [_mapManager setSearchIDKey:@"sdk" apiKey:@"bmF2aW5mb1o3enNka1NEU3g="];
    //地图初始化操作<<<<<<<<<<<<<<<<<<<end<<<by wangqiwei
    
    //增加标识，用于判断是否是第一次启动应用...
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
    }
    //初始化App
    App *oApp = [App getInstance];
    [CherryDBControl sharedCherryDBControl];
    [oApp setWindow:self.window];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"])
    {
        _guideViewController = [[GuideViewController alloc]init];
        [oApp setGuideRootController:_guideViewController];
    }
    else
    {
        _oMainViewController = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
        [oApp setRootController:_oMainViewController];
    }

    
    
    [self.window makeKeyAndVisible];
    
    [self registerNotification];

    //禁止自动休眠
    //    [UIApplication sharedApplication].idleTimerDisabled=YES;
    //    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    //    [NSThread sleepForTimeInterval:3];
    return YES;
}

-(void)registerNotification
{
    
    if ([App getVersion]>=IOS_VER_8) {
        /**
         *快速回复
        UIMutableUserNotificationAction *action = [[UIMutableUserNotificationAction alloc] init];
        action.identifier = @"action";//按钮的标示
        action.title=@"Accept";//按钮的标题
        action.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
        //    action.authenticationRequired = YES;
        //    action.destructive = YES;
        
        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
        action2.identifier = @"action2";
        action2.title=@"Reject";
        action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
        action.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
        action.destructive = YES;
        UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
        categorys.identifier = @"alert";//这组动作的唯一标示
        [categorys setActions:@[action,action2] forContext:(UIUserNotificationActionContextMinimal)];
        UIUserNotificationSettings *uns = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound) categories:[NSSet setWithObjects:categorys, nil]];
        */
         UIUserNotificationSettings *uns = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound) categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:uns];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        [[UIApplication sharedApplication]registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert];
    }
    self.messagePool = [[NIMessagePoll alloc] init];
    isGetMessage = 0;
}

- (void)application:(UIApplication *)app didReceiveLocalNotification:(UILocalNotification *)notif {
	// Handle the notificaton when the app is running
	NSLog(@"Recieved Notification %@",notif);
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    App *app = [App getInstance];
    NSLog(@"my deviceToken is %@",deviceToken);
    NSString *string = [NSString stringWithFormat:@"%@",deviceToken];
    NSRange range;
    range.location = 1;
    range.length = string.length - 2;
    app.deviceTokenId = [[NSString alloc]initWithString:[string substringWithRange:range]];
    if (isFromURL == 0) {
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"UserDefaultLogin"]) {
            
            NSString *time = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserDefaultAppResignActive"];
            long long lastTime = [time longLongValue]; // 将double转为long long型
            long long nowTime = [[App getTimeSince1970] longLongValue];
            if (nowTime - lastTime < 60*30 && nowTime - lastTime > 0)
            {
                [_oMainViewController automaticLogin];
            }
        }
    }
    isFromURL = 0;
    NSLog(@"self devicetokenid = %@",app.deviceTokenId);
}


- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"failed to get token ，error：%@",error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
    
//    if(application.applicationState == UIApplicationStateBackground)
//    {
//        NSLog(@"application.applicationState =UIApplicationStateBackground");
//        
//    }
//    else if(application.applicationState == UIApplicationStateInactive)
//    {
//        NSLog(@"application.applicationState =UIApplicationStateInactive");
////        [self popToMainVC];
//    }
//    else if(application.applicationState == UIApplicationStateActive)
//    {
//        
//    }
//    else
//    {
//        NSLog(@"application.applicationState =else");
//        
//    }
    
    if (isGetMessage == 0) {
        NSLog(@"application.applicationState =UIApplicationStateActive");
        NSLog(@"%@",[[userInfo objectForKey:@"aps"]objectForKey:@"badge" ]);
        NSLog(@"remote notification is %@",userInfo);
        NSLog(@"%d",application.applicationIconBadgeNumber);
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:[[[userInfo objectForKey:@"aps"]objectForKey:@"badge"]integerValue]];
        NSLog(@"------>有推送即将获取消息");
        [self.messagePool getMessage];
    }
}



- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    NSLog(@"------>前台进入后台1");
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@"------>前台进入后台2");
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    if (application.applicationIconBadgeNumber > 0)
    {
        NSLog(@"------>后台进入前台即将获取消息");
        [self.messagePool getMessage];
        isGetMessage = 1;
    }
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface
     NSLog(@"------>后台进入前台2");
    isGetMessage = 0;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.

}

NSString *lon,*lat,*title,*address,*phone;

#pragma mark - UIApplicationDelegate
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    isFromURL = 1;
    NSLog(@"%@",url);
    BOOL urlError = false;
    NSArray *array=[[url query] componentsSeparatedByString:@"&"];
    NSMutableDictionary *parmaMutableDictionary = [[NSMutableDictionary alloc]initWithCapacity:0];
    for (int i = 0; i < array.count; i++) {
        NSString *tempStr = [NSString stringWithFormat:@"%@",[array objectAtIndex:i]];
        if (tempStr && ![tempStr isEqualToString:@""]) {
            NSArray *tempArray=[tempStr componentsSeparatedByString:@"="];
            if (tempArray.count >= 2) {
                [parmaMutableDictionary setObject:[NSString stringWithFormat:@"%@",[tempArray objectAtIndex:1]] forKey:[NSString stringWithFormat:@"%@",[tempArray objectAtIndex:0]]];
            }
        }
        
        
    }
   
    lon = [parmaMutableDictionary objectForKey:@"lon"];
    lat = [parmaMutableDictionary objectForKey:@"lat"];
//    title = [parmaMutableDictionary objectForKey:@"title"];
//    address = [parmaMutableDictionary objectForKey:@"address"];
    
//    将UTF8编码转换成汉字
     title = [[parmaMutableDictionary objectForKey:@"title"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    address = [[parmaMutableDictionary objectForKey:@"address"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if ([parmaMutableDictionary objectForKey:@"phone"]) {
        phone = [[parmaMutableDictionary objectForKey:@"phone"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    else
    {
        phone = @"";
    }
    
    
//    NSLog(@"lon=%@,lat=%@,title=%@,address=%@",lon,lat,title,address);
    
    if (lon == nil ||lat == nil ||title == nil ||address == nil ||[lon isEqualToString:@""]||[lat isEqualToString:@""]||[title isEqualToString:@""]||[address isEqualToString:@""]) {
        urlError = true;
    }
    if (urlError == false) {
        NSMutableDictionary *disDic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:lon,@"lon",lat,@"lat",title,@"title",address,@"address",lat,@"lat",phone,@"phone",nil];
        App *app=[App getInstance];
        if( [[app getCurController] isKindOfClass:[MainViewController class]] ){
//            _oMainViewController.urlLon = lon;
//            _oMainViewController.urlLat = lat;
//            _oMainViewController.urlTitle = title;
//            _oMainViewController.urlAddress = address;
            _oMainViewController.urlJump = 1;
            [_oMainViewController setUrlDic:disDic];
            [_oMainViewController urlShouldGoMap];
        }
        else{
            _oMainViewController.urlJump = 1;
            [_oMainViewController setUrlDic:disDic];
            [app popToRootController:YES];
        }
        [disDic release];
        disDic = nil;
    }
    else
    {
        [_oMainViewController urlError];
    }
    

    return YES;
}

/*!
 @method goVehicleControlVC
 @abstract 界面跳转，暂时无用
 @discussion 界面跳转，暂时无用
 @param 无
 @result 无
 */
//-(void)goVehicleControlVC
//{
//    App *app=[App getInstance];
//    if( [[app getCurController] isKindOfClass:[MainViewController class]] ){
//        _oMainViewController.shouldGoVehicleControl = 1;
//        [_oMainViewController goVehicleControlVC];
//    }
//    else{
//        _oMainViewController.shouldGoVehicleControl = 1;
//        [app popToRootController:YES];
//    }
//}

/*!
 @method popToMainVC
 @abstract 跳转至主界面
 @discussion 跳转至主界面
 @param 无
 @result 无
 */
-(void)popToMainVC
{
    App *app=[App getInstance];
    [app popToRootController:YES];
}




@end
