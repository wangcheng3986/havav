
/*!
 @header SystemMessageData.h
 @abstract 操作发送到车消息表
 @author mengy
 @version 1.00 13-5-21 Creation
 */
#define TABLE_SYSTEM_MESSAGE_DATA          @"_SYSTEM_MESSAGE_DATA"
#import <Foundation/Foundation.h>
#import "UserData.h"
#import "MessageInfoData.h"
@interface SystemMessageData : NSObject
{
    NSString *mKeyID;
    NSString *mSendDate;
    NSString *mContent;
    NSString *mMessageID;
}
@property(nonatomic,copy)NSString *mKeyID;
@property(nonatomic,copy)NSString *mSendDate;
@property(nonatomic,copy)NSString *mContent;
@property(nonatomic,copy)NSString *mMessageID;
/*!
 @method initSystemMessageDatabase
 @abstract 建表
 @discussion 建表
 @param 无
 @result 无
 */
- (void)initSystemMessageDatabase;
//-(void)addSystemMessagee:(NSString *)keyID
//                sendDate:(NSString *)sendDate
//                 content:(NSString *)content
//               messageID:(NSString *)messageID;

/*!
 @method updateSystemMessage:(NSString *)keyID sendDate:(NSString *)sendDate content:(NSString *)content messageID:(NSString *)messageID
 @abstract 更新或添加系统消息
 @discussion 更新或添加系统消息
 @param 系统消息
 @result 无
 */
- (void)updateSystemMessage:(NSString *)keyID
                   sendDate:(NSString *)sendDate
                    content:(NSString *)content
                  messageID:(NSString *)messageID;

/*!
 @method deleteSystemMessage:(NSString *)messageID
 @abstract 根据messageID删除系统消息
 @discussion 根据messageID删除系统消息
 @param messageID 消息id
 @result 无
 */
- (void)deleteSystemMessage:(NSString *)messageID;

/*!
 @method deleteAllSystemMessage:(NSString *)messageID
 @abstract 删除所有系统消息，后续可能要重写
 @discussion 删除所有系统消息，后续可能要重写
 @param messageID 消息id
 @result 无
 */
- (void)deleteAllSystemMessage:(NSString *)messageID;

/*!
 @method loadMeetRequestSystemMessage:(NSString *)messageID
 @abstract 根据messageID加载消息数据，有问题，后续可能要重写
 @discussion 根据messageID加载消息数据，有问题，后续可能要重写
 @param messageID 消息id
 @result SystemMessageList 消息列表
 */
- (NSMutableArray *)loadMeetRequestSystemMessage:(NSString *)messageID;
/*!
 @method loadAllMeetRequestSystemMessage:(NSString *)userID
 @abstract 根据userID加载消息数据
 @discussion 根据messageID加载消息数据
 @param userID 所属用户id
 @result SystemMessageList 消息列表
 */
- (NSMutableArray *)loadAllMeetRequestSystemMessage:(NSString *)userID;
@end
