/*!
 @header ReturnButton.m
 @abstract 返回按钮
 @author wangqiwei
 @version 1.00 2014/9/1 Create
 */
#import "ReturnButton.h"
#import "App.h"

@implementation ReturnButton

/*!
 @method initWithFrame
 @abstract 重写init方法，设置按钮背景，边距，字体大小，标题
 @discussion 重写init方法，设置按钮背景，边距，字体大小，标题
 @param frame
 @result self
 */
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        Resources *oRes = [Resources getInstance];
        self.contentEdgeInsets = UIEdgeInsetsMake(NAVBTN_TEXT_DOWN_LOCATION,BACKBTN_TEXT_LOCATION, 0, 0);
        [self setBackgroundImage:[UIImage imageNamed:@"common_back_btn"] forState:UIControlStateNormal];
        [self setTitle:[oRes getText:@"common.BackButtonTitle"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont navBarItemSize];
    }
    return self;
}

/*!
 @method init
 @abstract 重写init方法，设置按钮背景，边距，字体大小，标题
 @discussion 重写init方法，设置按钮背景，边距，字体大小，标题
 @param 无
 @result self
 */
- (id)init
{
    self = [super init];
    if (self) {
        Resources *oRes = [Resources getInstance];
        self.frame = CGRectMake(0, 0, 61, 29);
        self.contentEdgeInsets = UIEdgeInsetsMake(NAVBTN_TEXT_DOWN_LOCATION,BACKBTN_TEXT_LOCATION, 0, 0);
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [self setBackgroundImage:[UIImage imageNamed:@"common_back_btn"] forState:UIControlStateNormal];
        [self setTitle:[oRes getText:@"common.BackButtonTitle"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont navBarItemSize];
    }
    return self;
}

/*!
 @method initWithCoder
 @abstract 重写init方法，设置按钮背景，边距，字体大小，标题
 @discussion 重写init方法，设置按钮背景，边距，字体大小，标题
 @param aDecoder
 @result self
 */
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        Resources *oRes = [Resources getInstance];
        self.frame = CGRectMake(0, 0, 61, 29);
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.contentEdgeInsets = UIEdgeInsetsMake(NAVBTN_TEXT_DOWN_LOCATION,BACKBTN_TEXT_LOCATION, 0, 0);
        [self setBackgroundImage:[UIImage imageNamed:@"common_back_btn"] forState:UIControlStateNormal];
        [self setTitle:[oRes getText:@"common.BackButtonTitle"] forState:UIControlStateNormal];
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
