//
//  CustomMapView.m
//  GW
//
//  Created by wangqiwei on 14-11-26.
//  Copyright (c) 2014年 Navinfo. All rights reserved.
//

#import "CustomMapView.h"
#import "NIMapViewShare.h"

@implementation CustomMapView
{
    NIMapViewShare* _mapview;

}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _mapview = [NIMapViewShare sharedInstance:frame];
        [self addSubview:_mapview.mapView];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        _mapview = [NIMapViewShare sharedInstance:self.frame];
        [self addSubview:_mapview.mapView];
    }
    
    return  self;
}

-(void)initDataDic
{
    self.POIData = [[NSMutableDictionary alloc]initWithCapacity:0];
}

-(void)removeDataDic
{
    [self.POIData removeAllObjects];
}

-(void)layoutSubviews
{
    [_mapview.mapView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}

-(void)viewWillAppear
{
    [self addSubview:_mapview.mapView];
    NSLog(@"self.frame.size.width:>>>>>>%f self.frame.size.height>>>>>>%f",self.frame.size.width,self.frame.size.height);
 //   [_mapview.mapView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [_mapview.mapView viewWillAppear];
    
}

/**
 *当mapview即将被隐藏的时候调用，存储当前mapview的状态。
 */
-(void)viewWillDisappear
{
    [_mapview.mapView viewWillDisappear];
}

-(void)dealloc
{
    [_mapview release];
    _mapview = nil;
    
    
    [super dealloc];
}



-(NIMapViewShare*) mapViewShare
{
    return _mapview;
}

@end
