/*!
 @header NIGetBlack.h
 @abstract 获取黑名单列表网络请求管理
 @author mengy
 @version 1.00 14-4-2 Creation
 */

#import <Foundation/Foundation.h>
#import "NIApplicationBase.h"
#import "NIGetBlackDelegate.h"
/*!
 @class NIGetBlack
 @abstract 获取黑名单列表网络管理类
 */
@interface NIGetBlack : NIApplicationBase
{
    id<NIGetBlackDelegate>         mDelegate;
}
/*!
 @method createRequest
 @abstract 创建网路请求
 @discussion 创建请求黑名单的网络请求URL（黑名单业务层）
 @result 无
 */
- (void)createRequest;
/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求（黑名单业务层）
 @discussion 发送请求黑名单列表异步网络请求
 @param delegate 代理函数
 @result 无
 */
- (void)sendRequestWithAsync:(id<NIGetBlackDelegate>)delegate;
/*!
 @method getMpMessage
 @abstract 获取信息
 @discussion 获取请求列表的黑名单信息的url字符串
 @result 请求字符串
 */
- (NSString *)getMpMessage;
@end
