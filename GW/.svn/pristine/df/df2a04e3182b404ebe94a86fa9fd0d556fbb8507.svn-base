/*!
 @header SendToCarMessageData.m
 @abstract 操作发送到车消息表
 @author mengy
 @version 1.00 13-5-20 Creation
 */
#import "SendToCarMessageData.h"
#import <sqlite3.h>
#import "UserData.h"
@interface SendToCarMessageData(Private)

- (void)initDatabase;
- (sqlite3*)openDatabase;
@end
@implementation SendToCarMessageData
@synthesize mPoiAddress;
@synthesize mPoiName;
@synthesize mSendTime;
@synthesize mMessageKeyID;
@synthesize mLon;
@synthesize mLat;
@synthesize mKeyID;
@synthesize mEventContent;
@synthesize mEventTime;
@synthesize mPoiID;
@synthesize mSendUserID;
@synthesize mSendUserName;
@synthesize mSendUserTel;
/*!
 @method initSendToCarMessageDatabase
 @abstract 建表
 @discussion 建表
 @param 无
 @result 无
 */
- (void)initSendToCarMessageDatabase
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        char *msg;
        NSString *sql;
        do
        {
//            1	KEYID	主键	VARCHAR2(32)	是	唯一
//            2	SENDER_USER_ID	发送者用户id	VARCHAR2(32)	是		GW.M.GET_MESSAGE_LIST	senderUserId
//            3	SENDER_USER_NAME	发送者用户名称	VARCHAR2(32)	是		GW.M.GET_MESSAGE_LIST	senderUserName
//            4	SEND_TIME	发送时间	VARCHAR2(16)	是		GW.M.GET_MESSAGE_LIST	sendTime
//            5	LON	经度	DOUBLE (16)	是		GW.M.GET_MESSAGE_LIST	lon
//            6	LAT	纬度	DOUBLE (16)	是		GW.M.GET_MESSAGE_LIST	lat
//            7	POI_NAME	位置名称	VARCHAR2(32)	是		GW.M.GET_MESSAGE_LIST	poiName
//            8	POI_ID	四维永久poiId	VARCHAR2(32)			GW.M.GET_MESSAGE_LIST	poiId
//            9	POI_ADDRESS	位置地址	VARCHAR2(128)			GW.M.GET_MESSAGE_LIST	poiAddress
//            10	EVENT_TIME	日历事件提醒时间	VARCHAR2(16)			GW.M.GET_MESSAGE_LIST	eventTime
//            11	EVENT_CONTENT	日历事件提醒内容	VARCHAR2(128)			GW.M.GET_MESSAGE_LIST	eventContent
//            12	MESSAGE_KEYID	消息主键	VARCHAR2(32)		外键，关联用户消息主表
            //create MessageInfo table
            sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (KEYID TEXT NOT NULL ,SENDER_USER_ID TEXT,SENDER_USER_NAME TEXT,SENDER_USER_TEL TEXT,SEND_TIME TEXT,LON DOUBLE ,LAT DOUBLE ,POI_NAME TEXT,POI_ADDRESS TEXT,POI_ID TEXT,EVENT_TIME TEXT,EVENT_CONTENT TEXT,MESSAGE_KEYID TEXT)", TABLE_SEND_TO_CAR_MESSAGE_DATA];
            if(sqlite3_exec(database, [sql UTF8String], NULL, NULL, &msg) != SQLITE_OK)
            {
                NSLog(@"create TABLE_SEND_TO_CAR_MESSAGE_DATA table fail.");
                break;
            }
            
        }
        while (0);
        
    }
    sqlite3_close(database);

    
}

- (void)dealloc
{
    [mPoiAddress release];
    [mPoiName release];
    [mSendTime release];
    [mMessageKeyID release];
    [mKeyID release];
    [mEventContent release];
    [mEventTime release];
    [mPoiID release];
    [mSendUserID release];
    [mSendUserName release];
    [mSendUserTel release];
    
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
 @method deleteSendToCarMessage:(NSString *)messageKeyID
 @abstract 根据MESSAGE_KEYID删除消息
 @discussion 根据MESSAGE_KEYID删除消息
 @param messageKeyID 消息id
 @result 无
 */
- (void)deleteSendToCarMessage:(NSString *)messageKeyID
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        [self deleteSendToCarMessage:database
                        messageKeyID:messageKeyID];
    }
    sqlite3_close(database);
}

- (void)deleteSendToCarMessage:(sqlite3*)database
                  messageKeyID:(NSString *)messageKeyID

