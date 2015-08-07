
/*!
 @header UserData.h
 @abstract 操作用户表
 @author mengy
 @version 1.00 12-6-23 Creation
 */
#import <Foundation/Foundation.h>

#define DATABASE_NAME           @"user.db"

#define TABLE_USERDATA          @"USER"

//设备屏幕大小
#define __MainScreenFrame   [[UIScreen mainScreen] bounds]
//设备屏幕宽
#define __MainScreen_Width  __MainScreenFrame.size.width
//设备屏幕高 20,表示状态栏高度.如3.5inch 的高,得到的__MainScreenFrame.size.height是480,而去掉电量那条状态栏,我们真正用到的是460;
#define __MainScreen_Height __MainScreenFrame.size.height-20

//top 标题文字大小22.5
#define TOP_TITLE_FONT_SIZE 22.5
//tab bar 文字大小22.5
#define TAB_BAR_FONT_SIZE 10.5
//返回button 文字位置
#define BACKBTN_TEXT_LOCATION 14

//rightbutton 文字位置
#define RIGHTBTN_TEXT_LOCATION -5

//homebutton 文字位置
#define HOMEBTN_TEXT_LOCATION 6

//导航栏 文字位置向下偏移
#define NAVBTN_TEXT_DOWN_LOCATION 1

//灰色bbbbbb
#define GARY_BB 187
//灰色a4a4a4
#define GARY_A4 164
//30size
#define FONT_SIZE_30 15
//24size
#define FONT_SIZE_24 12
//22size
#define FONT_SIZE_22 11
//28size
#define FONT_SIZE_28 14
//40size
#define FONT_SIZE_40 20
//29size
#define FONT_SIZE_29 14.5
//20size
#define FONT_SIZE_20 10
//18size
#define FONT_SIZE_18 9


//各处map默认的比例尺
#define MAP_ZOOM_DEFAULT_SIZE 14

enum USER_LOGIN_TYPE{
    
    // 用户类型，1：游客；2：演示；3：车主用户；
    USER_LOGIN_DEMO=2,        //demo用户
    USER_LOGIN_OTHER=1,       //游客
    USER_LOGIN_CAR=3          //车辆用户
    
};

enum USER_SEX_TYPE{
    MAN = 1,  //男
    WOMAN =2,//女
};

enum USER_FIRSTLOGIN_TYPE{
    USER_FIRSTLOGIN = 1,  //第一次登录车友
    USER_UNFIRSTLOGIN = 0,//不是第一次登录车友
};
enum USER_LOGIN_STATE{
    USER_LOGIN_WRONG_PASSWORD = 0,  //用户密码错误
    USER_LOGIN_SUCCESS = 1,             //登陆成功
    USER_LOGIN_WITHOTHER=2,            //其他手机登陆
    USER_LOGIN_NO_NET=3,//网络连接失败
    USER_LOGIN_FAILURE=4,//登录失败
    USER_LOGIN_ACCOUNT_NOEXIST=5,//账户不存在
    USER_LOGIN_NO_VEHICLES=6,//没有车
    USER_LOGIN_NO_DREDGE_OR_CLOSE=7,//没有车
    USER_LOGIN_SEVER_LOSE=8//T服务过期
};

enum SERVICE_TYPE{
    SERVICE_TYPE_CHERRY = 1,  //二期服务
    SERVICE_TYPE_LEMO = 0,//一期服务
};

enum VEHICLE_CONTROL_RESULT_CODE{
    VEHICLE_CONTROL_RESULT_SUCCESS = 0,  //车辆控制成功
    VEHICLE_CONTROL_RESULT_FAIL = 1,//失败
};

enum LIST_TYPE{
    FRIEND_LIST = 0,  //好友
    BLACK_LIST =1,//黑名单
};

enum EDIT_TYPE{
    EDIT = 0,  //编辑
    FINISH =1,//完成
};

enum COLLECT_TYPE{
    COLLECT = 1,  //收藏
    UNCOLLECT =0,//取消收藏
};


enum POI_TYPE{
    POI_TYPE_CAR = 1, //车机poi
    POI_TYPE_PHONE =2,  //手机poi
    POI_TYPE_POI=3,     //poi
    POI_TYPE_4S_RESULT=6,//搜索4s结果poi
    POI_TYPE_RESULT=4,//搜索结果poi
    POI_TYPE_CUSTOM=5,// 自定义poi
    POI_TYPE_URL=7// 通过短地址获取的poi
};

enum POI_DETAIL_VIEW_TYPE{
    POI_DETAIL_VIEW_INTEREST= 1, //兴趣点详情界面
    POI_DETAIL_VIEW_CUSTOM =2,  //位置详情界面
};

