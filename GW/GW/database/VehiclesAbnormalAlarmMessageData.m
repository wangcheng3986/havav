
/*!
 @header VehiclesAbnormalAlarmMessageData.m
 @abstract 车辆异常报警消息表
 @author mengy
 @version 1.00 14-9-3 Creation
 */
#import <sqlite3.h>
#import "UserData.h"
#import "VehiclesAbnormalAlarmMessageData.h"

@interface VehiclesAbnormalAlarmMessageData(Private)

@end
@implementation VehiclesAbnormalAlarmMessageData
@synthesize mMessageKeyID;
@synthesize mKeyid;
@synthesize mAddress;
@synthesize mAlarmTime;
@synthesize mDirection;
@synthesize mSpeed;
@synthesize mLat;
@synthesize mLon;
@synthesize mAlarmType;


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
//2	ALARM_TYPE	报警类型	CHAR(1)	否	0：车门异常打开；1：TBox报警		alarmType
//3	ALARM_TIME	报警时间	VARCHAR2(16)	否			alarmTime
//4	LON	报警位置经度	DOUBLE (16)	否			lon
//5	LAT	报警位置纬度	DOUBLE (16)	否			lat
//6	SPEED	报警车辆速度	VARCHAR2(16)	否			speed
//7	DIRECTION	报警车辆方向	VARCHAR2(16)	否			direction
//8	ADDRESS	报警位置地址	VARCHAR2(256)				address
//9	MESSAGE_KEYID	消息主键	VARCHAR2(32)	否	外键，关联用户消息主表
/*!
 @method initVehiclesAbnormalAlarmMessageDatabase
 @abstract 建表
 @discussion 建表
 @param 无
 @result 无
 */
- (void)initVehiclesAbnormalAlarmMessageDatabase
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        char *msg;
        NSString *sql;
        do
        {
            //create MessageInfo table
            sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (KEYID TEXT PRIMARY KEY,ALARM_TYPE CHAR,ALARM_TIME TEXT,LON DOUBLE,LAT DOUBLE,SPEED TEXT,DIRECTION TEXT,ADDRESS TEXT,MESSAGE_KEYID TEXT)", TABLE_VEHICLE_ABNORMAL_ALARM_MESSAGE_DATA];
            
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
    [mSpeed release];
    [mMessageKeyID release];
    [mKeyid release];
    [mAlarmTime release];
    [mDirection release];
    [mAddress release];
    [mAlarmType release];
    [super dealloc];
}


/*!
 @method deleteVehiclesAbnormalAlarmMessageWithIDs：
 @abstract 根据id删除多个消息
 @discussion 根据id删除多个消息
 @param messageID 消息id以逗号分开例如（id，id）
 @result 无
 */
- (void)deleteVehiclesAbnormalAlarmMessageWithIDs:(NSString *)messageID
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE MESSAGE_KEYID IN (%@)",TABLE_VEHICLE_ABNORMAL_ALARM_MESSAGE_DATA,messageID];
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
 @method loadVehiclesAbnormalAlarmByKeyID：
 @abstract 根据messageID加载消息数据
 @discussion 根据messageID加载消息数据
 @param messageID 消息id
 @result VehiclesAbnormalAlarmMessageData 消息数据
 */
- (VehiclesAbnormalAlarmMessageData *)loadVehiclesAbnormalAlarmByKeyID:(NSString *)MESSAGE_KEYID
{
    
    VehiclesAbnormalAlarmMessageData *vehiclesAbnormalAlarmMessage= [[[VehiclesAbnormalAlarmMessageData alloc]init]autorelease];
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE MESSAGE_KEYID='%@'",TABLE_VEHICLE_ABNORMAL_ALARM_MESSAGE_DATA,MESSAGE_KEYID];
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            while(sqlite3_step(stmt) == SQLITE_ROW)
            {
                vehiclesAbnormalAlarmMessage = [self createVehiclesAbnormalAlarmMessage:stmt];
                //[array addObject:electronicFenceMessage];
            }
            //            NSLog(@"%@",searchHistory.mSearchName);
        }
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
    }
    sqlite3_close(database);
    return vehiclesAbnormalAlarmMessage;
}

/*!
 @method loadVehiclesAbnormalAlarmMessage：
 @abstract 根据userID加载该用户下的所有车辆控制消息数据
 @discussion 根据userID加载该用户下的所有车辆控制消息数据
 @param userID 用户id
 @result messagelist 消息列表
 */
- (NSMutableArray *)loadVehiclesAbnormalAlarmMessage:(NSString *)userID
{
    NSMutableArray *array = [[[NSMutableArray alloc]initWithCapacity:0]autorelease];
    VehiclesAbnormalAlarmMessageData *vehiclesAbnormalAlarmMessage;
    sqlite3 *database = [self openDatabase];
    
    if(database)
    {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE MESSAGE_KEYID IN (SELECT KEYID FROM %@ WHERE TYPE= %d AND USER_ID='%@') ORDER BY ALARM_TIME DESC",TABLE_VEHICLE_ABNORMAL_ALARM_MESSAGE_DATA,TABLE_MESSAGE_INFO_DATA,MESSAGE_VEHICLE_ABNORMAL_ALARM,userID];
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            while(sqlite3_step(stmt) == SQLITE_ROW)
            {
                vehiclesAbnormalAlarmMessage = [self createVehiclesAbnormalAlarmMessage:stmt];
                [array addObject:vehiclesAbnormalAlarmMessage];
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
 @method createVehiclesAbnormalAlarmMessage：
 @abstract 创建消息实体
 @discussion 创建消息实体
 @param userID 用户id
 @result VehiclesAbnormalAlarmMessageData 消息实体
 */
//sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (KEYID TEXT PRIMARY KEY,ALARM_TYPE CHAR,ALARM_TIME TEXT,LON DOUBLE,LAT DOUBLE,SPEED TEXT,DIRECTION TEXT,ADDRESS TEXT,MESSAGE_KEYID TEXT)", TABLE_VEHICLE_ABNORMAL_ALARM_MESSAGE_DATA];
- (VehiclesAbnormalAlarmMessageData *)createVehiclesAbnormalAlarmMessage:(sqlite3_stmt*)stmt
{
    VehiclesAbnormalAlarmMessageData *vehiclesAbnormalAlarmMessage = [[[VehiclesAbnormalAlarmMessageData alloc]init]autorelease];
    char *text;
    int index = 0;
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehiclesAbnormalAlarmMessage.mKeyid = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehiclesAbnormalAlarmMessage.mAlarmType = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehiclesAbnormalAlarmMessage.mAlarmTime = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehiclesAbnormalAlarmMessage.mLon = [[NSString stringWithUTF8String:text]doubleValue];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehiclesAbnormalAlarmMessage.mLat = [[NSString stringWithUTF8String:text]doubleValue];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehiclesAbnormalAlarmMessage.mSpeed = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehiclesAbnormalAlarmMessage.mDirection = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehiclesAbnormalAlarmMessage.mAddress = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehiclesAbnormalAlarmMessage.mMessageKeyID = [NSString stringWithUTF8String:text];
    }
    return vehiclesAbnormalAlarmMessage;
}



@end