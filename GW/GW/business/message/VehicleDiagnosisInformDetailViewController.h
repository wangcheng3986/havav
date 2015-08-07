/*!
 @header VehicleDiagnosisViewController.h
 @abstract 车辆在线诊断主控界面
 @author wangqiwei
 @version 1.00 2014/9/1 Create
 */
#import <UIKit/UIKit.h>
#import "GroupCell.h"
#import "SubCell.h"
#import "SelectTableViewCell.h"
#import "MBProgressHUD.h"
#import "App.h"
@interface VehicleDiagnosisInformDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>
{
    IBOutlet UIImageView *headerBG;
   
    IBOutlet UIImageView *headerIcon;

    IBOutlet UITableView *AllTableView;
    
    
    IBOutlet UILabel *DiagnosisTimeTitle;
    
    IBOutlet UILabel *DiagnosisNumTitle;
    
    IBOutlet UILabel *DiagnosisTimeContent;
    
    
    IBOutlet UILabel *DiagnosisNumContent;

   // NSMutableDictionary *_subContentDic;
    
    IBOutlet UIImageView *DiagnosisFailureBG;

    IBOutlet UIImageView *DiagnosisFailureCarBG;
    IBOutlet UIView *footView;
    IBOutlet UIImageView *DiagnosisFailureTextBG;
    
    IBOutlet UIImageView *DiagnosisFailureLeftIcon;
    IBOutlet UILabel *DiagnosisTextFailureOrNull;
    
    
    IBOutlet UILabel *titleLabel;
    
    LeftButton *backBtn;
}
@property (assign) IBOutlet GroupCell *groupCell;
@property (nonatomic,retain) NSMutableArray *titleArray;
@property (nonatomic,retain) NSArray *subTitleArray;
@property (nonatomic,retain) NSMutableDictionary *subContentDic;
@property (nonatomic,retain) NSMutableDictionary *expandedIndexes;
@property (nonatomic,retain) NSMutableDictionary *subCellNumInGroup;
@property (nonatomic,retain) NSMutableArray *diagnosisDataAll;
@property (nonatomic, retain) MBProgressHUD    *progressHUD;
@property (nonatomic,retain) NSMutableArray *subdiagnosisDataTemp;


@property (nonatomic,retain) NSString *messageKeyID;


//+ (id)getInstance;
- (void)sendrequest;

- (SubCell *)item:(GroupCell *)groupCell setSubItem:(SubCell *)subCell forRowAtIndexPath:(NSIndexPath *)indexPath;


/*!
 @method setKeyID:(NSString *)keyid
 @abstract 设置keyid
 @discussion 设置keyid
 @param keyid
 @result 无
 */
-(void)setKeyID:(NSString *)keyid;

@end
