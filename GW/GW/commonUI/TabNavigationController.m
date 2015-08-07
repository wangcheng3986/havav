/*!
 @header TabNavigationController.m
 @abstract 继承UINavigationController
 @author kexin
 @version 1.00 12-7-25 Creation
 */

#import "TabNavigationController.h"
/*!
 @class
 @abstract 继承UINavigationController，重写系统方法
 */
@interface TabNavigationController ()

@end

@implementation TabNavigationController
/*!
 @method initWithNibName: bundle:
 @abstract 重写init方法
 @discussion 重写init方法
 @param
 @result self
 */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
    }
    return self;
}

/*!
 @method viewDidLoad
 @abstract 重写viewDidLoad方法，
 @discussion 隐藏navigationBar，设置navigationBar UIBarStyleBlack
 @param 无
 @result 无
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.navigationBarHidden = YES;
    self.navigationBar.barStyle = UIBarStyleBlack;
    
    if([[[UIDevice currentDevice]systemVersion]floatValue] < 5.0)
    {
        self.delegate = self;
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

/*!
 @method shouldAutorotateToInterfaceOrientation
 @abstract 重写shouldAutorotateToInterfaceOrientation方法，
 @discussion
 @param interfaceOrientation
 @result
 */
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

/*!
 @method navigationController：didShowViewController: animated:
 @abstract 重写navigationController：didShowViewController: animated:方法，
 @discussion 在显示viewController的实际处理业务
 @param navigationController
 @param viewController
 @param animated 动画
 @result 无
 */
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(mLastDidController != nil)
    {  
        [mLastDidController viewDidDisappear:animated]; 
        [viewController viewDidAppear:animated];
    }  
    mLastDidController = viewController;
}

/*!
 @method navigationController: willShowViewController: animated:
 @abstract 重写navigationController: willShowViewController: animated:方法，
 @discussion 在显示viewController的实际处理业务
 @param navigationController
 @param viewController
 @param animated 动画
 @result 无
 */
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(mLastWillController != nil)   
    {  
        [mLastWillController viewWillDisappear:animated];  
        [viewController viewWillAppear:animated];
    }  
    mLastWillController = viewController;
}

@end
