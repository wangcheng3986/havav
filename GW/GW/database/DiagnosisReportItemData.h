
/*!
 @header DiagnosisReportItemData.h
 @abstract 故障诊断故障项表
 @author mengy
 @version 1.00 14-10-20 Creation
 */

#import <Foundation/Foundation.h>
#define TABLE_VEHICLE_DIAGNOSIS_REPORT_ITEM_DATA          @"MESSAGE_DIAGNOSIS_REPORT_FAULT_ITEM"
@interface DiagnosisReportItemData : NSObject
//1	KEYID	主键	VARCHAR2(32)	否	唯一
//2	REPORT_ID	诊断报告的id	VARCHAR2(32)	否		GW.M.GET_MESSAGE_LIST	reportId
//3	CHECK_ITEM_TYPE	检查项的类型	VARCHAR2(1)	否		GW.M.GET_MESSAGE_LIST	checkItemType
//4	CHECK_ITEM_TYPE_NAME	检查项的类型名称	VARCHAR2(32)	否		GW.M.GET_MESSAGE_LIST	checkItemTypeName
//5	FAULT_ITEM_ID	故障项的id	VARCHAR2(32)			GW.M.GET_MESSAGE_LIST	faultItemId
//6	FAULT_ITEM_NAME	故障项的名称	VARCHAR2(32)			GW.M.GET_MESSAGE_LIST	faultItemName
//7	FAULT_ITEM_DESC	故障项的描述	VARCHAR2(256)			GW.M.GET_MESSAGE_LIST	faultItemDesc
//8	FAULT_CREATE_TIME	故障生成时间	VARCHAR2(16)			GW.M.GET_MESSAGE_LIST	faultCreateTime
@property(nonatomic,copy)NSString *mKeyid;
@property(nonatomic,copy)NSString *mRepertId;
@property(nonatomic,copy)NSString *mCheckItemType;
@property(nonatomic,copy)NSString *mCheckItemTypeName;
@property(nonatomic,copy)NSString *mFaultItemId;
@property(nonatomic,copy)NSString *mFaultItemName;
@property(nonatomic,copy)NSString *mFaultItemDesc;
@property(nonatomic,copy)NSString *mFaultCreateTime;
/*!
 @method initVehicleDiagnosisItemDatabase
 @abstract 建表
 @discussion 建表
 @param 无
 @result 无
 */
- (void)initVehicleDiagnosisItemDatabase;

//大分类查询去重排序
- (NSMutableArray*)selectWithReportID:(NSString*)reportID;
//通过reportID和大分类序号查询所有符合条件的数据
- (NSMutableArray*)selectWithReportID:(NSString*)reportID checkItemType:(NSString*)checkItemType;
@end
