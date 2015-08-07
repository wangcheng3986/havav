
/*!
 @header ElectronicFenceViewController.h
 @abstract 电子围栏消息类
 @author mengy
 @version 1.00 13-5-2 Creation
 */
#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "NICommonFormatDefine.h"
#import "CherryDBControl.h"
#import "MBProgressHUD.h"
@interface ElectronicFenceViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>
{
    IBOutlet UITableView *electronicFenceTableView;
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
@property (retain, nonatomic) NSMutableArray *electronicFenceMutableArray;
@property (retain, nonatomic) NSMutableArray *deleteMutableArray;
@end
