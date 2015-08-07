/***********************************
 * 版权所有：北京四维图新科技股份有限公司
 * 文件名称：FriendListViewController。h
 * 文件标识：
 * 内容摘要：车友列表
 * 其他说明：
 * 当前版本：
 * 作    者：刘铁成，王立琼
 * 完成日期：2013-08-25
 * 修改记录1：
 *	修改日期：2013-09-02
 *	版 本 号：
 *	修 改 人：孟磊
 *	修改内容：1.Demo模式下添加车友成功后返回车友列表
 *          2.Demo模式下添加成功提示与等待框并存，等待框不消失
 *          3.Demo模式下返回到车友列表后，重新进入同步车友界面
 **************************************/

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "NIUpdateContacts.h"
#import "NIDeleteContacts.h"
#import "NIGetContactsList.h"
#import "NISyncContacts.h"
#import "MBProgressHUD.h"
#import "NIDeleteBlack.h"
#import "NIGetBlack.h"

@class FriendTabBarViewController;

@interface FriendListViewController : UIViewController
<UITableViewDelegate, UITableViewDataSource,EGORefreshTableHeaderDelegate,UINavigationBarDelegate,
NIDeleteContactsDelegate,NIUpdateContactsDelegate,NIGetContactsListDelegate,NISyncContactsDelegate,MBProgressHUDDelegate,NIDeleteBlackDelegate,NIGetBlackDelegate>
{
    IBOutlet UIButton *syncContactsButton;
    IBOutlet UIView *firstLoginView;
    IBOutlet UITableView *tableview;
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *syncTitleLabel;
    IBOutlet UILabel *syncTextLabel;
    UINavigationController  *navigation;
//    IBOutlet UILabel *listtitleLabel;
//    HomeButton *backBtn;
    RightButton *editBtn;
    IBOutlet UISegmentedControl *m_segmentedControl;
    IBOutlet UIActivityIndicatorView *activityIndicator;
    IBOutlet UIView *btnView;
    IBOutlet UIButton *friendlistBtn;
    IBOutlet UIButton *blacklistBtn;
    IBOutlet UIView *footerView;
    IBOutlet UILabel *footerLabel;
    NIDeleteContacts *mDeleteContacts;
    NIUpdateContacts *mUpdateContacts;
    NIGetContactsList *mGetContacts;
    NISyncContacts *mSyncContacts;
    NIGetBlack *mGetBlack;
    NIDeleteBlack *mDeleteBlack;
    //NSString         *_picUrlString;
    UIImageView      *_imageView;
    MBProgressHUD    *_progressHUD;
}

//@property (nonatomic, copy) NSString           *picUrlString;
@property (nonatomic, retain) IBOutlet         UIImageView *imageView;
@property (nonatomic, retain) MBProgressHUD    *progressHUD;
@property (assign, nonatomic) FriendTabBarViewController *rootController;
@property (retain, nonatomic) NSMutableArray *dataMutableArray;
@property (retain, nonatomic) NSMutableArray *blacklistDataMutableArray;
@property (retain, nonatomic) NSMutableArray *deleteMutableArray;
@property (retain, nonatomic) NSMutableArray *tempDeleteMutableArray;

@property BOOL isSyncAndGetContactsList; //同时执行同步和获取通讯录时只显示一次等待框

-(void)tableViewEdit;
- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;
-(void)setTableviewType:(int)type;
-(void)submitData;
-(void)setEditType:(int)type;
-(void)sendGetContactListRequest;
- (void)viewDidLoad;

/*将实现代码从ViewDidLoad中剥离出来，与Demo的控制标识分开*/
-(void)doViewDidLoad;
-(void) refreshFriendList:(BOOL)bShowHUD;
-(void) syncFriendList:(BOOL)bShowHUD;
-(void) addFriendIntoList:(FriendsData *) friendData;

//demo通讯录同步时，将界面置为车友列表界面
-(void)demoDisplayFriendList;

-(void)JumptoNew:(NSString *)name;
@end
