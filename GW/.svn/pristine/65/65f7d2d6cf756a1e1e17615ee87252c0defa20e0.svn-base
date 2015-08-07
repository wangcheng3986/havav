/*!
 @header FriendRequestLocationMessageData.m
 @abstract 操作好友位置消息表
 @author mengy
 @version 1.00 13-5-20 Creation
 */

#import "FriendRequestLocationMessageData.h"
#import <sqlite3.h>
#import "UserData.h"
/*!
 @class
 @abstract 操作MESSAGE_FRIEND_LOCATION表。
 */
@interface FriendRequestLocationMessageData(Private)

- (void)initDatabase;
- (sqlite3*)openDatabase;
@end
@implementation FriendRequestLocationMessageData
@synthesize mFriendUserID;
@synthesize mFriendUserName;
@synthesize mFriendUserTel;
@synthesize mKeyID;
@synthesize mLat;
@synthesize mLon;
@synthesize mMessageKeyID;
@synthesize mResponseTime;
@synthesize mPoiAddress;
@synthesize mPoiName;
@synthesize mSendTime;
@synthesize mUploadTime;
@synthesize mLicenseNumber;

/*!
 @method initFriendRequestLocationMessageDatabase
 @abstract 建表
 @discussion 建表
 @param 无
 @result 无
 */
- (void)initFriendRequestLocationMessageDatabase
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        char *msg;
        NSString *sql;
        do
        {
//            1	KEYID	主键	VARCHAR2(32)	否	唯一
//            2	SEND_TIME	车友位置请求发送时间	VARCHAR2(16)	否		GW.M.GET_MESSAGE_LIST	sendTime
//            3	FRIEND_USER_ID	车友（应答者）用户id	VARCHAR2(32)	否		GW.M.GET_MESSAGE_LIST	friendUserId
//            4	FRIEND_USER_NAME	车友（应答者）名称	VARCHAR2(32)	否		GW.M.GET_MESSAGE_LIST	friendUserName
//            5	FRIEND_USER_TEL	车友（应答者）手机号，用于添加黑名单或车友	VARCHAR2(32)	否
//            6	RESPONSE_TIME	车友（应答者）处理请求时间	VARCHAR2(16)	否		GW.M.GET_MESSAGE_LIST	responseTime
//            7	UPLOAD_TIME	位置上传时间	VARCHAR2(16)	否		GW.M.GET_MESSAGE_LIST	uploadTime
//            8	LON	经度	DOUBLE (16)	否		GW.M.GET_MESSAGE_LIST	lon
//            9	LAT	纬度	DOUBLE (16)	否		GW.M.GET_MESSAGE_LIST	lat
//            10	POI_NAME	位置名称	VARCHAR2(32)	否		GW.M.GET_MESSAGE_LIST	poiName
//            11	POI_ADDRESS	位置地址	VARCHAR2(128)	是		GW.M.GET_MESSAGE_LIST	poiAddress
//            12	MESSAGE_KEYID	消息主键	VARCHAR2(32)	否	外键，关联用户消息主表
            //create FRIEND_REQUEST_LOCATION_MESSAGE table
            sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (KEYID TEXT NOT NULL,SEND_TIME TEXT,FRIEND_USER_ID TEXT,FRIEND_USER_NAME TEXT,FRIEND_USER_TEL TEXT,RESPONSE_TIME TEXT,UPLOAD_TIME TEXT, LON DOUBLE, LAT DOUBLE, POI_NAME TEXT, POI_ADDRESS TEXT,LICENSE_NUMBER TEXT, MESSAGE_KEYID TEXT)", TABLE_FRIEND_LOCATION_MESSAGE_DATA];
            if(sqlite3_exec(database, [sql UTF8String], NULL, NULL, &msg) != SQLITE_OK)
            {
                NSLog(@"create FRIEND_REQUEST_LOCATION_MESSAGE table fail.");
                break;
            }
            
        }
        while (0);
        
        sqlite3_close(database);
    }
    
}

- (void)dealloc
{
    [mKeyID release];
    [mFriendUserTel release];
    [mFriendUserName release];
    [mFriendUserID release];
    [mMessageKeyID release];
    [mSendTime release];
    [mUploadTime release];
    [mPoiName release];
    [mPoiAddress release];
    [mResponseTime release];
    [mLicenseNumber release];
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
    
    //NSLog(@"  open database  path=%@",databaseFilePath);
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
 @method deleteFriendRequestLocationMessage：
 @abstract 根据messageKeyID删除消息
 @discussion 根据messageKeyID删除消息
 @param messageID 消息id
 @result 无
 */
- (void)deleteFriendRequestLocationMessage:(NSString *)messageKeyID
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        [self deleteFriendRequestLocationMessage:database
                                    messageKeyID:(NSString *)messageKeyID];
        
    }
    sqlite3_close(database);
}

