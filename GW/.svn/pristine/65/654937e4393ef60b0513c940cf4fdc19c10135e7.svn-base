//
//  NIOpenUIPRequest.m
//  author: wlq
//
//  Created by mac on 13-5-29.
//  Copyright (c) 2013 NavInfo. All rights reserved.
//
//  version 1.0 2013-5-30 wlq create.
//
//
//

#import "NIOpenUIPRequest.h"
#import "App.h"
static int SEQ = 0;
NSString *SessionTokenID = @"";

@implementation NIOpenUIPRequest

@synthesize url,seq,version,paramEncrypt,resultEncrypt,
isKeyCompressed,dir,time,fName,fVersion,
isAsync,tokenId,timeout,isNeedReturn,param;
/*!
 @method init
 @abstract 初始化函数
 @discussion 设置url请求初始化参数
 @result self
 */
- (id)init
{
    self = [super init];
//    沈阳
//    self.url = [[NSString alloc]initWithFormat:@"%@/ibr/getjson",SERVER_URL];
//    self.url = [[NSString alloc]initWithFormat:@"%@/ibr/cherry",SERVER_URL];
//    保定
//    self.url = [[NSString alloc]initWithFormat:@"%@/tsp/lemon",SERVER_URL];
//    沈阳二期
    self.url = [[NSString alloc]initWithFormat:@"%@%@",SERVER_URL,ADD_URL];
    self.seq = 1;
    self.version = @"1.0";
    //self.paramEncrypt = nil;
    //self.resultEncrypt = nil;
    self.isKeyCompressed = YES;
    self.dir = DIR;
    self.time = 0;
    //self.fName = nil;
    
    self.fVersion = FUNCTION_VERSION;
    
    self.isAsync = YES;
    //self.tokenId = nil;
    
    self.timeout = 1000;
    self.isNeedReturn = 0;
    self.param = nil;
    
    return self;
    
}

- (void)dealloc
{
    if (url)
    {
        [url release];
        url = nil;
    }
    if (version)
    {
        [version release];
        version = nil;
    }
    if (paramEncrypt)
    {
        [paramEncrypt release];
        paramEncrypt = nil;
    }
    if (resultEncrypt)
    {
        [resultEncrypt release];
        resultEncrypt = nil;
    }
    if (dir)
    {
        [dir release];
        dir = nil;
    }
    if (fName)
    {
        [fName release];
        fName = nil;
    }
    if (fVersion)
    {
        [fVersion release];
        fVersion = nil;
    }
    if (tokenId)
    {
        [tokenId release];
        tokenId = nil;
    }
    
    if (param)
    {
        [param release];
        param = nil;
    }
    self.param = nil;
    
    [super dealloc];
    
}
/*!
 @method getNextSeq
 @abstract 请求计数器
 @discussion 请求计数器
 @result 无
 */
- (int)getNextSeq
{
    return SEQ++;
}

/*!
 @method generatePackage
 @abstract url字符串拼接操作
 @discussion url字符串拼接操作
 @result NSString类型的URL链接
 */
