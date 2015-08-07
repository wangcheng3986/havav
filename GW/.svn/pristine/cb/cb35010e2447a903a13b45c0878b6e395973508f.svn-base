//
//  NaviRoute.m
//  VW
//
//  Created by kexin on 12-7-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NaviRoute.h"
#import "AppInfo.h"
#import "RouteData.h"

#import "GHNSString+HMAC.h"
#import "PosData.h"


#define NAVI_USER_ID    @"testuser" 
#define NAVINFO_CODE    @"navinfo"

enum STATUS
{
    STATUS_NONE = 0,
    STATUS_STATUS,
    STATUS_SUMMARY,
    STATUS_POINTS,
    STATUS_STEP,
    STATUS_STEP_START,
    STATUS_STEP_END,
    STATUS_STEP_START_LON,
    STATUS_STEP_START_LAT,
    STATUS_STEP_END_LON,
    STATUS_STEP_END_LAT,
};

@implementation NaviRoute

- (id)init
{
    self = [super init];
    if(self)
    {
        mDelegate = nil;
        mMode = NAVI_MODE_DEFAULT;
        
        mRouteList = nil;
        mStartPos = nil;
        mEndPos = nil;
    }
    return self;
}

- (void)dealloc
{
    [mRouteList release];
    [mStartPos release];
    [mEndPos release];
    [super dealloc];
}

- (void)setStart:(PosData*)start end:(PosData*)end
{
    [mStartPos release];
    [mEndPos release];
    mStartPos = [start retain];
    mEndPos = [end retain];
}

- (void)setMode:(int)mode
{
    mMode = mode;
}

- (void)requestData:(id<NaviDelegate>)delegate
{NSLog(@"---->%f,%f:%f,%f",mStartPos.mLng,mStartPos.mLat,mEndPos.mLng,mEndPos.mLat);
    mDelegate = [delegate retain];
    NSString *params = [self encoder:[NSString stringWithFormat:@"waypoints=%f,%f;%f,%f&mode=%d&output=xml&userid=%@",mStartPos.mLng,mStartPos.mLat,mEndPos.mLng,mEndPos.mLat,mMode,NAVI_USER_ID]];

    NSString *code = [params gh_HMACSHA1:NAVINFO_CODE];
    code = [code stringByReplacingOccurrencesOfString:@"+" withString:@"-"];
    code = [code stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    
    NSString *url = [NSString stringWithFormat:@"%@?%@&key=%@", ROUTE_URL,params,code];
    NSLog(@"++>%@",url);
    
    NetManager *net = [[NetManager alloc]initWithString:url];
    [net requestWithAsynchronous:self];
    [net release];
}

- (NSString*)encoder:(NSString*)text
{  
    NSString *outputStr = (NSString *)  
    CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,  
                                            (CFStringRef)text,  
                                            NULL,  
                                            (CFStringRef)@",;",  
                                            kCFStringEncodingUTF8);  
    return outputStr;  
}  

- (void)onFinish:(NSData*)data
{
    if(mRouteList)
    {
        [mRouteList release];
    }
    mRouteList = [[NSMutableArray alloc]initWithCapacity:0];
    
    if(data)
    {
        NSXMLParser *oParser = [[[NSXMLParser alloc]initWithData:data]autorelease];
        [oParser setDelegate:self];
        [oParser parse];
    }
    [data release];
    
    //[mDelegate onFinish:data];
    //NSString *text = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    //NSLog(@"==>%@",text);
    //[text release];
}

- (void)onError:(int)code
{
    [mDelegate onError:code];
}

