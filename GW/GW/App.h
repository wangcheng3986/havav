
/*!
 @header App.h
 @abstract 与数据库交互类，公共方法类
 @author mengy
 @version 1.00 12-6-9 Creation
 */
#import <Foundation/Foundation.h>
#import "UIFont+Extensions.h"
#import "NSString+Extensions.h"
#import "LeftButton.h"
#import "RightButton.h"
#import "HomeButton.h"
#import "AppInfo.h"
#import "UserData.h"
#import "CarData.h"
#import "FriendsData.h"
#import "BlackData.h"
#import "SearchHistoryData.h"
#import "MessageInfoData.h"
#import "FriendLocationData.h"
#import "ElectronicFenceMessageData.h"
#import "SendToCarMessageData.h"
#import "SystemMessageData.h"
#import "FriendRequestLocationMessageData.h"
#import "POIData.h"
#import "NIDemoData.h"
#import <CoreLocation/CoreLocation.h>
#import <MessageUI/MFMessageComposeViewController.h>
#import "CherryDBControl.h"
#import "Resources.h"
#import "GuideViewController.h"
@class BaseViewController;
@class MainWindow;
@class NIPoi;
@class NICustomPoi;
@interface App : NSObject <CLLocationManagerDelegate,UIAlertViewDelegate,MFMessageComposeViewControllerDelegate>
{
    UIWindow    *mWindow;
    UIWebView *phoneCallWebView;
    UserData    *mUserData;
    CarData     *mCarData;
    FriendsData *mfriendData;
    BlackData   *mBlackData;
    SearchHistoryData *mSearchHistory;
    MessageInfoData *mMessageInfoData;
    ElectronicFenceMessageData *mElectronicFenceData;
    FriendLocationData *mFriendLocationData;
    FriendRequestLocationMessageData *mFriendReqLocationData;
    SendToCarMessageData *mSendToCarMessageData;
    SystemMessageData *mSystemMessageData;
    NIDemoData *mDemoData;
    POIData *mPOIData;
    NSTimer     *mTimer;
    NSTimer     *mUpdateTimer;
    NSTimer     *mCheckCarTimer;
    double      mTimeout;
    double      mSessionTime;
    int mLoginState;
    NICustomPoi *mCarPOI;
    NICustomPoi *mCurPOI;
    NICustomPoi *mCentralPOI;
    NSString *centralLat;
    NSString *centralLon;
    int demoIsFirstLoginFriend;
    int friendLoadType;
    int blackLoadType;
    NSString *loginID;
    NSString *selfPhone;
    NSThread *requestThread;
    
    //cherry
    CherryDBControl *mCherryDBControl;
}

@property(readonly)UserData *mUserData;
@property(readonly)CarData *mCarData;
@property(retain)NICustomPoi *mCarPOI;
@property(retain)NICustomPoi *mCurPOI;
@property(copy)NICustomPoi *mCentralPOI;
@property(assign)int demoIsFirstLoginFriend;
@property(assign)int friendLoadType;
@property(assign)int blackLoadType;
@property(assign,nonatomic)int elecLoadType;
//@property(retain)NSString *centralLat;
//@property(retain)NSString *centralLon;
@property BOOL IsFirstLogin;
@property(nonatomic,copy)NSString *loginID;
@property(nonatomic,copy)NSString *bCall;
@property(nonatomic,copy)NSString *selfPhone;
@property(assign, nonatomic)NSString *deviceTokenId;
@property(assign, nonatomic)int userAccountState;

/*!
 @method setExclusiveTouchForButtons:(UIView *)myView
 @abstract 控制不可多触点
 @discussion 控制不可多触点
 @param myView 要控制的view
 @result 无
 */
+ (void)setExclusiveTouchForButtons:(UIView *)myView;

/*!
 @method getInstance
 @abstract 实例化app，单例
 @discussion 实例化app，单例
 @param 无
 @result self
 */
+ (id)getInstance;

/*!
 @method getSystemVer
 @abstract 获取版本信息
 @discussion 获取版本信息
 @param 无
 @result version
 */
+ (float)getSystemVer;

/*!
 @method getTimeSince1970
 @abstract 获取本地时间，增量格式
 @discussion 获取本地时间，增量格式
 @param 无
 @result time
 */
+(NSString *)getTimeSince1970;
+(NSString *)getTimeSince1970_1000;
/*!
 @method getSystemTime
 @abstract 获取本地时间
 @discussion 获取本地时间
 @param 无
 @result time
 */
+(NSString *)getSystemTime;
+(NSString *)getSystemLastTime;
/*!
 @method getDateWithTimeSince1970:(NSString *)time
 @abstract 将Since1970时间格式转换成yyyy-MM-dd HH:mm:ss
 @discussion 将Since1970时间格式转换成yyyy-MM-dd HH:mm:ss
 @param time 增量时间
 @result time yyyy-MM-dd HH:mm:ss格式时间
 */
+(NSString *)getDateWithTimeSince1970:(NSString *)time;

/*!
 @method convertDateToLocalTime:(NSDate *)forDate
 @abstract 将北京时间转换成当前系统类型的时间
 @discussion 将北京时间转换成当前系统类型的时间
 @param forDate 北京时间
 @result date 本地时间
 */
+(NSDate *)convertDateToLocalTime:(NSDate *)forDate;

/*!
 @method convertDateToGMT:(NSDate *)forDate
 @abstract 将当前时区的时间转换成北京时区的时间
 @discussion 将当前时区的时间转换成北京时区的时间
 @param forDate 本地时间
 @result date 北京时间
 */
+(NSDate *)convertDateToGMT:(NSDate *)forDate;

/*!
 @method getFirstLetter:(NSString *)keyWord
 @abstract 获取首字母
 @discussion 获取首字母
 @param keyWord 文字
 @result char 首字母
 */
+(NSString *)getFirstLetter:(NSString *)keyWord;

/*!
 @method getPinyin:(NSString *)keyWord
 @abstract 获取拼音
 @discussion 获取拼音
 @param keyWord 文字
 @result NSString 拼音
 */
+(NSString *)getPinyin:(NSString *)keyWord;

/*!
 @method isNumText:(NSString *)str
 @abstract 判断一组字符是否为纯数字
 @discussion 判断一组字符是否为纯数字
 @param str 文字
 @result BOOL
 */
