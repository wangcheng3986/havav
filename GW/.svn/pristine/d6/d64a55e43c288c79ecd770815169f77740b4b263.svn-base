
/*!
 @header POIData.h
 @abstract 操作poi表
 @author mengy
 @version 1.00 13-5-13 Creation
 */
#define TABLE_POIDATA          @"POI_FAVORITES"
#import <Foundation/Foundation.h>
#import "UserData.h"

@interface POIData : NSObject
{
    UserData *mUserData;
    NSString *mKeyID;
    NSString *mfID;
    NSString *mID;
    NSString *mName;
    NSString *mCreateTime;
    NSString *mLon;
    NSString *mLat;
    NSString *mPhone;
    NSString *mAddress;
    NSString *mDesc;
    int mFlag;
    NSString *mUserID;
    NSString *mPostCode;
    int mLevel;
}
@property(nonatomic,copy)NSString *mKeyID;
@property(nonatomic,copy)NSString *mfID;
@property(nonatomic,copy)NSString *mID;
@property(nonatomic,copy)NSString *mName;
@property(nonatomic,copy)NSString *mCreateTime;
@property(nonatomic,copy)NSString *mLon;
@property(nonatomic,copy)NSString *mLat;
@property(nonatomic,copy)NSString *mPhone;
@property(nonatomic,copy)NSString *mAddress;
@property(nonatomic,copy)NSString *mDesc;
@property(assign)int mFlag;
@property(nonatomic,copy)NSString *mUserID;
@property(assign)int mLevel;
@property(nonatomic,copy)NSString *mPostCode;

/*!
 @method initPOIDatabase
 @abstract 建表
 @discussion 建表
 @param 无
 @result 无
 */
- (void)initPOIDatabase;

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
          postCode:(NSString *)postCode;

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
             postCode:(NSString *)postCode;

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
               fID:(NSString *)fID;

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
               IDs:(NSMutableArray *)IDs;


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
                  createTime:(NSString *)createTime;

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
                  fID:(NSString *)fID;

/*!
 @method deleteAllPOIData:(NSString*)userID
 @abstract 删除某用户下的所有poi
 @discussion 删除某用户下的所有poi
 @param userID 所属用户id
 @result 无
 */
- (void)deleteAllPOIData:(NSString*)userID;

/*!
 @method deleteSycnPOIData:(NSString*)userID
 @abstract 删除某用户下的所有已同步的poi
 @discussion 删除某用户下的所有已同步的poi
 @param userID 所属用户id
 @result 无
 */
- (void)deleteSycnPOIData:(NSString*)userID;

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
- (BOOL)poiExist:(NSString *)lon lat:(NSString *)lat userID:(NSString *)userID ID:(NSString *)ID fID:(NSString *)fID type:(int)type;


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
- (POIData*)loadPoi:(NSString *)lon lat:(NSString *)lat userID:(NSString *)userID ID:(NSString *)ID fID:(NSString *)fID type:(int)type;

/*!
 @method loadMeetRequestCollectTableData:(NSString *)userID
 @abstract 获取已同步和添加未同步的收藏夹列表
 @discussion 获取已同步和添加未同步的收藏夹列表
 @param userID 所属用户id
 @result poilist poi列表
 */
- (NSMutableArray*)loadMeetRequestCollectTableData:(NSString *)userID;

/*!
 @method loadMeetRequestPOIDataSyncYES:(NSString *)userID
 @abstract 获取已同步的收藏夹列表
 @discussion 获取已同步的收藏夹列表
 @param userID 所属用户id
 @result poilist poi列表
 */
- (NSMutableArray*)loadMeetRequestPOIDataSyncYES:(NSString *)userID;

/*!
 @method loadMeetRequestPOIDataSyncNO:(NSString *)userID
 @abstract 获取未同步的列表
 @discussion 获取未同步的列表
 @param userID 所属用户id
 @result poilist poi列表
 */
- (NSMutableArray*)loadMeetRequestPOIDataSyncNO:(NSString *)userID;

/*!
 @method loadMeetRequestPOIDataSyncAdd:(NSString *)userID
 @abstract 获取添加未同步的列表
 @discussion 获取添加未同步的列表
 @param userID 所属用户id
 @result poilist poi列表
 */
- (NSMutableArray*)loadMeetRequestPOIDataSyncAdd:(NSString *)userID;

/*!
 @method loadMeetRequestPOIData:(NSString *)userID lon:(NSString *)lon lat:(NSString *)lat
 @abstract 根据lon、lat、userid查找poi信息
 @discussion 根据lon、lat、userid查找poi信息
 @param userID 所属用户id
 @param lon 经度
 @param lat 纬度
 @result poi poi信息
 */
- (POIData*)loadMeetRequestPOIData:(NSString *)userID lon:(NSString *)lon lat:(NSString *)lat;

/*!
 @method deletePOIDataWithFID:(NSString *)fID userID:(NSString*)userID
 @abstract 根据fID和userID删除未同步的poi，将已同步的poi置为删除未同步状态。
 @discussion 根据fID和userID删除未同步的poi，将已同步的poi置为删除未同步状态。
 @param userID 所属用户id
 @param fID 收藏id
 @result 无
 */
- (void)deletePOIDataWithFID:(NSString *)fID
                      userID:(NSString*)userID;


/*!
 @method addPOIDataWithSqls:(NSMutableArray *)sqls
 @abstract 传入sql语句插入poi信息
 @discussion 传入sql语句插入poi信息
 @param sqls sql数组
 @result 无
 */
- (void)addPOIDataWithSqls:(NSMutableArray *)sqls;
@end
