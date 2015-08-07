/*!
 @header UIControl+UIControlExtend.m
 @abstract 按钮不可同时点击
 @author mengy
 @version 1.00 14-6-19 Creation
 */

#import "UIControl+UIControlExtend.h"
/*!
 @class
 @abstract UIControl扩展类
 */
@implementation UIControl (UIControlExtend)
/*!
 @method init
 @abstract 重写UIControl初始化方法
 @discussion 重写UIControl初始化方法，添加不可同时点多个按钮
 @param 无
 @result self
 */
- (id)init
{
    self = [super init];
    if (self) {
        self.exclusiveTouch = YES;
    }
    return self;
}

/*!
 @method initWithCoder
 @abstract 重写UIControl初始化方法
 @discussion 重写UIControl初始化方法，添加不可同时点多个按钮
 @param aDecoder
 @result self
 */
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.exclusiveTouch = YES;
    }
    return self;
}

/*!
 @method initWithFrame
 @abstract 重写UIControl初始化方法
 @discussion 重写UIControl初始化方法，添加不可同时点多个按钮
 @param frame 大小位置
 @result self
 */
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.exclusiveTouch = YES;
    }
    return self;
}

@end