+(BOOL)isNumText:(NSString *)str;

/*!
 @method isNSNull:(NSString *)str
 @abstract 判断字符串是否为nsnull
 @discussion 判断字符串是否为nsnull
 @param str 字符串
 @result BOOL
 */
+(BOOL)isNSNull:(NSString *)str;

/*!
 @method callPhone:(NSString*)tel
 @abstract 拨打电话
 @discussion 拨打电话
 @param tel 电话号码
 @result 无
 */
- (void)callPhone:(NSString*)tel;

/*!
 @method sendSMS:(NSString *)bodyOfMessage
 @abstract 发送短信
 @discussion 发送短信
 @param bodyOfMessage 短信内容
 @result 无
 */
- (void)sendSMS:(NSString *)bodyOfMessage;

/*!
 @method openBrowser:(NSString*)url
 @abstract 打开网页
 @discussion 打开网页
 @param url 网址
 @result 无
 */
- (void)openBrowser:(NSString*)url;

/*!
 @method setWindow:(UIWindow*)window
 @abstract 设置窗体
 @discussion 设置窗体
 @param window 窗体
 @result 无
 */
- (void)setWindow:(UIWindow*)window;

/*!
 @method pushController:(BaseViewController*)oController animated:(BOOL)animated
 @abstract push一个界面
 @discussion push一个界面
 @param oController 界面
 @param animated 动画
 @result 无
 */
- (void)pushController:(BaseViewController*)oController animated:(BOOL)animated;

/*!
 @method pushController:(BaseViewController *)oController animated:(BOOL)animated backTitle:(NSString*)title
 @abstract push一个界面并传入其返回按钮的title
 @discussion push一个界面并传入其返回按钮的title
 @param oController 界面
 @param animated 动画
 @param title 返回按钮文字
 @result 无
 */
- (void)pushController:(BaseViewController *)oController animated:(BOOL)animated backTitle:(NSString*)title;

/*!
 @method pushController:(BaseViewController *)oController animated:(BOOL)animated backTitle:(NSString*)backtitle Title:(NSString *)title
 @abstract push一个界面并传入其返回按钮的title 以及导航栏的title
 @discussion push一个界面并传入其返回按钮的title 以及导航栏的title
 @param oController 界面
 @param animated 动画
 @param backTitle 返回按钮文字
 @param title 导航栏title
 @result 无
 */
- (void)pushController:(BaseViewController *)oController animated:(BOOL)animated backTitle:(NSString*)backtitle Title:(NSString *)title;

/*!
 @method popController:(BOOL)animated
 @abstract 移除一个界面
 @discussion 移除一个界面
 @param animated 动画
 @result 无
 */
- (void)popController:(BOOL)animated;

/*!
 @method popToRootController:(BOOL)animated
 @abstract 移除界面至root界面
 @discussion 移除界面至root界面
 @param animated 动画
 @result 无
 */
- (void)popToRootController:(BOOL)animated;

/*!
 @method setRootController:(BaseViewController*)oController
 @abstract 设置root界面
 @discussion 设置root界面
 @param oController 界面
 @result 无
 */
- (void)setRootController:(BaseViewController*)oController;
- (void)setGuideRootController:(GuideViewController*)oController;
/*!
 @method getTopControllerID
 @abstract 获取最上方的窗口ID
 @discussion 获取最上方的窗口ID
 @param 无
 @result id
 */
- (int)getTopControllerID;

/*!
 @method getTopController
 @abstract 获取最上方的窗口
 @discussion 获取最上方的窗口
 @param 无
 @result BaseViewController
 */
- (BaseViewController*)getTopController;

/*!
 @method getCurController
 @abstract 获取当前窗口
 @discussion 获取当前窗口
 @param 无
 @result BaseViewController
 */
- (BaseViewController*)getCurController;

/*!
 @method hideBar
 @abstract 隐藏导航栏
 @discussion 隐藏导航栏
 @param 无
 @result 无
 */
- (void)hideBar;

/*!
 @method showBar
 @abstract 显示导航栏
 @discussion 显示导航栏
 @param 无
 @result 无
 */
- (void)showBar;

/*!
 @method clearUser
 @abstract 清除用户信息
 @discussion 清除用户信息
 @param 无
 @result 无
 */
- (void)clearUser;

/*!
 @method presentController:(BaseViewController *)oController animated:(BOOL)animated transitionStyle:(int)style
 @abstract 创建一个模态视图，并设置其过渡类型
 @discussion 创建一个模态视图，并设置其过渡类型
 @param oController 界面
 @param animated 是否显示动画
 @param style 动画类型
 @result 无
 */
- (void)presentController:(BaseViewController *)oController animated:(BOOL)animated transitionStyle:(int)style;

/*!
 @method setSheet:(id) action
 @abstract 设置action
 @discussion 设置action
 @param action
 @result 无
 */
- (void) setSheet:(id) action;

/*!
 @method setNav:(id) nav
 @abstract 设置nav
 @discussion 设置nav
 @param nav
 @result 无
 */
- (void) setNav:(id) nav;

/*!
 @method hideSheet
 @abstract 隐藏Sheet
 @discussion 隐藏Sheet
 @param 无
 @result 无
 */
- (void) hideSheet;

/*!
 @method showSheet
 @abstract 显示Sheet
 @discussion 显示Sheet
 @param 无
 @result 无
 */
- (void) showSheet;

/*!
 @method getNav
 @abstract 获取Nav
 @discussion 获取Nav
 @param 无
 @result nav
 */
- (UINavigationController *) getNav;

/*!
 @method deviceString
 @abstract 获取当前设备信息
 @discussion 获取当前设备信息
 @param 无
 @result str
 */
+ (NSString*)deviceString;

/*!
 @method ios7ViewLocation:(UIViewController *)sender
 @abstract 设置ios7下界面显示位置
 @discussion 设置ios7下界面显示位置
 @param sender 界面
 @result 无
 */
+(void)ios7ViewLocation:(UIViewController *)sender;

/*!
 @method getVersion
 @abstract 获取当前版本信息
 @discussion 获取当前版本信息
 @param 无
 @result ver
 */
+ (double)getVersion;

/*!
 @method createUUID
 @abstract 创建uuid
 @discussion 创建uuid
 @param 无
 @result uuid
 */
+(NSString *)createUUID;

