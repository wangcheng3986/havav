

/*!
 @header TabViewController.h
 @abstract 继承BaseViewController
 @author kexin
 @version 1.00 12-7-25 Creation
 */
#import "BaseViewController.h"

@class TabSubViewController;
@class TabNavigationController;
/*!
 @class
 @abstract 继承BaseViewController，重写系统方法
 */
@interface TabViewController : BaseViewController<UITabBarDelegate>
{
    IBOutlet UITabBar           *mTabBar;                   //TabBar Object
    NSMutableDictionary         *mNavigationList;           //NavigativeController List
    TabNavigationController     *mCurNavigationController;  //Current ViewController
    
    BOOL      mIsPrivateFirst;
    BOOL      mIsCommicFirst;
}

@property(readonly)TabNavigationController *mCurNavigationController;

/*!
 @method addSubViewController: item:
 @abstract 向navgation中添加TabSubViewController
 @discussion 向navgation中添加TabSubViewController
 @param controller 要添加的TabSubViewController
 @param item 要添加的TabSubViewController对应的UITabBarItem
 @result 无
 */
- (void)addSubViewController:(TabSubViewController*)controller item:(UITabBarItem*)item;

/*!
 @method setCurItem: item:
 @abstract 设置选中的item
 @discussion 设置选中的item
 @param item 选中的UITabBarItem
 @result 无
 */
- (void)setCurItem:(UITabBarItem*)item;

/*!
 @method getTopController
 @abstract 获取最顶层的Controller
 @discussion 获取最顶层的Controller
 @param 无
 @result BaseViewController 最顶层的Controller
 */
- (BaseViewController*)getTopController;

/*!
 @method getTopControllerId
 @abstract 获取最顶层的ControllerId
 @discussion 获取最顶层的ControllerId
 @param 无
 @result id 最顶层的ControllerId
 */
- (int)getTopControllerId;

@end
