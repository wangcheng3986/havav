
/*!
 @header UserData.m
 @abstract 操作用户表
 @author mengy
 @version 1.00 12-6-23 Creation
 */
#import <sqlite3.h>

#import "App.h"
#import "UserData.h"
#define ACCOUNT_ERROR 0
#define ACCOUNT_OK 1
@interface UserData(Private)

- (void)initDatabase;
- (sqlite3*)openDatabase;
@end

@implementation UserData
@synthesize mUserID;
@synthesize mUserKeyID;
@synthesize mAccount;
@synthesize mPassword;
@synthesize mType;
@synthesize mIsFirstLogin;
@synthesize mCarVin;
@synthesize msafe_pwd;
@synthesize mFlag;
@synthesize mLat;
@synthesize mLon;
@synthesize mLastReqTime;

/*!
 @method initWithName:(NSString *)userKeyID account:(NSString*)account password:(NSString*)password type:(int)type carVin:(NSString *)carVin safe_pwd:(NSString *)msafe_pwd flag:(int)flag lon:(NSString *)lon lat:(NSString *)lat
 lastreqtime:(NSString *)lastreqtime userID:(NSString *)userID
 @abstract 初始化缓存中数据
 @discussion 初始化缓存中数据
 @param 用户信息
 @result self
 */
- (id)initWithName:userKeyID
           account:(NSString*)account
          password:(NSString*)password
              type:(int)type
            carVin:(NSString *)carVin
          safe_pwd:(NSString *)safe_pwd
              flag:(int)flag
               lon:(NSString *)lon
               lat:(NSString *)lat
       lastreqtime:(NSString *)lastreqtime
            userID:(NSString *)userID
{
    self = [super init];
    mUserKeyID=[userKeyID copy];
    mUserID = [userID copy];
    mAccount = [account copy];
    NSLog(@" mAccount=%@",mAccount);
    mPassword = [password copy];
    mType = type;
    mCarVin=[carVin copy];
    msafe_pwd=[safe_pwd copy];
    mFlag=flag;
    mLon=[lon copy];
    mLat=[lat copy];
    mLastReqTime = [lastreqtime copy];
    [self initDatabase];
    return self;
}

-(void)dealloc
{
    [mUserKeyID release];
    [mUserID release];
    [mAccount release];
    [mPassword release];
    [mCarVin release];
    [msafe_pwd release];
    [mLon release];
    [mLat release];
//    [mLastReqTime release];
    [super dealloc];
}

/*!
 @method isHasUser:(NSString *)userID
 @abstract 判断用户信息是否在数据库中存在
 @discussion 判断用户信息是否在数据库中存在
 @param userID 用户ID
 @result 是否存在
 */
+ (int)isHasUser:(NSString *)userID
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *databaseFilePath = [documentsDirectory stringByAppendingPathComponent:DATABASE_NAME];
    
    sqlite3 *database;
    int result = sqlite3_open([databaseFilePath UTF8String], &database);
    if(result == SQLITE_OK)
    {
        int count = 0;
        NSString *sql = [NSString stringWithFormat:@"SELECT count(*) FROM %@ WHERE USER_ID='%@'", TABLE_USERDATA, userID];
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
        if(count == 0)
        {
            return ACCOUNT_ERROR;
        }
        else
        {
            return ACCOUNT_OK;
        }
        
    }
    sqlite3_close(database);
    return ACCOUNT_ERROR;
}

/*!
 @method initDatabase
 @abstract 建表
 @discussion 建表
 @param 无
 @result 无
 */
