

/*!
 @header SelectFriendViewController.h
 @abstract 选择车友
 @author mengy
 @version 1.00 13-5-14 Creation
 */
#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "MBProgressHUD.h"
@class SendToCarViewViewController;
@interface SelectFriendViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,MBProgressHUDDelegate>
{
    IBOutlet UITableView *tableview;
    IBOutlet UILabel *titleLabel;
//    NSMutableDictionary *dictionary;
//    NSMutableDictionary *nameDictionary;
    LeftButton *backBtn;
    RightButton *finishBtn;
    NSMutableDictionary *phoneDictionary;
    NSMutableDictionary *phoneNameDictionary;
    NSMutableDictionary *nameDictionary;
    NSMutableDictionary *numDictionary;
    
    NSString         *_picUrlString;
    UIImageView      *_imageView;
    MBProgressHUD    *_progressHUD;
}

@property (nonatomic, copy) NSString           *picUrlString;
@property (nonatomic, retain) IBOutlet         UIImageView *imageView;
@property (nonatomic, assign) MBProgressHUD    *progressHUD;
@property (retain, nonatomic) NSMutableArray *dataMutableArray;
//@property (retain, nonatomic) NSMutableArray *regroupDataArray;
@property (retain, nonatomic) NSMutableArray *selectDataArray;

@property (assign, nonatomic) SendToCarViewViewController *rootController;
@end