enum COLLECT_SYNC_TYPE{
    COLLECT_SYNC_NO_ADD =1,  //未同步待添加
    COLLECT_SYNC_YES = 2, //已同步
    COLLECT_SYNC_NO_DEL =3,  //已同步待删除
    COLLECT_SYNC_NO_UPDATE =4,  //已同步待修改
//    COLLECT_NO_ADD =3,  //添加
//    COLLECT_NO_DEL =4,  //删除
};

enum FRIEND_LOAD_TYPE
{
    FRIEND_LOAD_YES=1,//服务器加载
    FRIEND_LOAD_NO=0,//本地加载
};

enum BLACK_LOAD_TYPE
{
    BLACK_LOAD_YES=1,//服务器加载
    BLACK_LOAD_NO=0,//本地加载
};

enum ELEC_LOAD_TYPE
{
    ELEC_LOAD_YES=1,//服务器加载
    ELEC_LOAD_NO=0,//本地加载
};
enum POI_LOAD_TYPE
{
    POI_LOAD_YES=1,//服务器加载
    POI_LOAD_NO=0,//本地加载
};


enum CIRCUM_SEARCH_CENTRAL_TYPE{
    CIRCUM_SEARCH_CENTRAL_TYPE_CAR= 1, //周边搜索以车辆位置为中心
    CIRCUM_SEARCH_CENTRAL_TYPE_CUR =2,  //周边搜索以手机位置为中心
};

//注：下边个消息类型数值必须保持一致
enum MESSAGE_TYPE
{
    MESSAGE_ELECTRONIC=15,// 电子围栏消息
    MESSAGE_SEND_TO_CAR=13,//发送至车消息
    MESSAGE_FRIEND_LOCATION=12,//好友位置消息
    MESSAGE_FRIEND_REQUEST_LOCATION=11,//好友位置请求消息
    MESSAGE_VEHICLE_CONTROL=14,//车辆控制消息
    MESSAGE_VEHICLE_ABNORMAL_ALARM=17,//车辆异常报警消息
    MESSAGE_MAINTENANCE_ALARM=18,//保养提醒消息
    MESSAGE_VEHICLE_STATUS=20,//车辆状况消息
    MESSAGE_VEHICLE_DIAGNOSIS=16,//车辆故障诊断结果
    MESSAGE_VEHICLE_DIAGNOSIS_AUTOMATIC=19,//车辆自动诊断结果
    MESSAGE_SYSTEM=5
};

enum CLEAR_TYPE
{
    CLEAR_SEARCH_HISTORY=1,//删除搜索历史
    
    CLEAR_MESSAGE_ELECTRONIC=15,// 删除电子围栏消息
    CLEAR_MESSAGE_SEND_TO_CAR=13,//删除发送至车消息
    CLEAR_MESSAGE_FRIEND_LOCATION=12,//删除好友位置消息
    CLEAR_MESSAGE_FRIEND_REQUEST_LOCATION=11,//删除好友位置请求消息
    CLEAR_MESSAGE_VEHICLE_CONTROL=14,//删除车辆控制消息
    CLEAR_MESSAGE_VEHICLE_ABNORMAL_ALARM=17,//删除车辆异常报警消息
    CLEAR_MESSAGE_MAINTENANCE_ALARM=18,//删除保养提醒消息
    CLEAR_MESSAGE_VEHICLE_STATUS=20,//删除车辆状况消息
    CLEAR_MESSAGE_VEHICLE_DIAGNOSIS=16,//删除诊断结果消息
    
};



enum MESSAGE_STATUS_TYPE
{
    MESSAGE_READ=1,//已读
    MESSAGE_UNREAD=0,//未读
};

enum RESULT_ROOT_TYPE
{
    RESULT_ROOT_CIRCUM=0,//周边搜索进入
    RESULT_ROOT_SEARCH=1,//搜索进入
};

//1	1	餐饮
//2	2	住宿
//3	3	银行
//4	4	休闲
//5	5	购物
//6	6	加油站
//7	7	交通
enum SEARCH_TYPE_CODE
{
    SEARCH_TYPE_REPAST=1,//搜索餐饮
    SEARCH_TYPE_STAY=2,//搜索住宿
    SEARCH_TYPE_BANK=3,//搜索银行
    SEARCH_TYPE_RELAXATION=4,//搜索休闲
    SEARCH_TYPE_SHOP=5,//搜索餐饮
    SEARCH_TYPE_GAS=6,//搜索加油站
    SEARCH_TYPE_TRAFFIC=7,//搜索交通
    SEARCH_TYPE_4S_STORES=11,//搜索4S店
    SEARCH_TYPE_ORTHER=0//其他
    
};


