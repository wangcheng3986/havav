

/*!
 @header MaintenanceAlertInformMessageData.m
 @abstract 保养提醒消息表
 @author mengy
 @version 1.00 14-9-3 Creation
 */
#import <sqlite3.h>
#import "UserData.h"
#import "MaintenanceAlertInformMessageData.h"

@interface MaintenanceAlertInformMessageData(Private)

@end
@implementation MaintenanceAlertInformMessageData
@synthesize mMessageKeyID;
@synthesize mDescription;
@synthesize mKeyID;
@synthesize mMaintainItems;
@synthesize mMaintainMileage;
@synthesize mMaintainTime;

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

//1	KEYID	主键	VARCHAR2(32)	否	唯一
//2	MAINTAIN_TIME	提醒保养时间	VARCHAR2(16)	否			maintainTime
//3	MAINTAIN_MILEAGE	提醒保养里程	VARCHAR2(16)	否			maintainMileage
//4	MAINTAIN_ITEMS	提醒保养项目	VARCHAR2(256)	否	以逗号分隔多个项目		maintainItems
//5	DESCRIPTION	报警详细说明	VARCHAR2(256)				description
//6	MESSAGE_KEYID	消息主键	VARCHAR2(32)	否	外键，关联用户消息主表
/*!
 @method initMaintenanceAlertMessageDatabase
 @abstract 建表
 @discussion 建表
 @param 无
 @result 无
 */
- (void)initMaintenanceAlertMessageDatabase
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        char *msg;
        NSString *sql;
        do
        {
            //create MessageInfo table
            sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (KEYID TEXT PRIMARY KEY,MAINTAIN_TIME TEXT,MAINTAIN_MILEAGE TEXT,MAINTAIN_ITEMS TEXT,DESCRIPTION TEXT,MESSAGE_KEYID TEXT)", TABLE_MAINTENANCE_ALERT_MESSAGE_DATA];
            
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
    [mMaintainTime release];
    [mMessageKeyID release];
    [mKeyID release];
    [mMaintainMileage release];
    [mMaintainItems release];
    [mDescription release];
    [super dealloc];
}


/*!
 @method deleteMaintenanceAlertMessageWithIDs：
 @abstract 根据id删除多个消息
 @discussion 根据id删除多个消息
 @param messageID 消息id以逗号分开例如（id，id）
 @result 无
 */
- (void)deleteMaintenanceAlertMessageWithIDs:(NSString *)messageID
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE MESSAGE_KEYID IN (%@)",TABLE_MAINTENANCE_ALERT_MESSAGE_DATA,messageID];
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
 @method loadMaintenanceAlertByKeyID：
 @abstract 根据messageID加载消息数据
 @discussion 根据messageID加载消息数据
 @param messageID 消息id
 @result MaintenanceAlertInformMessageData 消息数据
 */
- (MaintenanceAlertInformMessageData *)loadMaintenanceAlertByKeyID:(NSString *)MESSAGE_KEYID
{
    
    MaintenanceAlertInformMessageData *maintenanceAlertMessage= [[[MaintenanceAlertInformMessageData alloc]init]autorelease];
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE MESSAGE_KEYID='%@'",TABLE_MAINTENANCE_ALERT_MESSAGE_DATA,MESSAGE_KEYID];
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            while(sqlite3_step(stmt) == SQLITE_ROW)
            {
                maintenanceAlertMessage = [self createMaintenanceAlertMessage:stmt];
                //[array addObject:electronicFenceMessage];
            }
            //            NSLog(@"%@",searchHistory.mSearchName);
        }
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
    }
    sqlite3_close(database);
    return maintenanceAlertMessage;
}

/*!
 @method loadMaintenanceAlertMessage：
 @abstract 根据userID加载该用户下的所有车辆控制消息数据
 @discussion 根据userID加载该用户下的所有车辆控制消息数据
 @param userID 用户id
 @result messagelist 消息列表
 */
- (NSMutableArray *)loadMaintenanceAlertMessage:(NSString *)userID
{
    NSMutableArray *array = [[[NSMutableArray alloc]initWithCapacity:0]autorelease];
    MaintenanceAlertInformMessageData *maintenanceAlertMessage;
    sqlite3 *database = [self openDatabase];
    
    if(database)
    {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE MESSAGE_KEYID IN (SELECT KEYID FROM %@ WHERE TYPE= %d AND USER_ID='%@') ORDER BY MAINTAIN_TIME DESC",TABLE_MAINTENANCE_ALERT_MESSAGE_DATA,TABLE_MESSAGE_INFO_DATA,MESSAGE_MAINTENANCE_ALARM,userID];
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            while(sqlite3_step(stmt) == SQLITE_ROW)
            {
                maintenanceAlertMessage = [self createMaintenanceAlertMessage:stmt];
                [array addObject:maintenanceAlertMessage];
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
 @method createMaintenanceAlertMessage：
 @abstract 创建消息实体
 @discussion 创建消息实体
 @param userID 用户id
 @result MaintenanceAlertInformMessageData 消息实体
 */
//sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (KEYID TEXT PRIMARY KEY,MAINTAIN_TIME TEXT,MAINTAIN_MILEAGE TEXT,MAINTAIN_ITEMS TEXT,DESCRIPTION TEXT,MESSAGE_KEYID TEXT)", TABLE_MAINTENANCE_ALERT_MESSAGE_DATA];
- (MaintenanceAlertInformMessageData *)createMaintenanceAlertMessage:(sqlite3_stmt*)stmt
{
    MaintenanceAlertInformMessageData *maintenanceAlertMessage = [[[MaintenanceAlertInformMessageData alloc]init]autorelease];
    char *text;
    int index = 0;
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        maintenanceAlertMessage.mKeyID = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        maintenanceAlertMessage.mMaintainTime = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        maintenanceAlertMessage.mMaintainMileage = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        maintenanceAlertMessage.mMaintainItems = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        maintenanceAlertMessage.mDescription = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        maintenanceAlertMessage.mMessageKeyID = [NSString stringWithUTF8String:text];
    }
    return maintenanceAlertMessage;
}



@end