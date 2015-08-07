/*!
 @header NIDeleteBlack.h
 @abstract 删除黑名单网络管理
 @author mengy
 @version 1.00 14-4-2 Creation
 */
#import <Foundation/Foundation.h>
#import "NIApplicationBase.h"
#import "NIDeleteBlackDelegate.h"

/*!
 @class NIDeleteBlack
 @abstract 删除黑名单网络管理类
 */
@interface NIDeleteBlack: NIApplicationBase
{
    id<NIDeleteBlackDelegate> mDelegate;
}
/*!
 @method createRequest
 @abstract 创建网路请求
 @discussion 创建删除黑名单的网络请求URL（黑名单业务层）
 @param ids 黑名单ID集合
 @result 无
 */
- (void)createRequest:(NSArray *)ids;
/*!
 @method sendRequestWithAsync
 @abstract 发送删除黑名单异步网络请求
 @discussion 发送异步网络请求（黑名单业务层）
 @param delegate 代理函数
 @result 无
 */
- (void)sendRequestWithAsync:(id<NIDeleteBlackDelegate>)delegate;

@end
