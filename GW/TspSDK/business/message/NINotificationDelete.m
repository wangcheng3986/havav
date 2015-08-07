//
//  NINotificationDelete.m
//  GW
//
//  Created by my on 13-9-3.
//  Copyright (c) 2013年 mengy. All rights reserved.
//

#import "NINotificationDelete.h"

@implementation NINotificationDelete
/*!
 @method createRequest:code:
 @abstract 创建网路请求
 @discussion 消息删除网络请求URL
 @param ntfyList 消息列表
 @param code 消息类型code
 @result 无
 */
- (void)createRequest:(NSMutableArray *)ntfyList code:(int)code
{
    mRequest = [[NIOpenUIPRequest alloc] init];
    mRequest.fVersion = [[NSString alloc] initWithFormat:@"1.0"];
    mRequest.seq = mRequest.getNextSeq;
    mRequest.fName = [[NSString alloc] initWithFormat:@"GW.C.NOTIFICATION.DELETE"];
    mRequest.time = [NSDate timeIntervalSinceReferenceDate];
    
    //check if the ids is empty.
    if (0 !=[ntfyList count])
    {
        NSMutableArray *tempList = [[NSMutableArray alloc]init];
        for (id obj in ntfyList)
        {
            NSLog(@"obj = %@", obj);
            
            NIOpenUIPData *temp = [[NIOpenUIPData alloc]init];
            [temp setInt:@"code" value:code];
            [temp setString:@"entityId" value: obj];
            [tempList addObject:temp.mutableDict];
        }
        
        NIOpenUIPData *param = [[NIOpenUIPData alloc]init];
        [param setObjList:@"ntfyList" list:tempList];
        NSLog(@"param = %@", param.mutableDict);
        [mRequest setParam:param];
        
//        [ntfyList release];
        
        mMessage = [mRequest generatePackage];
        NSLog(@"the message%@",mMessage);
    }
    else
    {
        NSLog(@"[Warnning] wrong parameter, the ids list is empty");
        mErrorCode = INPUT_PARAM_ERROR;
        [mDelegate onDeleteNotificationResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
    }
    
}
/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求
 @discussion 消息删除异步网络请求
 @param delegate 代理函数
 @result 无
 */
- (void)sendRequestWithAsync:(id<NINotificationDeleteDelegate>)delegate
{
    mDelegate = delegate;
    mNetManager = [[NINetManager alloc] initWithString:mMessage];
    
    NSLog(@"Message is :%@", mMessage);
    
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
            [mDelegate onDeleteNotificationResult:nil code:RETURN_PROTOCOL_ERROR errorMsg:[self convertErrorCode:RETURN_PROTOCOL_ERROR]];
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
                    [mDelegate onDeleteNotificationResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
                else if(c==NAVINFO_RESULT_SUCCESS)
                {
                    NSDictionary *resultDic = [responseResult objectForKey:@"body"];
                    if (resultDic != nil)
                    {
                        mErrorCode = NAVINFO_RESULT_SUCCESS;
                        [mDelegate onDeleteNotificationResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                    }
                    else
                    {
                        mErrorCode = RETURN_EMPTY;
                        [mDelegate onDeleteNotificationResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                    }
                }
                else{
                    mErrorCode = RETURN_PROTOCOL_ERROR;
                    [mDelegate onDeleteNotificationResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
            }
            else
            {
                mErrorCode = RETURN_PROTOCOL_ERROR;
                [mDelegate onDeleteNotificationResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
            }
            
        }
       
    }
    else
    {
        NSLog(@"[Error] The return's data is empty");
        mErrorCode = RETURN_EMPTY;
        [mDelegate onDeleteNotificationResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
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
    [mDelegate onDeleteNotificationResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
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
    [mDelegate onDeleteNotificationResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
}

@end
