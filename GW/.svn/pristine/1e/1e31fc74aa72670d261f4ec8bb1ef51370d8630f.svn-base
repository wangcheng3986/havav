
/***********************************
 * 版权所有：北京四维图新科技股份有限公司
 * 文件名称：AddFriendViewController.h
 * 文件标识：
 * 内容摘要：添加车友
 * 其他说明：
 * 当前版本：
 * 作    者：刘铁成，王立琼
 * 完成日期：2013-08-25
 * 修改记录1：
 *	修改日期：2013-08-28
 *	版 本 号：
 *	修 改 人：孟磊
 *	修改内容：取消添加车友后，重置窗体输入框
 *          从通讯录添加车友时，同步了0个联系人仍提示，直接提示不启动远程请求。
 *          
 **************************************/


#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "NICreateContacts.h"
#import "NICommonFormatDefine.h"
#import "MBProgressHUD.h"
#import "BaseTextField.h"
#import "NoCopyTextField.h"
@class FriendTabBarViewController;
@class FriendListViewController;
@interface AddFriendViewController : UIViewController<NICreateContactsDelegate, MBProgressHUDDelegate,UITextFieldDelegate>
{
    NICreateContacts *mCreateContacts;
    
    IBOutlet UIButton *inputFriendButton;
    IBOutlet UIButton *syncContactsButton;
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *phoneNumberLabel;
//    IBOutlet UILabel *addressLabel;
    IBOutlet BaseTextField *nameTextField;
    IBOutlet BaseTextField *phoneNumberTextField;
//    IBOutlet UITextField *addressTextField;
    IBOutlet UIButton *cencelButton;
    IBOutlet UIButton *confirmButton;
    IBOutlet UIView *addFriendView;
    IBOutlet UILabel *titleLabel;
    IBOutlet UIView *mDisView;
    IBOutlet UILabel *syncTextLabel;
    IBOutlet UILabel *syncTitleLabel;
    IBOutlet UILabel *addFriendTextLabel;
    IBOutlet UILabel *addFriendTitleLabel;
    
    
    NSString         *_picUrlString;
    UIImageView      *_imageView;
    MBProgressHUD    *_progressHUD;
    
    BOOL _showProgressHUD;
    
    
}

@property (nonatomic, copy) NSString           *picUrlString;
@property (nonatomic, retain) IBOutlet         UIImageView *imageView;
@property (nonatomic, retain) MBProgressHUD    *progressHUD;
@property (assign, nonatomic) FriendTabBarViewController *rootController;

@property (nonatomic,assign) FriendListViewController    *friendListController;

@property BOOL showProgressHUD;


@end
