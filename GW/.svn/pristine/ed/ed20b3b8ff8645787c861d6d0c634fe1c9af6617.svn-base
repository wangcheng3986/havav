/*!
 @header NIPOISycn.h
 @abstract 刷新收藏的POI信息
 @author wangqiwei
 @version 1.00 2013-5-30 Creation
*/

// Check private POI
// the fname = GW.C.PRIVATEPOI.QUERY
//

#import <Foundation/Foundation.h>
#import "NIApplicationBase.h"
#import "NIQueryPOIDelegate.h"
/*!
 @class NIQueryPOI
 @abstract 刷新收藏的POI信息网络管理类
 */
@interface NIQueryPOI : NIApplicationBase
{
//    NSArray *mResultInfo;
    id<NIQueryPOIDelegate>  mDelegate;
}

@property (nonatomic, retain)NSArray *mResultInfo;
/*!
 @method createRequest:size:
 @abstract 创建网路请求
 @discussion 刷新收藏的POI请求的网络请求URL
 @param num poi页数
 @param size  每页信息数量
 @result 无
 */
- (void)createRequest:(int) num size:(int)size;
/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求
 @discussion 刷新收藏的POI的异步网络请求
 @param delegate 代理函数
 @result 无
*/
- (void)sendRequestWithAsync:(id<NIQueryPOIDelegate>)delegate;
/*!
 @method getMpMessage
 @abstract 获取信息
 @discussion 获取刷新收藏的POI的url字符串
 @result 请求字符串
 */
- (NSString *)getMpMessage;
@end


