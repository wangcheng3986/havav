
/*!
 @header VehicleDiagnosisInformMessageData.m
 @abstract 故障诊断结果消息表
 @author mengy
 @version 1.00 13-5-20 Creation
 */
#import "VehicleDiagnosisInformMessageData.h"
#import <sqlite3.h>
#import "UserData.h"
@implementation VehicleDiagnosisInformMessageData
@synthesize mCheckResult;
@synthesize mCheckTime;
@synthesize mKeyid;
@synthesize mMessageKeyID;
@synthesize mRepertId;
@synthesize mRepertType;
@synthesize mSendTime;
-(void)dealloc
{
    if (mCheckResult) {
        [mCheckResult release];
    }
    if (mCheckTime) {
        [mCheckTime release];
    }
    if (mKeyid) {
        [mKeyid release];
    }
    if (mMessageKeyID) {
        [mMessageKeyID release];
    }
    if (mRepertId) {
        [mRepertId release];
    }
    if (mRepertType) {
        [mRepertType release];
    }
    if (mSendTime) {
        [mSendTime release];
    }
    [super dealloc];
}

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
 @method initVehicleDiagnosisMessageDatabase
 @abstract 建表
 @discussion 建表
 @param 无
 @result 无
 */
//1	KEYID	主键	VARCHAR2(32)	否	唯一
//2	REPORT_ID	诊断报告的id	VARCHAR2(32)	否		GW.M.GET_MESSAGE_LIST	reportId
//3	REPORT_TYPE	诊断报告类型。0：在线诊断报告；1：定期情况报告；2：其他；	VARCHAR2(16)	否		GW.M.GET_MESSAGE_LIST	reportType
//4	VIN	远程诊断目标车辆车架号	VARCHAR2(16)	否		GW.M.GET_MESSAGE_LIST	vin
//5	SEND_TIME	远程诊断请求发送时间，注：定期情况报告没有发送时间	VARCHAR2(16)	否		GW.M.GET_MESSAGE_LIST	sendTime
//6	CHECK_RESULT	检查结果。0:无故障；1：有故障；2：诊断失败	VARCHAR2(256)	否		GW.M.GET_MESSAGE_LIST	checkResult
//7	CHECK_TIME	检查时间，本次检查结果生成时间。	VARCHAR2(16)	否		GW.M.GET_MESSAGE_LIST	checkTime
//8	MESSAGE_KEYID	消息主键	VARCHAR2(32)	否	外键，关联用户消息主表
- (void)initVehicleDiagnosisMessageDatabase
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        char *msg;
        NSString *sql;
        do
        {
            //create MessageInfo table
            sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (KEYID TEXT PRIMARY KEY,REPORT_ID TEXT,REPORT_TYPE TEXT,SEND_TIME TEXT,CHECK_RESULT TEXT,CHECK_TIME TEXT,MESSAGE_KEYID TEXT)", TABLE_VEHICLE_DIAGNOSIS_MESSAGE_DATA];
            
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


/*!
 @method deleteVehicleDiagnosisMessageWithIDs：
 @abstract 根据id删除多个消息
 @discussion 根据id删除多个消息
 @param messageID 消息id以逗号分开例如（id，id）
 @result 无
 */
- (void)deleteVehicleDiagnosisMessageWithIDs:(NSString *)messageID
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        
        BOOL state = NO;
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE REPORT_ID IN(SELECT REPORT_ID FROM %@ WHERE MESSAGE_KEYID IN(%@))",TABLE_VEHICLE_DIAGNOSIS_REPORT_ITEM_DATA,TABLE_VEHICLE_DIAGNOSIS_MESSAGE_DATA,messageID];
        NSLog(@"%@",sql);
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            NSLog(@"DEL message ok.");
            int result = sqlite3_step(stmt);
            if( result == SQLITE_DONE)
            {
                state = YES;
            }
        }
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
        if (state) {
            sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE MESSAGE_KEYID IN (%@)",TABLE_VEHICLE_DIAGNOSIS_MESSAGE_DATA,messageID];
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
        
        
        
    }
    sqlite3_close(database);
}



/*!
 @method getNewVehicleDiagnosisWithUserID:(NSString *)userid vin:(NSString *)vin
 @abstract 根据userid,vin获取最新的reportid
 @discussion 根据userid,vin获取最新的reportid
 @param userid 用户id
 @result VehicleDiagnosisInformMessageData 车辆诊断数据
 */
