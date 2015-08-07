/*!
 @header ElecFenceModifyNetManagerDelegate.h
 @abstract 电子围栏修改业务网络请求回调代理函数
 @author wangqiwei
 @version 1.00 13-6-7 Creation
 */
#import <Foundation/Foundation.h>
/*!
 @protocol ElecFenceModifyNetManagerDelegate
 @abstract 电子围栏修改业务的网络回调代理类
 @discussion 网络请求成功后回调
 */
@protocol ElecFenceModifyNetManagerDelegate <NSObject>
/*!
 @method onElecFenceModifyResult:
 @abstract 回调函数
 @discussion 电子围栏删除业务的网络回调函数
 @param result 请求返回的信息字典
 @param code 错误码
 @param errorMsg 错误信息
 @result 无
 */
- (void)onElecFenceModifyResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg;
@end
