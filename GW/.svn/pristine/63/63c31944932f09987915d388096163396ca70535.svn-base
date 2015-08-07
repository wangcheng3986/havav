/*!
 @header BlackData.ｍ
 @abstract 操作BLACK表
 @author mengy
 @version 1.00 14-4-1 Creation
 */

#import <sqlite3.h>
#import "BlackData.h"
#import "UserData.h"
@interface BlackData(Private)

- (void)initDatabase;
- (sqlite3*)openDatabase;

@end
@implementation BlackData
@synthesize mCreateTime;
@synthesize mID;
@synthesize mKeyID;
@synthesize mLastUpdate;
@synthesize mMobile;
@synthesize mName;
@synthesize mUserKeyID;
@synthesize mPinyin;

/*!
 @method initBlackDatabase
 @abstract 建表
 @discussion 建表
 @param 无
 @result 无
 */
- (void)initBlackDatabase
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        char *msg;
        NSString *sql;
        do
        {
            sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(KEYID TEXT, ID TEXT,NAME TEXT,MOBILE TEXT,LAST_UPDATE TEXT,CREATE_TIME TEXT,USER_KEYID TEXT,PINYIN TEXT)", TABLE_BLACK_DATA];
            NSLog(@"%@",sql);
            if(sqlite3_exec(database, [sql UTF8String], NULL, NULL, &msg) != SQLITE_OK)
            {
                NSLog(@"create friend table fail.");
                break;
            }
            
        }
        while (0);
        
    }
    sqlite3_close(database);
}

/*!
 @method dealloc
 @abstract 释放内存
 @discussion 释放内存
 @param 无
 @result 无
 */
- (void)dealloc
{
    [mKeyID release];
    [mID release];
    [mName release];
    [mMobile release];
    [mLastUpdate release];
    [mCreateTime release];
    [mUserKeyID release];
    [mPinyin release];
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
 @method addBlackDataWithSqls：
 @abstract 根据ｓｑｌ语句向表中插入数据
 @discussion 根据ｓｑｌ语句向表中插入数据
 @param sql　ｓｑｌ语句数组
 @result 无
 */
- (void)addBlackDataWithSqls:(NSMutableArray *)sql
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        [self addBlackDataWithDB:database
                             sql:sql
         ];
        
    }
    sqlite3_close(database);
}

/*!
 @method addBlackDataWithDB：sql:
 @abstract 根据ｓｑｌ语句向表中插入数据
 @discussion 遍历ｓｑｌ数组插入数据
 @param sql　ｓｑｌ语句数组
 @param database　数据库
 @result 无
 */
- (void)addBlackDataWithDB:(sqlite3*)database
                       sql:(NSMutableArray *)sql
{
    for (int i = 0; i < sql.count; i ++)
    {
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [[sql objectAtIndex:i] UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            NSLog(@"add Black ok.");
            if(sqlite3_step(stmt) != SQLITE_DONE)
            {
                NSLog(@"add Black error.");
            }
        }
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
    }
    
}

/*!
 @method deleteBlackDataWithIDs：userKeyID：
 @abstract 根据ｉｄ数组删除表中多条数据
 @discussion 根据ｉｄ数组删除表中多条数据
 @param IDs　ｉｄ数组
 @param userKeyID　黑名单所属用户ｉｄ
 @result 无
 */
- (void)deleteBlackDataWithIDs:(NSArray *)IDs
                     userKeyID:(NSString *)userKeyID
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        [self deleteBlackDataWithDB:database
                                IDs:IDs
                          userKeyID:userKeyID];
    }
    sqlite3_close(database);
}

/*!
 @method deleteBlackDataWithDB：IDs:userKeyID:
 @abstract 根据ｉｄ数组删除表中多条数据
 @discussion 根据ｉｄ数组删除表中多条数据
 @param IDs　ｉｄ数组
 @param userKeyID　黑名单所属用户ｉｄ
 @param database　数据库
 @result 无
 */
