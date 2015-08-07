//
//  NIQueryPOI.m
//  author: wlq
//
//  Created by mac on 13-5-29.
//  Copyright (c) 2013 NavInfo. All rights reserved.
//
//  version 1.0 2013-5-30 wlq create.
//
//

#import "NIQueryPOI.h"

@implementation NIQueryPOI

//@synthesize mResultInfo;

- (void)dealloc
{
    [mResultInfo release];
    [super dealloc];
}


- (NSString *)getMpMessage
{
    return mMessage;
}
/*!
 @method createRequest:size:
 @abstract 创建网路请求
 @discussion 刷新收藏的POI请求的网络请求URL
 @param num poi页数
 @param size  每页信息数量
 @result 无
 */
- (void)createRequest:(int) num size:(int)size
{
    mRequest = [[[NIOpenUIPRequest alloc] init]autorelease];
    mRequest.fVersion = [NSString stringWithFormat:@"1.0"];
    mRequest.seq = mRequest.getNextSeq;
    mRequest.fName = [NSString stringWithFormat:@"GW.C.PRIVATEPOI.QUERY"];
    
    mRequest.time = [NSDate timeIntervalSinceReferenceDate];
    
//    NIOpenUIPData *temp = [[[NIOpenUIPData alloc]init]autorelease];
//    [temp setInt:@"num" value:num];
//    
//    //temp = [[NIOpenUIPData alloc]init];
//    [temp setInt:@"size" value:size];
    
    NIOpenUIPData *param = [[[NIOpenUIPData alloc]init]autorelease];
//    [param setObject:@"page" object:temp];
    
    [mRequest setParam:param];
    
    mMessage = [mRequest generatePackage];
}
/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求
 @discussion 刷新收藏的POI的异步网络请求
 @param delegate 代理函数
 @result 无
 */
- (void)sendRequestWithAsync:(id<NIQueryPOIDelegate>)delegate
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
            [mDelegate onQueryResult:nil code:RETURN_PROTOCOL_ERROR errorMsg:[self convertErrorCode:RETURN_PROTOCOL_ERROR]];
        }
        else
        {
            NSDictionary *header = [responseResult objectForKey:@"header"];
            if ([header objectForKey:@"c"])
            {
                int c = [[header objectForKey:@"c"]integerValue];
                if(c==NAVINFO_TOKENID_INVALID)
                {
                    mErrorCode = NAVINFO_TOKENID_INVALID;
                    [mDelegate onQueryResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
                else if(c==NAVINFO_RESULT_SUCCESS)
                {
                    NSDictionary *resultDic = [responseResult objectForKey:@"body"];
                    if (resultDic != nil)
                    {
                        mErrorCode = NAVINFO_RESULT_SUCCESS;
                        [mDelegate onQueryResult:resultDic code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                    }
                    else
                    {
                        mErrorCode = RETURN_EMPTY;
                        [mDelegate onQueryResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                    }
                }
                else
                {
                    mErrorCode = RETURN_PROTOCOL_ERROR;
                    [mDelegate onQueryResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }

            }
            else
            {
                mErrorCode = RETURN_PROTOCOL_ERROR;
                [mDelegate onQueryResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
            }
        }
        
    }
    else
    {
        NSLog(@"[Error] The return's data is empty");
        mErrorCode = RETURN_EMPTY;
        [mDelegate onQueryResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
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
    [mDelegate onQueryResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
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
    [mDelegate onQueryResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
}

@end