- (void)initDatabase
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        char *msg;
        NSString *sql;
        
        do
        {
            //create userdata table
            sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(KEYID TEXT, USER_ID TEXT,PASSWORD TEXT,USER_TYPE INTEGER,IS_SYNC_CONTACTS INTEGER,VEHICLE_VIN TEXT,SAFE_PWD TEXT,FLAG INTEGER,LON TEXT,LAT TEXT,LAST_RQ_TIME TEXT,ACCOUNT TEXT)", TABLE_USERDATA];
            
            if(sqlite3_exec(database, [sql UTF8String], NULL, NULL, &msg) != SQLITE_OK)
            {
                NSLog(@"create user table fail.");
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
 @result database 数据库
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
 @method userExist:(sqlite3*)database userID:(NSString *)userID
 @abstract 判断用户是否存在
 @discussion 判断用户是否存在
 @param userID 用户id
 @param database 数据库
 @result bool
 */
- (BOOL)userExist:(sqlite3*)database userID:(NSString *)userID
{
    int count = 0;
    NSString *sql = [NSString stringWithFormat:@"SELECT count(*) FROM %@ WHERE USER_ID='%@'", TABLE_USERDATA, userID];
    NSLog(@"%@",sql);
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
    NSLog(@"%d",count);
    if (count > 0) {
        return YES;
    }
    else
    {
        return NO;
    }
}

/*!
 @method updateUserData:(NSString *)userKeyID account:(NSString *)account password:(NSString *)password type:(int)type safe_pwd:(NSString *)safe_pwd
 flag:(int)flag lon:(NSString *)lon lat:(NSString *)lat lastreqtime:(NSString *)lastreqtime vin:(NSString *)vin userID:(NSString *)userID
 @abstract 添加或更新用户信息
 @discussion 添加或更新用户信息
 @param 用户信息
 @result 无
 */
- (void)updateUserData:(NSString *)userkeyid
               account:(NSString *)account
              password:(NSString *)password
                  type:(int)type
              safe_pwd:(NSString *)safe_pwd
                  flag:(int)flag
                   lon:(NSString *)lon
                   lat:(NSString *)lat
           lastreqtime:(NSString *)lastreqtime
                   vin:(NSString *)vin
                userID:(NSString *)userID
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        [self updateUserData:database
                   userkeyid:userkeyid
                     account:account
                    password:password
                        type:type
                    safe_pwd:safe_pwd
                        flag:flag
                         lon:lon
                         lat:lat
                 lastreqtime:lastreqtime
                         vin:vin
                      userID:userID];
        
    }
    sqlite3_close(database);
}

/*!
 @method updateUserData:(sqlite3*)database userkeyid:(NSString *)(NSString *)userKeyID account:(NSString *)account password:(NSString *)password type:(int)type safe_pwd:(NSString *)safe_pwd vin:(NSString *)vin
 flag:(int)flag lon:(NSString *)lon lat:(NSString *)lat lastreqtime:(NSString *)lastreqtime userID:(NSString *)userID
 @abstract 添加或更新用户信息
 @discussion 添加或更新用户信息
 @param 用户信息
 @result 无
 */
- (void)updateUserData:(sqlite3*)database
             userkeyid:(NSString *)userkeyid
               account:(NSString *)account
              password:(NSString *)password
                  type:(int)type
              safe_pwd:(NSString *)safe_pwd
                  flag:(int)flag
                   lon:(NSString *)lon
                   lat:(NSString *)lat
           lastreqtime:(NSString *)lastreqtime
                   vin:(NSString *)vin
                userID:(NSString *)userID

{
//KEYID,USER_ID,PASSWORD,USER_TYPE,IS_SYNC_CONTACTS,VEHICLE_VIN,SAFE_PWD,FLAG,LON,LAT,LAST_RQ_TIME
//    NSLog(@"%d",[self userExist:database]);
    if ([self userExist:database userID:userID]==YES) {
        NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET ACCOUNT = '%@', PASSWORD='%@',USER_TYPE=%d,SAFE_PWD='%@',FLAG=%d,VEHICLE_VIN = '%@' WHERE USER_ID='%@'",TABLE_USERDATA,account,password,type,safe_pwd,flag,vin,userID];
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            int index = 1;
            sqlite3_bind_text(stmt, index++, [mAccount UTF8String], -1, NULL);
            //        sqlite3_bind_int(stmt, index++, mSelectedCar);
            NSLog(@"update user ok.");
            if(sqlite3_step(stmt) != SQLITE_DONE)
            {
                NSLog(@"update user error.");
            }
        }
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);

    }
    else
    {
        NSLog(@"%@",account);
        NSLog(@"%@",password);
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@(KEYID,USER_ID,PASSWORD,USER_TYPE,IS_SYNC_CONTACTS,VEHICLE_VIN,SAFE_PWD,FLAG,LON,LAT,LAST_RQ_TIME,ACCOUNT) VALUES('%@','%@','%@',%d,%d,'%@','%@',%d,'%@','%@','%@','%@')",TABLE_USERDATA,userkeyid,userID,password,type,USER_FIRSTLOGIN,vin,safe_pwd,flag,lon,lat,lastreqtime,account];
    
    sqlite3_stmt *stmt;
    if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
    {
        int index = 1;
        sqlite3_bind_text(stmt, index++, [mAccount UTF8String], -1, NULL);
        //        sqlite3_bind_int(stmt, index++, mSelectedCar);
        NSLog(@"add user ok.");
        if(sqlite3_step(stmt) != SQLITE_DONE)
        {
            NSLog(@"add user error.");
        }
    }
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
        }
    [self loadUserData:database userID:userID];
}

