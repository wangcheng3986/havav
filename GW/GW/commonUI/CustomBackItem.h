/*!
 @header CustomBackItem.h
 @abstract 继承UIBarButtonItem
 @author mengy
 @version 1.00 12-8-15 Creation
 */

#import <UIKit/UIKit.h>

/*!
 @class
 @abstract 继承UIBarButtonItem，返回按钮
 */
@interface CustomBackItem : UIBarButtonItem
{
    
}

/*!
 @method initWithTitle: target: action:
 @abstract 重写init方法，设置按钮背景，边距，字体大小，标题
 @discussion 重写init方法，设置按钮背景，边距，字体大小，标题
 @param frame
 @result self
 */
- (id)initWithTitle:(NSString *)title target:(id)target action:(SEL)action;

@end
