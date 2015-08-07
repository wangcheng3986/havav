/*!
 @header NIGetNotificationsList.h
 @abstract 消息轮询
 @author wangqiwei
 @version 1.00 2013-5-30 Creation
*/

#import <Foundation/Foundation.h>
#import "NIApplicationBase.h"
#import "NIGetNotificationsListDelegate.h"
/*!
 @class NIGetNotificationsList
 @abstract 消息轮询网络管理类
*/
@interface NIGetNotificationsList : NIApplicationBase
{
    id<NIGetNotificationsListDelegate>         mDelegate;
}
/*!
 @method createRequest:targetId:isNeedSrc:
 @abstract 创建网路请求
 @discussion 消息轮询网络请求URL
 @param lastReqTime 最后一次请求时间
 @param targetId 目前ID
 @param isNeedSrc 预留字段
 @result 无
 */
- (void)createRequest:(long long) lastReqTime
             targetId:(NSString *) targetId
            isNeedSrc:(NSString *) isNeedSrc;
/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求
 @discussion 消息轮询异步网络请求
 @param delegate 代理函数
 @result 无
 */
- (void)sendRequestWithAsync:(id<NIGetNotificationsListDelegate>)delegate;
/*!
 @method getMpMessage
 @abstract 获取信息
 @discussion 消息轮询的url字符串
 @result 请求字符串
 */
- (NSString *)getMpMessage;
@end
