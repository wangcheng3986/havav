/*!
 @header NIFeedBack.h
 @abstract 意见反馈
 @author wangqiwei
 @version 1.00 2013-5-30 Creation
 */

// Get profile
// the fname = GW.C.CRUD.APP_PROFILE.GET
// p = "id" : "5199b3815c9388ea0da26eed"
//

#import <Foundation/Foundation.h>
#import "NIApplicationBase.h"
#import "NIFeedBackDelegate.h"
/*!
 @class NISetPWD
 @abstract 意见反馈网络管理类
 */
@interface NIFeedBack : NIApplicationBase
{
    id<NIFeedBackDelegate>         mDelegate;
}
/*!
 @method createRequest:content:type:
 @abstract 创建网路请求
 @discussion 意见反馈网络请求URL
 @param title 意见反馈标题
 @param content 意见反馈内容
 @param type 反馈类型（1:系统bug;2:用户体验;3:其他意见）
 @result 无
 */
- (void)createRequest:(NSString *) title content:(NSString *)content type:(int)type;
/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求
 @discussion 意见反馈异步网络请求
 @param delegate 代理函数
 @result 无
 */
- (void)sendRequestWithAsync:(id<NIFeedBackDelegate>)delegate;
/*!
 @method getMpMessage
 @abstract 获取信息
 @discussion 意见反馈的url字符串
 @result 请求字符串
 */
- (NSString *)getMpMessage;
@end