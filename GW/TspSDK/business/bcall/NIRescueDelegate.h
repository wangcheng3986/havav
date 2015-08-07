/*!
 @header NIRescueDelegate.h
 @abstract BCall业务网络请求回调代理函数
 @author wangqiwei
 @version 1.00 13-6-7 Creation
 */
#import <Foundation/Foundation.h>
/*!
 @protocol NIRescueDelegate
 @abstract BCall业务的网络回调代理类
 @discussion 网络请求成功后回调
 */
@protocol NIRescueDelegate <NSObject>
/*!
 @method onRescueResult:code:errorMsg:
 @abstract 回调函数
 @discussion BCall业务的网络回调函数
 @param result 请求返回的信息字典
 @param code 错误码
 @param errorMsg 错误信息
 @result 无
 */
- (void)onRescueResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg;
@end
