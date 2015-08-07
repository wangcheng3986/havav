/*!
 @header ElecFenceDeleteNetManager.h
 @abstract 电子围栏删除网络管理类
 @author wangqiwei
 @version 1.00 2014/9/1 Create
 */
#import "ElecFenceDeleteNetManager.h"

@implementation ElecFenceDeleteNetManager
/*!
 @method deleteRequest:
 @abstract 创建网路请求
 @discussion 创建电子围栏删除的网络请求URL
 @param elecIDlist 电子围栏列表
 @result 无
 */
- (void)deleteRequest:(NSArray *)elecIDlist
{
    mRequest = [[NIOpenUIPRequest alloc] init];
    mRequest.fVersion = @"1.0";
    mRequest.fName = @"GW.M.DELETE_ELEC_FENCES";
    mRequest.time = [NSDate timeIntervalSinceReferenceDate];
    NIOpenUIPData *param = [[[NIOpenUIPData alloc] init] autorelease];
    NSMutableArray *tempList = [[NSMutableArray alloc]init];
    for (int i = 0; i < elecIDlist.count; i++)
    {
        NIOpenUIPData *temp = [[[NIOpenUIPData alloc] init] autorelease];
        [temp setString:@"id" value:[elecIDlist objectAtIndex:i]];
        [tempList addObject:temp.mutableDict];

    }
    
    
    
    [param setList:@"idList" list:tempList];
    
    
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
- (void)sendRequestWithAsync:(id<ElecFenceDeleteNetManagerDelegate>)delegate
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
            [mDelegate onElecFenceDeleteResult:nil code:RETURN_PROTOCOL_ERROR errorMsg:[self convertErrorCode:RETURN_PROTOCOL_ERROR]];
        }
        else
        {
            NSDictionary *header = [responseResult objectForKey:@"header"];
            if ([header objectForKey:@"c"]) {
                int c = [[header objectForKey:@"c"]integerValue];
                if(c==NAVINFO_TOKENID_INVALID)
                {
                    mErrorCode = NAVINFO_TOKENID_INVALID;
                    [mDelegate onElecFenceDeleteResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
                else if(c==NAVINFO_RESULT_SUCCESS)
                {
   
                    mErrorCode = NAVINFO_RESULT_SUCCESS;
                    [mDelegate onElecFenceDeleteResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];

                }
                else
                {
                    mErrorCode = RETURN_PROTOCOL_ERROR;
                    [mDelegate onElecFenceDeleteResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
            }
            else
            {
                mErrorCode = RETURN_PROTOCOL_ERROR;
                [mDelegate onElecFenceDeleteResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
            }
            
        }
        
    }
    else
    {
        NSLog(@"[Error] The return's data is empty");
        mErrorCode = RETURN_EMPTY;
        [mDelegate onElecFenceDeleteResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
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
    [mDelegate onElecFenceDeleteResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
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
    [mDelegate onElecFenceDeleteResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
}
@end
