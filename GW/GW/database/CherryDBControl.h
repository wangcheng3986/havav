//
//  CherryDBControl.h
//  GW
//
//  Created by my on 14-9-3.
//  Copyright (c) 2014年 mengy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ElecFenceData.h"
#import "ElectronicFenceMessageData.h"
#import "VehicleControlInformMessageData.h"
#import "VehicleDiagnosisInformMessageData.h"
#import "VehiclesAbnormalAlarmMessageData.h"
#import "MaintenanceAlertInformMessageData.h"
#import "VehicleStatusInformMessageData.h"
#import "MessageInfoData.h"
#import "DiagnosisReportItemData.h"

@interface CherryDBControl : NSObject
{
    ElecFenceData * elecFenceData;
    ElectronicFenceMessageData *mElecFence;
    VehicleControlInformMessageData *mVehicleControl;
    VehicleDiagnosisInformMessageData *mVehicleDiagnosis;
    DiagnosisReportItemData *mDiagnosisReportItem;
    VehiclesAbnormalAlarmMessageData *mVehicleAbnormalAlarm;
    MaintenanceAlertInformMessageData *mMaintenanceAlert;
    VehicleStatusInformMessageData *mVehicleStatus;
//    MessageInfoData *mMessageInfo;
}

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
                    userKeyID:(NSString*)userKeyID;
//更新本地电子围栏为无效
- (BOOL)updateElecFenceWithValid:(NSString*)valid
                            vin:(NSString*)vin;
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
                             vin:(NSString*)vin;
//查询
- (NSMutableArray*)selectWithVin:(NSString*)vin;
- (NSMutableArray*)selectWithvin:(NSString*)vin
                     elecFenceId:(NSString*)elecFenceId;
//删除单项
- (BOOL)removeWithDBID:(NSString *)elecFenceId
                   vin:(NSString*)vin;
//删除all
- (BOOL)removeWithAllDBVin:(NSString*)vin;
+(id)sharedCherryDBControl;
- (void)initElecFenceData;

#pragma mark - message
/*!
 @method initCherryDB
 @abstract 初始化二期数据库表
 @discussion 初始化二期数据库表
 @param 无
 @result 无
 */
- (void)initCherryDB;

//大分类查询去重排序
- (NSMutableArray*)selectWithReportID:(NSString*)reportID;
//通过reportID和大分类序号查询所有符合条件的数据
- (NSMutableArray*)selectWithReportID:(NSString*)reportID checkItemType:(NSString*)checkItemType;
//电子围栏


/*!
 @method deleteElectronicFenceMessage:(NSString *)MESSAGE_KEYID
 @abstract 根据id删除多个消息
 @discussion 根据id删除多个消息
 @param MESSAGE_KEYID 多条消息id
 @result 无
 */
- (void)deleteElectronicFenceMessageWithIDs:(NSString *)MESSAGE_KEYID;


/*!
 @method loadMeetReqElectronicFenceMessageByKeyID:(NSString *)MESSAGE_KEYID
 @abstract 加载电子围栏消息
 @discussion 加载电子围栏消息
 @param MESSAGE_KEYID 消息id
 @result ElectronicFenceMessageData 电子围栏消息数据
 */
- (ElectronicFenceMessageData *)loadMeetReqElectronicFenceMessageByKeyID:(NSString *)MESSAGE_KEYID;


/*!
 @method loadElectronicFenceMessage:(NSString *)userid
 @abstract 获取电子围栏消息
 @discussion 获取电子围栏消息
 @param userid 用户id
 @result messageList 电子围栏消息列表
 */
- (NSMutableArray *)loadElectronicFenceMessage:(NSString *)userid;

/*!
 @method loadVehicleControlMessageByKeyID：
 @abstract 根据messageID加载消息数据
 @discussion 根据messageID加载消息数据
 @param messageID 消息id
 @result VehicleControlInformMessageData 消息数据
 */
- (VehicleControlInformMessageData *)loadVehicleControlMessageByKeyID:(NSString *)MESSAGE_KEYID;

/*!
 @method loadVehicleControlMessage：
 @abstract 根据userID加载该用户下的所有车辆控制消息数据
 @discussion 根据userID加载该用户下的所有车辆控制消息数据
 @param userID 用户id
 @result messagelist 消息列表
 */
- (NSMutableArray *)loadVehicleControlMessage:(NSString *)userID;


/*!
 @method deleteVehicleControlMessageWithIDs：
 @abstract 根据id删除多个消息
 @discussion 根据id删除多个消息
 @param messageID 消息id以逗号分开例如（id，id）
 @result 无
 */