{
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE MESSAGE_KEYID='%@'",TABLE_SEND_TO_CAR_MESSAGE_DATA,messageKeyID];
    //NSLog(@"%@",sql);
    sqlite3_stmt *stmt;
    if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
    {
        NSLog(@"DEL SEND_TO_CAR_MESSAGE ok.");
        if(sqlite3_step(stmt) != SQLITE_DONE)
        {
            NSLog(@"DEL SEND_TO_CAR_MESSAGE error.");
        }
    }
    
    sqlite3_reset(stmt);
    sqlite3_finalize(stmt);
    
}

/*!
 @method deleteSendToCarMessageWithIDs:(NSString *)messageKeyID
 @abstract 根据id删除多个消息
 @discussion 根据id删除多个消息
 @param messageKeyID 消息id以逗号分开例如（id，id）
 @result 无
 */
- (void)deleteSendToCarMessageWithIDs:(NSString *)messageID
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        [self deleteSendToCarMessageWithDB:database
                                 messageID:messageID];
    }
    sqlite3_close(database);
}

- (void)deleteSendToCarMessageWithDB:(sqlite3 *)database
                           messageID:(NSString *)messageID
{
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE MESSAGE_KEYID IN (%@)",TABLE_SEND_TO_CAR_MESSAGE_DATA,messageID];
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
 @method deleteDemoSendToCarMessage:(NSString *)messageKeyID
 @abstract 删除demo用户消息
 @discussion 删除demo用户消息
 @param messageKeyID 消息id
 @result 无
 */
- (void)deleteDemoSendToCarMessage:(NSString *)messageKeyID
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        [self deleteDemoSendToCarMessageWithDB:database
                                  messageKeyID:messageKeyID];
    }
    sqlite3_close(database);
}
- (void)deleteDemoSendToCarMessageWithDB:(sqlite3*)database
                            messageKeyID:(NSString *)messageKeyID
{
    if ([self sendToCarMessageExist:database messageKeyID:messageKeyID]==YES)
    {
        
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE MESSAGE_KEYID='%@'",TABLE_SEND_TO_CAR_MESSAGE_DATA,messageKeyID];
        
        //NSLog(@"%@",sql);
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            NSLog(@"DEL all SEND_TO_CAR_MESSAGE ok.");
            if(sqlite3_step(stmt) != SQLITE_DONE)
            {
                NSLog(@"DEL all SEND_TO_CAR_MESSAGE error.");
            }
        }
        
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
        
    }
    else
    {
        NSLog(@"DEL all SEND_TO_CAR_MESSAGE error.");
    }
}

/*!
 @method loadMeetRequestSendToCarMessage:(NSString *)messageKeyID
 @abstract 根据messageKeyID加载消息数据
 @discussion 根据messageKeyID加载消息数据
 @param messageKeyID 消息id
 @result SendToCarMessageData 消息数据
 */
- (SendToCarMessageData *)loadMeetRequestSendToCarMessage:(NSString *)messageKeyID
{
    SendToCarMessageData *sendToCarMessage= [[[SendToCarMessageData alloc]init]autorelease];
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE MESSAGE_KEYID='%@'",TABLE_SEND_TO_CAR_MESSAGE_DATA,messageKeyID];
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            while(sqlite3_step(stmt) == SQLITE_ROW)
            {
                sendToCarMessage = [self createMSendToCarMessage:stmt];
            }
        }
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
    }
    sqlite3_close(database);
    return sendToCarMessage;
}

/*!
 @method loadAllMeetRequestSendToCarMessage:(NSString *)userID
 @abstract 根据userID加载该用户下的所有发送到车消息数据
 @discussion 根据userID加载该用户下的所有发送到车求消息数据
 @param userID 用户id
 @result messagelist 消息列表
 */