/*!
 @method updateIsFirstLogin:(NSString *)userID
 @abstract 修改用户是否首次进入车友
 @discussion 修改用户是否首次进入车友
 @param userID 用户id
 @result 无
 */
- (void)updateIsFirstLogin:(NSString *)userID
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        [self updateIsFirstLogin:database userID:userID];
    }
    sqlite3_close(database);
}

/*!
 @method updateIsFirstLogin:(sqlite3*)database userID:(NSString *)userID
 @abstract 修改用户是否首次进入车友
 @discussion 修改用户是否首次进入车友
 @param userID 用户id
 @param database 数据库
 @result 无
 */
- (void)updateIsFirstLogin:(sqlite3*)database userID:(NSString *)userID
{
    NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET IS_SYNC_CONTACTS=%d WHERE USER_ID='%@'",TABLE_USERDATA, USER_UNFIRSTLOGIN,userID];
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
    [self loadUserData:database userID:userID];
}

/*!
 @method updateLocation:(NSString *)userID lon:(NSString *)lon lat:(NSString *)lat
 @abstract 更新用户手机位置
 @discussion 更新用户手机位置
 @param userID 用户id
 @param lon 经度
 @param lat 纬度
 @result 无
 */
-(void)updateLocation:(NSString *)userID
                  lon:(NSString *)lon
                  lat:(NSString *)lat
{
    
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        [self updateLocation:database userID:userID lon:lon lat:lat];
    }
    sqlite3_close(database);
}

/*!
 @method updateLocation:(sqlite3*)database userID:(NSString *)userID lon:(NSString *)lon lat:(NSString *)lat
 @abstract 更新用户手机位置
 @discussion 更新用户手机位置
 @param userID 用户id
 @param lon 经度
 @param lat 纬度
 @param database 数据库
 @result 无
 */
- (void)updateLocation:(sqlite3*)database userID:(NSString *)userID lon:(NSString *)lon lat:(NSString *)lat
{
    NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET LON=%@,LAT=%@ WHERE USER_ID='%@'",TABLE_USERDATA, lon,lat,userID];
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
    [self loadUserData:database userID:userID];
}

/*!
 @method updateLastReqTime:(NSString *)userID lastreqtime:(NSString *)lastreqtime
 @abstract 更新用户消息最后请求时间
 @discussion 更新用户消息最后请求时间
 @param userID 用户id
 @param lastreqtime 最后请求时间
 @result 无
 */
-(void)updateLastReqTime:(NSString *)userID
             lastreqtime:(NSString *)lastreqtime
{
    //mLastReqTime = [lastreqtime copy];
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        [self updateLastReqTime:database userID:userID lastreqtime:lastreqtime];
    }
    sqlite3_close(database);
}

/*!
 @method updateLastReqTime:(sqlite3*)database userID:(NSString *)userID lastreqtime:(NSString *)lastreqtime
 @abstract 更新用户消息最后请求时间
 @discussion 更新用户消息最后请求时间
 @param userID 用户id
 @param lastreqtime 最后请求时间
 @param database 数据库
 @result 无
 */
- (void)updateLastReqTime:(sqlite3*)database
                  userID:(NSString *)userID
              lastreqtime:(NSString *)lastreqtime
{

    NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET LAST_RQ_TIME=%@ WHERE USER_ID='%@'",TABLE_USERDATA, lastreqtime,userID];
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
    [self loadUserData:database userID:userID];
}

/*!
 @method updateVinWithUserID:(NSString *)userID vin:(NSString *)vin
 @abstract 更新用户选择车辆的vin
 @discussion 更新用户选择车辆的vin
 @param 用户id
 @param vin 车辆vin
 @result 无
 */
-(void)updateVinWithUserID:(NSString *)userID
                        vin:(NSString *)vin
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        [self updateVinWithDB:database userID:userID vin:vin];
    }
    sqlite3_close(database);
}

/*!
 @method updateVinWithDB:(sqlite3*)database userID:(NSString *)userID vin:(NSString *)vin
 @abstract 更新用户选择车辆的vin
 @discussion 更新用户选择车辆的vin
 @param userID 用户id
 @param vin 车辆vin
 @param database 数据库
 @result 无
 */