- (void)deleteBlackDataWithDB:(sqlite3*)database
                          IDs:(NSArray *)IDs
                    userKeyID:(NSString *)userKeyID
{
    if ([self blackExist:database IDs:IDs userKeyID:userKeyID]==YES)
    {
        NSMutableString *sql = [[NSMutableString alloc] initWithFormat:@"DELETE FROM %@ WHERE USER_KEYID='%@' AND (",TABLE_BLACK_DATA,userKeyID];
        int i;
        for (i =0; i< ([IDs count]-1); i++) {
            NSString *ID = [IDs objectAtIndex:i];
            [sql appendFormat:@" ID='%@' OR",ID];
        }
        //此处确保最后一个条件后没有'OR'
        [sql appendFormat:@" ID='%@')",[IDs objectAtIndex:i]];
        
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            if(sqlite3_step(stmt) != SQLITE_DONE)
            {
                NSLog(@"DEL black error.");
            }
        }
        
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
        [sql release];
    }
    else
    {
        NSLog(@"DEL black error.");
    }
}

/*!
 @method deleteAllBlackDataWithUserKeyID：
 @abstract 删除某用户的所有黑名单
 @discussion 删除某用户的所有黑名单
 @param userKeyID　黑名单所属用户ｉｄ
 @result 无
 */
- (void)deleteAllBlackDataWithUserKeyID:(NSString *)userKeyID
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        [self deleteAllBlackDataWithDB:database
                             userKeyID:userKeyID];
    }
    sqlite3_close(database);
}

/*!
 @method deleteAllBlackDataWithDB：userKeyID:
 @abstract 删除某用户的所有黑名单
 @discussion 删除某用户的所有黑名单
 @param userKeyID　黑名单所属用户ｉｄ
 @param database　数据库
 @result 无
 */
- (void)deleteAllBlackDataWithDB:(sqlite3*)database
                       userKeyID:(NSString *)userKeyID

{
    if ([self blackExist:database userKeyID:userKeyID]==YES)
    {
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE USER_KEYID='%@'",TABLE_BLACK_DATA,userKeyID];
        
        NSLog(@"%@",sql);
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            NSLog(@"DEL all black ok.");
            if(sqlite3_step(stmt) != SQLITE_DONE)
            {
                NSLog(@"DEL all black error.");
            }
        }
        
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
        
    }
    else
    {
        NSLog(@"DEL all black error.");
    }
}


/*!
 @method blackExist:IDs:userKeyID:
 @abstract 根据ｉｄ，userKeyID判断黑名单是否在数据库表中存在
 @discussion 根据ｉｄ，userKeyID判断黑名单是否在数据库表中存在
 @param userKeyID　黑名单所属用户ｉｄ
 @param database　数据库
 @param IDs　黑名单ｉｄ数组
 @result BOOL
 */
- (BOOL)blackExist:(sqlite3*)database IDs:(NSArray *)IDs userKeyID:(NSString *)userKeyID
{
    int count = 0;
    NSMutableString *sql = [[NSMutableString alloc] initWithFormat:@"SELECT count(*) FROM %@ WHERE USER_KEYID='%@' AND (", TABLE_BLACK_DATA,userKeyID];
    int idnum = [IDs count];
    //使用for循环把条件加入
    int i;
    for (i =0; i< (idnum - 1); i++) {
        NSString *ID = [IDs objectAtIndex:i];
        [sql appendFormat:@" ID='%@' OR",ID];
    }
    //此处确保最后一个条件后没有'OR'
    [sql appendFormat:@" ID='%@')",[IDs objectAtIndex:i]];//for 中已经进行了加1
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
    [sql release];
    if (count == idnum) {
        return YES;
    }else
    {
        return NO;
    }
}

/*!
 @method blackExist:userKeyID:
 @abstract 根据userKeyID判断黑名单是否在数据库表中存在
 @discussion 根据userKeyID判断黑名单是否在数据库表中存在
 @param userKeyID　黑名单所属用户ｉｄ
 @param database　数据库
 @result BOOL
 */
