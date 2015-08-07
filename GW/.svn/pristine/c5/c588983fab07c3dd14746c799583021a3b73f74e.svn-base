//
//  NIDeleteBlack.m
//  GW
//
//  Created by my on 14-4-2.
//  Copyright (c) 2014年 mengy. All rights reserved.
//

#import "NIDeleteBlack.h"

@implementation NIDeleteBlack
/*!
 @method createRequest
 @abstract 创建网路请求
 @discussion 创建删除黑名单的网络请求URL（黑名单业务层）
 @param ids 黑名单ID集合
 @result 无
 */
- (void)createRequest:(NSArray *)ids
{
    
    mRequest = [[NIOpenUIPRequest alloc] init];
    mRequest.fVersion = @"1.0";
    mRequest.seq = mRequest.getNextSeq;
    mRequest.fName = @"GW.M.DELETE_BLACKS";
    mRequest.time = [NSDate timeIntervalSinceReferenceDate];
    
    //check if the ids is empty.
    if (0 !=[ids count])
    {
//        以前方法，待新方法稳定后可进行删除
//        NSMutableArray *tempList = [[NSMutableArray alloc]init];
//        for (id obj in ids)
//        {
//            NSLog(@"obj = %@", obj);
//            
//            NIOpenUIPData *temp = [[[NIOpenUIPData alloc] init] autorelease];
//            [temp setString:@"id" value: [obj objectForKey:@"id"]];
//            [tempList addObject:temp.mutableDict];
//        }
        
//        NSMutableArray *tempList = [[NSMutableArray alloc]init];
//        for (int i = 0; i < ids.count; i++) {
//            NIOpenUIPData *temp = [[[NIOpenUIPData alloc] init] autorelease];
//            [temp setString:@"id" value:[ids objectAtIndex:i]];
//            [tempList addObject:temp.mutableDict];
//        }
        
        NIOpenUIPData *param = [[[NIOpenUIPData alloc] init] autorelease];
        [param setObjList:@"idList" list:ids];
        NSLog(@"param = %@", param.mutableDict);
        
        
        [mRequest setParam:param];
        
     //   [tempList release];
        
        mMessage = [mRequest generatePackage];
        NSLog(@"the message%@",mMessage);
    }
    else
    {
        NSLog(@"[Warnning] wrong parameter, the ids list is empty");
        mErrorCode = INPUT_PARAM_ERROR;
        [mDelegate onDeleteBlackResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
    }
    
}
/*!
 @method sendRequestWithAsync
 @abstract 发送删除黑名单异步网络请求
 @discussion 发送异步网络请求（黑名单业务层）
 @param delegate 代理函数
 @result 无
 */
- (void)sendRequestWithAsync:(id<NIDeleteBlackDelegate>)delegate
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
            [mDelegate onDeleteBlackResult:nil code:RETURN_PROTOCOL_ERROR errorMsg:[self convertErrorCode:RETURN_PROTOCOL_ERROR]];
        }
        else
        {
            NSDictionary *header = [responseResult objectForKey:@"header"];
            if ([header objectForKey:@"c"]) {
                int c = [[header objectForKey:@"c"]integerValue];
                if(c==NAVINFO_TOKENID_INVALID)
                {
                    mErrorCode = NAVINFO_TOKENID_INVALID;
                    [mDelegate onDeleteBlackResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
                else if(c==NAVINFO_RESULT_SUCCESS)
                {
                    
                    mErrorCode = NAVINFO_RESULT_SUCCESS;
                    [mDelegate onDeleteBlackResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
                else
                {
                    mErrorCode = RETURN_PROTOCOL_ERROR;
                    [mDelegate onDeleteBlackResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
            }
            else
            {
                mErrorCode = RETURN_PROTOCOL_ERROR;
                [mDelegate onDeleteBlackResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
            }
        }
        
    }
    else
    {
        NSLog(@"[Error] The return's data is empty");
        mErrorCode = RETURN_EMPTY;
        [mDelegate onDeleteBlackResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
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
    [mDelegate onDeleteBlackResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
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
    [mDelegate onDeleteBlackResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
}
@end
