/*!
 @header FriendsData.m
 @abstract 操作车友表
 @author mengy
 @version 1.00 13-4-23 Creation
 */

#import <sqlite3.h>
#import "FriendsData.h"
#import "UserData.h"
/*!
 @class
 @abstract 操作FRIEND表。
 */
@interface FriendsData(Private)

- (void)initDatabase;
- (sqlite3*)openDatabase;

@end
@implementation FriendsData
@synthesize mfKeyID;
@synthesize mfID;
@synthesize mfName;
@synthesize mfPhone;
@synthesize mfUserID;
@synthesize mfLat;
@synthesize mfLon;
@synthesize mfLastRqTime;
@synthesize mfLastUpdate;
@synthesize mSendLocationRqTime;
@synthesize mCreateTime;
@synthesize mFriendUserID;
@synthesize mPoiAddress;
@synthesize mPoiName;
@synthesize mPinyin;
/*!
 @method initFriendDatabase
 @abstract 建表
 @discussion 建表
 @param 无
 @result 无
 */
- (void)initFriendDatabase
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        char *msg;
        NSString *sql;
        do
        {
            //表结构调整后，重新定义表名及字段名 孟磊 2013年9月18日
            //表结构调整后，重新定义表名及字段名 孟月 2014年4月14日
            //表结构调整，添加FRIEND_USER_ID 孟月 2014年7月30日
            sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(KEYID TEXT, ID TEXT,NAME TEXT,PHONE TEXT,USER_KEYID TEXT,LON TEXT,LAT TEXT,LAST_RQ_TIME TEXT,LAST_UPDATE TEXT,SEND_LOCATION_REQUEST_TIME TEXT,CREATE_TIME TEXT,FRIEND_USER_ID TEXT,POI_NAME TEXT,POI_ADDRESS TEXT,PINYIN TEXT)", TABLE_FRIENDS_DATA];
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

- (void)dealloc
{
    [mSendLocationRqTime release];
    [mfKeyID release];
    [mfID release];
    [mfName release];
    [mfPhone release];

    [mfUserID release];
    [mfLon release];
    [mfLat release];
    [mfLastRqTime release];

    [mfLastUpdate release];
    [mCreateTime release];
    [mFriendUserID release];
    [mPoiName release];
    [mPoiAddress release];
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
 @method updateFriendData：
 @abstract 添加或修改车友表数据
 @discussion 添加或修改车友表数据
 @param 车友数据
 @result 无
 */
- (void)updateFriendData:(NSString*)fKeyID
                     fid:(NSString *)fID
                   fname:(NSString*)fName
                  fphone:(NSString*)fPhone
            fUserID:(NSString *)fUserID
                    flon:(NSString *)flon
                    flat:(NSString *)flat
             fLastRqTime:(NSString *)fLastRqTime
             fLastUpdate:(NSString*)fLastUpdate
      sendLocationRqTime:(NSString*)sendLocationRqTime
              createTime:(NSString *)createTime
            friendUserID:(NSString *)friendUserID
                 poiName:(NSString *)poiName
              poiAddress:(NSString *)poiAddress
                  pinyin:(NSString *)pinyin
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        [self updateFriendData:database
                        fkeyid:fKeyID
                           fid:fID
                         fname:fName
                        fphone:fPhone
                  fUserID:fUserID
                          flon:flon
                          flat:flat
                   fLastRqTime:fLastRqTime
                   fLastUpdate:fLastUpdate
            sendLocationRqTime:sendLocationRqTime
                    createTime:createTime
                  friendUserID:friendUserID
                       poiName:poiName
                    poiAddress:poiAddress
                        pinyin:pinyin
         ];
        
    }
    sqlite3_close(database);
}

