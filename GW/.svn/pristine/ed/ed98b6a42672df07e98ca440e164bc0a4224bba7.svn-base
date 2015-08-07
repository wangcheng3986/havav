/*!
 @header POIData.m
 @abstract 操作poi表
 @author mengy
 @version 1.00 13-5-13 Creation
 */
#import <sqlite3.h>
#import "UserData.h"
#import "POIData.h"


@interface POIData(Private)

- (void)initDatabase;
- (sqlite3*)openDatabase;
@end
@implementation POIData
@synthesize mfID;
@synthesize mAddress;
@synthesize mDesc;
@synthesize mCreateTime;
@synthesize mFlag;
@synthesize mID;
@synthesize mKeyID;
@synthesize mLat;
@synthesize mLon;
@synthesize mName;
@synthesize mPhone;
@synthesize mUserID;
@synthesize mLevel;
@synthesize mPostCode;
/*!
 @method initPOIDatabase
 @abstract 建表
 @discussion 建表
 @param 无
 @result 无
 */
- (void)initPOIDatabase
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        char *msg;
        NSString *sql;
        do
        {
            //create poi table
//            KEYID,FPOIID,POIID,NAME,CREATE_TIME,LON,LAT,PHONE,ADDRESS,DESC,FLAG,POST_CODE,LEVEL,USER_KEYID
            sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ ( KEYID TEXT PRIMARY KEY , FPOIID TEXT , POIID TEXT, NAME TEXT, CREATE_TIME TEXT, LON TEXT, LAT TEXT, PHONE TEXT, ADDRESS TEXT, DESC TEXT, FLAG INTEGER ,USER_ID TEXT,LEVEL INTEGER,POST_CODE TEXT)", TABLE_POIDATA];
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

-(void)dealloc
{
    [mKeyID release];
    [mfID release];
    [mID release];
    [mName release];
    [mCreateTime release];
    [mLon release];
    [mLat release];
    [mPhone release];
     [mAddress release];
     [mDesc release];
     [mUserID release];
     [mPostCode release];
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

/*!
 @method addPOIData:(NSString *)keyID fID:(NSString *)fID ID:(NSString *)ID name:(NSString *)name createTime:(NSString *)createTime lon:(NSString *)lon lat:(NSString *)lat phone:(NSString *)phone address:(NSString *)address desc:(NSString *)desc flag:(int)flag userID:(NSString *)userID level:(int)level postCode:(NSString *)postCode
 @abstract 插入一条poi数据
 @discussion 插入一条poi数据
 @param poi信息
 @result 无
 */
- (void)addPOIData:(NSString *)keyID
                fID:(NSString *)fID
                ID:(NSString *)ID
              name:(NSString *)name
        createTime:(NSString *)createTime
               lon:(NSString *)lon
               lat:(NSString *)lat
             phone:(NSString *)phone
           address:(NSString *)address
              desc:(NSString *)desc
              flag:(int)flag
            userID:(NSString *)userID
             level:(int)level
          postCode:(NSString *)postCode
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        [self addPOIData:database
                   keyID:keyID
                     fID:fID
                      ID:ID
                    name:name
              createTime:createTime
                     lon:lon
                     lat:lat
                   phone:phone
                 address:address
                    desc:desc
                    flag:flag
                  userID:userID
                   level:(int)level
                postCode:(NSString *)postCode
         ];
        
    }
    sqlite3_close(database);
}

