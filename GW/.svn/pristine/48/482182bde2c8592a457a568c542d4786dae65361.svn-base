
/*!
 @header SearchHistoryData.m
 @abstract 操作搜索历史表
 @author mengy
 @version 1.00 13-5-14 Creation
 */
#import <sqlite3.h>
#import "UserData.h"
#import "SearchHistoryData.h"
@interface SearchHistoryData(Private)

- (void)initDatabase;
- (sqlite3*)openDatabase;
@end
@implementation SearchHistoryData
@synthesize mCreateTime;
@synthesize mKeyID;
@synthesize mSearchName;
@synthesize mUserID;
@synthesize mUserData;
/*!
 @method initSearchHistoryDatabase
 @abstract 建表
 @discussion 建表
 @param 无
 @result 无
 */
- (void)initSearchHistoryDatabase
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        char *msg;
        NSString *sql;
        do
        {
            //create SearchHistroy table
            sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (KEYID TEXT PRIMARY KEY ,SEARCH_NAME TEXT ,CREATE_TIME TEXT ,USER_ID TEXT )", TABLE_SEARCH_HISTROY_DATA];
            if(sqlite3_exec(database, [sql UTF8String], NULL, NULL, &msg) != SQLITE_OK)
            {
                NSLog(@"create SearchHistroy table fail.");
                break;
            }
            
        }
        while (0);
        
        sqlite3_close(database);
    }
    
}