- (void)updateFriendData:(sqlite3*)database
                  fkeyid:(NSString*)fKeyID
                     fid:(NSString *)fID
                   fname:(NSString*)fName
                  fphone:(NSString*)fPhone
            fUserID:(NSString *)fUserID
                    flon:(NSString *)flon
                    flat:(NSString *)flat
             fLastRqTime:(NSString *)fLastRqTime
             fLastUpdate:(NSString*)fLastUpdate
      sendLocationRqTime:(NSString*)sendLocationRqTime
              createTime:(NSString *)createTime
            friendUserID:(NSString *)friendUserID
                 poiName:(NSString *)poiName
              poiAddress:(NSString *)poiAddress
                  pinyin:(NSString *)pinyin
{
    
    if ([self friendExist:database fid:fID fUserID:fUserID]==YES) {
        NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET NAME='%@',PHONE='%@',LON='%@',LAT='%@',LAST_RQ_TIME='%@',LAST_UPDATE='%@',SEND_LOCATION_REQUEST_TIME='%@',CREATE_TIME='%@', FRIEND_USER_ID='%@',POI_NAME='%@',POI_ADDRESS='%@',PINYIN='%@' WHERE ID='%@' AND USER_KEYID='%@'",TABLE_FRIENDS_DATA,fName,fPhone,flon,flat,fLastRqTime,fLastUpdate,sendLocationRqTime,createTime,friendUserID,poiName,poiAddress,pinyin,fID,fUserID];
        NSLog(@"%@",sql);
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            int index = 1;
            sqlite3_bind_text(stmt, index++, [fID UTF8String], -1, NULL);
            //        sqlite3_bind_int(stmt, index++, mSelectedCar);
            NSLog(@"update friend ok.");
            if(sqlite3_step(stmt) != SQLITE_DONE)
            {
                NSLog(@"update friend error.");
            }
        }
        
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
        
    }
    else
    {       
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ (KEYID,ID,NAME,PHONE,USER_KEYID,LON,LAT,LAST_RQ_TIME,LAST_UPDATE,SEND_LOCATION_REQUEST_TIME,CREATE_TIME,FRIEND_USER_ID,POI_NAME,POI_ADDRESS,PINYIN) VALUES('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",
                         TABLE_FRIENDS_DATA,
                         fKeyID,
                         fID,
                         fName,
                         fPhone,
                         fUserID,
                         flon,
                         flat,
                         fLastRqTime,
                         fLastUpdate,
                         sendLocationRqTime,
                         createTime,
                         friendUserID,
                         poiName,
                         poiAddress,
                         pinyin];
        NSLog(@"%@",sql);
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            int result = sqlite3_step(stmt);
            if(result != SQLITE_DONE)
            {
                NSLog(@"add friend error.");
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
 @method deleteFriendWithPhone：fUserID:
 @abstract 根据电话和所属用户进行删除
 @discussion 根据电话和所属用户进行删除
 @param phone 电话
 @param fUserID 所属用户id
 @result 无
 */
- (void)deleteFriendWithPhone:(NSString *)phone fUserID:(NSString *)fUserID
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        [self deleteFriendWithDB:database phone:phone fUserID:fUserID
         ];
        
    }
    sqlite3_close(database);
}

- (void)deleteFriendWithDB:(sqlite3*)database phone:(NSString *)phone fUserID:(NSString *)fUserID
{
    if ([self friendExist:database phone:phone fUserID:fUserID]==YES) {
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE PHONE ='%@'AND USER_KEYID='%@'",TABLE_FRIENDS_DATA,phone,fUserID];
        NSLog(@"%@",sql);
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            if(sqlite3_step(stmt) != SQLITE_DONE)
            {
                NSLog(@"DEL friend error.");
            }
        }
        
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
    }
}

/*!
 @method addFriendDataWithSqls:
 @abstract 通过sqlList添加车友
 @discussion 通过sqlList添加车友
 @param sql sql语句数组
 @result 无
 */
- (void)addFriendDataWithSqls:(NSMutableArray *)sql
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        [self addFriendDataWithSqls:database
                             sql:sql
         ];
        
    }
    sqlite3_close(database);
}

- (void)addFriendDataWithSqls:(sqlite3*)database
                       sql:(NSMutableArray *)sql
{
    for (int i = 0; i < sql.count; i ++)
    {
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [[sql objectAtIndex:i] UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            NSLog(@"add friend ok.");
            if(sqlite3_step(stmt) != SQLITE_DONE)
            {
                NSLog(@"add friend error.");
            }
        }
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
    }
    
}



/*!
 @method updateFriendRqTimeWithFID: rqTime: fUserID:
 @abstract 根据车友id和所属用户id修改位置请求时间
 @discussion 根据车友id和所属用户id修改位置请求时间
 @param fID 车友id
 @param fUserID 所属用户id
 @param rqTime 最后请求时间
 @result 无
 */
