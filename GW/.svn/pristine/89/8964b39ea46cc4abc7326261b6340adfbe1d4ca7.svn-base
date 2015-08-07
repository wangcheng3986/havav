/*!
 @header MessageInfoData.m
 @abstract 操作消息主表
 @author mengy
 @version 1.00 13-4-23 Creation
 */

#import "MessageInfoData.h"
#import <sqlite3.h>
#import "UserData.h"
/*!
 @class
 @abstract 操作MESSAGE_INFO表。
 */
@interface MessageInfoData(Private)

- (void)initDatabase;
- (sqlite3*)openDatabase;
@end
@implementation MessageInfoData
@synthesize mID;
@synthesize mCreateTime;
@synthesize mKeyID;
@synthesize mStatus;
@synthesize mType;
@synthesize mUser_KeyID;
@synthesize mVehicleVin;
/*!
 @method initFriendDatabase
 @abstract 建表
 @discussion 建表
 @param 无
 @result 无
 */
- (void)initMessageInfoDatabase
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        char *msg;
        NSString *sql;
        do
        {
            //create MessageInfo table
            sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (KEYID TEXT NOT NULL, ID TEXT ,TYPE TEXT ,CREATE_TIME TEXT ,STATUS TEXT ,VEHICLE_VIN TEXT ,USER_ID TEXT)", TABLE_MESSAGE_INFO_DATA];
            if(sqlite3_exec(database, [sql UTF8String], NULL, NULL, &msg) != SQLITE_OK)
            {
                NSLog(@"create MessageInfo table fail.");
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
    [mID release];
    [mCreateTime release];
    [mVehicleVin release];
    [mUser_KeyID release];
    
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

//-(void)addMessageInfo:(NSString *)KeyID
//                   ID:(NSString *)ID
//                 type:(char)type
//           createTime:(NSString *)createTime
//               status:(char)status
//           vehicleVin:(NSString *)vehicleVin
//               userID:(NSString *)userID
//{
//    sqlite3 *database = [self openDatabase];
//    if(database)
//    {
//        [self addMessageInfo:database
//                       KeyID:KeyID
//                          ID:ID
//                        type:type
//                  createTime:createTime
//                      status:status
//                  vehicleVin:vehicleVin
//                      userID:userID
//         ];
//    }
//    sqlite3_close(database);
//}
//
//- (void)addMessageInfo:(sqlite3 *)database
//                 KeyID:(NSString *)KeyID
//                    ID:(NSString *)ID
//                  type:(char)type
//            createTime:(NSString *)createTime
//                status:(char)status
//            vehicleVin:(NSString *)vehicleVin
//                userID:(NSString *)userID
//{
//    // @"CREATE TABLE IF NOT EXISTS %@ (KEYID INTEGER PRIMARY KEY AUTOINCREMENT,ID TEXT ,TYPE TEXT ,CREATE_TIME TEXT ,STATUS TEXT ,VEHICLE_VIN TEXT ,USER_ID TEXT )", TABLE_MESSAGE_INFO_DATA
//    NSString *sql=[NSString stringWithFormat:@"INSERT INTO %@(KEYID,ID,TYPE,CREATE_TIME,STATUS,VEHICLE_VIN,USER_ID) VALUES('%@','%@','%hhd','%@','%hhd','%@','%@')",TABLE_MESSAGE_INFO_DATA,KeyID,ID,type,createTime,status,vehicleVin,userID];
//    sqlite3_stmt *stmt;
//    if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
//    {
//        //        int index = 1;
//        //        sqlite3_bind_text(stmt, index++, [ID UTF8String], -1, NULL);
//        //        sqlite3_bind_int(stmt, index++, mSelectedCar);
//        NSLog(@"add messageinfo ok.");
//        if(sqlite3_step(stmt) != SQLITE_DONE)
//        {
//            NSLog(@"add messageinfo error.");
//        }
//    }
//    sqlite3_reset(stmt);
//    sqlite3_finalize(stmt);
//}

//- (void)updateMessageInfo:(NSString *)KeyID
//                       ID:(NSString *)ID
//                     type:(char)type
//               createTime:(NSString *)createTime
//                   status:(char)status
//               vehicleVin:(NSString *)vehicleVin
//                   userID:(NSString *)userID
//{
//    sqlite3 *database = [self openDatabase];
//    if(database)
//    {
//        [self updateMessageInfo:database
//                          KeyID:KeyID
//                             ID:ID
//                           type:type
//                     createTime:createTime
//                         status:status
//                     vehicleVin:vehicleVin
//                         userID:userID];
//        
//    }
//    sqlite3_close(database);
//}
//
//- (void)updateMessageInfo:(sqlite3 *)database
//                    KeyID:(NSString *)KeyID
//                       ID:(NSString *)ID
//                     type:(char)type
//               createTime:(NSString *)createTime
//                   status:(char)status
//               vehicleVin:(NSString *)vehicleVin
//                   userID:(NSString *)userID
//
//{
//    if ([self messageInfoExist:database KeyID:KeyID userID:userID type:type]==YES) {
//        NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET TYPE='%hhd',CREATE_TIME='%@',STATUS='%hhd',VEHICLE_VIN='%@' WHERE ID='%@'AND USER_ID='%@'",TABLE_MESSAGE_INFO_DATA,type,createTime,status,vehicleVin,ID,userID];
//        sqlite3_stmt *stmt;
//        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
//        {
//            NSLog(@"update MESSAGEINFO ok.");
//            if(sqlite3_step(stmt) != SQLITE_DONE)
//            {
//                NSLog(@"update MESSAGEINFO error.");
//            }
//        }
//
//        sqlite3_reset(stmt);
//        sqlite3_finalize(stmt);
//
//    }
//    else
//    {
//        NSString *sql=[NSString stringWithFormat:@"INSERT INTO %@(KEYID,ID,TYPE,CREATE_TIME,STATUS,VEHICLE_VIN,USER_ID) VALUES('%@','%@','%hhd','%@','%hhd','%@','%@')",TABLE_MESSAGE_INFO_DATA,KeyID,ID,type,createTime,status,vehicleVin,userID];
//        NSLog(@"%@",sql);
//        sqlite3_stmt *stmt;
//        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
//        {
//            NSLog(@"add MESSAGEINFO ok.");
//            if(sqlite3_step(stmt) != SQLITE_DONE)
//            {
//                NSLog(@"add MESSAGEINFO error.");
//            }
//        }
//
//        sqlite3_reset(stmt);
//        sqlite3_finalize(stmt);
//    }
//}

/*!
 @method deleteMessageInfo:userID:
 @abstract 根据所属用户id和消息id进行删除
 @discussion 根据所属用户id和消息id进行删除
 @param ID 消息id
 @param userID 所属用户id
 @result 无
 */
- (void)deleteMessageInfo:(NSString *)ID
                   userID:(NSString*)userID
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        [self deleteMessageInfo:database
                             ID:(NSString *)ID
                         userID:(NSString *)userID];
    }
    sqlite3_close(database);
}

