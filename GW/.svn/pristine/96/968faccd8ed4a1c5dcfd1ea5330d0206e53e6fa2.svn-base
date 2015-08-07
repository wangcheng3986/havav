//
//  RouteData.m
//  VW
//
//  Created by kexin on 12-7-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RouteData.h"

#pragma mark - RoutePoint
@implementation RoutePoint

//@synthesize Point = mPoint;

@end

#pragma mark - StepData
@implementation StepData

@synthesize mStartLng,mStartLat;
@synthesize mEndLng,mEndLat;

@end

#pragma mark -
@implementation LegData

@synthesize mStep;

- (id)init
{
    self = [super init];
    if(self)
    {
        mStep = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return self;
}

- (void)dealloc
{
    [mStep release];
    [super dealloc];
}

@end

#pragma mark -
@implementation RouteData

@synthesize mLeg;
@synthesize mDetail;
@synthesize mPoints;
@synthesize mStartPos, mEndPos;

- (id)init
{
    self = [super init];
    if(self)
    {
        mLeg = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return self;
}

- (void)dealloc
{
    [mLeg release];
    [mDetail release];
    [super dealloc];
}

//- (NSArray*)encodePoints
//{
//    int Ih = [mPoints length];
//    const char *chars = mPoints.UTF8String;
//    int pb = 0;
//    NSMutableArray *ba = [NSMutableArray arrayWithCapacity:0];
//    int Ka = 0;
//    int Pa = 0;
//    while (pb < Ih)
//    {
//        int ub;
//        int oc = 0;
//        int Fa = 0;
//        do
//        {
//            ub = chars[pb++] - 63;
//            Fa |= (ub & 31) << oc;
//            oc += 5;
//        }
//        while (ub >= 32);
//        Ka = Ka + (Fa & 1 ? ~(Fa >> 1) : Fa >> 1);
//        [ba addObject:[NSNumber numberWithInt:Ka]];
//        oc = 0;
//        Fa = 0;
//        do
//        {
//            ub = chars[pb++] - 63;
//            Fa |= (ub & 31) << oc;
//            oc += 5;
//        }
//        while (ub >= 32);
//        Pa = Pa + (Fa & 1 ? ~(Fa >> 1) : Fa >> 1);
//        [ba addObject:[NSNumber numberWithInt:Pa]];
//    }
//    
//    int count = [ba count];
//    NSNumber *value;
//    double result[count];
//    for (int i = 0;i < count; ++i)
//    {
//        value = [ba objectAtIndex:i];
//        result[i] = [value intValue] * 1.0E-5;
//    }
//    
//    WGS84 w84;
//    RoutePoint *point;
//    NSMutableArray *array = [[[NSMutableArray alloc]initWithCapacity:0]autorelease];
//    for (int i = 0; i < count; i += 2)
//    {
//        point = [[RoutePoint alloc]init];
//        w84.longitude = result[i];
//        w84.latitude = result[i + 1];
//        point.Point = w84;
//        [array addObject:point];
//        [point release];
//    }
//    return array;
//}
//
@end
