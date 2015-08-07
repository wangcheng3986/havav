
/*!
 @header SearchResultViewController.h
 @abstract 搜索结果
 @author mengy
 @version 1.00 13-4-24 Creation
 */
enum MAPVIEW_STATE
{
    MAPVIEW_SHOW=1,
    MAPVIEW_HIDE=0,
};

enum RIGHTBUTTON_STATE
{
    MAP=0,
    LIST=1,
};

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "BaseViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "NIPOISearchJSONServer.h"
#import "NIPOISearch4S.h"
#import "Search4SResultData.h"
#import "UIMapBaseViewController.h"
#import "MapPoiData.h"
@class SearchViewController;
@class CircumViewController;
//@class POIDetailViewController;
@interface SearchResultViewController : UIMapBaseViewController
<UITableViewDelegate, UITableViewDataSource,EGORefreshTableHeaderDelegate,UINavigationBarDelegate,NIPOISearchJSONSeverDelegate,MBProgressHUDDelegate,NIPOISearch4SDelegate>
{
    NIPOISearchJSONServer *mPOISearchJSONServer;
    NIPOISearch4S *mPOISearch4S;
    IBOutlet UILabel *titleLabel;
    IBOutlet UITableView *searchResultTableView;
    POIData *data;
    int resultRootType;
    LeftButton *backBtn;
    RightButton *mapBtn;
    IBOutlet CustomMapView* _mapView;
    IBOutlet UIView *footerView;
    IBOutlet UILabel *footerLabel;
    IBOutlet UIView *mDisView;
    NSString         *_picUrlString;
    UIImageView      *_imageView;
    MBProgressHUD    *_progressHUD;
    NIAnnotationView* viewPaopao;
    NIAnnotationView* _viewPoint;
    //气泡
    NIActionPaopaoAnnotation* ppAnnotation;
    
    NSMutableArray *pointAnnotationArray;//存储多个大头针
    
    
//    NIPointAnnotation *pointAnnotations;
}
@property (nonatomic, copy) NSString           *picUrlString;
@property (nonatomic, retain) IBOutlet         UIImageView *imageView;
@property (nonatomic, assign) MBProgressHUD    *progressHUD;
@property(assign)int resultRootType;
@property(assign)int searchKeyType;
@property(retain)POIData *data;
@property(assign) SearchViewController *searchViewRootController;
@property(assign)CircumViewController *circumViewRootController;
@property (nonatomic, assign)NSMutableArray *searchResultMutableArray;
@property (nonatomic, assign)int total;
/*!
 @method setKeyword:(NSString *)keyword
 @abstract 设置关键字
 @discussion 设置关键字
 @param keyword 关键字
 @result 无
 */
-(void)setKeyword:(NSString *)keyword;
/*!
 @method setSearchType:(NSString *)searchType
 @abstract 设置搜索类型
 @discussion 设置搜索类型
 @param searchType 搜索类型
 @result 无
 */
-(void)setSearchType:(NSString *)searchType;
/*!
 @method setCentreLocation:(double)lat lon:(double)lon
 @abstract 设置搜索中心点
 @discussion 设置搜索中心点
 @param lat 纬度
 @param lon 经度
 @result 无
 */
-(void)setCentreLocation:(double)lat lon:(double)lon;
@end
