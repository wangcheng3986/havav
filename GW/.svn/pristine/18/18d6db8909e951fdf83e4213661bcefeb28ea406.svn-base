
/*!
 @header SendToCarMessageData.h
 @abstract 操作发送到车消息表
 @author mengy
 @version 1.00 13-5-20 Creation
 */
#define TABLE_SEND_TO_CAR_MESSAGE_DATA          @"MESSAGE_SEND_TO_CAR"
#import <Foundation/Foundation.h>
#import "UserData.h"
#import "MessageInfoData.h"
@interface SendToCarMessageData : NSObject
{
//    @"CREATE TABLE IF NOT EXISTS %@ (KEYID TEXT NOT NULL ,SENDER_USER_ID TEXT,SENDER_USER_NAME TEXT,SENDER_USER_TEL TEXT,SEND_TIME TEXT,LON DOUBLE ,LAT DOUBLE ,POI_NAME TEXT,POI_ADDRESS TEXT,POI_ID TEXT,EVENT_TIME TEXT,EVENT_CONTENT TEXT,MESSAGE_KEYID TEXT)",
    NSString *mKeyID;
    NSString *mSendUserID;
    NSString *mSendUserName;
    NSString *mSendUserTel;
    NSString *mSendTime;
    double mLon;
    double mLat;
    NSString *mPoiName;
    NSString *mPoiAddress;
    NSString *mPoiID;
    NSString *mEventTime;
    NSString *mEventContent;
    NSString *mMessageKeyID;
}

@property(nonatomic,copy)NSString *mKeyID;
@property(nonatomic,copy)NSString *mSendUserID;
@property(nonatomic,copy)NSString *mSendUserName;
@property(nonatomic,assign)double mLon;
@property(nonatomic,assign)double mLat;
@property(nonatomic,copy)NSString *mSendUserTel;
@property(nonatomic,copy)NSString *mSendTime;
@property(nonatomic,copy)NSString *mPoiName;
@property(nonatomic,copy)NSString *mPoiAddress;
@property(nonatomic,copy)NSString *mPoiID;
@property(nonatomic,copy)NSString *mEventTime;
@property(nonatomic,copy)NSString *mEventContent;
@property(nonatomic,copy)NSString *mMessageKeyID;
/*!
 @method initSendToCarMessageDatabase
 @abstract 建表
 @discussion 建表
 @param 无
 @result 无
 */
- (void)initSendToCarMessageDatabase;

/*!
 @method deleteSendToCarMessage:(NSString *)messageKeyID
 @abstract 根据MESSAGE_KEYID删除消息
 @discussion 根据MESSAGE_KEYID删除消息
 @param messageKeyID 消息id
 @result 无
 */
- (void)deleteSendToCarMessage:(NSString *)messageKeyID;

/*!
 @method deleteSendToCarMessageWithIDs:(NSString *)messageKeyID
 @abstract 根据id删除多个消息
 @discussion 根据id删除多个消息
 @param messageKeyID 消息id以逗号分开例如（id，id）
 @result 无
 */
- (void)deleteSendToCarMessageWithIDs:(NSString *)messageKeyID;

/*!
 @method deleteDemoSendToCarMessage:(NSString *)messageKeyID
 @abstract 删除demo用户消息
 @discussion 删除demo用户消息
 @param messageKeyID 消息id
 @result 无
 */
- (void)deleteDemoSendToCarMessage:(NSString *)messageKeyID;

/*!
 @method loadMeetRequestSendToCarMessage:(NSString *)messageKeyID
 @abstract 根据messageKeyID加载消息数据
 @discussion 根据messageKeyID加载消息数据
 @param messageKeyID 消息id
 @result SendToCarMessageData 消息数据
 */
- (SendToCarMessageData *)loadMeetRequestSendToCarMessage:(NSString *)messageKeyID;

/*!
 @method loadAllMeetRequestSendToCarMessage:(NSString *)userID
 @abstract 根据userID加载该用户下的所有发送到车消息数据
 @discussion 根据userID加载该用户下的所有发送到车求消息数据
 @param userID 用户id
 @result messagelist 消息列表
 */
- (NSMutableArray *)loadAllMeetRequestSendToCarMessage:(NSString *)userID;
@end
