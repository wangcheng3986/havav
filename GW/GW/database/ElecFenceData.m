/*!
 @header ElecFenceData.m
 @abstract 电子围栏数据操作
 @author wangqiwei
 @version 1.00 2014/9/1 Create
 */

#import "ElecFenceData.h"
#import "UserData.h"

@implementation ElecFenceData

#pragma mark - dataBasePackage
//添加
- (BOOL)addElecFenceWithKeyid:(NSString*)KeyID
                           ID:(NSString*)elecFenceId
                         name:(NSString*)name
                   lastUpdate:(NSString*)lastUpdate
                        valid:(NSString*)valid
                          lon:(double)lon
                          lat:(double)lat
                       radius:(int)radius
                  description:(NSString*)description
                      address:(NSString*)address
                          vin:(NSString*)vin
                    userKeyID:(NSString*)userKeyID;
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        [self addElecFenceWithDB:database keyid:KeyID ID:elecFenceId name:name lastUpdate:lastUpdate valid:valid lon:lon lat:lat radius:radius description:description address:address vin:vin userKeyID:userKeyID];
        
        sqlite3_close(database);
       return YES;
    }
    else
    {
        return NO;
    }
}
//更新本地电子围栏为无效
- (BOOL)updateElecFenceWithValid:(NSString*)valid
                            vin:(NSString*)vin
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        int result = [self updateElecFenceWithDB:database valid:valid vin:vin];
        BOOL res;
        if (result == updateSuccess)
        {
            res = YES;
        } else {
            res = NO;
        }
        sqlite3_close(database);
        return res;
    }
    else
    {
        return NO;
    }
}

//更新
- (BOOL)updateElecFenceWithID:(NSString*)elecFenceId
                           name:(NSString*)name
                     lastUpdate:(NSString*)lastUpdate
                          valid:(NSString*)valid
                            lon:(double)lon
                            lat:(double)lat
                         radius:(int)radius
                    description:(NSString*)description
                        address:(NSString*)address
                            vin:(NSString*)vin
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        int result = [self updateElecFenceWithDB:database ID:elecFenceId name:name lastUpdate:lastUpdate valid:valid lon:lon lat:lat radius:radius description:description address:address vin:vin];
        BOOL res;
        if (result == updateSuccess)
        {
            res = YES;
        } else {
            res = NO;
        }
        sqlite3_close(database);
        return res;
    }
    else
    {
        return NO;
    }
}

//查询
- (NSMutableArray*)selectWithVin:(NSString*)vin
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
       NSMutableArray *dic = [self selectWithDB:database vin:vin];
        if (nil != dic)
        {
            sqlite3_close(database);
            return dic;
        }
        else
        {
            sqlite3_close(database);
            return nil;
        }
        

    }
    else
    {
        return nil;
    }
    
}

- (NSMutableArray*)selectWithvin:(NSString*)vin
                     elecFenceId:(NSString*)elecFenceId
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        NSMutableArray *dic = [self selectWithDB:database vin:vin elecFenceId:elecFenceId];
        if (nil != dic)
        {
            sqlite3_close(database);
            return dic;
        }
        else
        {
            sqlite3_close(database);
            return nil;
        }
        
        
    }
    else
    {
        return nil;
    }
}
//删除单项
- (BOOL)removeWithDBID:(NSString *)elecFenceId
                   vin:(NSString*)vin
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
      int result = [self removeWithDB:database ID:elecFenceId vin:vin];
        BOOL res;
        if (result == updateSuccess)
        {
            res = YES;
        } else {
            res = NO;
        }
        
        sqlite3_close(database);
        return  res;
    }
    else
    {
        return NO;
    }
}
//删除所有
- (BOOL)removeWithAllDBVin:(NSString*)vin
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        int result = [self removeWithAllDB:database vin:vin];
        BOOL res;
        if (result == updateSuccess)
        {
            res = YES;
        } else {
            res = NO;
        }
        
        sqlite3_close(database);
        return  res;
        
    }
    else
    {
        return NO;
    }
}

