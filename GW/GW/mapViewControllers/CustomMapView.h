//
//  CustomMapView.h
//  GW
//
//  Created by wangqiwei on 14-11-26.
//  Copyright (c) 2014年 Navinfo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIMapViewShare.h"

///承载地图view的uiview
@interface CustomMapView : UIView

@property (nonatomic, readonly) NIMapViewShare* mapViewShare;
@property(nonatomic,retain)NSMutableDictionary *POIData;
/**
 *当mapview即将被显式的时候调用，恢复之前存储的mapview状态。
 */
-(void)viewWillAppear;


/**
 *当mapview即将被隐藏的时候调用，存储当前mapview的状态。
 */
-(void)viewWillDisappear;

-(void)initDataDic;
-(void)removeDataDic;
@end
