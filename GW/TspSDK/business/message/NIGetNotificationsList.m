//
//  NIGetNotificationsList.m
//  author: wlq
//
//  Created by mac on 13-5-29.
//  Copyright (c) 2013 NavInfo. All rights reserved.
//
//  version 1.0 2013-5-30 wlq create.
//
//
//

#import "NIGetNotificationsList.h"

@implementation NIGetNotificationsList

- (void)dealloc
{
    [mRequest release];
    [mNetManager release];
    [super dealloc];
}

- (NSString *)getMpMessage
{
    return mMessage;
}
/*!
 @method createRequest:targetId:isNeedSrc:
 @abstract 创建网路请求
 @discussion 消息轮询网络请求URL
 @param lastReqTime 最后一次请求时间
 @param targetId 目前ID
 @param isNeedSrc 预留字段
 @result 无
 */
- (void)createRequest:(long long) lastReqTime
             targetId:(NSString *) targetId
            isNeedSrc:(NSString *) isNeedSrc
{
    mRequest = [[[NIOpenUIPRequest alloc] init]autorelease];
    mRequest.fVersion = @"1.0";
    mRequest.seq = mRequest.getNextSeq;
    mRequest.fName = @"GW.M.GET_MESSAGE_LIST";
    mRequest.time = [NSDate timeIntervalSinceReferenceDate];
    
    [mRequest setParam:NULL];
    mMessage = [mRequest generatePackage];
}
/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求
 @discussion 消息轮询异步网络请求
 @param delegate 代理函数
 @result 无
 */
- (void)sendRequestWithAsync:(id<NIGetNotificationsListDelegate>)delegate
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
            if ([header objectForKey:@"c"])
            {
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
                        [mDelegate onGetListResult:resultDic code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                    }
                    else
                    {
                        mErrorCode = RETURN_EMPTY;
                        [mDelegate onGetListResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                    }
                }
                else
                {
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
/*!
 @method onCancel
 @abstract 取消请求
 @discussion 取消网络请求回调此函数
 @result 无
 */
- (void)onCancel
{
    mErrorCode = USER_CANCEL_ERROR;
    [mDelegate onGetListResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
}

////我滴广播
//-(void)broadcast
//{
//    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
//    
//    // 取得ios系统唯一的全局的广播站 通知中心
//    
//    NSString *name = @"消息有变";
//    
//    UIColor *c = [UIColor redColor];
//    
//    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
//                          
//                          name, @"ThemeName",
//                          
//                          c, @"ThemeMessage", nil];
//    
//    //设置广播内容
//    
//    [nc postNotificationName:@"ChangeTheme" object:self userInfo:dict];
//    
//    //将内容封装到广播中 给ios系统发送广播
//    
//    // ChangeTheme频道
//}
@end
