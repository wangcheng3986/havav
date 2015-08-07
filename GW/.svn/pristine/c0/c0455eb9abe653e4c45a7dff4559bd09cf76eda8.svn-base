/*!
 @header SelectTableViewCell.h
 @abstract commmon class
 @author wangqiwei
 @version 1.00 14-9-16 Creation
 */
#import "SelectTableViewCell.h"

@implementation SelectTableViewCell



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectableCellState = Unchecked;
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (SelectableCellState) toggleCheck
{
    if (self.selectableCellState == Checked)
    {
        self.selectableCellState = Unchecked;
    }
    else
    {
        self.selectableCellState = Checked;

    }
    return self.selectableCellState;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) check
{
    self.selectableCellState = Checked;
}

- (void) uncheck
{
    self.selectableCellState = Unchecked;
}

- (void) halfCheck
{
    self.selectableCellState = Halfchecked;
}

- (void)dealloc {

    [_groupCellTitle release];
    [_groupCellFaultNum release];
    [_expandedImage release];
    [_subCellTitle release];
    [_subCellContent release];
    [super dealloc];
}
@end
