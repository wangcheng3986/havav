

/*!
 @header MessageInfoData.h
 @abstract 操作消息主表
 @author mengy
 @version 1.00 13-4-23 Creation
 */
#define TABLE_MESSAGE_INFO_DATA          @"MESSAGE_INFO"
#import <Foundation/Foundation.h>
#import "UserData.h"
#import "FriendLocationData.h"
#import "FriendRequestLocationMessageData.h"
#import "SendToCarMessageData.h"
#import "VehicleStatusInformMessageData.h"
#import "VehiclesAbnormalAlarmMessageData.h"
#import "VehicleDiagnosisInformMessageData.h"
#import "DiagnosisReportItemData.h"
#import "MaintenanceAlertInformMessageData.h"
#import "ElectronicFenceMessageData.h"
#import "VehicleControlInformMessageData.h"
#import "SearchHistoryData.h"
#import "CarData.h"
/*!
 @class
 @abstract 操作MESSAGE_INFO表。
 */
@interface MessageInfoData : NSObject
{
    UserData *mUserData;
    NSString *mKeyID;
    NSString *mID;
    char mType;
    NSString *mCreateTime;
    char mStatus;
    NSString *mVehicleVin;
    NSString *mUser_KeyID;
}
@property(nonatomic,copy)NSString *mKeyID;
@property(nonatomic,copy)NSString *mID;
@property(readwrite)char mType;
@property(nonatomic,copy)NSString *mCreateTime;
@property(readwrite)char mStatus;
@property(nonatomic,copy)NSString *mVehicleVin;
@property(nonatomic,copy)NSString *mUser_KeyID;

/*!
 @method initFriendDatabase
 @abstract 建表
 @discussion 建表
 @param 无
 @result 无
 */
- (void)initMessageInfoDatabase;

//-(void)addMessageInfo:(NSString *)KeyID
//                   ID:(NSString *)ID
//                 type:(char)type
//           createTime:(NSString *)createTime
//               status:(char)status
//           vehicleVin:(NSString *)vehicleVin
//               userID:(NSString *)userID;

//- (void)updateMessageInfo:(NSString *)KeyID
//                       ID:(NSString *)ID
//                     type:(char)type
//               createTime:(NSString *)createTime
//                   status:(char)status
//               vehicleVin:(NSString *)vehicleVin
//                   userID:(NSString *)userID;

/*!
 @method deleteMessageInfo:userID:
 @abstract 根据所属用户id和消息id进行删除
 @discussion 根据所属用户id和消息id进行删除
 @param ID 消息id
 @param userID 所属用户id
 @result 无
 */
- (void)deleteMessageInfo:(NSString *)ID userID:(NSString*)userID;

/*!
 @method deleteMessageInfo:userID:
 @abstract 根据所属用户id和消息id删除多条数据
 @discussion 根据所属用户id和消息id删除多条数据
 @param ID 消息id例如（id，id）
 @param userID 所属用户id
 @result 无
 */
- (void)deleteMessageInfoWithIDs:(NSString *)ID
                          userID:(NSString*)userID;

/*!
 @method deleteAllMessage:
 @abstract 删除某一用户下的所有消息
 @discussion 删除某一用户下的所有消息
 @param userID 所属用户id
 @result 无
 */
- (void)deleteAllMessage:(NSString*)userID;

/*!
 @method loadMessageTypeData: status: userID:
 @abstract 根据类型、状态和所属用户id加载消息列表
 @discussion 根据类型、状态和所属用户id加载消息列表
 @param type 类型
 @param status 状态
 @param userID 所属用户id
 @result messageList
 */
- (NSMutableArray*)loadMessageTypeData:(char)type status:(char)status userID:(NSString *)userID;

/*!
 @method loadMessageInfoData: userID:
 @abstract 根据所属用户id和状态加载消息列表
 @discussion 根据所属用户id和状态加载消息列表
 @param userID 所属用户id
 @param status 状态
 @result messageList
 */
- (NSMutableArray*)loadMessageInfoData:(char)status userID:(NSString *)userID;

/*!
 @method loadMessageCountWithType: userID:
 @abstract 获取某账户下某类未读消息数量
 @discussion 获取某账户下某类未读消息数量
 @param userID 所属用户id
 @param type 消息类型
 @result count 消息数量
 */
- (int)loadMessageCountWithType:(enum MESSAGE_TYPE)type userID:(NSString *)userID;


/*!
 @method setMessageAsReaded: userID:
 @abstract 根据keyid 和 userID 将消息设置成已读状态
 @discussion 根据keyid 和 userID 将消息设置成已读状态
 @param userID 所属用户id
 @param KEYID 消息id
 @result bool
 */
- (bool)setMessageAsReaded:(NSString *)KeyID userID:(NSString *)userID;

/*!
 @method getMessageStatus: userID:
 @abstract 根据keyid 和 userID 获取消息状态
 @discussion 根据keyid 和 userID 获取消息状态
 @param userID 所属用户id
 @param KEYID 消息id
 @result status 消息状态
 */
- (int)getMessageStatus:(NSString *)KeyID userID:(NSString *)userID;

/*!
 @method getCreateTime: userID:
 @abstract 根据keyid 和 userID 获取消息创建时间
 @discussion 根据keyid 和 userID 获取消息创建时间
 @param userID 所属用户id
 @param KEYID 消息id
 @result time 时间
 */
- (NSString *)getCreateTime:(NSString *)KeyID userID:(NSString *)userID;

/*!
 @method addMessageWithSqls:
 @abstract 根据sql语句，添加消息，其中包括主表消息以及其他分类的消息
 @discussion 根据sql语句，添加消息，其中包括主表消息以及其他分类的消息
 @param sql sql语句
 @result 无
 */
- (void)addMessageWithSqls:(NSMutableArray *)sqls;

/*!
 @method deleteMessageWithUserID: type:
 @abstract 删除某个用户下的某类消息
 @discussion 删除某个用户下的某类消息
 @param userID 消息所属用户id
 @param type 消息类型
 @result bool
 */
-(BOOL)deleteMessageWithUserID:(NSString *)userID type:(enum CLEAR_TYPE)type;

/*!
 @method deleteMessageWithUserID: types:
 @abstract 删除某个用户下的某几类消息
 @discussion 删除某个用户下的某几类消息
 @param userID 消息所属用户id
 @param types 消息类型数组
 @result bool
 */
-(BOOL)deleteMessageWithUserID:(NSString *)userID types:(NSMutableArray *)types;

/*!
 @method searchCarLicense:(NSString*)messageKeyID
 @abstract 根据消息id获取车牌号
 @discussion 根据消息id获取车牌号
 @param messageKeyID 消息id
 @result carLicense
 */
- (NSString *)searchCarNum:(NSString *)messageKeyID;

/*!
 @method getNewVehicleDiagnosisReportIdWithUserID:(NSString *)userid vin:(NSString *)vin
 @abstract 根据userid,vin获取最新的reportid
 @discussion 根据userid,vin获取最新的reportid
 @param userid 用户id
 @result ReportId 诊断id
 */
- (NSString *)getNewVehicleDiagnosisReportIdWithUserID:(NSString *)userid vin:(NSString *)vin;
@end