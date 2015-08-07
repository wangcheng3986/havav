
/*!
 @header VehicleControlInformMessageData.h
 @abstract 操作车辆控制消息表
 @author mengy
 @version 1.00 14-9-3 Creation
 */
#define TABLE_VEHICLE_CONTROL_MESSAGE_DATA          @"MESSAGE_VEHICLE_CONTROL"
#import <Foundation/Foundation.h>
#import "UserData.h"
#import "MessageInfoData.h"
//1	KEYID	主键	VARCHAR2(32)
//2	SEND_TIME	指令请求发送时间	VARCHAR2(16)
//3	CMD_CODE	指令类型码	VARCHAR2(16)
//4	RESULT_CODE	指令执行结果。	CHAR(1)
//5	RESULT_MSG	指令执行错误提示	VARCHAR2(256)
//6	MESSAGE_KEYID	消息主键	VARCHAR2(32)
@interface VehicleControlInformMessageData : NSObject
{
}
@property(nonatomic,copy)NSString *mKeyid;
@property(nonatomic,copy)NSString *mResultCode;
@property(nonatomic,copy)NSString *mSendTime;
@property(nonatomic,copy)NSString *mCmdCode;
@property(nonatomic,copy)NSString *mResultMsg;
@property(nonatomic,copy)NSString *mMessageKeyID;
/*!
 @method initVehicleControlMessageDatabase
 @abstract 建表
 @discussion 建表
 @param 无
 @result 无
 */
- (void)initVehicleControlMessageDatabase;

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
@end
