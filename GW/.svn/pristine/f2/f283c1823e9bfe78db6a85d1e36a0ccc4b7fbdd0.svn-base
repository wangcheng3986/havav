

/*!
 @header MessageViewController.h
 @abstract 消息分类
 @author mengy
 @version 1.00 13-5-2 Creation
 */
#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "NICommonFormatDefine.h"
#import "VehicleControlInformViewController.h"
#import "VehicleDiagnosisInformViewController.h"
#import "VehiclesAbnormalAlarmViewController.h"
#import "MaintenanceAlertInformViewController.h"
#import "MBProgressHUD.h"
@interface MessageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>
{
    IBOutlet UILabel *titleLabel;
    HomeButton *backBtn;
    LeftButton *childBackBtn;
    
    
    IBOutlet UITableView *messageTableView;
    NSMutableArray *sectionOneMutableArray;
    NSMutableArray *sectionTwoMutableArray;
    NSMutableArray *sectionThreeMutableArray;
    NSMutableArray *sectionOneCountMutableArray;
    NSMutableArray *sectionTwoCountMutableArray;
    NSMutableArray *sectionThreeCountMutableArray;
    NSMutableArray *sectionOneIconMutableArray;
    NSMutableArray *sectionTwoIconMutableArray;
    NSMutableArray *sectionThreeIconMutableArray;
    
    
    NSString         *_picUrlString;
    UIImageView      *_imageView;
    MBProgressHUD    *_progressHUD;
    
}

@property (nonatomic, copy) NSString           *picUrlString;
@property (nonatomic, retain) IBOutlet         UIImageView *imageView;
@property (nonatomic, retain) MBProgressHUD    *progressHUD;
@property (retain, nonatomic) NSMutableArray *dataMutableArray;

@end
