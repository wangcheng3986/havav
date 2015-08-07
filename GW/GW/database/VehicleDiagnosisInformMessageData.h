
/*!
 @header VehicleDiagnosisInformMessageData.h
 @abstract 故障诊断结果消息表
 @author mengy
 @version 1.00 14-9-3 Creation
 */
#define TABLE_VEHICLE_DIAGNOSIS_MESSAGE_DATA          @"MESSAGE_DIAGNOSIS_REPORT"
#import <Foundation/Foundation.h>
#import "UserData.h"
#import "MessageInfoData.h"
//1	KEYID	主键	VARCHAR2(32)	否	唯一
//2	REPORT_ID	诊断报告的id	VARCHAR2(32)	否		GW.M.GET_MESSAGE_LIST	reportId
//3	REPORT_TYPE	诊断报告类型。0：在线诊断报告；1：定期情况报告；2：其他；	VARCHAR2(16)	否		GW.M.GET_MESSAGE_LIST	reportType
//4	VIN	远程诊断目标车辆车架号	VARCHAR2(16)	否		GW.M.GET_MESSAGE_LIST	vin
//5	SEND_TIME	远程诊断请求发送时间，注：定期情况报告没有发送时间	VARCHAR2(16)	否		GW.M.GET_MESSAGE_LIST	sendTime
//6	CHECK_RESULT	检查结果。0:无故障；1：有故障；2：诊断失败	VARCHAR2(256)	否		GW.M.GET_MESSAGE_LIST	checkResult
//7	CHECK_TIME	检查时间，本次检查结果生成时间。	VARCHAR2(16)	否		GW.M.GET_MESSAGE_LIST	checkTime
//8	MESSAGE_KEYID	消息主键	VARCHAR2(32)	否	外键，关联用户消息主表
@interface VehicleDiagnosisInformMessageData : NSObject
@property(nonatomic,copy)NSString *mKeyid;
@property(nonatomic,copy)NSString *mRepertId;
@property(nonatomic,copy)NSString *mSendTime;
@property(nonatomic,copy)NSString *mRepertType;
@property(nonatomic,copy)NSString *mCheckResult;
@property(nonatomic,copy)NSString *mCheckTime;
@property(nonatomic,copy)NSString *mMessageKeyID;
/*!
 @method initVehicleDiagnosisMessageDatabase
 @abstract 建表
 @discussion 建表
 @param 无
 @result 无
 */
- (void)initVehicleDiagnosisMessageDatabase;

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
 @method loadVehicleDiagnosisMessage：
 @abstract 根据userID加载该用户下的所有车辆诊断结果消息数据
 @discussion 根据userID加载该用户下的所有车辆诊断结果数据
 @param userID 用户id
 @result messagelist 消息列表
 */
- (NSMutableArray *)loadVehicleDiagnosisMessage:(NSString *)userID;

/*!
 @method loadVehicleDiagnosisMessageByKeyID：
 @abstract 根据messageID加载消息数据
 @discussion 根据messageID加载消息数据
 @param messageID 消息id
 @result VehicleDiagnosisInformMessageData 消息数据
 */
- (VehicleDiagnosisInformMessageData *)loadVehicleDiagnosisMessageByKeyID:(NSString *)MESSAGE_KEYID;
@end