#pragma mark - baseControl
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
    
    NSLog(@" ELECFENCE+++++ open database  path=%@",databaseFilePath);
    sqlite3 *database;
    int result = sqlite3_open([databaseFilePath UTF8String], &database);
    if(result == SQLITE_OK)
    {
        return database;
    }
    else
    {
        sqlite3_close(database);
        return nil;
    }
}
//初始化
- (BOOL)initElecFenceDatabase
{
    char *error;
    sqlite3 *database = [self openDatabase];
    if (database)
    {
        NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(KEYID TEXT, ID TEXT,NAME TEXT,LAST_UPDATE TEXT,VALID TEXT,LON DOUBLE,LAT DOUBLE,RADIUS INTEGER,DESCRIPTION TEXT,ADDRESS TEXT,VIN TEXT,USER_KEYID TEXT)", TABLE_ELECFENCE_DB];
        NSLog(@"ElecFenceData ===========WQW======> %@",sql);
        int result =  sqlite3_exec(database, [sql UTF8String], nil, nil, &error);
        if (result != SQLITE_OK)
        {
            NSLog(@"创建数据库表“TABLE_ELECFENCE_DB”失败 %s",error);
            sqlite3_close(database);
            return NO;
        } else {
             sqlite3_close(database);
            return YES;
        }
        
    }
    else
    {
        NSLog(@"数据库打开失败");
        return NO;
    }
}
//查询行数





//查询
- (NSMutableArray*)selectWithDB:(sqlite3*)database
                            vin:(NSString*)vin
{
    NSMutableArray *array = [[[NSMutableArray alloc]initWithCapacity:0]autorelease];
    if (database)
    {
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE VIN='%@'",TABLE_ELECFENCE_DB,vin];
   // NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ ",TABLE_ELECFENCE_DB];
        // NSString *sql = [NSString stringWithFormat:@"SELECT * FROM FRIEND"];
        sqlite3_stmt *stmt;

        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            
            while(sqlite3_step(stmt) == SQLITE_ROW)
            {
                ElecFenceData *EFData;
                EFData = [self createElecFenceObject:stmt];
                [array addObject:EFData];
                
            }
            
        }
        
        sqlite3_finalize(stmt);
        return array;
    }
    else
    {
        return nil;
    }
    
}

- (NSMutableArray*)selectWithDB:(sqlite3*)database
                            vin:(NSString*)vin
                    elecFenceId:(NSString*)elecFenceId
{
    NSMutableArray *array = [[[NSMutableArray alloc]initWithCapacity:0]autorelease];
    if (database)
    {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE VIN='%@' AND ID = '%@'",TABLE_ELECFENCE_DB,vin,elecFenceId];
        // NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ ",TABLE_ELECFENCE_DB];
        // NSString *sql = [NSString stringWithFormat:@"SELECT * FROM FRIEND"];
        sqlite3_stmt *stmt;
        
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            
            while(sqlite3_step(stmt) == SQLITE_ROW)
            {
                ElecFenceData *EFData;
                EFData = [self createElecFenceObject:stmt];
                [array addObject:EFData];
                
            }
            
        }
        
        sqlite3_finalize(stmt);
        return array;
    }
    else
    {
        return nil;
    }
    
}

//数据封装
- (ElecFenceData*)createElecFenceObject:(sqlite3_stmt*)stmt
{
    int index = 0;
    char *text;
    double dValue;
    ElecFenceData *EFData = [[[ElecFenceData alloc]init]autorelease];
    //KEYID
    text = (char*)sqlite3_column_text(stmt, index++);
    if (text) {
        EFData.keyID = [NSString stringWithUTF8String:text];
    }
    //ID
    text = (char*)sqlite3_column_text(stmt, index++);
    if (text) {
        EFData.elecFenceId = [NSString stringWithUTF8String:text];
    }
    //NAME
    text = (char*)sqlite3_column_text(stmt, index++);
    if (text) {
        EFData.name = [NSString stringWithUTF8String:text];
    }
    //LAST_UPDATE
    text = (char*)sqlite3_column_text(stmt, index++);
    if (text) {
        EFData.lastUpdate = [NSString stringWithUTF8String:text];
    }
    //VALID
    text = (char*)sqlite3_column_text(stmt, index++);
    if (text) {
        EFData.valid = [NSString stringWithUTF8String:text];
    }
    //LON
    dValue = sqlite3_column_double(stmt, index++);
    if (dValue) {
        EFData.lon = dValue;
    }
    //LAT
    dValue = sqlite3_column_double(stmt, index++);
    if (text) {
        EFData.lat = dValue;
    }
    //RADIUS
    int radius = sqlite3_column_int(stmt, index++);
    if (radius) {
        EFData.radius = radius;
    }
    //DESCRIPTION
    text = (char*)sqlite3_column_text(stmt, index++);
    if (text) {
        EFData.descriptionText = [NSString stringWithUTF8String:text];
    }
    //ADDRESS
    text = (char*)sqlite3_column_text(stmt, index++);
    if (text) {
        EFData.address = [NSString stringWithUTF8String:text];
    }
    //VIN
    text = (char*)sqlite3_column_text(stmt, index++);
    if (text) {
        EFData.vin = [NSString stringWithUTF8String:text];
    }
    //userKeyID
    text = (char*)sqlite3_column_text(stmt, index++);
    if (text) {
        EFData.userKeyID = [NSString stringWithUTF8String:text];
    }
    
    
    return EFData;
}

