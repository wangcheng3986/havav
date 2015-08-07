/*!
 @header NICreateContacts.h
 @abstract 车友业务模块中添加新车友
 @author wangqiwei
 @version 1.00 2013-06-03 Creation
 */
#import <Foundation/Foundation.h>
#import "NIApplicationBase.h"
#import "NICreateContactsDelegate.h"
/*!
 @class NICreateContacts
 @abstract 添加车友网络管理类
 */
@interface NICreateContacts : NIApplicationBase
{
  
    id<NICreateContactsDelegate>         mDelegate;
}

/*!
 @method createRequest:telNo:
 @abstract 创建网路请求
 @discussion 创建加入车友的网络请求URL（车友业务层）
 @param name 用户名字
 @param telNo 电话号码
 @result 无
 */
- (void)createRequest:(NSString *)name
                telNo:(NSString *)telNo;


/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求
 @discussion 发送异步网络请求（黑名单业务层）
 @param delegate 代理函数
 @result 无
 */
- (void)sendRequestWithAsync:(id<NICreateContactsDelegate>)delegate;

@end