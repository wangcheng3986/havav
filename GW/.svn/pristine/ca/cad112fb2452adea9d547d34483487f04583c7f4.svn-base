/*!
 @header NIPOISycnDelegate.h
 @abstract 同步收藏POI信息代理
 @author wangqiwei
 @version 1.00 2013-5-30 Creation
 */

#import <Foundation/Foundation.h>
/*!
 @protocol NIPOISycnDelegate
 @abstract  网络请求代理类
 @discussion 同步收藏POI信息代理
 */
@protocol NIPOISycnDelegate <NSObject>
/*!
 @method onPOISyncResult:code:errorMsg:
 @abstract 回调函数
 @discussion 同步收藏POI成功后回调
 @param result 请求返回的信息字典
 @param code 错误码
 @param errorMsg 错误信息
 @result 无
 */
- (void)onPOISyncResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg;

@end
