//
//  NILogout.m
//  GW
//
//  Created by my on 13-6-18.
//  Copyright (c) 2013年 liutch. All rights reserved.
//


#import "NILogout.h"

@implementation NILogout
- (void)dealloc
{
    
    [super dealloc];
}
/*!
 @method createRequest
 @abstract 创建网路请求（登入登出业务层）
 @discussion 创建用户登出的网络请求URL
 @result 无
 */
- (void)createRequest
{
    mRequest = [[[NIOpenUIPRequest alloc] init]autorelease];
    mRequest.fVersion = [NSString stringWithFormat:@"1.0"];
    mRequest.seq = mRequest.getNextSeq;
    mRequest.fName = [NSString stringWithFormat:@"GW.M.LOGOUT"];
    mRequest.time = [NSDate timeIntervalSinceReferenceDate];
    
//    NIOpenUIPData *param = [[NIOpenUIPData alloc]init];
    
//    [param setString:@"tk" value:[logoutInfo objectForKey:@"tk"]];
//    [param setString:@"tk" value:[NIOpenUIPRequest getTokenID]];
//    [param setString:@"tk" value:@"xxxx-xxxxxx-xxxxx-b0815029-818a-4ee1-9851-acc9a27c11a0-toknid"];
    [mRequest setParam:NULL];
    mMessage = [mRequest generatePackage];
}
/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求（登入登出业务层）
 @discussion 发送用户登出的异步网络请求
 @param delegate 代理函数
 @result 无
 */
- (void)sendRequestWithAsync:(id<NILogoutDelegate>)delegate
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
    NSLog(@"%@",data);
    if(data)
    {
       
        NSDictionary *responseResult =  [mNetManager parsingOfJson:data];

        if ([[responseResult objectForKey:@"error"]boolValue])
        {
            mErrorCode = RETURN_PROTOCOL_ERROR;
            [mDelegate onLogoutResult:nil code:RETURN_PROTOCOL_ERROR errorMsg:[self convertErrorCode:RETURN_PROTOCOL_ERROR]];
        }
        else
        {
            NSDictionary *header = [responseResult objectForKey:@"header"];
            if ([header objectForKey:@"c"]) {
                int c = [[header objectForKey:@"c"]integerValue];
                if(c==NAVINFO_RESULT_SUCCESS)
                {
                    mErrorCode = NAVINFO_RESULT_SUCCESS;
                    [mDelegate onLogoutResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
                else
                {
                    mErrorCode = RETURN_PROTOCOL_ERROR;
                    [mDelegate onLogoutResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
            }
            else
            {
                mErrorCode = RETURN_PROTOCOL_ERROR;
                [mDelegate onLogoutResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
            }
            
        }
        
    }
    else
    {
        NSLog(@"[Error] The return's data is empty");
        mErrorCode = RETURN_EMPTY;
        [mDelegate onLogoutResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
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
    [mDelegate onLogoutResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
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
    [mDelegate onLogoutResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
}

@end