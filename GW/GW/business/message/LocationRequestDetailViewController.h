
/*!
 @header LocationRequestDetailViewController.h
 @abstract 位置请求消息类
 @author mengy
 @version 1.00 13-5-2 Creation
 */
#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "NICommonFormatDefine.h"
#import "FriendLocationData.h"
#import "NIResponseLocation.h"
#import "NICreateBlack.h"
#import "MBProgressHUD.h"
#import "NICreateContacts.h"
@interface LocationRequestDetailViewController : UIViewController<NIResponseLocationDelegate,NICreateBlackDelegate,MBProgressHUDDelegate,NICreateContactsDelegate,UITextFieldDelegate>
{
    NICreateContacts *mCreateContacts;
    NICreateBlack *mCreateBlack;
    IBOutlet UILabel *titleLabel;
    IBOutlet UIView *messageView;
    IBOutlet UILabel *senderLabel;
    IBOutlet UILabel *timeLabel;
    IBOutlet UITextView *messageTextView;
    IBOutlet UITextView *descTextView;
    IBOutlet UILabel *descTitleLabel;
    IBOutlet UIView *descView;
    IBOutlet UILabel *agreeLabel;
    IBOutlet UIButton *agreeButton;
    IBOutlet UIImageView *agreeIcon;
    IBOutlet UILabel *addFriendLabel;
    IBOutlet UIButton *addFriendButton;
    IBOutlet UIButton *addBlackListButton;
    IBOutlet UILabel *addBlackListLabel;
    IBOutlet UILabel *resultLabel;
    IBOutlet UIImageView *backgroundBottom;
    
    IBOutlet UIView *mDisView;
    IBOutlet UIView *remarkView;
    IBOutlet UILabel *remarkViewTitle;
    IBOutlet  UITextField*remarkViewTextField;
    IBOutlet UIButton *remarkViewCancelBtn;
    IBOutlet UIButton *remarkViewAffirmBtn;

    NIResponseLocation *mRespLocation;
    
    NSString *fName;
    
    NSString         *_picUrlString;
    UIImageView      *_imageView;
    MBProgressHUD    *_progressHUD;
    LeftButton *backBtn;
    
    
}

@property (nonatomic, retain)FriendLocationData *mData;
@property (nonatomic, copy) NSString * fName;
@property (nonatomic, copy) NSString           *picUrlString;
@property (nonatomic, retain) IBOutlet         UIImageView *imageView;
@property (nonatomic, retain) MBProgressHUD    *progressHUD;
/*!
 @method setKeyID:(NSString *)keyid
 @abstract 设置keyid
 @discussion 设置keyid
 @param keyid
 @result 无
 */
-(void)setKeyID:(NSString *)keyid;

@end