- (void)onCancel
{
    
}

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    mStatus = STATUS_NONE;NSLog(@"start parser");
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    mStatus = STATUS_NONE;NSLog(@"stop parser");
    
    RouteData *route;
    for(int i = 0;i < [mRouteList count];++i)
    {
        route = [mRouteList objectAtIndex:i];
        route.mStartPos = mStartPos;
        route.mEndPos = mEndPos;
    }
    
    [mDelegate onFinish:mRouteList];
    [mDelegate release];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
    if([elementName isEqualToString:@"Result"])
    {
        
    }
    else if([elementName isEqualToString:@"status"])
    {
        mStatus = STATUS_STATUS;
    }
    else if([elementName isEqualToString:@"route"])
    {
        RouteData *route = [[RouteData alloc]init];
        [mRouteList addObject:route];
        [route release];
    }
    else if([elementName isEqualToString:@"summary"])
    {
        mStatus = STATUS_SUMMARY;
    }
    else if([elementName isEqualToString:@"points"])
    {
        mStatus = STATUS_POINTS;
    }
    else if([elementName isEqualToString:@"leg"])
    {
        RouteData *route = [mRouteList lastObject];
        
        LegData *leg = [[LegData alloc]init];
        [route.mLeg addObject:leg];
        [leg release];
    }
    else if([elementName isEqualToString:@"step"])
    {
        mStatus = STATUS_STEP;
        RouteData *route = [mRouteList lastObject];
        LegData *leg = [route.mLeg lastObject];
        
        StepData *step = [[StepData alloc]init];
        [leg.mStep addObject:step];
        [step release];
    }
    else if([elementName isEqualToString:@"start"])
    {
        mStatus = STATUS_STEP_START;
    }
    else if([elementName isEqualToString:@"end"])
    {
        mStatus = STATUS_STEP_END;
    }
    else if([elementName isEqualToString:@"lon"])
    {
        if(mStatus == STATUS_STEP_START)
        {
            mStatus = STATUS_STEP_START_LON;
        }
        else if(mStatus == STATUS_STEP_END)
        {
            mStatus = STATUS_STEP_END_LON;
        }
    }
    else if([elementName isEqualToString:@"lat"])
    {
        if(mStatus == STATUS_STEP_START)
        {
            mStatus = STATUS_STEP_START_LAT;
        }
        else if(mStatus == STATUS_STEP_END)
        {
            mStatus = STATUS_STEP_END_LAT;
        }
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([elementName isEqualToString:@"lon"])
    {
        if(mStatus == STATUS_STEP_START_LON)
        {
            mStatus = STATUS_STEP_START;
        }
        else if(mStatus == STATUS_STEP_END_LON)
        {
            mStatus = STATUS_STEP_END;
        }
    }
    else if([elementName isEqualToString:@"lat"])
    {
        if(mStatus == STATUS_STEP_START_LAT)
        {
            mStatus = STATUS_STEP_START;
        }
        else if(mStatus == STATUS_STEP_END_LAT)
        {
            mStatus = STATUS_STEP_END;
        }
    }
    else if([elementName isEqualToString:@"summary"] ||
            [elementName isEqualToString:@"start"] ||
            [elementName isEqualToString:@"end"] ||
            [elementName isEqualToString:@"status"] ||
            [elementName isEqualToString:@"points"])
    {
        mStatus = STATUS_NONE;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    RouteData *route = [mRouteList lastObject];
    LegData *leg = [route.mLeg lastObject];
    StepData *step = [leg.mStep lastObject];
    
    switch(mStatus)
    {
        case STATUS_STEP_START_LON:
            step.mStartLng = [string doubleValue];
            break;
        case STATUS_STEP_START_LAT:
            step.mStartLat = [string doubleValue];
            break;
        case STATUS_STEP_END_LON:
            step.mEndLng = [string doubleValue];
            break;
        case STATUS_STEP_END_LAT:
            step.mEndLat = [string doubleValue];
            break;
        case STATUS_SUMMARY:
            {
                NSRange range = [string rangeOfString:@"Dist"];
                if(range.location != NSNotFound)
                {
                    route.mDetail = [string substringFromIndex:range.location];
                }
                else
                {
                    route.mDetail = string;
                }
                route.mDetail = [route.mDetail stringByReplacingOccurrencesOfString:@"=" withString:@":"];
            }
            break;
        case STATUS_POINTS:
            route.mPoints = string;
            break;
        case STATUS_STATUS:
            if(![string isEqualToString:@"0"])
            {
                [mDelegate onError:-1];
            }
            break;
    }
}

@end
