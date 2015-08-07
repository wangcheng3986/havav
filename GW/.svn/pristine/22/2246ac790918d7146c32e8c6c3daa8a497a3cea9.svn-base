//
//  NIPOISycn.m
//  GW
//
//  Created by my on 13-7-22.
//  Copyright (c) 2013年 liutch. All rights reserved.
//

#import "NIPOISycn.h"

@implementation NIPOISycn
- (void)dealloc
{
    [super dealloc];
}

/*!
 @method createRequest:(NSMutableArray *) addList delList:(NSMutableArray *) delList updateList:(NSMutableArray *) updateList
 @abstract 创建网路请求
 @discussion 同步收藏POI请求的网络请求URL
 @param addList 需要添加的poi信息
 @param delList 需要删除的poi信息
 @result 无
 */
- (void)createRequest:(NSMutableArray *) addList delList:(NSMutableArray *) delList updateList:(NSMutableArray *) updateList
{
    
    mRequest = [[[NIOpenUIPRequest alloc] init]autorelease];
    mRequest.fVersion = [NSString stringWithFormat:@"1.0"];
    mRequest.seq = mRequest.getNextSeq;
    mRequest.fName = [NSString stringWithFormat:@"GW.M.SYNC_FAVORITE_POI"];
    mRequest.time = [NSDate timeIntervalSinceReferenceDate];
    
    
     NSMutableArray *tempAddList = [[NSMutableArray alloc]initWithCapacity:0];
    NSMutableArray *tempDelList = [[NSMutableArray alloc]initWithCapacity:0];
    NSMutableArray *tempUpdateList = [[NSMutableArray alloc]initWithCapacity:0];
    if (0 !=[delList count])
    {
       
        for (id obj in delList)
        {
            NSLog(@"obj = %@", obj);
            
            [tempDelList addObject:obj];
        }
    }
    
    if (0 !=[addList count])
    {
        for (id obj in addList)
        {
            NSLog(@"obj = %@", obj);
//            下面注释掉的是非必填字段，为减少请求数据长度
             NIOpenUIPData *temp = [[[NIOpenUIPData alloc]init]autorelease];
            
            if ([obj objectForKey:@"poiId"] != nil && ![[obj objectForKey:@"poiId"]isEqualToString:@""]) {
                [temp setString:@"poiId" value:[obj objectForKey:@"poiId"]];
            }
            if ([obj objectForKey:@"lon"]) {
                [temp setDouble:@"lon" value:[[obj objectForKey:@"lon"]doubleValue]];
            }
            else
            {
                [temp setDouble:@"lon" value:0];
            }
            if ([obj objectForKey:@"lat"]) {
                [temp setDouble:@"lat" value:[[obj objectForKey:@"lat"]doubleValue]];
            }
            else
            {
                [temp setDouble:@"lat" value:0];
            }
            if ([obj objectForKey:@"address"] != nil && ![[obj objectForKey:@"address"]isEqualToString:@""]) {
                [temp setString:@"poiAddress" value:[obj objectForKey:@"address"]];
            }
            if ([obj objectForKey:@"conatctsNum"] != nil && ![[obj objectForKey:@"conatctsNum"]isEqualToString:@""]) {
                [temp setString:@"tel" value:[obj objectForKey:@"conatctsNum"]];
            }
            if ([obj objectForKey:@"createTime"] != nil && ![[obj objectForKey:@"createTime"]isEqualToString:@""]) {
                [temp setString:@"lastUpdate" value:[obj objectForKey:@"createTime"]];
            }
            [temp setString:@"poiName" value:[obj objectForKey:@"poiName"]];
            [tempAddList addObject:temp.mutableDict];
        }
    }
    
    if (0 !=[updateList count])
    {
        for (id obj in updateList)
        {
            NSLog(@"obj = %@", obj);
            //            下面注释掉的是非必填字段，为减少请求数据长度
            NIOpenUIPData *temp = [[[NIOpenUIPData alloc]init]autorelease];
            if ([obj objectForKey:@"id"] != nil && ![[obj objectForKey:@"id"]isEqualToString:@""]) {
                [temp setString:@"id" value:[obj objectForKey:@"id"]];
            }
            if ([obj objectForKey:@"poiId"] != nil && ![[obj objectForKey:@"poiId"]isEqualToString:@""]) {
                [temp setString:@"poiId" value:[obj objectForKey:@"poiId"]];
            }
            if ([obj objectForKey:@"lon"]) {
                [temp setDouble:@"lon" value:[[obj objectForKey:@"lon"]doubleValue]];
            }
            else
            {
                [temp setDouble:@"lon" value:0];
            }
            if ([obj objectForKey:@"lat"]) {
                [temp setDouble:@"lat" value:[[obj objectForKey:@"lat"]doubleValue]];
            }
            else
            {
                [temp setDouble:@"lat" value:0];
            }
            if ([obj objectForKey:@"address"] != nil && ![[obj objectForKey:@"address"]isEqualToString:@""]) {
                [temp setString:@"poiAddress" value:[obj objectForKey:@"address"]];
            }
            if ([obj objectForKey:@"conatctsNum"] != nil && ![[obj objectForKey:@"conatctsNum"]isEqualToString:@""]) {
                [temp setString:@"tel" value:[obj objectForKey:@"conatctsNum"]];
            }
            if ([obj objectForKey:@"createTime"] != nil && ![[obj objectForKey:@"createTime"]isEqualToString:@""]) {
                [temp setString:@"lastUpdate" value:[obj objectForKey:@"createTime"]];
            }
            [temp setString:@"poiName" value:[obj objectForKey:@"poiName"]];
            [tempUpdateList addObject:temp.mutableDict];
        }
    }
    NIOpenUIPData *param = [[[NIOpenUIPData alloc]init]autorelease];
    [param setObjList:@"delList" list:tempDelList];
    [param setObjList:@"addList" list:tempAddList];
    [param setObjList:@"updateList" list:tempUpdateList];
    NSLog(@"param = %@", param.mutableDict);
    [mRequest setParam:param];
    mMessage = [mRequest generatePackage];
    [tempAddList removeAllObjects];
    [tempAddList release];
    tempAddList = nil;
    [tempDelList removeAllObjects];
    [tempDelList release];
    tempDelList = nil;
    [tempUpdateList removeAllObjects];
    [tempUpdateList release];
    tempUpdateList = nil;
    
    
}
/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求
 @discussion 发送同步收藏POI的异步网络请求
 @param delegate 代理函数
 @result 无
 */
