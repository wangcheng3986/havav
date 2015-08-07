//
//  CherryDBControl.m
//  GW
//
//  Created by my on 14-9-3.
//  Copyright (c) 2014年 mengy. All rights reserved.
//

#import "CherryDBControl.h"

static CherryDBControl *cherryDBControl = nil;

@implementation CherryDBControl

+(id)sharedCherryDBControl
{
    @synchronized (self)
    {
        if(cherryDBControl == nil)
        {
            cherryDBControl = [[self alloc]init];
        }
    }
    

    
    return cherryDBControl;
}

+ (id) allocWithZone:(NSZone *)zone //第三步：重写allocWithZone方法
{
    @synchronized (self) {
        if (cherryDBControl == nil) {
            cherryDBControl = [super allocWithZone:zone];
            return cherryDBControl;
        }
    }
    return nil;
}

- (id) copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

- (id)retain
{
    return self;
}

- (id)autorelease
{
    return self;
}
- (oneway void)release
{
  //
}

- (unsigned) retainCount
{
    return UINT_MAX;
}

- (void)initElecFenceData
{
    elecFenceData=[[ElecFenceData alloc]init];
    [elecFenceData initElecFenceDatabase];
}

#pragma makr - elecFenceDatabaseControl

//添加
- (BOOL)addElecFenceWithKeyid:(NSString*)KeyID
                           ID:(NSString*)elecFenceId
                         name:(NSString*)name
                   lastUpdate:(NSString*)lastUpdate
                        valid:(NSString*)valid
                          lon:(double)lon
                          lat:(double)lat
                       radius:(int)radius
                  description:(NSString*)description
                      address:(NSString*)address
                          vin:(NSString*)vin
                    userKeyID:(NSString*)userKeyID
{
    BOOL result =[elecFenceData addElecFenceWithKeyid:KeyID ID:elecFenceId name:name lastUpdate:lastUpdate valid:valid lon:lon lat:lat radius:radius description:description address:address vin:vin userKeyID:userKeyID];
    if (result) {
        return YES;
    } else {
        return NO;
    }
}
//更新本地电子围栏为无效
- (BOOL)updateElecFenceWithValid:(NSString*)valid
                            vin:(NSString*)vin
{
    BOOL result = [elecFenceData updateElecFenceWithValid:valid vin:vin];
    if (result) {
        return YES;
    } else {
        return NO;
    }
}


//更新
- (BOOL)updateElecFenceWithID:(NSString*)elecFenceId
                            name:(NSString*)name
                      lastUpdate:(NSString*)lastUpdate
                           valid:(NSString*)valid
                             lon:(double)lon
                             lat:(double)lat
                          radius:(int)radius
                     description:(NSString*)description
                         address:(NSString*)address
                             vin:(NSString*)vin
{
    BOOL result = [elecFenceData updateElecFenceWithID:elecFenceId name:name lastUpdate:lastUpdate valid:valid lon:lon lat:lat radius:radius description:description address:address vin:vin];
    if (result) {
        return YES;
    } else {
        return NO;
    }
}
//查询
- (NSMutableArray*)selectWithVin:(NSString*)vin
{
    NSMutableArray *elecFenceDic = [elecFenceData selectWithVin:vin];
    if (0 != [elecFenceDic count]) {
        return elecFenceDic;
    } else {
        return nil;
    }
}

- (NSMutableArray*)selectWithvin:(NSString*)vin
                     elecFenceId:(NSString*)elecFenceId
{
    NSMutableArray *elecFenceDic = [elecFenceData selectWithvin:vin elecFenceId:elecFenceId];
    if (0 != [elecFenceDic count]) {
        return elecFenceDic;
    } else {
        return nil;
    }
}


//删除单项
- (BOOL)removeWithDBID:(NSString *)elecFenceId
                   vin:(NSString*)vin
{
    BOOL result = [elecFenceData removeWithDBID:elecFenceId vin:vin];
    if (result) {
        return YES;
    } else {
        return NO;
    }
}
//删除all
- (BOOL)removeWithAllDBVin:(NSString*)vin
{
    BOOL result = [elecFenceData removeWithAllDBVin:vin];
    if (result) {
        return YES;
    } else {
        return NO;
    }
}
#pragma mark - message

