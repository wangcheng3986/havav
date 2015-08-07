/*!
 @header NIFeedBack.h
 @abstract 版本检测
 @author wangqiwei
 @version 1.00 2013-5-30 Creation
 */

// Get profile
// the fname = GW.C.CRUD.APP_PROFILE.GET
// p = "id" : "5199b3815c9388ea0da26eed"
//

#import <Foundation/Foundation.h>
#import "NIApplicationBase.h"
#import "NIGetProfileDelegate.h"
/*!
 @class NIGetProfileApp
 @abstract 版本检测网络管理类
*/
@interface NIGetProfileApp : NIApplicationBase
{
    id<NIGetProfileDelegate>         mDelegate;
}
/*!
 @method createRequest:idValue:
 @abstract 创建网路请求
 @discussion 版本检测网络请求URL
 @param idValue 协议固定值:1
 @result 无
 */
- (void)createRequest:(int) idValue;
/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求
 @discussion 版本检测异步网络请求
 @param delegate 代理函数
 @result 无
 */
- (void)sendRequestWithAsync:(id<NIGetProfileDelegate>)delegate;
/*!
 @method getMpMessage
 @abstract 获取信息
 @discussion 版本检测的url字符串
 @result 请求字符串
 */
- (NSString *)getMpMessage;
@end
