//
//  NIApplicationBase.m
//  author: wlq
//
//  Created by mac on 13-5-29.
//  Copyright (c) 2013 NavInfo. All rights reserved.
//
//  version 1.0 2013-5-30 wlq create.
//
//
//

#import "NIApplicationBase.h"

@implementation NIApplicationBase

@synthesize mRequest = mRequest;
@synthesize mMessage = mMessage;
@synthesize mNetManager = mNetManager;

@synthesize mResultMsg,mResultInfo;

- (id)init
{
    self = [super init];
//    mRequest = [[NIOpenUIPRequest alloc] init];
    mMessage = [[NSString alloc] init];
    //mNetManager = [[NINetManager alloc] init];
    mResultMsg = [[NSArray alloc] init];
    mResultInfo = [[NSArray alloc] init];
    mErrorCode = 0;
    return self;
}

- (void)dealloc;
{
//    if (mRequest) {
//        [mRequest release];
//        mRequest = nil;
//    }

    if (mMessage) {
//        [mMessage release];
        mMessage = nil;
    }
    if (mNetManager) {
        [mNetManager release];
        mNetManager = nil;
    }
    if (mResultMsg) {
//        [mResultMsg release];
        mResultMsg = nil;
    }
    if (mResultInfo) {
//        [mResultInfo release];
        mResultInfo = nil;
    }
    [super dealloc];
}
/*!
 @method getValueInJSON
 @abstract 从JSON串中取得值
 @discussion 取得协议中key值为_v对应的储存值
 @param TSPstring JSON字符串
 @result 新的字典或字符串
 */
- (id)getValueInJSON:(NSDictionary *) TSPstring
{
    if (TSPstring == nil) return nil;
    return [TSPstring objectForKey:@"_v"];
}

/*!
 @method getTypeInJSON
 @abstract 从JSON串中取得值
 @discussion 取得协议中key值为_c对应的储存值
 @param TSPstring JSON字符串
 @result 新的字典或字符串
 */
- (int)getTypeInJSON:(NSDictionary *) TSPstring
{
    if (TSPstring == nil) return NSIntegerMax;
    NSNumber *type = [TSPstring valueForKey:@"_c"];
    int t = [type intValue];
    return t;

}


/*!
 @method analyseJSON:key:
 @abstract 按照协议解析JSON
 @discussion 按照协议解析JSON
 @param dict JSON集合体
 @param key key值
 @result 新的字典或字符串
 */
