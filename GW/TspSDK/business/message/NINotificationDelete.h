/*!
 @header NINotificationDelete.h
 @abstract 消息删除
 @author wangqiwei
 @version 1.00 2013-5-30 Creation
*/
#import <Foundation/Foundation.h>
#import "NIApplicationBase.h"
#import "NINotificationDeleteDelegate.h"
/*!
 @class NINotificationDelete
 @abstract 消息删除网络管理类
*/
@interface NINotificationDelete : NIApplicationBase
{
    id<NINotificationDeleteDelegate>         mDelegate;
}
/*!
 @method createRequest:code:
 @abstract 创建网路请求
 @discussion 消息删除网络请求URL
 @param ntfyList 消息列表
 @param code 消息类型code
 @result 无
 */
- (void)createRequest:(NSMutableArray *)ntfyList code:(int)code;
/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求
 @discussion 消息删除异步网络请求
 @param delegate 代理函数
 @result 无
 */
- (void)sendRequestWithAsync:(id<NINotificationDeleteDelegate>)delegate;

@end