/*!
 @header NISendToCarDelegate.h
 @abstract 发送到车信息代理
 @author wangqiwei
 @version 1.00 2013-5-30 Creation
*/

#import <Foundation/Foundation.h>
/*!
 @protocol NISendToCarDelegate
 @abstract  网络请求代理类
 @discussion 刷新收藏的POI信息代理
*/
@protocol NISendToCarDelegate <NSObject>
/*!
 @method onResult:code:errorMsg:
 @abstract 回调函数
 @discussion 发送到车信息成功后回调
 @param result 请求返回的信息字典
 @param code 错误码
 @param errorMsg 错误信息
 @result 无
 */
- (void)onResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg;
@end
