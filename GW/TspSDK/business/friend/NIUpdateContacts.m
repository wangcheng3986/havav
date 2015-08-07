//
//  NIUpdateContacts.m
//  author: wlq
//
//  Created by mac on 13-5-29.
//  Copyright (c) 2013 NavInfo. All rights reserved.
//
//  version 1.0 2013-5-30 wlq create.
//
//
//

#import "NIUpdateContacts.h"

@implementation NIUpdateContacts

- (id)init
{
    self = [super init];   
    return self;
}

-(void)delloc
{
    [super dealloc];
}

- (NSString *)getMpMessage
{
    return mMessage;
}

/*!
 @method createRequest
 @abstract 创建网路请求
 @discussion 创建请求车友名称备注修改的网络请求URL（车友业务层）
 @param contacts 车友信息
 @result 无
 */
- (void)createRequest:(NSDictionary *) contacts
{
    mRequest = [[NIOpenUIPRequest alloc] init];
    mRequest.fVersion = @"1.0";
    mRequest.seq = mRequest.getNextSeq;
    mRequest.fName = @"GW.M.UPDATE_FRIEND";
    mRequest.time = [NSDate timeIntervalSinceReferenceDate];
    NIOpenUIPData *param = [[[NIOpenUIPData alloc] init] autorelease];
    NIOpenUIPData *temp = [[[NIOpenUIPData alloc] init] autorelease];
    [temp setString:@"id" value:[contacts objectForKey:@"id"]];
    [temp setBstr:@"name" value:[contacts objectForKey:@"name"]];
    [temp setString:@"phone" value:[contacts objectForKey:@"phone"]];
    [param setObject:@"friend" object:temp.mutableDict];
    [mRequest setParam:param];
    NSLog(@"param = %@", param.mutableDict);
    mMessage = [mRequest generatePackage];
}


/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求（车友业务层）
 @discussion 发送车友名称备注修改的异步网络请求
 @param delegate 代理函数
 @result 无
 */
- (void)sendRequestWithAsync:(id<NIUpdateContactsDelegate>)delegate
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
            [mDelegate onUpdateResult:nil code:RETURN_PROTOCOL_ERROR errorMsg:[self convertErrorCode:RETURN_PROTOCOL_ERROR]];
        }
        else
        {
            NSDictionary *header = [responseResult objectForKey:@"header"];
            if ([header objectForKey:@"c"]) {
                int c = [[header objectForKey:@"c"]integerValue];
                if(c==NAVINFO_TOKENID_INVALID)
                {
                    mErrorCode = NAVINFO_TOKENID_INVALID;
                    [mDelegate onUpdateResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
                else if(c==NAVINFO_RESULT_SUCCESS)
                {
                    NSDictionary *resultDic = [responseResult objectForKey:@"body"];
                    if (resultDic != nil)
                    {
                        mErrorCode = NAVINFO_RESULT_SUCCESS;
                        [mDelegate onUpdateResult:resultDic code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                    }
                    else
                    {
                        mErrorCode = RETURN_EMPTY;
                        [mDelegate onUpdateResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                    }
                    
                }
                else
                {
                    mErrorCode = RETURN_PROTOCOL_ERROR;
                    [mDelegate onUpdateResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }

            }
            else
            {
                mErrorCode = RETURN_PROTOCOL_ERROR;
                [mDelegate onUpdateResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
            }
        }
        
    }
    else
    {
        NSLog(@"[Error] The return's data is empty");
        mErrorCode = RETURN_EMPTY;
        [mDelegate onUpdateResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
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
    [mDelegate onUpdateResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
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
    [mDelegate onUpdateResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
}


@end
