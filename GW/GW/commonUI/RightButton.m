/*!
 @header RightButton.m
 @abstract 继承UIButton
 @author mengy
 @version 1.00 14-6-23 Creation
 */
#import "App.h"
#import "RightButton.h"
#import "UIFont+Extensions.h"
/*!
 @class
 @abstract 继承UIButton，重写导航栏右侧按钮init方法
 */
@implementation RightButton

/*!
 @method initWithFrame
 @abstract 重写init方法，设置按钮背景，边距，字体大小
 @discussion 重写init方法，设置按钮背景，边距，字体大小
 @param frame
 @result self
 */
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundImage:[UIImage imageNamed:@"common_navgationBar_Item_bg"] forState:UIControlStateNormal];
        self.contentEdgeInsets = UIEdgeInsetsMake(NAVBTN_TEXT_DOWN_LOCATION,RIGHTBTN_TEXT_LOCATION, 0, 0);
        self.titleLabel.font = [UIFont navBarItemSize];
    }
    return self;
}

/*!
 @method init
 @abstract 重写init方法，设置按钮背景，边距，字体大小
 @discussion 重写init方法，设置按钮背景，边距，字体大小
 @param 无
 @result self
 */
- (id)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, 61, 29);
        self.contentEdgeInsets = UIEdgeInsetsMake(NAVBTN_TEXT_DOWN_LOCATION,RIGHTBTN_TEXT_LOCATION, 0, 0);
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [self setBackgroundImage:[UIImage imageNamed:@"common_navgationBar_Item_bg"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont navBarItemSize];
    }
    return self;
}

/*!
 @method initWithCoder
 @abstract 重写init方法，设置按钮背景，边距，字体大小
 @discussion 重写init方法，设置按钮背景，边距，字体大小
 @param aDecoder
 @result self
 */
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.frame = CGRectMake(0, 0, 61, 29);
        self.contentEdgeInsets = UIEdgeInsetsMake(NAVBTN_TEXT_DOWN_LOCATION,RIGHTBTN_TEXT_LOCATION, 0, 0);
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [self setBackgroundImage:[UIImage imageNamed:@"common_navgationBar_Item_bg"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont navBarItemSize];
    }
    return self;
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