/*!
 @method initCherryDB
 @abstract 初始化二期数据库表
 @discussion 初始化二期数据库表
 @param 无
 @result 无
 */
- (void)initCherryDB
{
    [self initElectronicFenceMessageData];
    [self initMaintenanceAlertData];
    [self initVehicleControlData];
    [self initVehicleDiagnosisData];
    [self initVehicleDiagnosisReportItemData];
    [self initVehiclesAbnormalAlarmData];
    [self initVehicleStatusData];
    [self initElecFenceData];
}





#pragma mark ElectronicFenceMessageData
//电子围栏

/*!
 @method initElectronicFenceMessageData
 @abstract 初始化电子围栏表
 @discussion 初始化电子围栏表
 @param 无
 @result 无
 */
- (void)initElectronicFenceMessageData
{
    mElecFence = [[ElectronicFenceMessageData alloc] init];
    [mElecFence initElectronicFenceMessageDatabase];
}


/*!
 @method deleteElectronicFenceMessage:(NSString *)MESSAGE_KEYID
 @abstract 根据id删除多个消息
 @discussion 根据id删除多个消息
 @param MESSAGE_KEYID 多条消息id
 @result 无
 */
- (void)deleteElectronicFenceMessageWithIDs:(NSString *)MESSAGE_KEYID
{
    [mElecFence deleteElectronicFenceMessageWithIDs:MESSAGE_KEYID];
}



/*!
 @method loadMeetReqElectronicFenceMessageByKeyID:(NSString *)MESSAGE_KEYID
 @abstract 加载电子围栏消息
 @discussion 加载电子围栏消息
 @param MESSAGE_KEYID 消息id
 @result ElectronicFenceMessageData 电子围栏消息数据
 */
- (ElectronicFenceMessageData *)loadMeetReqElectronicFenceMessageByKeyID:(NSString *)MESSAGE_KEYID
{
    return [mElecFence loadElectronicFenceMessageByKeyID:MESSAGE_KEYID];
}


/*!
 @method loadElectronicFenceMessage:(NSString *)userid
 @abstract 获取电子围栏消息
 @discussion 获取电子围栏消息
 @param userid 用户id
 @result messageList 电子围栏消息列表
 */
- (NSMutableArray *)loadElectronicFenceMessage:(NSString *)userid
{
    return [mElecFence loadElectronicFenceMessage:userid];
}

#pragma mark VehicleControlInformMessageData
//车辆控制

/*!
 @method initVehicleControlData
 @abstract 初始化车辆控制表
 @discussion 初始化车辆控制表
 @param 无
 @result 无
 */
- (void)initVehicleControlData
{
    mVehicleControl = [[VehicleControlInformMessageData alloc] init];
    [mVehicleControl initVehicleControlMessageDatabase];
}



/*!
 @method loadVehicleControlMessageByKeyID：
 @abstract 根据messageID加载消息数据
 @discussion 根据messageID加载消息数据
 @param messageID 消息id
 @result VehicleControlInformMessageData 消息数据
 */
- (VehicleControlInformMessageData *)loadVehicleControlMessageByKeyID:(NSString *)MESSAGE_KEYID
{
    return [mVehicleControl loadVehicleControlMessageByKeyID:MESSAGE_KEYID];
}

/*!
 @method loadVehicleControlMessage：
 @abstract 根据userID加载该用户下的所有车辆控制消息数据
 @discussion 根据userID加载该用户下的所有车辆控制消息数据
 @param userID 用户id
 @result messagelist 消息列表
 */
- (NSMutableArray *)loadVehicleControlMessage:(NSString *)userID
{
    return [mVehicleControl loadVehicleControlMessage:userID];
}

/*!
 @method deleteVehicleControlMessageWithIDs：
 @abstract 根据id删除多个消息
 @discussion 根据id删除多个消息
 @param messageID 消息id以逗号分开例如（id，id）
 @result 无
 */
- (void)deleteVehicleControlMessageWithIDs:(NSString *)messageID
{
    [mVehicleControl deleteVehicleControlMessageWithIDs:messageID];
}

#pragma mark VehicleDiagnosisInformMessageData
//车辆故障诊断

/*!
 @method initVehicleDiagnosisData
 @abstract 初始化车辆故障诊断
 @discussion 初始化车辆故障诊断
 @param 无
 @result 无
 */
