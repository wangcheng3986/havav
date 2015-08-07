
/*!
 @header VehicleStatusInformMessageData.h
 @abstract 车辆远程监控表
 @author mengy
 @version 1.00 14-9-5 Creation
 */
#define TABLE_VEHICLE_STATUS_MESSAGE_DATA          @"VEHICLE_STATUS"
#import <Foundation/Foundation.h>
#import "UserData.h"
#import "MessageInfoData.h"
#import <Foundation/Foundation.h>

@interface VehicleStatusInformMessageData : NSObject
//1	KEYID	主键	VARCHAR2(32)	否	唯一
//2	VIN	远程监控目标车辆车架号	VARCHAR2(32)	否	0：车门异常打开；1：TBox报警		vin
//3	SEND_TIME	远程监控请求发送时间	VARCHAR2(16)	否			sendTime
//4	RESULT_CODE	远程监控结果码	CHAR(1)	否	0：远程监控成功；1：远程监控失败		resultCode
//5	RESULT_MSG	远程监控错误提示	VARCHAR2(256)				resultMsg
//6	UPLOAD_TIME	车辆状况上传时间	VARCHAR2(16)				uploadTime
//7	RECEIVE_TIME	收到监控结果时间	VARCHAR2(16)	否
//8	LON	车辆位置经度	DOUBLE (16)				lon
//9	LAT	车辆位置纬度	DOUBLE (16)				lat
//10	SPEED	车辆速度，单位：公里/每小时	VARCHAR2(16)				speed
//11	DIRECTION	车辆方向，单位：度	VARCHAR2(16)		与正北方向夹角:0 – 360		direction
//12	MILEAGE	车辆行驶里程，单位：公里	VARCHAR2(16)				mileage
//13	FUEL_LEVEL	剩余油量，单位：升（L）	VARCHAR2(16)				fuelLevel
//14	FUEL_LEVEL_STATE	油量状态	VARCHAR2(16)		0：正常；1：异常
//15	FUEL_CONSUMPTION	油耗，单位：升/百公里（L/100km）	VARCHAR2(16)				fuelConsumption
//16	FL_TIRE_PRESSURE	左前轮胎胎压，单位：千帕	VARCHAR2(16)				FLTirePressure
//17	FL_TIRE_PRESSURE_STATE	左前胎压状态	VARCHAR2(16)		0：正常；1：异常
//18	FR_TIRE_PRESSURE	右前轮胎胎压	VARCHAR2(16)				FRTirePressure
//19	FR_TIRE_PRESSURE_STATE	右前胎压状态	VARCHAR2(16)		0：正常；1：异常
//20	RL_TIRE_PRESSURE	左后轮胎胎压	VARCHAR2(16)				RLTirePressure
//21	RL_TIRE_PRESSURE_STATE	左后胎压状态	VARCHAR2(16)		0：正常；1：异常
//22	RR_TIRE_PRESSURE	右后轮胎胎压	VARCHAR2(16)				RRTirePressure
//23	RR_TIRE_PRESSURE_STATE	右后胎压状态	VARCHAR2(16)		0：正常；1：异常
//24	DRIVER_DOOR_STS	主驾驶车门是否开启	CHAR(1)		0：关；1：开		driverDoorSts
//25	PASSENGER_DOOR_STS	副驾驶车门是否开启	CHAR(1)		0：关；1：开		passengerDoorSts
//26	RL_DOOR_STS	左后车门是否开启	CHAR(1)		0：关；1：开		RLDoorSts
//27	RR_DOOR_STS	右后车门是否开启	CHAR(1)		0：关；1：开		RRDoorSts
//28	HOOD_STS	机舱盖是否开启	CHAR(1)		0：关；1：开		hoodSts
//29	TRUNK_STS	后备箱是否开启	CHAR(1)		0：关；1：开		trunkSts
//30	BEAM_STS	大灯状态	CHAR(1)		0：关；1：开		beamSts
//31	CBN_TEMP	车内温度	VARCHAR2(16)				cbnTemp
//32	CDNG_OFF	空调是否关闭	CHAR(1)		0：关；1：开		cdngOff
//33	USER_KEYID	关联用户ID	VARCHAR2(32)	否	唯一
@property(nonatomic,copy)NSString *mKeyid;
@property(nonatomic,copy)NSString *mVin;
@property(nonatomic,copy)NSString *mSendTime;
@property(nonatomic,copy)NSString *mResultCode;
@property(nonatomic,copy)NSString *mResultMsg;
@property(nonatomic,copy)NSString *mUploadTime;
@property(nonatomic,copy)NSString *mReceiveTime;
@property(assign)double mLon;
@property(assign)double mLat;
@property(nonatomic,copy)NSString *mSpeed;
@property(nonatomic,copy)NSString *mDirection;
@property(nonatomic,copy)NSString *mMileage;
@property(nonatomic,copy)NSString *mFuelLevel;
@property(nonatomic,copy)NSString *mFuelLevelState;
@property(nonatomic,copy)NSString *mFuelConsumption;
@property(nonatomic,copy)NSString *mFlTirePressure;
@property(nonatomic,copy)NSString *mFrTirePressure;
@property(nonatomic,copy)NSString *mRlTirePressure;
@property(nonatomic,copy)NSString *mRrTirePressure;
@property(nonatomic,copy)NSString *mFlTirePressureState;
@property(nonatomic,copy)NSString *mFrTirePressureState;
@property(nonatomic,copy)NSString *mRlTirePressureState;
@property(nonatomic,copy)NSString *mRrTirePressureState;
@property(nonatomic,copy)NSString *mDriverDoorSts;
@property(nonatomic,copy)NSString *mPassengerDoorSts;
@property(nonatomic,copy)NSString *mRlDoorSts;
@property(nonatomic,copy)NSString *mRrDoorSts;
@property(nonatomic,copy)NSString *mHoodSts;
@property(nonatomic,copy)NSString *mTrunkSts;
@property(nonatomic,copy)NSString *mBeamSts;
@property(nonatomic,copy)NSString *mCbnTemp;
@property(nonatomic,copy)NSString *mCdngOff;
@property(nonatomic,copy)NSString *mUserKeyID;

/*!
 @method initVehicleStatusMessageDatabase
 @abstract 建表
 @discussion 建表
 @param 无
 @result 无
 */
- (void)initVehicleStatusMessageDatabase;

/*!
 @method loadVehicleStatusByVin：
 @abstract 根据vin加载车辆状态
 @discussion 根据vin加载车辆状态
 @param vin 车架号
 @result VehicleStatusInformMessageData 车辆状况信息
 */
- (VehicleStatusInformMessageData *)loadVehicleStatusByVin:(NSString *)vin;

/*!
 -(void)deleteVehicleStatusWithVin:vin
 @abstract 删除某个用户下的车辆状态
 @discussion 删除某个用户下的车辆状态
 @param vin 车架号
 @result 无
 */
-(void)deleteVehicleStatusWithVin:vin;
@end
