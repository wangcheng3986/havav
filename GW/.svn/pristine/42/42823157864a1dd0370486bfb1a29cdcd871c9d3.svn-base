
/*!
 @header VehicleStatusInformMessageData.h
 @abstract 车辆监控表
 @author mengy
 @version 1.00 14-9-3 Creation
 */
#import <sqlite3.h>
#import "UserData.h"
#import "VehicleStatusInformMessageData.h"

@interface VehicleStatusInformMessageData(Private)

@end
@implementation VehicleStatusInformMessageData
@synthesize mVin;
@synthesize mUploadTime;
@synthesize mTrunkSts;
@synthesize mSendTime;
@synthesize mRrTirePressure;
@synthesize mRrDoorSts;
@synthesize mRlTirePressure;
@synthesize mRlDoorSts;
@synthesize mReceiveTime;
@synthesize mPassengerDoorSts;
@synthesize mMileage;
@synthesize mDirection;
@synthesize mSpeed;
@synthesize mKeyid;
@synthesize mHoodSts;
@synthesize mFuelLevel;
@synthesize mFuelConsumption;
@synthesize mFrTirePressure;
@synthesize mFlTirePressure;
@synthesize mDriverDoorSts;
@synthesize mCdngOff;
@synthesize mCbnTemp;
@synthesize mResultCode;
@synthesize mResultMsg;
@synthesize mLon;
@synthesize mLat;
@synthesize mBeamSts;
@synthesize mUserKeyID;
@synthesize mFlTirePressureState;
@synthesize mFrTirePressureState;
@synthesize mFuelLevelState;
@synthesize mRlTirePressureState;
@synthesize mRrTirePressureState;
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
 @method initVehicleStatusMessageDatabase
 @abstract 建表
 @discussion 建表
 @param 无
 @result 无
 */
- (void)initVehicleStatusMessageDatabase
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        char *msg;
        NSString *sql;
        do
        {

            //create MessageInfo table
            sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (KEYID TEXT PRIMARY KEY,VIN TEXT,SEND_TIME TEXT,RESULT_CODE CHAR,RESULT_MSG TEXT,UPLOAD_TIME TEXT,RECEIVE_TIME TEXT,LON DOUBLE,LAT DOUBLE,SPEED TEXT,DIRECTION TEXT,MILEAGE TEXT,FUEL_LEVEL TEXT,FUEL_LEVEL_STATE TEXT,FUEL_CONSUMPTION TEXT,FL_TIRE_PRESSURE TEXT,FL_TIRE_PRESSURE_STATE TEXT,FR_TIRE_PRESSURE TEXT,FR_TIRE_PRESSURE_STATE TEXT,RL_TIRE_PRESSURE TEXT,RL_TIRE_PRESSURE_STATE TEXT,RR_TIRE_PRESSURE TEXT,RR_TIRE_PRESSURE_STATE TEXT,DRIVER_DOOR_STS CHAR,PASSENGER_DOOR_STS CHAR,RL_DOOR_STS CHAR,RR_DOOR_STS CHAR,HOOD_STS CHAR,TRUNK_STS CHAR,BEAM_STS CHAR,CBN_TEMP TEXT,CDNG_OFF CHAR,USER_KEYID TEXT)", TABLE_VEHICLE_STATUS_MESSAGE_DATA];
            
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
    [mVin release];
    [mUploadTime release];
    [mSendTime release];
    [mRrTirePressure release];
    [mRlTirePressure release];
    [mRrTirePressureState release];
    [mRlTirePressureState release];
    [mReceiveTime release];
    [mMileage release];
    [mDirection release];
    [mSpeed release];
    [mKeyid release];
    [mFuelLevel release];
    [mFuelLevelState release];
    [mFuelConsumption release];
    [mFrTirePressure release];
    [mFlTirePressure release];
    [mFrTirePressureState release];
    [mFlTirePressureState release];
    [mCbnTemp release];
    [mResultMsg release];
    [mUserKeyID release];
    [mResultCode release];
    [mDriverDoorSts release];
    [mPassengerDoorSts release];
    [mRlDoorSts release];
    [mRrDoorSts release];
    [mHoodSts release];
    [mTrunkSts release];
    [mBeamSts release];
    [mCdngOff release];
    [super dealloc];
}

/*!
 @method loadVehicleStatusByVin：
 @abstract 根据vin加载车辆状态
 @discussion 根据vin加载车辆状态
 @param vin 车架号
 @result VehicleStatusInformMessageData 车辆状况信息
 */
