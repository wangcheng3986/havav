/*!
 @header NICreateBlack.h
 @abstract 黑名单业务网络请求回调代理函数
 @author mengy
 @version 1.00 14-4-1 Creation
 */
#import <Foundation/Foundation.h>
#import "NIApplicationBase.h"
#import "NICreateBlackDelegate.h"
/*!
 @class NICreateBlack
 @abstract 添加黑名单网络管理类
 */
@interface NICreateBlack : NIApplicationBase
{
    
    id<NICreateBlackDelegate>         mDelegate;
}

/*!
 @method createRequest:mobile:userId:
 @abstract 创建网路请求
 @discussion 创建加入黑名单的网络请求URL（黑名单业务层）
 @param name 用户名字
 @param mobile 电话号码
 @param userId 用户唯一标识
 @result 无
 */
- (void)createRequest:(NSString *)name
               mobile:(NSString *)mobile
               userId:(NSString *)userId;


/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求
 @discussion 发送异步网络请求（黑名单业务层）
 @param delegate 代理函数
 @result 无
 */
- (void)sendRequestWithAsync:(id<NICreateBlackDelegate>)delegate;

@end