- (void)addPOIData:(sqlite3*)database
             keyID:(NSString *)keyID
               fID:(NSString *)fID
                ID:(NSString *)ID
              name:(NSString *)name
        createTime:(NSString *)createTime
               lon:(NSString *)lon
               lat:(NSString *)lat
             phone:(NSString *)phone
           address:(NSString *)address
              desc:(NSString *)desc
              flag:(int)flag
            userID:(NSString *)userID
             level:(int)level
          postCode:(NSString *)postCode
{
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@(KEYID, FPOIID, POIID,NAME,CREATE_TIME,LON,LAT,PHONE,ADDRESS,DESC,FLAG,USER_ID,LEVEL,POST_CODE) VALUES('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@',%d,'%@',%d,'%@')",TABLE_POIDATA,keyID,fID,ID,name,createTime,lon,lat,phone,address,desc,flag,userID,level,postCode];
//    NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@(FID, ID,NAME,CREATE_TIME,LON,LAT,PHONE,ADDRESS,DESC,FLAG,USER_ID,LEVEL,POST_CODE) VALUES('%@','%@','%@','%@','%@','%@','%@','111','111',%d,'%@',%d,'%@')",TABLE_POIDATA,fID,ID,name,createTime,lon,lat,phone,flag,userID,level,postCode];
    NSLog(@"%@",sql);
    sqlite3_stmt *stmt;
    if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
    {
//        int index = 1;
//        sqlite3_bind_text(stmt, index++, [ID UTF8String], -1, NULL);
        //        sqlite3_bind_int(stmt, index++, mSelectedCar);
        NSLog(@"add poi ok.");
        if(sqlite3_step(stmt) != SQLITE_DONE)
        {
            NSLog(@"add poi error.");
        }
    }
    sqlite3_reset(stmt);
    sqlite3_finalize(stmt);
}

/*!
 @method addPOIDataWithSqls:(NSMutableArray *)sqls
 @abstract 传入sql语句插入poi信息
 @discussion 传入sql语句插入poi信息
 @param sqls sql数组
 @result 无
 */

- (void)addPOIDataWithSqls:(NSMutableArray *)sqls
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        [self addPOIDataWithSqls:database
                   sql:sqls
         ];
        
    }
    sqlite3_close(database);
}

- (void)addPOIDataWithSqls:(sqlite3*)database
                       sql:(NSMutableArray *)sqls
{
    for (int i = 0; i < sqls.count; i ++) {
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [[sqls objectAtIndex:i] UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            NSLog(@"add poi ok.");
            if(sqlite3_step(stmt) != SQLITE_DONE)
            {
                NSLog(@"add poi error.");
            }
        }
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
    }
    
}

/*!
 @method updatePOIData:(NSString *)keyID fID:(NSString *)fID ID:(NSString *)ID name:(NSString *)name createTime:(NSString *)createTime lon:(NSString *)lon lat:(NSString *)lat phone:(NSString *)phone address:(NSString *)address desc:(NSString *)desc flag:(int)flag userID:(NSString *)userID level:(int)level postCode:(NSString *)postCode
 @abstract 更新一条poi数据
 @discussion 更新一条poi数据
 @param poi信息
 @result 无
 */
- (void)updatePOIData:(NSString *)keyID
                  fID:(NSString *)fID
                   ID:(NSString *)ID
                 name:(NSString *)name
           createTime:(NSString *)createTime
                  lon:(NSString *)lon
                  lat:(NSString *)lat
                phone:(NSString *)phone
              address:(NSString *)address
                 desc:(NSString *)desc
                 flag:(int)flag
               userID:(NSString *)userID
                level:(int)level
             postCode:(NSString *)postCode
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        [self updatePOIData:database
                      keyID:keyID
                        fID:fID
                         ID:ID
                       name:name
                 createTime:createTime
                        lon:lon
                        lat:lat
                      phone:phone
                    address:address
                       desc:desc
                       flag:flag
                     userID:userID
                      level:level
                   postCode:postCode];
    }
    sqlite3_close(database);
}

- (void)updatePOIData:(sqlite3*)database
                keyID:(NSString *)keyID
                  fID:(NSString *)fID
                   ID:(NSString *)ID
                 name:(NSString *)name
           createTime:(NSString *)createTime
                  lon:(NSString *)lon
                  lat:(NSString *)lat
                phone:(NSString *)phone
              address:(NSString *)address
                 desc:(NSString *)desc
                 flag:(int)flag
               userID:(NSString *)userID
                level:(int)level
             postCode:(NSString *)postCode

