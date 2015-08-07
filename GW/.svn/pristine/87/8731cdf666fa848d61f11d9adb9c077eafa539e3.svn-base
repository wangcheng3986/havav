

/*!
 @header VehiclesAbnormalAlarmViewController.h
 @abstract 车辆异常报警消息列表
 @author mengy
 @version 1.00 14-9-3 Creation
 */
#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "NICommonFormatDefine.h"
#import "CherryDBControl.h"
#import "CherryDBControl.h"
#import "VehiclesAbnormalAlarmDetailViewController.h"
#import "MBProgressHUD.h"
@interface VehiclesAbnormalAlarmViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>
{
    IBOutlet UITableView *vehiclesAbnormalAlarmTableView;
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

@property (retain, nonatomic) NSMutableArray *vehiclesAbnormalAlarmMutableArray;
@property (retain, nonatomic) NSMutableArray *deleteMutableArray;
@end
