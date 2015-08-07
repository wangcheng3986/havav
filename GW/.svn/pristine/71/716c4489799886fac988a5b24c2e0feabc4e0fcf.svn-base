/*!
 @header CarData.m
 @abstract 操作VEHICLE表
 @author mengy
 @version 1.00 14-4-1 Creation
 */
#import <sqlite3.h>

#import "App.h"
#import "CarData.h"
/*!
 @class
 @abstract 操作VEHICLE表。
 */
@interface CarData(Private)

- (void)initDatabase;
- (sqlite3*)openDatabase;
@end

@implementation CarData
@synthesize mLat;
@synthesize mLon;
@synthesize mCarID;
@synthesize mCarNumber;
@synthesize mCarRegisCode;
@synthesize mKeyID;
@synthesize mMotorCode;
@synthesize mName;
@synthesize mSim;
@synthesize mUserID;
@synthesize mVin;
@synthesize mVType;
@synthesize mLastRpTime;
@synthesize mService;

/*!
 @method initWithCarID：
 @abstract 初始化缓存中cardata数据
 @discussion 初始化缓存中cardata数据
 @param 车辆信息
 @result self
 */
- (id)initWithCarID:(NSString*)keyID
              carID:(NSString*)carID
                vin:(NSString*)vin
               type:(NSString*)type
               name:(NSString*)name
       carRegisCode:(NSString*)carRegisCode
          carNumber:(NSString*)carNumber
          motorCode:(NSString*)motorCode
             userID:(NSString*)userID
                sim:(NSString*)sim
                lon:(NSString *)lon
                lat:(NSString *)lat
         lastRpTime:(NSString *)lastRpTime
         service:(NSString *)service
{
    self = [super init];
    mKeyID=[keyID copy];
    mCarID=[carID copy];
    mVin=[vin copy];
    mVType=[type copy];
    mName=[name copy];
    mCarRegisCode=[carRegisCode copy];
    mCarNumber=[carNumber copy];
    mMotorCode=[motorCode copy];
    mUserID=[userID copy];
    mSim=[sim copy];
    mLon=[lon copy];
    mLat=[lat copy];
    mLastRpTime = [lastRpTime copy];
    mService = [service copy];
    [self initDatabase];
    return self;
}

-(void)dealloc
{
    [mKeyID release];
    [mCarID release];
    [mVin release];
    [mVType release];
    [mName release];
    [mCarRegisCode release];
    [mCarNumber release];
    [mMotorCode release];
    [mUserID release];
    [mSim release];
    [mLon release];
    [mLat release];
    [mLastRpTime release];
    [mService release];
    [super dealloc];
}

/*!
 @method initCarDatabase
 @abstract 建表
 @discussion 建表
 @param 无
 @result 无
 */
- (void)initCarDatabase
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        char *msg;
        NSString *sql;
        do
        {
            //create poi table
            sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ ( KEYID TEXT PRIMARY KEY, CAR_ID TEXT , VIN TEXT, V_TYPE TEXT, NAME TEXT, CAR_REGIS_CODE TEXT, CAR_NUMBER TEXT, MOTOR_CODE TEXT, USER_ID TEXT, LON TEXT, LAT TEXT ,SIM TEXT,LAST_RP_TIME TEXT,SERVICE_TYPE TEXT)", TABLE_CARDATA];
            if(sqlite3_exec(database, [sql UTF8String], NULL, NULL, &msg) != SQLITE_OK)
            {
                NSLog(@"create poi table fail.");
                break;
            }
            
        }
        while (0);
        
    }
    sqlite3_close(database);
    
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



/*!
 @method carExistWithUserID：vin:
 @abstract 根据userID和vin判断改车辆信息是否存在
 @discussion 根据userID和vin判断改车辆信息是否存在
 @param userid所属用户id
 @param vin 车辆vin号
 @result bool
 */
-(BOOL)carExistWithUserID:(NSString *)userID vin:(NSString *)vin
{
    int count = 0;
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        count = [self carExist:database userID:userID vin:vin];
        
    }
    sqlite3_close(database);
    return count != 0;
}

/*!
 @method carExist: userID: vin:
 @abstract 根据userID和vin判断改车辆信息是否存在
 @discussion 根据userID和vin判断改车辆信息是否存在
 @param userid所属用户id
 @param vin 车辆vin号
 @result bool
 */
