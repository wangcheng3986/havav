
/*!
 @header OpenTSeviceViewController.h
 @abstract 开通服务类
 @author mengy
 @version 1.00 14-7-3 Creation
 */
#import <UIKit/UIKit.h>
#import "App.h"
#import "UIUnderLineButton.h"
#import "NISetPWD.h"
#import "NIGetCDKEY.h"
#import "MBProgressHUD.h"
#import "ProtocolViewController.h"
#import "NoCopyTextField.h"
@interface OpenTSeviceViewController : UIViewController<NIGetCDKEYDelegate,NISetPWDDelegate,MBProgressHUDDelegate,UITextFieldDelegate>
{
    NISetPWD *mSetPWD;
    NIGetCDKEY *mGetCDKEY;
    IBOutlet UIControl *control;
    IBOutlet UITextField *phoneTextField;
    IBOutlet UITextField *cdkeyTextField;
    IBOutlet NoCopyTextField *pwdTextField;
    IBOutlet NoCopyTextField *pwdAgainTextField;
    IBOutlet UILabel *phoneLabel;
    IBOutlet UILabel *pwdLabel;
    IBOutlet UILabel *pwdAgainLabel;
    IBOutlet UILabel *cdkeyLabel;
    IBOutlet UILabel *timeDownLabel;
    IBOutlet UIButton *getCDKEYBtn;
    IBOutlet UIButton *openTSeverBtn;
    IBOutlet UIImageView *phoneImageView;
    IBOutlet UIImageView *pwdImageView;
    IBOutlet UIImageView *pwdAgainImageView;
    IBOutlet UIImageView *cdkeyImageView;
    IBOutlet UIUnderLineButton *protocolBtn;
    IBOutlet UILabel *titleLabel;
    IBOutlet UIImageView *controlBg;
    HomeButton *leftBtn;
    
    
    IBOutlet UIImageView *protocolImageView;
    
    IBOutlet UIButton *protocolButton;
    
    NSString         *_picUrlString;
    UIImageView      *_imageView;
    MBProgressHUD    *_progressHUD;
    
}
@property (nonatomic, copy) NSString           *picUrlString;
@property (nonatomic, retain) IBOutlet         UIImageView *imageView;
@property (nonatomic, retain) MBProgressHUD    *progressHUD;
@end
