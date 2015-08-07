
/*!
 @header FriendLocationDetailViewController.h
 @abstract 位置请求消息类
 @author mengy
 @version 1.00 13-5-2 Creation
 */
#import <UIKit/UIKit.h>
#import "BaseViewController.h"

#import "NICommonFormatDefine.h"
#import "NItinyUrlCreate.h"
#import "MBProgressHUD.h"
#import "NICreateBlack.h"
#import "UIMapBaseViewController.h"
#import "CustomMapView.h"
@interface FriendLocationDetailViewController :UIMapBaseViewController <UIActionSheetDelegate,MFMessageComposeViewControllerDelegate,NItinyUrlCreateDelegate,MBProgressHUDDelegate,NICreateBlackDelegate>
{
    NICreateBlack *mCreateBlack;
    NItinyUrlCreate *mTinyUrlCreate;
    IBOutlet UILabel *titleLabel;
    IBOutlet UIImageView *mapImageView;
    IBOutlet UIView *messageView;
    IBOutlet UIView *locationView;
    IBOutlet UILabel *selfLabel;
    IBOutlet UILabel *timeLabel;
    //IBOutlet UILabel *messageLabel;
    IBOutlet UILabel *uploadTimeLabel;
    IBOutlet UILabel *carNameLabel;
    IBOutlet UILabel *uploadAddressLabel;
    IBOutlet UILabel *uploadTimeTextLabel;
    IBOutlet UILabel *carNameTextLabel;
    IBOutlet UILabel *uploadAddressTextLabel;
    IBOutlet UITextView *uploadAddressText;
    IBOutlet UIButton *shareLocationButton;
    IBOutlet UIButton *addBlacklistButton;
    IBOutlet UILabel *shareLabel;
    IBOutlet UILabel *addBlacklistLabel;
    IBOutlet UITextView *mMessageTextView;
    IBOutlet UIView *shareLocationView;
    IBOutlet UILabel *sendToCarLabel;
    IBOutlet UILabel *shareByShortMessageLabel;
    IBOutlet UILabel *cancelLabel;
    IBOutlet UIImageView *bottomPopUpbg;
    IBOutlet UIButton *sharebyMessage;
    IBOutlet UIButton *toCar;
    IBOutlet UIButton *cancel;
    
    
    NSString         *_picUrlString;
    UIImageView      *_imageView;
    MBProgressHUD    *_progressHUD;
    
    NSString *fName;
    LeftButton *backBtn;
    IBOutlet CustomMapView* _mapView;
    //添加单个大头针标注 可以换图片
//    NIPointAnnotation* onePoint;
//    NIAnnotationView* viewPaopao;
//    //气泡
//    NIActionPaopaoAnnotation* ppAnnotation;
}

@property (nonatomic, retain)FriendRequestLocationMessageData *mData;
@property (nonatomic, copy) NSString           *picUrlString;
@property (nonatomic, retain) IBOutlet         UIImageView *imageView;
@property (nonatomic, retain) MBProgressHUD    *progressHUD;
@property (nonatomic, copy) NSString           *fName;
/*!
 @method setKeyID:(NSString *)keyid
 @abstract 设置keyid
 @discussion 设置keyid
 @param keyid
 @result 无
 */
-(void)setKeyID:(NSString *)keyid;

@end