-(void)dealloc
{
    [mKeyID release];
    [mSearchName release];
    [mCreateTime release];
    [mUserID release];
    [mUserData release];
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
 @method addSearchHistory:(NSString *)keyID searchName:(NSString *)searchName createTime:(NSString *)createTime userID:(NSString *)userID
 @abstract 添加或修改搜索历史数据
 @discussion 添加或修改搜索历史数据
 @param keyID 搜索历史id
 @param searchName 搜索关键字
 @param createTime 创建时间
 @param userID 所属用户id
 @result 无
 */
- (void)addSearchHistory:(NSString *)keyID
              searchName:(NSString *)searchName
              createTime:(NSString *)createTime
                  userID:(NSString *)userID
{
    
    sqlite3 *database = [self openDatabase];
    
    if(database)
    {
        if ([self poiExist:database searchName:searchName userID:userID]==NO)
        {
            [self addSearchHistory:database
                             keyID:keyID
                        searchName:searchName
                        createTime:createTime
                            userID:userID
             ];
        }
        else
        {
            [self updateSearchHistory:database
                                keyID:keyID
                        searchName:searchName
                        createTime:createTime
                            userID:userID
             ];
        }
        
    }
    sqlite3_close(database);
}

/*!
 @method addSearchHistory:(sqlite3 *)database keyID:(NSString *)keyID searchName:(NSString *)searchName createTime:(NSString *)createTime userID:(NSString *)userID
 @abstract 添加搜索历史数据
 @discussion 添加搜索历史数据
 @param keyID 搜索历史id
 @param searchName 搜索关键字
 @param createTime 创建时间
 @param userID 所属用户id
 @result 无
 */
- (void)addSearchHistory:(sqlite3 *)database
                   keyID:(NSString *)keyID
              searchName:(NSString *)searchName
              createTime:(NSString *)createTime
                  userID:(NSString *)userID
{
    NSString *sql=[NSString stringWithFormat:@"INSERT INTO %@(KEYID,SEARCH_NAME,CREATE_TIME,USER_ID) VALUES('%@','%@','%@','%@')",TABLE_SEARCH_HISTROY_DATA,keyID,searchName,createTime,userID];
    sqlite3_stmt *stmt;
    if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
    {
        NSLog(@"add history ok.");
        if(sqlite3_step(stmt) != SQLITE_DONE)
        {
            NSLog(@"add history error.");
        }
    }
    sqlite3_reset(stmt);
    sqlite3_finalize(stmt);
}

/*!
 @method updateSearchHistory:(sqlite3 *)database keyID:(NSString *)keyID searchName:(NSString *)searchName createTime:(NSString *)createTime userID:(NSString *)userID
 @abstract 修改搜索历史数据
 @discussion 修改搜索历史数据
 @param keyID 搜索历史id
 @param searchName 搜索关键字
 @param createTime 创建时间
 @param userID 所属用户id
 @result 无
 */
- (void)updateSearchHistory:(sqlite3 *)database
                      keyID:(NSString *)keyID
                 searchName:(NSString *)searchName
                 createTime:(NSString *)createTime
                     userID:(NSString *)userID
{
    NSString *sql=[NSString stringWithFormat:@"UPDATE %@ SET CREATE_TIME='%@' WHERE SEARCH_NAME='%@'AND USER_ID='%@' ",TABLE_SEARCH_HISTROY_DATA,createTime,searchName,userID];
    sqlite3_stmt *stmt;
    if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
    {
        NSLog(@"update history ok.");
        if(sqlite3_step(stmt) != SQLITE_DONE)
        {
            NSLog(@"update history error.");
        }
    }
    sqlite3_reset(stmt);
    sqlite3_finalize(stmt);
}

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

/*!
 @method loadMeetRequestSearchHistory:(NSString *)userID
 @abstract 加载某用户下的搜索历史记录
 @discussion 加载某用户下的搜索历史记录
 @param userID 所属用户id
 @result searchHistoryList 搜索历史列表
 */
- (NSMutableArray*)loadMeetRequestSearchHistory:(NSString *)userID
{
    NSMutableArray *array = [[[NSMutableArray alloc]initWithCapacity:0]autorelease];
    
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE USER_ID='%@' ORDER BY CREATE_TIME DESC",TABLE_SEARCH_HISTROY_DATA,userID];
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            SearchHistoryData *searchHistory;
            while(sqlite3_step(stmt) == SQLITE_ROW)
            {
                searchHistory = [self createMSearchHistory:stmt];
                [array addObject:searchHistory];
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
 @method loadMeetRequestSearchHistoryWithText:(NSString *)userID searchText:(NSString *)searchText
 @abstract 加载某用户下符合某关键字的搜索历史记录
 @discussion 加载某用户下符合某关键字的搜索历史记录
 @param userID 所属用户id
 @param searchText 搜索关键字
 @result searchHistoryList 搜索历史列表
 */
- (NSMutableArray*)loadMeetRequestSearchHistoryWithText:(NSString *)userID searchText:(NSString *)searchText
{
    NSMutableArray *array = [[[NSMutableArray alloc]initWithCapacity:0]autorelease];
    NSString *str=@"%";
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE USER_ID='%@' AND SEARCH_NAME LIKE '%@%@%@' ORDER BY CREATE_TIME DESC",TABLE_SEARCH_HISTROY_DATA,userID,str,searchText,str];
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            SearchHistoryData *searchHistory;
            while(sqlite3_step(stmt) == SQLITE_ROW)
            {
                searchHistory = [self createMSearchHistory:stmt];
                [array addObject:searchHistory];
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
 @method createMSearchHistory:
 @abstract 将查找到的数据封装到searchHistoryData中
 @discussion 将查找到的数据封装到searchHistoryData中
 @param stmt　查找到的某条数据
 @param searchHistoryData　搜索历史
 */
- (SearchHistoryData*)createMSearchHistory:(sqlite3_stmt*)stmt
{
    SearchHistoryData *searchHistoryData = [[[SearchHistoryData alloc]init]autorelease];
    char *text;
    int index = 0;
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        searchHistoryData.mKeyID = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        searchHistoryData.mSearchName = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        searchHistoryData.mCreateTime = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        searchHistoryData.mUserID = [NSString stringWithUTF8String:text];
    }
       //NSLog(@"----");
    //    NSLog(@"%@,%@",friend.mfID,friend.mfCarVin);
    
    return searchHistoryData;
}

/*!
 @method poiExist:(NSString *)searchName userID:(NSString *)userID
 @abstract 根据关键字和用户id判断搜索历史是否存在
 @discussion 根据关键字和用户id判断搜索历史是否存在
 @param userID 所属用户id
 @param searchName 关键字
 @result BOOL
 */
- (BOOL)poiExist:(NSString *)searchName userID:(NSString *)userID
{
    BOOL exist=NO;
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        exist=[self poiExist:database
                  searchName:searchName
                      userID:userID];
        
    }
    sqlite3_close(database);
    //    NSLog(@"%c",exist);
    return exist;
}

/*!
 @method poiExist:(sqlite3*)database searchName:(NSString *)searchName userID:(NSString *)userID
 @abstract 根据关键字和用户id判断搜索历史是否存在
 @discussion 根据关键字和用户id判断搜索历史是否存在
 @param userID 所属用户id
 @param searchName 关键字
 @param database 数据库
 @result BOOL
 */
- (BOOL)poiExist:(sqlite3*)database searchName:(NSString *)searchName userID:(NSString *)userID
{
    int count = 0;
    NSString *sql = [NSString stringWithFormat:@"SELECT count(*) FROM %@ WHERE SEARCH_NAME='%@' AND USER_ID='%@'", TABLE_SEARCH_HISTROY_DATA,searchName,userID];
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


@end