- (void)updateFriendRqTimeWithFID:(NSString *)fID
                           rqTime:(NSString *)rqTime
                     fUserID:(NSString *)fUserID
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        [self updateFriendRqTimeWithDB:database
                                   fid:fID
                                rqTime:rqTime
                          fUserID:fUserID];
    }
    sqlite3_close(database);
}

- (void)updateFriendRqTimeWithDB:(sqlite3*)database
                             fid:(NSString *)fID
                          rqTime:(NSString *)rqTime
                    fUserID:(NSString *)fUserID

{
    if ([self friendExist:database fid:fID fUserID:fUserID]==YES)
    {
        //(KEYID,ID,NAME,PHONE,SEX,ADDRESS,ISBLACKLIST,USER_KEYID,LON,LAT,LAST_RQ_TIME,TFTYPE,LAST_UPDATE)
        NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET SEND_LOCATION_REQUEST_TIME='%@' WHERE ID='%@'AND USER_KEYID='%@'",TABLE_FRIENDS_DATA,rqTime,fID,fUserID];
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            NSLog(@"update SEND_LOCATION_REQUEST_TIME ok.");
            if(sqlite3_step(stmt) != SQLITE_DONE)
            {
                NSLog(@"update SEND_LOCATION_REQUEST_TIME error.");
            }
        }
        
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
        
    }
    else
    {
        NSLog(@"update SEND_LOCATION_REQUEST_TIME error.");
    }
}

/*!
 @method getFriendName: fUserID:
 @abstract 根据车友id和所属用户id获取车友名字
 @discussion 根据车友id和所属用户id获取车友名字
 @param fID 车友id
 @param fUserID 所属用户id
 @result name
 */
- (NSString *)getFriendName:(NSString *)fID
               fUserID:(NSString *)fUserID
{
    FriendsData *friend = [[[FriendsData alloc] init] autorelease];
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        //(KEYID,ID,NAME,PHONE,SEX,ADDRESS,ISBLACKLIST,USER_KEYID,LON,LAT,LAST_RQ_TIME,TFTYPE,LAST_UPDATE)
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE USER_KEYID='%@'AND ID='%@'"
                         ,TABLE_FRIENDS_DATA,fUserID,fID];
        NSLog(@"%@",sql);
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {

            while(sqlite3_step(stmt) == SQLITE_ROW)
            {
                friend = [self createMFriend:stmt];

            }
        }
        sqlite3_finalize(stmt);
        sqlite3_finalize(stmt);
    }
    sqlite3_close(database);
    return friend.mfName;

}

/*!
 @method getFriendNameWithPhone: fUserID:
 @abstract 根据车友phone和所属用户id获取车友名字
 @discussion 根据车友phone和所属用户id获取车友名字
 @param phone 车友电话
 @param fUserID 所属用户id
 @result name
 */
- (NSString *)getFriendNameWithPhone:(NSString *)phone
                        fUserID:(NSString *)fUserID
{
    FriendsData *friend = [[[FriendsData alloc] init] autorelease];
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE USER_KEYID='%@'AND PHONE='%@'"
                         ,TABLE_FRIENDS_DATA,fUserID,phone];
        NSLog(@"%@",sql);
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            
            while(sqlite3_step(stmt) == SQLITE_ROW)
            {
                friend = [self createMFriend:stmt];
                
            }
        }
        sqlite3_finalize(stmt);
        sqlite3_finalize(stmt);
    }
    sqlite3_close(database);
    return friend.mfName;
}

/*!
 @method getRqTimeWithFID:  fUserID:
 @abstract 根据车友id和所属用户id获取上次位置请求时间
 @discussion 根据车友id和所属用户id获取上次位置请求时间
 @param fID 车友id
 @param fUserID 所属用户id
 @result time
 */
