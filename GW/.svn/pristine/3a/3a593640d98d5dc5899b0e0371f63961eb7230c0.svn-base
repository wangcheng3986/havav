//
//  FriendTabBarViewController.h
//  gratewall
//
//  Created by my on 13-4-19.
//  Copyright (c) 2013年 liutch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabViewController.h"
#import "FriendListViewController.h"
#import "AddFriendViewController.h"
#import "NICommonFormatDefine.h"
@interface FriendTabBarViewController : UITabBarController<UITabBarControllerDelegate,UINavigationBarDelegate>
{
//    IBOutlet UITabBarController *friendTabBarController;
//    IBOutlet UINavigationBar *friendListBar;
//    IBOutlet UINavigationBar *addFriendBar;
//    IBOutlet UINavigationItem *friendListItem;
//    IBOutlet UINavigationItem *addFriendItem;
//    IBOutlet UITabBarItem *friendListTabBarItem;//下方的“车友列表”TAB页切换
//    IBOutlet UITabBarItem *addFriendTabBarItem;//下方的“添加车友”TAB页切换
    IBOutlet FriendListViewController *friendController;
    IBOutlet AddFriendViewController *addfriendController;
    IBOutlet UILabel *titleLabel;
    int friendLoadType;
//    IBOutlet UITabBar *mTabBar;
    IBOutlet UIView *mDisViewUp;
    IBOutlet UIView *mDisViewDown;
    BOOL mSelectFlag;/*定义TabBarItem是否可用*/
}
@property(assign)int friendLoadType;
@property(assign)BOOL mSelectFlag;
@property(assign)HomeButton *backBtn;
//@property(nonatomic,retain)FriendListViewController *friendController;

- (void)goBack;
- (void)displayDisView;
- (void)hiddenDisView;
- (void)setFriendLoad:(int)friendLoad;
- (void)goFriendList;
- (void)goSelfDetail:(NSMutableArray *) frienddata index:(NSInteger)index;
- (void)goFriendDetail:(NSMutableArray *) frienddata index:(NSInteger)index;
- (void)showFriendList;
- (void)goFriendList:(BOOL)bShowHUD;
- (void)showBuildinTabBar;

-(void)goFriendListAndJumptoEnd:(FriendsData *)friend;
-(void)goFriendListAndJumptoNew:(NSString *)name;
@end
