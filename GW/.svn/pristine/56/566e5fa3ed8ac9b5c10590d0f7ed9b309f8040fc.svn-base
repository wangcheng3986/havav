//
//  FriendDetailViewController.h
//  gratewall
//
//  Created by my on 13-4-20.
//  Copyright (c) 2013年 liutch. All rights reserved.
//
enum SYNC_TYPE
{
    SYNC_YES=1,
    SYNC_NO=0
};
#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "NIUpdateContacts.h"
#import "NIRequestLocation.h"
#import "MBProgressHUD.h"
#import "FriendTabBarViewController.h"
#import "NIDeleteContacts.h"
#import "BaseTextField.h"
#import "UIMapBaseViewController.h"
#import "CustomMapView.h"
@interface FriendDetailViewController : UIMapBaseViewController<NIUpdateContactsDelegate,NIRequestLocationDelegate,MBProgressHUDDelegate,UITextViewDelegate,UIAlertViewDelegate,UIActionSheetDelegate,NIDeleteContactsDelegate,UITextFieldDelegate>
{
    IBOutlet UIImageView *photoImageView;
    IBOutlet UILabel *nameLabel;
    IBOutlet UIButton *siteRequestButton;
    IBOutlet UILabel *synchroLabel;
    IBOutlet UIButton *checkVehicleButton;
    IBOutlet UILabel *lastLocationLabel;
    IBOutlet UILabel *locatinLabel;
    IBOutlet UILabel *timeLabel;
    IBOutlet UILabel *mPhoneNumberLabel;
    LeftButton *BackBtn;
    RightButton *editBtn;
    IBOutlet UIButton *mCallBtn;
    IBOutlet UILabel *titleLabel;
    IBOutlet UIImageView *friendOtherViewBg;
    
    
    IBOutlet UIButton *remarkBtn;
    
    IBOutlet UIView *remarkView;
    IBOutlet UILabel *remarkViewTitle;
    IBOutlet  UITextField*remarkViewTextField;
    IBOutlet UIButton *remarkViewCancelBtn;
    IBOutlet UIButton *remarkViewAffirmBtn;
    IBOutlet UILabel *remarkBtnTitleLabel;
    IBOutlet UILabel *callBtnTitleLabel;
    
    
    IBOutlet UIView *mDisView;

    IBOutlet UITextView *nameTextView ;
    NIDeleteContacts *mDeleteContacts;
    NIUpdateContacts *mUpdateContacts;
    NIRequestLocation *mRequestLocation;
    MBProgressHUD    *_progressHUD;
    
    FriendsData     *mfriendData;
    IBOutlet CustomMapView* _mapView;
    //添加单个大头针标注 可以换图片
//    NIPointAnnotation* onePoint;
//    NIAnnotationView* viewPaopao;
//    //气泡
//    NIActionPaopaoAnnotation* ppAnnotation;
}

@property (nonatomic, retain) MBProgressHUD    *progressHUD;
@property (assign, nonatomic) FriendTabBarViewController *rootController;

@property (nonatomic, retain) FriendsData     *mfriendData;
-(void)setFriendData:(FriendsData *)friendData;
@end