- (BOOL)carExist:(sqlite3*)database userID:(NSString *)userID vin:(NSString *)vin
{
    int count = 0;
    NSString *sql = [NSString stringWithFormat:@"SELECT count(*) FROM %@ WHERE VIN='%@' AND USER_ID='%@'", TABLE_CARDATA,vin,userID];
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
 @method updateCarData：
 @abstract 更新或者添加车辆数据
 @discussion 更新或者添加车辆数据
 @param 车辆数据
 @result 无
 */
- (void)updateCarData:(sqlite3*)database
                keyID:(NSString*)keyID
                carID:(NSString*)carID
                  vin:(NSString*)vin
                 type:(NSString*)type
                 name:(NSString*)name
         carRegisCode:(NSString*)carRegisCode
            carNumber:(NSString*)carNumber
            motorCode:(NSString*)motorCode
               userID:(NSString*)userID
                  sim:(NSString*)sim
                  lon:(NSString *)lon
                  lat:(NSString *)lat
           lastRpTime:(NSString *)lastRpTime
           service:(NSString *)service

{
    if ([self carExist:database userID:userID vin:vin]==YES)
    {
        NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET KEYID='%@',CAR_ID='%@',V_TYPE='%@',NAME='%@',CAR_REGIS_CODE='%@',CAR_NUMBER='%@',MOTOR_CODE='%@', SIM='%@', LAST_RP_TIME='%@', SERVICE_TYPE='%@' WHERE VIN='%@' AND USER_ID='%@'",TABLE_CARDATA,keyID,carID,type,name,carRegisCode,carNumber,motorCode,sim,lastRpTime,service,vin,userID];
        NSLog(@"aql=%@",sql);
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            //        sqlite3_bind_int(stmt, index++, mSelectedCar);
            NSLog(@"update car ok.");
            if(sqlite3_step(stmt) != SQLITE_DONE)
            {
                NSLog(@"update car error.");
            }
        }
        
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
    }
    else
    {
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@(KEYID,CAR_ID,VIN,V_TYPE,NAME,CAR_REGIS_CODE,CAR_NUMBER,MOTOR_CODE,USER_ID,LON,LAT,SIM,LAST_RP_TIME,SERVICE_TYPE) VALUES('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",TABLE_CARDATA,keyID,carID,vin,type,name,carRegisCode,carNumber,motorCode,userID,lon,lat,sim,lastRpTime,service];
         NSLog(@"add car sql=%@",sql);
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            //        sqlite3_bind_int(stmt, index++, mSelectedCar);
            NSLog(@"add car ok.");
            if(sqlite3_step(stmt) != SQLITE_DONE)
            {
                NSLog(@"add car error.");
            }
        }
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
    }
    
//    [self loadCarData:database sim:userID vin:vin];
}

/*!
 @method updateCarData：
 @abstract 更新或者添加车辆数据
 @discussion 更新或者添加车辆数据
 @param 车辆数据
 @result 无
 */
- (void)updateCarData:(NSString*)keyID
                carID:(NSString*)carID
                  vin:(NSString*)vin
                 type:(NSString*)type
                 name:(NSString*)name
         carRegisCode:(NSString*)carRegisCode
            carNumber:(NSString*)carNumber
            motorCode:(NSString*)motorCode
               userID:(NSString*)userID
                  sim:(NSString*)sim
                  lon:(NSString *)lon
                  lat:(NSString *)lat
           lastRpTime:(NSString *)lastRpTime
              service:(NSString *)service

{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        [self updateCarData:database
                      keyID:keyID
                      carID:carID
                        vin:vin
                       type:type
                       name:name
               carRegisCode:carRegisCode
                  carNumber:carNumber
                  motorCode:motorCode
                     userID:userID
                        sim:sim
                        lon:lon
                        lat:lat
                 lastRpTime:lastRpTime
                    service:service
         
         ];
    }
    sqlite3_close(database);
}

/*!
 @method updateCarLocation：
 @abstract 根据userID和vin更新车辆位置信息
 @discussion 根据userID和vin更新车辆位置信息
 @param userid所属用户id
 @param vin 车辆vin号
 @param lon 经度
 @param lat 纬度
 @param lastRpTime位置上传时间
 @result 无
 */
