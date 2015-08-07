//
//  leaveMessageViewController.h
//  GW
//
//  Created by wqw on 14-8-25.
//  Copyright (c) 2014年 mengy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "App.h"
#import "MBProgressHUD.h"
#import "NIRequestLocation.h"

@interface leaveMessageViewController : UIViewController<UITextViewDelegate,UIAlertViewDelegate,MBProgressHUDDelegate,NIRequestLocationDelegate>
{

    IBOutlet UILabel *_messageTitle;
    IBOutlet UILabel *_informationTips;
    IBOutlet UILabel *_information;
    IBOutlet UIImageView *_messageTitleImage;
    IBOutlet UIButton *_sendMessageButton;
    IBOutlet UITextView *_textView;
    IBOutlet UILabel *_placeHolder;
    IBOutlet UILabel *_textNumber;
    IBOutlet UILabel *_titleLabel;
    LeftButton *backBtn;
    MBProgressHUD    *_progressHUD;
    NIRequestLocation *mRequestLocation;
        FriendsData     *mfriendData;
}
@property (nonatomic, retain) MBProgressHUD    *progressHUD;
@property (nonatomic, retain) MBProgressHUD    *progressHUDMessage;
-(void)setFriendData:(FriendsData *)friendData;
-(void)setsendTocarData:(NSString *)sendTocar;
@end
