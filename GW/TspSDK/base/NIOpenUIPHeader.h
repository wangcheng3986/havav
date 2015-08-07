/*!
 @header NIOpenUIPHeader.h
 @abstract 宏定义类
 @author wangliqiong
 @version 1.00 2013/5/30 Creation
 */

#ifndef OpenTSP_NIOpenUIPHeader_h

#define OpenTSP_NIOpenUIPHeader_h

//沈阳
//#define SERVER_URL @"http://61.161.176.174:8084"
//
//#define PORTAL_SERVER_URL @"https://61.161.176.174:8084" 

//沈阳二期

//#define SERVER_URL @"https://172.19.1.203:8443"
//#define PORTAL_SERVER_URL @"http://172.19.1.203:8080"
//#define ADD_URL @"/tsp/cherry"

//沈阳测试
//#define SERVER_URL @"https://172.19.1.231:8443"
//
//#define PORTAL_SERVER_URL @"http://172.19.1.231:8080"
//
//#define ADD_URL @"/ibr/cherry"

//沈阳测试外网
//#define SERVER_URL @"https://220.113.176.150:8995"
//
//#define PORTAL_SERVER_URL @"http://220.113.176.150:8080"
//
//#define ADD_URL @"/ibr/cherry"



//陈磊
//#define SERVER_URL @"http://172.19.1.105:8080"
//#define PORTAL_SERVER_URL @"http://172.19.1.203:8080"

//#define ADD_URL @"/tsp/cherry"

//腾腾
//#define SERVER_URL @"https://172.19.1.97:8443"
//#define PORTAL_SERVER_URL @"http://172.19.1.203:8080"
//
//#define ADD_URL @"/gwtsp/cherry"

//吉日
//#define SERVER_URL @"https://172.19.1.168:8443"
//#define PORTAL_SERVER_URL @"https://172.19.1.168:8080"

//#define ADD_URL @"/tsp/cherry"


//沈阳服务器

//保定
#define SERVER_URL @"https://ti.gwm.com.cn:8443"

//portal SERVER_URL
#define PORTAL_SERVER_URL @"http://t.gwm.com.cn"

#define ADD_URL @"/tsp/cherry"


//保定预发布环境
//#define SERVER_URL @"https://121.18.239.68:8443"
//
////portal SERVER_URL
//#define PORTAL_SERVER_URL @"http://121.18.239.68:8080"
//
//#define ADD_URL @"/tsp/cherry"


//portal PORTAL_PROTOCOL_URL
#define PORTAL_PROTOCOL_URL @"http://t.gwm.com.cn/page/account/legal.html"


#define FUNCTION_VERSION @"1.0"
#define DIR @"U"


/*
 平台状态码
 
 序号	成员名	             	字典值	类型
 1	注销成功		         100	     int		
 2	服务成功		         0	     int		
 3	功能访问未授权		     -100	int		
 4	tokenId无效		     -101	int		
 5	组件异常		          -102	int		
 6	json相关异常		     -104	int		
 7	业务参数解析异常		 -105	int		
 8	没找到任何参数		     -106	int		
 9	未提供协议版本号异常		 -107	int		
 10	参数未提供fname		 -108	int		
 11	相同会话使用不同代理异常	 -109	int		
 12	nodesession创建异常	 -110	int		
 13	未找到fname对应功能异常	 -111	int		
 14	接口功能类无法实例化		 -112	int		
 15	未知的功能装载元描述		 -113	int		
 16	节点功能执行器异常		 -114	int		
 17	未知错误		          -500	int		

 
 */

//#define NAVINFO_RESULT_SUCCESS          0     //见枚举值NET_INTERFACE_ERROR
//#define NAVINFO_RESULT_FAIL             1
#define NAVINFO_LOGOUT_SUCCESS               100//注销成功
#define NAVINFO_FUNCTION_UNAUTHORIZED        -100//功能访问未授权
#define NAVINFO_TOKENID_INVALID              -101//tokenId无效
#define NAVINFO_COMPONENT_EXCEPTION          -102//组件异常
#define NAVINFO_JSON_EXCEPTION               -104//json相关异常
#define NAVINFO_BUSINESS_PARSING_EXCEPTION   -105//业务参数解析异常
#define NAVINFO_PARAMETER_NOT_FIND           -106//没找到任何参数
#define NAVINFO_PROTOCOL_VERSION_EXCEPTION   -107//未提供协议版本号异常
#define NAVINFO_FNAME_NOT_PROVIDE            -108//参数未提供fname
#define NAVINFO_SESSION_PROXY_EXCEPTION      -109//相同会话使用不同代理异常
#define NAVINFO_NODESESSION_CREATE_EXCEPTION -110//nodesession创建异常
#define NAVINFO_FNAME_FUNCTION_NOT_FIND      -111//未找到fname对应功能异常
#define NAVINFO_INTERFACE_INSTANCE_EXCEPTION -112//接口功能类无法实例化
#define NAVINFO_UNKNOWN_FUNCTION_LOAD        -113//未知的功能装载元描述
#define NAVINFO_NODE_FUNCTION_EXCEPTION      -114//节点功能执行器异常
#define NAVINFO_RESULT_UNKNOWN_ERROR         -500//未知错误
#define NAVINFO_TOKENID_DIFFERENT_IN_SESSION -115//tokenId与当前http session绑定的tokenId不同
#define NAVINFO_SEND2CAR_SEND_MORETHAN_LIMIT  -1// send2car发送次数超过限制

