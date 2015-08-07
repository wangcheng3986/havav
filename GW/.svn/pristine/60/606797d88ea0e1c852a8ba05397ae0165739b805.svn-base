/*!
 @header ElecFenceViewController.h
 @abstract 电子围栏主控界面
 @author wangqiwei
 @version 1.00 2014/9/1 Create
 */
#import <UIKit/UIKit.h>
#import "ElecFenceData.h"
#import "EGORefreshTableHeaderView.h"
#import "ElecFenceQueryNetManagerDelegate.h"
#import "ElecFenceQueryNetManager.h"
#import "ElecFenceDeleteNetManagerDelegate.h"
#import "ElecFenceDeleteNetManager.h"
#import "MBProgressHUD.h"
@interface ElecFenceViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,EGORefreshTableHeaderDelegate,ElecFenceQueryNetManagerDelegate,ElecFenceDeleteNetManagerDelegate,MBProgressHUDDelegate>
{

    IBOutlet UIImageView *headerImage;
    IBOutlet UILabel *headerDetail;
    IBOutlet UIButton *headerNewButton;
    IBOutlet UIImageView *bgImage;
    
    IBOutlet UIButton *creatNewElecButton;
    IBOutlet UILabel *NewElecButton;
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
    ElecFenceQueryNetManager *elecFenceQueryNetManager;
    ElecFenceDeleteNetManager *elecFenceDeleteNetManager;
}
@property (retain, nonatomic) IBOutlet UIView *headerView;
@property (retain, nonatomic) NSMutableArray *deleteMutableArray;
@property (retain, nonatomic) NSMutableArray *tempDeleteMutableArray;
@property (retain, nonatomic) NSMutableArray *elecFenceList;
@property (retain, nonatomic)IBOutlet UITableView *elecFenceTableView;
@property (nonatomic, retain) MBProgressHUD    *progressHUD;

- (void)tableViewEdit;
- (void)tableViewFinish;
-(void)submitData;
- (void)reloadTableViewData;
- (void)doneLoadingTableViewData1;
@end
