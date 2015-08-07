/*!
 @header NIOpenUIPRequest.h
 @abstract OpenUIP协议请求设置
 @author wangliqiong
 @version 1.00 2013/5/30 Creation
 @version 1.1 2013-7-08 wlq Add the set of TokenID
 */
#import <Foundation/Foundation.h>
#import "NIOpenUIPData.h"
#import "NIOpenUIPHeader.h"
/*!
 @class
 @abstract OpenUIP协议网络数据管理类，设置请求相关参数
 */
@interface NIOpenUIPRequest : NSObject
{
	NSString *url;
    
	//sequence number
    int seq;
    
	//v,OpenUIP's version, the default value is 1.0
    NSString *version;
    
	//pe,param's encryption type. the value maybe as [base64,3DES,AES,NULL],default is NULL(no encryption)
    NSString *paramEncrypt;
    
	//re,the result's encrtion type. the value maybe as [base64,3DES,AES,NULL],default is NULL(no encryption)
    NSString *resultEncrypt;
    
	//ic,compressed or not.
    Boolean isKeyCompressed;
    
	//d,UP or DOWN.
    NSString *dir;
    
	//ts,time of Client send request.
    long long time;
    
	//function's name
    NSString *fName;
    
	//function's version
    NSString *fVersion;
    
	//as,true means asynchronous,false means synchronous.
    Boolean isAsync;
    
	//tk,the token id generate by service
    NSString *tokenId;
    
	//tt,time out value.
    int timeout;
    
	//if need to return, default is true. 
    Boolean isNeedReturn;
    
	//parameter
    NIOpenUIPData *param;
	
}



@property (nonatomic, retain)NSString *url;
@property (nonatomic)int seq;
@property (nonatomic, retain)NSString *version;
@property (nonatomic, retain)NSString *paramEncrypt;
@property (nonatomic, retain)NSString *resultEncrypt;
@property (nonatomic)Boolean isKeyCompressed;
@property (nonatomic, retain)NSString *dir;
@property (nonatomic)long long time;
@property (nonatomic, retain)NSString *fName;
@property (nonatomic, retain)NSString *fVersion;
@property (nonatomic)Boolean isAsync;
@property (nonatomic, retain)NSString *tokenId;
@property (nonatomic)int timeout;
@property (nonatomic)Boolean isNeedReturn;
@property (nonatomic, retain)NIOpenUIPData *param;

/*!
 @method init
 @abstract 初始化函数
 @discussion 设置url请求初始化参数
 @result self
 */
- (id)init;
/*!
 @method dealloc
 @abstract 内存释放
 @discussion 内存释放
 @result 无
 */
- (void)dealloc;
/*!
 @method getNextSeq
 @abstract 请求计数器
 @discussion 请求计数器
 @result 无
 */
- (int)getNextSeq;
/*!
 @method generatePackage
 @abstract url字符串拼接操作
 @discussion url字符串拼接操作
 @result NSString类型的URL链接
 */
- (NSString *)generatePackage;
/*!
 @method setTokenID
 @abstract 类方法
 @discussion 设置tokenID
 @param tokenID tokenID参数
 @result 无
 */
+ (void)setTokenID:(NSString *)tokenID;
/*!
 @method getTokenID
 @abstract 类方法
 @discussion 取得tokenID
 @result 无
 */
+ (NSString *)getTokenID;
@end

