/*!
 @header CustomTableViewCell.h
 @abstract 自定义TableView
 @author wangqiwei
 @version 1.00 2014/9/1 Creation
 */

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)willTransitionToState:(UITableViewCellStateMask)state
{
    NSLog(@"table view cell willTransitionToState ");
    [super willTransitionToState:state];
    if ((state & UITableViewCellStateShowingDeleteConfirmationMask) == UITableViewCellStateDefaultMask)
    {
        
        for (UIView *subview in self.subviews)
        {
            NSLog(@"=========>%@",NSStringFromClass([subview class]));
            if ([NSStringFromClass([subview class]) isEqualToString:@"UITableViewCellEditControl"])
            {
                subview.superview.backgroundColor = self.contentView.backgroundColor ;
            }
        }
    }
}


@end
