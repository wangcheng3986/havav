/*!
 @header NIGetCDKEYDelegate.h
 @abstract 获取注册的认证码代理
 @author mengyue
 @version 1.00 2014-7-3 Creation
 */

#import <Foundation/Foundation.h>
/*!
 @protocol NIGetCDKEYDelegate
 @abstract  代理类
 @discussion 获取注册的认证码代理
 */
@protocol NIGetCDKEYDelegate <NSObject>
/*!
 @method onGetCDKResult:code:errorMsg:
 @abstract 回调函数
 @discussion 获取注册的认证码成功后回调
 @param result 请求返回的信息字典
 @param code 错误码
 @param errorMsg 错误信息
 @result 无
 */
- (void)onGetCDKResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg;
@end