- (void)deleteVehicleControlMessageWithIDs:(NSString *)messageID;

/*!
 @method loadVehicleDiagnosisMessage：
 @abstract 根据userID加载该用户下的所有车辆故障诊断消息数据
 @discussion 根据userID加载该用户下的所有车辆故障诊断消息数据
 @param userID 用户id
 @result messagelist 消息列表
 */
- (NSMutableArray *)loadVehicleDiagnosisMessage:(NSString *)userID;

/*!
 @method deleteVehicleDiagnosisMessageWithIDs：
 @abstract 根据id删除多个消息
 @discussion 根据id删除多个消息
 @param messageID 消息id以逗号分开例如（id，id）
 @result 无
 */
- (void)deleteVehicleDiagnosisMessageWithIDs:(NSString *)messageID;

/*!
 @method getNewVehicleDiagnosisWithUserID:(NSString *)userid vin:(NSString *)vin
 @abstract 根据userid,vin获取最新的reportid
 @discussion 根据userid,vin获取最新的reportid
 @param userid 用户id
 @result VehicleDiagnosisInformMessageData 车辆诊断数据
 */
- (VehicleDiagnosisInformMessageData *)getNewVehicleDiagnosisWithUserID:(NSString *)userid vin:(NSString *)vin;

/*!
 @method loadVehicleDiagnosisMessageByKeyID：
 @abstract 根据messageID加载消息数据
 @discussion 根据messageID加载消息数据
 @param messageID 消息id
 @result VehicleDiagnosisInformMessageData 消息数据
 */
- (VehicleDiagnosisInformMessageData *)loadVehicleDiagnosisMessageByKeyID:(NSString *)MESSAGE_KEYID;

/*!
 @method deleteVehiclesAbnormalAlarmMessageWithIDs：
 @abstract 根据id删除多个消息
 @discussion 根据id删除多个消息
 @param messageID 消息id以逗号分开例如（id，id）
 @result 无
 */
- (void)deleteVehiclesAbnormalAlarmMessageWithIDs:(NSString *)messageID;

/*!
 @method loadVehiclesAbnormalAlarmByKeyID：
 @abstract 根据messageID加载消息数据
 @discussion 根据messageID加载消息数据
 @param messageID 消息id
 @result VehiclesAbnormalAlarmMessageData 消息数据
 */
- (VehiclesAbnormalAlarmMessageData *)loadVehiclesAbnormalAlarmByKeyID:(NSString *)MESSAGE_KEYID;

/*!
 @method loadVehiclesAbnormalAlarmMessage：
 @abstract 根据userID加载该用户下的所有车辆控制消息数据
 @discussion 根据userID加载该用户下的所有车辆控制消息数据
 @param userID 用户id
 @result messagelist 消息列表
 */
- (NSMutableArray *)loadVehiclesAbnormalAlarmMessage:(NSString *)userID;


/*!
 @method deleteMaintenanceAlertMessageWithIDs：
 @abstract 根据id删除多个消息
 @discussion 根据id删除多个消息
 @param messageID 消息id以逗号分开例如（id，id）
 @result 无
 */
- (void)deleteMaintenanceAlertMessageWithIDs:(NSString *)messageID;

/*!
 @method loadMaintenanceAlertByKeyID：
 @abstract 根据messageID加载消息数据
 @discussion 根据messageID加载消息数据
 @param messageID 消息id
 @result MaintenanceAlertInformMessageData 消息数据
 */
- (MaintenanceAlertInformMessageData *)loadMaintenanceAlertByKeyID:(NSString *)MESSAGE_KEYID;

/*!
 @method loadMaintenanceAlertMessage：
 @abstract 根据userID加载该用户下的所有车辆控制消息数据
 @discussion 根据userID加载该用户下的所有车辆控制消息数据
 @param userID 用户id
 @result messagelist 消息列表
 */
- (NSMutableArray *)loadMaintenanceAlertMessage:(NSString *)userID;


/*!
 @method loadVehicleStatusByVin：
 @abstract 根据vin加载车辆状态
 @discussion 根据vin加载车辆状态
 @param vin 车架号
 @result VehicleStatusInformMessageData 车辆状况信息
 */
- (VehicleStatusInformMessageData *)loadVehicleStatusByVin:(NSString *)vin;


/*!
 -(void)deleteVehicleStatusWithVin:vin
 @abstract 删除某个用户下的车辆状态
 @discussion 删除某个用户下的车辆状态
 @param vin 车架号
 @result 无
 */
-(void)deleteVehicleStatusWithVin:vin;
@end