- (BOOL)blackExist:(sqlite3*)database userKeyID:(NSString *)userKeyID
{
    int count = 0;
    NSString *sql = [NSString stringWithFormat:@"SELECT count(*) FROM %@ WHERE USER_KEYID='%@'", TABLE_BLACK_DATA,userKeyID];
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
 @method blackExist:userKeyID:ID:mobile:
 @abstract 根据ｉｄ，mobile，userKeyID判断黑名单是否在数据库表中存在
 @discussion 根据ｉｄ，mobile，userKeyID判断黑名单是否在数据库表中存在
 @param userKeyID　黑名单所属用户ｉｄ
 @param database　数据库
 @param ID　黑名单ｉｄ
 @param mobile　电话号码
 @result BOOL
 */
- (BOOL)blackExist:(sqlite3*)database userKeyID:(NSString *)userKeyID ID:(NSString *)ID mobile:(NSString *)mobile
{
    int count = 0;
    NSString *sql = [NSString stringWithFormat:@"SELECT count(*) FROM %@ WHERE USER_KEYID='%@' AND MOBILE='%@' AND ID='%@'", TABLE_BLACK_DATA,userKeyID,mobile,ID];
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
 @method updateBlackDataWithKeyID:(NSString*)KeyID　ID:(NSString*)ID　name:(NSString*)name mobile:(NSString *)mobile lastUpdate:(NSString *)lastUpdate
 createTime:(NSString *)createTime userKeyID:(NSString *)userKeyID pinyin:(NSString *)pinyin
 @abstract 更新或添加黑名单
 @discussion 更新或添加黑名单
 @param 黑名单属性
 @result 无
 */
- (void)updateBlackDataWithKeyID:(NSString*)KeyID
                              ID:(NSString*)ID
                            name:(NSString*)name
                          mobile:(NSString *)mobile
                      lastUpdate:(NSString *)lastUpdate
                      createTime:(NSString *)createTime
                       userKeyID:(NSString *)userKeyID
                          pinyin:(NSString *)pinyin

{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        [self updateBlackDataWithDB:database
                              KeyID:KeyID
                                 ID:ID
                               name:name
                             mobile:mobile
                         lastUpdate:lastUpdate
                         createTime:createTime
                          userKeyID:userKeyID
                             pinyin:pinyin
         ];
        
    }
    sqlite3_close(database);
}

/*!
 @method updateBlackDataWithDB：(sqlite3*)database　KeyID:(NSString*)KeyID　ID:(NSString*)ID　name:(NSString*)name mobile:(NSString *)mobile lastUpdate:(NSString *)lastUpdate
 createTime:(NSString *)createTime userKeyID:(NSString *)userKeyID
 @abstract 更新或添加黑名单
 @discussion 更新或添加黑名单
 @param 黑名单属性
 @result 无
 */
- (void)updateBlackDataWithDB:(sqlite3*)database
                        KeyID:(NSString*)KeyID
                           ID:(NSString*)ID
                         name:(NSString*)name
                       mobile:(NSString *)mobile
                   lastUpdate:(NSString *)lastUpdate
                   createTime:(NSString *)createTime
                    userKeyID:(NSString *)userKeyID
                       pinyin:(NSString *)pinyin
{
    
    if ([self blackExist:database userKeyID:userKeyID ID:ID mobile:mobile]==YES) {
        
        //KEYID TEXT, ID TEXT,NAME TEXT,MOBILE TEXT,LAST_UPDATE TEXT,CREATE_TIME TEXT,USER_KEYID TEXT
        NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET LAST_UPDATE='%@' WHERE ID='%@' AND USER_KEYID='%@'",TABLE_BLACK_DATA,lastUpdate,ID,userKeyID];
        NSLog(@"%@",sql);
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            NSLog(@"update BLACK ok.");
            if(sqlite3_step(stmt) != SQLITE_DONE)
            {
                NSLog(@"update BLACK error.");
            }
        }
        
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
        
    }
    else
    {
        //KEYID TEXT, ID TEXT,NAME TEXT,MOBILE TEXT,LAST_UPDATE TEXT,CREATE_TIME TEXT,USER_KEYID TEXT
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ (KEYID,ID,NAME,MOBILE,LAST_UPDATE,CREATE_TIME,USER_KEYID,PINYIN) VALUES('%@','%@','%@','%@','%@','%@','%@','%@')",TABLE_BLACK_DATA,KeyID,ID,name,mobile,lastUpdate,createTime,userKeyID,pinyin];
        NSLog(@"%@",sql);
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            int result = sqlite3_step(stmt);
            if(result != SQLITE_DONE)
            {
                NSLog(@"add BLACK error.");
                NSLog(@"stmt is = %d",result);
            }
        }
        else
        {
            NSLog(@"stmt is = %d",sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil));
        }
        
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
    }
}

