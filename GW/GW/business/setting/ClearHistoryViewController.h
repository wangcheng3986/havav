
/*!
 @header ClearHistoryViewController.h
 @abstract 清除历史类
 @author mengy
 @version 1.00 14-8-7 Creation
 */
#import <UIKit/UIKit.h>
#import "App.h"
#import "MBProgressHUD.h"
@interface ClearHistoryViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,MBProgressHUDDelegate>
{
    IBOutlet UITableView *clearTableView;
    IBOutlet UILabel *titleLabel;
    IBOutlet UIView *clearView;
    IBOutlet UIButton *cencelBtn;
    IBOutlet UIButton *affirmBtn;
    IBOutlet UILabel *alertMessageLabel;
    IBOutlet UIView *mDisView;
    LeftButton *backBtn;
    RightButton *clearBtn;
    NSArray *listTitleArray;
    NSArray *listMessageArray;
    NSArray *listIconNameArray;
    NSString         *_picUrlString;
    UIImageView      *_imageView;
    MBProgressHUD    *_progressHUD;
    
}
@property (nonatomic, copy) NSString           *picUrlString;
@property (nonatomic, retain) IBOutlet         UIImageView *imageView;
@property (nonatomic, retain) MBProgressHUD    *progressHUD;
@end
