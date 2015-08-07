/*!
 @header FriendLocationData.m
 @abstract 操作好友位置请求消息表
 @author mengy
 @version 1.00 14-4-1 Creation
 */

#import "FriendLocationData.h"
#import <sqlite3.h>
#import "UserData.h"
/*!
 @class
 @abstract 操作MESSAGE_FRIEND_REQUEST_LOCATION表。
 */
@interface FriendLocationData(Private)

- (void)initDatabase;
- (sqlite3*)openDatabase;
@end
@implementation FriendLocationData
@synthesize mMessageKeyID;
@synthesize mRpState;
@synthesize mKeyID;
@synthesize mRqTime;
@synthesize mDescription;
@synthesize mReqUID;
@synthesize mRpTime;
@synthesize mRqUserID;
@synthesize mRqUserName;
@synthesize mRqUserTel;
/*!
 @method initFriendLocationMessageDatabase
 @abstract 建表
 @discussion 建表
 @param 无
 @result 无
 */
- (void)initFriendLocationMessageDatabase
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        char *msg;
        NSString *sql;
        do
        {
//            1	KEYID	主键	VARCHAR2(32)	否	唯一
//            2	REQ_UID	位置请求事务id	VARCHAR2(32)	否		GW.M.GET_MESSAGE_LIST	reqUID
//            3	REQUEST_USER_ID	请求者用户id	VARCHAR2(32)	否		GW.M.GET_MESSAGE_LIST	requestUserId
//            4	REQUEST_USER_NAME	请求者名称	VARCHAR2(32)	否		GW.M.GET_MESSAGE_LIST	requestUserName
//            5	REQUEST_TIME	请求时间	VARCHAR2(16)	否		GW.M.GET_MESSAGE_LIST	requestTime
//            6	DESCRIPTION	请求描述	VARCHAR2(256)	是		GW.M.GET_MESSAGE_LIST	description
//            7	RP_STATE	状态	VARCHAR2(16)		1同意2拒绝	GW.M.HANDLE_FRIEND_LOCATION_REQUEST	state
//            8	RP_TIME	状态改变时间	VARCHAR2(16)			GW.M.HANDLE_FRIEND_LOCATION_REQUEST
//            9	MESSAGE_KEYID	消息主键	VARCHAR2(32)	否	外键，关联用户消息主表
            //create FRIEND_REQUEST_LOCATION_MESSAGE table
            sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (KEYID TEXT  NOT NULL,REQ_UID TEXT,REQUEST_USER_ID TEXT, REQUEST_USER_NAME TEXT,REQUEST_USER_TEL TEXT, REQUEST_TIME TEXT, DESCRIPTION TEXT, RP_STATE TEXT, RP_TIME TEXT, MESSAGE_KEYID TEXT)", TABLE_FRIEND_REQUEST_LOCATION_MESSAGE_DATA];
            if(sqlite3_exec(database, [sql UTF8String], NULL, NULL, &msg) != SQLITE_OK)
            {
                NSLog(@"create LOCATION_REQUEST_MESSAGE table fail.");
                break;
            }
            
        }
        while (0);
        
        sqlite3_close(database);
    }
    
}

- (void)dealloc
{
    [mMessageKeyID release];
    [mRqUserID release];
    [mRqUserTel release];
    [mRqUserName release];
    [mRqTime release];
    [mRpTime release];
    [mDescription release];
    [mReqUID release];
    [mKeyID release];
    [mRpState release];
    [super dealloc];
}

/*!
 @method openDatabase
 @abstract 打开数据库
 @discussion 打开数据库
 @param 无
 @result database　数据库
 */
- (sqlite3*)openDatabase
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *databaseFilePath = [documentsDirectory stringByAppendingPathComponent:DATABASE_NAME];
    
    NSLog(@"  open database  path=%@",databaseFilePath);
    sqlite3 *database;
    int result = sqlite3_open([databaseFilePath UTF8String], &database);
    if(result == SQLITE_OK)
    {
        return database;
    }
    else
    {
        return nil;
    }
}