/*!
 @method deleteMessageInfo: ID: userID:
 @abstract 根据所属用户id和消息id进行删除
 @discussion 根据所属用户id和消息id进行删除
 @param ID 消息id
 @param userID 所属用户id
 @param database 数据库
 @result 无
 */
- (void)deleteMessageInfo:(sqlite3*)database
                         ID:(NSString *)ID
                     userID:(NSString *)userID

{
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE KEYID='%@' AND USER_ID='%@'",TABLE_MESSAGE_INFO_DATA,ID,userID];
    //NSLog(@"%@",sql);
    sqlite3_stmt *stmt;
    if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
    {
        //            int index = 1;
        //            sqlite3_bind_text(stmt, index++, [fID UTF8String], -1, NULL);
        //        sqlite3_bind_int(stmt, index++, mSelectedCar);
        //NSLog(@"DEL MESSAGEINFO ok.");
        if(sqlite3_step(stmt) != SQLITE_DONE)
        {
            NSLog(@"DEL MESSAGEINFO error.");
        }
    }
    
    sqlite3_reset(stmt);
    sqlite3_finalize(stmt);
    
}

/*!
 @method deleteMessageInfo:userID:
 @abstract 根据所属用户id和消息id删除多条数据
 @discussion 根据所属用户id和消息id删除多条数据
 @param ID 消息id例如（id，id）
 @param userID 所属用户id
 @result 无
 */
- (void)deleteMessageInfoWithIDs:(NSString *)ID
                          userID:(NSString*)userID
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        [self deleteMessageInfoWithDB:database
                                   ID:ID
                               userID:userID];
    }
    sqlite3_close(database);
}

/*!
 @method deleteMessageInfo: ID: userID:
 @abstract 根据所属用户id和消息id删除多条数据
 @discussion 根据所属用户id和消息id删除多条数据
 @param ID 消息id例如（id，id）
 @param userID 所属用户id
 @param database 数据库
 @result 无
 */
- (void)deleteMessageInfoWithDB:(sqlite3*)database
                             ID:(NSString *)ID
                         userID:(NSString *)userID

{
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE USER_ID='%@' AND KEYID IN (%@)",TABLE_MESSAGE_INFO_DATA,userID,ID];
    //NSLog(@"%@",sql);
    sqlite3_stmt *stmt;
    if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
    {
        NSLog(@"DEL MESSAGEINFO ok.");
        if(sqlite3_step(stmt) != SQLITE_DONE)
        {
            NSLog(@"DEL MESSAGEINFO error.");
        }
    }
    
    sqlite3_reset(stmt);
    sqlite3_finalize(stmt);
    
}

/*!
 @method deleteMessageWithUserID: type:
 @abstract 删除某个用户下的某类消息
 @discussion 删除某个用户下的某类消息
 @param userID 消息所属用户id
 @param type 消息类型
 @result bool
 */
-(BOOL)deleteMessageWithUserID:(NSString *)userID type:(enum CLEAR_TYPE)type
{
    BOOL state = NO;
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        switch (type) {
            case CLEAR_MESSAGE_SEND_TO_CAR:
                state = [self deleteSend2carMessageWithDB:database
                                                   userID:userID
                                                     type:type];
                break;
            case CLEAR_MESSAGE_FRIEND_LOCATION:
                state = [self deleteFriendLocMessageWithDB:database
                                                    userID:userID
                                                      type:type];
                break;
            case CLEAR_MESSAGE_FRIEND_REQUEST_LOCATION:
                state = [self deleteLocRqMessageWithDB:database
                                                userID:userID
                                                  type:type];
                break;
            default:
                break;
        }
        if (state) {
            state = [self deleteMessageWithDB:database
                                       userID:(NSString *)userID
                                         type:type];
        }
    }
    sqlite3_close(database);
    return state;
}

