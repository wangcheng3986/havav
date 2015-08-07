//
//  TabViewController.m
//  TabTest
//
//  Created by kexin on 12-7-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TabViewController.h"

#import "TabSubViewController.h"
#import "TabNavigationController.h"

@interface TabViewController ()

@end

@implementation TabViewController

@synthesize mCurNavigationController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        mNavigationList = [[NSMutableDictionary alloc]initWithCapacity:0];
        mCurNavigationController = nil;
        mIsPrivateFirst = YES;
        mIsCommicFirst = YES;
    }
    return self;
}

- (void)dealloc
{
    [mNavigationList release];
    [super dealloc];
}

#pragma mark - UIViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
	mTabBar.delegate = self;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    //屏蔽该函数，用于防止从下侧弹出界面时出现的双层bar的问题
    //[[App getInstance]showBar];
    if(mCurNavigationController)
    {
        [mCurNavigationController.topViewController viewWillDisappear:animated];
    }

    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    if(mCurNavigationController)
    {
        [mCurNavigationController.topViewController viewDidDisappear:animated];
    }

    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Business Logic
/*!
 @method addSubViewController: item:
 @abstract 向navgation中添加TabSubViewController
 @discussion 向navgation中添加TabSubViewController
 @param controller 要添加的TabSubViewController
 @param item 要添加的TabSubViewController对应的UITabBarItem
 @result 无
 */
- (void)addSubViewController:(TabSubViewController*)controller item:(UITabBarItem*)item
{
    if(controller && item)
    {
        TabNavigationController *navigation = [[TabNavigationController alloc]initWithRootViewController:controller];
        
        [mNavigationList setObject:navigation forKey:item.title];
        
        CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - mTabBar.frame.size.height);
        
        navigation.view.frame = rect;
        controller.view.frame = rect;
        
        [navigation release];
    }
}

/*!
 @method setCurItem: item:
 @abstract 设置选中的item
 @discussion 设置选中的item
 @param item 选中的UITabBarItem
 @result 无
 */
- (void)setCurItem:(UITabBarItem*)item
{
    if(item)
    {
        if(mTabBar.selectedItem == nil)
        {
            mTabBar.selectedItem = item;
        }
        
        TabNavigationController *navigation = [mNavigationList objectForKey:item.title];
        BOOL mIsFirst = NO;
        if ([item.title isEqualToString:@"Private"]) {
            mIsFirst = mIsPrivateFirst;
        }
        else if([item.title isEqualToString:@"Commercial"])
        {
            mIsFirst = mIsCommicFirst;
        }
        if(navigation)
        {
            if(!mIsFirst)
            {
                if(mCurNavigationController)
                {
                    [mCurNavigationController.topViewController viewWillDisappear:NO];
                    [mCurNavigationController.view removeFromSuperview];
                }
                [navigation.topViewController viewWillAppear:NO];
            }
            
            CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - mTabBar.frame.size.height);
            navigation.view.frame = rect;
            [self.view addSubview:navigation.view];
            
            mCurNavigationController = navigation;
            if(!mIsFirst)
            {
                if(mCurNavigationController)
                {
                    [mCurNavigationController.topViewController viewDidDisappear:NO];
                }
                [navigation.topViewController viewDidAppear:NO];
            }
        }
        if ([item.title isEqualToString:@"Private"]) {
            mIsPrivateFirst = NO;
        }
        else if([item.title isEqualToString:@"Commercial"])
        {
            mIsCommicFirst = NO;
        }
    }
}

/*!
 @method tabBar：didSelectItem:
 @abstract 重写tabBar：didSelectItem:方法
 @discussion 在选中某个Item时调用setCurItem方法
 @param tabBar 操作的tabBar
 @param didSelectItem 选择的Item
 @result 无
 */
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    [self setCurItem:item];
}

/*!
 @method getTopController
 @abstract 获取最顶层的Controller
 @discussion 获取最顶层的Controller
 @param 无
 @result BaseViewController 最顶层的Controller
 */
- (BaseViewController*)getTopController
{
    if(mCurNavigationController)
    {
        return (BaseViewController*)mCurNavigationController.topViewController;
    }
    return nil;
}

/*!
 @method getTopControllerId
 @abstract 获取最顶层的ControllerId
 @discussion 获取最顶层的ControllerId
 @param 无
 @result id 最顶层的ControllerId
 */
- (int)getTopControllerId
{
    int controllerId = -1;
    if(mCurNavigationController)
    {
        BaseViewController * controller = (BaseViewController*)mCurNavigationController.topViewController;
        if(controller.presentedViewController != nil)
        {
            UINavigationController *navi = (UINavigationController*)controller.presentedViewController;
            BaseViewController *subController =(BaseViewController*)navi.topViewController;
            controllerId = subController.mID;
        }
        else
        {
            controllerId = controller.mID; 
        }
    }
    return controllerId;
}


@end