/*!
 @method updateFriendLocationMessageRpState： state: rpTime:
 @abstract 更新位置请求消息状态
 @discussion 更新位置请求消息状态
 @param messageKeyID 消息id
 @param state 状态
 @param rpTime 应答时间
 @result 无
 */
- (void)updateFriendLocationMessageRpState:(NSString *)messageKeyID state:(int)state rpTime:(NSString *)rpTime
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        [self updateFriendLocationMessageRPStatusWithDB:database
                                              messageID:messageKeyID
                                                  state:state
                                                 rpTime:rpTime];
        
    }
    sqlite3_close(database);
}

- (void)updateFriendLocationMessageRPStatusWithDB:(sqlite3*)database messageID:(NSString *)messageKeyID state:(int)state rpTime:(NSString *)rpTime
{
    if ([self friendLocatioMessageExist:database messageID:messageKeyID]==YES) {
        NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET RP_STATE='%d',RP_TIME='%@' WHERE MESSAGE_KEYID='%@' ",TABLE_FRIEND_REQUEST_LOCATION_MESSAGE_DATA,state,rpTime,messageKeyID];
        //NSLog(@"%@",sql);
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            //            int index = 1;
            //            sqlite3_bind_text(stmt, index++, [ID UTF8String], -1, NULL);
            //        sqlite3_bind_int(stmt, index++, mSelectedCar);
            NSLog(@"update FRIEND_LOCATION ok.");
            if(sqlite3_step(stmt) != SQLITE_DONE)
            {
                NSLog(@"update FRIEND_LOCATION error.");
            }
        }
        
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
        
    }
}

/*!
 @method deleteFriendLocationMessage：
 @abstract 根据MESSAGE_KEYID删除消息
 @discussion 根据MESSAGE_KEYID删除消息
 @param messageID 消息id
 @result 无
 */
- (void)deleteFriendLocationMessage:(NSString *)messageID
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        [self deleteFriendLocationMessage:database
                            messageID:messageID];
        
    }
    sqlite3_close(database);
}

- (void)deleteFriendLocationMessage:(sqlite3*)database
                     messageID:(NSString *)messageID

{
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE MESSAGE_KEYID='%@'",TABLE_FRIEND_REQUEST_LOCATION_MESSAGE_DATA,messageID];
    //NSLog(@"%@",sql);
    sqlite3_stmt *stmt;
    if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
    {
        //            int index = 1;
        //            sqlite3_bind_text(stmt, index++, [fID UTF8String], -1, NULL);
        //        sqlite3_bind_int(stmt, index++, mSelectedCar);
        NSLog(@"DEL FRIEND_LOCATION_MESSAGE ok.");
        if(sqlite3_step(stmt) != SQLITE_DONE)
        {
            NSLog(@"DEL FRIEND_LOCATION_MESSAGE error.");
        }
    }
    
    sqlite3_reset(stmt);
    sqlite3_finalize(stmt);
    
}

/*!
 @method deleteFriendLocationMessageWithIDs：
 @abstract 根据id删除多个消息
 @discussion 根据id删除多个消息
 @param messageID 消息id以逗号分开例如（id，id）
 @result 无
 */
- (void)deleteFriendLocationMessageWithIDs:(NSString *)messageID
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        [self deleteFriendLocationMessageWithDB:database
                                             messageID:messageID];
    }
    sqlite3_close(database);
}

- (void)deleteFriendLocationMessageWithDB:(sqlite3 *)database
                                       messageID:(NSString *)messageID
{
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE MESSAGE_KEYID IN (%@)",TABLE_FRIEND_REQUEST_LOCATION_MESSAGE_DATA,messageID];
    NSLog(@"%@",sql);
    sqlite3_stmt *stmt;
    if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
    {
        NSLog(@"DEL message ok.");
        int result = sqlite3_step(stmt);
        if( result != SQLITE_DONE)
        {
            NSLog(@"DEL message error.");
        }
    }
    sqlite3_reset(stmt);
    sqlite3_finalize(stmt);
}

