/*!
 @header FriendLocationData.h
 @abstract 操作好友位置请求消息表
 @author mengy
 @version 1.00 14-4-1 Creation
 */
//好友位置请求消息表
#define TABLE_FRIEND_REQUEST_LOCATION_MESSAGE_DATA          @"MESSAGE_FRIEND_REQUEST_LOCATION"
#import <Foundation/Foundation.h>
#import "UserData.h"
#import "MessageInfoData.h"
/*!
 @class
 @abstract 操作MESSAGE_FRIEND_REQUEST_LOCATION表。
 */
@interface FriendLocationData : NSObject
{
//    @"CREATE TABLE IF NOT EXISTS %@ (KEYID TEXT  NOT NULL,REQ_UID TEXT,REQUEST_USER_ID TEXT, REQUEST_USER_NAME TEXT,REQUEST_USER_TEL TEXT, REQUEST_TIME TEXT, DESCRIPTION TEXT, RP_STATE TEXT, RP_TIME TEXT, MESSAGE_KEYID INTEGER)",
    NSString *mKeyID;
    NSString *mReqUID;
    NSString *mRqUserID;
    NSString *mRqUserName;
    NSString *mRqUserTel;
    NSString *mDescription;
    NSString *mRqTime;
    NSString *mRpState;
    NSString *mRpTime;
    NSString *mMessageKeyID;
    
}

@property(nonatomic,copy)NSString *mKeyID;
@property(nonatomic,copy)NSString *mReqUID;
@property(nonatomic,copy)NSString *mRqUserID;
@property(nonatomic,copy)NSString *mRqUserName;
@property(nonatomic,copy)NSString *mRqUserTel;
@property(nonatomic,copy)NSString *mDescription;
@property(nonatomic,copy)NSString *mRqTime;
@property(nonatomic,copy)NSString *mRpState;
@property(nonatomic,copy)NSString *mRpTime;
@property(nonatomic,copy)NSString *mMessageKeyID;

/*!
 @method initFriendLocationMessageDatabase
 @abstract 建表
 @discussion 建表
 @param 无
 @result 无
 */
- (void)initFriendLocationMessageDatabase;

/*!
 @method deleteFriendLocationMessage：
 @abstract 根据MESSAGE_KEYID删除消息
 @discussion 根据MESSAGE_KEYID删除消息
 @param messageID 消息id
 @result 无
 */
- (void)deleteFriendLocationMessage:(NSString *)messageID;

/*!
 @method deleteFriendLocationMessageWithIDs：
 @abstract 根据id删除多个消息
 @discussion 根据id删除多个消息
 @param messageID 消息id以逗号分开例如（id，id）
 @result 无
 */
- (void)deleteFriendLocationMessageWithIDs:(NSString *)messageID;

/*!
 @method deleteDemoFriendLocationMessage：
 @abstract 删除demo用户消息
 @discussion 删除demo用户消息
 @param messageKeyID 消息id
 @result 无
 */
- (void)deleteDemoFriendLocationMessage:(NSString *)messageKeyID;

/*!
 @method loadMeetRequestFriendLocationMessage：
 @abstract 根据messageID加载消息数据
 @discussion 根据messageID加载消息数据
 @param messageID 消息id
 @result FriendLocationData 消息数据
 */
- (FriendLocationData *)loadMeetRequestFriendLocationMessage:(NSString *)messageID;

/*!
 @method loadAllMeetRequestFriendLocationMessage：
 @abstract 根据userID加载该用户下的所有车友位置请求消息数据
 @discussion 根据userID加载该用户下的所有车友位置请求消息数据
 @param userID 用户id
 @result messagelist 消息列表
 */
- (NSMutableArray *)loadAllMeetRequestFriendLocationMessage:(NSString *)userID;

/*!
 @method updateFriendLocationMessageRpState： state: rpTime:
 @abstract 更新位置请求消息状态
 @discussion 更新位置请求消息状态
 @param messageKeyID 消息id
 @param state 状态
 @param rpTime 应答时间
 @result 无
 */
- (void)updateFriendLocationMessageRpState:(NSString *)messageKeyID state:(int)state rpTime:(NSString *)rpTime;
@end
