//
//  NIGetLastTrack.m
//  TestNetInterface
//
//  Created by mac on 13-6-3.
//  Copyright (c) 2013年 wlq. All rights reserved.
//

#import "NIGetLastTrack.h"

@implementation NIGetLastTrack
@synthesize mDelegate;
//@synthesize mResultInfo;
//create the request message, set the function name and parameter's value.
// get last poi
//var fname = GW.C.TRACK.GET_LAST
//p = {
//    "id" : "13501321234",
//    "idType" : "tsim"
//}
/*!
 @method createRequest:type:
 @abstract 创建网路请求
 @discussion 上次车机所在位置网络请求URL
 @param trackID sim卡号
 @param type 预留
 @result 无
 */
- (void)createRequest:(NSString *) trackID type:(NSString *) type
{
    mRequest = [[[NIOpenUIPRequest alloc] init]autorelease];
    mRequest.fVersion = [NSString stringWithFormat:@"1.0"];
    mRequest.seq = mRequest.getNextSeq;
    mRequest.fName = [NSString stringWithFormat:@"GW.M.GET_LAST_POINT"];
    mRequest.time = [NSDate timeIntervalSinceReferenceDate];
    
    
    NIOpenUIPData *param = [[[NIOpenUIPData alloc]init]autorelease];
    [param setString:@"vin" value:trackID];
//    [param setString:@"idType" value:type];
    [mRequest setParam:param];
    
    mMessage = [mRequest generatePackage];
}
/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求
 @discussion 上次车机所在位置异步网络请求
 @param delegate 代理函数
 @result 无
 */
- (void)sendRequestWithAsync:(id<NIGetLastTrackDelegate>)delegate
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
            if (mDelegate) {
                [mDelegate onResult:nil code:RETURN_PROTOCOL_ERROR errorMsg:[self convertErrorCode:RETURN_PROTOCOL_ERROR]];
            }
        
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
                    if (mDelegate) {
                        [mDelegate onResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                    }
                    
                }
                else if(c==NAVINFO_RESULT_SUCCESS)
                {
                    NSDictionary *resultDic = [responseResult objectForKey:@"body"];
                    if (resultDic != nil)
                    {
                        NSMutableDictionary * infomantions = [[[NSMutableDictionary alloc] init]autorelease];
                        [infomantions setValue:[NSString stringWithFormat:@"%f",[[resultDic objectForKey:@"lon"]doubleValue]] forKey:@"lon"];
                        [infomantions setValue:[NSString stringWithFormat:@"%f",[[resultDic objectForKey:@"lat"]doubleValue]] forKey:@"lat"];
                        [infomantions setValue:[resultDic objectForKey:@"uploadTime"] forKey:@"time"];
                        [infomantions setValue:[resultDic objectForKey:@"vin"] forKey:@"vin"];
                        mErrorCode = NAVINFO_RESULT_SUCCESS;
                        if(mDelegate)
                        {
                            [mDelegate onResult:infomantions code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                        }
                        
                    }
                    else
                    {
                        mErrorCode = RETURN_EMPTY;
                        if (mDelegate) {
                            [mDelegate onResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                        }
                    }
                }
                else
                {
                    mErrorCode = RETURN_PROTOCOL_ERROR;
                    if (mDelegate) {
                        [mDelegate onResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                    }
                }
            }
            else
            {
                mErrorCode = RETURN_PROTOCOL_ERROR;
                if (mDelegate) {
                    [mDelegate onResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
            }
        }
    }
    else
    {
        NSLog(@"[Error] The return's data is empty");
        mErrorCode = RETURN_EMPTY;
        if (mDelegate) {
            [mDelegate onResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
        }
    
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
    if (mDelegate) {
        [mDelegate onResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
    }

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
    if (mDelegate) {
        [mDelegate onResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
    }

}
@end
