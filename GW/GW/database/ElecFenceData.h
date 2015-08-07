/*!
 @header ElecFenceData.h
 @abstract 电子围栏数据操作
 @author wangqiwei
 @version 1.00 2014/9/1 Create
 */
#import <Foundation/Foundation.h>
#import <sqlite3.h>
#define TABLE_ELECFENCE_DB          @"ELECFENCE"
#define removeSuccess 0
#define removeFailure 1
#define removeDataNotExist 2
#define updateSuccess 0
#define updateFailure 1
#define updateDataNotExist 2
@interface ElecFenceData : NSObject
{
    
}
@property (nonatomic ,copy) NSString *keyID;
@property (nonatomic ,copy) NSString *elecFenceId;
@property (nonatomic ,copy) NSString *name;
@property (nonatomic ,copy) NSString *lastUpdate;
@property (nonatomic ,copy) NSString *valid;
@property (nonatomic ,assign) double lon;
@property (nonatomic ,assign) double lat;
@property (nonatomic ,assign) int radius;
@property (nonatomic ,copy) NSString *descriptionText;
@property (nonatomic ,copy) NSString *address;
@property (nonatomic ,copy) NSString *vin;
@property (nonatomic ,copy) NSString *userKeyID;


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
                             vin:(NSString*)vin;
//更新所有电子围栏为无效
- (BOOL)updateElecFenceWithValid:(NSString*)valid
                            vin:(NSString*)vin;

//查询
- (NSMutableArray*)selectWithVin:(NSString*)vin;

//删除单项
- (BOOL)removeWithDBID:(NSString *)elecFenceId
                   vin:(NSString*)vin;

//删除所有
- (BOOL)removeWithAllDBVin:(NSString*)vin;



#pragma mark - baseControl
- (sqlite3*)openDatabase;
- (BOOL)initElecFenceDatabase;
//查询
- (NSMutableArray*)selectWithDB:(sqlite3*)database
                            vin:(NSString*)vin;

- (NSMutableArray*)selectWithvin:(NSString*)vin
                     elecFenceId:(NSString*)elecFenceId;
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
                 userKeyID:(NSString*)userKeyID;

//删除所有
- (BOOL)removeWithAllDB:(sqlite3*)database
                    vin:(NSString*)vin;

//删除单项
- (int)removeWithDB:(sqlite3*)database
                 ID:(NSString *)elecFenceId
                vin:(NSString*)vin;


//根据电子围栏ID查询电子围栏是否存在
- (BOOL)selectElecFenceIsExist:(sqlite3*)database
                            ID:(NSString *)elecFenceId;

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
                         vin:(NSString*)vin;


@end
