/*!
 @header NILogin.h
 @abstract 用户登入网络管理
 @author wangqiwei
 @version 1.00 2013-06-03 Creation
 */

#import <Foundation/Foundation.h>
#import "NIApplicationBase.h"
#import "NILoginDelegate.h"
#import "App.h"
/*!
 @class NILogin
 @abstract 用户登入网络管理类
 */
@interface NILogin : NIApplicationBase
{
    id<NILoginDelegate>         mDelegate;
}
/*!
 @method createRequest
 @abstract 创建网路请求（登入登出业务层）
 @discussion 创建用户登入的网络请求URL
 @param loginInfo 登入信息
 @result 无
 */
- (void)createRequest:(NSDictionary *) loginInfo;
/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求（登入登出业务层）
 @discussion 发送用户登入的异步网络请求
 @param delegate 代理函数
 @result 无
 */
- (void)sendRequestWithAsync:(id<NILoginDelegate>)delegate;

@end