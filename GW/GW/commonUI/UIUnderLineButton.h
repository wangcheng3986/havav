
/*!
 @header UIUnderLineButton.h
 @abstract 继承UIButton
 @author Liutiecheng
 @version 1.00 14-3-26 Creation
 */

#import <UIKit/UIKit.h>
/*!
 @class
 @abstract 继承UIButton，在button文字下添加下划线
 */
@interface UIUnderLineButton : UIButton
{
    BOOL noLine;
}
@property (nonatomic,assign)BOOL noLine;
/*!
 @method underlinedButton
 @abstract 初始化
 @discussion 初始化
 @param 无
 @result self
 */
+ (UIUnderLineButton *) underlinedButton; 

@end
