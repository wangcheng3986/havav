//
//  NIRequestLocation.m
//  author: wlq
//
//  Created by mac on 13-5-29.
//  Copyright (c) 2013 NavInfo. All rights reserved.
//
//  version 1.0 2013-5-30 wlq create.
//
//

#import "NIRequestLocation.h"

@implementation NIRequestLocation

- (NSString *)getMpMessage
{
    return mMessage;
}
/*!
 @method createRequest:rqDesc:rpUserId:s2c:
 @abstract 创建网路请求
 @discussion 创建请求车友列表的网络请求URL（车友业务层）
 @param rqSrc 来源
 @param rqDesc 内容
 @param rpUserId 车友userid
 @param s2c 位置发送到车机
 @result 无
 */
- (void)createRequest:(NSString *) rqSrc
               rqDesc:(NSString *)rqDesc
                rpUserId:(NSString *)rpUserId
                  s2c:(NSString *)s2c
{
    mRequest = [[[NIOpenUIPRequest alloc] init]autorelease];
    mRequest.fVersion = [NSString stringWithFormat:@"1.0"];
    mRequest.seq = mRequest.getNextSeq;
    mRequest.fName = [NSString stringWithFormat:@"GW.M.SEND_FRIEND_LOCATION_REQUEST"];
    mRequest.time = [NSDate timeIntervalSinceReferenceDate];
    
    NIOpenUIPData *param = [[[NIOpenUIPData alloc]init]autorelease];
    
    [param setBstr:@"description" value:rqDesc];
    [param setString:@"friendUserId" value:rpUserId];
    [param setBoolean:@"s2c" value:s2c];
    [mRequest setParam:param];
    
    mMessage = [mRequest generatePackage];
    
}
/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求（车友业务层）
 @discussion 发送车友位置请求的异步网络请求
 @param delegate 代理函数
 @result 无
 */
- (void)sendRequestWithAsync:(id<NIRequestLocationDelegate>)delegate
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
            [mDelegate onRequestLocationResult:nil code:RETURN_PROTOCOL_ERROR errorMsg:[self convertErrorCode:RETURN_PROTOCOL_ERROR]];
        }
        else
        {
            NSDictionary *header = [responseResult objectForKey:@"header"];
            if ([header objectForKey:@"c"]) {
                int c = [[header objectForKey:@"c"]integerValue];
                if(c==NAVINFO_TOKENID_INVALID)
                {
                    mErrorCode = NAVINFO_TOKENID_INVALID;
                    [mDelegate onRequestLocationResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
                else if(c == NAVINFO_FRIEND_REQUEST_FREQUENT)
                {
                    mErrorCode = NAVINFO_FRIEND_REQUEST_FREQUENT;
                    [mDelegate onRequestLocationResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
                else if(c == NAVINFO_FRIEND_REQUEST_FRIEND_NO_CAR)
                {
                    mErrorCode = NAVINFO_FRIEND_REQUEST_FRIEND_NO_CAR;
                    [mDelegate onRequestLocationResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
                else if(c==NAVINFO_RESULT_SUCCESS)
                {
                    NSDictionary *resultDic = [responseResult objectForKey:@"body"];
                    if (resultDic != nil)
                    {
                        mErrorCode = NAVINFO_RESULT_SUCCESS;
                        [mDelegate onRequestLocationResult:resultDic code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                    }
                    else
                    {
                        mErrorCode = RETURN_EMPTY;
                        [mDelegate onRequestLocationResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                    }
                    
                }
                else
                {
                    mErrorCode = RETURN_PROTOCOL_ERROR;
                    [mDelegate onRequestLocationResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
            }
            else
            {
                mErrorCode = RETURN_PROTOCOL_ERROR;
                [mDelegate onRequestLocationResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
            }
            
        }
        
    }
    else
    {
        NSLog(@"[Error] The return's data is empty");
        mErrorCode = RETURN_EMPTY;
        [mDelegate onRequestLocationResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
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
    [mDelegate onRequestLocationResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
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
    [mDelegate onRequestLocationResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
}
@end
