//
//  EGORefreshTableHeaderView.h
//  Demo
//
//  Created by Devin Doty on 10/14/09October14.
//  Copyright 2009 enormego. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
/*!
 @header EGORefreshTableHeaderView.h
 @abstract 下拉刷新
 @author mengy
 @version 1.00 14-6-19 Creation
 */
#import <UIKit/UIKit.h>
#import "App.h"
#import <QuartzCore/QuartzCore.h>

typedef enum{
	EGOOPullRefreshPulling = 0,
	EGOOPullRefreshNormal,
	EGOOPullRefreshLoading,	
} EGOPullRefreshState;

@protocol EGORefreshTableHeaderDelegate;
@interface EGORefreshTableHeaderView : UIView {
	
	id _delegate;
	EGOPullRefreshState _state;

	//UILabel *_lastUpdatedLabel; //注释了所有和最后更新时间相关的代码。 孟磊 2013年10月17日
	UILabel *_statusLabel;
	CALayer *_arrowImage;
	UIActivityIndicatorView *_activityView;
	

}

@property(nonatomic,assign) id <EGORefreshTableHeaderDelegate> delegate;

/*!
 @method initWithFrame: arrowImageName: textColor:
 @abstract 重写init方法，设置显示效果及内容
 @discussion 重写init方法，设置显示效果及内容
 @param frame；arrowImageName； textColor
 @result self
 */
- (id)initWithFrame:(CGRect)frame arrowImageName:(NSString *)arrow textColor:(UIColor *)textColor;

/*!
 @method refreshLastUpdatedDate
 @abstract 刷新更新时间
 @discussion 刷新更新时间
 @param 无
 @result 无
 */
- (void)refreshLastUpdatedDate;

/*!
 @method egoRefreshScrollViewDidScroll：
 @abstract 改变scrollView位置
 @discussion 改变scrollView位置
 @param scrollView
 @result 无
 */
- (void)egoRefreshScrollViewDidScroll:(UIScrollView *)scrollView;

/*!
 @method egoRefreshScrollViewDidEndDragging：
 @abstract 结束拖拽执行方法
 @discussion 结束拖拽执行方法
 @param scrollView
 @result 无
 */
- (void)egoRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView;

/*!
 @method egoRefreshScrollViewDataSourceDidFinishedLoading：
 @abstract 完成加载执行方法
 @discussion 完成加载执行方法
 @param scrollView
 @result 无
 */
- (void)egoRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView;

@end
/*!
 @protocol
 @abstract EGORefreshTableHeaderDelegate类的一个protocol
 @discussion 加载数据回调方法，时间更新，返回加载状态
 */
@protocol EGORefreshTableHeaderDelegate

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view;
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view;
@optional
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view;
@end
