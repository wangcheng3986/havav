/*!
 @header BaseNavigationController.m
 @abstract 继承UINavigationController
 @author kexin
 @version 1.00 12-9-4 Creation
 */

#import "App.h"
#import "BaseNavigationController.h"
/*!
 @class
 @abstract 继承UINavigationController，要进行UINavigationController的统一处理
 */
@interface BaseNavigationController (Private)

- (void)initPrivate;

@end

@implementation BaseNavigationController
/*!
 @method initWithCoder
 @abstract 重写UIControl初始化方法
 @discussion 重写UIControl初始化方法，
 @param aDecoder
 @result self
 */
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        [self initPrivate];
    }
    return self;
}

/*!
 @method initWithRootViewController
 @abstract 重写UIControl初始化方法
 @discussion 重写UIControl初始化方法，
 @param rootViewController
 @result self
 */
- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if(self)
    {
        [self initPrivate];
    }
    return self;
}

/*!
 @method initWithNibName：bundle:
 @abstract 重写UIControl初始化方法
 @discussion 重写UIControl初始化方法，
 @param nibNameOrNil
 @param nibBundleOrNil
 @result self
 */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [self initPrivate];
    }
    return self;
}

- (void)initPrivate
{
    
}

- (void)dealloc
{
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

/*!
 @method navigationBar: shouldPushItem:
 @abstract 重写navigationBar: shouldPushItem:方法
 @discussion 移动导航栏按钮位置
 @param navigationBar
 @param item
 @result yes
 */
- (BOOL) navigationBar:(UINavigationBar *)navigationBar shouldPushItem:(UINavigationItem *)item
{
    if (item.rightBarButtonItems.count>0) {
		UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
		if([App getVersion]<IOS_VER_7) {
			space.width = -5.0;
		} else {
			space.width = -16.0;
		}
		item.rightBarButtonItems = [@[space] arrayByAddingObjectsFromArray:item.rightBarButtonItems];
	}
    if (item.leftBarButtonItems.count>0) {
		UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
		if([App getVersion]<IOS_VER_7) {
			space.width = -5.0;
		} else {
			space.width = -16.0;
		}
		item.leftBarButtonItems = [@[space] arrayByAddingObjectsFromArray:item.leftBarButtonItems];
	}
    return YES;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



@end