{
        NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET  KEYID='%@'FPOIID='%@',POIID='%@',NAME='%@',CREATE_TIME='%@',LON='%@',LAT='%@',PHONE='%@',ADDRESS='%@',DESC='%@',FLAG=%d, LEVEL=%d,POST_CODE='%@' WHERE LON='%@' AND LAT='%@' AND USER_ID='%@' AND ID='%@'",TABLE_POIDATA,keyID,fID,ID,name,createTime,lon,lat,phone,address,desc,flag,level,postCode,lon,lat,userID,ID];
        NSLog(@"%@",sql);
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
//            int index = 1;
//            sqlite3_bind_text(stmt, index++, [ID UTF8String], -1, NULL);
            //        sqlite3_bind_int(stmt, index++, mSelectedCar);
            NSLog(@"update poi ok.");
//            NSLog(@"%d",sqlite3_step(stmt));
            if(sqlite3_step(stmt) != SQLITE_DONE)
            {
                NSLog(@"update poi error.");
            }
        }
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
        
//    else
//    {
//        NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@(FID, ID,NAME,CREATE_TIME,LON,LAT,PHONE,ADDRESS,DESC,FLAG,USER_ID,LEVEL,POST_CODE) VALUES('%@','%@','%@','%@','%@','%@','%@','%@','%@',%d,'%@',%d,'%@')",TABLE_POIDATA,fID,ID,name,createTime,lon,lat,phone,address,desc,flag,userID,level,postCode];
//        NSLog(@"%@",sql);
//        sqlite3_stmt *stmt;
//        int result = sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil);
//        if( result== SQLITE_OK)
//        {
//            //            int index = 1;
//            //            sqlite3_bind_text(stmt, index++, [fID UTF8String], -1, NULL);
//            //        sqlite3_bind_int(stmt, index++, mSelectedCar);
//            NSLog(@"add poi ok.");
//            if(sqlite3_step(stmt) != SQLITE_DONE)
//            {
//                NSLog(@"add poi error.");
//            }
//        }
//        sqlite3_reset(stmt);
//        sqlite3_finalize(stmt);
//    }
}

/*!
 @method updateFlag:(NSString *)lon lat:(NSString *)lat flag:(int)flag userID:(NSString*)userID ID:(NSString *)ID fID:(NSString *)fID
 @abstract 根据userID，ID，fID更新poi状态
 @discussion 根据userID，ID，fID更新poi状态
 @param userID 所属用户id
 @param ID poiid
 @param fID 收藏id
 @param lon 经度暂时无用
 @param lat 纬度暂时无用
 @param flag 状态
 @result 无
 */
- (void)updateFlag:(NSString *)lon
               lat:(NSString *)lat
              flag:(int)flag
            userID:(NSString*)userID
                ID:(NSString *)ID
               fID:(NSString *)fID
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        [self updateFlag:database
                     lon:lon
                     lat:lat
                    flag:flag
                  userID:userID
                      ID:ID
                     fID:fID];
        
    }
    sqlite3_close(database);
}

- (void)updateFlag:(sqlite3*)database
               lon:(NSString *)lon
               lat:(NSString *)lat
              flag:(int)flag
         userID:(NSString*)userID
         ID:(NSString *)ID
         fID:(NSString *)fID

{
    NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET FLAG=%d WHERE USER_ID='%@' AND POIID='%@' AND FPOIID='%@'",TABLE_POIDATA,flag,userID,ID,fID];
    
    sqlite3_stmt *stmt;
    if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
    {
        //            int index = 1;
        //            sqlite3_bind_text(stmt, index++, [ID UTF8String], -1, NULL);
        //        sqlite3_bind_int(stmt, index++, mSelectedCar);
        NSLog(@"update FLAG ok.");
        if(sqlite3_step(stmt) != SQLITE_DONE)
        {
            NSLog(@"update FLAG error.");
        }
    }
    sqlite3_reset(stmt);
    sqlite3_finalize(stmt);
    
}

/*!
 @method updateFlag:(int)flag userID:(NSString*)userID IDs:(NSMutableArray *)IDs
 @abstract 根据userID，ID，fID更新poi状态
 @discussion 根据userID，ID，fID更新poi状态
 @param userID 所属用户id
 @param ID poiid
 @param flag 状态
 @result 无
 */
