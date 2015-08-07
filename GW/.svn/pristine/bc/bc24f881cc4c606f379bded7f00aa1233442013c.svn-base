
/*!
 @header POIMapViewController.h
 @abstract 地图类
 @author mengy
 @version 1.00 13-4-27 Creation
 */
#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "UIMapBaseViewController.h"
#import "MapPoiData.h"
@class POIDetailViewController;
@interface POIMapViewController : UIMapBaseViewController
{
    IBOutlet UILabel *titleLabel;
    LeftButton *backBtn;
    IBOutlet CustomMapView* _mapView;
    NIPointAnnotation* onePoint;
    NIAnnotationView* viewPaopao;
//    //气泡
    NIActionPaopaoAnnotation* ppAnnotation;
}
@property(assign,nonatomic)POIDetailViewController *rootController;
/*!
 @method setPOI:(MapPoiData *)POI
 @abstract 设置poi，从搜索结果传来
 @discussion 设置poi，从搜索结果传来
 @param POI 搜索结果poi
 @result 无
 */
-(void)setPOI:(MapPoiData *)POI;



///*!
// @method setPOI:(SearchResultData *)POI
// @abstract 设置poi，从搜索结果传来
// @discussion 设置poi，从搜索结果传来
// @param POI 搜索结果poi
// @result 无
// */
//-(void)setLon:(double)lon;
///*!
// @method setPOI:(SearchResultData *)POI
// @abstract 设置poi，从搜索结果传来
// @discussion 设置poi，从搜索结果传来
// @param POI 搜索结果poi
// @result 无
// */
//-(void)setLat:(double)lat;
@end