- (void)sendRequestWithAsync:(id<NIPOISycnDelegate>)delegate
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
            [mDelegate onPOISyncResult:nil code:RETURN_PROTOCOL_ERROR errorMsg:[self convertErrorCode:RETURN_PROTOCOL_ERROR]];
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
                    [mDelegate onPOISyncResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
                else if(c==NAVINFO_RESULT_SUCCESS)
                {
                    NSDictionary *resultDic = [responseResult objectForKey:@"body"];
                    if (resultDic != nil)
                    {
                        mErrorCode = NAVINFO_RESULT_SUCCESS;
                        [mDelegate onPOISyncResult:resultDic code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                        
                    }
                    else
                    {
                        mErrorCode = RETURN_EMPTY;
                        [mDelegate onPOISyncResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                    }
                }
                else
                {
                    mErrorCode = RETURN_PROTOCOL_ERROR;
                    [mDelegate onPOISyncResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
            }
            else
            {
                mErrorCode = RETURN_PROTOCOL_ERROR;
                [mDelegate onPOISyncResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
            }
 
        }
        
    }
    else
    {
        NSLog(@"[Error] The return's data is empty");
        mErrorCode = RETURN_EMPTY;
        [mDelegate onPOISyncResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
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
    [mDelegate onPOISyncResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
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
    [mDelegate onPOISyncResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
}
@end
