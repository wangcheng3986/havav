/*!
 @header NIGetLastTrack.h
 @abstract 上次车机所在位置
 @author wangqiwei
 @version 1.00 2013-5-30 Creation
 */

// Check private POI
// the fname = GW.C.PRIVATEPOI.QUERY
//

#import <Foundation/Foundation.h>
#import "NIApplicationBase.h"
#import "NIGetLastTrackDelegate.h"
/*!
 @class NIGetLastTrack
 @abstract 上次车机所在位置网络管理类
*/
@interface NIGetLastTrack : NIApplicationBase
{
//    NSArray *mResultInfo;
    id<NIGetLastTrackDelegate>  mDelegate;
}

@property (nonatomic, retain)NSArray *mResultInfo;
@property (nonatomic, assign)id<NIGetLastTrackDelegate>  mDelegate;
/*!
 @method createRequest:type:
 @abstract 创建网路请求
 @discussion 上次车机所在位置网络请求URL
 @param trackID sim卡号
 @param type 预留
 @result 无
 */
- (void)createRequest:(NSString *) trackID type:(NSString *) type;
/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求
 @discussion 上次车机所在位置异步网络请求
 @param delegate 代理函数
 @result 无
 */
- (void)sendRequestWithAsync:(id<NIGetLastTrackDelegate>)delegate;

@end
