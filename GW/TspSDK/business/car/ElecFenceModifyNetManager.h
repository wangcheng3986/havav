/*!
 @header ElecFenceModifyNetManager.h
 @abstract 电子围栏修改网络管理类
 @author wangqiwei
 @version 1.00 2014/9/1 Create
 */
#import "NIApplicationBase.h"
#import "ElecFenceModifyNetManagerDelegate.h"

@interface ElecFenceModifyNetManager : NIApplicationBase
{
    id<ElecFenceModifyNetManagerDelegate>    mDelegate;
}
/*!
 @method modifyElecRequest:
 @abstract 创建网路请求
 @discussion 创建电子围栏修改的网络请求URL
 @param eleclist 电子围栏列表
 @result 无
 */
- (void)modifyElecRequest:(NSArray *)eleclist;

/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求
 @discussion 发送异步网络请求（业务层）
 @param delegate 代理函数
 @result 无
 */

- (void)sendRequestWithAsync:(id<ElecFenceModifyNetManagerDelegate>)delegate;
@end
