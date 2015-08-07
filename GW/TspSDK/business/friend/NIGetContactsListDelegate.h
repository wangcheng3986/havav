/*!
 @header NIGetContactsListDelegate.h
 @abstract 获取车友列表代理类
 @author wangqiwei
 @version 1.00 2013-5-30 Creation
 */
#import <Foundation/Foundation.h>
/*!
 @protocol NIGetBlackDelegate
 @abstract  网络请求成功后回调
 @discussion 获取车友列表成功后回调
 */
@protocol NIGetContactsListDelegate <NSObject>
/*!
 @method onGetListResult:code:errorMsg:
 @abstract 回调函数
 @discussion 获取车友列表成功后回调
 @param result 请求返回的信息字典
 @param code 错误码
 @param errorMsg 错误信息
 @result 无
 */
- (void)onGetListResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg;
                               
@end
