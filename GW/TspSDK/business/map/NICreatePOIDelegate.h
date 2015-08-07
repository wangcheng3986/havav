/*!
 @header NICreatePOIDelegate.h
 @abstract 创建收藏POI请求代理类
 @author wangqiwei
 @version 1.00 2013-5-30 Creation
 */
#import <Foundation/Foundation.h>
/*!
 @protocol NICreatePOIDelegate
 @abstract  网络请求代理类
 @discussion 创建收藏POI请求代理
 */
@protocol NICreatePOIDelegate <NSObject>
/*!
 @method onCreateResult:code:errorMsg:
 @abstract 回调函数
 @discussion 创建收藏POI请求成功后回调
 @param result 请求返回的信息字典
 @param code 错误码
 @param errorMsg 错误信息
 @result 无
 */
- (void)onCreateResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg;

@end
