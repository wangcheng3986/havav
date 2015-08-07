/*!
 @header SetParameterViewController.h
 @abstract 车辆遥控参数设置界面
 @author wangqiwei
 @version 1.00 2014/9/1 Create
 */

#import <UIKit/UIKit.h>
#define temperatureKey @"temperatureKey"
#define engineTimeKey @"engineTimeKey"
#define coolAirTimeKey @"coolAirTimeKey"
#define demoUser @"demo_vin"
@interface SetParameterViewController : UIViewController
{
    IBOutlet UILabel *openEngineTitle;
    IBOutlet UILabel *engineTime;
    IBOutlet UILabel *openCoolAirTitle;
    IBOutlet UILabel *temperature;
    IBOutlet UILabel *coolAirTime;
    
    IBOutlet UISlider *engineSlider;
    IBOutlet UISlider *temperatureSlider;
    IBOutlet UISlider *coolAirTimeSlider;
    
    IBOutlet UIView *headerView;
    IBOutlet UIView *buttomView;
    IBOutlet UILabel *coolAirTimeTitle;
    IBOutlet UILabel *coolAirTemperatureTitle;
}




@end
