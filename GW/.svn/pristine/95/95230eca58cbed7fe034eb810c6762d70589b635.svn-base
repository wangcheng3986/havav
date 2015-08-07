//
//  NICreateContacts.m
//  testLib
//
//  Created by mac on 13-6-4.
//  Copyright (c) 2013 NavInfo. All rights reserved.
//

#import "NICreateContacts.h"

@implementation NICreateContacts

- (NSString *)getMpMessage
{
    return mMessage;
}
/*!
 @method createRequest:telNo:
 @abstract 创建网路请求
 @discussion 创建加入车友的网络请求URL（车友业务层）
 @param name 用户名字
 @param telNo 电话号码
 @result 无
 */
- (void)createRequest:(NSString *) name
                telNo:(NSString *)telNo
{
    mRequest = [[NIOpenUIPRequest alloc] init];
    mRequest.fVersion = @"1.0";
    mRequest.seq = mRequest.getNextSeq;
    mRequest.fName = @"GW.M.CREATE_FRIEND";
    mRequest.time = [NSDate timeIntervalSinceReferenceDate];
    
//    NIOpenUIPData *param = [[[NIOpenUIPData alloc] init] autorelease];
//    if (telNo) {
//        [param setString:@"mobile" value:telNo];
//    }else
//    {
//        mErrorCode = INPUT_PARAM_ERROR;
//        [mDelegate onCreateResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
//    }
//    if (name) {
//        [param setBstr:@"name" value:name];
//    }else
//    {
//        mErrorCode = INPUT_PARAM_ERROR;
//        [mDelegate onCreateResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
//    }
//    NSLog(@"param = %@", param.mutableDict);   
//    [mRequest setParam:param];
    NIOpenUIPData *param = [[[NIOpenUIPData alloc] init] autorelease];
    NIOpenUIPData *temp = [[[NIOpenUIPData alloc] init] autorelease];
    [temp setBstr:@"name" value:name];
    [temp setString:@"phone" value:telNo];
    [param setObject:@"friend" object:temp.mutableDict];
    [mRequest setParam:param];
    NSLog(@"param = %@", param.mutableDict);  
    mMessage = [mRequest generatePackage];
    
}

/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求
 @discussion 发送异步网络请求（黑名单业务层）
 @param delegate 代理函数
 @result 无
 */
- (void)sendRequestWithAsync:(id<NICreateContactsDelegate>)delegate
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
            [mDelegate onCreateContactsResult:nil code:RETURN_PROTOCOL_ERROR errorMsg:[self convertErrorCode:RETURN_PROTOCOL_ERROR]];
        }
        else
        {
            NSDictionary *header = [responseResult objectForKey:@"header"];
            if ([header objectForKey:@"c"]) {
                int c = [[header objectForKey:@"c"]integerValue];
                if(c==NAVINFO_TOKENID_INVALID)
                {
                    mErrorCode = NAVINFO_TOKENID_INVALID;
                    [mDelegate onCreateContactsResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
                else if(c==NAVINFO_RESULT_SUCCESS)
                {
                    NSDictionary *resultDic = [responseResult objectForKey:@"body"];
                    if (resultDic != nil)
                    {
                        mErrorCode = NAVINFO_RESULT_SUCCESS;
                        [mDelegate onCreateContactsResult:resultDic code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                    }
                    else
                    {
                        mErrorCode = RETURN_EMPTY;
                        [mDelegate onCreateContactsResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                    }
                    
                }
                else if (c == NAVINFO_FRIEND_ADD_EXIST)
                {
                    mErrorCode = NAVINFO_FRIEND_ADD_EXIST;
                    [mDelegate onCreateContactsResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
                else if (c == NAVINFO_FRIEND_ADD_NO_T_SERVER)
                {
                    mErrorCode = NAVINFO_FRIEND_ADD_NO_T_SERVER;
                    [mDelegate onCreateContactsResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
                else
                {
                    mErrorCode = RETURN_PROTOCOL_ERROR;
                    [mDelegate onCreateContactsResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
            }
            else
            {
                mErrorCode = RETURN_PROTOCOL_ERROR;
                [mDelegate onCreateContactsResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
            }
            
        }

    }
    else
    {
        NSLog(@"[Error] The return's data is empty");
        mErrorCode = RETURN_EMPTY;
        [mDelegate onCreateContactsResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
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
    [mDelegate onCreateContactsResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
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
    [mDelegate onCreateContactsResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
}

@end
