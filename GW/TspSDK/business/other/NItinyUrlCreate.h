/*!
 @header NItinyUrlCreate.h
 @abstract 获取消息短地址URL
 @author wangqiwei
 @version 1.00 2013-5-30 Creation
 */

#import <Foundation/Foundation.h>
#import "NIApplicationBase.h"
#import "NItinyUrlCreateDelegate.h"
/*!
 @class NItinyUrlCreate
 @abstract 获取短信息URL网络管理类
 */
@interface NItinyUrlCreate : NIApplicationBase
{
    id<NItinyUrlCreateDelegate>         mDelegate;
}
/*!
 @method createRequest
 @abstract 创建网路请求
 @discussion 获取消息短地址URL网络请求URL
 @param urlString 消息长地址
 @result 无
 */
- (void)createRequest:(NSString *)urlString;
/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求
 @discussion 获取消息短地址URL异步网络请求
 @param delegate 代理函数
 @result 无
 */
- (void)sendRequestWithAsync:(id<NItinyUrlCreateDelegate>)delegate;

@end