- (NSString *)generatePackage
{
    [[NSUserDefaults standardUserDefaults] setObject:[App getTimeSince1970] forKey:@"UserDefaultAppResignActive"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSMutableString *package = [[[NSMutableString alloc] init] autorelease];
    
    
    
    /**
//    沈阳二期
    [package appendString:[NSString stringWithFormat:@"%@%@",SERVER_URL,ADD_URL]];
    
    

    [package appendString:@"?"];
    [package appendString:@"p="];
    
    [package appendString:@"{\"header\":{"];
    [package appendString:@"\"rs\":"];//请求来源
    [package appendString:@"\"2\""];//固定值“2” 代表手机

    [package appendString:@",\"ts\":"];//时间戳
    [package appendString:@"\""];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *timeStr= [dateFormatter stringFromDate:[NSDate date]];
   
    [package appendString:timeStr];
    [package appendString:@"\""];
       
    [package appendString:@",\"v\":"];//版本号 json 为1.0
    [package appendString:@"\""];
    [package appendString:version];//版本号 json 为1.0
    [package appendString:@"\""];
    [package appendString:@",\"fn\":"];//协议功能名称
    [package appendString:@"\""];
    [package appendString:fName];//协议功能名称
    [package appendString:@"\""];
    
    [package appendString:@",\"fv\":"];//f协议版本号 固定0201
    [package appendString:@"\""];
    [package appendString:@"0201"];
    [package appendString:@"\""];
    if(![SessionTokenID isEqualToString:@""])
    {
        [package appendString:@",\"tk\":"];//tokeID
        [package appendString:@"\""];
        [package appendString:SessionTokenID];
        [package appendString:@"\""];
    }
    [package appendString:@"},\"body\":"];
    
    
//    [package appendString:@"?"];
//    [package appendString:@"ic="];//Compressed or not
//    [package appendString:isKeyCompressed ? @"true":@"false" ];//Compressed or not
//    [package appendString:@"&tt="];//default 1000s
//    [package appendString:[[[NSString alloc] initWithFormat:@"%d",timeout] autorelease]];//default 1000s
//    [package appendString:@"&s="];//the sequence number of client.
//    [package appendString:[[[NSString alloc] initWithFormat:@"%d",seq] autorelease]];
//    
//    [package appendString:@"&d="];//U means Up，D means Down.
//    [package appendString:dir];//U means Up，D means Down.
//    [package appendString:@"&v="];//OpenUIP protocal's version, default value is 1.0.
//    [package appendString:version];//OpenUIP protocal's version, default value is 1.0.
//    [package appendString:@"&fn="];//function name for request.
//    [package appendString:fName];//function name for request.
//    [package appendString:@"&fv="];//function's version.
//    [package appendString:fVersion];//function's version.
//    if(![SessionTokenID isEqualToString:@""])
//    {
//        [package appendString:@"&tk="];
//        [package appendString:SessionTokenID];
//    }
    

    
    if (NULL != param)
    {
        NSLog(@"%@",param.toString);
        NSString *str = param.toString;
        str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
        str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        //解决英文留言无空格的问题
   //     str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSLog(@"%@",str);
//        [package appendString:@"&p={\"_c\": 9,\"_v\":"];//parameter for feature.
        [package appendString:str];//parameter for feature.
        [package appendString:@"}"];//parameter for feature.
    }else{
       // [package appendString:@"&p={\"_c\": 9,\"_v\":{}}"];//parameter for feature.
        [package appendString:@"{}}"];//parameter for feature.
    }
    
     [dateFormatter release];
    //NSTimeInterval currenttime = [[NSDate date] timeIntervalSince1970];
    //time = [[NSNumber numberWithDouble:currenttime] longLongValue]; // double to long long.
    
    //package = [package stringByAppendingFormat:@"&ts=%lld",time];//the time of sending.
    
    
    NSLog(@"package=%@", package);
    NSString *escaped = [package stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//utf8转码
    //处理“+”“\”
    
    NSMutableString *responseString = [NSMutableString stringWithString:escaped];
    NSString *character = nil;
    //汉字中有些转码后带有+和“\”所以需要处理
    for (int i = 0; i < responseString.length; i ++) {
        character = [responseString substringWithRange:NSMakeRange(i, 1)];
        if ([character isEqualToString:@"\\"])
        {
            [responseString deleteCharactersInRange:NSMakeRange(i, 1)];
            i--;
        }
        if ([character isEqualToString:@"+"])
        {
            [responseString replaceCharactersInRange:NSMakeRange(i, 1) withString:@"%2B"];
            i--;
        }
        //        if ([character isEqualToString:@"/"])
        //            [responseString deleteCharactersInRange:NSMakeRange(i, 1)];
        
    }
    NSLog(@"responseString %@",responseString);

    
    //NSLog(@"package=%@", escaped);
    
    //[package release];
    //return escaped;
    return responseString;
     **/
     
    
    
    
    //    沈阳二期
    NSMutableString *urlStr = [[[NSMutableString alloc] init] autorelease];
    [urlStr appendString:[NSString stringWithFormat:@"%@%@",SERVER_URL,ADD_URL]];
    
    
    
    [urlStr appendString:@"?"];
    [urlStr appendString:@"p="];
    
    [package appendString:@"{\"header\":{"];
    [package appendString:@"\"rs\":"];//请求来源
    [package appendString:@"\"2\""];//固定值“2” 代表手机
    
    [package appendString:@",\"ts\":"];//时间戳
    [package appendString:@"\""];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *timeStr= [dateFormatter stringFromDate:[NSDate date]];
    
    [package appendString:timeStr];
    [package appendString:@"\""];
    
    [package appendString:@",\"v\":"];//版本号 json 为1.0
    [package appendString:@"\""];
    [package appendString:version];//版本号 json 为1.0
    [package appendString:@"\""];
    [package appendString:@",\"fn\":"];//协议功能名称
    [package appendString:@"\""];
    [package appendString:fName];//协议功能名称
    [package appendString:@"\""];
    
    [package appendString:@",\"fv\":"];//f协议版本号 固定0201
    [package appendString:@"\""];
    [package appendString:@"0201"];
    [package appendString:@"\""];
    if(![SessionTokenID isEqualToString:@""])
    {
        [package appendString:@",\"tk\":"];//tokeID
        [package appendString:@"\""];
        [package appendString:SessionTokenID];
        [package appendString:@"\""];
    }
    [package appendString:@"},\"body\":"];
    
    
    if (NULL != param)
    {
        NSLog(@"%@",param.toString);
        NSString *str = param.toString;
        str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
        str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        //解决英文留言无空格的问题
        //     str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSLog(@"%@",str);
        [package appendString:str];//parameter for feature.
        [package appendString:@"}"];//parameter for feature.
    }else{
        [package appendString:@"{}}"];//parameter for feature.
    }
    
    [dateFormatter release];
    
    NSString *packageStr = package;
    packageStr = [packageStr UrlValueEncode];
    
    packageStr = [NSString stringWithFormat:@"%@%@",urlStr,packageStr];
    
    NSLog(@"responseString %@",packageStr);
    
    
    //NSLog(@"package=%@", escaped);
    
    //[package release];
    //return escaped;
    return packageStr;
}
/*!
 @method setTokenID
 @abstract 类方法
 @discussion 设置tokenID
 @param tokenID tokenID参数
 @result 无
 */
+ (void)setTokenID:(NSString *)tokenID
{
    SessionTokenID = [[NSString alloc] initWithString:tokenID];
    NSLog(@"the tokenID is %@",SessionTokenID);
}
/*!
 @method getTokenID
 @abstract 类方法
 @discussion 取得tokenID
 @result 无
 */
+ (NSString *)getTokenID
{
    return SessionTokenID;
   
}

@end
