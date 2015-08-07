
/*!
 @header POIDetailViewController.h
 @abstract poi详情界面
 @author mengy
 @version 1.00 13-4-27 Creation
 */
#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "SearchResultData.h"
#import "POIData.h"
#import "NICreatePOI.h"
#import "NIDeletePOI.h"
#import "NItinyUrlCreate.h"
#import "MBProgressHUD.h"
#import "MapPoiData.h"
@class SearchResultViewController;
@class CollectViewController;
@class MapMainViewController;
@class MapTabBarViewController;
@interface POIDetailViewController : UIViewController<NICreatePOIDelegate,NIDeletePOIDelegate,MFMessageComposeViewControllerDelegate,MBProgressHUDDelegate,NItinyUrlCreateDelegate,UITextFieldDelegate>
{
    NItinyUrlCreate *mTinyUrlCreate;
    NICreatePOI *mCreatePOI;
    NIDeletePOI *mDeletePOI;
    UserData *mUserData;
    NSString *fPOIID;
    IBOutlet UIView *interestPointView;
    IBOutlet UITextView *poiNameText;
    IBOutlet UILabel *poiAddressLabel;
    IBOutlet UITextView *poiAddressText;
    IBOutlet UILabel *poiPhoneLabel;
    IBOutlet UIButton *poiCallButton;
    IBOutlet UIButton *showMapButton;
    IBOutlet UIButton *searchAroundButton;
    IBOutlet UIButton *collectButton;
    IBOutlet UIButton *smsButton;
    IBOutlet UIButton *sendToCarButton;
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *poiCallLabel;
    IBOutlet UILabel *showMapLabel;
    IBOutlet UILabel *searchAroundLabel;
    IBOutlet UILabel *collectLabel;
    IBOutlet UILabel *smsLabel;
    IBOutlet UILabel *sendToCarLabel;
    IBOutlet UIImageView *collectImageView;
    POIData *data;
    LeftButton *backBtn;
    RightButton *rightBtn;
    IBOutlet UIView *locationView;
    IBOutlet UITextView *locationNameText;
    IBOutlet UILabel *locationAddressLabel;
    IBOutlet UITextView *locationAddressText;
    IBOutlet UIButton *locationShowMapButton;
    IBOutlet UIButton *locationSearchAroundButton;
    IBOutlet UIButton *locationCollectButton;
    IBOutlet UIButton *locationSmsButton;
    IBOutlet UIButton *locationSendToCarButton;
    IBOutlet UILabel *locationShowMapLabel;
    IBOutlet UILabel *locationSearchAroundLabel;
    IBOutlet UILabel *locationCollectLabel;
    IBOutlet UILabel *locationSmsLabel;
    IBOutlet UILabel *locationSendToCarLabel;
    IBOutlet UIImageView *locationCollectImageView;
    
    IBOutlet UIImageView *smsImageView;
    IBOutlet UIImageView *send2carImageView;
    IBOutlet UIImageView *downBgImageView;
    IBOutlet UIView *downView;
    IBOutlet UIImageView *upBgImageView;
    IBOutlet UIView *upView;
    IBOutlet UIImageView *showMapImageView;
    IBOutlet UIImageView *searchAroundImageView;
    IBOutlet UIImageView *callImageView;
    IBOutlet UIImageView *line1ImageView;
    IBOutlet UIImageView *line2ImageView;
    IBOutlet UIImageView *iconImageView;
    
    IBOutlet UIImageView *locationSmsImageView;
    IBOutlet UIImageView *locationSend2carImageView;
    IBOutlet UIImageView *locationDownBgImageView;
    IBOutlet UIView *locationDownView;
    IBOutlet UIImageView *locationUpBgImageView;
    IBOutlet UIView *locationUpView;
    IBOutlet UIImageView *locationShowMapImageView;
    IBOutlet UIImageView *locationSearchAroundImageView;
    IBOutlet UIImageView *locationIconImageView;
    IBOutlet UIImageView *locationlineImageView;
    
    IBOutlet UIView *mDisView;
    IBOutlet UIView *remarkView;
    IBOutlet UILabel *remarkViewTitle;
    IBOutlet  UITextField*remarkViewTextField;
    IBOutlet UIButton *remarkViewCancelBtn;
    IBOutlet UIButton *remarkViewAffirmBtn;
    
    
    NSString         *_picUrlString;
    UIImageView      *_imageView;
    MBProgressHUD    *_progressHUD;
    
}

@property (nonatomic, copy) NSString           *picUrlString;
@property (nonatomic, retain) IBOutlet         UIImageView *imageView;
@property (nonatomic, retain) MBProgressHUD    *progressHUD;
@property (assign, nonatomic) SearchResultViewController *searchResultRootController;
@property (assign, nonatomic) CollectViewController *collectViewRootController;
@property (assign, nonatomic) MapMainViewController *mapViewRootController;
@property (assign, nonatomic) MapTabBarViewController *mapRootController;
@property (retain, nonatomic)POIData *data;
//@property(retain, nonatomic) NSString *fPOIID;
/*!
 @method setCollectType:(int)collecttype
 @abstract 设置收藏类型
 @discussion 设置收藏类型
 @param collecttype 获取类型
 @result 无
 */
-(void)setCollectType:(int)collecttype;

/*!
 @method setPOI:(SearchResultData *)POI
 @abstract 设置poi，从搜索结果传来
 @discussion 设置poi，从搜索结果传来
 @param POI 搜索结果poi
 @result 无
 */
-(void)setPOI:(id)POI type:(int)type;

/*!
 @method setCollectPOI:(POIData *)POI type:(int)type;
 @abstract 设置poi，从收藏夹传来
 @discussion 设置poi，从收藏夹传来
 @param POI 收藏夹poi
 @result 无
 */
-(void)setCollectPOI:(POIData *)POI type:(int)type;


/*!
 @method setCustomPOI:(MapPoiData *)POI
 @abstract 设置poi，从收藏夹传来
 @discussion 设置poi，从收藏夹传来
 @param POI 收藏夹poi
 @result 无
 */
-(void)setCustomPOI:(MapPoiData *)POI type:(int)type;


/*!
 @method setfPOIID:(NSString *)POIID
 @abstract 设置poiid
 @discussion 设置poiid
 @param POIID poiid
 @result 无
 */
-(void)setfPOIID:(NSString *)POIID;


/*!
 @method setPOIPhone:(NSString *)phone
 @abstract 设置poi电话
 @discussion 设置poi电话
 @param phone poi电话
 @result 无
 */
-(void)setPOIPhone:(NSString *)phone;
@end
