
/*!
 @header NISelectCar.h
 @abstract 选车
 @author mengy
 @version 1.00 14-9-17 Creation
 */

#import <Foundation/Foundation.h>
#import "NIApplicationBase.h"
#import "NISelectCarDelegate.h"
/*!
 @class NISelectCar
 @abstract 用户选车网络管理类
 */
@interface NISelectCar : NIApplicationBase
{
    id<NISelectCarDelegate>         mDelegate;
}
/*!
 @method createRequest
 @abstract 创建网路请求（选车业务层）
 @discussion 创建用户选车的网络请求URL
 @result 无
 */
- (void)createRequest;
/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求（选车业务层）
 @discussion 发送用户选车的异步网络请求
 @param delegate 代理函数
 @result 无
 */
- (void)sendRequestWithAsync:(id<NISelectCarDelegate>)delegate;

@end