-(void)updateCarLocation:(NSString *)userID
                     vin:(NSString *)vin
                     lon:(NSString *)lon
                     lat:(NSString *)lat
              lastRpTime:(NSString *)lastRpTime
{
    
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        [self updateCarLocation:database
                        userID:userID
                            vin:vin
                            lon:lon
                            lat:lat
                     lastRpTime:lastRpTime];
    }
    [self loadCarData:database userID:userID vin:vin];
    sqlite3_close(database);

}

/*!
 @method updateCarLocation：
 @abstract 根据userID和vin更新车辆位置信息
 @discussion 根据userID和vin更新车辆位置信息
 @param userid所属用户id
 @param vin 车辆vin号
 @param lon 经度
 @param lat 纬度
 @param lastRpTime位置上传时间
 @result 无
 */
- (void)updateCarLocation:(sqlite3*)database
                  userID:(NSString *)userID
                      vin:(NSString *)vin
                      lon:(NSString *)lon
                      lat:(NSString *)lat
               lastRpTime:(NSString *)lastRpTime
{
    NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET LON='%@',LAT='%@',LAST_RP_TIME='%@' WHERE VIN='%@'AND USER_ID='%@'",TABLE_CARDATA, lon,lat,lastRpTime,vin,userID];
    NSLog(@"%@",sql);
    sqlite3_stmt *stmt;
    
    if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
    {
        if(sqlite3_step(stmt) != SQLITE_DONE)
        {
            NSLog(@"Updating register code error!");
        }
    }
    else{
        NSLog(@"Updating register code error!");
    }
    sqlite3_reset(stmt);
    sqlite3_finalize(stmt);
}

/*!
 @method deleteCarWithUserID：
 @abstract 删除当前账户下的车辆信息
 @discussion 删除当前账户下的车辆信息
 @param userid所属用户id
 @result 无
 */
-(void)deleteCarWithUserID:(NSString *)userID
{
    
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        [self deleteCarWithDB:database
                            userID:userID];
    }
    sqlite3_close(database);
    
}

/*!
 @method deleteCarWithDB：userID:
 @abstract 删除当前账户下的车辆信息
 @discussion 删除当前账户下的车辆信息
 @param userid所属用户id
 @result 无
 */

- (void)deleteCarWithDB:(sqlite3*)database
                 userID:(NSString *)userID

{
    //    NSString *acc=@"111";
    //    NSLog(@"%@",account);
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@  WHERE USER_ID='%@'",TABLE_CARDATA,userID];
    NSLog(@"%@",sql);
    sqlite3_stmt *stmt;
    
    int result = sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil);
    if(result == SQLITE_OK)
    {
        if(sqlite3_step(stmt) != SQLITE_DONE)
        {
            NSLog(@"delete car code error!");
        }
    }
    else{
        NSLog(@"delete car code error!");
    }
    sqlite3_reset(stmt);
    sqlite3_finalize(stmt);
}

/*!
 @method loadCarData：userID:vin:
 @abstract 更新缓存中的cardata
 @discussion 更新缓存中的cardata
 @param userid所属用户id
 @param vin 车辆vin号
 @result 无
 */
