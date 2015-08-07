/*!
 @header NIOpenUIPData.h
 @abstract This class is used for save Data with JSON type.
 @author wangliqiong
 @version 1.00 2013/5/30 Creation
 */


/**
 * int     1  default value is 0
 * bstr    2  default value is “”    
 * long    3  default value is 0
 * string  4  default value is “”    
 * time    5  default value is 0     
 * boolean 6  default value is false
 * float   7  default value is 0.0f
 * double  8  default value is 0.0d
 * map     9
 * list    10
 *
 */

#import <Foundation/Foundation.h>

#import "GTMBase64.h"
/*!
 @class
 @abstract OpenUIP协议数据管理类，通过协议参数，设置相应类型的值，拼成请求url
 */
@interface NIOpenUIPData : NSObject
{
    NSMutableDictionary *mutableDict;
//    NSString *KeyValue;
//    NSString *TypeValue;
}
@property (nonatomic, assign)NSMutableDictionary *mutableDict;
//@property (nonatomic, retain)NSString *KeyValue;
//@property (nonatomic, retain)NSString *TypeValue;
/*!
 @method setInt:value:
 @abstract 设置int类数据型存储到字典中
 @discussion 设置int类数据型存储到字典中，int,1
 @param key 协议中相应的key值
  @param value key值对应的存储数据
 @result bool类型
 */
- (bool)setInt:(NSString *)key value:(int)value;
/*!
 @method setBstr:value:
 @abstract 设置bstr类数据型存储到字典中
 @discussion bstr is a string with Chinese characters, its type value is 2
 @param key 协议中相应的key值
 @param value key值对应的存储数据
 @result bool类型
 */
- (bool)setBstr:(NSString *) key value:(NSString *)value;
/*!
 @method setLong:value:
 @abstract 设置long类数据型存储到字典中
 @discussion long's type value is 3
 @param key 协议中相应的key值
 @param value key值对应的存储数据
 @result bool类型
 */
- (bool)setLong:(NSString *)key value:(long long)value;
/*!
 @method setString:value:
 @abstract 设置String类数据型存储到字典中
 @discussion String's type value is 4.
 @param key 协议中相应的key值
 @param value key值对应的存储数据
 @result bool类型
 */
- (bool)setString:(NSString *)key value:(NSString *)value;
/*!
 @method setTime:date:
 @abstract 设置long long类数据型存储到字典中
 @discussion long long's type value is 5.
 @param key 协议中相应的key值
 @param value key值对应的存储数据
 @result bool类型
 */
- (bool)setTime: (NSString *)key date:(long long)value;
/*!
 @method setBoolean:value:
 @abstract 设置boolean类数据型存储到字典中
 @discussion boolean's type value is 6
 @param key 协议中相应的key值
 @param value key值对应的存储数据
 @result bool类型
 */
- (bool)setBoolean:(NSString *)key value:(NSString *)value;
/*!
 @method setFloat:value:
 @abstract 设置float类数据型存储到字典中
 @discussion float's type value is 7.
 @param key 协议中相应的key值
 @param value key值对应的存储数据
 @result bool类型
 */
- (bool)setFloat:(NSString *)key value:(float)value;
/*!
 @method setDouble:value:
 @abstract 设置double类数据型存储到字典中
 @discussion double's type value is 8
 @param key 协议中相应的key值
 @param value key值对应的存储数据
 @result bool类型
 */
- (bool)setDouble: (NSString *) key value:(double)value;
/*!
 @method setObject:object:
 @abstract 设置Map类数据型存储到字典中
 @discussion Map's type value is 9
 @param key 协议中相应的key值
 @param value key值对应的存储数据
 @result bool类型
 */
- (bool)setObject:(NSString *)key object:(NSMutableDictionary *)object;
/*!
 @method setList:list:
 @abstract 设置list类数据型存储到字典中
 @discussion List's type value is 10
 @param key 协议中相应的key值
 @param value key值对应的存储数据
 @result bool类型
 */
- (bool)setList:(NSString *)key list:(NSArray *)value;
/*!
 @method setObjList:list:
 @abstract 设置list类数据型存储到字典中
 @discussion List's type value is 10
 @param key 协议中相应的key值
 @param value key值对应的存储数据
 @result bool类型
 */
- (bool)setObjList:(NSString *)key list:(NSArray *)value;
/*!
 @method toString:list:
 @abstract tranfor the mutableDict from NSDictionary to NSString
 @discussion List's type value is 10
 @result NSString类型
 */
- (NSString *)toString;
/*!
 @method formatDate
 @abstract 空函数没有实现
 @discussion 预留
 @result 空
 */
- (NSString *)formatDate:(NSDate *)date;
/*!
 @method OpenUIPData
 @abstract 类方法
 @discussion 创建一个NIOpenUIPData，释放方式autorelease
 @result NIOpenUIPData实例
 */
+ (NIOpenUIPData *)OpenUIPData;
@end
