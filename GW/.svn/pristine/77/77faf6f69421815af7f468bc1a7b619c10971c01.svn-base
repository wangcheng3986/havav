

/*!
 @header CollectViewController.h
 @abstract 收藏夹类
 @author mengy
 @version 1.00 13-4-24 Creation
 */
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "BaseViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "NIQueryPOI.h"
#import "NIDeletePOI.h"
#import "NIPOISycn.h"
@class MapTabBarViewController;
@interface CollectViewController :  UIViewController
<UITableViewDelegate, UITableViewDataSource,UINavigationBarDelegate,EGORefreshTableHeaderDelegate,NIQueryPOIDelegate,NIDeletePOIDelegate,NIPOISycnDelegate,MBProgressHUDDelegate>
{
    UserData *mUserData;
    NIQueryPOI *mQueryPOI;
    NIDeletePOI *mDeletePOI;
    NIPOISycn *mPOISycn;
    IBOutlet UITableView *collectTableView;
    IBOutlet UILabel *titleLabel;
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
    NSString         *_picUrlString;
    UIImageView      *_imageView;
    MBProgressHUD    *_progressHUD;
    IBOutlet UIButton *sycnBtn;
    IBOutlet UIButton *editBtn;
    IBOutlet UIView *btnView;
}
@property (assign, nonatomic) MapTabBarViewController *rootController;
@property (retain, nonatomic) NSMutableArray *deleteMutableArray;
@property (retain, nonatomic) NSMutableArray *unCollectData;
@property (retain, nonatomic) NSMutableArray *collectTableData;
@property (nonatomic, copy) NSString           *picUrlString;
@property (nonatomic, retain) IBOutlet         UIImageView *imageView;
@property (nonatomic, retain) MBProgressHUD    *progressHUD;
//-(void)tableViewEdit;
//- (void)reloadTableViewDataSource;
//- (void)doneLoadingTableViewData;
//-(void)tableviewReloadData;
//-(void)submitData;

@end
