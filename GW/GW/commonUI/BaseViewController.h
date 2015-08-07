
/*!
 @header BaseViewController.h
 @abstract 继承UIViewController
 @author kexin
 @version 1.00 12-5-31 Creation
 */

#import <UIKit/UIKit.h>

#import "Resources.h"
#import "App.h"
#define DIALOG_BASE     0x00
#define DIALOG_OK       DIALOG_BASE + 1
/*!
 @class
 @abstract 继承UIViewController，公共方法
 */
@interface BaseViewController : UIViewController<UIGestureRecognizerDelegate, UIAlertViewDelegate>
{
    UIAlertView     *mAlertWait;
    int     mID;
}

@property(readonly)int mID;
- (void)dealloc;
/*!
 @method setNextBackTitle
 @abstract 设置下个界面返回按钮title
 @discussion 设置下个界面返回按钮title
 @param title
 @result 无
 */
- (void)setNextBackTitle:(NSString*)title;

/*!
 @method setNextBackImage
 @abstract 设置下个界面返回按钮背景图片
 @discussion 设置下个界面返回按钮背景图片
 @param image
 @result 无
 */
- (void)setNextBackImage:(UIImage*)image;

/*!
 @method showWaitDialog
 @abstract 显示等待框
 @discussion 显示等待框
 @param title
 @result 无
 */
- (void)showWaitDialog:(NSString*)title;

/*!
 @method closeWaitDialog
 @abstract 关闭等待框
 @discussion 关闭等待框
 @param title
 @result 无
 */
- (void)closeWaitDialog;

/*!
 @method showDialog: title: buttonText: delegate:
 @abstract 显示提示框
 @discussion 显示提示框
 @param key tag值;title;buttonText;delegate
 @result 无
 */
- (void)showDialog:(int)key title:(NSString*)title buttonText:(NSString*)btnText delegate:(id<UIAlertViewDelegate>)delegate;

/*!
 @method showDialog: buttonText:
 @abstract 显示提示框
 @discussion 显示提示框
 @param title;buttonText
 @result 无
 */
- (void)showDialog:(NSString*)title buttonText:(NSString*)btnText;

/*!
 @method showDialog: buttonText: delegate:
 @abstract 显示提示框
 @discussion 显示提示框
 @param title;buttonText;delegate
 @result 无
 */
- (void)showDialog:(NSString*)title buttonText:(NSString*)btnText delegate:(id<UIAlertViewDelegate>)delegate;


/*!
 @method showDialog: title: btn1: btn2: delegate:
 @abstract 显示提示框
 @discussion 显示提示框
 @param title;btn1;btn1;delegate
 @result 无
 */
- (void)showDialog:(int)key title:(NSString*)title btn1:(NSString*)btn1 btn2:(NSString*)btn2 delegate:(id<UIAlertViewDelegate>)delegate;

@end
