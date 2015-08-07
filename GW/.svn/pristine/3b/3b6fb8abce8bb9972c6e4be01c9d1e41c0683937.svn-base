//
//  NISendToCar.m
//  GW
//
//  Created by my on 13-6-5.
//  Copyright (c) 2013年 liutch. All rights reserved.
//

#import "NISendToCar.h"

@implementation NISendToCar
- (void)dealloc
{
    
    [super dealloc];
}
/*!
 @method createRequest:eventTime:lon:lat:event:poiID:oiName:poiAddress:
 @abstract 创建网路请求
 @discussion 发送到车信息的网络请求URL
 @param sendToCarInfo 发送到车的信息
 @param eventTime   事件时间
 @param lon 位置经度
 @param lat 位置纬度
 @param mPoiID poi的ID信息
 @param mPoiName poi的名称
 @param mPoiAddress poi的地址信息
 @result 无
 */
- (void)createRequest:(NSDictionary *) sendToCarInfo eventTime:(long long)eventTime lon:(double)lon lat:(double)lat event:(BOOL)event poiID:(NSString *)mPoiID poiName:(NSString *)mPoiName poiAddress:(NSString *)mPoiAddress
{
    mRequest = [[[NIOpenUIPRequest alloc] init]autorelease];
    mRequest.fVersion = [NSString stringWithFormat:@"1.0"];
    mRequest.seq = mRequest.getNextSeq;
    mRequest.fName = [NSString stringWithFormat:@"GW.M.SENDTOCAR"];
    mRequest.time = [NSDate timeIntervalSinceReferenceDate];
    
    NIOpenUIPData *param = [[[NIOpenUIPData alloc]init]autorelease];
    [param setString:@"source" value:[sendToCarInfo objectForKey:@"source"]];
    
    NSMutableArray *tempFriendUserIdList = [[[NSMutableArray alloc]init]autorelease] ;
    NSMutableArray *tempIdentityList = [[[NSMutableArray alloc]init]autorelease] ;
    for (id obj in [sendToCarInfo objectForKey:@"targetList"])
    {
        NSLog(@"obj = %@", obj);
        if([obj objectForKey:@"tid"]||[obj objectForKey:@"userId"])
        {
            if ([obj objectForKey:@"tid"])
            {
                [tempIdentityList addObject:[obj objectForKey:@"tid"]];
            }
            if ([obj objectForKey:@"userId"]) {
                [tempFriendUserIdList addObject:[obj objectForKey:@"userId"]];
            }
            
        }
        
    }
    
    [param setObjList:@"identityList" list:tempIdentityList];
    [param setObjList:@"friendUserIdList" list:tempFriendUserIdList];
    [param setDouble:@"lon" value:lon];
    [param setDouble:@"lat" value:lat];
    if (mPoiID != nil && ![mPoiID isEqualToString:@""]) {
        [param setString:@"poiId" value:mPoiID];
    }
    if (mPoiName != nil && ![mPoiName isEqualToString:@""]) {
        [param setString:@"poiName" value:mPoiName];
    }
    if (mPoiAddress != nil && ![mPoiAddress isEqualToString:@""]) {
        [param setString:@"poiAddress" value:mPoiAddress];
    }
    
    if (!event) {
        [param setString:@"eventContent" value:[sendToCarInfo objectForKey:@"content"]];
        [param setTime:@"eventTime" date:eventTime];
    }
    NSLog(@"send2car上传参数%@",param.mutableDict);
    [mRequest setParam:param];
    mMessage = [mRequest generatePackage];
}
/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求
 @discussion 发送到车信息的异步网络请求
 @param delegate 代理函数
 @result 无
 */
- (void)sendRequestWithAsync:(id<NISendToCarDelegate>)delegate
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
            [mDelegate onResult:nil code:RETURN_PROTOCOL_ERROR errorMsg:[self convertErrorCode:RETURN_PROTOCOL_ERROR]];
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
                    [mDelegate onResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
                else if(c == NAVINFO_SEND2CAR_SEND_MORETHAN_LIMIT)
                {
                    
                    NSString *message = [header objectForKey:@"m"];
                    if (responseResult != nil) {
                        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:message,@"message", nil];
                        mErrorCode = NAVINFO_SEND2CAR_SEND_MORETHAN_LIMIT;
                        [mDelegate onResult:dic code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                    }
                    
                }
                else if(c==NAVINFO_RESULT_SUCCESS)
                {
                    NSDictionary *resultDic = [responseResult objectForKey:@"body"];
                    if (resultDic != nil)
                    {
                        if ([resultDic objectForKey:@"failCount"]) {
                            if ([[resultDic objectForKey:@"failCount"] integerValue]==0) {
                                mErrorCode = NAVINFO_RESULT_SUCCESS;
                                [mDelegate onResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                            }
                            else
                            {
                                mErrorCode = NAVINFO_RESULT_SUCCESS;
                                [mDelegate onResult:resultDic code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                            }
                        }
                        else
                        {
                            mErrorCode = RETURN_EMPTY;
                            [mDelegate onResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                        }
                    }
                    else
                    {
                        mErrorCode = RETURN_PROTOCOL_ERROR;
                        [mDelegate onResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                    }
                    
                    
                }
                else
                {
                    mErrorCode = RETURN_PROTOCOL_ERROR;
                    [mDelegate onResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }

            }
            else
            {
                mErrorCode = RETURN_PROTOCOL_ERROR;
                [mDelegate onResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
            }
            
        }
        
    }
    else
    {
        NSLog(@"[Error] The return's data is empty");
        mErrorCode = RETURN_EMPTY;
        [mDelegate onResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
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
    [mDelegate onResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
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
    [mDelegate onResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
}


@end
