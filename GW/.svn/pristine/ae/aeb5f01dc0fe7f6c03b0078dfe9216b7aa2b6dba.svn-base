//
//  ElecFenceModifyNetManager.m
//  GW
//
//  Created by wqw on 14-9-3.
//  Copyright (c) 2014年 mengy. All rights reserved.
//

#import "ElecFenceModifyNetManager.h"
#import "ElecFenceData.h"

@implementation ElecFenceModifyNetManager
/*!
 @method modifyElecRequest:
 @abstract 创建网路请求
 @discussion 创建电子围栏修改的网络请求URL
 @param eleclist 电子围栏列表
 @result 无
 */
- (void)modifyElecRequest:(NSArray *)eleclist
{
    mRequest = [[NIOpenUIPRequest alloc] init];
    mRequest.fVersion = @"1.0";
    mRequest.fName = @"GW.M.UPDATE_ELEC_FENCE";
    mRequest.time = [NSDate timeIntervalSinceReferenceDate];
    NIOpenUIPData *param = [[[NIOpenUIPData alloc] init] autorelease];
    
    ElecFenceData *EFData = [eleclist objectAtIndex:0];
    
    NIOpenUIPData *temp = [[[NIOpenUIPData alloc] init] autorelease];
    
    [temp setBstr:@"id" value:EFData.elecFenceId];
    [temp setBstr:@"name" value:EFData.name];
    [temp setBstr:@"valid" value:EFData.valid];
    [temp setBstr:@"address" value:EFData.address];
    [temp setDouble:@"lon" value:EFData.lon];
    [temp setDouble:@"lat" value:EFData.lat];
    [temp setInt:@"radius" value:EFData.radius];
    
    
    [param setObject:@"elecFence" object:temp.mutableDict];
    
    [mRequest setParam:param];
    mMessage = [mRequest generatePackage];
    
    
}
/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求
 @discussion 发送异步网络请求（业务层）
 @param delegate 代理函数
 @result 无
 */
- (void)sendRequestWithAsync:(id<ElecFenceModifyNetManagerDelegate>)delegate
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
        NSLog(@" %@",responseResult);
        if ([[responseResult objectForKey:@"error"]boolValue])
        {
            mErrorCode = RETURN_PROTOCOL_ERROR;
            [mDelegate onElecFenceModifyResult:nil code:RETURN_PROTOCOL_ERROR errorMsg:[self convertErrorCode:RETURN_PROTOCOL_ERROR]];
        }
        else
        {
            NSDictionary *header = [responseResult objectForKey:@"header"];
            if ([header objectForKey:@"c"]) {
                int c = [[header objectForKey:@"c"]integerValue];
                if(c==NAVINFO_TOKENID_INVALID)
                {
                    mErrorCode = NAVINFO_TOKENID_INVALID;
                    [mDelegate onElecFenceModifyResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
                else if(c==NAVINFO_RESULT_SUCCESS)
                {
                    NSDictionary *resultDic = [responseResult objectForKey:@"body"];
                    NSLog(@"resultDic:%@",resultDic);
                    if (resultDic != nil)
                    {
                        mErrorCode = NAVINFO_RESULT_SUCCESS;
                        [mDelegate onElecFenceModifyResult:resultDic code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                    }
                    else
                    {
                        mErrorCode = RETURN_EMPTY;
                        [mDelegate onElecFenceModifyResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                    }
                    
                }
                else if (c == NAVINFO_MODIFY_VALID_EXIST)
                {
                    mErrorCode = NAVINFO_MODIFY_VALID_EXIST;
                    [mDelegate onElecFenceModifyResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
                else
                {
                    mErrorCode = RETURN_PROTOCOL_ERROR;
                    [mDelegate onElecFenceModifyResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
            }
            else
            {
                mErrorCode = RETURN_PROTOCOL_ERROR;
                [mDelegate onElecFenceModifyResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
            }
            
        }
        
    }
    else
    {
        NSLog(@"[Error] The return's data is empty");
        mErrorCode = RETURN_EMPTY;
        [mDelegate onElecFenceModifyResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
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
    [mDelegate onElecFenceModifyResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
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
    [mDelegate onElecFenceModifyResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
}@end