- (void)updateFlag:(int)flag
            userID:(NSString*)userID
               IDs:(NSMutableArray *)IDs
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        [self updateFlag:database
                    flag:flag
                  userID:userID
                     IDs:IDs];
        
    }
    sqlite3_close(database);
}

- (void)updateFlag:(sqlite3*)database
              flag:(int)flag
            userID:(NSString*)userID
               IDs:(NSMutableArray *)IDs

{
    NSString *str = [NSString stringWithFormat:@"%@",[IDs objectAtIndex:0]];
    for (int i = 1; i<IDs.count; i++) {
        str = [str stringByAppendingString:[NSString stringWithFormat:@"','%@",[IDs objectAtIndex:i]]];
    }
    NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET FLAG=%d WHERE USER_ID='%@' AND POIID IN('%@')",TABLE_POIDATA,flag,userID,str];
    
    sqlite3_stmt *stmt;
    if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
    {
        //            int index = 1;
        //            sqlite3_bind_text(stmt, index++, [ID UTF8String], -1, NULL);
        //        sqlite3_bind_int(stmt, index++, mSelectedCar);
        NSLog(@"update FLAG ok.");
        if(sqlite3_step(stmt) != SQLITE_DONE)
        {
            NSLog(@"update FLAG error.");
        }
    }
    sqlite3_reset(stmt);
    sqlite3_finalize(stmt);
    
}

/*!
 @method updatePOINameAndFlag:(NSString *)name flag:(int)flag userID:(NSString*)userID ID:(NSString *)ID fID:(NSString *)fID createTime:(NSString *)createTime
 @abstract 根据userID，ID，fID更新poi状态
 @discussion 根据userID，ID，fID更新poi状态
 @param userID 所属用户id
 @param ID poiid
 @param fID 收藏id
 @param flag 状态
 @param name poiname
 @result 无
 */
- (void)updatePOINameAndFlag:(NSString *)name
                        flag:(int)flag
                      userID:(NSString*)userID
                          ID:(NSString *)ID
                         fID:(NSString *)fID
                  createTime:(NSString *)createTime
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET FLAG=%d,NAME = '%@',CREATE_TIME = '%@' WHERE USER_ID='%@' AND POIID='%@' AND FPOIID='%@'",TABLE_POIDATA,flag,name,createTime,userID,ID,fID];
        
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            NSLog(@"update name and flag ok.");
            if(sqlite3_step(stmt) != SQLITE_DONE)
            {
                NSLog(@"update name and flag error.");
            }
        }
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
        
    }
    sqlite3_close(database);
}



/*!
 @method deletePOIData:(NSString *)lon lat:(NSString *)lat userID:(NSString*)userID ID:(NSString *)ID fID:(NSString *)fID
 @abstract 根据userID，ID，fID删除poi
 @discussion 根据userID，ID，fID删除poi
 @param userID 所属用户id
 @param ID poiid
 @param fID 收藏id
 @param lon 经度暂时无用
 @param lat 纬度暂时无用
 @result 无
 */
- (void)deletePOIData:(NSString *)lon
                  lat:(NSString *)lat
               userID:(NSString*)userID
                   ID:(NSString *)ID
                  fID:(NSString *)fID
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        [self deletePOIData:database
                        lon:(NSString *)lon
                        lat:(NSString *)lat
                     userID:(NSString*)userID
                         ID:ID
                        fID:fID];
    }
    sqlite3_close(database);

}

- (void)deletePOIData:(sqlite3*)database
                  lon:(NSString *)lon
                  lat:(NSString *)lat
               userID:(NSString*)userID
                   ID:(NSString *)ID
                  fID:(NSString *)fID

