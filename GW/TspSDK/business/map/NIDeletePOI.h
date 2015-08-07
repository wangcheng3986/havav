/*!
 @header NIDeletePOI.h
 @abstract 取消收藏POI请求网络管理
 @author wangqiwei
 @version 1.00 2013-06-03 Creation
 */
// Check private POI
// the fname = GW.C.PRIVATEPOI.DELETE
//

#import <Foundation/Foundation.h>
#import "NIApplicationBase.h"
#import "NIDeletePOIDelegate.h"
/*!
 @class NIDeletePOI
 @abstract 取消收藏POI请求网络管理类
 */
@interface NIDeletePOI: NIApplicationBase
{
    id<NIDeletePOIDelegate>  mDelegate;
}
/*!
 @method createRequest
 @abstract 创建网路请求
 @discussion 取消收藏POI请求的网络请求URL
 @param request POI信息
 @result 无
 */
- (void)createRequest:(NSMutableArray *)request;
/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求
 @discussion 发送取消收藏POI的异步网络请求
 @param delegate 代理函数
 @result 无
 */
- (void)sendRequestWithAsync:(id<NIDeletePOIDelegate>)delegate;
/*!
 @method clearDelegate
 @abstract 代理对象释放
 @discussion 代理对象释放
 @result 无
 */
- (void)clearDelegate;

@end