- (void)deleteFriendRequestLocationMessage:(sqlite3*)database
                              messageKeyID:(NSString *)messageKeyID

{
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE MESSAGE_KEYID='%@'",TABLE_FRIEND_LOCATION_MESSAGE_DATA,messageKeyID];
    //NSLog(@"%@",sql);
    sqlite3_stmt *stmt;
    if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
    {
        NSLog(@"DEL FRIEND_REQUEST_LOCATION_MESSAGE ok.");
        if(sqlite3_step(stmt) != SQLITE_DONE)
        {
            NSLog(@"DEL FRIEND_REQUEST_LOCATION_MESSAGE error.");
        }
    }
    
    sqlite3_reset(stmt);
    sqlite3_finalize(stmt);
    
}

/*!
 @method deleteFriendRequestLocationMessage：
 @abstract 根据id删除多个消息
 @discussion 根据id删除多个消息
 @param messageID 消息id以逗号分开例如（id，id）
 @result 无
 */
- (void)deleteFriendRequestLocationMessageWithIDs:(NSString *)messageKeyID
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        [self deleteFriendRequestLocationMessageWithDB:database
                                       messageKeyID:messageKeyID];
    }
    sqlite3_close(database);
}

- (void)deleteFriendRequestLocationMessageWithDB:(sqlite3 *)database
                                 messageKeyID:(NSString *)messageKeyID
{
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE MESSAGE_KEYID IN (%@)",TABLE_FRIEND_LOCATION_MESSAGE_DATA,messageKeyID];
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
 @method deleteDemoFriendRequestLocationMessage：
 @abstract 删除demo用户消息
 @discussion 删除demo用户消息
 @param messageKeyID 消息id
 @result 无
 */
- (void)deleteDemoFriendRequestLocationMessage:(NSString *)messageKeyID
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
    if ([self friendRequestLocationMessageExist:database messageKeyID:messageKeyID]==YES)
    {
        
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE MESSAGE_KEYID='%@'",TABLE_FRIEND_LOCATION_MESSAGE_DATA,messageKeyID];
        
        //NSLog(@"%@",sql);
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            NSLog(@"DEL all FRIEND_LOCATION_MESSAGE ok.");
            if(sqlite3_step(stmt) != SQLITE_DONE)
            {
                NSLog(@"DEL all FRIEND_LOCATION_MESSAGE error.");
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
 @method loadMeetRequestFriendRequestLocationMessage：
 @abstract 根据messageID加载消息数据
 @discussion 根据messageID加载消息数据
 @param messageID 消息id
 @result FriendRequestLocationMessageData 消息数据
 */
- (FriendRequestLocationMessageData *)loadMeetRequestFriendRequestLocationMessage:(NSString *)messageKeyID
{
    FriendRequestLocationMessageData *friendRequestLocationMessage= [[[FriendRequestLocationMessageData alloc]init]autorelease];
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE MESSAGE_KEYID='%@'",TABLE_FRIEND_LOCATION_MESSAGE_DATA,messageKeyID];
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            while(sqlite3_step(stmt) == SQLITE_ROW)
            {
                friendRequestLocationMessage = [self createMFriendRequestLocationMessage:stmt];
            }
            //            NSLog(@"%@",searchHistory.mSearchName);
        }
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
    }
    sqlite3_close(database);
    return friendRequestLocationMessage;
}

/*!
 @method loadAllMeetRequestFriendRequestLocationMessage：
 @abstract 根据userID加载该用户下的所有车友位置请求消息数据
 @discussion 根据userID加载该用户下的所有车友位置请求消息数据
 @param userID 用户id
 @result messagelist 消息列表
 */
- (NSMutableArray *)loadAllMeetRequestFriendRequestLocationMessage:(NSString *)userID;
{
    NSMutableArray *array = [[[NSMutableArray alloc]initWithCapacity:0]autorelease];
    FriendRequestLocationMessageData *friendRequestLocationMessage;
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE MESSAGE_KEYID IN (SELECT KEYID FROM %@ WHERE TYPE= %d AND USER_ID='%@') ORDER BY RESPONSE_TIME DESC",TABLE_FRIEND_LOCATION_MESSAGE_DATA,TABLE_MESSAGE_INFO_DATA,MESSAGE_FRIEND_LOCATION,userID];
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            while(sqlite3_step(stmt) == SQLITE_ROW)
            {
                friendRequestLocationMessage = [self createMFriendRequestLocationMessage:stmt];
                [array addObject:friendRequestLocationMessage];
            }
            //            NSLog(@"%@",searchHistory.mSearchName);
        }
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
    }
    
    //        需求变更取消排序问题
