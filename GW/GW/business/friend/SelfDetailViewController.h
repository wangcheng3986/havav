//
//  SelfDetailViewController.h
//  gratewall
//
//  Created by my on 13-4-25.
//  Copyright (c) 2013年 liutch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "App.h"
#import "MBProgressHUD.h"
#import "UIMapBaseViewController.h"
#import "CustomMapView.h"
#import "NIGetLastTrack.h"

@interface SelfDetailViewController : UIMapBaseViewController<NIGetLastTrackDelegate,MBProgressHUDDelegate>
{
    NIGetLastTrack *mGetLastTrcak;
    IBOutlet UIButton *refreshButton;
    IBOutlet UIImageView *photoImageView;
    IBOutlet UILabel *nameLabel;
    IBOutlet UIView *mMapContext;
    IBOutlet UILabel *titleLabel;
    LeftButton *backBtn;
    IBOutlet UILabel *locationTitleLabel;
    IBOutlet UILabel *phoneTitleLabel;
    IBOutlet UILabel *locationLabel;
    IBOutlet UILabel *phoneLabel;
    UserData *mUserData;
    IBOutlet CustomMapView* _mapView;
    //添加单个大头针标注 可以换图片
//    NIPointAnnotation* onePoint;
//    NIAnnotationView* viewPaopao;
//    //气泡
//    NIActionPaopaoAnnotation* ppAnnotation;
}
-(void)setSex:(int)sex;
-(void)setFriendData:(FriendsData *)friendData;
@end