{
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE USER_ID='%@' AND POIID='%@' AND FPOIID='%@'",TABLE_POIDATA,userID,ID,fID];
        NSLog(@"%@",sql);
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            //            int index = 1;
            //            sqlite3_bind_text(stmt, index++, [fID UTF8String], -1, NULL);
            //        sqlite3_bind_int(stmt, index++, mSelectedCar);
            NSLog(@"DEL POI ok.");
//            NSLog(@"%d",sqlite3_step(stmt));
            int result = sqlite3_step(stmt);
            if( result != SQLITE_DONE)
            {
                NSLog(@"DEL POI error.");
            }
        }
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);

}

/*!
 @method deletePOIDataWithFID:(NSString *)fID userID:(NSString*)userID
 @abstract 根据fID和userID删除未同步的poi，将已同步的poi置为删除未同步状态。
 @discussion 根据fID和userID删除未同步的poi，将已同步的poi置为删除未同步状态。
 @param userID 所属用户id
 @param fID 收藏id
 @result 无
 */
- (void)deletePOIDataWithFID:(NSString *)fID
                      userID:(NSString*)userID
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        [self deletePOIDataWithFID:database
                               fID:fID
                            userID:userID];
    }
    sqlite3_close(database);
    
}

- (void)deletePOIDataWithFID:(sqlite3*)database
                         fID:(NSString *)fID
                      userID:(NSString*)userID
                  

{
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE USER_ID = '%@' AND FLAG == %d AND FPOIID IN (%@)",TABLE_POIDATA,userID,COLLECT_SYNC_NO_ADD,fID];
    NSLog(@"%@",sql);
    sqlite3_stmt *stmt;
    NSLog(@"%d",sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil));
    if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
    {
        NSLog(@"DEL POI ok.");
        int result = sqlite3_step(stmt);
        if( result != SQLITE_DONE)
        {
            NSLog(@"DEL POI error.");
        }
    }
    sqlite3_reset(stmt);
    sqlite3_finalize(stmt);
    
    NSString *sql2 = [NSString stringWithFormat:@"UPDATE %@ SET FLAG=%d WHERE USER_ID='%@' AND FLAG != %d AND FPOIID IN (%@)",TABLE_POIDATA,COLLECT_SYNC_NO_DEL,userID,COLLECT_SYNC_NO_ADD,fID];
    
    sqlite3_stmt *stmt2;
    if(sqlite3_prepare_v2(database, [sql2 UTF8String], -1, &stmt2, nil) == SQLITE_OK)
    {
        //            int index = 1;
        //            sqlite3_bind_text(stmt, index++, [ID UTF8String], -1, NULL);
        //        sqlite3_bind_int(stmt, index++, mSelectedCar);
        NSLog(@"update FLAG ok.");
        if(sqlite3_step(stmt2) != SQLITE_DONE)
        {
            NSLog(@"update FLAG error.");
        }
    }
    sqlite3_reset(stmt2);
    sqlite3_finalize(stmt2);
}

/*!
 @method deleteAllPOIData:(NSString*)userID
 @abstract 删除某用户下的所有poi
 @discussion 删除某用户下的所有poi
 @param userID 所属用户id
 @result 无
 */
- (void)deleteAllPOIData:(NSString*)userID
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        [self deleteAllPOIData:database
                        userID:(NSString*)userID];
        
    }
    sqlite3_close(database);
}

- (void)deleteAllPOIData:(sqlite3*)database
                  userID:(NSString*)userID

{
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE USER_ID='%@'",TABLE_POIDATA,userID];
        NSLog(@"%@",sql);
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            //            int index = 1;
            //            sqlite3_bind_text(stmt, index++, [fID UTF8String], -1, NULL);
            //        sqlite3_bind_int(stmt, index++, mSelectedCar);
            NSLog(@"DEL all POI ok.");
            int result = sqlite3_step(stmt);
            if( result != SQLITE_DONE)
            {
                NSLog(@"DEL allPOI error.");
            }
        }
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
}

/*!
 @method deleteSycnPOIData:(NSString*)userID
 @abstract 删除某用户下的所有已同步的poi
 @discussion 删除某用户下的所有已同步的poi
 @param userID 所属用户id
 @result 无
 */
