/*!
 @header vehicleControlNetManager.h
 @abstract 车辆控制网络管理类
 @author wangqiwei
 @version 1.00 2014/9/1 Create
 */

#import "NIApplicationBase.h"
#import "vehicleControlNetManagerDelegate.h"
/*!
 @class VehicleControlNetManager
 @abstract 车辆控制网络管理类
 */
@interface VehicleControlNetManager : NIApplicationBase
{
    id<VehicleControlNetManagerDelegate>         mDelegate;
}
/*!
 @method createRequest:cmdCode:pwd:duration:temperature:
 @abstract 创建网路请求
 @discussion 创建车辆远程控制的网络请求URL
 @param vin 车架号
 @param cmdCode 遥控指令
 @param pwd 安防密码
 @param duration 时间
 @param temperature 温度
 @result 无
 */
- (void)createRequest:(NSString *)vin
              cmdCode:(NSString *)cmdCode
                  pwd:(NSString *)pwd
             duration:(int)duration
          temperature:(int)temperature;

/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求
 @discussion 发送异步网络请求（业务层）
 @param delegate 代理函数
 @result 无
 */
- (void)sendRequestWithAsync:(id<VehicleControlNetManagerDelegate>)delegate;


@end
