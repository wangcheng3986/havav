//
//  NaviRoute.h
//  VW
//
//  Created by kexin on 12-7-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NetManager.h"

@class PosData;

enum NAVI_MODE
{
    NAVI_MODE_DEFAULT = 0,
    NAVI_MODE_SHORT,
    NAVI_MODE_BEST_TIME,
    NAVI_MODE_MORE_HIGHWAY,
    NAVI_MODE_LESS_HIGHWAY,
    NAVI_MODE_LESS_MONEY,
    NAVI_MODE_PARKWAY
};

@protocol NaviDelegate <NSObject>

-(void)onFinish:(NSArray*)data;
-(void)onError:(int)code;

@end

@interface NaviRoute : NSObject<NetDelegate, NSXMLParserDelegate>
{
    PosData             *mStartPos;
    PosData             *mEndPos;
    int                 mMode;
    
    id<NaviDelegate>    mDelegate;
    
    NSMutableArray      *mRouteList;
    int                 mStatus;
}

- (id)init;

- (void)setStart:(PosData*)start end:(PosData*)end;

- (void)setMode:(int)mode;

- (void)requestData:(id<NaviDelegate>)delegate;

@end