- (void)deleteSycnPOIData:(NSString*)userID
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        [self deleteSycnPOIData:database
                        userID:(NSString*)userID];
    }
    sqlite3_close(database);
}

- (void)deleteSycnPOIData:(sqlite3*)database
                  userID:(NSString*)userID

{
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE FLAG=%d AND USER_ID='%@'",TABLE_POIDATA,COLLECT_SYNC_YES,userID];
    NSLog(@"%@",sql);
    sqlite3_stmt *stmt;
    if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
    {
        //            int index = 1;
        //            sqlite3_bind_text(stmt, index++, [fID UTF8String], -1, NULL);
        //        sqlite3_bind_int(stmt, index++, mSelectedCar);
        NSLog(@"DEL all POI ok.");
        int result = sqlite3_step(stmt);
        if( result != SQLITE_DONE)
        {
            NSLog(@"DEL allPOI error.");
        }
    }
    sqlite3_reset(stmt);
    sqlite3_finalize(stmt);
}

/*!
 @method poiExist:(NSString *)lon lat:(NSString *)lat userID:(NSString *)userID ID:(NSString *)ID fID:(NSString *)fID type:(int)type
 @abstract 根据不同类型的poi信息，通过不同的sql语句，判断该poi是否已经收藏
 @discussion 根据不同类型的poi信息，通过不同的sql语句，判断该poi是否已经收藏
 @param userID 所属用户id
 @param ID poiid
 @param fID 收藏id
 @param lon 经度暂时无用
 @param lat 纬度暂时无用
 @param type poi类型（手机位置、车机位置、自定义位置、收藏夹poi、搜索poi）
 @result BOOL
 */
- (BOOL)poiExist:(NSString *)lon lat:(NSString *)lat userID:(NSString *)userID ID:(NSString *)ID fID:(NSString *)fID type:(int)type
{
    BOOL exist=NO;
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        exist=[self poiExist:database
                         lon:lon
                         lat:lat
                      userID:userID
                          ID:ID
                         fID:fID
                        type:type];
    }
    sqlite3_close(database);
//    NSLog(@"%c",exist);
    return exist;
}


- (BOOL)poiExist:(sqlite3*)database lon:(NSString *)lon lat:(NSString *)lat userID:(NSString *)userID ID:(NSString *)ID fID:(NSString *)fID type:(int)type
{
//    @"SELECT count(*) FROM %@ WHERE LON='%@' AND LAT='%@' AND USER_ID='%@' And ID='%@' AND FID='%@'"
    int count = 0;
    NSString *sql;
    if (type==POI_TYPE_CAR||type==POI_TYPE_PHONE||type==POI_TYPE_POI) {
         sql = [NSString stringWithFormat:@"SELECT count(*) FROM %@ WHERE LON='%@' AND LAT='%@' AND USER_ID='%@' And FPOIID='%@' AND FPOIID!=''", TABLE_POIDATA,lon,lat,userID,fID];
    }
    else if(type==POI_TYPE_CUSTOM)
    {
         sql = [NSString stringWithFormat:@"SELECT count(*) FROM %@ WHERE LON='%@' AND LAT='%@' AND USER_ID='%@' ", TABLE_POIDATA,lon,lat,userID];
    }
    else if(type==POI_TYPE_RESULT)
    {
       sql = [NSString stringWithFormat:@"SELECT count(*) FROM %@ WHERE LON='%@' AND LAT='%@' AND USER_ID='%@' And POIID='%@' AND POIID!=''", TABLE_POIDATA,lon,lat,userID,ID];
    }
    else
    {
         sql = [NSString stringWithFormat:@"SELECT count(*) FROM %@ WHERE LON='%@' AND LAT='%@' AND USER_ID='%@' And POIID='%@' And FPOIID='%@'", TABLE_POIDATA,lon,lat,userID,ID,fID];
    }
   
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
 @method loadPoi:(NSString *)lon lat:(NSString *)lat userID:(NSString *)userID ID:(NSString *)ID fID:(NSString *)fID type:(int)type
 @abstract 根据不同类型的poi信息，通过不同的sql语句，判断该poi是否已经收藏
 @discussion 根据不同类型的poi信息，通过不同的sql语句，判断该poi是否已经收藏
 @param userID 所属用户id
 @param ID poiid
 @param fID 收藏id
 @param lon 经度暂时无用
 @param lat 纬度暂时无用
 @param type poi类型（手机位置、车机位置、自定义位置、收藏夹poi、搜索poi）
 @result POIData
 */
- (POIData*)loadPoi:(NSString *)lon lat:(NSString *)lat userID:(NSString *)userID ID:(NSString *)ID fID:(NSString *)fID type:(int)type
{
    POIData *poi = nil;
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        
        NSString *sql;
        if (type==POI_TYPE_CAR||type==POI_TYPE_PHONE||type==POI_TYPE_POI) {
            sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE LON='%@' AND LAT='%@' AND USER_ID='%@' And FPOIID='%@' AND FPOIID!=''", TABLE_POIDATA,lon,lat,userID,fID];
        }
        else if(type==POI_TYPE_CUSTOM)
        {
            sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE LON='%@' AND LAT='%@' AND USER_ID='%@' ", TABLE_POIDATA,lon,lat,userID];
        }
        else if(type==POI_TYPE_RESULT)
        {
            sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE LON='%@' AND LAT='%@' AND USER_ID='%@' And POIID='%@' AND POIID!=''", TABLE_POIDATA,lon,lat,userID,ID];
        }
        else
        {
            sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE LON='%@' AND LAT='%@' AND USER_ID='%@' And POIID='%@' And FPOIID='%@'", TABLE_POIDATA,lon,lat,userID,ID,fID];
        }
        
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            
            while(sqlite3_step(stmt) == SQLITE_ROW)
            {
                poi = [self createMPOI:stmt];
            }
            //            NSLog(@"%@,%@",poi.mID ,poi.mName);
        }
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
    }
    sqlite3_close(database);
    return poi;
}

