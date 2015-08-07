/*!
 @header NINotificationDeleteDelegate.h
 @abstract 消息删除
 @author wangqiwei
 @version 1.00 2013-9-3 Creation
 */

#import <Foundation/Foundation.h>
/*!
 @protocol NIGetNotificationsListDelegate
 @abstract  网络请求代理类
 @discussion 消息删除请求代理
 */
@protocol NINotificationDeleteDelegate <NSObject>
/*!
 @method onDeleteNotificationResult:code:errorMsg:
 @abstract 回调函数
 @discussion 消息删除成功后回调
 @param result 请求返回的信息字典
 @param code 错误码
 @param errorMsg 错误信息
 @result 无
 */
- (void)onDeleteNotificationResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg;
@end
