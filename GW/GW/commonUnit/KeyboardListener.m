//
//  KeyboardListener.m
//  VW
//
//  Created by kexin on 12-6-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "KeyboardListener.h"

@implementation KeyboardListener

/*!
 @method initWithView:
 @abstract 初始化
 @discussion 初始化
 @param view
 @result self
 */
- (id)initWithView:(UIView*)view
{
    mView = view;
    mHasOpen = NO;
    mDelegate = nil;
    return [self init];
}

/*!
 @method dealloc:
 @abstract 释放内存
 @discussion 释放内存
 @param 无
 @result 无
 */
- (void)dealloc
{
    [super dealloc];
}

/*!
 @method enable
 @abstract 设置键盘监听事件
 @discussion 设置键盘监听事件
 @param 无
 @result 无
 */
- (void)enable
{
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                                selector:@selector(keyboardWillShow:) 
                                                name:UIKeyboardWillShowNotification 
                                                object:nil]; 
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                                selector:@selector(keyboardWillHide:) 
                                                name:UIKeyboardWillHideNotification 
                                                object:nil]; 
    
    //NSLog(@"----enable");
}


/*!
 @method disable
 @abstract 取消键盘监听事件
 @discussion 取消键盘监听事件
 @param 无
 @result 无
 */
- (void)disable
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                name:UIKeyboardWillShowNotification 
                                                object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                name:UIKeyboardWillHideNotification 
                                                object:nil];
    
    //NSLog(@"----disable");
}


/*!
 @method setDelegate:
 @abstract 设置代理
 @discussion 设置代理
 @param delegate
 @result 无
 */
- (void)setDelegate:(id<KeyboardDelegate>)delegate
{
    mDelegate = delegate;
}


/*!
 @method keyboardWillShow:
 @abstract 键盘弹出时调用方法
 @discussion 改变view位置
 @param notification 键盘弹出通知（包括键盘高度等）
 @result 无
 */
- (void)keyboardWillShow:(NSNotification*)notification
{
    if(!mHasOpen)
    {
        NSDictionary* info = [notification userInfo]; 
    
        NSValue* value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey]; 
        CGSize keyboardRect = [value CGRectValue].size;
    
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2];
        
        CGRect rect = CGRectMake(0.0f, 
                             mView.frame.origin.y - keyboardRect.height, 
                             mView.frame.size.width, 
                             mView.frame.size.height); 
    
        mView.frame = rect;
        if(mDelegate)
        {
            [mDelegate onKeyboardShow:mView offset:keyboardRect.height];
        }
        [UIView commitAnimations];
        
        mHasOpen = YES;
    }
}


/*!
 @method keyboardWillHide:
 @abstract 键盘弹回时调用方法
 @discussion 改变view位置
 @param notification 键盘弹出通知
 @result 无
 */
- (void)keyboardWillHide:(NSNotification*)notification
{
    if(mHasOpen)
    {
        NSDictionary* info = [notification userInfo]; 
    
        NSValue* value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey]; 
        CGSize keyboardRect = [value CGRectValue].size;
    
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2];
    
        CGRect rect = CGRectMake(0.0f, 
                             mView.frame.origin.y + keyboardRect.height, 
                             mView.frame.size.width, 
                             mView.frame.size.height); 
    
        mView.frame = rect;
        [mDelegate onKeyboardHide:mView offset:keyboardRect.height];
        [UIView commitAnimations];

        mHasOpen = NO;
    }
}

@end
