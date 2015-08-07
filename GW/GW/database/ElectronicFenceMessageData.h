
/*!
 @header ElectronicFenceMessageData.h
 @abstract 操作电子围栏消息表
 @author mengy
 @version 1.00 13-5-20 Creation
 */
#define TABLE_ELECTRONIC_FENCE_MESSAGE_DATA          @"MESSAGE_ELECTRONIC_FENC"
#import <Foundation/Foundation.h>
#import "UserData.h"
#import "MessageInfoData.h"
//sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (KEYID TEXT PRIMARY KEY,ALARM_TYPE CHAR,ALARM_TIME TEXT,ELECFENCE_ID TEXT,ELECFENCE_NAME TEXT,RADIUS TEXT,LON DOUBLE ,LAT DOUBLE ,SPEED TEXT,DIRECTION TEXT,ADDRESS TEXT,DESCRIPTION TEXT,MESSAGE_KEYID TEXT)", 
@interface ElectronicFenceMessageData : NSObject
{
//    NSString *mKeyid;
//    char mAlarmType;
//    NSString *mAlarmTime;
//    NSString *mElecfenceID;
//    NSString *mElecfenceName;
//    NSString *mRadius;
//    double mLon;
//    double mLat;
//    NSString *mSpeed;
//    NSString *mDirection;
//    NSString *mAddress;
//    NSString *mDescription;
//    NSString *mMessageKeyID;

}
@property(nonatomic,copy)NSString *mKeyid;
@property(nonatomic,copy)NSString *mAlarmType;
@property(nonatomic,copy)NSString *mAlarmTime;
@property(nonatomic,copy)NSString *mElecfenceID;
@property(nonatomic,copy)NSString *mElecfenceName;
@property(nonatomic,copy)NSString *mRadius;
@property(assign)double mLon;
@property(assign)double mLat;
@property(nonatomic,copy)NSString *mSpeed;
@property(nonatomic,copy)NSString *mDirection;
@property(nonatomic,copy)NSString *mAddress;
@property(nonatomic,copy)NSString *mDescription;
@property(nonatomic,copy)NSString *mMessageKeyID;
@property(assign)double mElecfenceLon;
@property(assign)double mElecfenceLat;

/*!
 @method initElectronicFenceMessageDatabase
 @abstract 建表
 @discussion 建表
 @param 无
 @result 无
 */
- (void)initElectronicFenceMessageDatabase;

/*!
 @method loadElectronicFenceMessageByKeyID：
 @abstract 根据messageID加载消息数据
 @discussion 根据messageID加载消息数据
 @param messageID 消息id
 @result ElectronicFenceMessageData 消息数据
 */
- (ElectronicFenceMessageData *)loadElectronicFenceMessageByKeyID:(NSString *)MESSAGE_KEYID;

/*!
 @method loadElectronicFenceMessage：
 @abstract 根据userID加载该用户下的所有电子围栏消息数据
 @discussion 根据userID加载该用户下的所有电子围栏消息数据
 @param userID 用户id
 @result messagelist 消息列表
 */
- (NSMutableArray *)loadElectronicFenceMessage:(NSString *)userID;

/*!
 @method deleteElectronicFenceMessageWithIDs：
 @abstract 根据id删除多个消息
 @discussion 根据id删除多个消息
 @param messageID 消息id以逗号分开例如（id，id）
 @result 无
 */
- (void)deleteElectronicFenceMessageWithIDs:(NSString *)messageID;
@end
