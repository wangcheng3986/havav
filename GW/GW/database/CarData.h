

/*!
 @header CarData.h
 @abstract 操作VEHICLE表
 @author mengy
 @version 1.00 14-4-1 Creation
 */
#define TABLE_CARDATA          @"VEHICLE"
#import <Foundation/Foundation.h>
#import "UserData.h"
/*!
 @class
 @abstract 操作VEHICLE表。
 */
@interface CarData : NSObject
{
    NSString *mKeyID;
    NSString    *mCarID;
    NSString    *mVin;
    NSString *mVType;
    NSString *mName;
    NSString *mCarRegisCode;
    NSString *mCarNumber;
    NSString *mMotorCode;
    NSString *mUserID;
    NSString *mSim;
    NSString *mLon;
    NSString *mLat;
    NSString *mLastRpTime;
    NSString *mService;
}
@property(nonatomic,copy)NSString *mKeyID;
@property(nonatomic,copy) NSString *mCarID;
@property(nonatomic,copy) NSString *mVin;
@property(nonatomic,copy)NSString *mVType;
@property(nonatomic,copy) NSString *mName;
@property(nonatomic,copy) NSString *mCarRegisCode;
@property(nonatomic,copy)NSString *mCarNumber;
@property(nonatomic,copy) NSString *mMotorCode;
@property(nonatomic,copy) NSString *mUserID;
@property(nonatomic,copy) NSString *mSim;
@property(nonatomic,copy)NSString *mLon;
@property(nonatomic,copy)NSString *mLat;
@property(nonatomic,copy)NSString *mLastRpTime;
@property(nonatomic,copy)NSString *mService;

/*!
 @method initWithCarID：
 @abstract 初始化缓存中cardata数据
 @discussion 初始化缓存中cardata数据
 @param 车辆信息
 @result self
 */
- (id)initWithCarID:(NSString*)keyID
              carID:(NSString*)carID
                vin:(NSString*)vin
               type:(NSString*)type
               name:(NSString*)name
       carRegisCode:(NSString*)carRegisCode
          carNumber:(NSString*)carNumber
          motorCode:(NSString*)motorCode
             userID:(NSString*)userID
                sim:(NSString*)sim
                lon:(NSString *)lon
                lat:(NSString *)lat
         lastRpTime:(NSString *)lastRpTime;

/*!
 @method initCarDatabase
 @abstract 建表
 @discussion 建表
 @param 无
 @result 无
 */
- (void)initCarDatabase;

/*!
 @method updateCarData：
 @abstract 更新或者添加车辆数据
 @discussion 更新或者添加车辆数据
 @param 车辆数据
 @result 无
 */
- (void)updateCarData:(NSString*)keyID
                carID:(NSString*)carID
                  vin:(NSString*)vin
                 type:(NSString*)type
                 name:(NSString*)name
         carRegisCode:(NSString*)carRegisCode
            carNumber:(NSString*)carNumber
            motorCode:(NSString*)motorCode
               userID:(NSString*)userID
                  sim:(NSString*)sim
                  lon:(NSString *)lon
                  lat:(NSString *)lat
           lastRpTime:(NSString *)lastRpTime
              service:(NSString *)service;

/*!
 @method updateCarLocation：
 @abstract 根据userID和vin更新车辆位置信息
 @discussion 根据userID和vin更新车辆位置信息
 @param userid所属用户id
 @param vin 车辆vin号
 @param lon 经度
 @param lat 纬度
 @param lastRpTime位置上传时间
 @result 无
 */
-(void)updateCarLocation:(NSString *)userID
                     vin:(NSString *)vin
                     lon:(NSString *)lon
                     lat:(NSString *)lat
              lastRpTime:(NSString *)lastRpTime;

/*!
 @method loadCarData：
 @abstract 根据userID和vin更新缓存中的车辆信息
 @discussion 根据userID和vin更新缓存中的车辆信息
 @param userid所属用户id
 @param vin 车辆vin号
 @result 无
 */
- (void)loadCarData:(NSString *)userID vin:(NSString *)vin;

/*!
 @method deleteCarWithUserID：
 @abstract 删除当前账户下的车辆信息
 @discussion 删除当前账户下的车辆信息
 @param userid所属用户id
 @result 无
 */
-(void)deleteCarWithUserID:(NSString *)userID;

/*!
 @method loadCarDataWithUserID：
 @abstract 获取当前账户下的车辆列表
 @discussion 获取当前账户下的车辆列表
 @param userid所属用户id
 @result carlist
 */
- (NSMutableArray*)loadCarDataWithUserID:(NSString *)userID;

/*!
 @method carExistWithUserID：vin:
 @abstract 根据userID和vin判断改车辆信息是否存在
 @discussion 根据userID和vin判断改车辆信息是否存在
 @param userid所属用户id
 @param vin 车辆vin号
 @result bool
 */
-(BOOL)carExistWithUserID:(NSString *)userID vin:(NSString *)vin;
@end