//添加
- (BOOL)addElecFenceWithDB:(sqlite3*)database
                     keyid:(NSString*)KeyID
                        ID:(NSString*)elecFenceId
                      name:(NSString*)name
                lastUpdate:(NSString*)lastUpdate
                     valid:(NSString*)valid
                       lon:(double)lon
                       lat:(double)lat
                    radius:(int)radius
               description:(NSString*)description
                   address:(NSString*)address
                       vin:(NSString*)vin
                 userKeyID:(NSString*)userKeyID
{
    
            //KEYID TEXT, ID TEXT,NAME TEXT,MOBILE TEXT,LAST_UPDATE TEXT,CREATE_TIME TEXT,USER_KEYID TEXT
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ (KEYID,ID,NAME,LAST_UPDATE,VALID,LON,LAT,RADIUS,DESCRIPTION,ADDRESS,VIN,USER_KEYID) VALUES('%@','%@','%@','%@','%@','%f','%f','%d','%@','%@','%@','%@')",TABLE_ELECFENCE_DB,KeyID,elecFenceId,name,lastUpdate,valid,lon,lat,radius,description,address,vin,userKeyID];
        NSLog(@"%@",sql);
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            int result = sqlite3_step(stmt);
            if(result != SQLITE_DONE)
            {
                NSLog(@"add BLACK error.");
                NSLog(@"stmt is = %d",result);
                sqlite3_finalize(stmt);
                return NO;
            }
            sqlite3_finalize(stmt);
            return YES;
        }
        else
        {
            NSLog(@"stmt is = %d",sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil));
            sqlite3_finalize(stmt);
            return NO;
        }
    
}



