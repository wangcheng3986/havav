
/*!
 @header FriendRequestLocationMessageData.h
 @abstract 操作好友位置消息表
 @author mengy
 @version 1.00 13-5-20 Creation
 */
//好友位置消息表
#define TABLE_FRIEND_LOCATION_MESSAGE_DATA          @"MESSAGE_FRIEND_LOCATION"
#import <Foundation/Foundation.h>
#import "UserData.h"
#import "MessageInfoData.h"

//,RQ_SIM =>targetName
/*!
 @class
 @abstract 操作MESSAGE_FRIEND_LOCATION表。
 */
@interface FriendRequestLocationMessageData : NSObject
{
//    @"CREATE TABLE IF NOT EXISTS %@ (KEYID TEXT NOT NULL,SEND_TIME TEXT,FRIEND_USER_ID TEXT,FRIEND_USER_NAME TEXT,FRIEND_USER_TEL TEXT,RESPONSE_TIME TEXT,UPLOAD_TIME TEXT, LON DOUBLE, LAT DOUBLE, POI_NAME TEXT, POI_ADDRESS TEXT, MESSAGE_KEYID TEXT)",
    NSString *mKeyID;
    NSString *mSendTime;
    NSString *mFriendUserID;
    NSString *mFriendUserName;
    NSString *mFriendUserTel;
    NSString *mResponseTime;
    NSString *mUploadTime;
    double mLon;
    double mLat;
    NSString *mPoiName;
    NSString *mPoiAddress;
    NSString *mLicenseNumber;
    NSString *mMessageKeyID;
    

}

@property(nonatomic,copy)NSString *mKeyID;
@property(nonatomic,copy)NSString *mSendTime;
@property(nonatomic,assign)double mLon;
@property(nonatomic,assign)double mLat;
@property(nonatomic,copy)NSString *mFriendUserID;
@property(nonatomic,copy)NSString *mFriendUserName;
@property(nonatomic,copy)NSString *mFriendUserTel;
@property(nonatomic,copy)NSString *mResponseTime;
@property(nonatomic,copy)NSString *mUploadTime;
@property(nonatomic,copy)NSString *mPoiName;
@property(nonatomic,copy)NSString *mPoiAddress;
@property(nonatomic,copy)NSString *mLicenseNumber;
@property(nonatomic,copy)NSString *mMessageKeyID;
/*!
 @method initFriendRequestLocationMessageDatabase
 @abstract 建表
 @discussion 建表
 @param 无
 @result 无
 */
- (void)initFriendRequestLocationMessageDatabase;

/*!
 @method deleteFriendRequestLocationMessage：
 @abstract 根据messageKeyID删除消息
 @discussion 根据messageKeyID删除消息
 @param messageID 消息id
 @result 无
 */
- (void)deleteFriendRequestLocationMessage:(NSString *)messageKeyID;
//根据id删除多个消息
/*!
 @method deleteFriendRequestLocationMessage：
 @abstract 根据id删除多个消息
 @discussion 根据id删除多个消息
 @param messageID 消息id以逗号分开例如（id，id）
 @result 无
 */
- (void)deleteFriendRequestLocationMessageWithIDs:(NSString *)messageKeyID;

/*!
 @method deleteDemoFriendRequestLocationMessage：
 @abstract 删除demo用户消息
 @discussion 删除demo用户消息
 @param messageKeyID 消息id
 @result 无
 */
- (void)deleteDemoFriendRequestLocationMessage:(NSString *)messageKeyID;

/*!
 @method loadMeetRequestFriendRequestLocationMessage：
 @abstract 根据messageID加载消息数据
 @discussion 根据messageID加载消息数据
 @param messageID 消息id
 @result FriendRequestLocationMessageData 消息数据
 */
- (FriendRequestLocationMessageData *)loadMeetRequestFriendRequestLocationMessage:(NSString *)messageKeyID;

/*!
 @method loadAllMeetRequestFriendRequestLocationMessage：
 @abstract 根据userID加载该用户下的所有车友位置请求消息数据
 @discussion 根据userID加载该用户下的所有车友位置请求消息数据
 @param userID 用户id
 @result messagelist 消息列表
 */
- (NSMutableArray *)loadAllMeetRequestFriendRequestLocationMessage:(NSString *)userID;

@end
