
/*!
 @header ElectronicFenceMessageData.m
 @abstract 操作电子围栏消息表
 @author mengy
 @version 1.00 13-5-20 Creation
 */

#import "ElectronicFenceMessageData.h"
#import <sqlite3.h>
#import "UserData.h"
@interface ElectronicFenceMessageData(Private)

@end
@implementation ElectronicFenceMessageData

@synthesize mAddress;
@synthesize mAlarmTime;
@synthesize mAlarmType;
@synthesize mDescription;
@synthesize mDirection;
@synthesize mElecfenceID;
@synthesize mElecfenceName;
@synthesize mKeyid;
@synthesize mLat;
@synthesize mLon;
@synthesize mMessageKeyID;
@synthesize mRadius;
@synthesize mSpeed;
@synthesize mElecfenceLat;
@synthesize mElecfenceLon;

/*!
 @method openDatabase
 @abstract 打开数据库
 @discussion 打开数据库
 @param 无
 @result database　数据库
 */
-(sqlite3*)openDatabase
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
 @method initElectronicFenceMessageDatabase
 @abstract 建表
 @discussion 建表
 @param 无
 @result 无
 */
- (void)initElectronicFenceMessageDatabase
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        char *msg;
        NSString *sql;
        do
        {
            //create MessageInfo table
            sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (KEYID TEXT PRIMARY KEY,ALARM_TYPE CHAR,ALARM_TIME TEXT,ELECFENCE_ID TEXT,ELECFENCE_NAME TEXT,RADIUS TEXT,ELECFENCE_LON DOUBLE ,ELECFENCE_LAT DOUBLE,LON DOUBLE ,LAT DOUBLE ,SPEED TEXT,DIRECTION TEXT,ADDRESS TEXT,DESCRIPTION TEXT,MESSAGE_KEYID TEXT)", TABLE_ELECTRONIC_FENCE_MESSAGE_DATA];

            if(sqlite3_exec(database, [sql UTF8String], NULL, NULL, &msg) != SQLITE_OK)
            {
                NSLog(@"create TABLE_ELECTRONIC_FENCE_MESSAGE_DATA table fail.");
                break;
            }
            
        }
        while (0);
        
        
    }
    sqlite3_close(database);
}

- (void)dealloc
{
    [mAddress release];
    [mAlarmTime release];
    [mDescription release];
    [mDirection release];
    [mAlarmType release];
    [mElecfenceID release];
    [mElecfenceName release];
    [mKeyid release];
    [mMessageKeyID release];
    [mRadius release];
    [mSpeed release];
    [super dealloc];
}


/*!
 @method deleteElectronicFenceMessageWithIDs：
 @abstract 根据id删除多个消息
 @discussion 根据id删除多个消息
 @param messageID 消息id以逗号分开例如（id，id）
 @result 无
 */
- (void)deleteElectronicFenceMessageWithIDs:(NSString *)messageID
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE MESSAGE_KEYID IN (%@)",TABLE_ELECTRONIC_FENCE_MESSAGE_DATA,messageID];
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
    sqlite3_close(database);
}

/*!
 @method loadMeetReqElectronicFenceMessageByKeyID：
 @abstract 根据messageID加载消息数据
 @discussion 根据messageID加载消息数据
 @param messageID 消息id
 @result ElectronicFenceMessageData 消息数据
 */
- (ElectronicFenceMessageData *)loadElectronicFenceMessageByKeyID:(NSString *)MESSAGE_KEYID
{

    ElectronicFenceMessageData *electronicFenceMessage= [[[ElectronicFenceMessageData alloc]init]autorelease];
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE MESSAGE_KEYID='%@'",TABLE_ELECTRONIC_FENCE_MESSAGE_DATA,MESSAGE_KEYID];
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            while(sqlite3_step(stmt) == SQLITE_ROW)
            {
                electronicFenceMessage = [self createMElectronicFenceMessage:stmt];
                //[array addObject:electronicFenceMessage];
            }
            //            NSLog(@"%@",searchHistory.mSearchName);
        }
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
    }
    sqlite3_close(database);
    return electronicFenceMessage;
}

/*!
 @method loadMeetRequestElectronicFenceMessage：
 @abstract 根据userID加载该用户下的所有电子围栏消息数据
 @discussion 根据userID加载该用户下的所有电子围栏消息数据
 @param userID 用户id
 @result messagelist 消息列表
 */
- (NSMutableArray *)loadElectronicFenceMessage:(NSString *)userID
{
    NSMutableArray *array = [[[NSMutableArray alloc]initWithCapacity:0]autorelease];
    ElectronicFenceMessageData *electronicFenceMessage;
    sqlite3 *database = [self openDatabase];
    
    if(database)
    {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE MESSAGE_KEYID IN (SELECT KEYID FROM %@ WHERE TYPE= %d AND USER_ID='%@') ORDER BY ALARM_TIME DESC",TABLE_ELECTRONIC_FENCE_MESSAGE_DATA,TABLE_MESSAGE_INFO_DATA,MESSAGE_ELECTRONIC,userID];
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            while(sqlite3_step(stmt) == SQLITE_ROW)
            {
                electronicFenceMessage = [self createMElectronicFenceMessage:stmt];
                [array addObject:electronicFenceMessage];
            }
            //            NSLog(@"%@",searchHistory.mSearchName);
        }
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
    }
    sqlite3_close(database);
    
    return array;
}
//sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (KEYID TEXT PRIMARY KEY,ALARM_TYPE CHAR,ALARM_TIME TEXT,ELECFENCE_ID TEXT,ELECFENCE_NAME TEXT,RADIUS TEXT,ELECFENCE_LON DOUBLE ,ELECFENCE_LAT DOUBLE,LON DOUBLE ,LAT DOUBLE ,SPEED TEXT,DIRECTION TEXT,ADDRESS TEXT,DESCRIPTION TEXT,MESSAGE_KEYID TEXT)", TABLE_ELECTRONIC_FENCE_MESSAGE_DATA];

/*!
 @method createMElectronicFenceMessage：
 @abstract 创建消息实体
 @discussion 创建消息实体
 @param userID 用户id
 @result ElectronicFenceMessageData 消息实体
 */
- (ElectronicFenceMessageData *)createMElectronicFenceMessage:(sqlite3_stmt*)stmt
{
    ElectronicFenceMessageData *electronicFenceMessage = [[[ElectronicFenceMessageData alloc]init]autorelease];
    char *text;
    int index = 0;
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        electronicFenceMessage.mKeyid = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        electronicFenceMessage.mAlarmType = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        electronicFenceMessage.mAlarmTime = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        electronicFenceMessage.mElecfenceID = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        electronicFenceMessage.mElecfenceName = [NSString stringWithUTF8String:text];
    }text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        electronicFenceMessage.mRadius = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        electronicFenceMessage.mElecfenceLon = [[NSString stringWithUTF8String:text]doubleValue];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        electronicFenceMessage.mElecfenceLat = [[NSString stringWithUTF8String:text]doubleValue];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        electronicFenceMessage.mLon = [[NSString stringWithUTF8String:text]doubleValue];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        electronicFenceMessage.mLat = [[NSString stringWithUTF8String:text]doubleValue];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        electronicFenceMessage.mSpeed = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        electronicFenceMessage.mDirection = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        electronicFenceMessage.mAddress = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        electronicFenceMessage.mDescription = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        electronicFenceMessage.mMessageKeyID = [NSString stringWithUTF8String:text];
    }
    return electronicFenceMessage;
}


@end