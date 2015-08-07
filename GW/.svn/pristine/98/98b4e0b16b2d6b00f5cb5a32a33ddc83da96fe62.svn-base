

/*!
 @header KeyboardListener.h
 @abstract 监听键盘的弹出和隐藏
 @author kexin
 @version 1.00 12-6-9 Creation
 */

#import <Foundation/Foundation.h>

#import "KeyboardDelegate.h"
/*!
 @class
 @abstract 监听键盘
 */
@interface KeyboardListener : NSObject
{
    UIView *mView;
    id<KeyboardDelegate> mDelegate;
    
    BOOL    mHasOpen;
}

/*!
 @method initWithView:
 @abstract 初始化
 @discussion 初始化
 @param view
 @result self
 */
- (id)initWithView:(UIView*)view;

/*!
 @method dealloc:
 @abstract 释放内存
 @discussion 释放内存
 @param 无
 @result 无
 */
- (void)dealloc;

/*!
 @method enable
 @abstract 设置键盘监听事件
 @discussion 设置键盘监听事件
 @param 无
 @result 无
 */
- (void)enable;

/*!
 @method disable
 @abstract 取消键盘监听事件
 @discussion 取消键盘监听事件
 @param 无
 @result 无
 */
- (void)disable;

/*!
 @method setDelegate:
 @abstract 设置代理
 @discussion 设置代理
 @param delegate
 @result 无
 */
- (void)setDelegate:(id<KeyboardDelegate>)delegate;

/*!
 @method keyboardWillShow:
 @abstract 键盘弹出时调用方法
 @discussion 改变view位置
 @param notification 键盘弹出通知（包括键盘高度等）
 @result 无
 */
- (void)keyboardWillShow:(NSNotification*)notification;

/*!
 @method keyboardWillHide:
 @abstract 键盘弹回时调用方法
 @discussion 改变view位置
 @param notification 键盘弹出通知
 @result 无
 */
- (void)keyboardWillHide:(NSNotification*)notification;

@end
