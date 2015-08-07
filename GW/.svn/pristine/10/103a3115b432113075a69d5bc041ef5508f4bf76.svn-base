/*!
 @header CustomCellBackground.m
 @abstract 继承UIView
 @author mengy
 @version 1.00 13-4-12 Creation
 */

#import "CustomCellBackground.h"
/*!
 @class
 @abstract 继承UIView，设置cell的Background
 */
@implementation CustomCellBackground
/*!
 @method drawRect:
 @abstract 重画
 @discussion 重画
 @param rect
 @result 无
 */
- (void)drawRect:(CGRect)rect
{
    // draw a rounded rect bezier path filled with blue
    CGContextRef aRef = UIGraphicsGetCurrentContext();
    CGContextSaveGState(aRef);
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:5.0f];
    [bezierPath setLineWidth:5.0f];
    [[UIColor blackColor] setStroke];
    
    UIColor *fillColor = [UIColor colorWithRed:0.529 green:0.808 blue:0.922 alpha:1]; // color equivalent is #87ceeb
    [fillColor setFill];
    
    [bezierPath stroke];
    [bezierPath fill];
    CGContextRestoreGState(aRef);
}

@end