/*!
 @method getScreenSize
 @abstract 获取屏幕分辨率
 @discussion 获取屏幕分辨率
 @param 无
 @result size 屏幕分辨率
 */
+(int)getScreenSize;
//下方为业务方法

/*!
 @method initUserData
 @abstract 初始化用户信息
 @discussion 初始化用户信息
 @param 无
 @result 无
 */
-(void)initUserData;

/*!
 @method logout
 @abstract 登出，重置账号信息
 @discussion 登出，重置账号信息
 @param 无
 @result 无
 */
-(void)logout;

/*!
 @method login:(NSString *)userKeyID account:(NSString*)account password:(NSString*)password type:(int)type safe_pwd:(NSString *)safe_pwd flag:(int)flag lon:(NSString *)lon lat:(NSString *)lat lastreqtime:(NSString *)lastreqtime vin:(NSString *)vin userID:(NSString *)userID
 @abstract 登录后将登录信息存储到本地数据库
 @discussion 登录后将登录信息存储到本地数据库
 @param userData
 @result 无
 */
- (void)login:(NSString *)userKeyID
      account:(NSString*)account
     password:(NSString*)password
         type:(int)type
     safe_pwd:(NSString *)safe_pwd
         flag:(int)flag
          lon:(NSString *)lon
          lat:(NSString *)lat
  lastreqtime:(NSString *)lastreqtime
          vin:(NSString *)vin
       userID:(NSString *)userID;

/*!
 @method updateIsFirstLogin
 @abstract 更新是否同步车友
 @discussion 更新是否同步车友
 @param 无
 @result 无
 */
-(void)updateIsFirstLogin;

/*!
 @method updateLocation:(NSString *)lon lat:(NSString *)lat
 @abstract 更新位置信息
 @discussion 更新位置信息
 @param 无
 @result 无
 */
-(void)updateLocation:(NSString *)lon
                  lat:(NSString *)lat;

/*!
 @method updateLastReqTime:(NSString *)userID lastreqtime:(NSString *)lastreqtime
 @abstract 更新用户的最后请求时间
 @discussion 更新用户的最后请求时间
 @param 无
 @result 无
 */
-(void)updateLastReqTime:(NSString *)userID
             lastreqtime:(NSString *)lastreqtime;

/*!
 @method updateVinWithUserID:(NSString *)userID vin:(NSString *)vin
 @abstract 更新用户选择车辆的vin
 @discussion 更新用户选择车辆的vin
 @param 无
 @result 无
 */
-(void)updateVinWithUserID:(NSString *)userID
                       vin:(NSString *)vin;

/*!
 @method getPassword:(NSString *)userID
 @abstract 获取密码
 @discussion 获取密码
 @param userID 用户id
 @result pwd 密码
 */
- (NSString *)getPassword:(NSString *)userID;

/*!
 @method getIsFirstLogin
 @abstract 获取是否为首次进入车友
 @discussion 获取是否为首次进入车友
 @param 无
 @result 是否首次进入车友标记
 */
- (int)getIsFirstLogin;

/*!
 @method getUserData
 @abstract 获取账户数据
 @discussion 获取账户数据
 @param 无
 @result UserData 账户数据
 */
-(UserData *)getUserData;

/*!
 @method initCarData
 @abstract 初始化车辆信息
 @discussion 初始化车辆信息
 @param 无
 @result 无
 */
- (void)initCarData;

/*!
 @method updateCarData:(NSString*)keyID carID:(NSString*)carID vin:(NSString*)vin type:(NSString*)type name:(NSString*)name carRegisCode:(NSString*)carRegisCode carNumber:(NSString*)carNumber motorCode:(NSString*)motorCode userID:(NSString*)userID sim:(NSString*)sim lon:(NSString *)lon lat:(NSString *)lat lastRpTime:(NSString *)lastRpTime
 @abstract 更新或添加车辆信息
 @discussion 更新或添加车辆信息
 @param carData
 @result 无
 */
- (void)updateCarData:(NSString*)keyID
                carID:(NSString*)carID
                  vin:(NSString*)vin
                 type:(NSString*)type
                 name:(NSString*)name
         carRegisCode:(NSString*)carRegisCode
            carNumber:(NSString*)carNumber
            motorCode:(NSString*)motorCode
               userID:(NSString*)userID
                  sim:(NSString*)sim
                  lon:(NSString *)lon
                  lat:(NSString *)lat
           lastRpTime:(NSString *)lastRpTime
           service:(NSString *)service;

/*!
 @method updateCarLocation:(NSString *)lon lat:(NSString *)lat lastRpTime:(NSString *)lastRpTime
 @abstract 更新车辆位置和时间
 @discussion 更新车辆位置和时间
 @param lon 经度
 @param lat 纬度
 @param lastRpTime 车辆最后位置
 @result 无
 */
-(void)updateCarLocation:(NSString *)lon
                     lat:(NSString *)lat
              lastRpTime:(NSString *)lastRpTime;

/*!
 @method getCarData
 @abstract 获取当前选中车辆信息
 @discussion 获取当前选中车辆信息
 @param 无
 @result carData 车辆信息
 */
-(CarData *)getCarData;

/*!
 @method loadCarData
 @abstract 加载车辆信息
 @discussion 加载车辆信息
 @param 无
 @result 无
 */
- (void)loadCarData;

/*!
 @method existCarDataWithCarVin:(NSString *)carVin
 @abstract 根据vin判断车辆是否存在
 @discussion 根据vin判断车辆是否存在
 @param carVin 车架号
 @result bool
 */
- (BOOL)existCarDataWithCarVin:(NSString *)carVin;

/*!
 @method deleteCarWithUserID:(NSString *)userID
 @abstract 删除当前账户下的车辆信息
 @discussion 删除当前账户下的车辆信息
 @param userID 用户id
 @result 无
 */
-(void)deleteCarWithUserID:(NSString *)userID;

/*!
 @method deleteCarWithUserID:(NSString *)userID
 @abstract 获取当前账户下的车辆信息
 @discussion 获取当前账户下的车辆信息
 @param userID 用户id
 @result carlist 车辆列表
 */
