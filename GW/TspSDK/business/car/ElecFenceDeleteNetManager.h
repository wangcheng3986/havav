/*!
 @header ElecFenceDeleteNetManager.h
 @abstract 电子围栏删除网络管理类
 @author wangqiwei
 @version 1.00 2014/9/1 Create
 */
#import "NIApplicationBase.h"
#import "ElecFenceDeleteNetManagerDelegate.h"
/*!
 @class ElecFenceDeleteNetManager
 @abstract 电子围栏删除网络管理类
 */
@interface ElecFenceDeleteNetManager : NIApplicationBase
{
     id<ElecFenceDeleteNetManagerDelegate>         mDelegate;
}
/*!
 @method deleteRequest:
 @abstract 创建网路请求
 @discussion 创建电子围栏删除的网络请求URL
 @param elecIDlist 电子围栏列表
 @result 无
 */
- (void)deleteRequest:(NSArray *)elecIDlist;

/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求
 @discussion 发送异步网络请求（业务层）
 @param delegate 代理函数
 @result 无
 */

- (void)sendRequestWithAsync:(id<ElecFenceDeleteNetManagerDelegate>)delegate;
@end