- (NSString *)getRqTimeWithFID:(NSString *)fID
                  fUserID:(NSString *)fUserID
{
//    FriendsData *friend = [[[FriendsData alloc] init] autorelease];
    NSString *sendRqTime = nil;
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        //(KEYID,ID,NAME,PHONE,SEX,ADDRESS,ISBLACKLIST,USER_KEYID,LON,LAT,LAST_RQ_TIME,TFTYPE,LAST_UPDATE)
        NSString *sql = [NSString stringWithFormat:@"SELECT SEND_LOCATION_REQUEST_TIME FROM %@ WHERE USER_KEYID='%@'AND ID='%@'"
                         ,TABLE_FRIENDS_DATA,fUserID,fID];
        NSLog(@"%@",sql);
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            
            while(sqlite3_step(stmt) == SQLITE_ROW)
            {
//                friend = [self createMFriend:stmt];
                char *text = (char*)sqlite3_column_text(stmt, 0);
                if(text)
                {
                    sendRqTime = [NSString stringWithUTF8String:text];
                }
                
            }
        }
        sqlite3_finalize(stmt);
        sqlite3_finalize(stmt);
    }
    sqlite3_close(database);
    NSLog(@"%@",sendRqTime);
    return sendRqTime;
    
}

/*!
 @method updateFriendLocation:  flon: flat: fUserID: lastRqTime:
 @abstract 根据车友id和所属用户id更新车友最后位置信息
 @discussion 根据车友id和所属用户id更新车友最后位置信息
 @param fID 车友id
 @param fUserID 所属用户id
 @param flon 经度
 @param flat 纬度
 @param lastRqTime 最后更新时间
 @result 无
 */
- (void)updateFriendLocation:(NSString *)fID
                        flon:(NSString *)flon
                        flat:(NSString *)flat
                fUserID:(NSString *)fUserID
                  lastRqTime:(NSString *)lastRqTime
                     poiName:(NSString *)poiName
                  poiAddress:(NSString *)poiAddress
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        [self updateFriendLocation:database
                              fID:fID
                              flon:flon
                              flat:flat
                      fUserID:fUserID
                        lastRqTime:lastRqTime
                           poiName:poiName
                        poiAddress:poiAddress];
    }
    sqlite3_close(database);
}

- (void)updateFriendLocation:(sqlite3*)database
                         fID:(NSString *)fID
                        flon:(NSString *)flon
                        flat:(NSString *)flat
                fUserID:(NSString *)fUserID
                  lastRqTime:(NSString *)lastRqTime
                     poiName:(NSString *)poiName
                  poiAddress:(NSString *)poiAddress

{
    if ([self friendExist:database fid:fID fUserID:fUserID]==YES)
    {
        //(KEYID,ID,NAME,PHONE,SEX,ADDRESS,ISBLACKLIST,USER_KEYID,LON,LAT,LAST_RQ_TIME,TFTYPE,LAST_UPDATE)
        NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET LON=%@,LAT=%@,LAST_RQ_TIME=%@,POI_NAME = '%@',POI_ADDRESS = '%@' WHERE USER_KEYID='%@'AND ID='%@'",TABLE_FRIENDS_DATA,flon,flat,lastRqTime,poiName,poiAddress,fUserID,fID];

        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
//            int index = 1;
//            sqlite3_bind_text(stmt, index++, [fphone UTF8String], -1, NULL);
            //        sqlite3_bind_int(stmt, index++, mSelectedCar);
            NSLog(@"update FriendLocation ok.");
            if(sqlite3_step(stmt) != SQLITE_DONE)
            {
                NSLog(@"update FriendLocation error.");
            }
        }
        
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
        
    }
    else
    {
        NSLog(@"update FriendLocation error.");
    }
}


/*!
 @method updateFriendDataWithID:(NSString *)fID
 mobile:(NSString *)mobile
 name:(NSString *)name
 createTime:(NSString *)createTime
 lastUpdate:(NSString *)lastUpdate
 fUserID:(NSString *)fUserID
 pinyin:(NSString *)pinyin
 @abstract 更新车友信息
 @discussion 更新车友信息
 @param 车友信息
 @result 无
 */
- (void)updateFriendDataWithID:(NSString *)fID
                        mobile:(NSString *)mobile
                          name:(NSString *)name
                    createTime:(NSString *)createTime
                    lastUpdate:(NSString *)lastUpdate
                       fUserID:(NSString *)fUserID
                       pinyin:(NSString *)pinyin
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        [self updateFriendDataWithDB:database
                                  ID:fID
                              mobile:mobile
                                name:name
                          createTime:createTime
                          lastUpdate:lastUpdate
                             fUserID:fUserID
                              pinyin:pinyin];
    }
    sqlite3_close(database);
}