//    if(database)
//    {
//        
//        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE MESSAGE_KEYID IN (SELECT MESSAGEKEYID FROM %@ WHERE TYPE='3' AND USER_ID='%@' AND STATUS=0) ORDER BY RP_TIME DESC",TABLE_FRIEND_LOCATION_MESSAGE_DATA,TABLE_MESSAGE_INFO_DATA,userID];
//        sqlite3_stmt *stmt;
//        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
//        {
//            while(sqlite3_step(stmt) == SQLITE_ROW)
//            {
//                friendRequestLocationMessage = [self createMFriendRequestLocationMessage:stmt];
//                [array addObject:friendRequestLocationMessage];
//            }
//            //            NSLog(@"%@",searchHistory.mSearchName);
//        }
//        sqlite3_finalize(stmt);
//        
//        NSString *sql1 = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE MESSAGE_KEYID IN (SELECT MESSAGEKEYID FROM %@ WHERE TYPE='3' AND USER_ID='%@' AND STATUS=1) ORDER BY RP_TIME DESC",TABLE_FRIEND_LOCATION_MESSAGE_DATA,TABLE_MESSAGE_INFO_DATA,userID];
//        sqlite3_stmt *stmt1;
//        if(sqlite3_prepare_v2(database, [sql1 UTF8String], -1, &stmt1, nil) == SQLITE_OK)
//        {
//            while(sqlite3_step(stmt1) == SQLITE_ROW)
//            {
//                friendRequestLocationMessage = [self createMFriendRequestLocationMessage:stmt1];
//                [array addObject:friendRequestLocationMessage];
//            }
//            //            NSLog(@"%@",searchHistory.mSearchName);
//        }
//        sqlite3_finalize(stmt1);
//    }
    sqlite3_close(database);
    return array;
}

/*!
 @method createMFriendRequestLocationMessage:
 @abstract 将查找到的数据封装到friendRequestLocationMessage中
 @discussion 将查找到的数据封装到friendRequestLocationMessage中
 @param stmt　查找到的某条数据
 @param friendRequestLocationMessage　车友位置请求消息
 */
- (FriendRequestLocationMessageData *)createMFriendRequestLocationMessage:(sqlite3_stmt*)stmt
{
//    @"CREATE TABLE IF NOT EXISTS %@ (KEYID TEXT NOT NULL,SEND_TIME TEXT,FRIEND_USER_ID TEXT,FRIEND_USER_NAME TEXT,FRIEND_USER_TEL TEXT,RESPONSE_TIME TEXT,UPLOAD_TIME TEXT, LON DOUBLE, LAT DOUBLE, POI_NAME TEXT, POI_ADDRESS TEXT, MESSAGE_KEYID TEXT)"
     FriendRequestLocationMessageData *friendRequestLocationMessage= [[[FriendRequestLocationMessageData alloc]init]autorelease];
    char *text;
    int index = 0;
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        friendRequestLocationMessage.mKeyID = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        friendRequestLocationMessage.mSendTime = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        friendRequestLocationMessage.mFriendUserID = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        friendRequestLocationMessage.mFriendUserName = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        friendRequestLocationMessage.mFriendUserTel = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        friendRequestLocationMessage.mResponseTime = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        friendRequestLocationMessage.mUploadTime = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        friendRequestLocationMessage.mLon = [[NSString stringWithUTF8String:text] doubleValue];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        friendRequestLocationMessage.mLat = [[NSString stringWithUTF8String:text] doubleValue];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        friendRequestLocationMessage.mPoiName = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        friendRequestLocationMessage.mPoiAddress = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        friendRequestLocationMessage.mLicenseNumber = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        friendRequestLocationMessage.mMessageKeyID = [NSString stringWithUTF8String:text];
    }
    
    return friendRequestLocationMessage;
}

/*!
 @method friendRequestLocationMessageExist:
 @abstract 根据MESSAGE_KEYID查找该数据是否在表中存在
 @discussion 根据MESSAGE_KEYID查找该数据是否在表中存在
 @param messageID　消息id
 @param bool
 */
- (BOOL)friendRequestLocationMessageExist:(sqlite3*)database messageKeyID:(NSString *)messageKeyID
{
    int count = 0;
    NSString *sql = [NSString stringWithFormat:@"SELECT count(*) FROM %@ WHERE MESSAGE_KEYID='%@'",TABLE_FRIEND_LOCATION_MESSAGE_DATA,messageKeyID];
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