/*!
 @header NICreateBlack.h
 @abstract 黑名单业务网络请求回调代理函数
 @author mengy
 @version 1.00 14-4-1 Creation
 */

#import <Foundation/Foundation.h>
/*!
 @protocol NICreateBlackDelegate
 @abstract 网络请求成功后回调
 @discussion 黑名单业务的网络回调代理类
 */
@protocol NICreateBlackDelegate <NSObject>
/*!
 @method onRescueResult:code:errorMsg:
 @abstract 回调函数
 @discussion 添加黑名单成功后回调
 @param result 请求返回的信息字典
 @param code 错误码
 @param errorMsg 错误信息
 @result 无
 */
- (void)onCreateResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg;
@end
