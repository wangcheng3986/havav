
/*!
 @header NSString+Extensions.h
 @abstract 扩展NSString
 @author mengy
 @version 1.00 14-6-26 Creation
 */

#import <Foundation/Foundation.h>
/*!
 @class
 @abstract 扩展NSString，为单引号再加一个单引号来转义。
 */
@interface NSString (Extensions)
/*!
 @method avoidSingleQuotesForSqLite
 @abstract 将单引号替换成两个单引号
 @discussion 将单引号替换成两个单引号
 @param 无
 @result self
 */
-(NSString *)avoidSingleQuotesForSqLite;

/*!
 @method deleteIllegalCharacter
 @abstract 删除电话号码中非法字符
 @discussion 删除电话号码中非法字符包括（“-”,“(”,")"," ","+86","86"）
 @param 无
 @result self
 */
-(NSString *)deleteIllegalCharacter;


/*!
 @method UrlValueEncode
 @abstract 对url进行Encode编码
 @discussion 对url进行Encode编码
 @param 无
 @result self
 */
-(NSString*)UrlValueEncode;



/**
 
 *GTM 转码
 
 */

-(NSString *)GTMEncode;

/**
 
 * GTM 解码
 
 */

-(NSString *)GTMDecode;
@end