- (void)updateVinWithDB:(sqlite3*)database
                userID:(NSString *)userID
                    vin:(NSString *)vin
{
    //KEYID,USER_ID,PASSWORD,USER_TYPE,IS_SYNC_CONTACTS,VEHICLE_VIN,SAFE_PWD,FLAG,LON,LAT,LAST_RQ_TIME
    NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET VEHICLE_VIN='%@' WHERE USER_ID='%@'",TABLE_USERDATA, vin,userID];
    NSLog(@"%@",sql);
    sqlite3_stmt *stmt;
    
    if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
    {
        if(sqlite3_step(stmt) != SQLITE_DONE)
        {
            NSLog(@"Updating vin code error!");
        }
    }
    else{
        NSLog(@"Updating vin code error!");
    }
    sqlite3_reset(stmt);
    sqlite3_finalize(stmt);
    [self loadUserData:database userID:userID];
}

/*!
 @method getUserPassword:(NSString *)userID
 @abstract 根据账号获取密码
 @discussion 根据账号获取密码
 @param userID 用户id
 @result pwd 密码
 */
- (NSString *)getUserPassword:(NSString *)userID
{
    NSString *password=@"";
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        password=[self getUserPassword:database userID:userID];
    }
    sqlite3_close(database);
    return password;
}

/*!
 @method getUserPassword:(sqlite3*)database userID:(NSString *)userID
 @abstract 根据账号获取密码
 @discussion 根据账号获取密码
 @param userID 用户id
 @param database 数据库
 @result pwd 密码
 */
- (NSString *)getUserPassword:(sqlite3*)database userID:(NSString *)userID
{
    NSString *password=@"";
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE USER_ID='%@'",TABLE_USERDATA, userID];
    sqlite3_stmt *stmt;
    if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
    {
        if(sqlite3_step(stmt) == SQLITE_ROW)
        {
            int index = 2;
            char *text;
            text = (char*)sqlite3_column_text(stmt, index++);
            if (text) {
                password = [NSString stringWithUTF8String:text];
            }
        }
    }
    sqlite3_reset(stmt);
    sqlite3_finalize(stmt);
    return password;
    
}

/*!
 @method getUserLastReqTime:(NSString *)userID
 @abstract 获取用户最后请求时间，存入缓存
 @discussion 获取用户最后请求时间，存入缓存
 @param 无
 @result 无
 */
- (void)getUserLastReqTime:(NSString *)userID
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE USER_ID='%@'",TABLE_USERDATA, userID];
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            if(sqlite3_step(stmt) == SQLITE_ROW)
            {
                int index = 10;
                char *text;
                text = (char*)sqlite3_column_text(stmt, index++);
                if (text) {
                    self.mLastReqTime = [NSString stringWithUTF8String:text];
                }
            }
        }
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
    }
    sqlite3_close(database);

}

/*!
 @method loadUserData:(sqlite3*)database userID:(NSString *)userID
 @abstract 加载用户信息到缓存
 @discussion 加载用户信息到缓存
 @param userID 用户id
 @param database 数据库
 @result 无
 */
- (void)loadUserData:(sqlite3*)database userID:(NSString *)userID
{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE USER_ID='%@'",TABLE_USERDATA, userID];
    sqlite3_stmt *stmt;
    if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
    {
        if(sqlite3_step(stmt) == SQLITE_ROW)
        {
            int index = 0;
            char *text;
            text = (char*)sqlite3_column_text(stmt, index++);
            if (text) {
                self.mUserKeyID = [NSString stringWithUTF8String:text];
            }

            text = (char*)sqlite3_column_text(stmt, index++);
            if (text) {
                self.mUserID = [NSString stringWithUTF8String:text];
            }
            text = (char*)sqlite3_column_text(stmt, index++);
            if (text) {
                self.mPassword = [NSString stringWithUTF8String:text];
            }
            self.mType=sqlite3_column_int(stmt, index++);

            self.mIsFirstLogin = sqlite3_column_int(stmt, index++);
            text = (char*)sqlite3_column_text(stmt, index++);
            if (text) {
                self.mCarVin = [NSString stringWithUTF8String:text];
            }
            text = (char*)sqlite3_column_text(stmt, index++);
            if (text) {
                self.msafe_pwd = [NSString stringWithUTF8String:text];
            }
            self.mFlag = sqlite3_column_int(stmt, index++);
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
                self.mLastReqTime = [NSString stringWithUTF8String:text];
                //NSLog(@"%d",[mLastReqTime retainCount]);
            }
            text = (char*)sqlite3_column_text(stmt, index++);
            if (text) {
                self.mAccount = [NSString stringWithUTF8String:text];
            }
            NSLog(@"keyid=%@, account=%@,  pass=%@,mType=%d,  mfirst=%d, carVin=%@,safe_pwd=%@, mFlag=%d, mLon=%@,mLat=%@,mLastReqTime=%@",mUserKeyID, mAccount,mPassword,mType,mIsFirstLogin,mCarVin,msafe_pwd,mFlag,mLon,mLat,mLastReqTime);
        }
    }
    sqlite3_reset(stmt);
    sqlite3_finalize(stmt);
}

