//
//  NILogin.m
//  GW
//
//  Created by my on 13-6-4.
//  Copyright (c) 2013年 liutch. All rights reserved.
//

#import "NILogin.h"

@implementation NILogin
- (void)dealloc
{
    
    [super dealloc];
}
/*!
 @method createRequest
 @abstract 创建网路请求（登入登出业务层）
 @discussion 创建用户登入的网络请求URL
 @param loginInfo 登入信息
 @result 无
 */
- (void)createRequest:(NSDictionary *) loginInfo
{
    App *app = [App getInstance];
    mRequest = [[[NIOpenUIPRequest alloc] init]autorelease];
    mRequest.fVersion = [NSString stringWithFormat:@"1.0"];
    mRequest.seq = mRequest.getNextSeq;
    mRequest.fName = [NSString stringWithFormat:@"GW.M.IOS_LOGIN"];
    mRequest.time = [NSDate timeIntervalSinceReferenceDate];
    
    NIOpenUIPData *param = [[[NIOpenUIPData alloc]init]autorelease];
    
    [param setString:@"account" value:[loginInfo objectForKey:@"loginName"]];
    [param setString:@"pwd" value:[loginInfo objectForKey:@"password"]];
    if (app.deviceTokenId) {
    
        [param setString:@"deviceToken" value:app.deviceTokenId];
    }
    else
    {
        [param setString:@"deviceToken" value:@""];
    }
    [mRequest setParam:param];
    mMessage = [mRequest generatePackage];
}
/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求（登入登出业务层）
 @discussion 发送用户登入的异步网络请求
 @param delegate 代理函数
 @result 无
 */
- (void)sendRequestWithAsync:(id<NILoginDelegate>)delegate
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
          [mDelegate onLoginResult:nil code:RETURN_PROTOCOL_ERROR errorMsg:[self convertErrorCode:RETURN_PROTOCOL_ERROR]];
        }
       else
        {
            NSDictionary *header = [responseResult objectForKey:@"header"];
            if ([header objectForKey:@"c"]) {
                int c = [[header objectForKey:@"c"]integerValue];
                if(c==NAVINFO_LOGIN_PWD_ERROR)//用户名密码错误
                {
                    mErrorCode = NAVINFO_LOGIN_PWD_ERROR;
                    [mDelegate onLoginResult:nil code:NAVINFO_LOGIN_PWD_ERROR errorMsg:[self convertErrorCode:mErrorCode]];
                }
                else if(c==NAVINFO_LOGIN_ACCOUNT_NOEXIST)//账户不存在
                {
                    mErrorCode = NAVINFO_LOGIN_ACCOUNT_NOEXIST;
                    [mDelegate onLoginResult:nil code:NAVINFO_LOGIN_ACCOUNT_NOEXIST errorMsg:[self convertErrorCode:mErrorCode]];
                }
                else if(c==NAVINFO_LOGIN_NO_VEHICLES)//没有车
                {
                    mErrorCode = NAVINFO_LOGIN_NO_VEHICLES;
                    [mDelegate onLoginResult:nil code:NAVINFO_LOGIN_NO_VEHICLES errorMsg:[self convertErrorCode:mErrorCode]];
                }
                else if (c==NAVINFO_LOGIN_NO_DREDGE_OR_CLOSE)
                {
                    mErrorCode = NAVINFO_LOGIN_NO_DREDGE_OR_CLOSE;
                    [mDelegate onLoginResult:nil code:NAVINFO_LOGIN_NO_DREDGE_OR_CLOSE errorMsg:[self convertErrorCode:mErrorCode]];
                }
                else if(c==NAVINFO_RESULT_SUCCESS)
                {
                    NSDictionary *resultDic = [responseResult objectForKey:@"body"];
                    if (resultDic != nil) {
                        mErrorCode = NAVINFO_RESULT_SUCCESS;
                        [mDelegate onLoginResult:resultDic code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                    }
                    else
                    {
                        mErrorCode = RETURN_EMPTY;
                        [mDelegate onLoginResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                    }
                    
                }
                else
                {
                    mErrorCode = RETURN_PROTOCOL_ERROR;
                    [mDelegate onLoginResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
            }
            else
            {
                mErrorCode = RETURN_PROTOCOL_ERROR;
                [mDelegate onLoginResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
            }

        }
    }
    else
    {
        NSLog(@"[Error] The return's data is empty");
        mErrorCode = RETURN_EMPTY;
        [mDelegate onLoginResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
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
    [mDelegate onLoginResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
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
    [mDelegate onLoginResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
}


@end
