/*!
 @header ElecFenceQueryNetManager.h
 @abstract 电子围栏查询网络管理类
 @author wangqiwei
 @version 1.00 2014/9/1 Create
 */
#import "NIApplicationBase.h"
#import "ElecFenceQueryNetManagerDelegate.h"
/*!
 @class ElecFenceQueryNetManager
 @abstract 电子围栏查询网络管理类
 */
@interface ElecFenceQueryNetManager : NIApplicationBase
{
    id<ElecFenceQueryNetManagerDelegate>         mDelegate;
}
/*!
 @method queryRequest:
 @abstract 创建网路请求
 @discussion 创建电子围栏查询的网络请求URL
 @param vin 车架号
 @result 无
 */
- (void)queryRequest:(NSString *)vin;

/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求
 @discussion 发送异步网络请求（业务层）
 @param delegate 代理函数
 @result 无
 */
- (void)sendRequestWithAsync:(id<ElecFenceQueryNetManagerDelegate>)delegate;
@end
