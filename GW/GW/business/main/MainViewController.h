
/*!
 @header MainViewController.h
 @abstract 主界面类
 @author mengy
 @version 1.00 13-4-15 Creation
 */
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "NILogin.h"
#import "BaseViewController.h"

#import "NIRescue.h"
#import "NILogout.h"
#import "NIOpenUIPRequest.h"
#import "NIGetNotificationsList.h"
#import "NIMessagePoll.h"
#import "BasePageControl.h"
#import "UIUnderLineButton.h"
#import "OpenTSeviceViewController.h"
#import "NISelectCar.h"
#import "NoCopyTextField.h"
#import "ResetPwdViewController.h"
@class MapViewController;
@class NIOpenUIPRequest;
@interface MainViewController : BaseViewController<UIScrollViewDelegate,UIGestureRecognizerDelegate,UIActionSheetDelegate,NILoginDelegate,NIRescueDelegate,NILogoutDelegate,MBProgressHUDDelegate,CLLocationManagerDelegate,NIGetNotificationsListDelegate,UIScrollViewDelegate,UITextFieldDelegate,NISelectCarDelegate>
{
    CLLocationManager *locManager;
    NILogin *mLogin;
    NIRescue *mRescue;
    NILogout *mLogout;
    NISelectCar *mSelectCar;
    IBOutlet UIButton *rescueButton;
    IBOutlet UIButton *friendButton;
    IBOutlet UIButton *mapButton;
    IBOutlet UIButton *messageButton;
    IBOutlet UIButton *setButton;
    IBOutlet UIButton *loveCarButton;
    IBOutlet UILabel *messageCountLabel;
    IBOutlet UIImageView *messageCountImage;
    int messageCount;
    BOOL mOpenSelectCar;
    int selectCar;
    int selectCarCount;
    IBOutlet UIView *mDisView;
    UIView *selectCarView;
    UIImageView *selectCarViewBg;
    BasePageControl *selectCarPageControl;
    UIScrollView *selectCarScrollView;
    IBOutlet UIView *loginView;
    IBOutlet UIImageView *rememberPasswordImageView;
    IBOutlet UILabel *nameLable;
    IBOutlet UILabel *passwordLable;
    IBOutlet UILabel *rememberPasswordLable;
    IBOutlet UITextField *nameTextField;
    IBOutlet NoCopyTextField *passwordTextField;
    IBOutlet UIButton *rememberPasswordButton;
    IBOutlet UIButton *loginButton;
    IBOutlet UIButton *imitationLoginButton;
    IBOutlet UIUnderLineButton *firstLoginBtn;
    IBOutlet UIUnderLineButton *resetPwdBtn;
    IBOutlet UILabel *annotationLable;
    IBOutlet UILabel *annotationLable2;
    IBOutlet UIView *titleView;
    IBOutlet UILabel *titleLabel;
    IBOutlet UIView *functionView;
    LeftButton *leftBtn;
    RightButton *rightBtn;
    IBOutlet UIImageView *mainBg;
    int poiLoad;
//    IBOutlet UIButton *backBtn;
    MapViewController *mapController;
    NSString         *_picUrlString;
    UIImageView      *_imageView;
    MBProgressHUD    *_progressHUD;
    NIMessagePoll *mMessage;
    int urlJump;
    NSMutableArray *carList;
}
@property (nonatomic, copy) NSString           *picUrlString;
@property (nonatomic, retain) IBOutlet         UIImageView *imageView;
@property (nonatomic, retain) MBProgressHUD    *progressHUD;
@property (nonatomic, retain) NIMessagePoll *mMessage;
@property (assign) int poiLoad;

//@property (nonatomic, copy) NSString *urlLon;
//@property (nonatomic, copy) NSString *urlLat;
//@property (nonatomic, copy) NSString *urlTitle;
//@property (nonatomic, copy) NSString *urlAddress;
@property (nonatomic, retain) NSMutableDictionary *urlDic;

@property(assign)int urlJump;

@property(assign)int shouldGoVehicleControl;

/*!
 @method friend
 @abstract 主界面点击车友按钮执行方法，进入车友界面
 @discussion 主界面点击车友按钮执行方法，进入车友界面
 @param sender
 @result 无
 */
-(IBAction)friend:(id)sender;
/*!
 @method goMap
 @abstract 主界面点击地图按钮执行方法，进入地图界面
 @discussion 主界面点击地图按钮执行方法，进入地图界面
 @param sender
 @result 无
 */
-(IBAction)goMap:(id)sender;

/*!
 @method rescue
 @abstract 主界面点击救援按钮执行方法，获取救援电话
 @discussion 主界面点击救援按钮执行方法，获取救援电话
 @param sender
 @result 无
 */
-(IBAction)rescue:(id)sender;
/*!
 @method goMessage
 @abstract 主界面点击消息按钮执行方法，进入消息界面
 @discussion 主界面点击消息按钮执行方法，进入消息界面
 @param sender
 @result 无
 */
-(IBAction)goMessage:(id)sender;

/*!
 @method popself
 @abstract 返回上一页
 @discussion 返回上一页
 @param 无
 @result 无
 */
-(void)popself;

/*!
 @method urlGoMap:(NSString *)URLLon lat:(NSString *)URLLat title:(NSString *)title address:(NSString *)address
 @abstract 点击短信分享链接进入到应用程序，从主界面进入地图界面，将poi点扎在地图上
 @discussion 点击短信分享链接进入到应用程序，从主界面进入地图界面，将poi点扎在地图上
 @param URLLon 经度
 @param URLLat 纬度
 @param title 标题
 @param address 地址
 @result 无
 */
-(void)urlGoMap:(NSString *)URLLon lat:(NSString *)URLLat title:(NSString *)title address:(NSString *)address;

/*!
 @method urlShouldGoMap
 @abstract 判断url是否符合格式标准
 @discussion 判断url是否符合格式标准，若符合调用urlGoMap:(NSString *)URLLon lat:(NSString *)URLLat title:(NSString *)title address:(NSString *)address方法打开地图并扎点
 @param 无
 @result 无
 */
-(void)urlShouldGoMap;

/*!
 @method urlError
 @abstract url错误时调用方法
 @discussion url错误时调用方法，弹出alert
 @param 无
 @result 无
 */
-(void)urlError;

/*!
 @method automaticLogin
 @abstract 重新登录
 @discussion 重新登录，若账号密码有误弹出错误提示
 @param 无
 @result 无
 */
-(void)automaticLogin;

/*!
 @method goVehicleControlVC
 @abstract 跳转至车辆控制界面
 @discussion 跳转至车辆控制界面
 @param 无
 @result 无
 */
-(void)goVehicleControlVC;
@end
