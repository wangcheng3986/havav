/*!
 @header SelectTableViewCell.h
 @abstract SelectTableViewCell
 @author wangqiwei
 @version 1.00 14-9-16 Creation
 */
#import <UIKit/UIKit.h>
@class VehicleDiagnosisViewController;
typedef NS_ENUM(NSInteger, SelectableCellState)
{
    Unchecked = 0,
    Checked,
    Halfchecked,
};


@interface SelectTableViewCell : UITableViewCell
{
  //  VehicleDiagnosisViewController* vehicleDiagnosisView;
    id vehicleDiagnosisView;
}
@property (retain, nonatomic) IBOutlet UILabel *groupCellTitle;
@property (retain, nonatomic) IBOutlet UILabel *groupCellFaultNum;
@property (retain, nonatomic) IBOutlet UIImageView *expandedImage;
@property (retain, nonatomic) IBOutlet UILabel *subCellTitle;
@property (retain, nonatomic) IBOutlet UILabel *subCellContent;

@property (nonatomic) SelectableCellState selectableCellState;

@end
