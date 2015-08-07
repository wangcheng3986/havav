

/*!
 @header SendToCarViewController.h
 @abstract 发送到车消息类
 @author mengy
 @version 1.00 13-5-2 Creation
 */

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>
#import "BaseViewController.h"
#import "NICommonFormatDefine.h"
#import "NINotificationDelete.h"
#import "MBProgressHUD.h"
@interface SendToCarViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NINotificationDeleteDelegate,MBProgressHUDDelegate>
{
    NINotificationDelete *mDelete;
    IBOutlet UITableView *sendToCarTableView;
    IBOutlet UILabel *titleLabel;
    LeftButton *backBtn;
    RightButton *editBtn;
    IBOutlet UIButton *loadButton;
    //IBOutlet UIView *footerView;
    IBOutlet UILabel *footerLabel;
    BOOL _reloading;
    NSString         *_picUrlString;
    UIImageView      *_imageView;
    MBProgressHUD    *_progressHUD;
}
@property (retain, nonatomic) NSMutableArray *sendToCarMutableArray;
@property (retain, nonatomic) NSMutableArray *deleteMutableArray;
@property (nonatomic, copy) NSString           *picUrlString;
@property (nonatomic, retain) IBOutlet         UIImageView *imageView;
@property (nonatomic, retain) MBProgressHUD    *progressHUD;
@end