/*!
 @method blackExist:mobile:
 @abstract 根据mobile，userKeyID判断黑名单是否在数据库表中存在
 @discussion 根据mobile，userKeyID判断黑名单是否在数据库表中存在
 @param userKeyID　黑名单所属用户ｉｄ
 @param database　数据库
 @param mobile　电话号码
 @result BOOL
 */
- (BOOL)blackExist:(NSString *)userKeyID mobile:(NSString *)mobile
{
    BOOL isExist = NO;
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        isExist = [self blackExist:database userKeyID:userKeyID mobile:mobile];
        
    }
    sqlite3_close(database);
    return isExist;
}

/*!
 @method blackExist:userKeyID:mobile:
 @abstract 根据mobile，userKeyID判断黑名单是否在数据库表中存在
 @discussion 根据mobile，userKeyID判断黑名单是否在数据库表中存在
 @param userKeyID　黑名单所属用户ｉｄ
 @param database　数据库
 @param mobile　电话号码
 @result BOOL
 */
- (BOOL)blackExist:(sqlite3*)database userKeyID:(NSString *)userKeyID mobile:(NSString *)mobile
{
    int count = 0;
    NSString *sql = [NSString stringWithFormat:@"SELECT count(*) FROM %@ WHERE USER_KEYID='%@' AND MOBILE='%@' ", TABLE_BLACK_DATA,userKeyID,mobile];
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
 @method deleteBlackDataWithMobile：userKeyID:
 @abstract 根据电话和userKeyID删除黑名单数据
 @discussion 根据电话和userKeyID删除黑名单数据
 @param mobile　电话
 @param userKeyID　所属用户ｉｄ
 @result 无
 */
- (void)deleteBlackDataWithMobile:(NSString*)mobile
                        userKeyID:(NSString *)userKeyID

{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        [self deleteBlackDataWithDB:database
                             mobile:mobile
                          userKeyID:userKeyID
         ];
        
    }
    sqlite3_close(database);
}

/*!
 @method deleteBlackDataWithDB：ｍobile：userKeyID:
 @abstract 根据电话和userKeyID删除黑名单数据
 @discussion 根据电话和userKeyID删除黑名单数据
 @param mobile　电话
 @param userKeyID　所属用户ｉｄ
 @result 无
 */
- (void)deleteBlackDataWithDB:(sqlite3*)database
                       mobile:(NSString*)mobile
                    userKeyID:(NSString *)userKeyID
{
    
    if ([self blackExist:database userKeyID:userKeyID mobile:mobile]==YES) {
        
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE MOBILE='%@'AND USER_KEYID='%@'",TABLE_BLACK_DATA,mobile,userKeyID];
        NSLog(@"%@",sql);
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            NSLog(@"DELETE BLACK ok.");
            if(sqlite3_step(stmt) != SQLITE_DONE)
            {
                NSLog(@"DELETE BLACK error.");
            }
        }
        
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
        
    }
}


/*!
 @method loadBlackDataWithUserKeyID:
 @abstract 加载某用户下黑名单数据
 @discussion 加载某用户下黑名单数据
 @param userKeyID　所属用户ｉｄ
 @result NSMutableArray　黑名单列表
 */
- (NSMutableArray*)loadBlackDataWithUserKeyID:(NSString *)userKeyID
{
    NSMutableArray *array = [[[NSMutableArray alloc]initWithCapacity:0]autorelease];
    
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE USER_KEYID='%@' ORDER BY PINYIN",TABLE_BLACK_DATA,userKeyID];
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            BlackData *black;
            while(sqlite3_step(stmt) == SQLITE_ROW)
            {
                black = [self createMBlack:stmt];
                [array addObject:black];
            }
        }
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
    }
    sqlite3_close(database);
    return array;
}
/*!
 @method createMBlack:
 @abstract 将查找到的数据封装到ｂｌａｃｋ中
 @discussion 将查找到的数据封装到ｂｌａｃｋ中
 @param stmt　查找到的某条数据
 @param black　黑名单
 */
- (BlackData*)createMBlack:(sqlite3_stmt*)stmt
{
    BlackData *black = [[[BlackData alloc]init]autorelease];
    
    char *text;
    int index = 0;
    
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        black.mKeyID = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        black.mID = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        black.mName = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        black.mMobile = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        black.mLastUpdate = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        black.mCreateTime = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        black.mUserKeyID = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        black.mPinyin = [NSString stringWithUTF8String:text];
    }
    return black;
}

@end