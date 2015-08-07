/*!
 @header NItinyUrlCreateDelegate.h
 @abstract 获取消息短地址URL
 @author mengyue
 @version 1.00 2014-3-15 Creation
*/

#import <Foundation/Foundation.h>
/*!
 @protocol NItinyUrlCreateDelegate
 @abstract  代理类
 @discussion 获取消息短地址URL请求代理
 */
@protocol NItinyUrlCreateDelegate <NSObject>
/*!
 @method onTinyUrlCreateResult:code:errorMsg:
 @abstract 回调函数
 @discussion 获取消息短地址URL成功后回调
 @param result 请求返回的信息字典
 @param code 错误码
 @param errorMsg 错误信息
 @result 无
 */
- (void)onTinyUrlCreateResult:(NSString *)result code:(int)code errorMsg:(NSString *)errorMsg;
@end
