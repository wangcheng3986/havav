//
//  MapPoiData.m
//  GW
//
//  Created by my on 14/11/28.
//  Copyright (c) 2014年 Navinfo. All rights reserved.
//

#import "MapPoiData.h"

@implementation MapPoiData
@synthesize mID;
@synthesize mAddress;
@synthesize mImageName;
@synthesize coordinate;
@synthesize mName;


-(void)dealloc
{
    [mAddress release];
    [mImageName release];
    [mName release];
    [super dealloc];
}


-(MapPoiData *)initWithID:(NSInteger )poiID
{
    self = [super init];
    if (self)
    {
        mID = poiID;
        
    }
    return self;
}


@end

