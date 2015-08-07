
/*!
 @header SystemMessageViewController.h
 @abstract 系统消息类
 @author mengy
 @version 1.00 13-5-2 Creation
 */
#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "NICommonFormatDefine.h"
#import "EGORefreshTableHeaderView.h"
#import "MBProgressHUD.h"
#import "NINotificationDelete.h"
@interface SystemMessageViewController : UIViewController<UITableViewDataSource,EGORefreshTableHeaderDelegate,UITableViewDelegate,MBProgressHUDDelegate,NINotificationDeleteDelegate>
{
    IBOutlet UITableView *systemMessageTableView;
    IBOutlet UILabel *titleLabel;
    LeftButton *backBtn;
    RightButton *editBtn;
    IBOutlet UILabel *footerLabel;
    IBOutlet UIView *noMessageView;
    EGORefreshTableHeaderView *_refreshHeaderView;
    NSString         *_picUrlString;
    UIImageView      *_imageView;
    MBProgressHUD    *_progressHUD;
    NINotificationDelete *mDelete;
}
@property (retain, nonatomic) NSMutableArray *systemMessageMutableArray;
@property (retain, nonatomic) NSMutableArray *deleteMutableArray;
@property (nonatomic, copy) NSString           *picUrlString;
@property (nonatomic, retain) IBOutlet         UIImageView *imageView;
@property (nonatomic, retain) MBProgressHUD    *progressHUD;
@end
