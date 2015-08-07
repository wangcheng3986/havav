/*!
 @header vehicleControlNetManagerDelegate.h
 @abstract 远程控制业务网络请求回调代理函数
 @author wangqiwei
 @version 1.00 13-6-7 Creation
 */
#import <Foundation/Foundation.h>
/*!
 @protocol VehicleControlNetManagerDelegate
 @abstract 远程控制业务的网络回调代理类
 @discussion 网络请求成功后回调
 */
@protocol VehicleControlNetManagerDelegate <NSObject>
/*!
 @method onVehicleControlResult:
 @abstract 回调函数
 @discussion 远程控制业务的网络回调函数
 @param result 请求返回的信息字典
 @param code 错误码
 @param errorMsg 错误信息
 @result 无
 */
- (void)onVehicleControlResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg;
@end
