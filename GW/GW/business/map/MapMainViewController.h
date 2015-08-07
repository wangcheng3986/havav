

/*!
 @header MapMainViewController.h
 @abstract 地图主界面类
 @author mengy
 @version 1.00 13-4-24 Creation
 */
#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "NIGetLastTrack.h"
#import "UserData.h"
#import "CarData.h"
#import "MBProgressHUD.h"
#import "UIMapBaseViewController.h"
#import "CustomMapView.h"
#import "MapPoiData.h"
#import "NINaviManager.h"
@class MapTabBarViewController;
//@class MapViewController;
@interface MapMainViewController : UIMapBaseViewController <NIGetLastTrackDelegate,MBProgressHUDDelegate,NINaviManagerDelegate>
{
    NIGetLastTrack *mGetLastTrcak;
    UserData *mUserData;
    CarData *mCarData;
    IBOutlet UIButton *searchButton;
    IBOutlet UILabel *titleLabel;
    
//    HomeButton *backBtn;
    IBOutlet UIImageView *compassImageView;
    
    IBOutlet UIView *mDisView;
    NSString         *_picUrlString;
    UIImageView      *_imageView;
    MBProgressHUD    *_progressHUD;
    
    IBOutlet CustomMapView* _mapView;
    
    IBOutlet UIButton *carBtn;
    IBOutlet UIButton *phoneBtn;
    IBOutlet UIButton *routeBtn;
    IBOutlet UILabel *disNum;
    IBOutlet UILabel *paopaoInfoTitle;
    IBOutlet UILabel *paopaoInfoSubTitle;
    IBOutlet UILabel *paopaoInfoText;
    
    
    
    UIView *infoView;

    IBOutlet UIView *routeView;
    IBOutlet UIView *paopaoVIew;
}

@property (nonatomic, copy) NSString           *picUrlString;
@property (nonatomic, retain) IBOutlet         UIImageView *imageView;
@property (nonatomic, assign) MBProgressHUD    *progressHUD;
@property (assign, nonatomic) MapTabBarViewController *rootController;
@property (assign, nonatomic) int mapZoom;
@property (assign, nonatomic) float centralLon;
@property (assign, nonatomic) float centralLat;
@property (assign, nonatomic) BOOL isFromSearch;

/*!
 @method getLastTrack
 @abstract 获取最后车辆位置
 @discussion 获取最后车辆位置
 @param 无
 @result 无
 */
//- (void)getLastTrack;

/*!
 @method getMapCenterCoord
 @abstract 获取地图主界面中心坐标
 @discussion 获取地图主界面中心坐标
 @param 无
 @result centerCoor 中心坐标
 */
-(CLLocationCoordinate2D)getMapCenterCoord;
@end