- (NSMutableArray *)loadAllMeetRequestSendToCarMessage:(NSString *)userID
{
    NSMutableArray *array = [[[NSMutableArray alloc]initWithCapacity:0]autorelease];
    SendToCarMessageData *sendToCarMessage;
    sqlite3 *database = [self openDatabase];
    if(database)
    {
//        需求变更取消排序问题
//        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE MESSAGE_KEYID IN (SELECT MESSAGEKEYID FROM %@ WHERE TYPE='4' AND USER_ID='%@' AND STATUS=0) ORDER BY SEND_TIME DESC",TABLE_SEND_TO_CAR_MESSAGE_DATA,TABLE_MESSAGE_INFO_DATA,userID];
//        sqlite3_stmt *stmt;
//        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
//        {
//            while(sqlite3_step(stmt) == SQLITE_ROW)
//            {
//                sendToCarMessage = [self createMSendToCarMessage:stmt];
//                [array addObject:sendToCarMessage];
//            }
//            //            NSLog(@"%@",searchHistory.mSearchName);
//        }
//        sqlite3_finalize(stmt);
//        
//        NSString *sql1 = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE MESSAGE_KEYID IN (SELECT MESSAGEKEYID FROM %@ WHERE TYPE='4' AND USER_ID='%@' AND STATUS=1) ORDER BY SEND_TIME DESC",TABLE_SEND_TO_CAR_MESSAGE_DATA,TABLE_MESSAGE_INFO_DATA,userID];
//        sqlite3_stmt *stmt1;
//        if(sqlite3_prepare_v2(database, [sql1 UTF8String], -1, &stmt1, nil) == SQLITE_OK)
//        {
//            while(sqlite3_step(stmt1) == SQLITE_ROW)
//            {
//                sendToCarMessage = [self createMSendToCarMessage:stmt1];
//                [array addObject:sendToCarMessage];
//            }
//            //            NSLog(@"%@",searchHistory.mSearchName);
//        }
//        sqlite3_finalize(stmt1);
        
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE MESSAGE_KEYID IN (SELECT KEYID FROM %@ WHERE TYPE= %d AND USER_ID='%@')  ORDER BY SEND_TIME DESC",TABLE_SEND_TO_CAR_MESSAGE_DATA,TABLE_MESSAGE_INFO_DATA,MESSAGE_SEND_TO_CAR,userID];
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            while(sqlite3_step(stmt) == SQLITE_ROW)
            {
                sendToCarMessage = [self createMSendToCarMessage:stmt];
                [array addObject:sendToCarMessage];
            }
        }
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
    }
    sqlite3_close(database);
    return array;
}

/*!
 @method createMSendToCarMessage:
 @abstract 将查找到的数据封装到sendToCarMessage中
 @discussion 将查找到的数据封装到sendToCarMessage中
 @param stmt　查找到的某条数据
 @param sendToCarMessage　发送到车消息
 */
- (SendToCarMessageData *)createMSendToCarMessage:(sqlite3_stmt*)stmt
{
    SendToCarMessageData *sendToCarMessage = [[[SendToCarMessageData alloc]init]autorelease];
    char *text;
    int index = 0;
//@"CREATE TABLE IF NOT EXISTS %@ (KEYID TEXT NOT NULL ,SENDER_USER_ID TEXT,SENDER_USER_NAME TEXT,SENDER_USER_TEL TEXT,SEND_TIME TEXT,LON DOUBLE ,LAT DOUBLE ,POI_NAME TEXT,POI_ADDRESS TEXT,POI_ID TEXT,EVENT_TIME TEXT,EVENT_CONTENT TEXT,MESSAGE_KEYID TEXT)",
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        sendToCarMessage.mKeyID = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        sendToCarMessage.mSendUserID = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        sendToCarMessage.mSendUserName = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        sendToCarMessage.mSendUserTel = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        sendToCarMessage.mSendTime = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        sendToCarMessage.mLon = [[NSString stringWithUTF8String:text] doubleValue];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        sendToCarMessage.mLat = [[NSString stringWithUTF8String:text] doubleValue];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        sendToCarMessage.mPoiName = [NSString stringWithUTF8String:text];
    }text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        sendToCarMessage.mPoiAddress = [NSString stringWithUTF8String:text];
    }text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        sendToCarMessage.mPoiID = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        sendToCarMessage.mEventTime = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        sendToCarMessage.mEventContent = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        sendToCarMessage.mMessageKeyID = [NSString stringWithUTF8String:text];
    }
    
    
    return sendToCarMessage;
}

/*!
 @method sendToCarMessageExist:(sqlite3*)database messageKeyID:(NSString *)messageKeyID
 @abstract 根据messageKeyID判断发送到车消息是否存在
 @discussion 根据messageKeyID判断发送到车消息是否存在
 @param messageKeyID 消息id
 @result BOOL
 */
- (BOOL)sendToCarMessageExist:(sqlite3*)database messageKeyID:(NSString *)messageKeyID
{
    int count = 0;
    NSString *sql = [NSString stringWithFormat:@"SELECT count(*) FROM %@ WHERE MESSAGE_KEYID='%@'",TABLE_SEND_TO_CAR_MESSAGE_DATA,messageKeyID];
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