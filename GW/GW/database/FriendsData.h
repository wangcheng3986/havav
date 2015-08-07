
/*!
 @header FriendsData.h
 @abstract 操作车友表
 @author mengy
 @version 1.00 13-4-23 Creation
 */
enum FRIEND_TYPE{
    FRIENDLIST = 0,  //好友
    BLACKLIST =1,//黑名单
};
//#define FRIENDDATABASE_NAME           @"friend.db"
#define TABLE_FRIENDS_DATA          @"FRIEND"
#import <Foundation/Foundation.h>
#import "UserData.h"
/*!
 @class
 @abstract 操作FRIEND表。
 */
@interface FriendsData : NSObject
{
    
}
@property(nonatomic,copy)NSString *mfKeyID;
@property(nonatomic,copy) NSString *mfID;
@property(nonatomic,copy) NSString *mfName;
@property(nonatomic,copy)NSString *mfPhone;
@property(nonatomic,copy)NSString *mfUserID;
@property(nonatomic,copy)NSString *mfLon;
@property(nonatomic,copy)NSString *mfLat;
@property(nonatomic,copy)NSString *mfLastRqTime;
@property(nonatomic,copy)NSString *mfLastUpdate;
@property(nonatomic,copy)NSString *mSendLocationRqTime;
@property(nonatomic,copy)NSString *mCreateTime;
@property(nonatomic,copy)NSString *mFriendUserID;
@property(nonatomic,copy)NSString *mPoiName;
@property(nonatomic,copy)NSString *mPoiAddress;
@property(nonatomic,copy)NSString *mPinyin;
/*!
 @method initFriendDatabase
 @abstract 建表
 @discussion 建表
 @param 无
 @result 无
 */
- (void)initFriendDatabase;

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
                  pinyin:(NSString *)pinyin;

/*!
 @method deleteFriendWithPhone：fUserID:
 @abstract 根据电话和所属用户进行删除
 @discussion 根据电话和所属用户进行删除
 @param phone 电话
 @param fUserID 所属用户id
 @result 无
 */
- (void)deleteFriendWithPhone:(NSString *)phone fUserID:(NSString *)fUserID;

/*!
 @method addFriendDataWithSqls:
 @abstract 通过sqlList添加车友
 @discussion 通过sqlList添加车友
 @param sql sql语句数组
 @result 无
 */
- (void)addFriendDataWithSqls:(NSMutableArray *)sql;

/*!
 @method getFriendName: fUserID:
 @abstract 根据车友id和所属用户id获取车友名字
 @discussion 根据车友id和所属用户id获取车友名字
 @param fID 车友id
 @param fUserID 所属用户id
 @result name
 */
- (NSString *)getFriendName:(NSString *)fID
               fUserID:(NSString *)fUserID;

/*!
 @method getFriendNameWithPhone: fUserID:
 @abstract 根据车友phone和所属用户id获取车友名字
 @discussion 根据车友phone和所属用户id获取车友名字
 @param phone 车友电话
 @param fUserID 所属用户id
 @result name
 */
- (NSString *)getFriendNameWithPhone:(NSString *)phone
                        fUserID:(NSString *)fUserID;


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
                  poiAddress:(NSString *)poiAddress;


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
                        pinyin:(NSString *)pinyin;

/*!
 @method getFriendData:  fUserID:
 @abstract 根据车友id和所属用户id读取车友数据
 @discussion 根据车友id和所属用户id读取车友数据
 @param fID 车友id
 @param fUserID 所属用户id
 @result friend
 */
- (FriendsData *)getFriendData:(NSString *)fID
         fUserID:(NSString *)fUserID;

/*!
 @method getRqTimeWithFID:  fUserID:
 @abstract 根据车友id和所属用户id获取上次位置请求时间
 @discussion 根据车友id和所属用户id获取上次位置请求时间
 @param fID 车友id
 @param fUserID 所属用户id
 @result time
 */
- (NSString *)getRqTimeWithFID:(NSString *)fID
                  fUserID:(NSString *)fUserID;

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
                     fUserID:(NSString *)fUserID;

/*!
 @method deleteFriendData: fUserID:
 @abstract 根据车友id和所属用户id删除车友
 @discussion 根据车友id和所属用户id删除车友
 @param fID 车友id
 @param fUserID 所属用户id
 @result 无
 */
- (void)deleteFriendData:(NSString *)fID
            fUserID:(NSString *)fUserID;

/*!
 @method deleteMutiFriendsData: fUserID:
 @abstract 根据车友id数组和所属用户id删除多个车友
 @discussion 根据车友id数组和所属用户id删除多个车友
 @param fIDs 车友id数组
 @param fUserID 所属用户id
 @result 无
 */
- (void)deleteMutiFriendsData:(NSArray *)fIDs
            fUserID:(NSString *)fUserID;

/*!
 @method deleteAllFriendData:
 @abstract 根据用户id删除改账号下的所有车友
 @discussion 根据用户id删除改账号下的所有车友
 @param fUserID 所属用户id
 @result 无
 */
- (void)deleteAllFriendData:(NSString *)fUserID;

/*!
 @method loadMeetRequestFriendDataWithUserKeyID:
 @abstract 根据用户id读取该账号下的所有车友
 @discussion 根据用户id读取该账号下的所有车友
 @param fUserID 所属用户id
 @result friendlist
 */
- (NSMutableArray*)loadMeetRequestFriendDataWithUserKeyID:(NSString *)fUserID;
/*!
 @method loadFriendUserIDWithPhoneList: fUserID:
 @abstract 根据用户id和电话列表读取电话和friendUserID对应的信息
 @discussion 根据用户id和电话列表读取电话和friendUserID对应的信息
 @param phoneList 电话列表
 @param userID 所属用户id
 @result dic 电话和friendUserID的字典，电话为key
 */
-(NSMutableDictionary *)loadFriendUserIDWithPhoneList:(NSArray *)phoneList
                                          userID:(NSString *)userID;

/*!
 @method loadFriendNameWithFriendUserID:(NSMutableArray *)friendUserIDList userID:(NSString *)userID
 @abstract 通过车友用户id获取车友名字
 @discussion 通过车友用户id获取车友名字
 @param friendUserIDList 车友用户idList
 @param userID 所属用户id
 @result NSMutableDictionary KEY UserIDList value friendName
 */
-(NSMutableDictionary *)loadFriendNameWithFriendUserID:(NSMutableArray *)friendUserIDList
                                           userID:(NSString *)userID;

/*!
 @method friendExist:phone:fUserID:
 @abstract 查找车友表中是否存在所属用户为fUserID电话为phone的车友
 @discussion 查找车友表中是否存在所属用户为fUserID电话为phone的车友
 @param fUserID 所属用户id
 @param phone 电话
 @result bool
 */
- (BOOL)friendExistWhitUserID:(NSString *)fUserID phone:(NSString *)phone;
@end
