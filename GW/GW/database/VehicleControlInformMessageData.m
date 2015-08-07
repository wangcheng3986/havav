
/*!
 @header VehicleControlInformMessageData.m
 @abstract 操作车辆控制消息表
 @author mengy
 @version 1.00 13-5-20 Creation
 */
#import "VehicleControlInformMessageData.h"
#import <sqlite3.h>
#import "UserData.h"
@interface VehicleControlInformMessageData(Private)

@end
@implementation VehicleControlInformMessageData
@synthesize mMessageKeyID;
@synthesize mKeyid;
@synthesize mCmdCode;
@synthesize mResultCode;
@synthesize mResultMsg;
@synthesize mSendTime;


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
 @method initVehicleControlMessageDatabase
 @abstract 建表
 @discussion 建表
 @param 无
 @result 无
 */
//1	KEYID	主键	VARCHAR2(32)
//2	SEND_TIME	指令请求发送时间	VARCHAR2(16)
//3	CMD_CODE	指令类型码	VARCHAR2(16)
//4	RESULT_CODE	指令执行结果。	CHAR(1)
//5	RESULT_MSG	指令执行错误提示	VARCHAR2(256)
//6	MESSAGE_KEYID	消息主键	VARCHAR2(32)
- (void)initVehicleControlMessageDatabase
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        char *msg;
        NSString *sql;
        do
        {
            //create MessageInfo table
            sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (KEYID TEXT PRIMARY KEY,SEND_TIME TEXT,CMD_CODE TEXT,RESULT_CODE CHAR,RESULT_MSG TEXT,MESSAGE_KEYID TEXT)", TABLE_VEHICLE_CONTROL_MESSAGE_DATA];
            
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
    [mSendTime release];
    [mResultMsg release];
    [mKeyid release];
    [mCmdCode release];
    [mResultCode release];
    [mMessageKeyID release];
    [super dealloc];
}


/*!
 @method deleteVehicleControlMessageWithIDs：
 @abstract 根据id删除多个消息
 @discussion 根据id删除多个消息
 @param messageID 消息id以逗号分开例如（id，id）
 @result 无
 */
- (void)deleteVehicleControlMessageWithIDs:(NSString *)messageID
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE MESSAGE_KEYID IN (%@)",TABLE_VEHICLE_CONTROL_MESSAGE_DATA,messageID];
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
 @method loadVehicleControlMessageByKeyID：
 @abstract 根据messageID加载消息数据
 @discussion 根据messageID加载消息数据
 @param messageID 消息id
 @result VehicleControlInformMessageData 消息数据
 */
- (VehicleControlInformMessageData *)loadVehicleControlMessageByKeyID:(NSString *)MESSAGE_KEYID
{
    
    VehicleControlInformMessageData *vehicleControlInformMessage= [[[VehicleControlInformMessageData alloc]init]autorelease];
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE MESSAGE_KEYID='%@'",TABLE_VEHICLE_CONTROL_MESSAGE_DATA,MESSAGE_KEYID];
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            while(sqlite3_step(stmt) == SQLITE_ROW)
            {
                vehicleControlInformMessage = [self createVehicleControlMessage:stmt];
                //[array addObject:electronicFenceMessage];
            }
            //            NSLog(@"%@",searchHistory.mSearchName);
        }
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
    }
    sqlite3_close(database);
    return vehicleControlInformMessage;
}

/*!
 @method loadVehicleControlMessage：
 @abstract 根据userID加载该用户下的所有车辆控制消息数据
 @discussion 根据userID加载该用户下的所有车辆控制消息数据
 @param userID 用户id
 @result messagelist 消息列表
 */
- (NSMutableArray *)loadVehicleControlMessage:(NSString *)userID
{
    NSMutableArray *array = [[[NSMutableArray alloc]initWithCapacity:0]autorelease];
    VehicleControlInformMessageData *vehicleControlInformMessage;
    sqlite3 *database = [self openDatabase];
    
    if(database)
    {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE MESSAGE_KEYID IN (SELECT KEYID FROM %@ WHERE TYPE= %d AND USER_ID='%@') ORDER BY SEND_TIME DESC",TABLE_VEHICLE_CONTROL_MESSAGE_DATA,TABLE_MESSAGE_INFO_DATA,MESSAGE_VEHICLE_CONTROL,userID];
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            while(sqlite3_step(stmt) == SQLITE_ROW)
            {
                vehicleControlInformMessage = [self createVehicleControlMessage:stmt];
                [array addObject:vehicleControlInformMessage];
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
 @method createVehicleControlMessage：
 @abstract 创建消息实体
 @discussion 创建消息实体
 @param userID 用户id
 @result VehicleControlInformMessageData 消息实体
 */
//sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (KEYID TEXT PRIMARY KEY,SEND_TIME TEXT,CMD_CODE TEXT,RESULT_CODE CHAR,RESULT_MSG TEXT,MESSAGE_KEYID TEXT)", 
- (VehicleControlInformMessageData *)createVehicleControlMessage:(sqlite3_stmt*)stmt
{
    VehicleControlInformMessageData *vehicleControlInformMessage = [[[VehicleControlInformMessageData alloc]init]autorelease];
    char *text;
    int index = 0;
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehicleControlInformMessage.mKeyid = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehicleControlInformMessage.mSendTime = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehicleControlInformMessage.mCmdCode = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehicleControlInformMessage.mResultCode = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehicleControlInformMessage.mResultMsg = [NSString stringWithUTF8String:text];
    }text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehicleControlInformMessage.mMessageKeyID = [NSString stringWithUTF8String:text];
    }
    return vehicleControlInformMessage;
}



@end