/*!
 @method loadMeetRequestCollectTableData:(NSString *)userID
 @abstract 获取已同步和添加未同步的收藏夹列表
 @discussion 获取已同步和添加未同步的收藏夹列表
 @param userID 所属用户id
 @result poilist poi列表
 */
- (NSMutableArray*)loadMeetRequestCollectTableData:(NSString *)userID
{
    NSMutableArray *array = [[[NSMutableArray alloc]initWithCapacity:0]autorelease];
    
    sqlite3 *database = [self openDatabase];
    if(database)
    {
//        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE FLAG!=%d AND USER_ID='%@' ORDER BY FLAG ASC, CREATE_TIME DESC",TABLE_POIDATA,COLLECT_SYNC_NO_DEL,userID];
         NSString *sql = [NSString stringWithFormat:@"SELECT * ,replace(FLAG,'4','1') AS FLAG_SORT FROM %@ WHERE FLAG!=%d AND USER_ID='%@' ORDER BY FLAG_SORT, CREATE_TIME DESC",TABLE_POIDATA,COLLECT_SYNC_NO_DEL,userID];
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            POIData *poi;
            while(sqlite3_step(stmt) == SQLITE_ROW)
            {
                poi = [self createMPOI:stmt];
                [array addObject:poi];
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
 @method loadMeetRequestPOIDataSyncYES:(NSString *)userID
 @abstract 获取已同步的收藏夹列表
 @discussion 获取已同步的收藏夹列表
 @param userID 所属用户id
 @result poilist poi列表
 */
- (NSMutableArray*)loadMeetRequestPOIDataSyncYES:(NSString *)userID
{
    NSMutableArray *array = [[[NSMutableArray alloc]initWithCapacity:0]autorelease];
    
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE FLAG=%d AND USER_ID='%@' ORDER BY CREATE_TIME DESC",TABLE_POIDATA,COLLECT_SYNC_YES,userID];
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            POIData *poi;
            while(sqlite3_step(stmt) == SQLITE_ROW)
            {
                poi = [self createMPOI:stmt];
                [array addObject:poi];
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
 @method loadMeetRequestPOIData:(NSString *)userID lon:(NSString *)lon lat:(NSString *)lat
 @abstract 根据lon、lat、userid查找poi信息
 @discussion 根据lon、lat、userid查找poi信息
 @param userID 所属用户id
 @param lon 经度
 @param lat 纬度
 @result poi poi信息
 */
- (POIData*)loadMeetRequestPOIData:(NSString *)userID lon:(NSString *)lon lat:(NSString *)lat
{
     POIData *poi = nil;
    sqlite3 *database = [self openDatabase];
    if(database)
    {
       
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE LON='%@' AND LAT='%@' AND USER_ID='%@'", TABLE_POIDATA,lon,lat,userID];
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            
            while(sqlite3_step(stmt) == SQLITE_ROW)
            {
                poi = [self createMPOI:stmt];
            }
            //            NSLog(@"%@,%@",poi.mID ,poi.mName);
        }
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
    }
    sqlite3_close(database);
    return poi;
}

/*!
 @method createMPOI:
 @abstract 将查找到的数据封装到poi中
 @discussion 将查找到的数据封装到poi中
 @param stmt　查找到的某条数据
 @param poi　poi信息
 */
- (POIData*)createMPOI:(sqlite3_stmt*)stmt
{
    POIData *poi = [[[POIData alloc]init]autorelease];
    char *text;
    int index = 0;
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        poi.mKeyID = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        poi.mfID = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        poi.mID = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        poi.mName = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        poi.mCreateTime = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        poi.mLon = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        poi.mLat = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        poi.mPhone = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        poi.mAddress = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        poi.mDesc = [NSString stringWithUTF8String:text];
    }
    poi.mFlag  = sqlite3_column_int(stmt, index++);
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        poi.mUserID = [NSString stringWithUTF8String:text];
    }
    poi.mLevel  = sqlite3_column_int(stmt, index++);
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        poi.mUserID = [NSString stringWithUTF8String:text];
    }
    
    //NSLog(@"----");
    //    NSLog(@"%@,%@",friend.mfID,friend.mfCarVin);

    return poi;
}

/*!
 @method loadMeetRequestPOIDataSyncNO:(NSString *)userID
 @abstract 获取未同步的列表
 @discussion 获取未同步的列表
 @param userID 所属用户id
 @result poilist poi列表
 */
- (NSMutableArray*)loadMeetRequestPOIDataSyncNO:(NSString *)userID
{
    NSMutableArray *array = [[[NSMutableArray alloc]initWithCapacity:0]autorelease];
    
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE FLAG!=%d AND USER_ID='%@' ORDER BY CREATE_TIME DESC",TABLE_POIDATA,COLLECT_SYNC_YES,userID];
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            POIData *poi;
            while(sqlite3_step(stmt) == SQLITE_ROW)
            {
                poi = [self createMPOI:stmt];
                [array addObject:poi];
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
 @method loadMeetRequestPOIDataSyncAdd:(NSString *)userID
 @abstract 获取添加未同步的列表
 @discussion 获取添加未同步的列表
 @param userID 所属用户id
 @result poilist poi列表
 */
- (NSMutableArray*)loadMeetRequestPOIDataSyncAdd:(NSString *)userID
{
    NSMutableArray *array = [[[NSMutableArray alloc]initWithCapacity:0]autorelease];
    
    sqlite3 *database = [self openDatabase];
    if(database)
    {
//        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE FLAG =%d AND USER_ID='%@' ORDER BY CREATE_TIME DESC",TABLE_POIDATA,COLLECT_NO_ADD,userID];
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE FLAG =%d AND USER_ID='%@' ORDER BY CREATE_TIME DESC",TABLE_POIDATA,COLLECT_SYNC_NO_ADD,userID];
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            POIData *poi;
            while(sqlite3_step(stmt) == SQLITE_ROW)
            {
                poi = [self createMPOI:stmt];
                [array addObject:poi];
            }
            //            NSLog(@"%@,%@",poi.mID ,poi.mName);
        }
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
    }
    sqlite3_close(database);
    return array;
}
@end