- (void)initVehicleDiagnosisData
{
    mVehicleDiagnosis = [[VehicleDiagnosisInformMessageData alloc] init];
    [mVehicleDiagnosis initVehicleDiagnosisMessageDatabase];
}

/*!
 @method loadVehicleDiagnosisMessage：
 @abstract 根据userID加载该用户下的所有车辆故障诊断消息数据
 @discussion 根据userID加载该用户下的所有车辆故障诊断消息数据
 @param userID 用户id
 @result messagelist 消息列表
 */
- (NSMutableArray *)loadVehicleDiagnosisMessage:(NSString *)userID
{
    return [mVehicleDiagnosis loadVehicleDiagnosisMessage:userID];
}

/*!
 @method loadVehicleDiagnosisMessageByKeyID：
 @abstract 根据messageID加载消息数据
 @discussion 根据messageID加载消息数据
 @param messageID 消息id
 @result VehicleDiagnosisInformMessageData 消息数据
 */
- (VehicleDiagnosisInformMessageData *)loadVehicleDiagnosisMessageByKeyID:(NSString *)MESSAGE_KEYID
{
    return [mVehicleDiagnosis loadVehicleDiagnosisMessageByKeyID:MESSAGE_KEYID];
}

/*!
 @method deleteVehicleDiagnosisMessageWithIDs：
 @abstract 根据id删除多个消息
 @discussion 根据id删除多个消息
 @param messageID 消息id以逗号分开例如（id，id）
 @result 无
 */
- (void)deleteVehicleDiagnosisMessageWithIDs:(NSString *)messageID
{
    [mVehicleDiagnosis deleteVehicleDiagnosisMessageWithIDs:messageID];
}

/*!
 @method getNewVehicleDiagnosisWithUserID:(NSString *)userid vin:(NSString *)vin
 @abstract 根据userid,vin获取最新的reportid
 @discussion 根据userid,vin获取最新的reportid
 @param userid 用户id
 @result VehicleDiagnosisInformMessageData 车辆诊断数据
 */
- (VehicleDiagnosisInformMessageData *)getNewVehicleDiagnosisWithUserID:(NSString *)userid vin:(NSString *)vin
{
    return [mVehicleDiagnosis getNewVehicleDiagnosisWithUserID:userid vin:vin];
}

/*!
 @method initVehicleDiagnosisReportItemData
 @abstract 初始化车辆故障诊断
 @discussion 初始化车辆故障诊断
 @param 无
 @result 无
 */
- (void)initVehicleDiagnosisReportItemData
{
    mDiagnosisReportItem = [[DiagnosisReportItemData alloc] init];
    [mDiagnosisReportItem initVehicleDiagnosisItemDatabase];
}


//大分类查询去重排序
- (NSMutableArray*)selectWithReportID:(NSString*)reportID
{
    NSMutableArray *reportIDDic = [mDiagnosisReportItem selectWithReportID:reportID];
    if (0 != [reportIDDic count]) {
        return reportIDDic;
    } else {
        return nil;
    }
}
//通过reportID和大分类序号查询所有符合条件的数据
- (NSMutableArray*)selectWithReportID:(NSString*)reportID checkItemType:(NSString*)checkItemType
{
    NSMutableArray *reportDataDic = [mDiagnosisReportItem selectWithReportID:reportID checkItemType:checkItemType];
    if (0 != [reportDataDic count]) {
        return reportDataDic;
    } else {
        return nil;
    }
}

#pragma mark VehiclesAbnormalAlarmMessageData
//车辆异常报警

/*!
 @method initVehiclesAbnormalAlarmData
 @abstract 初始化车辆异常报警
 @discussion 初始化车辆异常报警
 @param 无
 @result 无
 */
- (void)initVehiclesAbnormalAlarmData
{
    mVehicleAbnormalAlarm = [[VehiclesAbnormalAlarmMessageData alloc] init];
    [mVehicleAbnormalAlarm initVehiclesAbnormalAlarmMessageDatabase];
}

/*!
 @method deleteVehiclesAbnormalAlarmMessageWithIDs：
 @abstract 根据id删除多个消息
 @discussion 根据id删除多个消息
 @param messageID 消息id以逗号分开例如（id，id）
 @result 无
 */
