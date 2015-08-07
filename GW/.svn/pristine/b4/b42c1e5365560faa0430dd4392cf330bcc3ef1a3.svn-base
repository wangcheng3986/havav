//
//  NISyncContacts.m
//  author: wlq
//
//  Created by mac on 13-5-29.
//  Copyright (c) 2013 NavInfo. All rights reserved.
//
//  version 1.0 2013-5-30 wlq create.
//
//
//

#import "NISyncContacts.h"

@implementation NISyncContacts

- (id)init
{
    self = [super init];   
    return self;
}

-(void)delloc
{
    [super dealloc];
}

- (NSString *)getMpMessage
{
    return mMessage;
}
/*!
 @method createRequest
 @abstract 创建网路请求
 @discussion 创建请求同步通讯录的网络请求URL（车友业务层）
 @param contactsList 通讯录列表集合
 @result 无
 */
- (void)createRequest:(NSArray *) contactsList
{
    mRequest = [[NIOpenUIPRequest alloc] init];
    [contactsList retain];
    mRequest.fVersion = @"1.0";
    mRequest.seq = mRequest.getNextSeq;
    mRequest.fName = @"GW.M.SYNC_CONTACTS";
    mRequest.time = [NSDate timeIntervalSinceReferenceDate];
    
    NIOpenUIPData *param = [[[NIOpenUIPData alloc] init] autorelease];
    
    //check if the ids is empty.
    if (0 !=[contactsList count])
    {
        NSMutableArray *tempList = [[NSMutableArray alloc] init];
        //NSMutableArray *tempList = nil;
        for (id contact in contactsList)
        {
            //NSLog(@"contact = %@", contact);
            NIOpenUIPData *temp = [[[NIOpenUIPData alloc] init] autorelease];
            
            if ([contact objectForKey:@"name"]) {
                
                /*超过32个字符，自动截取 孟磊 2013年9月18日*/
                NSString *string  = [contact objectForKey:@"name"];
                if (string.length > 32) {
                    string = [string substringToIndex:32];
                }
                [temp setBstr:@"name" value: string];
                
            }else
            {
                continue;
//                mErrorCode = INPUT_PARAM_ERROR;
//                [mDelegate onSyncResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
            }
            
            if ([contact objectForKey:@"phone"]) {
                [temp setString:@"phone" value: [contact objectForKey:@"phone"]];
            }else
            {
                continue;
//                mErrorCode = INPUT_PARAM_ERROR;
//                [mDelegate onSyncResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
            }
            
            
            [tempList addObject:temp.mutableDict];
            //NSLog(@"%d",[mRequest retainCount]);
            
        }

        [param setObjList:@"contactsList" list:tempList];
        
        [mRequest setParam:param];
        mMessage = [mRequest generatePackage];
        //NSLog(@"%@",mMessage);
    }
    else
    {
        NSLog(@"[Warnning] wrong parameter, the contacts list is empty");
        mErrorCode = INPUT_PARAM_ERROR;
        [mDelegate onSyncResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
    }
    [contactsList release];
}
/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求（车友业务层）
 @discussion 发送车友同步通讯录的异步网络请求
 @param delegate 代理函数
 @result 无
 */
- (void)sendRequestWithAsync:(id<NISyncContactsDelegate>)delegate
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
    NSString *urlmessage = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    NSLog(@"onFinish. the urlmessage =:%@",urlmessage);
    if(data)
    {
        NSDictionary *responseResult =  [mNetManager parsingOfJson:data];
        if ([[responseResult objectForKey:@"error"]boolValue])
        {
            mErrorCode = RETURN_PROTOCOL_ERROR;
            [mDelegate onSyncResult:nil code:RETURN_PROTOCOL_ERROR errorMsg:[self convertErrorCode:RETURN_PROTOCOL_ERROR]];
        }
        else
        {
            NSDictionary *header = [responseResult objectForKey:@"header"];
            if ([header objectForKey:@"c"]) {
                int c = [[header objectForKey:@"c"]integerValue];
                if(c==NAVINFO_TOKENID_INVALID)
                {
                    mErrorCode = NAVINFO_TOKENID_INVALID;
                    [mDelegate onSyncResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
                else if(c==NAVINFO_RESULT_SUCCESS)
                {
                    
                    NSDictionary *resultDic = [responseResult objectForKey:@"body"];
                    if (resultDic != nil)
                    {
                        mErrorCode = NAVINFO_RESULT_SUCCESS;
                        [mDelegate onSyncResult:resultDic code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                    }
                    else
                    {
                        mErrorCode = RETURN_EMPTY;
                        [mDelegate onSyncResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                    }
                }
                else{
                    mErrorCode = RETURN_PROTOCOL_ERROR;
                    [mDelegate onSyncResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
                }
            }
            else
            {
                mErrorCode = RETURN_PROTOCOL_ERROR;
                [mDelegate onSyncResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
            }
            
            
        }
      
    }
    else
    {
        NSLog(@"[Error] The return's data is empty");
        mErrorCode = RETURN_EMPTY;
        [mDelegate onSyncResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
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
    [mDelegate onSyncResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
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
    [mDelegate onSyncResult:nil code:mErrorCode errorMsg:[self convertErrorCode:mErrorCode]];
}


@end
