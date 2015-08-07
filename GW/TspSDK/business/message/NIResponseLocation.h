/*!
 @header NIResponseLocation.h
 @abstract 位置请求应答（同意或拒绝）
 @author wangqiwei
 @version 1.00 2013-5-30 Creation
*/


#import <Foundation/Foundation.h>
#import "NIApplicationBase.h"
#import "NIResponseLocationDelegate.h"
/*!
 @class NIGetNotificationsList
 @abstract 位置请求应答（同意或拒绝）
*/
@interface NIResponseLocation : NIApplicationBase
{
    id<NIResponseLocationDelegate>         mDelegate;
}
/*!
 @method createRequest:rpState:
 @abstract 创建网路请求
 @discussion 位置请求应答网络请求URL
 @param reqId 请求ID
 @param rpState 请求状态
 @result 无
 */
- (void)createRequest:(NSString *)reqId
              rpState:(int)rpState
;
/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求
 @discussion 位置请求应答异步网络请求
 @param delegate 代理函数
 @result 无
 */
- (void)sendRequestWithAsync:(id<NIResponseLocationDelegate>)delegate;

@end
