
/*!
 @header MapTabBarViewController.h
 @abstract 地图Tab类
 @author mengy
 @version 1.00 13-4-24 Creation
 */
#import <UIKit/UIKit.h>
#import "TabViewController.h"
#import "MapMainViewController.h"
#import "CollectViewController.h"
#import "CircumViewController.h"
#import "MainViewController.h"
#import "MBProgressHUD.h"
@interface MapTabBarViewController : UITabBarController<UITableViewDelegate, UITableViewDataSource,UINavigationBarDelegate,UINavigationControllerDelegate,
UITabBarControllerDelegate,
UISearchBarDelegate,MBProgressHUDDelegate>
{
//    IBOutlet UITabBarController *mapTabBarController;
    IBOutlet UILabel *titleLabel;
    IBOutlet MapMainViewController *mapController;
    IBOutlet CollectViewController *collectController;
    IBOutlet CircumViewController *circumController;
    int poiLoadType;
    int isFirstInCollect;
    NSString *keyword;
    NSString *searchType;
    UserData *mUserData;
    IBOutlet UIView *mDisView;
    NSString *mlon;
    NSString *mlat;
    NSString *mTitle;
    NSString *mAddress;
    NSString * fPOIID;
    BOOL tabBarEnabled;
    
    NSString         *_picUrlString;
    UIImageView      *_imageView;
    MBProgressHUD    *_progressHUD;
    
}

@property (nonatomic, copy) NSString           *picUrlString;
@property (nonatomic, retain) IBOutlet         UIImageView *imageView;
@property (nonatomic, assign) MBProgressHUD    *progressHUD;
@property(assign,nonatomic)MainViewController *mainRootViewController;
@property(retain)UIView *mDisView;
@property(assign)int poiLoadType;
@property(assign)int isFirstInCollect;
@property(assign)CLLocationCoordinate2D centralCoord;
@property(assign)CLLocationCoordinate2D circumSearchCentralCoord;
@property(copy)NSString *keyword;
@property(copy)NSString *searchType;
@property(assign)HomeButton *backBtn;

@property(nonatomic,retain)NSMutableDictionary *urlDic;

@property(assign)BOOL tabBarEnabled;
/*!
 @method setPOILoad:(int)poiLoad
 @abstract 设置收藏夹获取方式，现均未本地获取
 @discussion 设置收藏夹获取方式，现均未本地获取
 @param poiLoad 获取方式
 @result 无
 */
-(void)setPOILoad:(int)poiLoad;

/*!
 @method setIsFirstInCollect:(int)data
 @abstract 设置是否第一次进入收藏夹
 @discussion 设置是否第一次进入收藏夹
 @param data 第几次进入收藏夹
 @result 无
 */
-(void)setIsFirstInCollect:(int)data;

/*!
 @method goCircum:(POIData *)poi
 @abstract 进入周边搜索
 @discussion 进入周边搜索
 @param poi 周边搜索中心点
 @result 无
 */
-(void)goCircum:(POIData *)poi;

/*!
 @method search
 @abstract 搜索
 @discussion 搜索
 @param 无
 @result 无
 */
//-(void)search;

/*!
 @method showPOI:(POIData *)poi
 @abstract 显示poi详情
 @discussion 显示poi详情
 @param poi poi信息
 @result 无
 */
-(void)showPOI:(POIData *)poi;

/*!
 @method showCustomPOI:(MapPoiData *)poi type:(int)type
 @abstract 车辆，手机或自定义位置详情
 @discussion 车辆，手机或自定义位置详情
 @param poi poi信息
 @param type 位置类型
 @result 无
 */
-(void)showCustomPOI:(MapPoiData *)poi type:(int)type;

/*!
 @method setPOI:(NSString *)lon lat:(NSString *)lat
 @abstract 设置经纬度
 @discussion 设置经纬度
 @param lon 经度
 @param lat 纬度
 @result 无
 */
//-(void)setPOI:(NSString *)lon lat:(NSString *)lat;

/*!
 @method setfPOIID:(NSString *)POIID
 @abstract 设置自定义位置点id
 @discussion 设置自定义位置点id
 @param POIID id
 @result 无
 */
-(void)setfPOIID:(NSString *)POIID;

/*!
 @method onclickSearch
 @abstract 点击地图上搜索栏进入搜索界面
 @discussion 点击地图上搜索栏进入搜索界面
 @param 无
 @result 无
 */
-(void)onclickSearch;

/*!
 @method setURLDic:(NSMutableDictionary *)urlDic
 @abstract 从短信url中获取的poi信息
 @discussion 从短信url中获取的poi信息
 @param 无
 @result 无
 */
-(void)setURLDic:(NSMutableDictionary *)URL;

/*!
 @method goMapMainVCWithMapzoom:(int)mapzoom centralLon:(float)centralLon centralLat:(float)centralLat
 @abstract 搜索到直达词后进入地图主界面
 @discussion 搜索到直达词后进入地图主界面
 @param mapzoom 地图缩放比例
 @param centralLon 中心点经度
 @param centralLat 中心点纬度
 @result 无
 */
-(void)goMapMainVCWithMapzoom:(int)mapzoom centralLon:(float)centralLon centralLat:(float)centralLat;

/*!
 @method goSearchWithReault:(NSMutableArray *)mutableArray searchTotal:(int)searchTotal type:(int)type
 @abstract 搜索到结果后跳转到搜索列表界面
 @discussion 搜索到结果后跳转到搜索列表界面
 @param mutableArray 搜索结果列表
 @param searchTotal 搜索总条数
 @param type 搜索类型 是否为4s店
 @result 无
 */
-(void)goSearchWithReault:(NSMutableArray *)mutableArray searchTotal:(int)searchTotal type:(int)type;
@end
