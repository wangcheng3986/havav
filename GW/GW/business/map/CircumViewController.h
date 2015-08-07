

/*!
 @header CircumViewController.h
 @abstract 周边搜索类
 @author mengy
 @version 1.00 13-4-24 Creation
 */
#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "POIData.h"
#import "MBProgressHUD.h"
#import "SearchResultData.h"
#import "NIPOISearchJSONServer.h"
#import "NIPOISearch4S.h"
#import "Search4SResultData.h"
@class MapTabBarViewController;
@class MapMainViewController;
@interface CircumViewController :  UIViewController<UITableViewDelegate, UITableViewDataSource,UINavigationBarDelegate,UISearchBarDelegate,NIPOISearchJSONSeverDelegate,MBProgressHUDDelegate,NIPOISearch4SDelegate>
{
    
    IBOutlet UITableView *searchTypeTableView;
    IBOutlet UISearchBar *searchViewSearchBar;
    IBOutlet UIImageView *tableViewBg;
    IBOutlet UILabel *titleLabel;
    IBOutlet UIView *mDisView;
    NIPOISearchJSONServer *mPOISearchJSONServer;
    NIPOISearch4S *mPOISearch4S;
    NSString         *_picUrlString;
    UIImageView      *_imageView;
    MBProgressHUD    *_progressHUD;
    
}

@property (nonatomic, copy) NSString           *picUrlString;
@property (nonatomic, retain) IBOutlet         UIImageView *imageView;
@property (nonatomic, assign) MBProgressHUD    *progressHUD;

@property(assign)MapMainViewController *mapViewController;
@property (assign, nonatomic) MapTabBarViewController *rootController;
@property (retain, nonatomic) NSMutableArray *searchTypeMutableArray;


@property (retain, nonatomic) NICustomPoi *centralPOI;
@property(assign,nonatomic)NSMutableArray *searchResultMutableArray;
@property(assign,nonatomic)int searchTotal;

/*!
 @method setPOI:(POIData *)poi
 @abstract 设置周边搜索中心点
 @discussion 设置周边搜索中心点
 @param poi poi信息
 @result 无
 */
-(void)setPOI:(POIData *)poi;
@end