- (void)updateFriendDataWithDB:(sqlite3 *)database
                            ID:(NSString *)fID
                        mobile:(NSString *)mobile
                          name:(NSString *)name
                    createTime:(NSString *)createTime
                    lastUpdate:(NSString *)lastUpdate
                       fUserID:(NSString *)fUserID
                        pinyin:(NSString *)pinyin
{
    if ([self friendExist:database fid:fID fUserID:fUserID]==YES)
    {
//        @"CREATE TABLE IF NOT EXISTS %@(KEYID TEXT, ID TEXT,NAME TEXT,PHONE TEXT,USER_KEYID TEXT,LON TEXT,LAT TEXT,LAST_RQ_TIME TEXT,LAST_UPDATE TEXT,SEND_LOCATION_REQUEST_TIME TEXT,CREATE_TIME TEXT)
        NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET NAME='%@',LAST_UPDATE='%@',CREATE_TIME='%@',PINYIN='%@' WHERE ID='%@' AND USER_KEYID='%@'",TABLE_FRIENDS_DATA,name,lastUpdate,createTime,pinyin,fID,fUserID];
        NSLog(@"%@",sql);
        sqlite3_stmt *stmt;
        int result = sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil);
        NSLog(@"%d",result);
        if(result == SQLITE_OK)
        {
            NSLog(@"update FriendName ok.");
            if(sqlite3_step(stmt) != SQLITE_DONE)
            {
                NSLog(@"update FriendName error.");
            }
        }
        
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
        
    }
    else
    {
        NSLog(@"update FriendName error.");
    }
}


/*!
 @method loadFriendUserIDWithPhoneList: fUserID:
 @abstract 根据用户id和电话列表读取电话和friendUserID对应的信息
 @discussion 根据用户id和电话列表读取电话和friendUserID对应的信息
 @param phoneList 电话列表
 @param fUserID 所属用户id
 @result dic 电话和friendUserID的字典，电话为key
 */
-(NSMutableDictionary *)loadFriendUserIDWithPhoneList:(NSArray *)phoneList
                         userID:(NSString *)userID
{
    NSMutableDictionary *tempDic = [[[NSMutableDictionary alloc]initWithCapacity:0]autorelease];
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        NSString *str = [NSString stringWithFormat:@"%@",[phoneList objectAtIndex:0]];
        for (int i = 1; i<phoneList.count; i++) {
            str = [str stringByAppendingString:[NSString stringWithFormat:@"','%@",[phoneList objectAtIndex:i]]];
        }
        NSString *sql = [NSString stringWithFormat:@"SELECT PHONE,FRIEND_USER_ID  FROM %@ WHERE PHONE IN('%@') AND USER_KEYID='%@'",TABLE_FRIENDS_DATA,str,userID];
        
        NSLog(@"%@",sql);
        sqlite3_stmt *stmt;
        int result = sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil);
        NSLog(@"%d",result);
        if(result == SQLITE_OK)
        {
            while(sqlite3_step(stmt) == SQLITE_ROW)
            {
                char *phone;
                char *userid;
                phone = (char*)sqlite3_column_text(stmt, 0);
                userid=(char*)sqlite3_column_text(stmt, 1);
                if(phone && userid)
                {
                    [tempDic setObject:[NSString stringWithUTF8String:userid] forKey:[NSString stringWithUTF8String:phone]];
                    
                    
                }
            }
        }
        
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
    }
    sqlite3_close(database);
    return tempDic;
}

/*!
 @method loadFriendNameWithFriendUserID:(NSMutableArray *)friendUserIDList userID:(NSString *)userID
 @abstract 通过车友用户id获取车友名字
 @discussion 通过车友用户id获取车友名字
 @param friendUserIDList 车友用户idList
 @param userAccount 所属用户id
 @result NSMutableDictionary KEY UserIDList value friendName
 */