- (NSMutableArray*)loadCarDataWithUserID:(NSString *)userID;
//friendData
/*!
 @method updateFriendData:(NSString*)fKeyID fid:(NSString *)fID fname:(NSString*)fName fphone:(NSString*)fPhone flon:(NSString *)flon flat:(NSString *)flat fLastRqTime:(NSString *)fLastRqTime fLastUpdate:(NSString*)fLastUpdate sendLocationRqTime:(NSString*)sendLocationRqTime createTime:(NSString *)createTime friendUserID:(NSString *)friendUserID poiName:(NSString *)poiName poiAddress:(NSString *)poiAddress pinyin:(NSString*)pinyin
 @abstract 更新或添加车友信息
 @discussion 更新或添加车友信息
 @param friendData 车友信息
 @result 无
 */
- (void)updateFriendData:(NSString*)fKeyID
                     fid:(NSString *)fID
                   fname:(NSString*)fName
                  fphone:(NSString*)fPhone
                    flon:(NSString *)flon
                    flat:(NSString *)flat
             fLastRqTime:(NSString *)fLastRqTime
             fLastUpdate:(NSString*)fLastUpdate
      sendLocationRqTime:(NSString*)sendLocationRqTime
              createTime:(NSString *)createTime
            friendUserID:(NSString *)friendUserID
                 poiName:(NSString *)poiName
              poiAddress:(NSString *)poiAddress
                  pinyin:(NSString*)pinyin;

/*!
 @method deleteFriendWithPhone:(NSString *)phone
 @abstract 根据电话号码和用户id删除车友信息
 @discussion 根据电话号码和用户id删除车友信息
 @param phone 电话
 @result 无
 */
-(void)deleteFriendWithPhone:(NSString *)phone;

/*!
 @method addFriendDataWithSqls:(NSMutableArray *)sql
 @abstract 通过sql添加车友
 @discussion 通过sql添加车友
 @param sql sqllist
 @result 无
 */
- (void)addFriendDataWithSqls:(NSMutableArray *)sql;


/*!
 @method getFriendName:(NSString *)fID
 @abstract 通过车友id，获取车友名字
 @discussion 通过车友id，获取车友名字
 @param fID 车友id
 @result name
 */
- (NSString *)getFriendName:(NSString *)fID;

/*!
 @method getFriendNameWithPhone:(NSString *)phone
 @abstract 通过车友电话，获取车友名字
 @discussion 通过车友电话，获取车友名字
 @param phone 车友电话
 @result name
 */
- (NSString *)getFriendNameWithPhone:(NSString *)phone;

/*!
 @method updateFriendLocation:(NSString *)fID flon:(NSString *)flon flat:(NSString *)flat lastRqTime:(NSString *)lastRqTime  poiName:(NSString *)poiName  poiAddress:(NSString *)poiAddress
 @abstract 通过车友id，更新车友位置
 @discussion 通过车友id，更新车友位置
 @param fID 车友id
 @param flon 经度
 @param flat 纬度
 @param lastRqTime 最后时间
 @result 无
 */
- (void)updateFriendLocation:(NSString *)fID
                        flon:(NSString *)flon
                        flat:(NSString *)flat
                  lastRqTime:(NSString *)lastRqTime
                     poiName:(NSString *)poiName
                  poiAddress:(NSString *)poiAddress;



/*!
 @method updateFriendDataWithID:(NSString *)fID mobile:(NSString *)mobile name:(NSString *)name createTime:(NSString *)createTime lastUpdate:(NSString *)lastUpdate pinyin:(NSString *)pinyin
 @abstract 更新车友名字
 @discussion 更新车友名字
 @param fID 车友id
 @param fName 名字
 @result 无
 */
- (void)updateFriendDataWithID:(NSString *)fID
                        mobile:(NSString *)mobile
                          name:(NSString *)name
                    createTime:(NSString *)createTime
                    lastUpdate:(NSString *)lastUpdate
                        pinyin:(NSString *)pinyin
;

/*!
 @method getFriendData:(NSString *)fID
 @abstract 获取车友信息
 @discussion 获取车友信息
 @param fID 车友id
 @result FriendData 车友信息
 */
- (FriendsData *)getFriendData:(NSString *)fID;

/*!
 @method getRqTimeWithFID:(NSString *)fID
 @abstract 获取请求时间
 @discussion 获取请求时间
 @param fID 车友id
 @result time
 */
- (NSString *)getRqTimeWithFID:(NSString *)fID;

/*!
 @method updateFriendRqTimeWithFID:(NSString *)fID rqTime:(NSString *)rqTime
 @abstract 修改请求时间
 @discussion 修改请求时间
 @param fID 车友id
 @param rqTime 请求时间
 @result 无
 */
- (void)updateFriendRqTimeWithFID:(NSString *)fID
                           rqTime:(NSString *)rqTime;

/*!
 @method deleteFriendData:(NSString *)fID
 @abstract 删除车友信息
 @discussion 删除车友信息
 @param fID 车友id
 @result 无
 */
- (void)deleteFriendData:(NSString *)fID;

/*!
 @method deleteMutiFriendsData:(NSArray *)fIDs
 @abstract 删除多条车友信息
 @discussion 删除多条车友信息
 @param fIDs 车友id列表
 @result 无
 */
- (void)deleteMutiFriendsData:(NSArray *)fIDs;

/*!
 @method deleteAllFriend
 @abstract 删除当前账户所有车友信息
 @discussion 删除当前账户所有车友信息
 @param 无
 @result 无
 */
-(void)deleteAllFriend;


/*!
 @method loadMeetRequestFriendData
 @abstract 加载车友信息
 @discussion 加载车友信息
 @param 无
 @result friendList 车友列表
 */
- (NSMutableArray*)loadMeetRequestFriendData;

/*!
 @method initmfriendData
 @abstract 初始化mfriendData，及创建表
 @discussion 初始化mfriendData，及创建表
 @param 无
 @result 无
 */
- (void)initmfriendData;

/*!
 @method loadFriendUserIDWithPhoneList:(NSArray *)phoneList
 @abstract 通过手机号list获取车友userid
 @discussion 通过手机号list获取车友userid
 @param phoneList 电话列表
 @result NSMutableDictionary 电话为key userid 为value
 */
-(NSMutableDictionary *)loadFriendUserIDWithPhoneList:(NSArray *)phoneList;

