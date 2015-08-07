

/*!
 @header SendToCarViewViewController.h
 @abstract 发送到车类
 @author mengy
 @version 1.00 13-5-4 Creation
 */
#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>
#import "BaseViewController.h"
#import "SelectFriendViewController.h"
#import "NISendToCar.h"
#import "MBProgressHUD.h"
@class POIDetailViewController;
@interface SendToCarViewViewController : UIViewController<NISendToCarDelegate,UITextViewDelegate,MBProgressHUDDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIScrollViewDelegate>
{
    NISendToCar *mSendToCar;
    IBOutlet UIView *eventView;
    IBOutlet UIScrollView *eventScrollView;
    UIView *eventScrollViewBottom;
    IBOutlet UILabel *receiverLabel;
    IBOutlet UILabel *eventLabel;
    IBOutlet UITextView *receiveTextView;
    IBOutlet UILabel *receivePlaceholderLabel;
    IBOutlet UITextView *message;
    IBOutlet UILabel *messagePlaceholderLabel;
    IBOutlet UIImageView *messageBg;
    IBOutlet UIButton *addReceiverButton;
    IBOutlet UIButton *addEventButton;
    IBOutlet UIDatePicker *datePicker;
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *sendToCarLabel;
    LeftButton *cencelBtn;
    RightButton *sendBtn;
//    IBOutlet UISearchBar *searchBar;
    NSString         *_picUrlString;
    UIImageView      *_imageView;
    MBProgressHUD    *_progressHUD;
    IBOutlet UIView *mDisView;
    IBOutlet UIImageView *upBg;
    IBOutlet UIImageView *downBg;
    IBOutlet UILabel *textCountLabel;
    NSMutableDictionary *phoneDictionary;
    NSMutableDictionary *phoneNameDictionary;
    NSMutableDictionary *nameDictionary;
    NSMutableDictionary *numDictionary;
//    POIData *POI;
}
@property (nonatomic, copy) NSString           *picUrlString;
@property (nonatomic, retain) IBOutlet         UIImageView *imageView;
@property (nonatomic, retain) MBProgressHUD    *progressHUD;
@property(assign)POIDetailViewController *rootController;
@property(copy)NSMutableDictionary *phoneDictionary;
@property(copy)NSMutableDictionary *nameDictionary;
@property(copy)NSMutableDictionary *numDictionary;
@property(copy)NSMutableDictionary *phoneNameDictionary;
/*!
 @method setPOI:(POIData *)poi
 @abstract 设置poi点
 @discussion 设置poi点
 @param poi poi信息
 @result 无
 */
-(void)setPOI:(POIData *)poi;

/*!
 @method setData:(NSMutableDictionary *)PhoneDictionary phoneNameDictionary:(NSMutableDictionary *)PhoneNameDictionary nameDictionary
 @abstract 将选择车友界面的数据带回到send2car界面
 @discussion 将选择车友界面的数据带回到send2car界面
 @param PhoneDictionary nameDictionary numDictionary
 @result 无
 */
-(void)setData:(NSMutableDictionary *)PhoneDictionary phoneNameDictionary:(NSMutableDictionary *)PhoneNameDictionary nameDictionary:(NSMutableDictionary *)NameDictionary numDictionary:(NSMutableDictionary*)NumDictionary;
@end
