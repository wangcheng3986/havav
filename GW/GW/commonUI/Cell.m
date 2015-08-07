//
//  Cell.m
//  gratewall
//
//  Created by my on 13-4-12.
//  Copyright (c) 2013年 liutch. All rights reserved.
//

#import "Cell.h"
#import "CustomCellBackground.h"

@implementation Cell

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        // change to our custom selected background view
        CustomCellBackground *backgroundView = [[CustomCellBackground alloc] initWithFrame:CGRectZero];
        self.selectedBackgroundView = backgroundView;
    }
    return self;
}

@end