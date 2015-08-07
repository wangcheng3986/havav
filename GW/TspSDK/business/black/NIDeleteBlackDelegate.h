/*!
 @header NIDeleteBlackDelegate.h
 @abstract 网络请求删除黑名单代理
 @author mengy
 @version 1.00 14-4-2 Creation
 */
#import <Foundation/Foundation.h>
/*!
 @protocol NIDeleteBlackDelegate
 @abstract  网络请求成功后回调
 @discussion 删除黑名单成功后回调
 */
@protocol NIDeleteBlackDelegate <NSObject>
/*!
 @method onDeleteBlackResult:code:errorMsg:
 @abstract 回调函数
 @discussion 删除黑名单成功后回调
 @param result 请求返回的信息字典
 @param code 错误码
 @param errorMsg 错误信息
 @result 无
 */
- (void)onDeleteBlackResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg;
@end
