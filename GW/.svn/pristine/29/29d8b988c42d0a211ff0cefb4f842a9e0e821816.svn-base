
/*!
 @header ResetPwdViewController.h
 @abstract 重置密码
 @author mengy
 @version 1.00 14-7-3 Creation
 */
#import <UIKit/UIKit.h>
#import "App.h"
#import "UIUnderLineButton.h"
#import "NIResetPWD.h"
#import "NIGetCDKEY.h"
#import "MBProgressHUD.h"
#import "ProtocolViewController.h"
#import "NoCopyTextField.h"
@interface ResetPwdViewController : UIViewController<NIGetCDKEYDelegate,NIResetPWDDelegate,MBProgressHUDDelegate,UITextFieldDelegate>
{
    NIResetPWD *mResetPWDPWD;
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
    IBOutlet UILabel *titleLabel;
    IBOutlet UIImageView *controlBg;
    HomeButton *leftBtn;
    
    
    NSString         *_picUrlString;
    UIImageView      *_imageView;
    MBProgressHUD    *_progressHUD;
    
}
@property (nonatomic, copy) NSString           *picUrlString;
@property (nonatomic, retain) IBOutlet         UIImageView *imageView;
@property (nonatomic, retain) MBProgressHUD    *progressHUD;
@end
