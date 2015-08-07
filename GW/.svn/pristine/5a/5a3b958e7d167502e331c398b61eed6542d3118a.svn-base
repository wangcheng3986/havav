
/*!
 @header NIPOISearch4S.h
 @abstract 检索4s店poi
 @author mengy
 @version 1.00 14-9-18 Creation
 */
#import <Foundation/Foundation.h>
#import "NIApplicationBase.h"
#import "NIPOISearch4SDelegate.h"
/*!
 @class NIPOISearchJSONServer
 @abstract POI检索网络管理类
 */
@interface NIPOISearch4S : NIApplicationBase
{
    id<NIPOISearch4SDelegate>         mDelegate;
}
/*!
 @method createRequest
 @abstract 创建网路请求
 @discussion POI检索请求的网络请求URL
 @param searchInfo POI信息
 @result 无
 */
- (void)createRequest:(NSDictionary *) searchInfo;
/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求（POI检索业务层）
 @discussion 发送POI检索的异步网络请求
 @param delegate 代理函数
 @result 无
 */
- (void)sendRequestWithAsync:(id<NIPOISearch4SDelegate>)delegate;
@end
