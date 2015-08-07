//
//  FriendTabBarViewController.m
//  gratewall
//
//  Created by my on 13-4-19.
//  Copyright (c) 2013年 liutch. All rights reserved.
//

#import "FriendTabBarViewController.h"
#import "App.h"
#import "MainViewController.h"
#import "FriendListViewController.h"
#import "SelfDetailViewController.h"
#import "FriendDetailViewController.h"
@interface FriendTabBarViewController ()
{

    int isFirstLoginFriend;
    int editType;
    UIBarButtonItem *leftButton;
}
@end
@implementation FriendTabBarViewController

@synthesize friendLoadType;
@synthesize mSelectFlag;
@synthesize backBtn;
//@synthesize friendController;

- (id)init
{
    self = [super initWithNibName:@"FriendTabBarViewController" bundle:nil];
    if (self)
    {
        mSelectFlag = YES;
    }
    return self;
}
- (void)dealloc
{
    [friendController release], friendController = nil;
    [addfriendController release],addfriendController = nil;
    [titleLabel release],titleLabel = nil;
    [mDisViewUp removeFromSuperview];
    [mDisViewUp release],mDisViewUp = nil;
    [mDisViewDown removeFromSuperview];
    [mDisViewDown release],mDisViewDown = nil;
    if (leftButton) {
        [leftButton release];
        leftButton= nil;
    }
    if (backBtn) {
        [backBtn release];
        backBtn= nil;
    }
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.delegate = self;
    [self.view setBackgroundColor:[UIColor blackColor]];
    if([App getVersion]>=IOS_VER_7){
        [App ios7ViewLocation:self];
        
    }
    backBtn = [[HomeButton alloc]init];
    //modify by wangqiwei for IOS7 style at 2014 5 19
    [backBtn addTarget:self action:@selector(goBack)forControlEvents:UIControlEventTouchUpInside];
    leftButton=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftButton;
    //数据库获取isFirstLoginFriend
//    App *app = [App getInstance];
//    isFirstLoginFriend=[app getIsFirstLogin];
    Resources *oRes = [Resources getInstance];
    self.tabBar.backgroundImage=[UIImage imageNamed:@"friend_tabbar_bg"];
    addfriendController = [[AddFriendViewController alloc]init];
    friendController = [[FriendListViewController alloc]init];
    
    if ([App getVersion] >= IOS_VER_7)
    {
        UIImage * normalImage = [[UIImage imageNamed:@"friend_tab_list_no_ic"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage * selectImage = [[UIImage imageNamed:@"friend_tab_list_yes_ic"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        friendController.tabBarItem = [[UITabBarItem alloc]initWithTitle:[oRes getText:@"friend.FriendTabBarViewController.friendListTabBarItemTitle"] image:normalImage selectedImage:selectImage];
        
        normalImage = [[UIImage imageNamed:@"friend_tab_add_no_ic"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        selectImage = [[UIImage imageNamed:@"friend_tab_add_yes_ic"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        addfriendController.tabBarItem = [[UITabBarItem alloc]initWithTitle:[oRes getText:@"friend.FriendTabBarViewController.addFriendTabBarItemTitle"] image:normalImage selectedImage:selectImage];
    }
    else
    {
        friendController.tabBarItem.title=[oRes getText:@"friend.FriendTabBarViewController.friendListTabBarItemTitle"];
        addfriendController.tabBarItem.title=[oRes getText:@"friend.FriendTabBarViewController.addFriendTabBarItemTitle"];
        [friendController.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"friend_tab_list_yes_ic"] withFinishedUnselectedImage:[UIImage imageNamed:@"friend_tab_list_no_ic"]];
        [addfriendController.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"friend_tab_add_yes_ic"] withFinishedUnselectedImage:[UIImage imageNamed:@"friend_tab_add_no_ic"]];
    }
    
    
    //下面两条解决了tabbar文字大小设置的问题
    //modify by wangqiwei for ios7 style
    [friendController.tabBarItem setTitleTextAttributes:@{ UITextAttributeFont : [UIFont size12] }forState:UIControlStateNormal];
    
    [addfriendController.tabBarItem setTitleTextAttributes:@{ UITextAttributeFont : [UIFont size12] }forState:UIControlStateNormal];
    
    friendController.rootController = self;
    NSLog(@"%d",[friendController retainCount]);
    addfriendController.rootController = self;
   
    self.tabBar.tintColor = [UIColor whiteColor];
    
     self.viewControllers = [NSArray arrayWithObjects:friendController,addfriendController,nil];
    CGRect rect1 = CGRectMake(self.view.frame.origin.x,self.view.frame.origin.x,self.view.frame.size.width,53);
    mDisViewUp.frame = rect1;
    [self.view addSubview:mDisViewUp];
    mDisViewUp.hidden=YES;
    
    CGRect rect2 = CGRectMake(self.view.frame.origin.x,(self.view.frame.size.height) - 57,self.view.frame.size.width,57);
    mDisViewDown.frame = rect2;
    [self.view addSubview:mDisViewDown];
    mDisViewDown.hidden=YES;
    // Do any additional setup after loading the view from its nib.
    
}
/*!
 @method goBack
 @abstract UI界面设置
 @discussion UI界面设置
 @result 无
 */
- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
/*!
 @method displayDisView
 @abstract UI界面设置
 @discussion UI界面设置
 @result 无
 */
- (void)displayDisView
{
    mDisViewUp.hidden=NO;
    mDisViewDown.hidden=NO;
}
/*!
 @method hiddenDisView
 @abstract UI界面设置
 @discussion UI界面设置
 @result 无
 */
- (void)hiddenDisView
{
    mDisViewUp.hidden=YES;
    mDisViewDown.hidden=YES;
}
/*!
 @method setFriendLoad
 @abstract UI界面设置
 @discussion UI界面设置
 @result 无
 */
- (void)setFriendLoad:(int)friendLoad
{
    friendLoadType=friendLoad;
}

/*!
 @method goFriendList
 @abstract 跳转到朋友列表，带等待框
 @discussion 跳转到朋友列表，带等待框
 @result 无
 */
-(void)goFriendList
{
    /* 刷新朋友列表 孟磊 2013年9月10日*/
    [self setSelectedIndex:0];
}

/*!
 @method goFriendListAndJumptoEnd
 @abstract 跳转到朋友列表，带等待框
 @discussion 跳转到朋友列表，带等待框
 @param friend 列表数据
 @result 无
 */
-(void)goFriendListAndJumptoEnd:(FriendsData *)friend
{
    /* 刷新朋友列表 孟磊 2013年9月10日*/
    [self setSelectedIndex:0];
    
    /* 定位到最后一行 孟磊 2013年9月17日*/
    [friendController addFriendIntoList:friend];
}

/*!
 @method goFriendListAndJumptoNew
 @abstract 跳转到车友列表界面，并定位到新添加车友
 @discussion 跳转到车友列表界面，并定位到新添加车友
 @param name 名称
 @result 无
 */
-(void)goFriendListAndJumptoNew:(NSString *)name
{
    [self setSelectedIndex:0];
    [friendController JumptoNew:name];
}

/*!
 @method goFriendList
 @abstract 跳转到朋友列表，可不带等待框
 @discussion 跳转到朋友列表，可不带等待框
 @result 无
 */
-(void)goFriendList:(BOOL)bShowHUD
{
    /* 刷新朋友列表 孟磊 2013年9月10日*/
    [self setSelectedIndex:0];
    App *app = [App getInstance];
    if (app.mUserData.mType != USER_LOGIN_DEMO) {
        [friendController syncFriendList:YES];
    }
    else
    {
        [friendController demoDisplayFriendList];
    }
}

/*!
 @method goSelfDetail
 @abstract 为了在显示本机详情时隐藏tabbar,实现goFriendDetail方法提供给FriendListViewController
 @discussion 为了在显示本机详情时隐藏tabbar,实现goFriendDetail方法提供给FriendListViewController
 @result 无
 */
- (void)goSelfDetail:(NSMutableArray *) frienddata index:(NSInteger)index
{
    FriendsData *data = [frienddata objectAtIndex:index];
   
    SelfDetailViewController *selfDetailViewController=[[SelfDetailViewController alloc]init];
    [selfDetailViewController setFriendData:data];
    [selfDetailViewController setSex:MAN];
    
    [self.navigationController pushViewController:selfDetailViewController animated:YES];
    
    [selfDetailViewController release];
}

/*!
 @method goSelfDetail
 @abstract 为了在显示好友详情时隐藏tabbar,实现goFriendDetail方法提供给FriendListViewController
 @discussion 为了在显示好友详情时隐藏tabbar,实现goFriendDetail方法提供给FriendListViewController
 @result 无
 */
- (void)goFriendDetail:(NSMutableArray *) frienddata index:(NSInteger)index
{
    FriendsData *data = [frienddata objectAtIndex:index];
    FriendDetailViewController *friendDetailViewController=[[FriendDetailViewController alloc]init];
    /*设置车友详情的根控制器，用于控制加入黑名单后跳转到车友列表 孟磊 2013年9月23日*/
    friendDetailViewController.rootController = self;
    
    [friendDetailViewController setFriendData:data];
    [self.navigationController pushViewController:friendDetailViewController animated:YES];
    

    [friendDetailViewController release];
}
/*!
 @method showFriendList
 @abstract UI界面设置
 @discussion UI界面设置
 @result 无
 */
- (void)showFriendList {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
/*!
 @method showBuildinTabBar
 @abstract UI界面设置
 @discussion UI界面设置
 @result 无
 */
- (void)showBuildinTabBar {
    
    NSLog(@"调用showBuildinTabBar");
//    [mTabBar setHidden:NO];
    
}
#pragma mark -
#pragma mark UITabBarControllerDelegate
/*!
 @method tabBarController
 @abstract UI界面设置
 @discussion UI界面设置
 @result 无
 */
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if (!mSelectFlag) {
        return NO;
    }
    else
    {
        return YES;
    }
}

@end
