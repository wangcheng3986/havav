//
//  NIGetCDKEY.m
//  GW
//
//  Created by my on 14-7-3.
//  Copyright (c) 2014年 mengy. All rights reserved.
//

#import "NIGetCDKEY.h"

@implementation NIGetCDKEY
- (void)dealloc
{
    
    [super dealloc];
}
/*!
 @method createRequest:dealType:
 @abstract 创建网路请求
 @discussion 获取注册的认证码网络请求URL
 @param loginName 登入名
 @param dealType 处理类型:(1:设置新密码2:修改密码)
 @result 无
 */
- (void)createRequest:(NSString *)loginName dealType:(NSString *)dealType
{
    mRequest = [[[NIOpenUIPRequest alloc] init]autorelease];
    mRequest.fVersion = [NSString stringWithFormat:@"1.0"];
    mRequest.seq = mRequest.getNextSeq;
    mRequest.fName = [NSString stringWithFormat:@"GW.M.READY_FOR_SERVICE"];
    mRequest.time = [NSDate timeIntervalSinceReferenceDate];
    
    NIOpenUIPData *param = [[[NIOpenUIPData alloc]init]autorelease];
    
    [param setString:@"account" value:loginName];
    [param setString:@"dealType" value:dealType];
    [mRequest setParam:param];
    NSLog(@"%@",param);
    mMessage = [mRequest generatePackage];
}
/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求
 @discussion 获取注册的认证码异步网络请求
 @param delegate 代理函数
 @result 无
 */
- (void)sendRequestWithAsync:(id<NIGetCDKEYDelegate>)delegate
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
            [mDelegate onGetCDKResult:nil code:RETURN_PROTOCOL_ERROR errorMsg:[self convertErrorCode:RETURN_PROTOCOL_ERROR]];
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
                    [mDelegate onGetCDKResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
                else if(c==NAVINFO_LOGIN_PRE_PWD_RECOVERY_ACCOUNT_NOEXIST)
                {
                    mErrorCode = NAVINFO_LOGIN_PRE_PWD_RECOVERY_ACCOUNT_NOEXIST;
                    [mDelegate onGetCDKResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
                else if(c==NAVINFO_LOGIN_PRE_PWD_RECOVERY_SEND_FAILURE)
                {
                    mErrorCode = NAVINFO_LOGIN_PRE_PWD_RECOVERY_SEND_FAILURE;
                    [mDelegate onGetCDKResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
                else if(c==NAVINFO_LOGIN_PRE_PWD_RECOVERY_ACCOUNT_OPENDED)
                {
                    mErrorCode = NAVINFO_LOGIN_PRE_PWD_RECOVERY_ACCOUNT_OPENDED;
                    [mDelegate onGetCDKResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
                else if(c==NAVINFO_LOGIN_PRE_PWD_RECOVERY_ACCOUNT_NOBOUND_VEHICLE)
                {
                    mErrorCode = NAVINFO_LOGIN_PRE_PWD_RECOVERY_ACCOUNT_NOBOUND_VEHICLE;
                    [mDelegate onGetCDKResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
                else if(c==NAVINFO_LOGIN_PRE_PWD_RECOVERY_ACCOUNT_UNOPEN)
                {
                    mErrorCode = NAVINFO_LOGIN_PRE_PWD_RECOVERY_ACCOUNT_UNOPEN;
                    [mDelegate onGetCDKResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
                else
                {
                    mErrorCode = RETURN_PROTOCOL_ERROR;
                    [mDelegate onGetCDKResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
            }
            else
            {
                mErrorCode = RETURN_PROTOCOL_ERROR;
                [mDelegate onGetCDKResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
            }
        }
        
    }
    else
    {
        NSLog(@"[Error] The return's data is empty");
        mErrorCode = RETURN_EMPTY;
        [mDelegate onGetCDKResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
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
    [mDelegate onGetCDKResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
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
    [mDelegate onGetCDKResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
}
@end
