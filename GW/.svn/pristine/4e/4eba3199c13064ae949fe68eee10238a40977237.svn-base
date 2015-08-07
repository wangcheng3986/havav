//
//  NICreatePOI.m
//  TestNetInterface
//
//  Created by mac on 13-6-3.
//  Copyright (c) 2013年 wlq. All rights reserved.
//

#import "NICreatePOI.h"

@implementation NICreatePOI

@synthesize mPrivatePOIInfo;

- (void)dealloc
{
    [mPrivatePOIInfo release];
    [super dealloc];
}

//create the request message, set the function name and parameter's value.
//p = {
//	poiName : "#新添POI", // POI名称
//    
//	poiId : "XXXXXXX", // 如果POI来源是基础数据,需要提供此值,可选
//    
//	lon : "D#115.123", // 经度
//    
//	lat : "D#40.123", // 纬度
//    
//	desc : "#朝阳区琨莎中心", // 位置描述
//    
//	aliasName : "#别名",// 别名
//    
//	address : "#朝阳区琨莎中心",// 地址
//    
//	conatctsNum : "01088888888",// 联系电话
//    
//	postCode : "100191",// 邮编
//    
//	level : "1"// 公开等级 0,公开,1私有
//}
/*!
 @method createRequest
 @abstract 创建网路请求
 @discussion 创建收藏POI请求的网络请求URL
 @param privatePOIInfo POI信息
 @result 无
 */
- (void)createRequest:(NSDictionary *) privatePOIInfo
{
    mPrivatePOIInfo = [NSArray arrayWithObjects:                   @"poiName",@"poiId",@"lon",@"lat",@"desc",@"aliasName",@"address",@"conatctsNum",@"postCode",@"level",nil];
    
    mRequest = [[[NIOpenUIPRequest alloc] init]autorelease];
    mRequest.fVersion = [NSString stringWithFormat:@"1.0"];
    mRequest.seq = mRequest.getNextSeq;
    mRequest.fName = [NSString stringWithFormat:@"GW.C.PRIVATEPOI.CREATE"];
    mRequest.time = [NSDate timeIntervalSinceReferenceDate];
    
    NIOpenUIPData *param = [[[NIOpenUIPData alloc]init]autorelease];
    
    [param setBstr:@"poiName" value:[privatePOIInfo objectForKey:@"poiName"]];
    if ([privatePOIInfo objectForKey:@"poiId"] != nil) {
        [param setString:@"poiId" value:[privatePOIInfo objectForKey:@"poiId"]];
    }
    [param setString:@"lon" value:[privatePOIInfo objectForKey:@"lon"]];
    [param setString:@"lat" value:[privatePOIInfo objectForKey:@"lat"]];
    if ([privatePOIInfo objectForKey:@"desc"] != nil) {
        [param setBstr:@"desc" value:[privatePOIInfo objectForKey:@"desc"]];
    }
    if ([privatePOIInfo objectForKey:@"aliasName"] != nil) {
        [param setBstr:@"aliasName" value:[privatePOIInfo objectForKey:@"aliasName"]];
    }
    if ([privatePOIInfo objectForKey:@"address"] != nil) {
        [param setBstr:@"address" value:[privatePOIInfo objectForKey:@"address"]];  
    }
    if ([privatePOIInfo objectForKey:@"conatctsNum"] != nil) {
        [param setString:@"conatctsNum" value:[privatePOIInfo objectForKey:@"conatctsNum"]];
    }
    if ([privatePOIInfo objectForKey:@"postCode"] != nil) {
        [param setString:@"postCode" value:[privatePOIInfo objectForKey:@"postCode"]];
    }
    if ([privatePOIInfo objectForKey:@"level"]) {
        [param setString:@"level" value:[privatePOIInfo objectForKey:@"level"]];
    }
    
    
    [mRequest setParam:param];
        
    mMessage = [mRequest generatePackage];
}


//The result is the private POI's ID.
//r = {
//	"id" : "519d8d7ef7436112e530bdd8"
//}
/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求
 @discussion 发送创建收藏POI的异步网络请求
 @param delegate 代理函数
 @result 无
 */
- (void)sendRequestWithAsync:(id<NICreatePOIDelegate>)delegate
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
    NSLog(@"onFinish.");
    if(data)
    {
        NSDictionary *responseResult =  [mNetManager parsingOfJson:data];
        
        
        if ([[responseResult objectForKey:@"error"]boolValue])
        {
            mErrorCode = RETURN_PROTOCOL_ERROR;
            [mDelegate onCreateResult:nil code:RETURN_PROTOCOL_ERROR errorMsg:[self convertErrorCode:RETURN_PROTOCOL_ERROR]];
        }
        else
        {
            NSDictionary *header = [responseResult objectForKey:@"header"];
            if ([header objectForKey:@"c"]) {
                int c = [[header objectForKey:@"c"]integerValue];
                if(c==NAVINFO_TOKENID_INVALID)
                {
                    mErrorCode = NAVINFO_TOKENID_INVALID;
                    [mDelegate onCreateResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
                else if(c==NAVINFO_RESULT_SUCCESS)
                {
                    NSDictionary *resultDic = [responseResult objectForKey:@"body"];
                    if (resultDic != nil) {
                        mErrorCode = NAVINFO_RESULT_SUCCESS;
                        [mDelegate onCreateResult:resultDic code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                    }
                    else
                    {
                        mErrorCode = RETURN_EMPTY;
                        [mDelegate onCreateResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                    }
                    
                }
                else
                {
                    mErrorCode = RETURN_PROTOCOL_ERROR;
                    [mDelegate onCreateResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
            }
            else
            {
                mErrorCode = RETURN_PROTOCOL_ERROR;
                [mDelegate onCreateResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
            }
        }

    }
    else
    {
        NSLog(@"[Error] The return's data is empty");
        mErrorCode = RETURN_EMPTY;
        [mDelegate onCreateResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
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
    [mDelegate onCreateResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
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
    [mDelegate onCreateResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
}

@end
