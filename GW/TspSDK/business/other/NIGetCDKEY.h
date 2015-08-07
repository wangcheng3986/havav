/*!
 @header NIGetCDKEY.h
 @abstract 获取注册的认证码
 @author mengyue
 @version 1.00 2014-7-3 Creation
 */

#import "NIApplicationBase.h"
#import <Foundation/Foundation.h>
#import "NIGetCDKEYDelegate.h"
/*!
 @class NIGetCDKEY
 @abstract 获取注册的认证码网络管理类
 */
@interface NIGetCDKEY : NIApplicationBase
{
    id<NIGetCDKEYDelegate>         mDelegate;
}
/*!
 @method createRequest:dealType:
 @abstract 创建网路请求
 @discussion 获取注册的认证码网络请求URL
 @param loginName 登入名
 @param dealType 处理类型:(1:设置新密码2:修改密码)
 @result 无
 */
- (void)createRequest:(NSString *)loginName dealType:(NSString *)dealType;
/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求
 @discussion 获取注册的认证码异步网络请求
 @param delegate 代理函数
 @result 无
 */
- (void)sendRequestWithAsync:(id<NIGetCDKEYDelegate>)delegate;


@end
