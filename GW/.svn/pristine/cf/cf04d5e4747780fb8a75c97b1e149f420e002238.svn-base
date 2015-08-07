/*!
 @header NetDelegate.h
 @abstract 网络请求回调代理
 @author wangqiwei
 @version 1.00 2012/4/25 Creation
 */

#import <Foundation/Foundation.h>
/*!
 @protocol NetDelegate
 @abstract 代理函数
 @discussion 网络请求回调代理
 */
@protocol NetDelegate <NSObject>
/*!
 @method onFinish
 @abstract 回调函数
 @discussion 网络请求完毕后回调
 @param data http请返回的数据信息
 @result 无
 */
-(void)onFinish:(NSData*)data;
/*!
 @method onError
 @abstract 错误信息
 @discussion 如果请求发生错误，请回调此函数
 @param code 错误码
 @result 无
 */
-(void)onError:(int)code;
/*!
 @method onCancel
 @abstract 取消请求
 @discussion 取消网络请求回调此函数
 @result 无
 */
-(void)onCancel;

@end

