
/*!
 @header CustomBackItem.m
 @abstract 继承UIBarButtonItem
 @author mengy
 @version 1.00 12-8-15 Creation
 */

#import "CustomBackItem.h"
/*!
 @class
 @abstract 继承UIBarButtonItem，返回按钮
 */
@implementation CustomBackItem

/*!
 @method initWithTitle: target: action:
 @abstract 重写init方法，设置按钮背景，标题，按钮大小，方法
 @discussion 重写init方法，设置按钮背景，标题，按钮大小，方法
 @param title；target； action 方法
 @result self
 */
- (id)initWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
//    UIFont *font = [UIFont fontWithName:VW_FONT_BOLD size:12];
    NSString *text = [NSString stringWithFormat:@"   %@", title];
    int width = 40;//[text sizeWithFont:font].width + 15;
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, width, 30)];
//    button.titleLabel.font = font;
    [button setTitle:text forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"backItem"] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    self = [super initWithCustomView:button];
    if(self)
    {
    }
    [button release];
    return self;
}

@end