- (void)deleteVehiclesAbnormalAlarmMessageWithIDs:(NSString *)messageID
{
    [mVehicleAbnormalAlarm deleteVehiclesAbnormalAlarmMessageWithIDs:messageID];
}

/*!
 @method loadVehiclesAbnormalAlarmByKeyID：
 @abstract 根据messageID加载消息数据
 @discussion 根据messageID加载消息数据
 @param messageID 消息id
 @result VehiclesAbnormalAlarmMessageData 消息数据
 */
- (VehiclesAbnormalAlarmMessageData *)loadVehiclesAbnormalAlarmByKeyID:(NSString *)MESSAGE_KEYID
{
    return [mVehicleAbnormalAlarm loadVehiclesAbnormalAlarmByKeyID:MESSAGE_KEYID];
}

/*!
 @method loadVehiclesAbnormalAlarmMessage：
 @abstract 根据userID加载该用户下的所有车辆控制消息数据
 @discussion 根据userID加载该用户下的所有车辆控制消息数据
 @param userID 用户id
 @result messagelist 消息列表
 */
- (NSMutableArray *)loadVehiclesAbnormalAlarmMessage:(NSString *)userID
{
    return [mVehicleAbnormalAlarm loadVehiclesAbnormalAlarmMessage:userID];
}

#pragma mark MaintenanceAlertInformMessageData
//保养提醒

/*!
 @method initMaintenanceAlertData
 @abstract 初始化保养提醒
 @discussion 初始化保养提醒
 @param 无
 @result 无
 */
- (void)initMaintenanceAlertData
{
    mMaintenanceAlert = [[MaintenanceAlertInformMessageData alloc] init];
    [mMaintenanceAlert initMaintenanceAlertMessageDatabase];
}

/*!
 @method deleteMaintenanceAlertMessageWithIDs：
 @abstract 根据id删除多个消息
 @discussion 根据id删除多个消息
 @param messageID 消息id以逗号分开例如（id，id）
 @result 无
 */
- (void)deleteMaintenanceAlertMessageWithIDs:(NSString *)messageID
{
    [mMaintenanceAlert deleteMaintenanceAlertMessageWithIDs:messageID];
}

/*!
 @method loadMaintenanceAlertByKeyID：
 @abstract 根据messageID加载消息数据
 @discussion 根据messageID加载消息数据
 @param messageID 消息id
 @result MaintenanceAlertInformMessageData 消息数据
 */
- (MaintenanceAlertInformMessageData *)loadMaintenanceAlertByKeyID:(NSString *)MESSAGE_KEYID
{
    return [mMaintenanceAlert loadMaintenanceAlertByKeyID:MESSAGE_KEYID];
}

/*!
 @method loadMaintenanceAlertMessage：
 @abstract 根据userID加载该用户下的所有车辆控制消息数据
 @discussion 根据userID加载该用户下的所有车辆控制消息数据
 @param userID 用户id
 @result messagelist 消息列表
 */
- (NSMutableArray *)loadMaintenanceAlertMessage:(NSString *)userID
{
    return [mMaintenanceAlert loadMaintenanceAlertMessage:userID];
}

#pragma mark VehicleStatusInformMessageData
//车辆状态

/*!
 @method initVehicleStatusData
 @abstract 初始化车辆状态
 @discussion 初始化车辆状态
 @param 无
 @result 无
 */
- (void)initVehicleStatusData
{
    mVehicleStatus = [[VehicleStatusInformMessageData alloc] init];
    [mVehicleStatus initVehicleStatusMessageDatabase];
}

/*!
 @method loadVehicleStatusByVin：
 @abstract 根据vin加载车辆状态
 @discussion 根据vin加载车辆状态
 @param vin 车架号
 @result VehicleStatusInformMessageData 车辆状况信息
 */
- (VehicleStatusInformMessageData *)loadVehicleStatusByVin:(NSString *)vin
{
    return [mVehicleStatus loadVehicleStatusByVin:vin];
}


/*!
 -(void)deleteVehicleStatusWithVin:vin
 @abstract 删除某个用户下的车辆状态
 @discussion 删除某个用户下的车辆状态
 @param vin 车架号
 @result 无
 */
-(void)deleteVehicleStatusWithVin:vin
{
    [mVehicleStatus deleteVehicleStatusWithVin:vin];
}



@end
