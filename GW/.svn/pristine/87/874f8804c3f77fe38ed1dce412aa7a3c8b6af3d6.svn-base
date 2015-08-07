/*!
 @header GroupCell.h
 @abstract GroupCell
 @author wangqiwei
 @version 1.00 14-9-16 Creation
 */
#import "GroupCell.h"
#import "VehicleDiagnosisViewController.h"
@implementation GroupCell

+ (int) getGroupCellHeight
{
    return groupCellHeight;
}

+ (int) getSubCellHeight
{
    return subCellHeight;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    if((self = [super initWithCoder:aDecoder]))
    {
//        if (vehicleDiagnosisView == nil) {
//            vehicleDiagnosisView = [VehicleDiagnosisViewController getInstance];
//        }
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)getmain:(id)main
{
    vehicleDiagnosisView = main;
}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return _subCellNumber;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* identifier = @"SubCell";
    SubCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SubCell" owner:self options:nil]lastObject];
    }
    cell = [vehicleDiagnosisView item:self setSubItem:cell forRowAtIndexPath:indexPath];
    
    return  cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return subCellHeight;
}




- (void)dealloc {
    [_subTableView release];
    [super dealloc];
}
@end
