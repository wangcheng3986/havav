/*!
 @header GroupCell.h
 @abstract GroupCell
 @author wangqiwei
 @version 1.00 14-9-16 Creation
 */
#import "SelectTableViewCell.h"
#import "SubCell.h"

static const int groupCellHeight = 47;
static const int subCellHeight = 40;


@interface GroupCell : SelectTableViewCell <UITableViewDataSource,UITableViewDelegate>
{
    
    
    
   
}

@property (retain, nonatomic) IBOutlet UITableView *subTableView;
@property (nonatomic,assign)int subCellNumber;
+ (int) getGroupCellHeight;

+ (int) getSubCellHeight;
- (void)getmain:(id)main;
@end
