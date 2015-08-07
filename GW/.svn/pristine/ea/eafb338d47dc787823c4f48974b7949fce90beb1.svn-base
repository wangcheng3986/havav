//
//  NetManager.m
//  VW
//
//  Created by kexin on 12-4-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NetManager.h"

@implementation NetManager
/*!
 @method initWithUrl
 @abstract 初始化http请求头信息
 @discussion 初始化http请求头信息
 @param oUrl URL请求参数
 @result [self init]
 */
-(id)initWithUrl:(NSURL*)url
{
    oConn = nil;
    oDataBuf = nil;
    
    oRequest = [[NSMutableURLRequest alloc]initWithURL:url];
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
    [oConn release];
    [oDataBuf release];
    [oRequest release];
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
    NSURLResponse *oResponse = [[NSURLResponse alloc] init];
    NSData *data = [NSURLConnection sendSynchronousRequest:oRequest
                                         returningResponse:nil 
                                                     error:nil];
    [oResponse release];

    return data;
}
/*!
 @method requestWithAsynchronous
 @abstract 发送异步网络请求
 @discussion 发送异步网路请求
 @param delegate 网络请求代理函数对象
 @result 无
 */
-(void)requestWithAsynchronous:(id<NetDelegate>)delegate
{
    netDelegate = [delegate retain];
    oDataBuf = [[NSMutableData alloc] initWithLength:0];
    oConn = [[NSURLConnection alloc]initWithRequest:oRequest delegate:self startImmediately:YES];
    [self retain];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
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
    [netDelegate onFinish:oDataBuf];
    [oConn release];
    [netDelegate release];
}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]){
        
        [[challenge sender]  useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
        
        [[challenge sender]  continueWithoutCredentialForAuthenticationChallenge: challenge];
        
    }
    
}

@end