- (id)analyseJSON:(NSDictionary *)dict key:(NSString *)key
{
    //NSLog(@"the dict is :%@",dict);
    
    NSArray *keys;
    int i, count;
    id  value;
    NSString *keyforObj;
    if (NSOrderedSame ==[key compare:@"_c"]||NSOrderedSame ==[key compare:@"_v"] ) {
        //NSLog(@"%@",dict);
        count = 0;
    }
    else{
        keys = [dict allKeys];
        count = [keys count];
    }

    if (count > 0)
    {
        for (i = 0; i < count; i++)
        {
            keyforObj = [keys objectAtIndex: i];
            value = [dict objectForKey: keyforObj];           
            if ([value intValue] == 9 && NSOrderedSame ==[keyforObj compare:@"_c"])
            {
                //如果类型为NIOpenUIPData，需要继续递归解析。
                NSArray *subkeys;
                NSMutableDictionary *resultDict = [[[NSMutableDictionary alloc] init] autorelease];
                int j, subcount;            
                subkeys = [[dict objectForKey:@"_v"] allKeys];
                //NSLog(@"In the subtree of object. the subkeys is:%@",subkeys);
                subcount = [subkeys count];
                
                for (j = 0; j < subcount; j++)
                {
                    NSDictionary *temp = [[dict objectForKey:@"_v"]objectForKey:[subkeys objectAtIndex:j]] ;
                    NSDictionary *temp1 = [self analyseJSON:temp key:[subkeys objectAtIndex:j]];
                    //NSLog(@"%@",[subkeys objectAtIndex:j]);
                    //NSLog(@"%@",temp1);
                    if (temp1) {
                        [resultDict setObject: temp1 forKey: [subkeys objectAtIndex:j]];
                    }
                    else
                    {
                        [resultDict setObject: @"" forKey: [subkeys objectAtIndex:j]];
                    }
                }
                //[subkeys release];
                //NSLog(@"resultDict is%@",resultDict);
                return resultDict;

            }
            else if([value intValue] == 10 && NSOrderedSame == [keyforObj compare:@"_c" ])
            {
                NSArray *tempList = [dict objectForKey:@"_v"];
                NSMutableArray *resultList = [[[NSMutableArray alloc] init] autorelease];
                //NSLog(@"In the List Subtree. the tempList :%@",tempList);
                for (id JSONObj in tempList)
                {
                    //NSLog(@"JSONObj :%@",JSONObj);
                    id result = [self analyseJSON:JSONObj key:@"1"];
                    NSLog(@"result:%@",result);                    
                    if (nil != result) {
                        [resultList addObject:result];
                    }
                }
                //NSLog(@"resultList :%@",resultList);
                return resultList;
              }
            else
            {
                //transfor to chinese
                if ([value intValue] == 2) {
                    
                    NSData *data1 = [[dict objectForKey:@"_v"] dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
                    data1 = [GTMBase64 decodeData:data1];
                    NSString *string = [[[NSString alloc] initWithData:data1 encoding:NSUTF8StringEncoding] autorelease];
                    NSLog(@"string:%@", string);
                    return string;
                }else
                {
                    return [dict objectForKey:@"_v"];    
                }
            }
        }
    }
    //else
    //{
        return @"the result is not correct";
    //}

}

/*!
 @method transBstrToStr
 @abstract 将Base 64字符转换成NSString类型
 @discussion 将Base 64字符转换成NSString类型
 @param bstr Base 64字符串
 @result NSString类型字符串
 */
- (NSString *)transBstrToStr:(NSString *) bstr
{
    NSData *data1 = [bstr dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data1 = [GTMBase64 decodeData:data1];
    NSString *string = [[[NSString alloc] initWithData:data1 encoding:NSUTF8StringEncoding] autorelease];
    //NSLog(@"string:%@", string);
    return string;
}


/*!
 @method createRequest
 @abstract 创建url请求字符串和设置包头
 @discussion 根据对应协议创建url请求字符串
 @param idValue key值为id的值
 @result 无
 */
- (void)createRequest:(NSString *) idValue
{
    mRequest = [[NIOpenUIPRequest alloc] init];
    mRequest.fVersion = @"1.0";
    mRequest.seq = mRequest.getNextSeq;
    mRequest.fName = @"GW.C.CRUD.APP_PROFILE.GET";
    mRequest.time = [NSDate timeIntervalSinceReferenceDate];
    
    NIOpenUIPData *param = [[[NIOpenUIPData alloc] init] autorelease];
    if ([param setString:@"id" value:idValue]) {
        [mRequest setParam:param];
        
        mMessage = [mRequest generatePackage];
    }
    else
    {
        NSLog(@"the request id may be not correct, it is:%@", idValue);
    }
    

}

/*!
 @method sendRequestWithSync
 @abstract 发送同步网络请求
 @discussion 发送同步网络请求
 @result 无
 */
- (id)sendRequestWithSync
{
    NSLog(@"++>%@",mMessage);    
    mNetManager = [[NINetManager alloc] initWithString:mMessage];
    NSData *response = [mNetManager requestWithSynchronous];
    
    if (NULL != response)
    {
        NSError *error;
        NSDictionary *responseString = [NSJSONSerialization JSONObjectWithData:response options:
                                        NSJSONReadingMutableLeaves error:&error];        
        NSLog(@"the string in responseString is:%@", responseString);
        return responseString;
    }else
    {
        NSLog(@"Sorry, did not get the response.");        
        return NULL;  //Currently do not know return what to application.
    }
    
}

/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求
 @discussion 发送异步网络请求
 @result 无
 */
- (void)sendRequestWithAsync;
{
    NSLog(@"[Msg] the request package is:%@",mMessage);    
    mNetManager = [[NINetManager alloc] initWithString:mMessage];
    [mNetManager requestWithAsynchronous:self];
}

/*!
 @method sendRequestWithAsync
 @abstract 取消发送网络请求
 @discussion 取消发送网络请求
 @result 无
 */
- (void)cancelRequest
{
    [mNetManager requestCancel];
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
        NSError *error;   
        NSDictionary *responseString = [NSJSONSerialization JSONObjectWithData:data options:
                                        NSJSONReadingMutableLeaves error:&error];
        NSLog(@"[Msg]the string in responseString is:%@", responseString);
    }
    else
    {
        NSLog(@"[Error] The return's data is empty");
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
    NSLog(@"[Error] The connection is broken.");
}

/**********************************************************
 函数名称:- (NSString *)convertErrorCode:(int)errorcode 
 函数描述:将网络通信产生的error code转换为对应的文字消息
 输入参数:(int)errorcode:某error code。 
 返回值:NSString *strMsg:消息字符串
 **********************************************************/
- (NSString *)convertErrorCode:(int)errorcode
{
    NSString *strMsg;
    switch (errorcode) {
        case INPUT_PARAM_ERROR:
            strMsg = @"输入参数错误";
            break;
        case INNER_ERROR:
            strMsg = @"程序内部错误";
            break;
        case NET_ERROR:
            strMsg = @"网络错误，无法建立连接或连接超时";
            break;
        case RETURN_EMPTY:
            strMsg = @"应答为空";
            break;
        case RETURN_PROTOCOL_ERROR:
            strMsg = @"应答不符合协议格式";
            break;
        case USER_CANCEL_ERROR:
            strMsg = @"取消请求";
            break;
        case NAVINFO_LOGIN_NO_VEHICLES:
            strMsg = @"当前账号下没有车";
            break;
        case NAVINFO_LOGIN_ACCOUNT_NOEXIST:
            strMsg = @"账户不存在";
            break;
        case NAVINFO_LOGIN_PWD_ERROR:
            strMsg = @"账号或密码错误";
            break;
        default:
            strMsg = @"服务器异常";
    }
    return strMsg;
}


- (NSString *)transforToChinese:(NSString *)utf8string
{
    NSString* strAfterDecodeByUTF8AndURI = [utf8string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
   
    NSLog(@"strAfterDecodeByUTF8AndURI=%@", strAfterDecodeByUTF8AndURI);
    return strAfterDecodeByUTF8AndURI;
}

@end