/*!
 @method deleteMessageWithUserID: types:
 @abstract 删除某个用户下的某几类消息
 @discussion 删除某个用户下的某几类消息
 @param userID 消息所属用户id
 @param types 消息类型数组
 @result bool
 */
-(BOOL)deleteMessageWithUserID:(NSString *)userID types:(NSMutableArray *)types
{
    BOOL state = NO;
    sqlite3 *database = [self openDatabase];
    if(database)
    {
//         NSMutableArray *array = [[NSMutableArray alloc]initWithObjects:[NSString stringWithFormat:@"%d",CLEAR_MESSAGE_ELECTRONIC], [NSString stringWithFormat:@"%d",CLEAR_MESSAGE_SEND_TO_CAR],[NSString stringWithFormat:@"%d",CLEAR_MESSAGE_FRIEND_LOCATION],[NSString stringWithFormat:@"%d",CLEAR_MESSAGE_FRIEND_REQUEST_LOCATION],[NSString stringWithFormat:@"%d",CLEAR_MESSAGE_VEHICLE_CONTROL],[NSString stringWithFormat:@"%d",CLEAR_MESSAGE_VEHICLE_ABNORMAL_ALARM],[NSString stringWithFormat:@"%d",CLEAR_MESSAGE_MAINTENANCE_ALARM],nil];
        for (int i = 0; i < types.count; i++) {
            int type =[[types objectAtIndex:i]integerValue];
            switch (type) {
                case CLEAR_SEARCH_HISTORY:
                    state = [self deleteSearchHistory:userID];
                    break;
                case CLEAR_MESSAGE_SEND_TO_CAR:
                    state = [self deleteSend2carMessageWithDB:database
                                                       userID:userID
                                                         type:type];
                    break;
                case CLEAR_MESSAGE_FRIEND_LOCATION:
                    state = [self deleteFriendLocMessageWithDB:database
                                                        userID:userID
                                                          type:type];
                    break;
                case CLEAR_MESSAGE_FRIEND_REQUEST_LOCATION:
                    state = [self deleteLocRqMessageWithDB:database
                                                    userID:userID
                                                      type:type];
                    break;
                case CLEAR_MESSAGE_ELECTRONIC:
                    state = [self deleteElecFenceMessageWithDB:database
                                                       userID:userID
                                                         type:type];
                    break;
                case CLEAR_MESSAGE_VEHICLE_CONTROL:
                    state = [self deleteVehicleControlMessageWithDB:database
                                                        userID:userID
                                                          type:type];
                    break;
                case CLEAR_MESSAGE_VEHICLE_DIAGNOSIS:
                    state = [self deleteVehicleDiagnosisMessageWithDB:database
                                                             userID:userID
                                                               type:type];
                    break;
                case CLEAR_MESSAGE_VEHICLE_ABNORMAL_ALARM:
                    state = [self deleteVehicleAbnormalAlarmMessageWithDB:database
                                                    userID:userID
                                                      type:type];
                    break;
                case CLEAR_MESSAGE_MAINTENANCE_ALARM:
                    state = [self deleteMaintenanceAlertMessageWithDB:database
                                                    userID:userID
                                                      type:type];
                    break;
                default:
                    break;
                
            }
            if (state) {
                state = [self deleteMessageWithDB:database
                                           userID:(NSString *)userID
                                             type:type];
            }
        }
        
    }
    sqlite3_close(database);
    return state;
}

/*!
 @method deleteMessageWithDB: userID: type:
 @abstract 删除某个用户下的某类消息
 @discussion 删除某个用户下的某类消息
 @param userID 消息所属用户id
 @param type 消息类型
 @param database 数据库
 @result bool
 */
- (BOOL)deleteMessageWithDB:(sqlite3*)database
                     userID:(NSString *)userID
                       type:(enum CLEAR_TYPE)type

{
    BOOL state = NO;
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE USER_ID='%@' AND TYPE = %d",TABLE_MESSAGE_INFO_DATA,userID,type];
    NSLog(@"%@",sql);
    sqlite3_stmt *stmt;
    if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
    {
        if(sqlite3_step(stmt) != SQLITE_DONE)
        {
            NSLog(@"DEL messageInfo error.");
        }
        else
        {
            NSLog(@"DEL messageInfo ok.");
            state = YES;
        }
    }
    
    sqlite3_reset(stmt);
    sqlite3_finalize(stmt);
    return state;
    
}

/*!
 @method deleteSend2carMessageWithDB: userID: type:
 @abstract 删除某个用户下的发送到车消息
 @discussion 删除某个用户下的发送到车消息
 @param userID 消息所属用户id
 @param type 消息类型
 @param database 数据库
 @result bool
 */
-(BOOL)deleteSend2carMessageWithDB:(sqlite3*)database
                            userID:(NSString *)userID
                              type:(enum CLEAR_TYPE)type
{
    BOOL state = NO;
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE MESSAGE_KEYID IN(SELECT KEYID FROM %@ WHERE USER_ID = '%@' AND TYPE = %d)",TABLE_SEND_TO_CAR_MESSAGE_DATA,TABLE_MESSAGE_INFO_DATA,userID,type];
    NSLog(@"%@",sql);
    sqlite3_stmt *stmt;
    if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
    {
        if(sqlite3_step(stmt) != SQLITE_DONE)
        {
            NSLog(@"DEL SEND_TO_CAR_MESSAGE_DATA error.");
        }
        else
        {
            NSLog(@"DEL SEND_TO_CAR_MESSAGE_DATA ok.");
            state = YES;
        }
    }
    
    sqlite3_reset(stmt);
    sqlite3_finalize(stmt);
    return state;
}



