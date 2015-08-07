/*!
 @header NIGetProfileDelegate.h
 @abstract 版本检测代理
 @author wangqiwei
 @version 1.00 2013-5-30 Creation
 */
#import <Foundation/Foundation.h>
/*!
 @protocol NIGetProfileDelegate
 @abstract  代理类
 @discussion 版本检测代理
 */
@protocol NIGetProfileDelegate <NSObject>
/*!
 @method onProfileResult:code:errorMsg:
 @abstract 回调函数
 @discussion 版本检测成功后回调
 @param result 请求返回的信息字典
 @param code 错误码
 @param errorMsg 错误信息
 @result 无
 */
- (void)onProfileResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg;
                               
@end
