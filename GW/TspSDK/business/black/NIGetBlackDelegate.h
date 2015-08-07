/*!
 @header NIGetBlackDelegate.h
 @abstract 获取黑名单列表代理类
 @author mengy
 @version 1.00 14-4-2 Creation
 */
#import <Foundation/Foundation.h>
/*!
 @protocol NIGetBlackDelegate
 @abstract  网络请求成功后回调
 @discussion 获取黑名单列表成功后回调
 */
@protocol NIGetBlackDelegate <NSObject>
/*!
 @method onGetBlackResult:code:errorMsg:
 @abstract 回调函数
 @discussion 获取黑名单列表成功后回调
 @param result 请求返回的信息字典
 @param code 错误码
 @param errorMsg 错误信息
 @result 无
 */
- (void)onGetBlackResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg;
@end
