/*!
 @header NINetDelegate.h
 @abstract 网络请求管理类
 @author wangliqiong
 @version 1.00 2013/5/30 Creation
 */

#import <Foundation/Foundation.h>
/*!
 @protocol NINetDelegate
 @abstract 代理函数
 @discussion 网络请求回调代理
 */
@protocol NINetDelegate <NSObject>
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
-(void)onError:(long)code;
/*!
 @method onCancel
 @abstract 取消请求
 @discussion 取消网络请求回调此函数
 @result 无
 */
-(void)onCancel;

@end
