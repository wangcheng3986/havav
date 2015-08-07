
/*!
 @header SystemMessageData.m
 @abstract 操作发送到车消息表
 @author mengy
 @version 1.00 13-5-21 Creation
 */


#import "SystemMessageData.h"
#import <sqlite3.h>
#import "UserData.h"
@interface SystemMessageData(Private)

- (void)initDatabase;
- (sqlite3*)openDatabase;
@end
@implementation SystemMessageData
@synthesize mMessageID;
@synthesize mContent;
@synthesize mSendDate;
@synthesize mKeyID;
/*!
 @method initSystemMessageDatabase
 @abstract 建表
 @discussion 建表
 @param 无
 @result 无
 */
- (void)initSystemMessageDatabase
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        char *msg;
        NSString *sql;
        do
        {
            //create FRIEND_REQUEST_LOCATION_MESSAGE table
            sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (KEYID TEXT PRIMARY KEY,SEND_DATE TEXT ,CONTENT TEXT ,MESSAGE_ID TEXT )", TABLE_SYSTEM_MESSAGE_DATA];
            if(sqlite3_exec(database, [sql UTF8String], NULL, NULL, &msg) != SQLITE_OK)
            {
                NSLog(@"create TABLE_SYSTEM_MESSAGE_DATA table fail.");
                break;
            }
            
        }
        while (0);
        
        
    }
    sqlite3_close(database);
    
}

- (void)dealloc
{
    [mKeyID release];
    [mSendDate release];
    [mContent release];
    [mMessageID release];
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
//@"CREATE TABLE IF NOT EXISTS %@ (KEYID INTEGER PRIMARY KEY AUTOINCREMENT,SEND_DATE TEXT ,CONTENT TEXT ,MESSAGE_ID TEXT )"
//-(void)addSystemMessagee:(NSString *)keyID
//                sendDate:(NSString *)sendDate
//                 content:(NSString *)content
//               messageID:(NSString *)messageID
//
//{
//    sqlite3 *database = [self openDatabase];
//    if(database)
//    {
//        [self addSystemMessage:database
//                         keyID:keyID
//                      sendDate:sendDate
//                       content:content
//                     messageID:messageID
//         ];
//        
//    }
//    sqlite3_close(database);
//}
//
//- (void)addSystemMessage:(sqlite3 *)database
//                   keyID:(NSString *)keyID
//                sendDate:(NSString *)sendDate
//                 content:(NSString *)content
//               messageID:(NSString *)messageID
//{
//    //@"CREATE TABLE IF NOT EXISTS %@ (KEYID INTEGER PRIMARY KEY AUTOINCREMENT,SEND_DATE TEXT ,CONTENT TEXT ,MESSAGE_ID TEXT )"
//    NSString *sql=[NSString stringWithFormat:@"INSERT INTO %@(KEYID, SEND_DATE,CONTENT,MESSAGE_ID) VALUES('%@','%@','%@','%@')",TABLE_SYSTEM_MESSAGE_DATA,keyID,sendDate,content,messageID];
//    sqlite3_stmt *stmt;
//    if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
//    {
//        //        int index = 1;
//        //        sqlite3_bind_text(stmt, index++, [ID UTF8String], -1, NULL);
//        //        sqlite3_bind_int(stmt, index++, mSelectedCar);
//        NSLog(@"add SYSTEM_MESSAGE ok.");
//        if(sqlite3_step(stmt) != SQLITE_DONE)
//        {
//            NSLog(@"add SYSTEM_MESSAGE error.");
//        }
//    }
//    sqlite3_reset(stmt);
//    sqlite3_finalize(stmt);
//}

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
                  messageID:(NSString *)messageID
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        [self updateSystemMessage:database
                            keyID:keyID
                         sendDate:sendDate
                          content:content
                        messageID:messageID];
    }
    sqlite3_close(database);
}

/*!
 @method updateSystemMessage:(sqlite3 *)database keyID:(NSString *)keyID sendDate:(NSString *)sendDate content:(NSString *)content messageID:(NSString *)messageID
 @abstract 更新或添加系统消息
 @discussion 更新或添加系统消息
 @param 系统消息
 @result 无
 */
