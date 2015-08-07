//
//  NISetPWD.m
//  GW
//
//  Created by my on 14-7-3.
//  Copyright (c) 2014年 mengy. All rights reserved.
//

#import "NISetPWD.h"

@implementation NISetPWD
- (void)dealloc
{
    
    [super dealloc];
}
/*!
 @method createRequest:loginName:smsCode:
 @abstract 创建网路请求
 @discussion 用户设置密码网络请求URL
 @param loginName 登入名
 @param smsCode 认证码
 @result 无
 */
- (void)createRequest:(NSString *)pwd loginName:(NSString *)loginName smsCode:(NSString *)smsCode
{
    mRequest = [[[NIOpenUIPRequest alloc] init]autorelease];
    mRequest.fVersion = [NSString stringWithFormat:@"1.0"];
    mRequest.seq = mRequest.getNextSeq;
    mRequest.fName = [NSString stringWithFormat:@"GW.M.OPEN_UP_SERVICE"];
    mRequest.time = [NSDate timeIntervalSinceReferenceDate];
    
    NIOpenUIPData *param = [[[NIOpenUIPData alloc]init]autorelease];
    [param setString:@"pwd" value:pwd];
    [param setString:@"account" value:loginName];
    [param setString:@"verifyCode" value:smsCode];
    [mRequest setParam:param];
    NSLog(@"%@",param);
    mMessage = [mRequest generatePackage];
}
/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求
 @discussion 用户设置密码异步网络请求
 @param delegate 代理函数
 @result 无
 */
- (void)sendRequestWithAsync:(id<NISetPWDDelegate>)delegate
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
            [mDelegate onSetPWDResult:nil code:RETURN_PROTOCOL_ERROR errorMsg:[self convertErrorCode:RETURN_PROTOCOL_ERROR]];
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
                    [mDelegate onSetPWDResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
                else if (c==NAVINFO_LOGIN_PWD_RECOVERY_SMSCODE_ERROR)
                {
                    mErrorCode = NAVINFO_LOGIN_PWD_RECOVERY_SMSCODE_ERROR;
                    [mDelegate onSetPWDResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
                else if (c==NAVINFO_LOGIN_PWD_RECOVERY_ACCOUNT_NOEXIST)
                {
                    mErrorCode = NAVINFO_LOGIN_PWD_RECOVERY_ACCOUNT_NOEXIST;
                    [mDelegate onSetPWDResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
                else if (c==NAVINFO_LOGIN_PWD_RECOVERY_ACCOUNT_OPENDED)
                {
                    mErrorCode = NAVINFO_LOGIN_PWD_RECOVERY_ACCOUNT_OPENDED;
                    [mDelegate onSetPWDResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
                else if (c==NAVINFO_LOGIN_PWD_RECOVERY_ACCOUNT_NO_VEHICLES)
                {
                    mErrorCode = NAVINFO_LOGIN_PWD_RECOVERY_ACCOUNT_NO_VEHICLES;
                    [mDelegate onSetPWDResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
                else
                {
                    mErrorCode = RETURN_PROTOCOL_ERROR;
                    [mDelegate onSetPWDResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
            }
            else
            {
                mErrorCode = RETURN_PROTOCOL_ERROR;
                [mDelegate onSetPWDResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
            }
        }
        
    }
    else
    {
        NSLog(@"[Error] The return's data is empty");
        mErrorCode = RETURN_EMPTY;
        [mDelegate onSetPWDResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
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
    [mDelegate onSetPWDResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
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
    [mDelegate onSetPWDResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
}
@end
