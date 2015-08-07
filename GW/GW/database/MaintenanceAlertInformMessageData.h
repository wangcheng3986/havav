

/*!
 @header MaintenanceAlertInformMessageData.h
 @abstract 保养提醒消息表
 @author mengy
 @version 1.00 14-9-3 Creation
 */
#define TABLE_MAINTENANCE_ALERT_MESSAGE_DATA          @"MESSAGE_MAINTENANCE_ALERT"
#import <Foundation/Foundation.h>
#import "UserData.h"
#import "MessageInfoData.h"
//1	KEYID	主键	VARCHAR2(32)	否	唯一
//2	MAINTAIN_TIME	提醒保养时间	VARCHAR2(16)	否			maintainTime
//3	MAINTAIN_MILEAGE	提醒保养里程	VARCHAR2(16)	否			maintainMileage
//4	MAINTAIN_ITEMS	提醒保养项目	VARCHAR2(256)	否	以逗号分隔多个项目		maintainItems
//5	DESCRIPTION	报警详细说明	VARCHAR2(256)				description
//6	MESSAGE_KEYID	消息主键	VARCHAR2(32)	否	外键，关联用户消息主表
@interface MaintenanceAlertInformMessageData : NSObject
@property(nonatomic,copy)NSString *mKeyID;
@property(nonatomic,copy)NSString *mMaintainTime;
@property(nonatomic,copy)NSString *mMaintainMileage;
@property(nonatomic,copy)NSString *mMaintainItems;
@property(nonatomic,copy)NSString *mDescription;
@property(nonatomic,copy)NSString *mMessageKeyID;

/*!
 @method initMaintenanceAlertMessageDatabase
 @abstract 建表
 @discussion 建表
 @param 无
 @result 无
 */
- (void)initMaintenanceAlertMessageDatabase;

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
@end
