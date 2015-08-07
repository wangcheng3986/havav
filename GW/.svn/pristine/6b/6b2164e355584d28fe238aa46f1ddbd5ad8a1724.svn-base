//
//  NICreateBlack.m
//  GW
//
//  Created by my on 14-4-1.
//  Copyright (c) 2014年 mengy. All rights reserved.
//

#import "NICreateBlack.h"

@implementation NICreateBlack
- (NSString *)getMpMessage
{
    return mMessage;
}

/*!
 @method createRequest:mobile:userId:
 @abstract 创建网路请求
 @discussion 创建加入黑名单的网络请求URL（黑名单业务层）
 @param name 用户名字
 @param mobile 电话号码
 @param userId 用户唯一标识
 @result 无
 */
- (void)createRequest:(NSString *)name
               mobile:(NSString *)mobile
               userId:(NSString *)userId
{
    mRequest = [[NIOpenUIPRequest alloc] init];
    mRequest.fVersion = @"1.0";
    mRequest.seq = mRequest.getNextSeq;
    mRequest.fName = @"GW.C.BLACKS.CREATE";
    mRequest.time = [NSDate timeIntervalSinceReferenceDate];
    
    NIOpenUIPData *param = [[[NIOpenUIPData alloc] init] autorelease];
    NIOpenUIPData *temp = [[[NIOpenUIPData alloc] init] autorelease];
    if (userId) {
        [temp setString:@"userId" value:userId];
    }
//    if (mobile) {
//        [temp setString:@"mobile" value:mobile];
//    }
    if (name != nil && ![name isEqualToString:@""]) {
        [temp setBstr:@"name" value:name];
    }
    [param setObject:@"black" object:temp.mutableDict];
    
    [mRequest setParam:param];
    
    mMessage = [mRequest generatePackage];
    
}
/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求
 @discussion 发送异步网络请求（黑名单业务层）
 @param delegate 代理函数
 @result 无
 */
- (void)sendRequestWithAsync:(id<NICreateBlackDelegate>)delegate
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
            [mDelegate onCreateResult:nil code:RETURN_PROTOCOL_ERROR errorMsg:[self convertErrorCode:RETURN_PROTOCOL_ERROR]];
        }
        else
        {
            NSDictionary *header = [responseResult objectForKey:@"header"];
            if ([header objectForKey:@"c"]) {
                int c = [[header objectForKey:@"c"]integerValue];
                if(c==NAVINFO_TOKENID_INVALID)
                {
                    mErrorCode = NAVINFO_TOKENID_INVALID;
                    [mDelegate onCreateResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
                else if(c==NAVINFO_RESULT_SUCCESS)
                {
                    NSDictionary *resultDic = [responseResult objectForKey:@"body"];
                    if (resultDic != nil)
                    {
                        
                        mErrorCode = NAVINFO_RESULT_SUCCESS;
                        [mDelegate onCreateResult:resultDic code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                    }
                    else
                    {
                        mErrorCode = RETURN_EMPTY;
                        [mDelegate onCreateResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                    }
                }
                else if (NAVINFO_FRIEND_BLACKLIST_RESULT == c)
                {
                    mErrorCode = NAVINFO_FRIEND_BLACKLIST_RESULT;
                    [mDelegate onCreateResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
                else
                {
                    mErrorCode = RETURN_PROTOCOL_ERROR;
                    [mDelegate onCreateResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
            }
            else
            {
                mErrorCode = RETURN_PROTOCOL_ERROR;
                [mDelegate onCreateResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
            }
            
        }
   
    }
    else
    {
        NSLog(@"[Error] The return's data is empty");
        mErrorCode = RETURN_EMPTY;
        [mDelegate onCreateResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
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
    [mDelegate onCreateResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
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
    [mDelegate onCreateResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
}
@end