- (VehicleDiagnosisInformMessageData *)getNewVehicleDiagnosisWithUserID:(NSString *)userid vin:(NSString *)vin
{
    VehicleDiagnosisInformMessageData *vehicleDiagnosisInformMessage= [[[VehicleDiagnosisInformMessageData alloc]init]autorelease];
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE REPORT_TYPE = '%d' AND MESSAGE_KEYID IN (SELECT KEYID FROM %@ WHERE USER_ID = '%@' AND TYPE = %d AND VEHICLE_VIN = '%@') ORDER BY SEND_TIME DESC",TABLE_VEHICLE_DIAGNOSIS_MESSAGE_DATA,VEHICLE_DIAGNOSIS_TYPE_ONLINE,TABLE_MESSAGE_INFO_DATA,userid,MESSAGE_VEHICLE_DIAGNOSIS,vin];
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            if (sqlite3_step(stmt) == SQLITE_ROW) {
                do
                {
                    vehicleDiagnosisInformMessage = [self createVehicleDiagnosisMessage:stmt];
                }
                while (0);
            }
            
        }
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
    }
    sqlite3_close(database);
    return vehicleDiagnosisInformMessage;
}


/*!
 @method loadVehicleDiagnosisMessageByKeyID：
 @abstract 根据messageID加载消息数据
 @discussion 根据messageID加载消息数据
 @param messageID 消息id
 @result VehicleDiagnosisInformMessageData 消息数据
 */
- (VehicleDiagnosisInformMessageData *)loadVehicleDiagnosisMessageByKeyID:(NSString *)MESSAGE_KEYID
{
    
    VehicleDiagnosisInformMessageData *vehicleDiagnosisInformMessage= [[[VehicleDiagnosisInformMessageData alloc]init]autorelease];
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE MESSAGE_KEYID='%@'",TABLE_VEHICLE_DIAGNOSIS_MESSAGE_DATA,MESSAGE_KEYID];
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            while(sqlite3_step(stmt) == SQLITE_ROW)
            {
                vehicleDiagnosisInformMessage = [self createVehicleDiagnosisMessage:stmt];
                //[array addObject:electronicFenceMessage];
            }
            //            NSLog(@"%@",searchHistory.mSearchName);
        }
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
    }
    sqlite3_close(database);
    return vehicleDiagnosisInformMessage;
}

/*!
 @method loadVehicleDiagnosisMessage：
 @abstract 根据userID加载该用户下的所有车辆诊断结果消息数据
 @discussion 根据userID加载该用户下的所有车辆诊断结果数据
 @param userID 用户id
 @result messagelist 消息列表
 */
- (NSMutableArray *)loadVehicleDiagnosisMessage:(NSString *)userID
{
    NSMutableArray *array = [[[NSMutableArray alloc]initWithCapacity:0]autorelease];
    VehicleDiagnosisInformMessageData *vehicleDiagnosisInformMessage;
    sqlite3 *database = [self openDatabase];
    
    if(database)
    {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE MESSAGE_KEYID IN (SELECT KEYID FROM %@ WHERE TYPE= %d AND USER_ID='%@') ORDER BY SEND_TIME DESC",TABLE_VEHICLE_DIAGNOSIS_MESSAGE_DATA,TABLE_MESSAGE_INFO_DATA,MESSAGE_VEHICLE_DIAGNOSIS,userID];
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            while(sqlite3_step(stmt) == SQLITE_ROW)
            {
                vehicleDiagnosisInformMessage = [self createVehicleDiagnosisMessage:stmt];
                [array addObject:vehicleDiagnosisInformMessage];
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
 @method createVehicleDiagnosisMessage：
 @abstract 创建消息实体
 @discussion 创建消息实体
 @param userID 用户id
 @result VehicleDiagnosisInformMessageData 消息实体
 */
//@"CREATE TABLE IF NOT EXISTS %@ (KEYID TEXT PRIMARY KEY,REPORT_ID TEXT,REPORT_TYPE TEXT,SEND_TIME TEXT,CHECK_RESULT TEXT,CHECK_TIME TEXT,MESSAGE_KEYID TEXT)"
- (VehicleDiagnosisInformMessageData *)createVehicleDiagnosisMessage:(sqlite3_stmt*)stmt
{
    VehicleDiagnosisInformMessageData *vehicleDiagnosisInformMessage = [[[VehicleDiagnosisInformMessageData alloc]init]autorelease];
    char *text;
    int index = 0;
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehicleDiagnosisInformMessage.mKeyid = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehicleDiagnosisInformMessage.mRepertId = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehicleDiagnosisInformMessage.mRepertType = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehicleDiagnosisInformMessage.mSendTime = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehicleDiagnosisInformMessage.mCheckResult = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehicleDiagnosisInformMessage.mCheckTime = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehicleDiagnosisInformMessage.mMessageKeyID = [NSString stringWithUTF8String:text];
    }
    return vehicleDiagnosisInformMessage;
}


@end