/*!
 @method deleteFriendLocMessageWithDB: userID: type:
 @abstract 删除某个用户下的车友位置消息
 @discussion 删除某个用户下的车友位置消息
 @param userID 消息所属用户id
 @param type 消息类型
 @param database 数据库
 @result bool
 */
-(BOOL)deleteFriendLocMessageWithDB:(sqlite3*)database
                             userID:(NSString *)userID
                               type:(enum CLEAR_TYPE)type
{
    BOOL state = NO;
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE MESSAGE_KEYID IN(SELECT KEYID FROM %@ WHERE USER_ID = '%@' AND TYPE = %d)",TABLE_FRIEND_LOCATION_MESSAGE_DATA,TABLE_MESSAGE_INFO_DATA,userID,type];
    NSLog(@"%@",sql);
    sqlite3_stmt *stmt;
    if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
    {
        if(sqlite3_step(stmt) != SQLITE_DONE)
        {
            NSLog(@"DEL FRIEND_LOCATION_MESSAGE_DATA error.");
        }
        else
        {
            NSLog(@"DEL FRIEND_LOCATION_MESSAGE_DATA ok.");
            state = YES;
        }
    }
    
    sqlite3_reset(stmt);
    sqlite3_finalize(stmt);
    return state;
}

/*!
 @method deleteLocRqMessageWithDB: userID: type:
 @abstract 删除某个用户下的车友位置请求消息
 @discussion 删除某个用户下的车友位置请求消息
 @param userID 消息所属用户id
 @param type 消息类型
 @param database 数据库
 @result bool
 */
-(BOOL)deleteLocRqMessageWithDB:(sqlite3*)database
                         userID:(NSString *)userID
                           type:(enum CLEAR_TYPE)type
{
    BOOL state = NO;
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE MESSAGE_KEYID IN(SELECT KEYID FROM %@ WHERE USER_ID = '%@' AND TYPE = %d)",TABLE_FRIEND_REQUEST_LOCATION_MESSAGE_DATA,TABLE_MESSAGE_INFO_DATA,userID,type];
    NSLog(@"%@",sql);
    sqlite3_stmt *stmt;
    if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
    {
        if(sqlite3_step(stmt) != SQLITE_DONE)
        {
            NSLog(@"DEL FRIEND_REQUEST_LOCATION_MESSAGE_DATA error.");
        }
        else
        {
            NSLog(@"DEL FRIEND_REQUEST_LOCATION_MESSAGE_DATA ok.");
            state = YES;
        }
    }
    
    sqlite3_reset(stmt);
    sqlite3_finalize(stmt);
    return state;
}


/*!
 @method deleteVehicleControlMessageWithDB: userID: type:
 @abstract 删除某个用户下的车辆控制消息
 @discussion 删除某个用户下的车辆控制消息
 @param userID 消息所属用户id
 @param type 消息类型
 @param database 数据库
 @result bool
 */
-(BOOL)deleteVehicleControlMessageWithDB:(sqlite3*)database
                         userID:(NSString *)userID
                           type:(enum CLEAR_TYPE)type
{
    BOOL state = NO;
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE MESSAGE_KEYID IN(SELECT KEYID FROM %@ WHERE USER_ID = '%@' AND TYPE = %d)",TABLE_VEHICLE_CONTROL_MESSAGE_DATA,TABLE_MESSAGE_INFO_DATA,userID,type];
    NSLog(@"%@",sql);
    sqlite3_stmt *stmt;
    if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
    {
        if(sqlite3_step(stmt) != SQLITE_DONE)
        {
            NSLog(@"DEL VEHICLE_CONTROL_MESSAGE_DATA error.");
        }
        else
        {
            NSLog(@"DEL VEHICLE_CONTROL_MESSAGE_DATA ok.");
            state = YES;
        }
    }
    
    sqlite3_reset(stmt);
    sqlite3_finalize(stmt);
    return state;
}

/*!
 @method deleteElecFenceMessageWithDB: userID: type:
 @abstract 删除某个用户下的电子围栏消息
 @discussion 删除某个用户下的电子围栏消息
 @param userID 消息所属用户id
 @param type 消息类型
 @param database 数据库
 @result bool
 */
-(BOOL)deleteElecFenceMessageWithDB:(sqlite3*)database
                            userID:(NSString *)userID
                              type:(enum CLEAR_TYPE)type
{
    BOOL state = NO;
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE MESSAGE_KEYID IN(SELECT KEYID FROM %@ WHERE USER_ID = '%@' AND TYPE = %d)",TABLE_ELECTRONIC_FENCE_MESSAGE_DATA,TABLE_MESSAGE_INFO_DATA,userID,type];
    NSLog(@"%@",sql);
    sqlite3_stmt *stmt;
    if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
    {
        if(sqlite3_step(stmt) != SQLITE_DONE)
        {
            NSLog(@"DEL ELECTRONIC_FENCE_MESSAGE_DATA error.");
        }
        else
        {
            NSLog(@"DEL ELECTRONIC_FENCE_MESSAGE_DATA ok.");
            state = YES;
        }
    }
    
    sqlite3_reset(stmt);
    sqlite3_finalize(stmt);
    return state;
}

