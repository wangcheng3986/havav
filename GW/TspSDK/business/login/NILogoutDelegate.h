/*!
 @header NILoginDelegate.h
 @abstract 用户登出请求代理类
 @author wangqiwei
 @version 1.00 2013-5-30 Creation
 */
#import <Foundation/Foundation.h>
/*!
 @protocol NILoginDelegate
 @abstract  网络请求成功后回调
 @discussion 用户登出请求成功后回调
 */
@protocol NILogoutDelegate <NSObject>
/*!
 @method onLoginResult:code:errorMsg:
 @abstract 回调函数
 @discussion 用户登入请求成功后回调
 @param result 请求返回的信息字典
 @param code 错误码
 @param errorMsg 错误信息
 @result 无
 */
- (void)onLogoutResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg;
@end