/*!
 @method deleteDemoFriendLocationMessage：
 @abstract 删除demo用户消息
 @discussion 删除demo用户消息
 @param messageKeyID 消息id
 @result 无
 */
- (void)deleteDemoFriendLocationMessage:(NSString *)messageKeyID
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        [self deleteDemoMessage:database
                 messageKeyID:messageKeyID];
        
    }
    sqlite3_close(database);
}
- (void)deleteDemoMessage:(sqlite3*)database
           messageKeyID:(NSString *)messageKeyID

{
    if ([self friendLocatioMessageExist:database messageID:messageKeyID]==YES)
    {
        
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE MESSAGE_KEYID='%@'",TABLE_FRIEND_REQUEST_LOCATION_MESSAGE_DATA,messageKeyID];
        
        NSLog(@"%@",sql);
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            //            int index = 1;
            //            sqlite3_bind_text(stmt, index++, [fID UTF8String], -1, NULL);
            //        sqlite3_bind_int(stmt, index++, mSelectedCar);
            NSLog(@"DEL all FRIEND_REQUEST_LOCATION ok.");
            if(sqlite3_step(stmt) != SQLITE_DONE)
            {
                NSLog(@"DEL all FRIEND_REQUEST_LOCATION error.");
            }
        }
        
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
        
    }
    else
    {
        NSLog(@"DEL all friend error.");
    }
}





/*!
 @method loadMeetRequestFriendLocationMessage：
 @abstract 根据messageID加载消息数据
 @discussion 根据messageID加载消息数据
 @param messageID 消息id
 @result FriendLocationData 消息数据
 */
- (FriendLocationData *)loadMeetRequestFriendLocationMessage:(NSString *)messageID
{
    FriendLocationData *friendLocationData= [[[FriendLocationData alloc]init]autorelease];
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE MESSAGE_KEYID='%@'",TABLE_FRIEND_REQUEST_LOCATION_MESSAGE_DATA,messageID];
        NSLog(@"%@",sql);
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            while(sqlite3_step(stmt) == SQLITE_ROW)
            {
                friendLocationData = [self createMFriendLocatioMessage:stmt];

            }
            //            NSLog(@"%@",searchHistory.mSearchName);
        }
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
    }
    sqlite3_close(database);
    return friendLocationData;
}

/*!
 @method loadAllMeetRequestFriendLocationMessage：
 @abstract 根据userID加载该用户下的所有车友位置请求消息数据
 @discussion 根据userID加载该用户下的所有车友位置请求消息数据
 @param userID 用户id
 @result messagelist 消息列表
 */
- (NSMutableArray *)loadAllMeetRequestFriendLocationMessage:(NSString *)userID
{
    NSMutableArray *array = [[[NSMutableArray alloc]initWithCapacity:0]autorelease];
    //FriendLocationData *friendLocationData= [[[FriendLocationData alloc]init]autorelease];
    FriendLocationData *friendLocationData;
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE MESSAGE_KEYID IN (SELECT KEYID FROM %@ WHERE TYPE= %d AND USER_ID='%@') ORDER BY REQUEST_TIME DESC",TABLE_FRIEND_REQUEST_LOCATION_MESSAGE_DATA,TABLE_MESSAGE_INFO_DATA,MESSAGE_FRIEND_REQUEST_LOCATION,userID];
//        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@",TABLE_FRIEND_REQUEST_LOCATION_MESSAGE_DATA];
        
        NSLog(@"%@",sql);
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            while(sqlite3_step(stmt) == SQLITE_ROW)
            {
                friendLocationData = [self createMFriendLocatioMessage:stmt];
                [array addObject:friendLocationData];
            }
            //            NSLog(@"%@",searchHistory.mSearchName);
        }
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
    }
    sqlite3_close(database);
    //        需求变更取消排序问题
