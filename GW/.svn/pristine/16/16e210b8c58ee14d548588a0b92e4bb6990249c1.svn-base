/*!
 @header NSString+Extensions.m
 @abstract 扩展NSString
 @author mengy
 @version 1.00 14-6-26 Creation
 */
#import "NSString+Extensions.h"
#import "GTMBase64.h"
/*!
 @class
 @abstract 扩展NSString，为单引号再加一个单引号来转义。
 */
@implementation NSString (Extensions)

/*!
 @method avoidSingleQuotesForSqLite
 @abstract 将单引号替换成两个单引号
 @discussion 将单引号替换成两个单引号
 @param 无
 @result self
 */
-(NSString *)avoidSingleQuotesForSqLite
{
    if (self) {
        self =[self stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
        return self;
    }
    else
    {
        return @"";
    }
}


/*!
 @method deleteIllegalCharacter
 @abstract 删除电话号码中非法字符
 @discussion 删除电话号码中非法字符包括（“-”,“(”,")"," ","+86","86"）
 @param 无
 @result self
 */
-(NSString *)deleteIllegalCharacter
{
    if (self) {
        self =[self stringByReplacingOccurrencesOfString:@"-" withString:@""];
        self =[self stringByReplacingOccurrencesOfString:@"(" withString:@""];
        self =[self stringByReplacingOccurrencesOfString:@")" withString:@""];
        self =[self stringByReplacingOccurrencesOfString:@" " withString:@""];
        if([self hasPrefix:@"+86"])
        {
            self = [self stringByReplacingCharactersInRange:NSMakeRange(0, 3) withString:@""];
        }
        if([self hasPrefix:@"86"])
        {
            self = [self stringByReplacingCharactersInRange:NSMakeRange(0, 2) withString:@""];
        }
        return self;
    }
    else
    {
        return @"";
    }
}

/*!
 @method UrlValueEncode
 @abstract 对url进行Encode编码
 @discussion 对url进行Encode编码
 @param 无
 @result self
 */
-(NSString*)UrlValueEncode
{
    self = (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                           (CFStringRef)self,
                                                                           NULL,
                                                                           CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                           kCFStringEncodingUTF8);
    return self;
    
}


/**
 
 *GTM 转码
 
 */

-(NSString *)GTMEncode

{
    
    NSString* originStr = self;
    
    NSString* encodeResult = nil;
    
    NSData* originData = [originStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData* encodeData = [GTMBase64 encodeData:originData];
    
    self = [[[NSString alloc] initWithData:encodeData encoding:NSUTF8StringEncoding]autorelease];
    
    NSLog(@"%@",encodeResult);
    return self;
    
}


/**
 
 * GTM 解码
 
 */

-(NSString *)GTMDecode

{
    
    NSString* encodeStr = self;
    
    NSString* decodeResult = nil;
    
    NSData* encodeData = [encodeStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData* decodeData = [GTMBase64 decodeData:encodeData];
    
    self = [[[NSString alloc] initWithData:decodeData encoding:NSUTF8StringEncoding]autorelease];
    
    NSLog(@"%@",decodeResult);
    return self;
    
}

@end
