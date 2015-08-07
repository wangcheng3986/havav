/*!
 @header ElecFenceDetailViewController.h
 @abstract 电子围栏详情界面
 @author wangqiwei
 @version 1.00 2014/9/1 Create
 */

#import <UIKit/UIKit.h>
#import "ElecFenceQueryNetManagerDelegate.h"
#import "ElecFenceAddNetManagerDelegate.h"
#import "ElecFenceDeleteNetManagerDelegate.h"
#import "ElecFenceModifyNetManagerDelegate.h"
#import "ElecFenceAddNetManager.h"
#import "ElecFenceQueryNetManager.h"
#import "ElecFenceModifyNetManager.h"
#import "MBProgressHUD.h"
#import "ElecFenceData.h"
#import "UIMapBaseViewController.h"
@interface ElecFenceDetailViewController : UIMapBaseViewController<UITextViewDelegate,UITextFieldDelegate, ElecFenceAddNetManagerDelegate,ElecFenceModifyNetManagerDelegate,ElecFenceAddNetManagerDelegate,MBProgressHUDDelegate>
{
    IBOutlet UIView *mMapContext;

    IBOutlet UILabel *MonitorRadius;
    IBOutlet UILabel *effectTitle;
    IBOutlet UILabel *address;

    
    IBOutlet UIButton *selsecButton;
    
    IBOutlet UIButton *selsecNoButton;
    IBOutlet UITextView *adressText;
    
    
    IBOutlet UILabel *_placeHolder;
    
    IBOutlet UILabel *radiusUnit;
    IBOutlet UIButton *carButton;
    ElecFenceAddNetManager *elecFenceAddNetManager;
    ElecFenceModifyNetManager *elecFenceModifyNetManager;
  //  NILocationService * mLocationService;
    
    IBOutlet UITextField *textFieldRadius;
}

@property (retain, nonatomic) NSMutableArray *elecFenceList;
@property (copy,nonatomic)NSString *POIadress;
@property (nonatomic, retain) MBProgressHUD    *progressHUD;

- (void)setElecFenceData:(ElecFenceData *)elecFenceData flag:(int)flag;
@end
