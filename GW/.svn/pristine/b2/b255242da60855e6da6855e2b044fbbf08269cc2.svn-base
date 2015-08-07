/*!
 @header ElecFenceAddNetManager.h
 @abstract 电子围栏添加网络管理类
 @author wangqiwei
 @version 1.00 2014/9/1 Create
 */
#import "NIApplicationBase.h"
#import "ElecFenceAddNetManagerDelegate.h"
/*!
 @class ElecFenceAddNetManager
 @abstract 电子围栏添加网络管理类
 */
@interface ElecFenceAddNetManager : NIApplicationBase
{
    id<ElecFenceAddNetManagerDelegate>         mDelegate;
}
/*!
 @method createRequest:
 @abstract 创建网路请求
 @discussion 创建电子围栏添加的网络请求URL
 @param vin 车架号
 @param name 名称
 @param valid 是否可用
 @param lon 经度
 @param lat 纬度
 @param radius 半径
 @param adress 地址
 @result 无
 */
- (void)createRequest:(NSString *)vin
                 name:(NSString *)name
                valid:(NSString *)valid
                  lon:(double)lon
                  lat:(double)lat
               radius:(int)radius
               adress:(NSString *)adress;

/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求
 @discussion 发送异步网络请求（业务层）
 @param delegate 代理函数
 @result 无
 */
- (void)sendRequestWithAsync:(id<ElecFenceAddNetManagerDelegate>)delegate;
@end
