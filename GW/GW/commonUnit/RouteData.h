//
//  RouteData.h
//  VW
//
//  Created by kexin on 12-7-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PosData;


@interface RoutePoint : NSObject
{
   // WGS84   mPoint;
}
//@property(assign)WGS84 Point;

@end

@interface StepData : NSObject
{
    double      mStartLng;
    double      mStartLat;
    double      mEndLng;
    double      mEndLat;
}

@property(assign)double mStartLng;
@property(assign)double mStartLat;
@property(assign)double mEndLng;
@property(assign)double mEndLat;

@end

@interface LegData : NSObject
{
    NSMutableArray      *mStep;
}

@property(readonly)NSMutableArray *mStep;

@end


#pragma mark -
@interface RouteData : NSObject
{
    NSMutableArray      *mLeg;
    NSString            *mDetail;
    NSString            *mPoints;
    
    PosData             *mStartPos;
    PosData             *mEndPos;
}

@property(readonly)NSMutableArray *mLeg;
@property(retain)NSString *mDetail;
@property(retain)NSString *mPoints;
@property(retain)PosData *mStartPos;
@property(retain)PosData *mEndPos;

- (NSArray*)encodePoints;

@end