-(NSMutableDictionary *)loadFriendNameWithFriendUserID:(NSMutableArray *)friendUserIDList
                                           userID:(NSString *)userID
{
    NSMutableDictionary *tempDic = [[[NSMutableDictionary alloc]initWithCapacity:0]autorelease];
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        NSString *str = [NSString stringWithFormat:@"%@",[friendUserIDList objectAtIndex:0]];
        for (int i = 1; i<friendUserIDList.count; i++) {
            str = [str stringByAppendingString:[NSString stringWithFormat:@"','%@",[friendUserIDList objectAtIndex:i]]];
        }
        NSString *sql = [NSString stringWithFormat:@"SELECT NAME,FRIEND_USER_ID  FROM %@ WHERE FRIEND_USER_ID IN('%@') AND USER_KEYID='%@'",TABLE_FRIENDS_DATA,str,userID];
        
        NSLog(@"%@",sql);
        sqlite3_stmt *stmt;
        int result = sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil);
        NSLog(@"%d",result);
        if(result == SQLITE_OK)
        {
            while(sqlite3_step(stmt) == SQLITE_ROW)
            {
                char *name;
                char *userid;
                name = (char*)sqlite3_column_text(stmt, 0);
                userid=(char*)sqlite3_column_text(stmt, 1);
                if(name && userid)
                {
                    [tempDic setObject:[NSString stringWithUTF8String:name] forKey:[NSString stringWithUTF8String:userid]];
                    
                    
                }
            }
        }
        
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
    }
    sqlite3_close(database);
    return tempDic;
}


/*!
 @method getFriendData:  fUserID:
 @abstract 根据车友id和所属用户id读取车友数据
 @discussion 根据车友id和所属用户id读取车友数据
 @param fID 车友id
 @param fUserID 所属用户id
 @result friend
 */
- (FriendsData *)getFriendData:(NSString *)fID
         fUserID:(NSString *)fUserID
{
    FriendsData *friend = [[[FriendsData alloc] init] autorelease];
    
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        //(KEYID,ID,NAME,PHONE,SEX,ADDRESS,ISBLACKLIST,USER_KEYID,LON,LAT,LAST_RQ_TIME,TFTYPE,LAST_UPDATE)
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE USER_KEYID='%@'AND ID='%@'",TABLE_FRIENDS_DATA,fUserID,fID];
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {

            while(sqlite3_step(stmt) == SQLITE_ROW)
            {
                friend = [self createMFriend:stmt];

            }
        }
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
    }
    sqlite3_close(database);
    return friend;
}

/*!
 @method deleteFriendData: fUserID:
 @abstract 根据车友id和所属用户id删除车友
 @discussion 根据车友id和所属用户id删除车友
 @param fID 车友id
 @param fUserID 所属用户id
 @result 无
 */
- (void)deleteFriendData:(NSString *)fID
            fUserID:(NSString *)fUserID
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        [self deleteFriendData:database
                           fid:fID
                  fUserID:fUserID];
    }
    sqlite3_close(database);
}

- (void)deleteFriendData:(sqlite3*)database
                     fid:(NSString *)fID
            fUserID:(NSString *)fUserID

{
    if ([self friendExist:database fid:fID fUserID:fUserID]==YES)
    {
        //(KEYID,ID,NAME,PHONE,SEX,ADDRESS,ISBLACKLIST,USER_KEYID,LON,LAT,LAST_RQ_TIME,TFTYPE,LAST_UPDATE)
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE ID='%@'AND USER_KEYID='%@'",TABLE_FRIENDS_DATA,fID,fUserID];
        NSLog(@"%@",sql);
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            if(sqlite3_step(stmt) != SQLITE_DONE)
            {
                NSLog(@"DEL friend error.");
            }
        }
        
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
        
    }
    else
    {
        NSLog(@"DEL friend error.");
    }
}

/*!
 @method deleteMutiFriendsData: fUserID:
 @abstract 根据车友id数组和所属用户id删除多个车友
 @discussion 根据车友id数组和所属用户id删除多个车友
 @param fIDs 车友id数组
 @param fUserID 所属用户id
 @result 无
 */
- (void)deleteMutiFriendsData:(NSArray *)fIDs
                 fUserID:(NSString *)fUserID
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        [self deleteMutiFriendsData:database
                           fid:fIDs
                  fUserID:fUserID];
    }
    sqlite3_close(database);
}

