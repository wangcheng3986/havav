/*!
 @header NIPOISycn.h
 @abstract 同步收藏POI信息
 @author wangqiwei
 @version 1.00 2013-5-30 Creation
 */
#import <Foundation/Foundation.h>
#import "NIApplicationBase.h"
#import "NIPOISycnDelegate.h"
/*!
 @class NIPOISycn
 @abstract 同步收藏POI信息网络管理类
 */
@interface NIPOISycn : NIApplicationBase
{
    id<NIPOISycnDelegate>         mDelegate;
}

@property (nonatomic, retain)NSArray *mPrivatePOIInfo;
/*!
 @method createRequest:(NSMutableArray *) addList delList:(NSMutableArray *) delList updateList:(NSMutableArray *) updateList
 @abstract 创建网路请求
 @discussion 同步收藏POI请求的网络请求URL
 @param addList 需要添加的poi信息
 @param delList 需要删除的poi信息
 @result 无
 */
- (void)createRequest:(NSMutableArray *) addList delList:(NSMutableArray *) delList updateList:(NSMutableArray *) updateList;
/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求
 @discussion 发送同步收藏POI的异步网络请求
 @param delegate 代理函数
 @result 无
 */
- (void)sendRequestWithAsync:(id<NIPOISycnDelegate>)delegate;
@end
