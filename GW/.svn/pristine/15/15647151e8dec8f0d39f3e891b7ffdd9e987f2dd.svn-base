
/*!
 @header MaintenanceAlertInformViewController.h
 @abstract 保养提醒消息列表
 @author mengy
 @version 1.00 14-9-3 Creation
 */
#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "NICommonFormatDefine.h"
#import "CherryDBControl.h"
#import "MaintenanceAlertInformDetailViewController.h"
#import "MBProgressHUD.h"
@interface MaintenanceAlertInformViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *maintenanceAlertInformTableView;
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
@property (retain, nonatomic) NSMutableArray *maintenanceAlertInformMutableArray;
@property (retain, nonatomic) NSMutableArray *deleteMutableArray;
@end
