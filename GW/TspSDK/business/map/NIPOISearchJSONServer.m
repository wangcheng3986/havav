//
//  NIPOISearchJSONServer.m
//  GW
//
//  Created by my on 13-7-17.
//  Copyright (c) 2013年 liutch. All rights reserved.
//

#import "NIPOISearchJSONServer.h"

@implementation NIPOISearchJSONServer
- (void)dealloc
{
    
    [super dealloc];
}
/*!
 @method createRequest
 @abstract 创建网路请求
 @discussion POI检索请求的网络请求URL
 @param searchInfo POI信息
 @result 无
 */
- (void)createRequest:(NSDictionary *) searchInfo
{
    mRequest = [[[NIOpenUIPRequest alloc] init]autorelease];
    mRequest.fVersion = [NSString stringWithFormat:@"1.0"];
    mRequest.seq = mRequest.getNextSeq;
    mRequest.fName =[NSString stringWithFormat:@"GW.M.SEARCH_ROUND_POI"];
    mRequest.time = [NSDate timeIntervalSinceReferenceDate];
    
    NIOpenUIPData *param = [[[NIOpenUIPData alloc]init]autorelease];
    if ([searchInfo objectForKey:@"lon"]) {
        [param setDouble:@"lon" value:[[searchInfo objectForKey:@"lon"]doubleValue]];
    }
    else
    {
        [param setDouble:@"lon" value:0];
    }
    if ([searchInfo objectForKey:@"lat"]) {
        [param setDouble:@"lat" value:[[searchInfo objectForKey:@"lat"]doubleValue]];
    }
    else
    {
        [param setDouble:@"lat" value:0];
    }
    // 周边搜索半径不传时，后台默认为1000米 updat 20140102 by mengyue
    [param setInt:@"radius" value:[[searchInfo objectForKey:@"radius"]integerValue]];
    if ([searchInfo objectForKey:@"kind"]) {
        [param setString:@"kind" value:[searchInfo objectForKey:@"kind"]];
    }
    if ([searchInfo objectForKey:@"keyword"]) {
        [param setString:@"keyword" value:[searchInfo objectForKey:@"keyword"]];
    }
    [param setInt:@"sortType" value:20];
    [param setInt:@"page" value:[[searchInfo objectForKey:@"page"]integerValue]];
    [param setInt:@"size" value:[[searchInfo objectForKey:@"pagesize"]integerValue]];
     NSLog(@"param = %@", param.mutableDict);
    [mRequest setParam:param];
    mMessage = [mRequest generatePackage];
}
/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求（POI检索业务层）
 @discussion 发送POI检索的异步网络请求
 @param delegate 代理函数
 @result 无
 */
- (void)sendRequestWithAsync:(id<NIPOISearchJSONSeverDelegate>)delegate
{
    mDelegate = delegate;
    mNetManager = [[NINetManager alloc] initWithString:mMessage];
    [mNetManager requestWithAsynchronous:self];
}
/*!
 @method onFinish
 @abstract 回调函数
 @discussion 网络请求完毕后回调
 @param data http请返回的数据信息
 @result 无
 */
- (void)onFinish:(NSData*)data
{
    if(data)
    {
        NSDictionary *responseResult =  [mNetManager parsingOfJson:data];
        if ([[responseResult objectForKey:@"error"]boolValue])
        {
            mErrorCode = RETURN_PROTOCOL_ERROR;
            [mDelegate onSearchResult:nil code:RETURN_PROTOCOL_ERROR errorMsg:[self convertErrorCode:RETURN_PROTOCOL_ERROR]];
        }
        else
        {
            NSDictionary *header = [responseResult objectForKey:@"header"];
            if ([header objectForKey:@"c"]) {
                int c = [[header objectForKey:@"c"]integerValue];
                if(c==NAVINFO_RESULT_SUCCESS)
                {
                    NSDictionary *resultDic = [responseResult objectForKey:@"body"];
                    if (resultDic != nil)
                    {
                        mErrorCode = NAVINFO_RESULT_SUCCESS;
                        [mDelegate onSearchResult:resultDic code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                    }
                    else
                    {
                        mErrorCode = RETURN_EMPTY;
                        [mDelegate onSearchResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                    }
                    
                }
                else
                {
                    mErrorCode = RETURN_PROTOCOL_ERROR;
                    [mDelegate onSearchResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
            }
            else
            {
                mErrorCode = RETURN_PROTOCOL_ERROR;
                [mDelegate onSearchResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
            }
        }
    }
    else
    {
        NSLog(@"[Error] The return's data is empty");
        mErrorCode = RETURN_EMPTY;
        [mDelegate onSearchResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
    }

}
/*!
 @method onError
 @abstract 错误信息
 @discussion 如果请求发生错误，请回调此函数
 @param code 错误码
 @result 无
 */
- (void)onError:(long)code
{
    mErrorCode = NET_ERROR;
    [mDelegate onSearchResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
}
/*!
 @method onCancel
 @abstract 取消请求
 @discussion 取消网络请求回调此函数
 @result 无
 */
- (void)onCancel
{
    mErrorCode = USER_CANCEL_ERROR;
    [mDelegate onSearchResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
}


@end
