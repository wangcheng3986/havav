/*!
 @header vehicleDiagnosisNetManager.h
 @abstract 车辆诊断网络管理类
 @author wangqiwei
 @version 1.00 2014/9/1 Create
 */
#import "NIApplicationBase.h"
#import "VehicleDiagnosisNetManagerDelegate.h"
/*!
 @class VehicleDiagnosisNetManager
 @abstract 车辆诊断网络管理类
 */
@interface VehicleDiagnosisNetManager : NIApplicationBase
{
    id<VehicleDiagnosisNetManagerDelegate>         mDelegate;
}
/*!
 @method createRequest:
 @abstract 创建网路请求
 @discussion 创建车辆诊断的网络请求URL
 @param vin 车架号
 @result 无
 */
- (void)createRequest:(NSString *)vin;

/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求
 @discussion 发送异步网络请求（业务层）
 @param delegate 代理函数
 @result 无
 */
- (void)sendRequestWithAsync:(id<VehicleDiagnosisNetManagerDelegate>)delegate;
@end
