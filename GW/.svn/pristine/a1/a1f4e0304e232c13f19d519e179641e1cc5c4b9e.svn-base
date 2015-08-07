//
//  NINetManager.m
//  author: wlq
//
//  Created by mac on 13-5-29.
//  Copyright (c) 2013 NavInfo. All rights reserved.
//
//  version 1.0 2013-5-30 wlq create.
//
//

#import "NINetManager.h"

@implementation NINetManager
/*!
 @method initWithUrl
 @abstract 初始化http请求头信息
 @discussion 初始化http请求头信息
 @param oUrl URL请求参数
 @result [self init]
 */
-(id)initWithUrl:(NSURL*)url
{
    self = [super init];    
    oConn = nil;
    oDataBuf = nil;
   
    oRequest = [[[NSMutableURLRequest alloc]initWithURL:url]autorelease];

    [oRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
   
    return [self init];    
}

/*!
 @method initWithString
 @abstract 初始化URL信息
 @discussion 初始化URL信息，输入字符串
 @param sUrl URL地址
 @result [self init]
 */
-(id)initWithString:(NSString*)sUrl
{
    return [self initWithUrl:[[[NSURL alloc]initWithString:sUrl]autorelease]];
}

-(void)dealloc
{
    //[oConn release];
    //[oDataBuf release];
//    if (oRequest) {
//        [oRequest release];
//    }
    if (_timer) {
        [_timer release];
    }
    [super dealloc];
}
/*!
 @method setMethod
 @abstract 设置http请求方式
 @discussion 设置http请求方式
 @param mode 0:POST 1:GET
 @result 无
 */
-(void)setMethod:(int)mode
{
    if(mode == 0)
    {
        [oRequest setHTTPMethod:@"POST"];
    }
    else if(mode == 1)
    {
        [oRequest setHTTPMethod:@"GET"];
    }
}
/*!
 @method setPostData
 @abstract 设置http请求以post方式
 @discussion 此方法以POST方式请求网络，不可修改请求方式
 @param data 请求的输入数据
 @result 无
 */
-(void)setPostData:(NSData*)data
{
    if(data)
    {
        [oRequest setHTTPMethod:@"POST"];
        
        NSString *length = [NSString stringWithFormat:@"%d", [data length]];
        [oRequest setValue:length forHTTPHeaderField:@"Content-Length"];
        [oRequest setHTTPBody:data];
    }
}
/*!
 @method requestWithSynchronous
 @abstract 发送同步网络请求
 @discussion 发送同步网络请求
 @result 网络请求返回的数据
 */
-(NSData*)requestWithSynchronous
{
    
    NSData *data = [NSURLConnection sendSynchronousRequest:oRequest
                                         returningResponse:nil
                                                     error:nil];
    
    return data;
}
/*!
 @method requestWithAsynchronous
 @abstract 发送异步网络请求
 @discussion 发送异步网路请求
 @param delegate 网络请求代理函数对象
 @result 无
 */
-(void)requestWithAsynchronous:(id<NINetDelegate>)delegate
{
    netDelegate = [delegate retain];
    oDataBuf = [[NSMutableData alloc] initWithLength:0];
    oConn = [[NSURLConnection alloc]initWithRequest:oRequest delegate:self startImmediately:YES];
    [oConn scheduleInRunLoop:[NSRunLoop currentRunLoop]
                   forMode:NSDefaultRunLoopMode];
    
    if (oConn != nil)
    {
        NSLog(@"connect successed.");
        /*连接成功后，开始计时 孟磊 2013年9月17日*/
        [self addTimeOutDelay2Runloop:_timeOut];
    }
    else
    {
        NSLog(@"connect failed.");
    }
}

/*!
 @method requestCancel
 @abstract 取消网络请求
 @discussion 取消网络请求
 @result 无
 */
-(void)requestCancel
{
    [oConn cancel];

}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
     NSLog(@"didReceiveResponse");
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    /*失败后，取消监听 孟磊 2013年9月17日*/
    [self removeTimeOutDelayFromRunloop];
    
    if ([netDelegate respondsToSelector:@selector(onError:)] && error != nil) {
        [netDelegate onError:error.code];
    }
}

-(void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)data
{
    [oDataBuf appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"connectionDidFinishLoading");
    
    /*成功后，取消监听 孟磊 2013年9月17日*/
    [self removeTimeOutDelayFromRunloop];
    
    [netDelegate onFinish:oDataBuf];
    [oConn release];
    [oDataBuf release];
    [netDelegate release];
}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    
        NSLog(@"didReceiveAuthenticationChallenge %@ %zd", [[challenge protectionSpace] authenticationMethod], (ssize_t) [challenge previousFailureCount]);
    
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]){
        
        [[challenge sender]  useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
        
        [[challenge sender]  continueWithoutCredentialForAuthenticationChallenge: challenge];
        
    }
    
}

# pragma mark - 孟磊 - 私有方法
/*将超时等待监听添加到进程的Runloop中*/
-(void) addTimeOutDelay2Runloop:(NSInteger) nDelayTime
{
    if (nDelayTime <= 0) {
        nDelayTime = 30;
    }
    //开始计时
    [self performSelector:@selector(requestTimeOut) withObject:nil afterDelay:nDelayTime];
}

/*将超时等待监听从进程的Runloop中移除，取消监听*/
-(void)removeTimeOutDelayFromRunloop
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(requestTimeOut) object:nil];
}

/*执行取消连接方法*/
 - (void) requestTimeOut
{
    [self requestCancel];
    if ([netDelegate respondsToSelector:@selector(onError:)]) {
        [netDelegate onError:404];
    }
    [oConn release];
    [oDataBuf release];
    [netDelegate release];

    
}

#pragma mark-王启威-封装josn校验
-(NSMutableDictionary*)parsingOfJson:(NSData *)data
{
    
    NSLog(@">>>>>>>>>>>>进入函数parsingOfJson>>>>>>>>>>>>>>>");
    NSError *error = nil;
    NSNumber *resultError = @NO;
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                            resultError,@"error",nil];
    
    
    NSDictionary *responseString = [NSJSONSerialization JSONObjectWithData:data options:
                                    NSJSONReadingMutableLeaves error:&error];
    NSLog(@"%@",responseString);
    if (error)
    {
        NSLog(@"the transfor of string is failed. The error is :%@",error);
        resultError = @YES;
        [result setValue:resultError forKey:@"error"];
        
    }
    else
    {
        
        if([responseString objectForKey:@"header"] != nil)
        {
            [result setObject:[responseString objectForKey:@"header"] forKey:@"header"];
            NSLog(@"result>>>>>>>>>>>>>:%p",result);
            if([responseString objectForKey:@"body"] != nil)
            {
                [result setObject:[responseString objectForKey:@"body"] forKey:@"body"];
            }
            return result;

        }
        resultError = @YES;
        [result setObject:resultError forKey:@"error"];
     }
    
    return result;
}

    
@end
