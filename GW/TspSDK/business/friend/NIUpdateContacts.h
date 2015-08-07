/*!
 @header NIUpdateContacts.h
 @abstract 车友名称备注修改网络管理
 @author wangqiwei
 @version 1.00 2013-06-03 Creation
 */

#import <Foundation/Foundation.h>
#import "NIApplicationBase.h"
#import "NIUpdateContactsDelegate.h"
/*!
 @class NISyncContacts
 @abstract 车友名称备注修改网络管理类
 */
@interface NIUpdateContacts : NIApplicationBase
{
    id<NIUpdateContactsDelegate>         mDelegate;
}
/*!
 @method createRequest
 @abstract 创建网路请求
 @discussion 创建请求车友名称备注修改的网络请求URL（车友业务层）
 @param contacts 车友信息
 @result 无
 */
- (void)createRequest:(NSDictionary *) contacts;

/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求（车友业务层）
 @discussion 发送车友名称备注修改的异步网络请求
 @param delegate 代理函数
 @result 无
 */
- (void)sendRequestWithAsync:(id<NIUpdateContactsDelegate>)delegate;

@end

