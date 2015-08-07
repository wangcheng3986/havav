/*!
 @header NIGetContactsList.h
 @abstract 获取车友列表网络请求管理
 @author wangqiwei
 @version 1.00 2013-5-30 Creation
 */

#import <Foundation/Foundation.h>
#import "NIApplicationBase.h"
#import "NIGetContactsListDelegate.h"
/*!
 @class NIGetContactsList
 @abstract 请求车友列表网络管理类
 */
@interface NIGetContactsList : NIApplicationBase
{
    id<NIGetContactsListDelegate>         mDelegate;
}
@property(nonatomic,assign)id<NIGetContactsListDelegate>         mDelegate;
/*!
 @method createRequest
 @abstract 创建网路请求
 @discussion 创建请求车友列表的网络请求URL（车友业务层）
 @result 无
 */
- (void)createRequest;
/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求（车友业务层）
 @discussion 发送请求车友列表异步网络请求
 @param delegate 代理函数
 @result 无
 */
- (void)sendRequestWithAsync:(id<NIGetContactsListDelegate>)delegate;
/*!
 @method getMpMessage
 @abstract 获取信息
 @discussion 获取请求列表的车友信息的url字符串
 @result 请求字符串
 */
- (NSString *)getMpMessage;
@end
