/*!
 @header Utils.m
 @abstract 将秒换算成XX:XX格式
 @author kexin
 @version 1.00 12-8-8 Creation
 */
#import "Utils.h"
/*!
 @class
 @abstract 提供换算方法
 */
@implementation Utils

/*!
 @method formatTime：
 @abstract 将秒换算成XX:XX格式，返回
 @discussion 将秒换算成XX:XX格式，返回
 @param time 时间（秒）
 @result str 换算后的字符串格式为XX:XX
 */
+ (NSString*)formatTime:(int)time
{
    int min = time / 60;
    int sec = time % 60;
    NSMutableString *string = [[[NSMutableString alloc]initWithCapacity:0]autorelease];
    if(min < 10)
    {
        [string appendFormat:@"0%d:",min];
    }
    else
    {
        [string appendFormat:@"%d:",min];
    }
    if(sec < 10)
    {
        [string appendFormat:@"0%d",sec];
    }
    else
    {
        [string appendFormat:@"%d",sec];
    }
    return string;
}

@end
