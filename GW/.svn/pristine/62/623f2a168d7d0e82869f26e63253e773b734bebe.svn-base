//
//  NIGetProfileApp.m
//  author: wlq
//
//  Created by mac on 13-5-29.
//  Copyright (c) 2013 NavInfo. All rights reserved.
//
//  version 1.0 2013-5-30 wlq create.
//
//
//

#import "NIGetProfileApp.h"

@implementation NIGetProfileApp
/*!
 @method getMpMessage
 @abstract 获取信息
 @discussion 版本检测的url字符串
 @result 请求字符串
 */
- (NSString *)getMpMessage
{
    return mMessage;
}
/*!
 @method createRequest:idValue:
 @abstract 创建网路请求
 @discussion 版本检测网络请求URL
 @param idValue 协议固定值:1
 @result 无
 */
- (void)createRequest:(int) idValue
{
    mRequest = [[[NIOpenUIPRequest alloc] init]autorelease];
    mRequest.fVersion = [NSString stringWithFormat:@"1.0"];
    mRequest.seq = mRequest.getNextSeq;
    mRequest.fName = [NSString stringWithFormat:@"GW.M.VER.CHECK"];
    mRequest.time = [NSDate timeIntervalSinceReferenceDate];
    
    NIOpenUIPData *param = [[[NIOpenUIPData alloc]init]autorelease];
    
    [param setInt:@"src" value:idValue];
    [mRequest setParam:param];
    
    mMessage = [mRequest generatePackage];
}

// Only need to read "version" and "desc" from result.
// A example of the result is below:
// http://218.249.91.93/jsnc/index.html#dataType
//r = {
//	"id" : "5199b3815c9388ea0da26eed",
//	"desc" : "iphone app",
//	"lastUpdate" : 1369027457988,
//	"version" : "v1.1.0"
//}
//
//var or = {
//	"$or" : [{
//		"name1" : {
//			"$in" : ["zhou28-1", "zhou29"]
//		}
//	}],
//	"name2" : "zhou"
//}
/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求
 @discussion 版本检测异步网络请求
 @param delegate 代理函数
 @result 无
 */
- (void)sendRequestWithAsync:(id<NIGetProfileDelegate>)delegate
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
    NSLog(@"onFinish.");   
    if(data)
    {
        NSDictionary *responseResult =  [mNetManager parsingOfJson:data];
       if ([[responseResult objectForKey:@"error"]boolValue])
       {
            mErrorCode = RETURN_PROTOCOL_ERROR;
            [mDelegate onProfileResult:nil code:RETURN_PROTOCOL_ERROR errorMsg:[self convertErrorCode:RETURN_PROTOCOL_ERROR]];
        }
        else
        {
            NSDictionary *header = [responseResult objectForKey:@"header"];
            if ([header objectForKey:@"c"])
            {
                int c = [[header objectForKey:@"c"]integerValue];
                if(c==NAVINFO_RESULT_SUCCESS)
                {
                    
                    NSDictionary *resultDic = [responseResult objectForKey:@"body"];
                    if (resultDic != nil)
                    {
                        mErrorCode = NAVINFO_RESULT_SUCCESS;
                        [mDelegate onProfileResult:resultDic code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                    }
                    else
                    {
                        mErrorCode = RETURN_EMPTY;
                        [mDelegate onProfileResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                    }
                }
                else
                {
                    mErrorCode = RETURN_PROTOCOL_ERROR;
                    [mDelegate onProfileResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
            }
            else
            {
                mErrorCode = RETURN_PROTOCOL_ERROR;
                [mDelegate onProfileResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
            }
        }
        
    }
    else
    {
        NSLog(@"[Error] The return's data is empty");
        mErrorCode = RETURN_EMPTY;
        [mDelegate onProfileResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
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
    [mDelegate onProfileResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
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
    [mDelegate onProfileResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
}
@end
