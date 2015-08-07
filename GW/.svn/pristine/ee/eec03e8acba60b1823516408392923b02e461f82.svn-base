/*!
 @header NILogout.h
 @abstract 用户登出网络管理
 @author wangqiwei
 @version 1.00 2013-06-03 Creation
 */

#import <Foundation/Foundation.h>
#import "NIApplicationBase.h"
#import "NILogoutDelegate.h"
/*!
 @class NILogin
 @abstract 用户登出网络管理类
 */
@interface NILogout : NIApplicationBase
{
    id<NILogoutDelegate>         mDelegate;
}
/*!
 @method createRequest
 @abstract 创建网路请求（登入登出业务层）
 @discussion 创建用户登出的网络请求URL
 @result 无
 */
- (void)createRequest;
/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求（登入登出业务层）
 @discussion 发送用户登出的异步网络请求
 @param delegate 代理函数
 @result 无
 */
- (void)sendRequestWithAsync:(id<NILogoutDelegate>)delegate;

@end