/*
 *  NINaviData.h
 *
 *  Copyright (c) 2014年 Navinfo. All rights reserved.
 *
 */

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>



/// 导航状态数据类
@interface NINaviData : NSObject
{
    double naviDirection;//当前方向
    double naviCurrentSpeed;//当前速度
    unsigned int  naviSurplusDistance;//导航剩余距离
    unsigned int naviDwSumDistance;//已导航距离
    unsigned int naviRemainTime;//剩余时间
    NSString *naviCurrentRoadName;//当前路段名称
    NSString *naviNextRoadName;//下一路段名称
    double naviDirctionToEnd;//当前点到终点的方向
    unsigned int naviValueDistance;//下一路口的距离
    unsigned char naviType;//下一路口提示类型
    CLLocationCoordinate2D naviLocation;//导航中的位置
    NSString *naviWavData;//语音提示数据
    NSInteger Priority;//语音播报优先级
    
    
}
/// 当前方向
@property(nonatomic)double naviDirection;
/// 当前速度
@property(nonatomic)double naviCurrentSpeed;
/// 导航剩余距离
@property(nonatomic)unsigned int  naviSurplusDistance;
/// 已导航距离
@property(nonatomic)unsigned int naviDwSumDistance;
/// 剩余时间
@property(nonatomic)unsigned int naviRemainTime;
/// 当前路段名称
@property(nonatomic,retain)NSString *naviCurrentRoadName;
/// 下一路段名称
@property(nonatomic,retain)NSString *naviNextRoadName;
/// 当前点到终点的方向
@property(nonatomic)double naviDirctionToEnd;
/// 下一路口的距离
@property(nonatomic)unsigned int naviValueDistance;
/// 下一路口提示类型\n
///  0：空\n
///  1：调头\n
///  2：直行\n
///  3：右\n
///  4：右前\n
///  5：左\n
///  6：左前\n
///  7：右后\n
///  8：左后\n
///  9：道路分流到左侧路口\n
/// 10：道路分流到右侧路口\n
/// 11：主路入口\n
/// 12：主路出口\n
/// 13：分流道路到主路(连接线到主路)\n
/// 14：主路分流到左侧路口\n
/// 15：主路分流到右侧路口\n
/// 16：提前右转弯\n
/// 17：提前左转弯\n
/// 18：环岛调头\n
/// 19：环岛直行\n
/// 20：环岛左转\n
/// 21：环岛右转\n
/// 22：环岛出第1路口\n
/// 23：环岛出第2路口\n
/// 24：环岛出第3路口\n
/// 25：环岛出第4路口\n
/// 26：环岛出第5路口\n
/// 27：环岛出第6路口\n
/// 28：环岛出第7路口\n
/// 29：环岛出第8路口\n
/// 30：环岛出第9路口\n
/// 31：环岛出第10路口\n
/// 32：环岛出其他路口\n
/// 33：右手第1路口\n
/// 34：右手第2路口\n
/// 35：右手第3路口\n
/// 36：右手第4路口\n
/// 37：右手第5路口\n
/// 38：右手第6路口\n
/// 39：右手第7路口\n
/// 40：右手第8路口\n
/// 41：右手第9路口\n
/// 42：右手第10路口\n
/// 43：路况复杂\n
/// 44：收费站\n
/// 45：摄像头\n
/// 46：驶入服务区\n
/// 47：经过服务区\n
/// 48：目的地\n
/// 49：目的地附近\n
/// 50：红绿灯路口\n
@property(nonatomic)unsigned char naviType;
@property(nonatomic)CLLocationCoordinate2D naviLocation;
@property(nonatomic,copy)NSString *naviWavData;
@property(nonatomic)NSInteger Priority;//语音播报优先级





/// 初始化导航状态数据
-(id)initData;

/// 将导航状态数据清空
-(void)resetData;

@end
