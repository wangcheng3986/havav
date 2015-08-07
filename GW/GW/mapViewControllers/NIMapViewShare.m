//
//  NIMapViewShare.m
//  GW
//
//  Created by wangqiwei on 14-11-26.
//  Copyright (c) 2014年 Navinfo. All rights reserved.
//

#import "NIMapViewShare.h"


static NIMapViewShare *sharedObj = nil;

@implementation NIMapViewShare{
    NIMapView* _mapView;
}


+ (NIMapViewShare*) sharedInstance:(CGRect)maprect
{
    @synchronized (self)
    {
        if (sharedObj == nil)
        {
            [[self alloc] init:maprect];
        }
    }
    return sharedObj;
}

+ (id) allocWithZone:(NSZone *)zone
{
    @synchronized (self) {
        if (sharedObj == nil) {
            sharedObj = [super allocWithZone:zone];
            return sharedObj;
        }
    }
    return nil;
}

- (id) copyWithZone:(NSZone *)zone
{
    return self;
}


- (oneway void) release
{
    [self->_mapView release];
    self->_mapView  = nil;
    [super release];
    sharedObj = nil;
}

- (id)init:(CGRect)maprect
{
    @synchronized(self) {
        [super init];
        self->_mapView = [[NIMapView alloc]initWithFrame:maprect];
        return self;
    }
}

@end


