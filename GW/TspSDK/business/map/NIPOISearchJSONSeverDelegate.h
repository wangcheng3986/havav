/*!
 @header NIPOISearchJSONSeverDelegate.h
 @abstract POI检索请求代理
 @author wangqiwei
 @version 1.00 2013-5-30 Creation
 */
#import <Foundation/Foundation.h>
/*!
 @protocol NIPOISearchJSONSeverDelegate
 @abstract  网络请求代理类
 @discussion POI检索请求代理
 */
@protocol NIPOISearchJSONSeverDelegate <NSObject>
/*!
 @method onSearchResult:code:errorMsg:
 @abstract 回调函数
 @discussion POI检索请求成功后回调
 @param result 请求返回的信息字典
 @param code 错误码
 @param errorMsg 错误信息
 @result 无
 */
- (void)onSearchResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg;
@end
