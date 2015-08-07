/*!
 @header BasePageControl.m
 @abstract 继承UIPageControl
 @author mengy
 @version 1.00 14-3-14 Creation
 */
#import "BasePageControl.h"
#import "App.h"
/*!
 @class
 @abstract 继承UIPageControl，替换page下面的选中和未选中图片
 */
@implementation BasePageControl
@synthesize kSpacing=_kSpacing;

/*!
 @method initWithFrame
 @abstract 重写UIPageControl初始化方法
 @discussion 重写UIPageControl初始化方法，
 @param frame 大小位置
 @result self
 */
- (id)initWithFrame:(CGRect)frame
{
    self= [super initWithFrame:frame];
    //清除颜色
    if ([self respondsToSelector:@selector(setCurrentPageIndicatorTintColor:)] && [self respondsToSelector:@selector(setPageIndicatorTintColor:)]) {
        [self setCurrentPageIndicatorTintColor:[UIColor clearColor]];
        [self setPageIndicatorTintColor:[UIColor clearColor]];
    }
    //清除背景颜色
    [self setBackgroundColor:[UIColor clearColor]];
    _activeImage= [[UIImage imageNamed:@"main_selectCar_point_red"]retain];
    _inactiveImage= [[UIImage imageNamed:@"main_selectCar_point_grey"]retain];
    _kSpacing=10.0f;
    //hold住原来pagecontroll的subview
    _usedToRetainOriginalSubview=[NSArray arrayWithArray:self.subviews];
    for (UIView *su in self.subviews) {
        [su removeFromSuperview];
    }
    self.contentMode=UIViewContentModeRedraw;
    return self;
}

/*!
 @method dealloc
 @abstract 重写dealloc方法
 @discussion 重写dealloc方法
 @param 无
 @result 无
 */
-(void)dealloc
{
    //释放原来hold住的那些subview
    _usedToRetainOriginalSubview=nil;
    if (_activeImage) {
        [_activeImage release];
        _activeImage=nil;
    }
    if (_inactiveImage) {
        [_inactiveImage release];
        _inactiveImage=nil;
        
    }
    
    [super dealloc];
}

/*!
 @method updateDots
 @abstract 修改图片
 @discussion 修改图片
 @param 无
 @result 无
 */
- (void)updateDots
{
    
    for (int i = 0; i< [self.subviews count]; i++) {
        UIImageView* dot =[self.subviews objectAtIndex:i];
        
        if (i == self.currentPage) {
            if ([dot respondsToSelector:@selector(setImage:)]) {
                dot.image=_activeImage;
            }
            
        } else {
            if ([dot respondsToSelector:@selector(setImage:)]) {
                dot.image=_inactiveImage;
            }
        }
    }
}

/*!
 @method setCurrentPage
 @abstract 重写setCurrentPage方法
 @discussion 重写setCurrentPage方法，系统版本小于ios7时，通过updateDots方法来改变图片
 @param 无
 @result 无
 */
- (void)setCurrentPage:(NSInteger)currentPage
{
    [super setCurrentPage:currentPage];
    if([App getVersion] < IOS_VER_7)
    {
        [self updateDots];
    }
    [self setNeedsDisplay];
}

/*!
 @method setNumberOfPages
 @abstract 重写setNumberOfPages方法
 @discussion 重写setNumberOfPages方法，系统版本小于ios7时，通过updateDots方法来改变图片
 @param 无
 @result 无
 */
- (void)setNumberOfPages:(NSInteger)numberOfPages
{
    [super setNumberOfPages:numberOfPages];
    if([App getVersion] < IOS_VER_7)
    {
        [self updateDots];
    }
    [self setNeedsDisplay];
    
}

/*!
 @method drawRect
 @abstract 重写drawRect方法
 @discussion 重写drawRect方法，系统版本在ios7以上时，通过这个方法来改变图片。
 @param 无
 @result 无
 */
-(void)drawRect:(CGRect)iRect
{
    if([App getVersion] >= IOS_VER_7)
    {//加个判断
        int i;
        CGRect rect;
        
        UIImage *image;
        iRect = self.bounds;
        
        if ( self.opaque ) {
            [self.backgroundColor set];
            UIRectFill( iRect );
        }
        
        if ( self.hidesForSinglePage && self.numberOfPages == 1 ) return;
        
        rect.size.height = _activeImage.size.height;
        rect.size.width = self.numberOfPages * _activeImage.size.width + ( self.numberOfPages - 1 ) * _kSpacing;
        rect.origin.x = floorf( ( iRect.size.width - rect.size.width ) / 2.0 );
        rect.origin.y = floorf( ( iRect.size.height - rect.size.height ) / 2.0 );
        rect.size.width = _activeImage.size.width;
        
        for ( i = 0; i < self.numberOfPages; ++i ) {
            image = i == self.currentPage ? _activeImage : _inactiveImage;
            
            [image drawInRect: rect];
            
            rect.origin.x += _activeImage.size.width + _kSpacing;
        }
    }
    else
    {
        
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
