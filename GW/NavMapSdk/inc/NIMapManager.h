/*
 *  NIMapManager.h
 *
 *  Copyright (c) 2014年 Navinfo. All rights reserved.
 *
 */

#import <UIKit/UIKit.h>

@class NIMapView;
///主引擎类
@interface NIMapManager : NSObject

///设置搜索类的userid和key
- (void) setSearchIDKey:(NSString *)userid apiKey:(NSString *)apikey;

///添加一个地图
-(void)AddMapView:(NIMapView*)mapview;
///移除一个多地图
-(void)RemoveMapView:(NIMapView*)mapview;

@end


