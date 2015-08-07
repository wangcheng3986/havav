/*!
 @header TabSubViewController.h
 @abstract 继承BaseViewController
 @author kexin
 @version 1.00 12-7-25 Creation
 */

#import "TabSubViewController.h"
#import "TabNavigationController.h"
/*!
 @class
 @abstract 继承BaseViewController，重写系统方法
 */
@interface TabSubViewController ()

@end

@implementation TabSubViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {

    }
    return self;
}

#pragma mark - UIViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
	
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

/*!
 @method viewWillAppear:
 @abstract 重写viewWillAppear方法，
 @discussion TabNavigationController.viewControllers>1时，显示Tab的导航栏。
 @param animated 动画
 @result 无
 */
- (void)viewWillAppear:(BOOL)animated
{
    if([self isCheckNavigateBar] &&
       [self.navigationController.viewControllers count] > 1)
    {
        [[App getInstance] hideBar];
        self.navigationController.navigationBarHidden = NO;
    }
    [super viewWillAppear:animated];
}

/*!
 @method viewDidAppear:
 @abstract 重写viewDidAppear方法，
 @discussion TabNavigationController.viewControllers<=1时，显示navgation的导航栏。
 @param animated 动画
 @result 无
 */
- (void)viewDidAppear:(BOOL)animated
{
    if([self isCheckNavigateBar] &&
       [self.navigationController.viewControllers count] <= 1)
    {
        [[App getInstance] showBar];
        self.navigationController.navigationBarHidden = YES;
    }
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Business Logic
/*!
 @method isCheckNavigateBar
 @abstract 判断是否选择TabNavigationController
 @discussion 判断是否选择TabNavigationController
 @param 无
 @result BOOL
 */
- (BOOL)isCheckNavigateBar
{
    if([self.navigationController isKindOfClass:TabNavigationController.class])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
@end
