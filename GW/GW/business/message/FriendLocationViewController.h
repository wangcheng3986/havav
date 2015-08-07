

/*!
 @header FriendLocationViewController.h
 @abstract 车友位置消息类
 @author mengy
 @version 1.00 13-5-2 Creation
 */
#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "NICommonFormatDefine.h"
#import "EGORefreshTableHeaderView.h"
#import "MBProgressHUD.h"
#import "NINotificationDelete.h"
@interface FriendLocationViewController :UIViewController<UITableViewDataSource,EGORefreshTableHeaderDelegate,UITableViewDelegate,MBProgressHUDDelegate,NINotificationDeleteDelegate>
{
    IBOutlet UITableView *friendLocationTableView;
    IBOutlet UILabel *titleLabel;
    LeftButton *backBtn;
    RightButton *editBtn;
    IBOutlet UIButton *loadButton;
   // IBOutlet UIView *footerView;
    IBOutlet UILabel *footerLabel;
    EGORefreshTableHeaderView *_refreshHeaderView;
    NSString         *_picUrlString;
    UIImageView      *_imageView;
    MBProgressHUD    *_progressHUD;
    NINotificationDelete *mDelete;
}
@property (retain, nonatomic) NSMutableArray *friendLocationMutableArray;
@property (retain, nonatomic) NSMutableArray *deleteMutableArray;
@property (nonatomic, copy) NSString           *picUrlString;
@property (nonatomic, retain) IBOutlet         UIImageView *imageView;
@property (nonatomic, retain) MBProgressHUD    *progressHUD;
@end