#define NAVINFO_LOGIN_ACCOUNT_NOEXIST -1// login账户不存在
#define NAVINFO_LOGIN_NO_VEHICLES -2// login当前登录账户名下没有车辆，不可登陆
#define NAVINFO_LOGIN_NO_DREDGE_OR_CLOSE -3//当前账户未开通T服务或服务处于停止状态。
#define NAVINFO_LOGIN_PWD_ERROR  -4// login账号密码错误
//#define NAVINFO_LOGIN_SEVER_LOSE  -5// login账号密码错误

#define NAVINFO_FRIEND_ADD_EXIST -1//所添加的车友已存在
#define NAVINFO_FRIEND_ADD_NO_T_SERVER -2//所添加的手机号没有注册或开通长城T服务。
#define NAVINFO_FRIEND_REFRESH_NO_LOC_TIME -1 //自己详情界面最后一次位置没有时间
#define NAVINFO_FRIEND_BLACKLIST_RESULT -1 //已经加入到黑名单
#define NAVINFO_FRIEND_REQUEST_FREQUENT -1 //位置请求频繁
#define NAVINFO_FRIEND_REQUEST_FRIEND_NO_CAR -2 //请求的车友没有车

#define NAVINFO_LOGIN_PRE_PWD_RECOVERY_ACCOUNT_NOEXIST -1// 该账号不存在
#define NAVINFO_LOGIN_PRE_PWD_RECOVERY_SEND_FAILURE -2// 短信激活码发送失败
#define NAVINFO_LOGIN_PRE_PWD_RECOVERY_ACCOUNT_OPENDED -3// 该账户已经开通
#define NAVINFO_LOGIN_PRE_PWD_RECOVERY_ACCOUNT_NOBOUND_VEHICLE -4// 该账户还未绑定车辆
#define NAVINFO_LOGIN_PRE_PWD_RECOVERY_ACCOUNT_UNOPEN -6// 该账户未开通



#define NAVINFO_LOGIN_PWD_RECOVERY_SMSCODE_ERROR -4// 短信激活码有误
#define NAVINFO_LOGIN_PWD_RECOVERY_ACCOUNT_NOEXIST -1// 账户不存在
#define NAVINFO_LOGIN_PWD_RECOVERY_ACCOUNT_OPENDED -2// 该账户已经开通
#define NAVINFO_LOGIN_PWD_RECOVERY_ACCOUNT_NO_VEHICLES -3// 该账户还未与车辆绑定


#define NAVINFO_LOGIN_RESETPWD_RECOVERY_ACCOUNT_UNOPEND -2// 该账户未开通

//car
#define NAVINFO_ELEC_NUM_EXIST -1//此车辆已经存在3个电子围栏
#define NAVINFO_ELEC_VALID_EXIST -2//此车辆已经存在一个有效的电子围栏
#define NAVINFO_MODIFY_VALID_EXIST -1//此车辆已经存在一个有效的电子围栏

#define NAVINFO_CONTROL_ERROR -1//安防密码错误
#define NAVINFO_CONTROL_EXECUTING -2//有指令正在执行

#define NAVINFO_VEHICLE_STATUS_EXECUTING -1//有指令正在执行

#define NAVINFO_VEHICLE_DIAGNOSIS_EXECUTING -1//有指令正在执行
enum NET_INTERFACE_ERROR{
    NAVINFO_RESULT_SUCCESS = 0,
    NAVINFO_RESULT_FAIL = 1,
    
    INPUT_PARAM_ERROR = 401,
    INNER_ERROR = 500,             // 程序内部错误
    NET_ERROR = 501,               // 网络错误，无法建立连接或连接超时
    RETURN_EMPTY = 502,// 应答为空
    RETURN_PROTOCOL_ERROR = 503,   // 应答不符合协议格式
    USER_CANCEL_ERROR = 506        // 网络请求被取消
    
};

#endif
