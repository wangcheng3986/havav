/*!
 @header NIPOISycn.h
 @abstract 发送到车信息
 @author wangqiwei
 @version 1.00 2013-5-30 Creation
*/

#import <Foundation/Foundation.h>
#import "NIApplicationBase.h"
#import "NISendToCarDelegate.h"
/*!
 @class NISendToCar
 @abstract 发送到车信息网络管理类
 */
@interface NISendToCar : NIApplicationBase
{
    id<NISendToCarDelegate>         mDelegate;
}
/*!
 @method createRequest:eventTime:lon:lat:event:poiID:oiName:poiAddress:
 @abstract 创建网路请求
 @discussion 发送到车信息的网络请求URL
 @param sendToCarInfo 发送到车的信息
 @param eventTime   事件时间
 @param lon 位置经度
 @param lat 位置纬度
 @param mPoiID poi的ID信息
 @param mPoiName poi的名称
 @param mPoiAddress poi的地址信息
 @result 无
 */
- (void)createRequest:(NSDictionary *) sendToCarInfo eventTime:(long long)eventTime lon:(double)lon lat:(double)lat event:(BOOL)event poiID:(NSString *)mPoiID poiName:(NSString *)mPoiName poiAddress:(NSString *)mPoiAddress;
/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求
 @discussion 发送到车信息的异步网络请求
 @param delegate 代理函数
 @result 无
 */
- (void)sendRequestWithAsync:(id<NISendToCarDelegate>)delegate;

@end