//    {
//        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE MESSAGE_ID IN (SELECT MESSAGEKEYID FROM %@ WHERE TYPE='2' AND USER_ID='%@' AND STATUS=0) ORDER BY TIME DESC",TABLE_FRIEND_REQUEST_LOCATION_MESSAGE_DATA,TABLE_MESSAGE_INFO_DATA,userID];
//        sqlite3_stmt *stmt;
//        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
//        {
//            while(sqlite3_step(stmt) == SQLITE_ROW)
//            {
//                friendLocationData = [self createMFriendLocatioMessage:stmt];
//                [array addObject:friendLocationData];
//            }
//            //            NSLog(@"%@",searchHistory.mSearchName);
//        }
//        sqlite3_finalize(stmt);
//        
//        NSString *sql1 = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE MESSAGE_ID IN (SELECT MESSAGEKEYID FROM %@ WHERE TYPE='2' AND USER_ID='%@' AND STATUS=1) ORDER BY TIME DESC",TABLE_FRIEND_REQUEST_LOCATION_MESSAGE_DATA,TABLE_MESSAGE_INFO_DATA,userID];
//        sqlite3_stmt *stmt1;
//        if(sqlite3_prepare_v2(database, [sql1 UTF8String], -1, &stmt1, nil) == SQLITE_OK)
//        {
//            while(sqlite3_step(stmt1) == SQLITE_ROW)
//            {
//                friendLocationData = [self createMFriendLocatioMessage:stmt1];
//                [array addObject:friendLocationData];
//            }
//            //            NSLog(@"%@",searchHistory.mSearchName);
//        }
//        sqlite3_finalize(stmt1);
//    }
    return array;
}

/*!
 @method createMFriendLocatioMessage:
 @abstract 将查找到的数据封装到friendLocationData中
 @discussion 将查找到的数据封装到friendLocationData中
 @param stmt　查找到的某条数据
 @param friendLocationData　车友位置请求消息
 */
- (FriendLocationData *)createMFriendLocatioMessage:(sqlite3_stmt*)stmt
{
//    @"CREATE TABLE IF NOT EXISTS %@ (KEYID TEXT  NOT NULL,REQ_UID TEXT,REQUEST_USER_ID TEXT, REQUEST_USER_NAME TEXT,REQUEST_USER_TEL TEXT, REQUEST_TIME TEXT, DESCRIPTION TEXT, RP_STATE TEXT, RP_TIME TEXT, MESSAGE_KEYID TEXT)", 
     FriendLocationData *friendLocationData= [[[FriendLocationData alloc]init]autorelease];
    char *text;
    int index = 0;
    
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        friendLocationData.mKeyID = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        friendLocationData.mReqUID = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        friendLocationData.mRqUserID = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        friendLocationData.mRqUserName = [NSString stringWithUTF8String:text];
    }
    
    
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        friendLocationData.mRqUserTel = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        friendLocationData.mRqTime = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        friendLocationData.mDescription = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        friendLocationData.mRpState = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        friendLocationData.mRpTime = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        friendLocationData.mMessageKeyID = [NSString stringWithUTF8String:text];
    }
    return friendLocationData;
}

/*!
 @method friendLocatioMessageExist:
 @abstract 根据MESSAGE_KEYID查找该数据是否在表中存在
 @discussion 根据MESSAGE_KEYID查找该数据是否在表中存在
 @param messageID　消息id
 @param bool　
 */
- (BOOL)friendLocatioMessageExist:(sqlite3*)database messageID:(NSString *)messageID
{
    int count = 0;
    NSString *sql = [NSString stringWithFormat:@"SELECT count(*) FROM %@ WHERE MESSAGE_KEYID='%@'",TABLE_FRIEND_REQUEST_LOCATION_MESSAGE_DATA,messageID];
    sqlite3_stmt *stmt;
    if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
    {
        if(sqlite3_step(stmt) == SQLITE_ROW)
        {
            count = sqlite3_column_int(stmt, 0);
        }
    }
    sqlite3_reset(stmt);
    sqlite3_finalize(stmt);
    //    NSLog(@"%d",count);
    return count != 0;
}

@end