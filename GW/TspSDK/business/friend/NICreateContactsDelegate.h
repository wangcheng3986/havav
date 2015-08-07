/*!
 @header NICreateContactsDelegate.h
 @abstract 车友业务网络请求回调代理函数
 @author wangqiwei
 @version 1.00 13-6-4 Creation
 */
#import <Foundation/Foundation.h>
/*!
 @protocol NICreateContactsDelegate
 @abstract 网络请求成功后回调
 @discussion 车友业务的网络回调代理类
 */
@protocol NICreateContactsDelegate <NSObject>
/*!
 @method onCreateResult:code:errorMsg:
 @abstract 回调函数
 @discussion 添加车友成功后回调
 @param result 请求返回的信息字典
 @param code 错误码
 @param errorMsg 错误信息
 @result 无
 */
- (void)onCreateContactsResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg;

@end
