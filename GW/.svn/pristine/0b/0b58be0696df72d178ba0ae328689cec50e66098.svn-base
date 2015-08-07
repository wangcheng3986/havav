/*!
 @header NISyncContacts.h
 @abstract 通讯录同步功能网络管理
 @author wlq
 @version 1.00 2013-06-03 Creation
 */
#import <Foundation/Foundation.h>
#import "NIApplicationBase.h"
#import "NISyncContactsDelegate.h"
/*!
 @class NISyncContacts
 @abstract 通讯录同步功能网络管理类
 */
@interface NISyncContacts : NIApplicationBase
{
    id<NISyncContactsDelegate>         mDelegate;
}
/*!
 @method createRequest
 @abstract 创建网路请求
 @discussion 创建请求同步通讯录的网络请求URL（车友业务层）
 @param contactsList 通讯录列表集合
 @result 无
 */
- (void)createRequest:(NSArray *) contactsList;

/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求（车友业务层）
 @discussion 发送车友同步通讯录的异步网络请求
 @param delegate 代理函数
 @result 无
 */
- (void)sendRequestWithAsync:(id<NISyncContactsDelegate>)delegate;

@end

