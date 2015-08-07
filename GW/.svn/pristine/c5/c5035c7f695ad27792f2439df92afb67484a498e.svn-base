
/*!
 @header VehicleControlInformViewController.h
 @abstract 车辆控制列表类
 @author mengy
 @version 1.00 14-9-3 Creation
 */
#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "NICommonFormatDefine.h"
#import "VehicleControlInformMessageData.h"
#import "CherryDBControl.h"
#import "App.h"
#import "MBProgressHUD.h"
@interface VehicleControlInformViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>
{
    IBOutlet UITableView *vehicleControlInformTableView;
    IBOutlet UILabel *titleLabel;
    LeftButton *backBtn;
    RightButton *editBtn;
    CherryDBControl *mCherryDBControl;
    NSString         *_picUrlString;
    UIImageView      *_imageView;
    MBProgressHUD    *_progressHUD;
}

@property (nonatomic, copy) NSString           *picUrlString;
@property (nonatomic, retain) IBOutlet         UIImageView *imageView;
@property (nonatomic, retain) MBProgressHUD    *progressHUD;
@property (retain, nonatomic) NSMutableArray *vehicleControlInformMutableArray;
@property (retain, nonatomic) NSMutableArray *deleteMutableArray;
@end