- (void)loadCarData:(sqlite3*)database userID:(NSString *)userID vin:(NSString *)vin
{
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE  VIN='%@' AND USER_ID='%@'",TABLE_CARDATA, vin,userID];
     NSLog(@"%@",sql);
    sqlite3_stmt *stmt;
    if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
    {
//        @"CREATE TABLE IF NOT EXISTS %@ ( KEYID INTEGER PRIMARY KEY AUTOINCREMENT, CAR_ID TEXT , VIN TEXT, V_TYPE TEXT, NAME TEXT, CAR_REGIS_CODE TEXT, CAR_NUMBER TEXT, MOTOR_CODE TEXT, USER_ID TEXT, LON TEXT, LAT TEXT ,SIM TEXT)"
//        NSLog(@"%d",sqlite3_step(stmt));
        int r=sqlite3_step(stmt);
        if(r == SQLITE_ROW)
        {
            int index = 0;
            char *text;
            text = (char*)sqlite3_column_text(stmt, index++);
            if (text) {
                self.mKeyID = [NSString stringWithUTF8String:text];
            }
            
            text = (char*)sqlite3_column_text(stmt, index++);
            if (text) {
                self.mCarID = [NSString stringWithUTF8String:text];
            }
            text = (char*)sqlite3_column_text(stmt, index++);
            if (text) {
                self.mVin = [NSString stringWithUTF8String:text];
            }
            text = (char*)sqlite3_column_text(stmt, index++);
            if (text) {
                self.mVType = [NSString stringWithUTF8String:text];
            }
            text = (char*)sqlite3_column_text(stmt, index++);
            if (text) {
                self.mName = [NSString stringWithUTF8String:text];
            }
            text = (char*)sqlite3_column_text(stmt, index++);
            if (text) {
                self.mCarRegisCode = [NSString stringWithUTF8String:text];
            }
            text = (char*)sqlite3_column_text(stmt, index++);
            if (text) {
                self.mCarNumber = [NSString stringWithUTF8String:text];
            }
            text = (char*)sqlite3_column_text(stmt, index++);
            if (text) {
                self.mMotorCode = [NSString stringWithUTF8String:text];
            }
            text = (char*)sqlite3_column_text(stmt, index++);
            if (text) {
                self.mUserID = [NSString stringWithUTF8String:text];
            }
            text = (char*)sqlite3_column_text(stmt, index++);
            if (text) {
                self.mLon = [NSString stringWithUTF8String:text];
            }
            text = (char*)sqlite3_column_text(stmt, index++);
            if (text) {
                self.mLat = [NSString stringWithUTF8String:text];
            }
            text = (char*)sqlite3_column_text(stmt, index++);
            if (text) {
                self.mSim = [NSString stringWithUTF8String:text];
            }
            text = (char*)sqlite3_column_text(stmt, index++);
            if (text) {
                self.mLastRpTime = [NSString stringWithUTF8String:text];
            }
            text = (char*)sqlite3_column_text(stmt, index++);
            if (text) {
                self.mService = [NSString stringWithUTF8String:text];
            }
        }
    }
    sqlite3_reset(stmt);
    sqlite3_finalize(stmt);
}


/*!
 @method loadCarData：
 @abstract 根据userID和vin更新缓存中的车辆信息
 @discussion 根据userID和vin更新缓存中的车辆信息
 @param userid所属用户id
 @param vin 车辆vin号
 @result 无
 */
- (void)loadCarData:(NSString *)userID  vin:(NSString *)vin
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        [self loadCarData:database userID:userID vin:vin];
        
    }
    sqlite3_close(database);
}


/*!
 @method loadCarDataWithUserID：
 @abstract 获取当前账户下的车辆列表
 @discussion 获取当前账户下的车辆列表
 @param userid所属用户id
 @result carlist
 */
- (NSMutableArray*)loadCarDataWithUserID:(NSString *)userID
{
    NSMutableArray *array = [[[NSMutableArray alloc]initWithCapacity:0]autorelease];
    
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE USER_ID='%@' ",TABLE_CARDATA,userID];
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            CarData *car;
            while(sqlite3_step(stmt) == SQLITE_ROW)
            {
                car = [self createCarData:stmt];
                [array addObject:car];
            }
            //            NSLog(@"%@,%@",poi.mID ,poi.mName);
        }
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
        
    }
    sqlite3_close(database);
    return array;
}

/*!
 @method createCarData:
 @abstract 将查找到的数据封装到car中
 @discussion 将查找到的数据封装到car中
 @param stmt　查找到的某条数据
 @param car　车辆
 */
- (CarData*)createCarData:(sqlite3_stmt*)stmt
{
    CarData *car = [[[CarData alloc]init]autorelease];
    int index = 0;
    char *text;
    text = (char*)sqlite3_column_text(stmt, index++);
    if (text) {
        car.mKeyID = [NSString stringWithUTF8String:text];
    }
    
    text = (char*)sqlite3_column_text(stmt, index++);
    if (text) {
        car.mCarID = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if (text) {
        car.mVin = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if (text) {
        car.mVType = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if (text) {
        car.mName = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if (text) {
        car.mCarRegisCode = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if (text) {
        car.mCarNumber = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if (text) {
        car.mMotorCode = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if (text) {
        car.mUserID = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if (text) {
        car.mLon = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if (text) {
        car.mLat = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if (text) {
        car.mSim = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if (text) {
        self.mLastRpTime = [NSString stringWithUTF8String:text];
    }
    return car;
}

@end