- (void)deleteMutiFriendsData:(sqlite3*)database
                     fid:(NSArray *)fIDs
            fUserID:(NSString *)fUserID
{
    if ([self friendExist:database fids:fIDs fUserID:fUserID]==YES)
    {
        //(KEYID,ID,NAME,PHONE,SEX,ADDRESS,ISBLACKLIST,USER_KEYID,LON,LAT,LAST_RQ_TIME,TFTYPE,LAST_UPDATE)
        NSMutableString *sql = [[NSMutableString alloc] initWithFormat:@"DELETE FROM %@ WHERE USER_KEYID='%@' AND (",TABLE_FRIENDS_DATA,fUserID];
        int i;
        for (i =0; i< ([fIDs count]-1); i++) {
            NSString *fid = [fIDs objectAtIndex:i];
            [sql appendFormat:@" ID='%@' OR",fid];
        }
        //此处确保最后一个条件后没有'OR'
        [sql appendFormat:@" ID='%@')",[fIDs objectAtIndex:i]];
        
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            if(sqlite3_step(stmt) != SQLITE_DONE)
            {
                NSLog(@"DEL friend error.");
            }
        }
        
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
        [sql release];
    }
    else
    {
        NSLog(@"DEL friend error.");
    }
}

/*!
 @method deleteAllFriendData:
 @abstract 根据用户id删除改账号下的所有车友
 @discussion 根据用户id删除改账号下的所有车友
 @param fUserID 所属用户id
 @result 无
 */
- (void)deleteAllFriendData:(NSString *)fUserID
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        [self deleteAllFriendData:database
                     fUserID:fUserID];
    }
    sqlite3_close(database);
}

- (void)deleteAllFriendData:(sqlite3*)database
               fUserID:(NSString *)fUserID

{
    if ([self friendExist:database fUserID:fUserID]==YES)
    {
        //(KEYID,ID,NAME,PHONE,SEX,ADDRESS,ISBLACKLIST,USER_KEYID,LON,LAT,LAST_RQ_TIME,TFTYPE,LAST_UPDATE)
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE USER_KEYID='%@'",TABLE_FRIENDS_DATA,fUserID];
        
        NSLog(@"%@",sql);
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            NSLog(@"DEL all friend ok.");
            if(sqlite3_step(stmt) != SQLITE_DONE)
            {
                NSLog(@"DEL all friend error.");
            }
        }
        
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
        
    }
    else
    {
        NSLog(@"DEL all friend error.");
    }
}

/*!
 @method friendExist:fids:fUserID:
 @abstract 查找车友表中是否存在fID中的车友
 @discussion 查找车友表中是否存在fID中的车友
 @param fUserID 所属用户id
 @param fID 车友id数组
 @result bool
 */
