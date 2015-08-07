
/*!
 @header BlackData.h
 @abstract 操作BLACK表
 @author mengy
 @version 1.00 14-4-1 Creation
 */
#import <Foundation/Foundation.h>
#define TABLE_BLACK_DATA          @"BLACK"
#import "UserData.h"
/*!
 @class
 @abstract 操作BLACK表。
 */
@interface BlackData : NSObject
{
}
@property(nonatomic,copy)NSString *mKeyID;
@property(nonatomic,copy) NSString *mID;
@property(nonatomic,copy) NSString *mName;
@property(nonatomic,copy)NSString *mMobile;
@property(nonatomic,copy) NSString *mLastUpdate;
@property(nonatomic,copy) NSString *mCreateTime;
@property(nonatomic,copy) NSString *mUserKeyID;
@property(nonatomic,copy) NSString *mPinyin;
/*!
 @method initBlackDatabase
 @abstract 建表
 @discussion 建表
 @param 无
 @result 无
 */
- (void)initBlackDatabase;

/*!
 @method addBlackDataWithSqls：
 @abstract 根据ｓｑｌ语句向表中插入数据
 @discussion 根据ｓｑｌ语句向表中插入数据
 @param sql　ｓｑｌ语句数组
 @result 无
 */
- (void)addBlackDataWithSqls:(NSMutableArray *)sql;

/*!
 @method deleteBlackDataWithIDs：userKeyID：
 @abstract 根据ｉｄ数组删除表中多条数据
 @discussion 根据ｉｄ数组删除表中多条数据
 @param IDs　ｉｄ数组
 @param userKeyID　黑名单所属用户ｉｄ
 @result 无
 */
- (void)deleteBlackDataWithIDs:(NSArray *)IDs
                     userKeyID:(NSString *)userKeyID;

/*!
 @method deleteAllBlackDataWithUserKeyID：
 @abstract 删除某用户的所有黑名单
 @discussion 删除某用户的所有黑名单
 @param userKeyID　黑名单所属用户ｉｄ
 @result 无
 */
- (void)deleteAllBlackDataWithUserKeyID:(NSString *)userKeyID;

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
                          pinyin:(NSString *)pinyin;

/*!
 @method deleteBlackDataWithMobile：userKeyID:
 @abstract 根据电话和userKeyID删除黑名单数据
 @discussion 根据电话和userKeyID删除黑名单数据
 @param mobile　电话
 @param userKeyID　所属用户ｉｄ
 @result 无
 */
- (void)deleteBlackDataWithMobile:(NSString*)mobile
                        userKeyID:(NSString *)userKeyID;

/*!
 @method loadBlackDataWithUserKeyID:
 @abstract 加载某用户下黑名单数据
 @discussion 加载某用户下黑名单数据
 @param userKeyID　所属用户ｉｄ
 @result NSMutableArray　黑名单列表
 */
- (NSMutableArray*)loadBlackDataWithUserKeyID:(NSString *)userKeyID;

/*!
 @method blackExist:mobile:
 @abstract 根据mobile，userKeyID判断黑名单是否在数据库表中存在
 @discussion 根据mobile，userKeyID判断黑名单是否在数据库表中存在
 @param userKeyID　黑名单所属用户ｉｄ
 @param database　数据库
 @param mobile　电话号码
 @result BOOL
 */
- (BOOL)blackExist:(NSString *)userKeyID mobile:(NSString *)mobile;
@end
