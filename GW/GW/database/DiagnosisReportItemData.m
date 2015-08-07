
/*!
 @header DiagnosisReportItemData.m
 @abstract 故障诊断故障项表
 @author mengy
 @version 1.00 14-10-20 Creation
 */

#import "DiagnosisReportItemData.h"

#import <sqlite3.h>
#import "UserData.h"
@implementation DiagnosisReportItemData
//@synthesize mRepertId;
//@synthesize mKeyid;
//@synthesize mCheckItemType;
//@synthesize mCheckItemTypeName;
//@synthesize mFaultCreateTime;
//@synthesize mFaultItemDesc;
//@synthesize mFaultItemId;
//@synthesize mFaultItemName;

-(void)dealloc
{
    if (_mRepertId) {
        [_mRepertId release];
    }
    if (_mKeyid) {
        [_mKeyid release];
    }
    if (_mCheckItemType) {
        [_mCheckItemType release];
    }
    if (_mCheckItemTypeName) {
        [_mCheckItemTypeName release];
    }
    if (_mFaultCreateTime) {
        [_mFaultCreateTime release];
    }
    if (_mFaultItemDesc) {
        [_mFaultItemDesc release];
    }
    if (_mFaultItemId) {
        [_mFaultItemId release];
    }
    if (_mFaultItemName) {
        [_mFaultItemName release];
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

//大分类查询去重排序
- (NSMutableArray*)selectWithReportID:(NSString*)reportID
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        NSMutableArray *dic = [self selectWithDB:database reportID:reportID];
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

//通过reportID和大分类序号查询所有符合条件的数据
- (NSMutableArray*)selectWithReportID:(NSString*)reportID checkItemType:(NSString*)checkItemType
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        NSMutableArray *dic = [self selectWithDB:database reportID:reportID checkItemType:checkItemType];
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

/*!
 @method initVehicleDiagnosisItemDatabase
 @abstract 建表
 @discussion 建表
 @param 无
 @result 无
 */
//1	KEYID	主键	VARCHAR2(32)	否	唯一
//2	REPORT_ID	诊断报告的id	VARCHAR2(32)	否		GW.M.GET_MESSAGE_LIST	reportId
//3	CHECK_ITEM_TYPE	检查项的类型	VARCHAR2(1)	否		GW.M.GET_MESSAGE_LIST	checkItemType
//4	CHECK_ITEM_TYPE_NAME	检查项的类型名称	VARCHAR2(32)	否		GW.M.GET_MESSAGE_LIST	checkItemTypeName
//5	FAULT_ITEM_ID	故障项的id	VARCHAR2(32)			GW.M.GET_MESSAGE_LIST	faultItemId
//6	FAULT_ITEM_NAME	故障项的名称	VARCHAR2(32)			GW.M.GET_MESSAGE_LIST	faultItemName
//7	FAULT_ITEM_DESC	故障项的描述	VARCHAR2(256)			GW.M.GET_MESSAGE_LIST	faultItemDesc
//8	FAULT_CREATE_TIME	故障生成时间	VARCHAR2(16)			GW.M.GET_MESSAGE_LIST	faultCreateTime
- (void)initVehicleDiagnosisItemDatabase
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
        char *msg;
        NSString *sql;
        do
        {
            //create MessageInfo table
            sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (KEYID TEXT PRIMARY KEY,REPORT_ID TEXT,CHECK_ITEM_TYPE TEXT,CHECK_ITEM_TYPE_NAME TEXT,FAULT_ITEM_ID TEXT,FAULT_ITEM_NAME TEXT,FAULT_ITEM_DESC TEXT,FAULT_CREATE_TIME TEXT)", TABLE_VEHICLE_DIAGNOSIS_REPORT_ITEM_DATA];
            
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
- (NSMutableArray*)selectWithDB:(sqlite3*)database
                       reportID:(NSString*)reportID

{
    NSMutableArray *array = [[[NSMutableArray alloc]initWithCapacity:0]autorelease];
    int index = 0;
    char *text;
    if (database)
    {
        NSString *sql = [NSString stringWithFormat:@"SELECT DISTINCT CHECK_ITEM_TYPE FROM %@ WHERE REPORT_ID='%@' ORDER BY CHECK_ITEM_TYPE",TABLE_VEHICLE_DIAGNOSIS_REPORT_ITEM_DATA,reportID];
        sqlite3_stmt *stmt;
        
        if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
        {
            while(sqlite3_step(stmt) == SQLITE_ROW)
            {
                text = (char*)sqlite3_column_text(stmt,index);
                if (text)
                {
                    [array addObject:[NSString stringWithUTF8String:text]];
                }

            }
        }
        sqlite3_finalize(stmt);
    }
    
    return  array;
}

- (NSMutableArray*)selectWithDB:(sqlite3*)database reportID:(NSString*)reportID checkItemType:(NSString*)checkItemType
{
    NSMutableArray *array = [[[NSMutableArray alloc]initWithCapacity:0]autorelease];
    
    if (database)
    {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE REPORT_ID='%@' AND CHECK_ITEM_TYPE='%@'",TABLE_VEHICLE_DIAGNOSIS_REPORT_ITEM_DATA,reportID,checkItemType];
        sqlite3_stmt *stmt;
         if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK)
         {
            while(sqlite3_step(stmt) == SQLITE_ROW)
            {
                DiagnosisReportItemData *ReportItemData;
                ReportItemData = [self createDiagnosisDataObject:stmt];
                [array addObject:ReportItemData];
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

//诊断数据封装
- (DiagnosisReportItemData*)createDiagnosisDataObject:(sqlite3_stmt*)stmt
{
    int index = 0;
    char *text;
    
    DiagnosisReportItemData *ReportItemData = [[[DiagnosisReportItemData alloc]init]autorelease];
    //KEYID
    text = (char*)sqlite3_column_text(stmt, index++);
    if (text) {
        ReportItemData.mKeyid = [NSString stringWithUTF8String:text];
    }
    //REPORT_ID
    text = (char*)sqlite3_column_text(stmt, index++);
    if (text) {
        ReportItemData.mRepertId = [NSString stringWithUTF8String:text];
    }
    
    //CHECK_ITEM_TYPE
    text = (char*)sqlite3_column_text(stmt, index++);
    if (text) {
        ReportItemData.mCheckItemType = [NSString stringWithUTF8String:text];
    }
    
    //CHECK_ITEM_TYPE_NAME
    text = (char*)sqlite3_column_text(stmt, index++);
    if (text) {
        ReportItemData.mCheckItemTypeName = [NSString stringWithUTF8String:text];
    }
    
    //FAULT_ITEM_ID
    text = (char*)sqlite3_column_text(stmt, index++);
    if (text) {
        ReportItemData.mFaultItemId = [NSString stringWithUTF8String:text];
    }
    
    //FAULT_ITEM_NAME
    text = (char*)sqlite3_column_text(stmt, index++);
    if (text) {
        ReportItemData.mFaultItemName = [NSString stringWithUTF8String:text];
    }
    
    //FAULT_ITEM_DESC
    text = (char*)sqlite3_column_text(stmt, index++);
    if (text) {
        ReportItemData.mFaultItemDesc = [NSString stringWithUTF8String:text];
    }
    
    //FAULT_CREATE_TIME
    text = (char*)sqlite3_column_text(stmt, index++);
    if (text) {
        ReportItemData.mFaultCreateTime = [NSString stringWithUTF8String:text];
    }
    
    return ReportItemData;
}

@end
