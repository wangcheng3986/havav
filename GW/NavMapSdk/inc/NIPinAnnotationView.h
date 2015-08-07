/*
 *  NIPinAnnotationView.h
 *
 *  Copyright (c) 2014年 Navinfo. All rights reserved.
 *
 */

#import "NIAnnotationView.h"
enum {
    NIPinAnnotationColorPurple= 0,
    NIPinAnnotationColorRed,
    NIPinAnnotationColorGreen
};
typedef NSUInteger NIPinAnnotationColor;

///提供类似大头针效果的annotation view
@interface NIPinAnnotationView : NIAnnotationView
{
@private
    NIPinAnnotationColor _pinColor;
}

///大头针的颜色
@property (nonatomic) NIPinAnnotationColor pinColor;

@end
