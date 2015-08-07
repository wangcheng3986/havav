
/*!
 @header SearchViewController.h
 @abstract 搜索界面
 @author mengy
 @version 1.00 13-4-25 Creation
 */
#import <UIKit/UIKit.h>
#import "TabViewController.h"
#import "NIPOISearchJSONServer.h"
#import "MBProgressHUD.h"
#import "SearchResultData.h"
#import "NIPOISearch4S.h"
#import "Search4SResultData.h"
@class MapMainViewController;
@interface SearchViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,UINavigationBarDelegate,UISearchBarDelegate,UIGestureRecognizerDelegate,UIGestureRecognizerDelegate,NIPOISearchJSONSeverDelegate,MBProgressHUDDelegate,NIPOISearch4SDelegate>
{
    IBOutlet UITableView *searchHistoryTableView;
    IBOutlet UISearchBar *searchViewSearchBar;
    IBOutlet UILabel *titleLabel;
    LeftButton *backBtn;
    IBOutlet UIImageView *downBg;
    NICustomPoi *centralPOI;
    NIPOISearchJSONServer *mPOISearchJSONServer;
    NIPOISearch4S *mPOISearch4S;
    IBOutlet UIView *mDisView;
    NSString         *_picUrlString;
    UIImageView      *_imageView;
    MBProgressHUD    *_progressHUD;
}

@property (nonatomic, copy) NSString           *picUrlString;
@property (nonatomic, retain) IBOutlet         UIImageView *imageView;
@property (nonatomic, assign) MBProgressHUD    *progressHUD;
@property(assign,nonatomic)MapMainViewController *mapViewRootController;
@property (retain, nonatomic) NSMutableArray *searchHistoryMutableArray;
@property(assign,nonatomic)NSMutableArray *searchResultMutableArray;
@property(assign,nonatomic)int searchTotal;

@end
