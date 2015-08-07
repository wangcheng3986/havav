/*!
 @header VehicleStatusViewController.h
 @abstract 车辆监控主控界面
 @author wangqiwei
 @version 1.00 2014/9/1 Create
 */
#import <UIKit/UIKit.h>
#import "vehicleStatusNetManagerDelegate.h"
#import "MBProgressHUD.h"
@interface VehicleStatusViewController : UIViewController<VehicleStatusNetManagerDelegate,MBProgressHUDDelegate>
{
    IBOutlet UILabel *refreshTimeTitle;
    IBOutlet UILabel *refreshTimeTitleNum;
    IBOutlet UILabel *leftFrontTirePressure;
    IBOutlet UILabel *leftRearTirePressure;
    IBOutlet UILabel *rightFrontTirePressure;
    IBOutlet UILabel *rightRearTirePressure;
    IBOutlet UILabel *temperatureInCarTitle;
    IBOutlet UILabel *temperatureInCarNum;
    IBOutlet UILabel *mileageTitle;
    IBOutlet UILabel *mileageNum;
    IBOutlet UILabel *oilWearTitle;
    IBOutlet UILabel *oilWearNum;
    IBOutlet UILabel *oilMassTitle;
    IBOutlet UILabel *oilMassNum;
    IBOutlet UIImageView *speedIconImage;
    IBOutlet UIImageView *oilWearImage;
    IBOutlet UIImageView *oilMassImage;
    IBOutlet UIImageView *speedIconDiviner;
    IBOutlet UIImageView *oilWearImageDiviner;
    IBOutlet UIImageView *oilMassImageDiviner;
    IBOutlet UIImageView *carImage;
    
    IBOutlet UIImageView *leftFrontDoor;
    IBOutlet UIImageView *leftRearDoor;
    IBOutlet UIImageView *rightFrontDoor;
    IBOutlet UIImageView *rightRearDoor;
    
    IBOutlet UIImageView *frontLight;
    IBOutlet UIImageView *rearLight;
    
    
}
@property (nonatomic, retain) MBProgressHUD    *progressHUD;
- (void)sendrequest;
@end
