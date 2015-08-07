/*!
 @header NISetPWD.h
 @abstract 用户设置密码
 @author mengyue
 @version 1.00 2014-7-3 Creation
 */

#import "NIApplicationBase.h"
#import <Foundation/Foundation.h>
#import "NISetPWDDelegate.h"
/*!
 @class NISetPWD
 @abstract 用户设置密码网络管理类
 */
@interface NISetPWD : NIApplicationBase
{
    id<NISetPWDDelegate>         mDelegate;
}
/*!
 @method createRequest:loginName:smsCode:
 @abstract 创建网路请求
 @discussion 用户设置密码网络请求URL
 @param loginName 登入名
 @param smsCode 认证码
 @result 无
 */
- (void)createRequest:(NSString *)pwd loginName:(NSString *)loginName smsCode:(NSString *)smsCode;
/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求
 @discussion 用户设置密码异步网络请求
 @param delegate 代理函数
 @result 无
 */
- (void)sendRequestWithAsync:(id<NISetPWDDelegate>)delegate;
@end
