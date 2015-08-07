/*!
 @header SetParaButton.m
 @abstract 设置参数按钮
 @author wangqiwei
 @version 1.00 2014/9/1 Create
 */

#import "SetParaButton.h"
#import "App.h"
#import "UIFont+Extensions.h"
@implementation SetParaButton

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
        Resources *oRes = [Resources getInstance];
        self.frame = CGRectMake(0, 0, 61, 29);
        self.contentEdgeInsets = UIEdgeInsetsMake(NAVBTN_TEXT_DOWN_LOCATION,RIGHTBTN_TEXT_LOCATION, 0, 0);
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [self setBackgroundImage:[UIImage imageNamed:@"common_navgationBar_Item_bg"] forState:UIControlStateNormal];
        [self setTitle:[oRes getText:@"Car.setParameterViewController.setParaButton"] forState:UIControlStateNormal];
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
        Resources *oRes = [Resources getInstance];
        self.frame = CGRectMake(0, 0, 61, 29);
        self.contentEdgeInsets = UIEdgeInsetsMake(NAVBTN_TEXT_DOWN_LOCATION,RIGHTBTN_TEXT_LOCATION, 0, 0);
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [self setBackgroundImage:[UIImage imageNamed:@"common_navgationBar_Item_bg"] forState:UIControlStateNormal];
        [self setTitle:[oRes getText:@"Car.setParameterViewController.setParaButton"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont navBarItemSize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        Resources *oRes = [Resources getInstance];
        self.frame = CGRectMake(0, 0, 61, 29);
        self.contentEdgeInsets = UIEdgeInsetsMake(NAVBTN_TEXT_DOWN_LOCATION,RIGHTBTN_TEXT_LOCATION, 0, 0);
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [self setBackgroundImage:[UIImage imageNamed:@"common_navgationBar_Item_bg"] forState:UIControlStateNormal];
        [self setTitle:[oRes getText:@"Car.setParameterViewController.setParaButton"] forState:UIControlStateNormal];
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