/*!
 @method deleteVehicleDiagnosisMessageWithDB: userID: type:
 @abstract 删除某个用户下的诊断结果消息
 @discussion 删除某个用户下的诊断结果消息
 @param userID 消息所属用户id
 @param type 消息类型
 @param database 数据库
 @result bool
 */
-(BOOL)deleteVehicleDiagnosisMessageWithDB:(sqlite3*)database
                             userID:(NSString *)userID
                               type:(enum CLEAR_TYPE)type
{
    
    BOOL state = NO;
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE REPORT_ID IN(SELECT REPORT_ID FROM %@ WHERE MESSAGE_KEYID IN(SELECT KEYID FROM %@ WHERE USER_ID = '%@' AND TYPE = %d))",TABLE_VEHICLE_DIAGNOSIS_REPORT_ITEM_DATA,TABLE_VEHICLE_DIAGNOSIS_MESSAGE_DATA,TABLE_MESSAGE_INFO_DATA,userID,type];
    NSLog(@"%@",sql);
    sqlite3_stmt *stmt;
    if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
    {
        if(sqlite3_step(stmt) != SQLITE_DONE)
        {
            NSLog(@"DEL VEHICLE_DIAGNOSIS_MESSAGE_DATA error.");
        }
        else
        {
            NSLog(@"DEL VEHICLE_DIAGNOSIS_MESSAGE_DATA ok.");
            state = YES;
        }
    }
    
    sqlite3_reset(stmt);
    sqlite3_finalize(stmt);
    
    if (state) {
        state = NO;
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE MESSAGE_KEYID IN(SELECT KEYID FROM %@ WHERE USER_ID = '%@' AND TYPE = %d)",TABLE_VEHICLE_DIAGNOSIS_MESSAGE_DATA,TABLE_MESSAGE_INFO_DATA,userID,type];
        NSLog(@"%@",sql);
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            if(sqlite3_step(stmt) != SQLITE_DONE)
            {
                NSLog(@"DEL VEHICLE_DIAGNOSIS_MESSAGE_DATA error.");
            }
            else
            {
                NSLog(@"DEL VEHICLE_DIAGNOSIS_MESSAGE_DATA ok.");
                state = YES;
            }
        }
        
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
    }
    return state;
}


/*!
 @method getNewVehicleDiagnosisReportIdWithUserID:(NSString *)userid vin:(NSString *)vin
 @abstract 根据userid,vin获取最新的reportid
 @discussion 根据userid,vin获取最新的reportid
 @param userid 用户id
 @result ReportId 诊断id
 */
- (NSString *)getNewVehicleDiagnosisReportIdWithUserID:(NSString *)userid vin:(NSString *)vin
{
    NSString *reportId = @"";
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE REPORT_TYPE = '%d' AND MESSAGE_KEYID IN (SELECT KEYID FROM %@ WHERE USER_ID = '%@' AND TYPE = %d AND VEHICLE_VIN = '%@') ORDER BY SEND_TIME ASC",TABLE_VEHICLE_DIAGNOSIS_MESSAGE_DATA,VEHICLE_DIAGNOSIS_TYPE_ONLINE,TABLE_MESSAGE_INFO_DATA,userid,MESSAGE_VEHICLE_DIAGNOSIS,vin];
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            char *text;
            while(sqlite3_step(stmt) == SQLITE_ROW)
            {
                text = (char*)sqlite3_column_text(stmt, 0);
                if(text)
                {
                    reportId = [NSString stringWithUTF8String:text];
                }
            }
        }
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
    }
    sqlite3_close(database);
    return reportId;
}

/*!
 @method deleteVehicleAbnormalAlarmMessageWithDB: userID: type:
 @abstract 删除某个用户下的车辆异常报警消息
 @discussion 删除某个用户下的车辆异常报警消息
 @param userID 消息所属用户id
 @param type 消息类型
 @param database 数据库
 @result bool
 */
-(BOOL)deleteVehicleAbnormalAlarmMessageWithDB:(sqlite3*)database
                                    userID:(NSString *)userID
                                      type:(enum CLEAR_TYPE)type
{
    BOOL state = NO;
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE MESSAGE_KEYID IN(SELECT KEYID FROM %@ WHERE USER_ID = '%@' AND TYPE = %d)",TABLE_VEHICLE_ABNORMAL_ALARM_MESSAGE_DATA,TABLE_MESSAGE_INFO_DATA,userID,type];
    NSLog(@"%@",sql);
    sqlite3_stmt *stmt;
    if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
    {
        if(sqlite3_step(stmt) != SQLITE_DONE)
        {
            NSLog(@"DEL VEHICLE_ABNORMAL_ALARM_MESSAGE_DATA error.");
        }
        else
        {
            NSLog(@"DEL VEHICLE_ABNORMAL_ALARM_MESSAGE_DATA ok.");
            state = YES;
        }
    }
    
    sqlite3_reset(stmt);
    sqlite3_finalize(stmt);
    return state;
}

/*!
 @method deleteMaintenanceAlertMessageWithDB: userID: type:
 @abstract 删除某个用户下的保养提醒消息
 @discussion 删除某个用户下的保养提醒消息
 @param userID 消息所属用户id
 @param type 消息类型
 @param database 数据库
 @result bool
 */
