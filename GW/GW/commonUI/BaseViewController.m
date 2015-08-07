/*!
 @header BaseViewController.m
 @abstract 继承UIViewController
 @author kexin
 @version 1.00 12-5-31 Creation
 */

#import "BaseViewController.h"
#import "ViewID.h"
/*!
 @class
 @abstract 继承UIViewController，公共方法
 */
@interface BaseViewController ()

@end

@implementation BaseViewController

@synthesize mID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        mID = ID_CONTROLLER_NONE;
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
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

- (void)dismissModalViewControllerAnimated:(BOOL)animated
{
    [[App getInstance] setNav:nil];
    
    //modify by wangqiwei for new API at 2014.6.15
    [self dismissViewControllerAnimated:animated
                             completion:^(void){
                                 NSLog(@"______>>>>视图结束");
                             }];
    //[super dismissModalViewControllerAnimated:animated];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if([App getSystemVer] < IOS_VER_5){
        UIView *titleView = [[[NSBundle mainBundle] loadNibNamed:@"title" owner:self options:nil] lastObject];
        UILabel *title = (UILabel*)[titleView viewWithTag:1];
        title.text = self.title;
        self.navigationItem.titleView = titleView;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
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

/*!
 @method setNextBackTitle
 @abstract 设置下个界面返回按钮title
 @discussion 设置下个界面返回按钮title
 @param title
 @result 无
 */
- (void)setNextBackTitle:(NSString*)title
{
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:title
                                            style:UIBarButtonItemStylePlain 
                                            target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    [backButton release];
}

/*!
 @method setNextBackImage
 @abstract 设置下个界面返回按钮背景图片
 @discussion 设置下个界面返回按钮背景图片
 @param image
 @result 无
 */
- (void)setNextBackImage:(UIImage*)image
{
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] 
                                   initWithImage:image
                                   style:UIBarButtonItemStylePlain 
                                   target:nil action:nil];
    
    self.navigationItem.backBarButtonItem = backButton;
    [backButton release];
}

/*!
 @method showWaitDialog
 @abstract 显示等待框
 @discussion 显示等待框
 @param title
 @result 无
 */
- (void)showWaitDialog:(NSString*)title
{
    if(mAlertWait == nil)
    {
        mAlertWait = [[UIAlertView alloc]initWithTitle:title message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
        [[App getInstance] setSheet:mAlertWait];
        [mAlertWait show];
        
        UIActivityIndicatorView *wait = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        wait.center = CGPointMake(mAlertWait.bounds.size.width / 2, mAlertWait.bounds.size.height - 40);
        [wait startAnimating];
        [mAlertWait addSubview:wait];
        [wait release];
    }
}

/*!
 @method closeWaitDialog
 @abstract 关闭等待框
 @discussion 关闭等待框
 @param title
 @result 无
 */
- (void)closeWaitDialog
{
    if(mAlertWait)
    {
        [mAlertWait dismissWithClickedButtonIndex:0 animated:NO];
        [mAlertWait release];
        mAlertWait = nil;
        [[App getInstance] setSheet:nil];
    }
}

/*!
 @method showDialog: buttonText:
 @abstract 显示提示框
 @discussion 显示提示框
 @param title;buttonText
 @result 无
 */
- (void)showDialog:(NSString*)title buttonText:(NSString*)btnText;{
    [self showDialog:-1 title:title buttonText:btnText delegate:self];
    
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [[App getInstance] setSheet:nil];
}

/*!
 @method showDialog: title: buttonText: delegate:
 @abstract 显示提示框
 @discussion 显示提示框
 @param key tag值;title;buttonText;delegate
 @result 无
 */
- (void)showDialog:(int)key title:(NSString*)title buttonText:(NSString*)btnText delegate:(id<UIAlertViewDelegate>)delegate
{
    UIAlertView *alert = [[[UIAlertView alloc]initWithTitle:title message:nil delegate:delegate cancelButtonTitle:btnText otherButtonTitles:nil]autorelease];
    alert.tag = key;
    [[App getInstance] setSheet:alert];
    [alert show];
}


/*!
 @method showDialog: buttonText: delegate:
 @abstract 显示提示框
 @discussion 显示提示框
 @param title;buttonText;delegate
 @result 无
 */
- (void)showDialog:(NSString*)title buttonText:(NSString*)btnText delegate:(id<UIAlertViewDelegate>)delegate
{
    [self showDialog:-1 title:title buttonText:btnText delegate:delegate];
}

/*!
 @method showDialog: title: btn1: btn2: delegate:
 @abstract 显示提示框
 @discussion 显示提示框
 @param title;btn1;btn1;delegate
 @result 无
 */
- (void)showDialog:(int)key title:(NSString*)title btn1:(NSString*)btn1 btn2:(NSString*)btn2 delegate:(id<UIAlertViewDelegate>)delegate;
{
    UIAlertView *alert = [[[UIAlertView alloc]initWithTitle:title message:nil delegate:delegate cancelButtonTitle:btn1 otherButtonTitles:btn2,nil]autorelease];
    alert.tag = key;
    [[App getInstance] setSheet:alert];
    [alert show];
}


- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [[App getInstance] setSheet:nil];
}

#pragma mark -
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return NO;
}
@end