/*!
 @method loadFriendNameWithFriendUserID:(NSMutableArray *)friendUserIDList
 @abstract 通过车友用户id获取车友名字
 @discussion 通过车友用户id获取车友名字
 @param friendUserIDList 车友用户idList
 @result NSMutableDictionary KEY UserIDList value friendName
 */
-(NSMutableDictionary *)loadFriendNameWithFriendUserID:(NSMutableArray *)friendUserIDList;


/*!
 @method friendExistWhitPhone:
 @abstract 查找车友表中是否存在所属用户为fUserID电话为phone的车友
 @discussion 查找车友表中是否存在所属用户为fUserID电话为phone的车友
 @param fUserID 所属用户id
 @param phone 电话
 @result bool
 */
- (BOOL)friendExistWhitPhone:(NSString *)phone;

//blackData
/*!
 @method initBlackData
 @abstract 初始化黑名单，包括建表
 @discussion 初始化黑名单，包括建表
 @param 无
 @result 无
 */
- (void)initBlackData;

/*!
 @method updateBlackDataWithKeyID:(NSString*)KeyID ID:(NSString*)ID name:(NSString*)name mobile:(NSString *)mobile lastUpdate:(NSString *)lastUpdate
 createTime:(NSString *)createTime pinyin:(NSString *)pinyin
 @abstract 添加或修改黑名单
 @discussion 添加或修改黑名单
 @param BlackData 黑名单数据
 @result 无
 */
- (void)updateBlackDataWithKeyID:(NSString*)KeyID
                              ID:(NSString*)ID
                            name:(NSString*)name
                          mobile:(NSString *)mobile
                      lastUpdate:(NSString *)lastUpdate
                      createTime:(NSString *)createTime
                          pinyin:(NSString *)pinyin;

/*!
 @method deleteBlackDataWithMobile:(NSString*)mobile
 @abstract 根据电话和用户id删除黑名单
 @discussion 根据电话和用户id删除黑名单
 @param mobile 电话
 @result 无
 */
- (void)deleteBlackDataWithMobile:(NSString*)mobile;

/*!
 @method deleteAllBlackData
 @abstract 删除当前用户下所有黑名单
 @discussion 删除当前用户下所有黑名单
 @param 无
 @result 无
 */
- (void)deleteAllBlackData;

/*!
 @method addBlackDataWithSqls:(NSMutableArray *)sql
 @abstract 通过sql语句添加黑名单
 @discussion 通过sql语句添加黑名单
 @param sql sqllist
 @result 无
 */
- (void)addBlackDataWithSqls:(NSMutableArray *)sql;

/*!
 @method deleteBlackDataWithIDs:(NSArray *)IDs
 @abstract 根据ids删除黑名单
 @discussion 根据ids删除黑名单
 @param IDs idlist
 @result 无
 */
- (void)deleteBlackDataWithIDs:(NSArray *)IDs;

/*!
 @method loadBlackData
 @abstract 加载黑名单列表
 @discussion 加载黑名单列表
 @param 无
 @result balckList 黑名单列表
 */
- (NSMutableArray*)loadBlackData;

/*!
 @method blackExist:
 @abstract 根据mobile，userKeyID判断黑名单是否在数据库表中存在
 @discussion 根据mobile，userKeyID判断黑名单是否在数据库表中存在
 @param userKeyID　黑名单所属用户ｉｄ
 @param database　数据库
 @param mobile　电话号码
 @result BOOL
 */
- (BOOL)blackExist:(NSString *)mobile;

//messageInfo

/*!
 @method deleteMessageWithType:(enum CLEAR_TYPE)type
 @abstract 通过消息类型删除消息
 @discussion 通过消息类型删除消息
 @param type 类型
 @result bool
 */
- (BOOL)deleteMessageWithType:(enum CLEAR_TYPE)type;


/*!
 @method deleteMessageWithTypes:(NSMutableArray *)types
 @abstract 通过消息类型删除几种消息
 @discussion 通过消息类型删除几种消息
 @param type 类型数组
 @result bool
 */
- (BOOL)deleteMessageWithTypes:(NSMutableArray *)types;

/*!
 @method initMessageInfoDatabase
 @abstract 初始化消息主表
 @discussion 初始化消息主表
 @param 无
 @result 无
 */
- (void)initMessageInfoDatabase;


/*!
 @method deleteMessageInfo:(NSString *)ID
 @abstract 根据消息id删除消息主表中数据
 @discussion 根据消息id删除消息主表中数据
 @param ID 消息id
 @result 无
 */
- (void)deleteMessageInfo:(NSString *)ID;

/*!
 @method deleteMessageInfoWithIDs:(NSString *)ID
 @abstract 根据id删除多条消息
 @discussion 根据id删除多条消息
 @param ID 消息ids
 @result 无
 */
- (void)deleteMessageInfoWithIDs:(NSString *)ID;

/*!
 @method loadMessageTypeData:(char)type status:(char)status userID:(NSString *)userID
 @abstract 根据类型，状态，用户id，获取消息
 @discussion 根据类型，状态，用户id，获取消息
 @param type 类型 
 @param status 状态
 @param userID 用户id
 @result messagelist 消息列表
 */
- (NSMutableArray*)loadMessageTypeData:(char)type status:(char)status userID:(NSString *)userID;


/*!
 @method loadMessageInfoData:(char)status userID:(NSString *)userID
 @abstract 根据类型，状态，用户id，获取消息主表中数据
 @discussion 根据类型，状态，用户id，获取消息主表中数据
 @param type 类型
 @param status 状态
 @param userID 用户id
 @result messagelist 消息列表
 */
- (NSMutableArray*)loadMessageInfoData:(char)status userID:(NSString *)userID;


/*!
 @method deleteAllMessage
 @abstract 删除所有消息
 @discussion 删除所有消息
 @param 无
 @result 无
 */
- (void)deleteAllMessage;

/*!
 @method loadMessageCountWithType:(enum MESSAGE_TYPE)type
 @abstract 获取某类消息未读数量
 @discussion 获取某类消息未读数量
 @param 无
 @result count
 */
- (int)loadMessageCountWithType:(enum MESSAGE_TYPE)type;



/*!
 @method setMessageAsReaded:(NSString *)KeyID
 @abstract 将消息置为已读状态
 @discussion 将消息置为已读状态
 @param KeyID 消息id
 @result 无
 */
- (void)setMessageAsReaded:(NSString *)KeyID;