/*!
 @method deleteDemo
 @abstract 删除demo账号
 @discussion 删除demo账号
 @param 无
 @result 无
 */
- (void)deleteDemo
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        [self deleteDemo:database];
    }
    sqlite3_close(database);
}

/*!
 @method deleteDemo:(sqlite3*)database
 @abstract 删除demo账号
 @discussion 删除demo账号
 @param database 数据库
 @result 无
 */
- (void)deleteDemo:(sqlite3*)database
{
    if ([self userExist:database userID:@"demo_admin"]==YES)
    {
        //(KEYID,ID,NAME,PHONE,SEX,ADDRESS,ISBLACKLIST,USER_KEYID,LON,LAT,LAST_RQ_TIME,TFTYPE,LAST_UPDATE)
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE USER_ID='demo_admin'",TABLE_USERDATA];
        NSLog(@"%@",sql);
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            if(sqlite3_step(stmt) != SQLITE_DONE)
            {
                NSLog(@"DEL demo_admin error.");
            }
        }
        
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
        
    }
    else
    {
        NSLog(@"DEL demo_admin error.");
    }
}


/*!
 @method loadDemoUserData
 @abstract 加载demo用户信息到缓存
 @discussion 加载demo用户信息到缓存
 @param 无
 @result 无
 */
- (void)loadDemoUserData
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        [self loadUserData:database userID:@"demo_admin"];
    }
    sqlite3_close(database);
}

/*!
 @method loadUserData
 @abstract 加载用户信息到缓存中
 @discussion 加载用户信息到缓存中
 @param 无
 @result 无
 */
- (void)loadUserData
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        [self loadUserData:database userID:mUserID];
    }
    sqlite3_close(database);
}

//KEYID,USER_ID,PASSWORD,USER_TYPE,IS_SYNC_CONTACTS,VEHICLE_VIN,SAFE_PWD,FLAG,LON,LAT,LAST_RQ_TIME

//- (void)addUserData:(sqlite3*)database
//{
//    NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@(KEYID,USER_ID,PASSWORD,USER_TYPE, IS_SYNC_CONTACTS,VEHICLE_VIN,SAFE_PWD,FLAG,LON,LAT) VALUES(?,?,?,?,?,?,?,?,?,?)",TABLE_USERDATA];
//    
//    sqlite3_stmt *stmt;
//    if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
//    {
//        int index = 1;
////        sqlite3_bind_text(stmt, index++, [mUserKeyID UTF8String], -1, NULL);
//        sqlite3_bind_text(stmt, index++, [mAccount UTF8String], -1, NULL);
//        sqlite3_bind_text(stmt, index++, [mPassword UTF8String], -1, NULL);
//        sqlite3_bind_int(stmt, index++, mType);
//        sqlite3_bind_int(stmt, index++, USER_FIRSTLOGIN);
//        sqlite3_bind_text(stmt, index++, [mCarVin UTF8String], -1, NULL);
//        sqlite3_bind_text(stmt, index++, [msafe_pwd UTF8String], -1, NULL);
//        sqlite3_bind_int(stmt, index++, mFlag);
//        sqlite3_bind_text(stmt, index++, [mLon UTF8String], -1, NULL);
//        sqlite3_bind_text(stmt, index++, [mLat UTF8String], -1, NULL);
//        sqlite3_bind_text(stmt, index++, [mLastReqTime UTF8String], -1, NULL);
//        if(sqlite3_step(stmt) != SQLITE_DONE)
//        {
//            NSLog(@"add user error.");
//        }
//    }
//    sqlite3_reset(stmt);
//    sqlite3_finalize(stmt);
//}

@end
