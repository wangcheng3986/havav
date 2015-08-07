/*!
 @header NIRescue.h
 @abstract BCall业务网络管理
 @author wangqiwei
 @version 1.00 13-6-7 Creation
 */
#import <Foundation/Foundation.h>
#import "NIApplicationBase.h"
#import "NIRescueDelegate.h"
/*!
 @class NIRescue
 @abstract BCall业务网络管理类
 */
@interface NIRescue : NIApplicationBase
{
    id<NIRescueDelegate>         mDelegate;
}
/*!
 @method createRequest
 @abstract 创建请求
 @discussion 创建URL请求字符串
 @result 无
 */
- (void)createRequest;
/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求
 @discussion 发送异步网络请求（BCall业务层）
 @param delegate 代理函数
 @result 无
 */
- (void)sendRequestWithAsync:(id<NIRescueDelegate>)delegate;

@end