/*!
 @header ElecFenceAddNetManager.h
 @abstract 电子围栏添加网络管理类
 @author wangqiwei
 @version 1.00 2014/9/1 Create
 */

#import "ElecFenceAddNetManager.h"

@implementation ElecFenceAddNetManager
/*!
 @method createRequest:
 @abstract 创建网路请求
 @discussion 创建电子围栏添加的网络请求URL
 @param vin 车架号
 @param name 名称
 @param valid 是否可用
 @param lon 经度
 @param lat 纬度
 @param radius 半径
 @param adress 地址
 @result 无
 */
- (void)createRequest:(NSString *)vin
                 name:(NSString *)name
                valid:(NSString *)valid
                  lon:(double)lon
                  lat:(double)lat
               radius:(int)radius
               adress:(NSString *)address;
{
    mRequest = [[NIOpenUIPRequest alloc] init];
    mRequest.fVersion = @"1.0";
    mRequest.fName = @"GW.M.CREATE_ELEC_FENCE";
    mRequest.time = [NSDate timeIntervalSinceReferenceDate];
    NIOpenUIPData *param = [[[NIOpenUIPData alloc] init] autorelease];
    NIOpenUIPData *temp = [[[NIOpenUIPData alloc] init] autorelease];

    
    [temp setBstr:@"name" value:name];
    [temp setBstr:@"valid" value:valid];
    [temp setBstr:@"address" value:address];
    [temp setDouble:@"lon" value:lon];
    [temp setDouble:@"lat" value:lat];
    [temp setInt:@"radius" value:radius];
    
    [param setBstr:@"vin" value:vin];
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
- (void)sendRequestWithAsync:(id<ElecFenceAddNetManagerDelegate>)delegate
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
            [mDelegate onElecFenceAddResult:nil code:RETURN_PROTOCOL_ERROR errorMsg:[self convertErrorCode:RETURN_PROTOCOL_ERROR]];
        }
        else
        {
            NSDictionary *header = [responseResult objectForKey:@"header"];
            if ([header objectForKey:@"c"]) {
                int c = [[header objectForKey:@"c"]integerValue];
                if(c==NAVINFO_TOKENID_INVALID)
                {
                    mErrorCode = NAVINFO_TOKENID_INVALID;
                    [mDelegate onElecFenceAddResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
                else if(c==NAVINFO_RESULT_SUCCESS)
                {
                    NSDictionary *resultDic = [responseResult objectForKey:@"body"];
                    NSLog(@"resultDic:%@",resultDic);
                    if (resultDic != nil)
                    {
                        mErrorCode = NAVINFO_RESULT_SUCCESS;
                        [mDelegate onElecFenceAddResult:resultDic code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                    }
                    else
                    {
                        mErrorCode = RETURN_EMPTY;
                        [mDelegate onElecFenceAddResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                    }
                    
                }
                else if(c==NAVINFO_ELEC_NUM_EXIST)
                {
                    mErrorCode = NAVINFO_ELEC_NUM_EXIST;
                    [mDelegate onElecFenceAddResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
                else if(c==NAVINFO_ELEC_VALID_EXIST)
                {
                    mErrorCode = NAVINFO_ELEC_VALID_EXIST;
                    [mDelegate onElecFenceAddResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
                else
                {
                    mErrorCode = RETURN_PROTOCOL_ERROR;
                    [mDelegate onElecFenceAddResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
            }
            else
            {
                mErrorCode = RETURN_PROTOCOL_ERROR;
                [mDelegate onElecFenceAddResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
            }
            
        }
        
    }
    else
    {
        NSLog(@"[Error] The return's data is empty");
        mErrorCode = RETURN_EMPTY;
        [mDelegate onElecFenceAddResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
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
    [mDelegate onElecFenceAddResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
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
    [mDelegate onElecFenceAddResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
}
@end
