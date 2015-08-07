/*!
 @header NIResponseLocationDelegate.h
 @abstract 位置请求应答代理
 @author wangqiwei
 @version 1.00 2013-9-3 Creation
 */
 

#import <Foundation/Foundation.h>
/*!
 @protocol NIResponseLocationDelegate
 @abstract  代理类
 @discussion 位置请求应答请求代理
 */
@protocol NIResponseLocationDelegate <NSObject>
/*!
 @method onResponseLocationResult:code:errorMsg:
 @abstract 回调函数
 @discussion 位置请求应答成功后回调
 @param result 请求返回的信息字典
 @param code 错误码
 @param errorMsg 错误信息
 @result 无
 */
- (void)onResponseLocationResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg;
                               
@end