/*!
 @method getMessageStatus:(NSString *)KeyID
 @abstract 获取消息状态
 @discussion 获取消息状态
 @param KeyID 消息id
 @result Status 消息状态
 */
- (int)getMessageStatus:(NSString *)KeyID;


/*!
 @method getCreateTime:(NSString *)KeyID
 @abstract 获取消息创建时间
 @discussion 获取消息创建时间
 @param KeyID 消息id
 @result time
 */
- (NSString *)getCreateTime:(NSString *)KeyID;


/*!
 @method addMessageWithSqls:(NSMutableArray *)sqls
 @abstract 传入sql语句插入多条消息，在messageInfoData中进行
 @discussion 传入sql语句插入多条消息，在messageInfoData中进行
 @param sqls sql语句
 @result 无
 */
- (void)addMessageWithSqls:(NSMutableArray *)sqls;

/*!
 @method getNewVehicleDiagnosisReportId
 @abstract 根据userid,vin获取最新的reportid
 @discussion 根据userid,vin获取最新的reportid
 @param 无
 @result ReportId 诊断id
 */
- (NSString *)getNewVehicleDiagnosisReportId;



/*!
 @method searchCarLicense:(NSString*)messageKeyID
 @abstract 根据消息id获取车牌号
 @discussion 根据消息id获取车牌号
 @param messageKeyID 消息id
 @result carLicense
 */
- (NSString *)searchCarNum:(NSString *)messageKeyID;

//位置请求通知

/*!
 @method initFriendLocationMessageDatabase
 @abstract 初始化位置请求表
 @discussion 初始化位置请求表
 @param 无
 @result 无
 */
- (void)initFriendLocationMessageDatabase;

/*!
 @method initFriendLocationMessageDatabase
 @abstract 修改请求应答状态及时间
 @discussion 修改请求应答状态及时间
 @param MESSAGE_KEYID 消息id
 @param state 应答状态
 @param rpTime 应答时间
 @result 无
 */
- (void)updateFriendLocationMessageRpState:(NSString *)MESSAGE_KEYID state:(int)state rpTime:(NSString *)rpTime;

/*!
 @method deleteFriendLocationMessage:(NSString *)messageID
 @abstract 删除位置请求消息
 @discussion 删除位置请求消息
 @param messageID 消息id
 @result 无
 */
- (void)deleteFriendLocationMessage:(NSString *)messageID;

/*!
 @method deleteFriendLocationMessage:(NSString *)messageID
 @abstract 根据id删除多个消息
 @discussion 根据id删除多个消息
 @param MESSAGE_KEYID 多条消息id
 @result 无
 */
- (void)deleteFriendLocationMessageWithIDs:(NSString *)MESSAGE_KEYID;

/*!
 @method deleteDemoFriendLocationMessage
 @abstract 删除demo的位置请求消息
 @discussion 删除demo的位置请求消息
 @param 无
 @result 无
 */
- (void)deleteDemoFriendLocationMessage;

/*!
 @method loadMeetRequestFriendLocationMessage:(NSString *)messageID
 @abstract 加载位置请求消息
 @discussion 加载位置请求消息
 @param messageID 消息id
 @result FriendLocationData 消息数据
 */
- (FriendLocationData *)loadMeetRequestFriendLocationMessage:(NSString *)messageID;

/*!
 @method loadAllMeetRequestFriendLocationMessage
 @abstract 加载位置请求消息
 @discussion 加载位置请求消息
 @param 无
 @result messagelist 消息列表
 */
- (NSMutableArray *)loadAllMeetRequestFriendLocationMessage;


//SendtoCarMessage
/*!
 @method initSendToCarMessageDatabase
 @abstract 初始化发送到车数据库表
 @discussion 初始化发送到车数据库表
 @param 无
 @result 无
 */
- (void)initSendToCarMessageDatabase;

/*!
 @method deleteDemoSendToCarMessage
 @abstract 删除demo的发送到车消息
 @discussion 删除demo的发送到车消息
 @param 无
 @result 无
 */
- (void)deleteDemoSendToCarMessage;


/*!
 @method loadMeetRequestSendToCarMessage:(NSString *)MESSAGE_KEYID
 @abstract 加载发送到车消息
 @discussion 加载发送到车消息
 @param MESSAGE_KEYID 消息id
 @result SendToCarMessageData 消息数据
 */
- (SendToCarMessageData *)loadMeetRequestSendToCarMessage:(NSString *)MESSAGE_KEYID;

/*!
 @method loadAllMeetRequestSendToCarMessage
 @abstract 加载当前账户下发送到车消息
 @discussion 加载当前账户下发送到车消息
 @param 无
 @result messageList 发送到车列表
 */
- (NSMutableArray *)loadAllMeetRequestSendToCarMessage;

/*!
 @method deleteSendToCarMessage:(NSString *)MESSAGE_KEYID
 @abstract 删除发送到车消息
 @discussion  删除发送到车消息
 @param MESSAGE_KEYID 消息id
 @result 无
 */
- (void)deleteSendToCarMessage:(NSString *)MESSAGE_KEYID;

/*!
 @method deleteSendToCarMessage:(NSString *)MESSAGE_KEYID
 @abstract 根据id删除多个消息
 @discussion  根据id删除多个消息
 @param MESSAGE_KEYID 消息ids
 @result 无
 */
- (void)deleteSendToCarMessageWithIDs:(NSString *)MESSAGE_KEYID;
//FriendRequestLocation(车友位置消息)

/*!
 @method initFriendRequestLocationMessageDatabase
 @abstract 初始化车友网位置表
 @discussion  初始化车友网位置表
 @param 无
 @result 无
 */
- (void)initFriendRequestLocationMessageDatabase;

/*!
 @method deleteFriendRequestLocationMessage:(NSString *)MESSAGE_KEYID
 @abstract 删除车友位置消息
 @discussion 删除车友位置消息
 @param MESSAGE_KEYID 消息id
 @result 无
 */
- (void)deleteFriendRequestLocationMessage:(NSString *)MESSAGE_KEYID;

/*!
 @method deleteFriendRequestLocationMessageWithIDs:(NSString *)MESSAGE_KEYID
 @abstract 根据id删除多个消息
 @discussion 根据id删除多个消息
 @param MESSAGE_KEYID 消息ids
 @result 无
 */