- (void)updateSystemMessage:(sqlite3 *)database
                      keyID:(NSString *)keyID
                   sendDate:(NSString *)sendDate
                    content:(NSString *)content
                  messageID:(NSString *)messageID
{ //@"CREATE TABLE IF NOT EXISTS %@ (KEYID INTEGER PRIMARY KEY AUTOINCREMENT,SEND_DATE TEXT ,CONTENT TEXT ,MESSAGE_ID TEXT )"
    if ([self systemMessageExist:database messageID:messageID]==YES) {
        NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET KEYID='%@', SEND_DATE='%@',CONTENT='%@' WHERE MESSAGE_ID='%@'",TABLE_SYSTEM_MESSAGE_DATA,keyID,sendDate,content,messageID];
        NSLog(@"%@",sql);
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            //            int index = 1;
            //            sqlite3_bind_text(stmt, index++, [ID UTF8String], -1, NULL);
            //        sqlite3_bind_int(stmt, index++, mSelectedCar);
            NSLog(@"update SYSTEM_MESSAGE ok.");
            if(sqlite3_step(stmt) != SQLITE_DONE)
            {
                NSLog(@"update SYSTEM_MESSAGE error.");
            }
        }
        
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
        
    }
    else
    {
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@(KEYID, SEND_DATE,CONTENT,MESSAGE_ID) VALUES('%@','%@','%@','%@')",TABLE_SYSTEM_MESSAGE_DATA,keyID,sendDate,content,messageID];
        NSLog(@"%@",sql);
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            //            int index = 1;
            //            sqlite3_bind_text(stmt, index++, [fID UTF8String], -1, NULL);
            //        sqlite3_bind_int(stmt, index++, mSelectedCar);
            NSLog(@"add SYSTEM_MESSAGE ok.");
            if(sqlite3_step(stmt) != SQLITE_DONE)
            {
                NSLog(@"add SYSTEM_MESSAGE error.");
            }
        }
        
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
    }
}

/*!
 @method deleteSystemMessage:(NSString *)messageID
 @abstract 根据messageID删除系统消息
 @discussion 根据messageID删除系统消息
 @param messageID 消息id
 @result 无
 */
- (void)deleteSystemMessage:(NSString *)messageID
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        [self deleteSystemMessage:database messageID:(NSString *)messageID];
    }
    sqlite3_close(database);

}

/*!
 @method deleteSystemMessage:(sqlite3*)database messageID:(NSString *)messageID
 @abstract 根据messageID删除系统消息
 @discussion 根据messageID删除系统消息
 @param database 数据库
 @param messageID 消息id
 @result 无
 */
- (void)deleteSystemMessage:(sqlite3*)database
                  messageID:(NSString *)messageID

{
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE MESSAGE_ID='%@'",TABLE_SYSTEM_MESSAGE_DATA,messageID];
    NSLog(@"%@",sql);
    sqlite3_stmt *stmt;
    if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
    {
        //            int index = 1;
        //            sqlite3_bind_text(stmt, index++, [fID UTF8String], -1, NULL);
        //        sqlite3_bind_int(stmt, index++, mSelectedCar);
        NSLog(@"DEL SYSTEM_MESSAGE ok.");
        if(sqlite3_step(stmt) != SQLITE_DONE)
        {
            NSLog(@"DEL SYSTEM_MESSAGE error.");
        }
    }
    sqlite3_reset(stmt);
    sqlite3_finalize(stmt);
    
}

/*!
 @method deleteAllSystemMessage:(NSString *)messageID
 @abstract 删除所有系统消息，后续可能要重写
 @discussion 删除所有系统消息，后续可能要重写
 @param messageID 消息id
 @result 无
 */
- (void)deleteAllSystemMessage:(NSString *)messageID
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        [self deleteAllMessage:database
                 messageID:messageID];
    }
    sqlite3_close(database);

}
/*!
 @method deleteAllMessage:(sqlite3*)database messageID:(NSString *)messageID
 @abstract 删除所有系统消息，后续可能要重写
 @discussion 删除所有系统消息，后续可能要重写
 @param messageID 消息id
 @result 无
 */