//删除所有
- (BOOL)removeWithAllDB:(sqlite3*)database
                    vin:(NSString*)vin
{

    
        NSString *sql =[NSString stringWithFormat:@"DELETE FROM %@ WHERE VIN = '%@'",TABLE_ELECFENCE_DB,vin];
        NSLog(@"%@",sql);
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            if(sqlite3_step(stmt) != SQLITE_DONE)
            {
                sqlite3_finalize(stmt);
                NSLog(@"DEL  error.");
                return NO;
            }
            sqlite3_finalize(stmt);
            return YES;
        }
        else
        {
            NSLog(@"sqlite3_prepare error");
            return NO;
        }
    
}
//删除单项
- (int)removeWithDB:(sqlite3*)database
                  ID:(NSString *)elecFenceId
                 vin:(NSString*)vin
{
    sqlite3_stmt *stmt = NULL;
    if ([self selectElecFenceIsExist:database ID:elecFenceId])
    {
        NSString *sql =[NSString stringWithFormat:@"DELETE FROM %@ WHERE ID = '%@' AND VIN = '%@' ",TABLE_ELECFENCE_DB,elecFenceId,vin];
        NSLog(@"%@",sql);
        
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            if(sqlite3_step(stmt) != SQLITE_DONE)
            {
                NSLog(@"DEL  error.");
                sqlite3_finalize(stmt);
                return removeFailure;
            }
            else
            {
                return removeSuccess;
            }
            
            
            
        }
        else
        {
            NSLog(@"sqlite3_prepare error");
            return removeFailure;
        }
        
        
    }
    else
    {
        NSLog(@"要删除的数据不存在");
        sqlite3_finalize(stmt);
        return removeDataNotExist;
    }
}
//根据电子围栏ID查询电子围栏是否存在
- (BOOL)selectElecFenceIsExist:(sqlite3*)database
                            ID:(NSString *)elecFenceId
{
    sqlite3_stmt *stmt = nil;
    NSString *sql = [NSString stringWithFormat:@"SELECT count(*) FROM %@ WHERE ID = '%@'",TABLE_ELECFENCE_DB,elecFenceId];
    NSLog(@"SELECT===WQW===> %@",sql);
    if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
    {
        if (sqlite3_step(stmt) == SQLITE_ROW)
        {
            sqlite3_finalize(stmt);
            return YES;
        }
        else
        {
            return NO;
        }
    }
    
    sqlite3_finalize(stmt);
    return NO;
    
}
//更新本地电子围栏为无效
- (BOOL)updateElecFenceWithDB:(sqlite3*)database
                       valid:(NSString*)valid
                         vin:(NSString*)vin
{
    sqlite3_stmt *stmt = NULL;
    NSString *sql =[NSString stringWithFormat:@"UPDATE %@ SET VALID = '%@' WHERE VIN = '%@'",TABLE_ELECFENCE_DB,valid,vin];
    int result = sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil);
    if (result == SQLITE_OK)
    {
        NSLog(@"prepare_v2 update ElecFence success.");
        if(sqlite3_step(stmt) != SQLITE_DONE)
        {
            NSLog(@"update ElecFence error.");
            sqlite3_finalize(stmt);
            return  updateFailure;
        }
        else
        {
            NSLog(@"update ElecFence success.");
            sqlite3_finalize(stmt);
            return updateSuccess;
        }
        
    }
    else
    {
        NSLog(@"prepare_v2 update ElecFence failure.");
        sqlite3_finalize(stmt);
        return updateFailure;
    }

    
}
//更新
- (int)updateElecFenceWithDB:(sqlite3*)database
                          ID:(NSString*)elecFenceId
                        name:(NSString*)name
                  lastUpdate:(NSString*)lastUpdate
                       valid:(NSString*)valid
                         lon:(double)lon
                         lat:(double)lat
                      radius:(int)radius
                 description:(NSString*)description
                     address:(NSString*)address
                         vin:(NSString*)vin
{
    sqlite3_stmt *stmt = NULL;
    if ([self selectElecFenceIsExist:database ID:elecFenceId])
    {
        
        NSString *sql =[NSString stringWithFormat:@"UPDATE %@ SET NAME = '%@' ,LAST_UPDATE = '%@',VALID = '%@',LON = '%f',LAT = '%f',RADIUS = '%d',DESCRIPTION = '%@',ADDRESS = '%@' WHERE VIN = '%@' AND ID = '%@'",TABLE_ELECFENCE_DB,name,lastUpdate,valid,lon,lat,radius,_descriptionText,address,vin,elecFenceId];
        
        int result = sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil);
        if (result == SQLITE_OK)
        {
            NSLog(@"prepare_v2 update ElecFence success.");
            if(sqlite3_step(stmt) != SQLITE_DONE)
            {
                NSLog(@"update ElecFence error.");
                sqlite3_finalize(stmt);
                return  updateFailure;
            }
            else
            {
                NSLog(@"update ElecFence success.");
                sqlite3_finalize(stmt);
                return updateSuccess;
            }
            
        }
        else
        {
            NSLog(@"prepare_v2 update ElecFence failure.");
            sqlite3_finalize(stmt);
            return updateFailure;
        }
    }
    else
    {
        NSLog(@"update ElecFence error.");
        sqlite3_finalize(stmt);
        return updateDataNotExist;
    }
    
}

- (void)dealloc
{
    [_elecFenceId release];
    [_name release];
    [_lastUpdate release];
    [_valid release];
 //   [_lon release];
 //   [_lat release];
  //  [_radius release];
    [_descriptionText release];
    [_address release];
    [super dealloc];
}
@end