enum OPERATE_TYPE{
    OPERATE_CREATE_POI = 1, //添加poi
    OPERATE_DELETE_POI = 2, //删除poi
    OPERATE_QUERY_POI = 3,  //查询poi
    OPERATE_PROFILE=4,//版本检测
    OPERATE_FEEDBACK=5,//意见反馈
    OPERATE_LOGIN=6,//登录
    OPERATE_RESCUE=7//救援
};

enum LEVEL_TYPE{
    LEVEL_PRIVATE = 1, //私有
    LEVEL_OPEN = 0, //公开
};

enum EVENT_TYPE
{
    EVENT_TYPE_YES=1,//添加事件
    EVENT_TYPE_NO=0,//不添加事件
};

enum SCREEN_SIZE
{
    SCREEN_SIZE_960_640=1,//960*640
    SCREEN_SIZE_1136_640=0,//1136*640
};

enum FRIEND_LOCATION_RESULT_TYPE
{
    FRIEND_LOCATION_REFUSE=2,//拒绝
    FRIEND_LOCATION_AGREE=1,//同意
    FRIEND_LOCATION_UNTREATED=0,//未处理
};

enum FRIEND_DETAIL_EDIT_BTN_TYPE{
    EDIT_BTN_TYPE_EDIT = 0,  //点击按钮弹出编辑框（ 按钮名字为编辑）
    EDIT_BTN_TYPE_FINISH =1,//点击按钮弹回编辑框（按钮名字为完成，暂时忽略）
};


//1	5	开车门锁
//2	6	关车门锁
//3	7	鸣笛闪灯
//4	1	启动引擎
//5	2	关闭引擎
//6	3	开启空调
//7	4	关闭空调
enum VEHICLE_CONTROL_TYPE
{
    OPEN_DOOR = 5,
    CLOSE_DOOR = 6,
    WHISTLE = 7,
    OPEN_ENGINE = 1,
    CLOSE_ENGINE = 2,
    OPEN_AIRCON = 3,
    CLOSE_AIRCON = 4,
};

enum VEHICLE_DIAGNOSIS_STATE
{
    VEHICLE_DIAGNOSIS_STATE_SUCCESS = 0,//无故障
    VEHICLE_DIAGNOSIS_STATE_SUCCESS_FAULT = 1,//有故障
    VEHICLE_DIAGNOSIS_STATE_FAILURE = 2,//诊断失败
};

enum VEHICLE_DIAGNOSIS_TYPE
{
    VEHICLE_DIAGNOSIS_TYPE_ONLINE = 0,//在线诊断
    VEHICLE_DIAGNOSIS_TYPE_PERIODIC = 1,//定期报告
    VEHICLE_DIAGNOSIS_TYPE_AUTO = 2,//自动诊断
};


enum USER_ACCOUNT_STATE
{
//    USER_ACCOUNT_STATE_LEMO_OR_CHERRY = 0,//用户仅有一期或二期车辆
//    USER_ACCOUNT_STATE_LEMO_AND_CHERRY = 1,//用户有一期和二期车辆
    
    USER_ACCOUNT_STATE_PART_FUNCTION= 0,// 账户下有部分功能（Lemo）
    USER_ACCOUNT_STATE_ALL_FUNCTION = 1,// 账户下有全部功能（Cherry）
};


@interface UserData : NSObject
{
    NSString *mUserKeyID;
    NSString    *mAccount;
    NSString    *mPassword;
    NSInteger mType;
    NSInteger mIsFirstLogin;
    NSString *mCarVin;
    NSString *msafe_pwd;
    NSInteger mFlag;
    NSString *mLon;
    NSString *mLat;
    NSString *mLastReqTime;
    NSString *mUserID;
    
}

@property(nonatomic,copy)NSString *mUserKeyID;
@property(nonatomic,copy)NSString *mUserID;
@property(nonatomic,copy) NSString *mAccount;
@property(nonatomic,copy) NSString *mPassword;
@property(readwrite)NSInteger mType;
@property(readwrite) NSInteger mIsFirstLogin;
@property(nonatomic,copy)NSString *mCarVin;
@property(nonatomic,copy)NSString *msafe_pwd;
@property(readwrite)NSInteger mFlag;
@property(nonatomic,copy)NSString *mLon;
@property(nonatomic,copy)NSString *mLat;
@property(nonatomic,copy)NSString *mLastReqTime;

