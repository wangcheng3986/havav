/*!
 @header NISetPWDDelegate.h
 @abstract 用户设置密码代理
 @author mengyue
 @version 1.00 2014-7-3 Creation
 */

#import <Foundation/Foundation.h>
/*!
 @protocol NISetPWDDelegate
 @abstract  代理类
 @discussion 用户设置密码代理
 */
@protocol NISetPWDDelegate <NSObject>
/*!
 @method onSetPWDResult:code:errorMsg:
 @abstract 回调函数
 @discussion 用户设置密码成功后回调
 @param result 请求返回的信息字典
 @param code 错误码
 @param errorMsg 错误信息
 @result 无
 */
- (void)onSetPWDResult:(NSString *)result code:(int)code errorMsg:(NSString *)errorMsg;
@end
