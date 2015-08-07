
/*!
 @header SearchHistoryData.h
 @abstract 操作搜索历史表
 @author mengy
 @version 1.00 13-5-14 Creation
 */
#define TABLE_SEARCH_HISTROY_DATA          @"POI_SEARCH_HISTORY"
#import <Foundation/Foundation.h>
#import "UserData.h"

@interface SearchHistoryData : NSObject
{
    UserData *mUserData;
    NSString *mKeyID;
    NSString *mSearchName;
    NSString *mCreateTime;
    NSString *mUserID;
}
@property(nonatomic,copy)NSString *mKeyID;
@property(nonatomic,copy)NSString *mSearchName;
@property(nonatomic,copy)NSString *mCreateTime;
@property(nonatomic,copy)NSString *mUserID;
@property(nonatomic,retain)UserData *mUserData;
/*!
 @method initSearchHistoryDatabase
 @abstract 建表
 @discussion 建表
 @param 无
 @result 无
 */
- (void)initSearchHistoryDatabase;

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
-(void)addSearchHistory:(NSString *)keyID
             searchName:(NSString *)searchName
             createTime:(NSString *)createTime
                 userID:(NSString *)userID;

/*!
 @method deleteSearchHistory:(NSString*)userID
 @abstract 删除某用户下的搜索历史记录
 @discussion 删除某用户下的搜索历史记录
 @param userID 所属用户id
 @result bool
 */
- (BOOL)deleteSearchHistory:(NSString*)userID;

/*!
 @method loadMeetRequestSearchHistory:(NSString *)userID
 @abstract 加载某用户下的搜索历史记录
 @discussion 加载某用户下的搜索历史记录
 @param userID 所属用户id
 @result searchHistoryList 搜索历史列表
 */
- (NSMutableArray*)loadMeetRequestSearchHistory:(NSString *)userID;

/*!
 @method loadMeetRequestSearchHistoryWithText:(NSString *)userID searchText:(NSString *)searchText
 @abstract 加载某用户下符合某关键字的搜索历史记录
 @discussion 加载某用户下符合某关键字的搜索历史记录
 @param userID 所属用户id
 @param searchText 搜索关键字
 @result searchHistoryList 搜索历史列表
 */
- (NSMutableArray*)loadMeetRequestSearchHistoryWithText:(NSString *)userID searchText:(NSString *)searchText;
@end