- (void)deleteFriendRequestLocationMessageWithIDs:(NSString *)MESSAGE_KEYID;


/*!
 @method deleteDemoFriendRequestLocationMessage
 @abstract 删除demo车友位置消息
 @discussion 删除demo车友位置消息
 @param 无
 @result 无
 */
- (void)deleteDemoFriendRequestLocationMessage;

/*!
 @method loadMeetRequestFriendRequestLocationMessage:(NSString *)MESSAGE_KEYID
 @abstract 加载车友位置消息
 @discussion 加载车友位置消息
 @param MESSAGE_KEYID 消息id
 @result MessageData 消息数据
 */
- (FriendRequestLocationMessageData *)loadMeetRequestFriendRequestLocationMessage:(NSString *)MESSAGE_KEYID;


/*!
 @method loadAllMeetRequestFriendRequestLocationMessage
 @abstract 加载车友位置消息
 @discussion 加载车友位置消息
 @param 无
 @result MessageList 消息列表
 */
- (NSMutableArray *)loadAllMeetRequestFriendRequestLocationMessage;
//system message

/*!
 @method initSystemMessageDatabase
 @abstract 初始化系统消息表
 @discussion 初始化系统消息表
 @param 无
 @result 无
 */
- (void)initSystemMessageDatabase;


/*!
 @method updateSystemMessage:(NSString *)keyID sendDate:(NSString *)sendDate content:(NSString *)content messageID:(NSString *)messageID
 @abstract 更新或添加系统消息
 @discussion 更新或添加系统消息
 @param message 系统消息
 @result 无
 */
- (void)updateSystemMessage:(NSString *)keyID
                   sendDate:(NSString *)sendDate
                    content:(NSString *)content
                  messageID:(NSString *)messageID;

/*!
 @method deleteSystemMessage:(NSString *)messageID
 @abstract 删除系统消息
 @discussion 删除系统消息
 @param messageID 系统消息id
 @result 无
 */
- (void)deleteSystemMessage:(NSString *)messageID;

/*!
 @method loadAllMeetRequestSystemMessage
 @abstract 获取系统消息列表
 @discussion 获取系统消息列表
 @param 无
 @result messageList
 */
- (NSMutableArray *)loadAllMeetRequestSystemMessage;

//searchHistory
/*!
 @method initSearchHistoryDatabase
 @abstract 初始化搜索历史表
 @discussion 初始化搜索历史表
 @param 无
 @result 无
 */
- (void)initSearchHistoryDatabase;

/*!
 @method addSearchHistory:(NSString *)keyID searchName:(NSString *)searchName createTime:(NSString *)createTime
 @abstract 添加搜索历史
 @discussion 添加搜索历史
 @param keyID id
 @param searchName 搜索关键字
 @param createTime 创建时间
 @result 无
 */
-(void)addSearchHistory:(NSString *)keyID
             searchName:(NSString *)searchName
             createTime:(NSString *)createTime;

/*!
 @method deleteSearchHistory
 @abstract 删除搜索历史
 @discussion 删除搜索历史
 @param 无
 @result bool
 */
- (BOOL)deleteSearchHistory;


/*!
 @method loadMeetRequestSearchHistory
 @abstract 加载搜索历史
 @discussion 加载搜索历史
 @param 无
 @result HistoryList 历史列表
 */
- (NSMutableArray*)loadMeetRequestSearchHistory;


/*!
 @method loadMeetRequestSearchHistoryWithText:(NSString *)searchText
 @abstract 根据关键字加载搜索历史
 @discussion 根据关键字加载搜索历史
 @param 无
 @result HistoryList 历史列表
 */
- (NSMutableArray*)loadMeetRequestSearchHistoryWithText:(NSString *)searchText;
//poi

/*!
 @method initPOIDatabase
 @abstract 初始化poi表
 @discussion 初始化poi表
 @param 无
 @result 无
 */
- (void)initPOIDatabase;


/*!
 @method addPOIData:(NSString *)keyID fID:(NSString *)fID ID:(NSString *)ID
 name:(NSString *)name createTime:(NSString *)createTime lon:(NSString *)lon
 lat:(NSString *)lat phone:(NSString *)phone address:(NSString *)address
 desc:(NSString *)desc flag:(int)flag level:(int)level postCode:(NSString *)postCode
 @abstract 添加poi信息
 @discussion 添加poi信息
 @param poidata poi信息
 @result 无
 */
- (void)addPOIData:(NSString *)keyID
               fID:(NSString *)fID
                ID:(NSString *)ID
              name:(NSString *)name
        createTime:(NSString *)createTime
               lon:(NSString *)lon
               lat:(NSString *)lat
             phone:(NSString *)phone
           address:(NSString *)address
              desc:(NSString *)desc
              flag:(int)flag
             level:(int)level
          postCode:(NSString *)postCode;


/*!
 @method updatePOIData:(NSString *)keyID fID:(NSString *)fID ID:(NSString *)ID
 name:(NSString *)name createTime:(NSString *)createTime lon:(NSString *)lon
 lat:(NSString *)lat phone:(NSString *)phone address:(NSString *)address
 desc:(NSString *)desc flag:(int)flag level:(int)level postCode:(NSString *)postCode
 @abstract 修改poi信息
 @discussion 修改poi信息
 @param poidata poi信息
 @result 无
 */
- (void)updatePOIData:(NSString *)keyID
                  fID:(NSString *)fID
                   ID:(NSString *)ID
                 name:(NSString *)name
           createTime:(NSString *)createTime
                  lon:(NSString *)lon
                  lat:(NSString *)lat
                phone:(NSString *)phone
              address:(NSString *)address
                 desc:(NSString *)desc
                 flag:(int)flag
                level:(int)level
             postCode:(NSString *)postCode;


/*!
 @method updateFlag:(NSString *)lon lat:(NSString *)lat flag:(int)flag
 ID:(NSString *)ID fID:(NSString *)fID
 @abstract 修改poi状态
 @discussion 修改poi状态
 @param lon 经度
 @param lat 纬度
 @param flag 状态
 @param id poiid
 @param fid 收藏id
 @result 无
 */
- (void)updateFlag:(NSString *)lon
               lat:(NSString *)lat
              flag:(int)flag
                ID:(NSString *)ID
               fID:(NSString *)fID;

