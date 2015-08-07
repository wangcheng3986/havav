/*!
 @header NIDeleteContacts.h
 @abstract 删除车友网络管理
 @author wangqiwei
 @version 1.00 2013-5-30 Creation
 */
#import <Foundation/Foundation.h>
#import "NIApplicationBase.h"
#import "NIDeleteContactsDelegate.h"

/*!
 @class NIDeleteContacts
 @abstract 删除车友网络管理类
 */
@interface NIDeleteContacts: NIApplicationBase
{
    id<NIDeleteContactsDelegate> mDelegate;
}
/*!
 @method createRequest
 @abstract 创建网路请求
 @discussion 创建删除车友的网络请求URL（车友业务层）
 @param ids 车友ID集合
 @result 无
 */
- (void)createRequest:(NSArray *)ids;
/*!
 @method sendRequestWithAsync
 @abstract 发送删除车友异步网络请求
 @discussion 发送异步网络请求（车友业务层）
 @param delegate 代理函数
 @result 无
 */
- (void)sendRequestWithAsync:(id<NIDeleteContactsDelegate>)delegate;

@end
