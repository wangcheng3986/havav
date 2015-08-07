

/*!
 @header Resources.h
 @abstract 管理文字资源
 @author kexin
 @version 1.00 12-6-5 Creation
 */

#import <Foundation/Foundation.h>
/*!
 @class
 @abstract 资源文字类。
 */
@interface Resources : NSObject<NSXMLParserDelegate>
{
    NSMutableDictionary *mDataList;
    NSMutableDictionary *mDefList;
    NSMutableDictionary *mTempList;
}

/*!
 @method getInstance
 @abstract 实例化Resources，单例
 @discussion 实例化Resources，单例
 @param 无
 @result self
 */
+(id)getInstance;

/*!
 @method dealloc
 @abstract 释放数据存储空间
 @discussion 释放数据存储空间
 @param 无
 @result 无
 */
- (void)dealloc;

- (void)setLanguage:(NSString*)language;

/*!
 @method addTextFromFile:
 @abstract 从文件中读取文字信息
 @discussion 从文件中读取文字信息
 @param file 文件名
 @result 无
 */
- (void)addTextFromFile:(NSString*)file;

/*!
 @method getText:
 @abstract 获取文字资源
 @discussion 获取文字资源
 @param key
 @result text 文字
 */

- (NSString*)getText:(NSString*)key;

/*!
 @method getTextWithEnter:
 @abstract 获取文字资源
 @discussion 获取文字资源
 @param key
 @result text 文字
 */
- (NSString *)getTextWithEnter:(NSString *)key;

/*!
 @method getText: withIndex:
 @abstract 获取key对应的文字中第index行文字
 @discussion 获取key对应的文字中第index行文字
 @param key
 @param index 第几行
 @result text 文字
 */
- (NSString*) getText:(NSString *)key withIndex:(NSInteger)index;
- (NSString*)getText:(NSString *)key withPlaceHolders:(NSArray *)PlaceHolders withDescriptions:(NSArray*)Descriptions;
- (NSString*)getText:(NSString *)key withPlaceHolder:(NSString *)PlaceHolder withDescription:(NSString*)Description;
@end
