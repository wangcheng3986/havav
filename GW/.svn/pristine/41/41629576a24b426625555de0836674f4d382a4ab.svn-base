/*!
 @header NIApplicationBase.h
 @abstract OpenUIP网络协议管理类
 @author wangliqiong
 @version 1.00 2013/5/30 Creation
 */

#import <Foundation/Foundation.h>
#import "NIOpenUIPData.h"
#import "NIOpenUIPRequest.h"
#import "NINetManager.h"

/*!
 @class NIApplicationBase
 @abstract OpenUIP网络协议的一些处理，并且具有代理NINetDelegate的属性
 */
@interface NIApplicationBase: NSObject<NINetDelegate>
{
    NIOpenUIPRequest *mRequest;
    NSString *mMessage;
    NINetManager *mNetManager;
    
    NSArray *mResultMsg;
    NSArray *mResultInfo;
    int mErrorCode;
}

@property (nonatomic, retain)NIOpenUIPRequest *mRequest;
@property (nonatomic, assign)NSString *mMessage;
@property (nonatomic, retain)NINetManager *mNetManager;
@property (nonatomic, retain)NSArray *mResultMsg;
@property (nonatomic, retain)NSArray *mResultInfo;

/*!
 @method getValueInJSON
 @abstract 从JSON串中取得值
 @discussion 取得协议中key值为_v对应的储存值
 @param TSPstring JSON字符串
 @result 新的字典或字符串
 */
- (id)getValueInJSON:(NSDictionary *)TSPstring;

/*!
 @method getTypeInJSON
 @abstract 从JSON串中取得值
 @discussion 取得协议中key值为_c对应的储存值
 @param TSPstring JSON字符串
 @result 新的字典或字符串
 */
- (int)getTypeInJSON:(NSDictionary *)TSPstring;

/*!
 @method analyseJSON:key:
 @abstract 按照协议解析JSON
 @discussion 按照协议解析JSON
 @param dict JSON集合体
 @param key key值
 @result 新的字典或字符串
 */
- (id)analyseJSON:(NSDictionary *)dict key:(NSString *) key;


/*!
 @method transBstrToStr
 @abstract 将Base 64字符转换成NSString类型
 @discussion 将Base 64字符转换成NSString类型
 @param bstr Base 64字符串
 @result NSString类型字符串
 */
- (NSString *)transBstrToStr:(NSString *) bstr;

/*!
 @method createRequest
 @abstract 创建url请求字符串和设置包头
 @discussion 根据对应协议创建url请求字符串
 @param idValue key值为id的值
 @result 无
 */
- (void)createRequest:(NSString *) idValue;

/*!
 @method sendRequestWithSync
 @abstract 发送同步网络请求
 @discussion 发送同步网络请求
 @result 无
 */
- (id)sendRequestWithSync;

/*!
 @method sendRequestWithAsync
 @abstract 发送异步网络请求
 @discussion 发送异步网络请求
 @result 无
 */
- (void)sendRequestWithAsync;

/*!
 @method sendRequestWithAsync
 @abstract 取消发送网络请求
 @discussion 取消发送网络请求
 @result 无
 */
- (void)cancelRequest;

/*!
 @method convertErrorCode
 @abstract 转换error code对应的message
 @discussion 转换error code对应的message
 @param errorcode 错误码
 @result 字符串信息
 */
- (NSString *)convertErrorCode:(int)errorcode;

/*!
 @method transforToChinese
 @abstract 对汉字进行utf8编码
 @discussion 对汉字进行utf8编码
 @param utf8string 字符串
 @result utf8字符串信息
 */
- (NSString *)transforToChinese:(NSString *)utf8string;

@end

