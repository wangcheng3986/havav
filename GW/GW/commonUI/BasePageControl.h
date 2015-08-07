
/*!
 @header BasePageControl.h
 @abstract 继承UIPageControl
 @author mengy
 @version 1.00 14-3-14 Creation
 */
#import <UIKit/UIKit.h>
/*!
 @class
 @abstract 继承UIPageControl，替换page下面的选中和未选中图片
 */
@interface BasePageControl : UIPageControl
{
    UIImage *_activeImage;
    UIImage *_inactiveImage;
    NSArray *_usedToRetainOriginalSubview;
}
@property (nonatomic, assign) CGFloat kSpacing;
@end
