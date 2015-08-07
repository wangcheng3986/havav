/*!
 @header UIUnderLineButton.h
 @abstract 继承UIButton
 @author Liutiecheng
 @version 1.00 14-3-26 Creation
 */

#import "UIUnderLineButton.h"
/*!
 @class
 @abstract 继承UIButton，在button文字下添加下划线
 */
@implementation UIUnderLineButton
@synthesize noLine;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*!
 @method underlinedButton
 @abstract 初始化
 @discussion 初始化
 @param 无
 @result self
 */
+ (UIUnderLineButton*) underlinedButton {
    UIUnderLineButton* button = [[UIUnderLineButton alloc] init];
    return button;
}

/*!
 @method drawRect：
 @abstract 重画，添加下划线
 @discussion 重画，添加下划线
 @param rect
 @result 无
 */
- (void) drawRect:(CGRect)rect
{
    if (noLine) {
        [super drawRect:rect];
    }
    else
    {
        CGRect textRect = self.titleLabel.frame;
        
        // need to put the line at top of descenders (negative value)
        CGFloat descender = self.titleLabel.font.descender;
        NSLog(@" descender = %f",descender);
        
        CGContextRef contextRef = UIGraphicsGetCurrentContext();
        
        // set to same colour as text
        CGContextSetStrokeColorWithColor(contextRef, self.titleLabel.textColor.CGColor);
        
        CGContextMoveToPoint(contextRef, textRect.origin.x, textRect.origin.y + textRect.size.height + descender+1);
        
        CGContextAddLineToPoint(contextRef, textRect.origin.x + textRect.size.width, textRect.origin.y + textRect.size.height + descender+1);
        
        CGContextClosePath(contextRef);
        CGContextDrawPath(contextRef, kCGPathStroke);
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
