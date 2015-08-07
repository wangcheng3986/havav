/*!
 @header ehicleControlViewController.h
 @abstract 车辆遥控主控界面
 @author wangqiwei
 @version 1.00 2014/9/1 Create
 */
#import <UIKit/UIKit.h>
#import "vehicleControlNetManager.h"
#import "MBProgressHUD.h"
#import <AudioToolbox/AudioToolbox.h> 
#define OPEN_DOORLOCK_CODE @"5"  //开锁
#define TURNOff_DOORLOCK_CODE @"6" //关锁
#define WHISTLE_AND_FLASHING_LIGHT_CODE @"7" //鸣笛闪灯
#define OPEN_ENGINE_CODE @"1" //启动引擎
#define TURNOff_ENGINE_CODE @"2" //关闭引擎
#define OPEN_COOLAIR_CODE @"3" //开启空调
#define TURNOff_COOLAIR_CODE @"4" //关闭空调
#define defaultVaule 0 

#define OPEN_DOORLOCK 5  //开锁
#define TURNOff_DOORLOCK 6 //关锁
#define WHISTLE_AND_FLASHING_LIGHT 7 //鸣笛闪灯
#define OPEN_ENGINES  1//启动引擎
#define TURNOff_ENGINE 2 //关闭引擎
#define OPEN_COOLAIR 3 //开启空调
#define TURNOff_COOLAIR 4 //关闭空调


@interface VehicleControlViewController : UIViewController<UITextFieldDelegate,VehicleControlNetManagerDelegate,UIScrollViewDelegate,MBProgressHUDDelegate>
{
    
    IBOutlet UIButton *EngineSwitch;
    IBOutlet UIButton *whistleAndFlashingLight;
    IBOutlet UIButton *openCoolAir;
    IBOutlet UIButton *turnOffCoolAir;
    IBOutlet UIButton *openDoorLock;
    IBOutlet UIButton *turnOffDoorLock;
    
    IBOutlet UIView *passwordView;
    IBOutlet UITextField *passwordTield;
    IBOutlet UIControl *passwordViewBG;

    IBOutlet UILabel *temperatureInCar;
    

    VehicleControlNetManager *vehicleControlNet;
    
    IBOutlet UIView *carControllView;
    
    IBOutlet UIView *setParaView;

    IBOutlet UILabel *openCoolAirLable;
    IBOutlet UILabel *closeCoolAirLable;
    IBOutlet UILabel *openDoorLable;
    IBOutlet UILabel *closeDoorLable;
    IBOutlet UILabel *currentTemperatureTitle;
    IBOutlet UILabel *temperatureUnit;
    
    IBOutlet UIImageView *animationDoor;
    IBOutlet UIImageView *animationCarBG;
    IBOutlet UIImageView *animationCoolAir;
    IBOutlet UIImageView *animationEngine;
    
    IBOutlet UIImageView *animationWhistleAndFlashingLight;
}
@property (nonatomic, retain) MBProgressHUD    *progressHUD;
void finishPalySoundCallBack(SystemSoundID sound_id,void* user_data);
@end