- (void)deleteAllMessage:(sqlite3*)database
           messageID:(NSString *)messageID{
    if ([self systemMessageExist:database messageID:messageID]==YES)
    {
        
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE MESSAGE_ID='%@'",TABLE_SYSTEM_MESSAGE_DATA,messageID];
        
        NSLog(@"%@",sql);
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            //            int index = 1;
            //            sqlite3_bind_text(stmt, index++, [fID UTF8String], -1, NULL);
            //        sqlite3_bind_int(stmt, index++, mSelectedCar);
            NSLog(@"DEL all SYSTEM_MESSAGE ok.");
            if(sqlite3_step(stmt) != SQLITE_DONE)
            {
                NSLog(@"DEL all SYSTEM_MESSAGE error.");
            }
        }
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
        
    }
    else
    {
        NSLog(@"DEL all SYSTEM_MESSAGE error.");
    }
}
/*!
 @method loadMeetRequestSystemMessage:(NSString *)messageID
 @abstract 根据messageID加载消息数据，有问题，后续可能要重写
 @discussion 根据messageID加载消息数据，有问题，后续可能要重写
 @param messageID 消息id
 @result SystemMessageList 消息列表
 */
- (NSMutableArray *)loadMeetRequestSystemMessage:(NSString *)messageID
{
    NSMutableArray *array = [[[NSMutableArray alloc]initWithCapacity:0]autorelease];
    //SystemMessageData *systemMessageData= [[[SystemMessageData alloc]init]autorelease];
    SystemMessageData *systemMessageData;
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE MESSAGE_ID='%@'",TABLE_SYSTEM_MESSAGE_DATA,messageID];
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            while(sqlite3_step(stmt) == SQLITE_ROW)
            {
                systemMessageData = [self createMSystemMessage:stmt];
                [array addObject:systemMessageData];
            }
            //            NSLog(@"%@",searchHistory.mSearchName);
        }
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
    }
    sqlite3_close(database);
    return array;
}

/*!
 @method loadAllMeetRequestSystemMessage:(NSString *)userID
 @abstract 根据userID加载消息数据
 @discussion 根据messageID加载消息数据
 @param userID 所属用户id
 @result SystemMessageList 消息列表
 */
- (NSMutableArray *)loadAllMeetRequestSystemMessage:(NSString *)userID
{
    NSMutableArray *array = [[[NSMutableArray alloc]initWithCapacity:0]autorelease];
    //SystemMessageData *systemMessageData= [[[SystemMessageData alloc]init]autorelease];
    SystemMessageData *systemMessageData;
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE MESSAGE_ID IN (SELECT KEYID FROM %@ WHERE TYPE= %d AND USER_ID='%@')",TABLE_SYSTEM_MESSAGE_DATA,TABLE_MESSAGE_INFO_DATA,MESSAGE_SYSTEM,userID];
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            while(sqlite3_step(stmt) == SQLITE_ROW)
            {
                systemMessageData = [self createMSystemMessage:stmt];
                [array addObject:systemMessageData];
            }
            //            NSLog(@"%@",searchHistory.mSearchName);
        }
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
    }
    sqlite3_close(database);
    return array;
}

/*!
 @method createMSystemMessage:
 @abstract 将查找到的数据封装到systemMessageData中
 @discussion 将查找到的数据封装到systemMessageData中
 @param stmt　查找到的某条数据
 @param systemMessageData　系统消息
 */
- (SystemMessageData *)createMSystemMessage:(sqlite3_stmt*)stmt
{
   SystemMessageData *systemMessageData= [[[SystemMessageData alloc]init]autorelease];
    char *text;
    int index = 0;
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        systemMessageData.mKeyID = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        systemMessageData.mSendDate = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        systemMessageData.mContent = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        systemMessageData.mMessageID = [NSString stringWithUTF8String:text];
    }
    return systemMessageData;
}

/*!
 @method systemMessageExist:(sqlite3*)database messageID:(NSString *)messageID
 @abstract 根据messageKeyID判断系统消息是否存在
 @discussion 根据messageKeyID判断系统消息是否存在
 @param messageKeyID 消息id
 @result BOOL
 */
- (BOOL)systemMessageExist:(sqlite3*)database messageID:(NSString *)messageID
{
    int count = 0;
    NSString *sql = [NSString stringWithFormat:@"SELECT count(*) FROM %@ WHERE MESSAGE_ID='%@'",TABLE_SYSTEM_MESSAGE_DATA,messageID];
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