-(BOOL)deleteMaintenanceAlertMessageWithDB:(sqlite3*)database
                                        userID:(NSString *)userID
                                          type:(enum CLEAR_TYPE)type
{
    BOOL state = NO;
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE MESSAGE_KEYID IN(SELECT KEYID FROM %@ WHERE USER_ID = '%@' AND TYPE = %d)",TABLE_MAINTENANCE_ALERT_MESSAGE_DATA,TABLE_MESSAGE_INFO_DATA,userID,type];
    NSLog(@"%@",sql);
    sqlite3_stmt *stmt;
    if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
    {
        if(sqlite3_step(stmt) != SQLITE_DONE)
        {
            NSLog(@"DEL MAINTENANCE_ALERT_MESSAGE_DATA error.");
        }
        else
        {
            NSLog(@"DEL MAINTENANCE_ALERT_MESSAGE_DATA ok.");
            state = YES;
        }
    }
    
    sqlite3_reset(stmt);
    sqlite3_finalize(stmt);
    return state;
}

/*!
 @method deleteAllMessage:
 @abstract 删除某一用户下的所有消息
 @discussion 删除某一用户下的所有消息
 @param userID 所属用户id
 @result 无
 */
- (void)deleteAllMessage:(NSString*)userID
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        [self deleteAllMessage:database
                     userID:userID];
    }
    sqlite3_close(database);
}

/*!
 @method deleteAllMessage:userID:
 @abstract 删除某一用户下的所有消息
 @discussion 删除某一用户下的所有消息
 @param userID 所属用户id
 @param database 数据库
 @result 无
 */
- (void)deleteAllMessage:(sqlite3*)database
               userID:(NSString *)userID

{
    if ([self MessageExist:database userID:userID]==YES)
    {

        NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE USER_ID='%@'",TABLE_MESSAGE_INFO_DATA,userID];
        
        //NSLog(@"%@",sql);
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            //            int index = 1;
            //            sqlite3_bind_text(stmt, index++, [fID UTF8String], -1, NULL);
            //        sqlite3_bind_int(stmt, index++, mSelectedCar);
            NSLog(@"DEL all MESSAGE_INFO ok.");
            if(sqlite3_step(stmt) != SQLITE_DONE)
            {
                NSLog(@"DEL all MESSAGE_INFO error.");
            }
        }
        
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
        
    }
    else
    {
        NSLog(@"DEL all MESSAGE_INFO error.");
    }
}

/*!
 @method MessageExist:userID:
 @abstract 查询某账户下是否存在消息
 @discussion 查询某账户下是否存在消息
 @param userID 所属用户id
 @param database 数据库
 @result 无
 */
- (BOOL)MessageExist:(sqlite3*)database userID:(NSString *)userID
{
    int count = 0;
    NSString *sql = [NSString stringWithFormat:@"SELECT count(*) FROM %@ WHERE USER_ID='%@'", TABLE_MESSAGE_INFO_DATA,userID];
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
    return count != 0;
}

/*!
 @method loadMessageInfoData: userID:
 @abstract 根据所属用户id和状态加载消息列表
 @discussion 根据所属用户id和状态加载消息列表
 @param userID 所属用户id
 @param status 状态
 @result messageList
 */
