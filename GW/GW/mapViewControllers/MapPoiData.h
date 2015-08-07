//
//  MapPoiData.h
//  GW
//
//  Created by my on 14/11/28.
//  Copyright (c) 2014年 Navinfo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@interface MapPoiData : NSObject
{
    
}
@property(nonatomic,assign)CLLocationCoordinate2D coordinate;
@property(nonatomic,assign)NSInteger mID;
@property(nonatomic,copy)NSString *mName;
@property(nonatomic,copy)NSString *mAddress;
@property(nonatomic,copy)NSString *mImageName;
//@property(nonatomic, assign)BOOL *mIsEnable;
//@property(nonatomic, assign)BOOL *mAutoGetLocation;


-(MapPoiData *)initWithID:(NSInteger )poiID;

@end
