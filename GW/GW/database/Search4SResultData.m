//
//  Search4SResultData.m
//  GW
//
//  Created by my on 14-9-18.
//  Copyright (c) 2014年 mengy. All rights reserved.
//

#import "Search4SResultData.h"

@implementation Search4SResultData
@synthesize mAddress;
@synthesize mBrandAgent;
@synthesize mDistance;
@synthesize mEndOpenTime;
@synthesize mID;
@synthesize mKeyID;
@synthesize mLat;
@synthesize mLevel;
@synthesize mLon;
@synthesize mName;
@synthesize mStartOpenTime;
@synthesize mtel;
- (void)dealloc
{
    if (mAddress) {
        [mAddress release];
    }
    if (mID) {
        [mID release];
    }
    if (mKeyID) {
        [mKeyID release];
    }
    if (mLat) {
        [mLat release];
    }
    if (mLon) {
        [mLon release];
    }
    if (mName) {
        [mName release];
    }
    if (mtel) {
        [mtel release];
    }
    if (mDistance) {
        [mDistance release];
    }
    if (mStartOpenTime) {
        [mStartOpenTime release];
    }
    if (mEndOpenTime) {
        [mEndOpenTime release];
    }
    if (mBrandAgent) {
        [mBrandAgent release];
    }
    if (mLevel) {
        [mLevel release];
    }
    [super dealloc];
}
@end
