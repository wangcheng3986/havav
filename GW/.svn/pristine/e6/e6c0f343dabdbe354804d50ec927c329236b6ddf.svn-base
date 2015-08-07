//
//  NIGetContactsList.m
//  author: wlq
//
//  Created by mac on 13-5-29.
//  Copyright (c) 2013 NavInfo. All rights reserved.
//
//  version 1.0 2013-5-30 wlq create.
//
//
//

#import "NIGetContactsList.h"

@implementation NIGetContactsList
@synthesize mDelegate;

- (NSString *)getMpMessage
{
    return mMessage;
}
/*!
 @method createRequest
 @abstract 创建网路请求
 @discussion 创建请求车友列表的网络请求URL（车友业务层）
 @result 无
 */
- (void)createRequest
{
    mRequest = [[NIOpenUIPRequest alloc] init];
    mRequest.fVersion = @"1.0";
    mRequest.seq = mRequest.getNextSeq;
    mRequest.fName = @"GW.M.GET_FRIEND_LIST";
    mRequest.time = [NSDate timeIntervalSinceReferenceDate];
    
    NIOpenUIPData *param = nil;
    
    [mRequest setParam:param];
       
    mMessage = [mRequest generatePackage];

}

/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求（车友业务层）
 @discussion 发送请求车友列表异步网络请求
 @param delegate 代理函数
 @result 无
 */
- (void)sendRequestWithAsync:(id<NIGetContactsListDelegate>)delegate
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
            [mDelegate onGetListResult:nil code:RETURN_PROTOCOL_ERROR errorMsg:[self convertErrorCode:RETURN_PROTOCOL_ERROR]];
        }
        else
        {
            NSDictionary *header = [responseResult objectForKey:@"header"];
            if ([header objectForKey:@"c"]) {
                int c = [[header objectForKey:@"c"]integerValue];
                if(c==NAVINFO_TOKENID_INVALID)
                {
                    mErrorCode = NAVINFO_TOKENID_INVALID;
                    [mDelegate onGetListResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
                else if(c==NAVINFO_RESULT_SUCCESS)
                {
                    NSDictionary *resultDic = [responseResult objectForKey:@"body"];
                    if (resultDic != nil)
                    {
                        mErrorCode = NAVINFO_RESULT_SUCCESS;
                        if (mDelegate) {
                            [mDelegate onGetListResult:resultDic code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                        }
                    }
                    else
                    {
                        mErrorCode = RETURN_EMPTY;
                        [mDelegate onGetListResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                    }
                                        
                }
                else{
                    mErrorCode = RETURN_PROTOCOL_ERROR;
                    [mDelegate onGetListResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
            }
            else
            {
                mErrorCode = RETURN_PROTOCOL_ERROR;
                [mDelegate onGetListResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
            }
            
        }
        
    }
    else
    {
        NSLog(@"[Error] The return's data is empty");
        mErrorCode = RETURN_EMPTY;
        [mDelegate onGetListResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
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
    [mDelegate onGetListResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
}

- (void)onCancel
{
    mErrorCode = USER_CANCEL_ERROR;
    [mDelegate onGetListResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
}

@end
