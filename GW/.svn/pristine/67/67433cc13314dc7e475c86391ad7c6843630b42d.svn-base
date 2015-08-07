//
//  NIFeedBack.m
//  author: wlq
//
//  Created by mac on 13-5-29.
//  Copyright (c) 2013 NavInfo. All rights reserved.
//
//  version 1.0 2013-5-30 wlq create.
//
//
//

#import "NIFeedBack.h"

@implementation NIFeedBack
/*!
 @method getMpMessage
 @abstract 获取信息
 @discussion 意见反馈的url字符串
 @result 请求字符串
 */
- (NSString *)getMpMessage
{
    return mMessage;
}
/*!
 @method createRequest:content:type:
 @abstract 创建网路请求
 @discussion 意见反馈网络请求URL
 @param title 意见反馈标题
 @param content 意见反馈内容
 @param type 反馈类型（1:系统bug;2:用户体验;3:其他意见）
 @result 无
 */
- (void)createRequest:(NSString *) title content:(NSString *)content type:(int)type
{
    mRequest = [[[NIOpenUIPRequest alloc] init]autorelease];
    mRequest.fVersion = [NSString stringWithFormat:@"1.0"];
    mRequest.seq = mRequest.getNextSeq;
    mRequest.fName = [NSString stringWithFormat:@"GW.M.FEEDBACK.CREATE"];
//    mRequest.fName = [NSString stringWithFormat:@"GW.C.CRUD.FEEDBACK.CREATE"];
    
    mRequest.time = [NSDate timeIntervalSinceReferenceDate];
    
    NIOpenUIPData *param = [[[NIOpenUIPData alloc]init]autorelease];
    if (title == nil || content == nil ) {
        mErrorCode = INPUT_PARAM_ERROR;
        [mDelegate onFeedBackResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];

    }
    else
    {
        [param setBstr:@"title" value:title];
        [param setBstr:@"content" value:content];
        [param setInt:@"type" value:type];
        [mRequest setParam:param];
        mMessage = [mRequest generatePackage];
    }
    
}

// Only need to read the "id" from result.
//r = {
//    "id" : "5199b3815c9388ea0da26eed"
//}
/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求
 @discussion 意见反馈异步网络请求
 @param delegate 代理函数
 @result 无
 */
- (void)sendRequestWithAsync:(id<NIFeedBackDelegate>)delegate
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
            [mDelegate onFeedBackResult:nil code:RETURN_PROTOCOL_ERROR errorMsg:[self convertErrorCode:RETURN_PROTOCOL_ERROR]];
        }
        else
        {
            NSDictionary *header = [responseResult objectForKey:@"header"];
            if ([header objectForKey:@"c"])
            {
                int c = [[header objectForKey:@"c"]integerValue];
                if(c==NAVINFO_RESULT_SUCCESS)
                {
                    mErrorCode = NAVINFO_RESULT_SUCCESS;
                    [mDelegate onFeedBackResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                    
                }
                else
                {
                    mErrorCode = RETURN_PROTOCOL_ERROR;
                    [mDelegate onFeedBackResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
            }
            else
            {
                mErrorCode = RETURN_PROTOCOL_ERROR;
                [mDelegate onFeedBackResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
            }
        }
        
    }
    else
    {
        NSLog(@"[Error] The return's data is empty");
        mErrorCode = RETURN_EMPTY;
        [mDelegate onFeedBackResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
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
    [mDelegate onFeedBackResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
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
    [mDelegate onFeedBackResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
}

@end