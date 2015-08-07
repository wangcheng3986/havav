/*!
 @header NIRequestLocation.h
 @abstract 获取车友位置功能网络管理（位置请求）
 @author wlq
 @version 1.00 2013-5-30 Creation
*/

#import <Foundation/Foundation.h>
#import "NIApplicationBase.h"
#import "NIRequestLocationDelegate.h"
/*!
 @class NIGetContactsList
 @abstract 获取车友位置功能网络管理类
 */
@interface NIRequestLocation : NIApplicationBase
{
    id<NIRequestLocationDelegate>         mDelegate;
}
/*!
 @method createRequest:rqDesc:rpUserId:s2c:
 @abstract 创建网路请求
 @discussion 创建请求车友列表的网络请求URL（车友业务层）
 @param rqSrc 来源
 @param rqDesc 内容
 @param rpUserId 车友userid
 @param s2c 位置发送到车机
 @result 无
 */
- (void)createRequest:(NSString *) rqSrc
               rqDesc:(NSString *)rqDesc
                rpUserId:(NSString *)rpUserId
                  s2c:(NSString *)s2c
;

/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求（车友业务层）
 @discussion 发送车友位置请求的异步网络请求
 @param delegate 代理函数
 @result 无
 */
- (void)sendRequestWithAsync:(id<NIRequestLocationDelegate>)delegate;

@end


