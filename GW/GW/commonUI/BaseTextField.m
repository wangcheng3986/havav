/*!
 @header BaseTextField.h
 @abstract 继承UITextField
 @author mengy
 @version 1.00 14-2-28 Creation
 */

#import "BaseTextField.h"
#import "App.h"

/*!
 @class
 @abstract 继承UITextField，改变Placeholder字体颜色和大小
 */
@implementation BaseTextField

/*!
 @method drawPlaceholderInRect
 @abstract 重写drawPlaceholderInRect方法
 @discussion 重写drawPlaceholderInRect方法，主要是ios7下改变Placeholder字体颜色，和位置
 @param rect
 @result 无
 */
- (void)drawPlaceholderInRect:(CGRect)rect{
//    设置Placeholder颜色
    if (self.tag == Add_Friend_View_NameTextField_tag || self.tag == Add_Friend_View_PhoneTextField_tag) {
        if([App getVersion] >= IOS_VER_7)
        {
            //modify by wangqiwei for change Color of Placeholder at 2014 5 19
            UIColor *placeholderColor = [UIColor colorWithRed:132.0/255.0f green:132.0/255.0f blue:132.0/255.0f alpha:1];//设置颜色
            [placeholderColor setFill];
            
            CGRect placeholderRect = CGRectMake(rect.origin.x+2, (rect.size.height- self.font.pointSize)/2, rect.size.width, self.font.pointSize+1);//设置距离
            
            NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
            style.lineBreakMode = NSLineBreakByTruncatingTail;
            style.alignment = self.textAlignment;
            NSDictionary *attr = [NSDictionary dictionaryWithObjectsAndKeys:style,NSParagraphStyleAttributeName, self.font, NSFontAttributeName, placeholderColor, NSForegroundColorAttributeName, nil];
            [self.placeholder drawInRect:placeholderRect withAttributes:attr];
        }
        else
        {
           [super drawPlaceholderInRect:rect];

        }
    }
    else
    {
         [super drawPlaceholderInRect:rect];
    }
    
}

@end