- (BOOL)friendExist:(sqlite3*)database fids:(NSArray *)fID fUserID:(NSString *)fUserID
{
    int count = 0;
    //(KEYID,ID,NAME,PHONE,SEX,ADDRESS,ISBLACKLIST,USER_KEYID,LON,LAT,LAST_RQ_TIME,TFTYPE,LAST_UPDATE)
    NSMutableString *sql = [[NSMutableString alloc] initWithFormat:@"SELECT count(*) FROM %@ WHERE USER_KEYID='%@' AND (", TABLE_FRIENDS_DATA,fUserID];
    int idnum = [fID count];
    //使用for循环把条件加入
    int i;
    for (i =0; i< (idnum - 1); i++) {
        NSString *fid = [fID objectAtIndex:i];
        [sql appendFormat:@" ID='%@' OR",fid];
    }
    //此处确保最后一个条件后没有'OR'
    [sql appendFormat:@" ID='%@')",[fID objectAtIndex:i]];//for 中已经进行了加1
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
 @method friendExist:fid:fUserID:
 @abstract 查找车友表中是否存在fID中的车友
 @discussion 查找车友表中是否存在fID中的车友
 @param fUserID 所属用户id
 @param fID 车友id
 @result bool
 */
- (BOOL)friendExist:(sqlite3*)database fid:(NSString *)fID fUserID:(NSString *)fUserID
{
    int count = 0;
    //(KEYID,ID,NAME,PHONE,SEX,ADDRESS,ISBLACKLIST,USER_KEYID,LON,LAT,LAST_RQ_TIME,TFTYPE,LAST_UPDATE)
    NSString *sql = [NSString stringWithFormat:@"SELECT count(*) FROM %@ WHERE ID='%@' AND USER_KEYID='%@'", TABLE_FRIENDS_DATA,fID,fUserID];
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
 @method friendExist:fid:fUserID:
 @abstract 查找车友表中是否存在所属用户为fUserID的车友
 @discussion 查找车友表中是否存在所属用户为fUserID的车友
 @param fUserID 所属用户id
 @result bool
 */
- (BOOL)friendExist:(sqlite3*)database fUserID:(NSString *)fUserID
{
    int count = 0;
    //(KEYID,ID,NAME,PHONE,SEX,ADDRESS,ISBLACKLIST,USER_KEYID,LON,LAT,LAST_RQ_TIME,TFTYPE,LAST_UPDATE)
    NSString *sql = [NSString stringWithFormat:@"SELECT count(*) FROM %@ WHERE USER_KEYID='%@'", TABLE_FRIENDS_DATA,fUserID];
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
 @method friendExist:phone:fUserID:
 @abstract 查找车友表中是否存在所属用户为fUserID电话为phone的车友
 @discussion 查找车友表中是否存在所属用户为fUserID电话为phone的车友
 @param fUserID 所属用户id
 @param phone 电话
 @result bool
 */
- (BOOL)friendExistWhitUserID:(NSString *)fUserID phone:(NSString *)phone
{
    BOOL isExist = NO;
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        isExist = [self friendExist:database phone:phone fUserID:fUserID];
    }
    sqlite3_close(database);
    return isExist;
}

/*!
 @method friendExist:phone:fUserID:
 @abstract 查找车友表中是否存在所属用户为fUserID电话为phone的车友
 @discussion 查找车友表中是否存在所属用户为fUserID电话为phone的车友
 @param fUserID 所属用户id
 @param phone 电话
 @result bool
 */
- (BOOL)friendExist:(sqlite3*)database phone:(NSString *)phone  fUserID:(NSString *)fUserID
{
    int count = 0;
    //(KEYID,ID,NAME,PHONE,SEX,ADDRESS,ISBLACKLIST,USER_KEYID,LON,LAT,LAST_RQ_TIME,TFTYPE,LAST_UPDATE)
    NSString *sql = [NSString stringWithFormat:@"SELECT count(*) FROM %@ WHERE PHONE='%@' AND USER_KEYID='%@'", TABLE_FRIENDS_DATA,phone,fUserID];
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
 @method loadMeetRequestFriendDataWithUserKeyID:
 @abstract 根据用户id读取该账号下的所有车友
 @discussion 根据用户id读取该账号下的所有车友
 @param fUserID 所属用户id
 @result friendlist
 */
- (NSMutableArray*)loadMeetRequestFriendDataWithUserKeyID:(NSString *)fUserID
{
    NSMutableArray *array = [[[NSMutableArray alloc]initWithCapacity:0]autorelease];
    
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE USER_KEYID='%@'ORDER BY PINYIN",TABLE_FRIENDS_DATA,fUserID];
        sqlite3_stmt *stmt;
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            FriendsData *friend;
            while(sqlite3_step(stmt) == SQLITE_ROW)
            {
                friend = [self createMFriend:stmt];
                [array addObject:friend];
            }
            //            NSLog(@"%@,%@",friend.mfID,friend.mfCarVin);
        }
        sqlite3_reset(stmt);
        sqlite3_finalize(stmt);
    }
    sqlite3_close(database);
    return array;
}

/*!
 @method createMFriend:
 @abstract 将查找到的数据封装到friend中
 @discussion 将查找到的数据封装到friend中
 @param stmt　查找到的某条数据
 @param friend　车友
 */
- (FriendsData*)createMFriend:(sqlite3_stmt*)stmt
{
    FriendsData *friend = [[[FriendsData alloc]init]autorelease];
    //    FriendsData *friend = [[FriendsData alloc]init];
    
    char *text;
    int index = 0;
    
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        friend.mfKeyID = [NSString stringWithUTF8String:text];
//        NSLog(@"%@",friend.mfKeyID);
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        friend.mfID = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        friend.mfName = [NSString stringWithUTF8String:text];
//        NSLog(@"%@",friend.mfName);
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        friend.mfPhone = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        friend.mfUserID = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        friend.mfLon = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        friend.mfLat = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        friend.mfLastRqTime = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        friend.mfLastUpdate = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        friend.mSendLocationRqTime = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        friend.mCreateTime = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        friend.mFriendUserID = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        friend.mPoiName = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        friend.mPoiAddress = [NSString stringWithUTF8String:text];
    }
    text = (char*)sqlite3_column_text(stmt, index++);
    if(text)
    {
        friend.mPinyin = [NSString stringWithUTF8String:text];
    }
    return friend;
}

@end