/*!
 @method updateFlag:(int)flag IDs:(NSMutableArray *)IDs
 @abstract 根据userID，ID更新poi状态
 @discussion 根据userID，ID更新poi状态
 @param userID 所属用户id
 @param ID poiid
 @param flag 状态
 @result 无
 */
- (void)updateFlag:(int)flag
               IDs:(NSMutableArray *)IDs;

/*!
 @method updatePOINameAndFlag:(NSString *)name flag:(int)flag ID:(NSString *)ID fID:(NSString *)fID createTime:(NSString *)createTime
 @abstract 根据userID，ID，fID更新poi状态
 @discussion 根据userID，ID，fID更新poi状态
 @param ID poiid
 @param fID 收藏id
 @param flag 状态
 @param name poiname
 @result 无
 */
- (void)updatePOINameAndFlag:(NSString *)name
                        flag:(int)flag
                          ID:(NSString *)ID
                         fID:(NSString *)fID
                  createTime:(NSString *)createTime;


/*!
 @method deleteAllPOIData
 @abstract 删除当前账户下所有poi信息
 @discussion 删除当前账户下所有poi信息
 @param 无
 @result 无
 */
- (void)deleteAllPOIData;

/*!
 @method deleteSycnPOIData
 @abstract 删除当前账户下所有已同步的poi信息
 @discussion 删除当前账户下所有已同步的poi信息
 @param 无
 @result 无
 */
- (void)deleteSycnPOIData;


/*!
 @method deletePOIData:(NSString *)lon lat:(NSString *)lat ID:(NSString *)ID fID:(NSString *)fID
 @abstract 删除poi信息
 @discussion 删除poi信息
 @param lon 经度
 @param lat 纬度
 @param id poiid
 @param fid 收藏id
 @result 无
 */
- (void)deletePOIData:(NSString *)lon
                  lat:(NSString *)lat
                   ID:(NSString *)ID
                  fID:(NSString *)fID;



/*!
 @method poiExist:(NSString *)lon lat:(NSString *)lat ID:(NSString *)ID fID:(NSString *)fID type:(int)type
 @abstract 判断poi是否已存在
 @discussion 判断poi是否已存在
 @param lon 经度
 @param lat 纬度
 @param id poiid
 @param fid 收藏id
 @param type 类型
 @result bool
 */
- (BOOL)poiExist:(NSString *)lon lat:(NSString *)lat ID:(NSString *)ID fID:(NSString *)fID type:(int)type;


/*!
 @method loadMeetRequestCollectTableData
 @abstract 获取收藏夹列表要显示的数据
 @discussion 获取收藏夹列表要显示的数据
 @param 无
 @result poiList poi列表
 */
- (NSMutableArray*)loadMeetRequestCollectTableData;

/*!
 @method loadMeetRequestPOIDataSyncYES
 @abstract 获取已同步的poi列表
 @discussion 获取已同步的poi列表
 @param 无
 @result poiList poi列表
 */
- (NSMutableArray*)loadMeetRequestPOIDataSyncYES;

/*!
 @method loadMeetRequestPOIDataSyncNO
 @abstract 获取未同步的poi列表
 @discussion 获取未同步的poi列表
 @param 无
 @result poiList poi列表
 */
- (NSMutableArray*)loadMeetRequestPOIDataSyncNO;

/*!
 @method loadMeetRequestPOIDataSyncAdd
 @abstract 获取添加未同步的列表
 @discussion 获取添加未同步的列表
 @param 无
 @result poiList poi列表
 */
- (NSMutableArray*)loadMeetRequestPOIDataSyncAdd;


/*!
 @method loadMeetRequestPOIData:(NSString *)lon lat:(NSString *)lat
 @abstract 加载poi信息
 @discussion 加载poi信息
 @param lon 经度
 @param lat 纬度
 @result POIData poi信息
 */
- (POIData*)loadMeetRequestPOIData:(NSString *)lon lat:(NSString *)lat;

/*!
 @method loadPoi:(NSString *)lon lat:(NSString *)lat ID:(NSString *)ID fID:(NSString *)fID type:(int)type
 @abstract 根据不同类型的poi信息，通过不同的sql语句，判断该poi是否已经收藏
 @discussion 根据不同类型的poi信息，通过不同的sql语句，判断该poi是否已经收藏
 @param userID 所属用户id
 @param ID poiid
 @param fID 收藏id
 @param lon 经度暂时无用
 @param lat 纬度暂时无用
 @param type poi类型（手机位置、车机位置、自定义位置、收藏夹poi、搜索poi）
 @result POIData
 */
- (POIData*)loadPoi:(NSString *)lon lat:(NSString *)lat ID:(NSString *)ID fID:(NSString *)fID type:(int)type;

/*!
 @method deletePOIDataWithFID:(NSString *)fID
 @abstract 一次性删除多个poi信息 以及修改标识flag
 @discussion 一次性删除多个poi信息 以及修改标识flag
 @param fID poiid
 @result 无
 */
- (void)deletePOIDataWithFID:(NSString *)fID;

/*!
 @method addPOIDataWithSqls:(NSMutableArray *)sqls
 @abstract 传入sql语句插入poi信息
 @discussion 传入sql语句插入poi信息
 @param sqls sqllist
 @result 无
 */
- (void)addPOIDataWithSqls:(NSMutableArray *)sqls;

/*!
 @method loadDemoData
 @abstract 载入DEMO数据
 @discussion 载入DEMO数据
 @param 无
 @result 无
 */
- (void)loadDemoData;

/*!
 @method loadDemoUserData
 @abstract 载入DEMO账户数据
 @discussion 载入DEMO账户数据
 @param 无
 @result 无
 */
- (void)loadDemoUserData;

/*!
 @method clearHistoryData:
 @abstract 清除历史数据
 @discussion 清除历史数据
 @param 无
 @result 无
 */
-(BOOL)clearHistoryData:(NSMutableArray *)array;


/*!
 @method initDatabase
 @abstract 初始化数据库
 @discussion 初始化数据库
 @param 无
 @result 无
 */
-(void)initDatabase;
/*!
 @method initCarSetPara
 @abstract 初始化车辆控制参数
 @discussion 初始化车辆控制参数
 @param 无
 @result 无
 */
- (void)initCarSetPara;
//- (void)initElecFenceData;
@end
