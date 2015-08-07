

/*!
 @header VehiclesAbnormalAlarmMessageData.h
 @abstract 车辆异常报警消息表
 @author mengy
 @version 1.00 14-9-3 Creation
 */
#define TABLE_VEHICLE_ABNORMAL_ALARM_MESSAGE_DATA          @"MESSAGE_VEHICLE_ABNORMAL_ALARM"
#import <Foundation/Foundation.h>
#import "UserData.h"
#import "MessageInfoData.h"
//1	KEYID	主键	VARCHAR2(32)	否	唯一
//2	ALARM_TYPE	报警类型	CHAR(1)	否	0：车门异常打开；1：TBox报警		alarmType
//3	ALARM_TIME	报警时间	VARCHAR2(16)	否			alarmTime
//4	LON	报警位置经度	DOUBLE (16)	否			lon
//5	LAT	报警位置纬度	DOUBLE (16)	否			lat
//6	SPEED	报警车辆速度	VARCHAR2(16)	否			speed
//7	DIRECTION	报警车辆方向	VARCHAR2(16)	否			direction
//8	ADDRESS	报警位置地址	VARCHAR2(256)				address
//9	MESSAGE_KEYID	消息主键	VARCHAR2(32)	否	外键，关联用户消息主表
@interface VehiclesAbnormalAlarmMessageData : NSObject
@property(nonatomic,copy)NSString *mKeyid;
@property(nonatomic,copy)NSString *mAlarmType;
@property(nonatomic,copy)NSString *mAlarmTime;
@property(assign)double mLon;
@property(assign)double mLat;
@property(nonatomic,copy)NSString *mSpeed;
@property(nonatomic,copy)NSString *mDirection;
@property(nonatomic,copy)NSString *mAddress;
@property(nonatomic,copy)NSString *mMessageKeyID;

/*!
 @method initVehiclesAbnormalAlarmMessageDatabase
 @abstract 建表
 @discussion 建表
 @param 无
 @result 无
 */
- (void)initVehiclesAbnormalAlarmMessageDatabase;
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

@end
