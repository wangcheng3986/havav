
/*!
 @header SendToCarDetailViewController.h
 @abstract 发送到车消息类
 @author mengy
 @version 1.00 13-5-3 Creation
 */
#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "NICommonFormatDefine.h"
#import "SendToCarMessageData.h"
#import "NItinyUrlCreate.h"
#import "MBProgressHUD.h"
#import "NICreateBlack.h"
#import "NICreateContacts.h"

#import "UIMapBaseViewController.h"
#import "CustomMapView.h"
@interface SendToCarDetailViewController : UIMapBaseViewController<UIActionSheetDelegate,MFMessageComposeViewControllerDelegate,NItinyUrlCreateDelegate,MBProgressHUDDelegate,NICreateBlackDelegate,UITextFieldDelegate,NICreateContactsDelegate>
{
    NICreateContacts *mCreateContacts;
    NICreateBlack *mCreateBlack;
    NItinyUrlCreate *mTinyUrlCreate;
    IBOutlet UILabel *titleLabel;
    IBOutlet UIImageView *mapImageView;
    IBOutlet UIView *messageView;
    IBOutlet UIView *buttonView;
    IBOutlet UILabel *senderLabel;
    IBOutlet UILabel *timeLabel;
    IBOutlet UITextView *messageLabel;
    IBOutlet UIButton *shareLocationButton;
    IBOutlet UIButton *addBlacklistButton;
    IBOutlet UIButton *addFriendlistButton;
    IBOutlet UILabel *shareLabel;
    IBOutlet UILabel *addBlackListLabel;
    IBOutlet UILabel *addFriendListLabel;
    IBOutlet UIView *shareLocationView;
    IBOutlet UIButton *shareByShortMessage;
    IBOutlet UIButton *sendToCar;
    IBOutlet UIButton *cancelShare;
    IBOutlet UILabel *sendToCarLabel;
    IBOutlet UILabel *shareByShortMessageLabel;
    IBOutlet UILabel *cancelLabel;
    IBOutlet UIImageView *bottomPopUpbg;
    
    
    IBOutlet UIView *mDisView;
    IBOutlet UIView *remarkView;
    IBOutlet UILabel *remarkViewTitle;
    IBOutlet  UITextField*remarkViewTextField;
    IBOutlet UIButton *remarkViewCancelBtn;
    IBOutlet UIButton *remarkViewAffirmBtn;

    
    NSString *fName;
    NSString *fLocName;

    NSString         *_picUrlString;
    UIImageView      *_imageView;
    MBProgressHUD    *_progressHUD;
    LeftButton *backBtn;
    
    
    IBOutlet CustomMapView* _mapView;
    //添加单个大头针标注 可以换图片
//    NIPointAnnotation* onePoint;
//    NIAnnotationView* viewPaopao;
//    //气泡
//    NIActionPaopaoAnnotation* ppAnnotation;

}
@property (nonatomic, retain)SendToCarMessageData *mData;
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
