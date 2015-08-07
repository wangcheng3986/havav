//
//  NIDeletePOI.m
//  author: wlq
//
//  Created by mac on 13-5-29.
//  Copyright (c) 2013 NavInfo. All rights reserved.
//
//  version 1.0 2013-5-30 wlq create.
//
//

#import "NIDeletePOI.h"

@implementation NIDeletePOI

//var fname = GW.C.PRIVATEPOI.DELETE
//p = {
//	ids : [ {
//		id : "519d8d7ef7436112e530bdd8"
//	}, {
//		id : "519d8de6f7436112e530bdd9"
//	} ]
//}
//create the request message, set the function name and parameter's value.
- (void)createRequest:(NSMutableArray *)ids
{
    mRequest = [[[NIOpenUIPRequest alloc] init]autorelease];
    mRequest.fVersion = [NSString stringWithFormat:@"1.0"];
    mRequest.seq = mRequest.getNextSeq;
    mRequest.fName = [NSString stringWithFormat:@"GW.C.PRIVATEPOI.DELETE"];
    mRequest.time = [NSDate timeIntervalSinceReferenceDate];
    
    //check if the ids is empty.
    if (0 !=[ids count])
    {
        NSMutableArray *tempList = [[[NSMutableArray alloc]init]autorelease];
        for (id obj in ids)
        {
            NSLog(@"obj = %@", obj);
            
            NIOpenUIPData *temp = [[[NIOpenUIPData alloc]init]autorelease];
            [temp setString:@"id" value: obj];
            [tempList addObject:temp.mutableDict];
        }
        
        NIOpenUIPData *param = [[[NIOpenUIPData alloc]init]autorelease];
        [param setObjList:@"ids" list:tempList];
        NSLog(@"param = %@", param.mutableDict);
        
        
        [mRequest setParam:param];
        
        [tempList release];
        
        mMessage = [mRequest generatePackage];
        NSLog(@"the message%@",mMessage);
    }
    else
    {
        NSLog(@"[Warnning] wrong parameter, the ids list is empty");
        mErrorCode = INPUT_PARAM_ERROR;
        [mDelegate onDeleteResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
    }
    
}
/*!
 @method clearDelegate
 @abstract 代理对象释放
 @discussion 代理对象释放
 @result 无
 */
- (void)clearDelegate{
    mDelegate = nil;
}
/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求
 @discussion 发送取消收藏POI的异步网络请求
 @param delegate 代理函数
 @result 无
 */
- (void)sendRequestWithAsync:(id<NIDeletePOIDelegate>)delegate
{
    mDelegate = delegate;
    mNetManager = [[NINetManager alloc] initWithString:mMessage];
    
    //NSLog(@"Message is :%@", mpMessage);
    
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
    NSString *urlmessage = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    NSLog(@"onFinish. the urlmessage =:%@",urlmessage);
    
    if(data)
    {
        NSDictionary *responseResult =  [mNetManager parsingOfJson:data];
        
        if ([[responseResult objectForKey:@"error"]boolValue])
        {
            mErrorCode = RETURN_PROTOCOL_ERROR;
            [mDelegate onDeleteResult:nil code:RETURN_PROTOCOL_ERROR errorMsg:[self convertErrorCode:RETURN_PROTOCOL_ERROR]];
        }
        else
        {
            NSDictionary *header = [responseResult objectForKey:@"header"];
            if ([header objectForKey:@"c"]) {
                int c = [[header objectForKey:@"c"]integerValue];
                if(c==NAVINFO_TOKENID_INVALID)
                {
                    mErrorCode = NAVINFO_TOKENID_INVALID;
                    [mDelegate onDeleteResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
                else if(c==NAVINFO_RESULT_SUCCESS)
                {
                    NSDictionary *resultDic = [responseResult objectForKey:@"body"];
                    if (resultDic != nil) {
                        mErrorCode = NAVINFO_RESULT_SUCCESS;
                        [mDelegate onDeleteResult:resultDic code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                        
                    }
                    else
                    {
                        mErrorCode = RETURN_EMPTY;
                        [mDelegate onDeleteResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                    }
                    
                }
                else
                {
                    mErrorCode = RETURN_PROTOCOL_ERROR;
                    [mDelegate onDeleteResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
            }
            else
            {
                mErrorCode = RETURN_PROTOCOL_ERROR;
                [mDelegate onDeleteResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
            }
        }

    }
    else
    {
        NSLog(@"[Error] The return's data is empty");
        mErrorCode = RETURN_EMPTY;
        [mDelegate onDeleteResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
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
    [mDelegate onDeleteResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
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
    [mDelegate onDeleteResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
}



@end