- (NSMutableArray*)loadMessageInfoData:(char)status userID:(NSString *)userID
{
    NSMutableArray *array = [[[NSMutableArray alloc]initWithCapacity:0]autorelease];
    
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE STATUS='%hhd' AND USER_ID='%@'",TABLE_MESSAGE_INFO_DATA,status, userID];
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            MessageInfoData *messageInfo;
            while(sqlite3_step(stmt) == SQLITE_ROW)
            {
                messageInfo = [self createMMessageInfo:stmt];
                [array addObject:messageInfo];
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
 @method loadMessageTypeData: status: userID:
 @abstract 根据类型、状态和所属用户id加载消息列表
 @discussion 根据类型、状态和所属用户id加载消息列表
 @param type 类型
 @param status 状态
 @param userID 所属用户id
 @result messageList
 */
- (NSMutableArray*)loadMessageTypeData:(char)type status:(char)status userID:(NSString *)userID
{
    NSMutableArray *array = [[[NSMutableArray alloc]initWithCapacity:0]autorelease];
    
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE STATUS='%hhd' AND TYPE='%hhd' AND USER_ID='%@'",TABLE_MESSAGE_INFO_DATA, status, type, userID];
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            MessageInfoData *messageInfo;
            while(sqlite3_step(stmt) == SQLITE_ROW)
            {
                messageInfo = [self createMMessageInfo:stmt];
                [array addObject:messageInfo];
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
 @method createMMessageInfo:
 @abstract 将查找到的数据封装到messageInfo中
 @discussion 将查找到的数据封装到messageInfo中
 @param stmt　查找到的某条数据
 @param messageInfo　消息主表中的一条数据
 */
- (MessageInfoData*)createMMessageInfo:(sqlite3_stmt*)stmt
{
    MessageInfoData *messageInfo = [[[MessageInfoData alloc]init]autorelease];
    char *text;
    int index = 0;
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        messageInfo.mKeyID =[NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        messageInfo.mID = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        messageInfo.mType = *text;
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        messageInfo.mCreateTime = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        messageInfo.mStatus = *text;
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        messageInfo.mVehicleVin = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        messageInfo.mUser_KeyID = [NSString stringWithUTF8String:text];
    }
    //NSLog(@"----");
    //    NSLog(@"%@,%@",friend.mfID,friend.mfCarVin);
    
    return messageInfo;
}

/*!
 @method messageInfoExist: KeyID: type: userID:
 @abstract 根据KeyID、userID、type查询表中是否有数据
 @discussion 根据KeyID、userID、type查询表中是否有数据
 @param userID 所属用户id
 @param KeyID 消息id
 @param type 消息类型
 @param database 数据库
 @result 无
 */
- (BOOL)messageInfoExist:(sqlite3*)database KeyID:(NSString *)KeyID userID:(NSString *)userID type:(char)type
{
    int count = 0;
    NSString *sql = [NSString stringWithFormat:@"SELECT count(*) FROM %@ WHERE KEYID='%@'AND USER_ID='%@' AND TYPE='%hhd'", TABLE_MESSAGE_INFO_DATA,KeyID,userID,type];
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


/*!
 @method loadMessageCountWithType: userID:
 @abstract 获取某账户下某类未读消息数量
 @discussion 获取某账户下某类未读消息数量
 @param userID 所属用户id
 @param type 消息类型
 @result count 消息数量
 */
- (int)loadMessageCountWithType:(enum MESSAGE_TYPE)type userID:(NSString *)userID
{
    int count=0;
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        count=[self messageInfoCount:database
                                type:[NSString stringWithFormat:@"%d",type]
                              userID:userID];
    }
    sqlite3_close(database);
    //    NSLog(@"%c",exist);
    return count;
}


/*!
 @method messageInfoCount: type: userID:
 @abstract 获取某账户下某条未读消息数量
 @discussion 获取某账户下某条未读消息数量
 @param userID 所属用户id
 @param type 消息类型
 @result count 消息数量
 */
- (int)messageInfoCount:(sqlite3*)database type:(NSString *)type userID:(NSString *)userID
{
    int count = 0;
    
    NSString *sql = [NSString stringWithFormat:@"SELECT count(*) FROM %@ WHERE type='%@'AND USER_ID='%@' AND STATUS='%d'", TABLE_MESSAGE_INFO_DATA,type,userID,MESSAGE_UNREAD];
    //NSLog(@"%@",sql);
    sqlite3_stmt *stmt;
    int result = sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil);
    if(result == SQLITE_OK)
    {
        if(sqlite3_step(stmt) == SQLITE_ROW)
        {
            count = sqlite3_column_int(stmt, 0);
        }
    }
//    同步锁
//    @synchronized(self) {
//        NSString *sql = [NSString stringWithFormat:@"SELECT count(*) FROM %@ WHERE type='%@'AND USER_ID='%@' AND STATUS='%d'", TABLE_MESSAGE_INFO_DATA,type,userID,MESSAGE_UNREAD];
//        //NSLog(@"%@",sql);
//        sqlite3_stmt *stmt;
//        int result = sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil);
//        if(result == SQLITE_OK)
//        {
//            if(sqlite3_step(stmt) == SQLITE_ROW)
//            {
//                count = sqlite3_column_int(stmt, 0);
//            }
//        }
//        
//    }
//    else if(result == SQLITE_BUSY)
//    {
//        sqlite3_busy_timeout(database, 2000);
//    }
    sqlite3_reset(stmt);
    sqlite3_finalize(stmt);
    //    NSLog(@"%d",count);
    return count;
}

/*!
 @method setMessageAsReaded: userID:
 @abstract 根据keyid 和 userID 将消息设置成已读状态
 @discussion 根据keyid 和 userID 将消息设置成已读状态
 @param userID 所属用户id
 @param KEYID 消息id
 @result bool
 */
- (bool)setMessageAsReaded:(NSString *)KeyID userID:(NSString *)userID
{
    sqlite3 *database = [self openDatabase];
    NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET STATUS='%d' WHERE KEYID IN ('%@') AND USER_ID='%@'", TABLE_MESSAGE_INFO_DATA,MESSAGE_READ,KeyID,userID];
    sqlite3_stmt *stmt;
    if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
    {

        NSLog(@"Update ok.");
        if(sqlite3_step(stmt) != SQLITE_DONE)
        {
            return false;
            NSLog(@"Update error.");
        }
    }
    sqlite3_reset(stmt);
    sqlite3_finalize(stmt);
    NSString *sql1 = [NSString stringWithFormat:@"SELECT * FROM %@",TABLE_MESSAGE_INFO_DATA];
    //NSString *sql1 = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE STATUS='%d' AND KEYID='%@' AND USER_ID='%@'",TABLE_MESSAGE_INFO_DATA, MESSAGE_UNREAD, KeyID, userID];
    sqlite3_stmt *stmt1;
    if(sqlite3_prepare_v2(database, [sql1 UTF8String], -1, &stmt1, nil) == SQLITE_OK)
    {
        MessageInfoData *messageInfo;
        while(sqlite3_step(stmt1) == SQLITE_ROW)
        {
            messageInfo = [self createMMessageInfo:stmt1];
            NSLog(@"%@",messageInfo);
        }

    }
    sqlite3_reset(stmt1);
    sqlite3_finalize(stmt1);
    sqlite3_close(database);

    return true;
}

/*!
 @method getMessageStatus: userID:
 @abstract 根据keyid 和 userID 获取消息状态
 @discussion 根据keyid 和 userID 获取消息状态
 @param userID 所属用户id
 @param KEYID 消息id
 @result status 消息状态
 */
- (int)getMessageStatus:(NSString *)KeyID userID:(NSString *)userID
{
    sqlite3 *database = [self openDatabase];

    int count = 0;
    NSString *sql = [NSString stringWithFormat:@"SELECT STATUS FROM %@ WHERE KEYID='%@'AND USER_ID='%@'", TABLE_MESSAGE_INFO_DATA,KeyID,userID];
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

    sqlite3_close(database);
    return count;
}

/*!
 @method getCreateTime: userID:
 @abstract 根据keyid 和 userID 获取消息创建时间
 @discussion 根据keyid 和 userID 获取消息创建时间
 @param userID 所属用户id
 @param KEYID 消息id
 @result time 时间
 */
- (NSString *)getCreateTime:(NSString *)KeyID userID:(NSString *)userID
{
    sqlite3 *database = [self openDatabase];
    
    NSString *time=nil;
    char *text;
    NSString *sql = [NSString stringWithFormat:@"SELECT CREATE_TIME FROM %@ WHERE KEYID='%@'AND USER_ID='%@'", TABLE_MESSAGE_INFO_DATA,KeyID,userID];
    sqlite3_stmt *stmt;
    if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
    {
        if(sqlite3_step(stmt) == SQLITE_ROW)
        {
            text = (char*)sqlite3_column_text(stmt, 0);
            time=[NSString stringWithUTF8String:text];
        }
    }
    sqlite3_reset(stmt);
    sqlite3_finalize(stmt);
    //    NSLog(@"%d",count);
    
    sqlite3_close(database);
    return time;
}

/*!
 @method addMessageWithSqls:
 @abstract 根据sql语句，添加消息，其中包括主表消息以及其他分类的消息
 @discussion 根据sql语句，添加消息，其中包括主表消息以及其他分类的消息
 @param sql sql语句
 @result 无
 */
- (void)addMessageWithSqls:(NSMutableArray *)sqls
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        [self addMessageWithDB:database
                             sql:sqls
         ];
        
    }
    sqlite3_close(database);
}

/*!
 @method addMessageWithDB: userID:
 @abstract 根据sql语句，添加消息，其中包括主表消息以及其他分类的消息
 @discussion 根据sql语句，添加消息，其中包括主表消息以及其他分类的消息
 @param sql sql语句
 @result 无
 */
- (void)addMessageWithDB:(sqlite3*)database
                       sql:(NSMutableArray *)sqls
{
    for (int i = 0; i < sqls.count; i ++) {
        sqlite3_stmt *stmt;
        NSLog(@"sql=%@",[sqls objectAtIndex:i]);
        if(sqlite3_prepare_v2(database, [[sqls objectAtIndex:i] UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            NSLog(@"add message ok.");
            if(sqlite3_step(stmt) != SQLITE_DONE)
            {
                NSLog(@"add message error.");
            }
        }
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
    }
    
}



#pragma mark SearchHistoryData
/*!
 @method deleteSearchHistory:(NSString*)userID
 @abstract 删除某用户下的搜索历史记录
 @discussion 删除某用户下的搜索历史记录
 @param userID 所属用户id
 @result bool
 */
- (BOOL)deleteSearchHistory:(NSString *)userID
{
    BOOL state = NO;
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        state = [self deleteSearchHistory:database
                                   userID:(NSString *)userID];
    }
    sqlite3_close(database);
    return state;
}

/*!
 @method deleteSearchHistory:(sqlite3*)database userID:(NSString *)userID
 @abstract 删除某用户下的搜索历史记录
 @discussion 删除某用户下的搜索历史记录
 @param userID 所属用户id
 @param database 数据库
 @result bool
 */
- (BOOL)deleteSearchHistory:(sqlite3*)database
                     userID:(NSString *)userID

{
    BOOL state = NO;
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE USER_ID='%@'",TABLE_SEARCH_HISTROY_DATA,userID];
    NSLog(@"%@",sql);
    sqlite3_stmt *stmt;
    if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
    {
        //            int index = 1;
        //            sqlite3_bind_text(stmt, index++, [fID UTF8String], -1, NULL);
        //        sqlite3_bind_int(stmt, index++, mSelectedCar);
        NSLog(@"DEL searchhistory ok.");
        if(sqlite3_step(stmt) != SQLITE_DONE)
        {
            NSLog(@"DEL searchhistory error.");
        }
        else
        {
            state = YES;
        }
    }
    
    sqlite3_reset(stmt);
    sqlite3_finalize(stmt);
    return state;
    
}

#pragma mark CarData
/*!
 @method searchCarLicense:(NSString*)messageKeyID
 @abstract 根据消息id获取车牌号
 @discussion 根据消息id获取车牌号
 @param messageKeyID 消息id
 @result carLicense
 */
- (NSString *)searchCarNum:(NSString *)messageKeyID
{
    sqlite3 *database = [self openDatabase];
    NSString *carNum = @"";
    if(database)
    {
        
        NSString *sql = [NSString stringWithFormat:@"SELECT CAR_NUMBER FROM %@ WHERE VIN IN(SELECT VEHICLE_VIN FROM %@ WHERE KEYID = '%@')",TABLE_CARDATA,TABLE_MESSAGE_INFO_DATA,messageKeyID];
        NSLog(@"%@",sql);
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            NSLog(@"select car_num ok.");
            if(sqlite3_step(stmt) == SQLITE_ROW)
            {
                char *text;
                int index = 0;
                text = (char*)sqlite3_column_text(stmt, index++);
                if(text)
                {
                    carNum = [NSString stringWithUTF8String:text];
                    
                }
            }
            else
            {
                
                NSLog(@"select car_num error.");
            }
        }
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
    }
    sqlite3_close(database);
    return carNum;
}

@end
