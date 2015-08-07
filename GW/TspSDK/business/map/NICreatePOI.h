/*!
 @header NICreatePOI.h
 @abstract 创建收藏POI请求网络管理
 @author wangqiwei
 @version 1.00 2013-06-03 Creation
 */

// create private POI
// the fname = GW.C.PRIVATEPOI.CREATE
//

#import <Foundation/Foundation.h>
#import "NIApplicationBase.h"
#import "NICreatePOIDelegate.h"
/*!
 @class NICreatePOI
 @abstract 创建收藏POI请求网络管理类
 */
@interface NICreatePOI : NIApplicationBase
{
    NSArray *mPrivatePOIInfo;
    id<NICreatePOIDelegate>         mDelegate;
}

@property (nonatomic, retain)NSArray *mPrivatePOIInfo;
/*!
 @method createRequest
 @abstract 创建网路请求
 @discussion 创建收藏POI请求的网络请求URL
 @param privatePOIInfo POI信息
 @result 无
 */
- (void)createRequest:(NSDictionary *) privatePOIInfo;
/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求
 @discussion 发送创建收藏POI的异步网络请求
 @param delegate 代理函数
 @result 无
 */
- (void)sendRequestWithAsync:(id<NICreatePOIDelegate>)delegate;

@end