/*!
 @method initWithName:(NSString *)userKeyID account:(NSString*)account password:(NSString*)password type:(int)type carVin:(NSString *)carVin safe_pwd:(NSString *)msafe_pwd flag:(int)flag lon:(NSString *)lon lat:(NSString *)lat
 lastreqtime:(NSString *)lastreqtime userID:(NSString *)userID
 @abstract 初始化缓存中数据
 @discussion 初始化缓存中数据
 @param 用户信息
 @result self
 */
- (id)initWithName:userKeyID
           account:(NSString*)account
          password:(NSString*)password
              type:(int)type
            carVin:(NSString *)carVin
          safe_pwd:(NSString *)safe_pwd
              flag:(int)flag
               lon:(NSString *)lon
               lat:(NSString *)lat
       lastreqtime:(NSString *)lastreqtime
            userID:(NSString *)userID;

/*!
 @method getUserPassword:(NSString *)userID
 @abstract 根据账号获取密码
 @discussion 根据账号获取密码
 @param userID 用户id
 @result pwd 密码
 */
- (NSString *)getUserPassword:(NSString *)userID;

/*!
 @method isHasUser:(NSString *)userID
 @abstract 判断用户信息是否在数据库中存在
 @discussion 判断用户信息是否在数据库中存在
 @param userID 用户ID
 @result 是否存在
 */
+ (int)isHasUser:(NSString *)userID;

/*!
 @method updateUserData:(NSString *)userKeyID account:(NSString *)account password:(NSString *)password type:(int)type safe_pwd:(NSString *)safe_pwd
 flag:(int)flag lon:(NSString *)lon lat:(NSString *)lat lastreqtime:(NSString *)lastreqtime vin:(NSString *)vin userID:(NSString *)userID
 @abstract 添加或更新用户信息
 @discussion 添加或更新用户信息
 @param 用户信息
 @result 无
 */
- (void)updateUserData:(NSString *)userkeyid
               account:(NSString *)account
              password:(NSString *)password
                  type:(int)type
              safe_pwd:(NSString *)safe_pwd
                  flag:(int)flag
                   lon:(NSString *)lon
                   lat:(NSString *)lat
           lastreqtime:(NSString *)lastreqtime
                   vin:(NSString *)vin
                userID:(NSString *)userID;

/*!
 @method updateIsFirstLogin:(NSString *)userID
 @abstract 修改用户是否首次进入车友
 @discussion 修改用户是否首次进入车友
 @param userID 用户id
 @result 无
 */
- (void)updateIsFirstLogin:(NSString *)userID;

/*!
 @method updateLocation:(NSString *)userID lon:(NSString *)lon lat:(NSString *)lat
 @abstract 更新用户手机位置
 @discussion 更新用户手机位置
 @param userID 用户id
 @param lon 经度
 @param lat 纬度
 @result 无
 */
-(void)updateLocation:(NSString *)userID
                  lon:(NSString *)lon
                  lat:(NSString *)lat;

/*!
 @method updateLastReqTime:(NSString *)userID lastreqtime:(NSString *)lastreqtime
 @abstract 更新用户消息最后请求时间
 @discussion 更新用户消息最后请求时间
 @param userID 用户id
 @param lastreqtime 最后请求时间
 @result 无
 */
-(void)updateLastReqTime:(NSString *)userID
             lastreqtime:(NSString *)lastreqtime;

/*!
 @method updateVinWithUserID:(NSString *)userID vin:(NSString *)vin
 @abstract 更新用户选择车辆的vin
 @discussion 更新用户选择车辆的vin
 @param 用户id
 @param vin 车辆vin
 @result 无
 */
-(void)updateVinWithUserID:(NSString *)userID
                       vin:(NSString *)vin;

/*!
 @method loadUserData
 @abstract 加载用户信息到缓存中
 @discussion 加载用户信息到缓存中
 @param 无
 @result 无
 */
- (void)loadUserData;

/*!
 @method getUserLastReqTime:(NSString *)userID
 @abstract 获取用户最后请求时间，存入缓存
 @discussion 获取用户最后请求时间，存入缓存
 @param 无
 @result 无
 */
- (void)getUserLastReqTime:(NSString *)userID;

/*!
 @method deleteDemo
 @abstract 删除demo账号
 @discussion 删除demo账号
 @param 无
 @result 无
 */
-(void)deleteDemo;

/*!
 @method loadDemoUserData
 @abstract 加载demo用户信息到缓存
 @discussion 加载demo用户信息到缓存
 @param 无
 @result 无
 */
- (void)loadDemoUserData;
@end
