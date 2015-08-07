/*!
 @header CarTabBarViewController.h
 @abstract 爱车的tabbar主控界面
 @author wangqiwei
 @version 1.00 2014/9/1 Create
 */
#import <UIKit/UIKit.h>
#import "TabViewController.h"
#import "VehicleControlViewController.h"
#import "VehicleDiagnosisViewController.h"
#import "VehicleStatusViewController.h"
#import "ElecFenceViewController.h"
#import "EditButton.h"

enum EDIT_STATE
{
    EDIT_STATE = 0,  //编辑
    FINIS_STATE =1,//完成
};
@interface CarTabBarViewController : UITabBarController<UITabBarControllerDelegate,UITabBarDelegate>
{
    VehicleControlViewController *vehicleControl;
    VehicleStatusViewController *vehicleStatus;
    ElecFenceViewController *ElecFence;
    VehicleDiagnosisViewController *vehicleDiagnosis;
    HomeButton *_homeBtn;
    EditButton* _editBt;
    int editState;
}


@end