- (VehicleStatusInformMessageData *)loadVehicleStatusByVin:(NSString *)vin
{
    
    VehicleStatusInformMessageData *vehicleStatusMessage= [[[VehicleStatusInformMessageData alloc]init]autorelease];
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE VIN='%@'",TABLE_VEHICLE_STATUS_MESSAGE_DATA,vin];
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            while(sqlite3_step(stmt) == SQLITE_ROW)
            {
                vehicleStatusMessage = [self createVehicleStatusMessage:stmt];
                //[array addObject:electronicFenceMessage];
            }
            //            NSLog(@"%@",searchHistory.mSearchName);
        }
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
    }
    sqlite3_close(database);
    return vehicleStatusMessage;
}



/*!
 -(void)deleteVehicleStatusWithVin:vin
 @abstract 删除某个用户下的车辆状态
 @discussion 删除某个用户下的车辆状态
 @param vin 车架号
 @result 无
 */
-(void)deleteVehicleStatusWithVin:vin
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE VIN = '%@'",TABLE_VEHICLE_STATUS_MESSAGE_DATA,vin];
        NSLog(@"%@",sql);
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            if(sqlite3_step(stmt) != SQLITE_DONE)
            {
                NSLog(@"DEL VEHICLE_STATUS_MESSAGE_DATA error.");
            }
            else
            {
                NSLog(@"DEL VEHICLE_STATUS_MESSAGE_DATA ok.");
            }
        }
        
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
        
    }
    
    sqlite3_close(database);
}




/*!
 @method createVehicleStatusMessage：
 @abstract 创建消息实体
 @discussion 创建消息实体
 @param stmt
 @result VehicleStatusInformMessageData 消息实体
 */
//sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (KEYID TEXT PRIMARY KEY,VIN TEXT,SEND_TIME TEXT,RESULT_CODE CHAR,RESULT_MSG TEXT,UPLOAD_TIME TEXT,RECEIVE_TIME TEXT,LON DOUBLE,LAT DOUBLE,SPEED TEXT,DIRECTION TEXT,MILEAGE TEXT,FUEL_LEVEL TEXT,FUEL_CONSUMPTION TEXT,FL_TIRE_PRESSURE TEXT,FR_TIRE_PRESSURE TEXT,RL_TIRE_PRESSURE TEXT,RR_TIRE_PRESSURE TEXT,DRIVER_DOOR_STS CHAR,PASSENGER_DOOR_STS CHAR,RL_DOOR_STS CHAR,RR_DOOR_STS CHAR,HOOD_STS CHAR,TRUNK_STS CHAR,BEAM_STS CHAR,CBN_TEMP TEXT,CDNG_OFF CHAR)", TABLE_VEHICLE_STATUS_MESSAGE_DATA];
- (VehicleStatusInformMessageData *)createVehicleStatusMessage:(sqlite3_stmt*)stmt
{
    VehicleStatusInformMessageData *vehicleStatusMessage = [[[VehicleStatusInformMessageData alloc]init]autorelease];
    char *text;
    int index = 0;
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehicleStatusMessage.mKeyid = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehicleStatusMessage.mVin = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehicleStatusMessage.mSendTime = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehicleStatusMessage.mResultCode = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehicleStatusMessage.mResultMsg = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehicleStatusMessage.mUploadTime = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehicleStatusMessage.mReceiveTime = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehicleStatusMessage.mLon = [[NSString stringWithUTF8String:text]doubleValue];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehicleStatusMessage.mLat = [[NSString stringWithUTF8String:text]doubleValue];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehicleStatusMessage.mSpeed = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehicleStatusMessage.mDirection = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehicleStatusMessage.mMileage = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehicleStatusMessage.mFuelLevel = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehicleStatusMessage.mFuelLevelState = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehicleStatusMessage.mFuelConsumption = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehicleStatusMessage.mFlTirePressure = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehicleStatusMessage.mFlTirePressureState = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehicleStatusMessage.mFrTirePressure = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehicleStatusMessage.mFrTirePressureState = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehicleStatusMessage.mRlTirePressure = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehicleStatusMessage.mRlTirePressureState = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehicleStatusMessage.mRrTirePressure = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehicleStatusMessage.mRrTirePressureState = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehicleStatusMessage.mDriverDoorSts = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehicleStatusMessage.mPassengerDoorSts = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehicleStatusMessage.mRlDoorSts = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehicleStatusMessage.mRrDoorSts = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehicleStatusMessage.mHoodSts = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehicleStatusMessage.mTrunkSts = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehicleStatusMessage.mBeamSts = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehicleStatusMessage.mCbnTemp = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehicleStatusMessage.mCdngOff = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        vehicleStatusMessage.mUserKeyID = [NSString stringWithUTF8String:text];
    }
    return vehicleStatusMessage;
}



@end