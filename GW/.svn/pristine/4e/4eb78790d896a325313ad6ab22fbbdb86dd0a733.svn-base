

/*!
 @header VehicleDiagnosisInformViewController.h
 @abstract 车辆故障诊断消息列表
 @author mengy
 @version 1.00 14-9-3 Creation
 */
#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "NICommonFormatDefine.h"
#import "VehicleDiagnosisInformMessageData.h"
#import "CherryDBControl.h"
#import "MBProgressHUD.h"
#import "VehicleDiagnosisInformDetailViewController.h"
@interface VehicleDiagnosisInformViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>
{
    IBOutlet UITableView *vehicleDiagnosisInformTableView;
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

@property (retain, nonatomic) NSMutableArray *vehicleDiagnosisInformMutableArray;
@property (retain, nonatomic) NSMutableArray *deleteMutableArray;
@end
