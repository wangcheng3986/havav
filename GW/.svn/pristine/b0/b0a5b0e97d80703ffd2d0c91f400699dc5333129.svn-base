/*!
 @header NetManager.h
 @abstract 网络请求管理类
 @author wangqiwei
 @version 1.00 2012/4/25 Creation
 */
#import <Foundation/Foundation.h>

#import "NetDelegate.h"

//enum  
//{
//    NET_MODE_GET = 0,
//    NET_MODE_POST = 1
//};
/*!
 @class NetManager
 @abstract 网络请求管理类
 */
@interface NetManager : NSObject<NSURLConnectionDelegate>
{
    NSURLConnection         *oConn;
    NSMutableURLRequest     *oRequest;
    NSMutableData           *oDataBuf;
    
    id<NetDelegate>         netDelegate;
}
/*!
 @method initWithUrl
 @abstract 初始化http请求头信息
 @discussion 初始化http请求头信息
 @param oUrl URL请求参数
 @result [self init]
 */
-(id)initWithUrl:(NSURL*)oUrl;
/*!
 @method initWithString
 @abstract 初始化URL信息
 @discussion 初始化URL信息，输入字符串
 @param sUrl URL地址
 @result [self init]
 */
-(id)initWithString:(NSString*)sUrl;
/*!
 @method dealloc
 @abstract 内存释放
 @discussion 系统内部内存释放函数
 @result 无
 */
-(void)dealloc;
/*!
 @method setMethod
 @abstract 设置http请求方式
 @discussion 设置http请求方式
 @param mode 0:POST 1:GET
 @result 无
 */
-(void)setMethod:(int)mode;
/*!
 @method setPostData
 @abstract 设置http请求以post方式
 @discussion 此方法以POST方式请求网络，不可修改请求方式
 @param data 请求的输入数据
 @result 无
 */
-(void)setPostData:(NSData*)data;
/*!
 @method requestWithSynchronous
 @abstract 发送同步网络请求
 @discussion 发送同步网络请求
 @result 网络请求返回的数据
 */
-(NSData*)requestWithSynchronous;
/*!
 @method requestWithAsynchronous
 @abstract 发送异步网络请求
 @discussion 发送异步网路请求
 @param delegate 网络请求代理函数对象
 @result 无
 */
-(void)requestWithAsynchronous:(id<NetDelegate>)delegate;

@end
