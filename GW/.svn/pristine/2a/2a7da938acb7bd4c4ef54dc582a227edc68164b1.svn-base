
/*!
 @header NIDemoData.m
 @abstract 加载demo数据
 @author 王 立琼
 @version 1.00 13-7-3 Creation
 */

#import "NIDemoData.h"
#import <sqlite3.h>
#import "App.h"
/*!
 @class
 @abstract 加载demo数据。
 */
@implementation NIDemoData

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
 @method loadDemoDatabase
 @abstract 通过执行sql语句加载demo数据
 @discussion 通过执行sql语句加载demo数据
 @param 无
 @result 无
 */
- (void)loadDemoDatabase
{
    sqlite3 *database = [self openDatabase];
    if(database)
    {
       // NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        NSDate *date = [NSDate date];
        NSTimeInterval timeStr = [date timeIntervalSince1970]*1000;
        double itime = roundf(timeStr);
        NSString *cTimeStr = [NSString stringWithFormat:@"%f",itime];
       // [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
       // NSString *timeStr= [dateFormatter stringFromDate:date];
       // [dateFormatter release];
        NSArray *sqlArray = [[NSArray alloc] initWithObjects:
//                              demo用户信息
                              [NSString stringWithFormat:@"INSERT INTO USER(KEYID,USER_ID,VEHICLE_VIN,FLAG,PASSWORD,SAFE_PWD,USER_TYPE,ACCOUNT)VALUES('%@','demo_admin','demo_vin','0','123456','123456','%d','demo_admin')",[App createUUID],USER_LOGIN_DEMO],
//                              新车友demo数据
                              [NSString stringWithFormat:@"INSERT INTO FRIEND(KEYID,ID,NAME,PHONE,CREATE_TIME,LAST_UPDATE,LON,LAT,LAST_RQ_TIME,USER_KEYID,SEND_LOCATION_REQUEST_TIME,FRIEND_USER_ID,POI_NAME,POI_ADDRESS,PINYIN)VALUES('%@','%@','自己','15910838083','%@','%@','%f','%f','2013-08-13 12:19:01','demo_admin','','demo_self','车辆位置','北京市西城区宣武门外东大街8号','')",[App createUUID],DEMO_LOGINID,[App getTimeSince1970_1000],[App getTimeSince1970_1000],MAP_DEFAULT_LPP_LON,MAP_DEFAULT_LPP_LAT],
//                             KEYID,ID,NAME,PHONE,USER_KEYID,LON,LAT,LAST_RQ_TIME,LAST_UPDATE,SEND_LOCATION_REQUEST_TIME,CREATE_TIME,INITIAL,FRIEND_USER_ID,POI_NAME,POI_ADDRESS
                              [NSString stringWithFormat:@"INSERT INTO FRIEND(KEYID,ID,NAME,PHONE,CREATE_TIME,LAST_UPDATE,LON,LAT,LAST_RQ_TIME,USER_KEYID,SEND_LOCATION_REQUEST_TIME,FRIEND_USER_ID,POI_NAME,POI_ADDRESS,PINYIN)VALUES('%@','demo_friend_1','王五','15910838084','%@','%@','116.38','39.90','2013-08-15 11:09:11','demo_admin','','demo_friend_1','车辆位置','北京市西城区宣武门外东大街8号','wangwu')",[App createUUID],[App getTimeSince1970_1000],[App getTimeSince1970_1000]],
                              [NSString stringWithFormat:@"INSERT INTO FRIEND(KEYID,ID,NAME,PHONE,CREATE_TIME,LAST_UPDATE,LON,LAT,LAST_RQ_TIME,USER_KEYID,SEND_LOCATION_REQUEST_TIME,FRIEND_USER_ID,POI_NAME,POI_ADDRESS,PINYIN)VALUES('%@','demo_friend_2','刘一','15910838085','%@','%@','116.38','39.90','2013-08-15 11:09:11','demo_admin','','demo_friend_2','车辆位置','北京市西城区宣武门外东大街8号','liuyi')",[App createUUID],[App getTimeSince1970_1000],[App getTimeSince1970_1000]],
//                              新黑名单demo数据
                              [NSString stringWithFormat:@"INSERT INTO BLACK(KEYID,ID,NAME,MOBILE,CREATE_TIME,LAST_UPDATE,USER_KEYID,PINYIN)VALUES('%@','demo_black_1','王黑五','15910838086','%@','%@','demo_admin','wangheiwu')",[App createUUID],[App getTimeSince1970_1000],[App getTimeSince1970_1000]],
                              [NSString stringWithFormat:@"INSERT INTO BLACK(KEYID,ID,NAME,MOBILE,CREATE_TIME,LAST_UPDATE,USER_KEYID,PINYIN)VALUES('%@','demo_black_2','刘黑一','15910838087','%@','%@','demo_admin','liuheiyi')",[App createUUID],[App getTimeSince1970_1000],[App getTimeSince1970_1000]],
//                             电子围栏
                             [NSString stringWithFormat:@"INSERT INTO ELECFENCE(KEYID,ID,NAME,LAST_UPDATE,VALID,LON,LAT,RADIUS,DESCRIPTION,ADDRESS,VIN,USER_KEYID)VALUES('%@','123456','%@','2014-09-05 08:08:08','1','116.111','40.123','100','目前没有描述','沈阳市沈河区卓越大厦四维图新','demo_vin','demo_admin')",[App createUUID],[App getSystemLastTime]],
                             [NSString stringWithFormat:@"INSERT INTO ELECFENCE(KEYID,ID,NAME,LAST_UPDATE,VALID,LON,LAT,RADIUS,DESCRIPTION,ADDRESS,VIN,USER_KEYID)VALUES('%@','333444','%@','2014-09-06 08:08:08','0','117.999','41.999','200','目前没有描述','北京市四维图新','demo_vin','demo_admin')",[App createUUID],[App getSystemLastTime]],
                              
//                              车辆表demo数据
                              [NSString stringWithFormat:@"INSERT INTO VEHICLE(KEYID,CAR_ID,VIN,V_TYPE,NAME,CAR_NUMBER,MOTOR_CODE,CAR_REGIS_CODE,USER_ID,SIM,LON,LAT,LAST_RP_TIME,SERVICE_TYPE)VALUES('%@','demo_car_id_1','demo_vin','1','哈佛H6白色','体验车辆','demo_motor_code_1','demo_car_regis_code_1','demo_admin','13591990526','%f','%f','2013-08-15 11:09:11','1')",[App createUUID],MAP_DEFAULT_LPP_LON,MAP_DEFAULT_LPP_LAT],
//                             消息主表demo数据
                             
                             [NSString stringWithFormat:@"INSERT INTO MESSAGE_INFO(KEYID,ID,TYPE,CREATE_TIME,STATUS,VEHICLE_VIN,USER_ID) VALUES('1','demo_message1',%d,'2014-09-11 11:22:30',0,'demo_vin','demo_admin')",MESSAGE_FRIEND_REQUEST_LOCATION],
                             [NSString stringWithFormat:@"INSERT INTO MESSAGE_INFO(KEYID,ID,TYPE,CREATE_TIME,STATUS,VEHICLE_VIN,USER_ID) VALUES('2','demo_message2',%d,'2014-09-11 11:22:30',0,'demo_vin','demo_admin')",MESSAGE_FRIEND_LOCATION],
                             [NSString stringWithFormat:@"INSERT INTO MESSAGE_INFO(KEYID,ID,TYPE,CREATE_TIME,STATUS,VEHICLE_VIN,USER_ID) VALUES('3','demo_message3',%d,'2014-09-11 11:22:30',0,'demo_vin','demo_admin')",MESSAGE_SEND_TO_CAR],
                             [NSString stringWithFormat:@"INSERT INTO MESSAGE_INFO(KEYID,ID,TYPE,CREATE_TIME,STATUS,VEHICLE_VIN,USER_ID) VALUES('4','demo_message4',%d,'2014-09-11 11:22:30',0,'demo_vin','demo_admin')",MESSAGE_ELECTRONIC],
                             [NSString stringWithFormat:@"INSERT INTO MESSAGE_INFO(KEYID,ID,TYPE,CREATE_TIME,STATUS,VEHICLE_VIN,USER_ID) VALUES('5','demo_message5',%d,'2014-09-11 11:22:30',0,'demo_vin','demo_admin')",MESSAGE_VEHICLE_CONTROL],
                             [NSString stringWithFormat:@"INSERT INTO MESSAGE_INFO(KEYID,ID,TYPE,CREATE_TIME,STATUS,VEHICLE_VIN,USER_ID) VALUES('6','demo_message6',%d,'2014-09-11 11:22:30',0,'demo_vin','demo_admin')",MESSAGE_VEHICLE_DIAGNOSIS],
                             [NSString stringWithFormat:@"INSERT INTO MESSAGE_INFO(KEYID,ID,TYPE,CREATE_TIME,STATUS,VEHICLE_VIN,USER_ID) VALUES('7','demo_message7',%d,'2014-09-11 11:22:30',0,'demo_vin','demo_admin')",MESSAGE_VEHICLE_ABNORMAL_ALARM],
                             [NSString stringWithFormat:@"INSERT INTO MESSAGE_INFO(KEYID,ID,TYPE,CREATE_TIME,STATUS,VEHICLE_VIN,USER_ID) VALUES('8','demo_message8',%d,'2014-09-11 11:22:30',0,'demo_vin','demo_admin')",MESSAGE_MAINTENANCE_ALARM],
                              
//                              位置请求消息
                              
                              @"INSERT INTO MESSAGE_FRIEND_REQUEST_LOCATION(KEYID,REQ_UID,REQUEST_USER_ID, REQUEST_USER_NAME, REQUEST_USER_TEL, REQUEST_TIME,DESCRIPTION, RP_STATE, RP_TIME, MESSAGE_KEYID) VALUES('1','demo_REQ_UID','demo_friend_2','刘一','15910838085','1410405738000','告诉我你在哪，我去找你','0','','1')",
                              
//                              车友位置消息
                              
                              @"INSERT INTO MESSAGE_FRIEND_LOCATION(KEYID,SEND_TIME,FRIEND_USER_ID,FRIEND_USER_NAME,FRIEND_USER_TEL,RESPONSE_TIME,UPLOAD_TIME,LON, LAT,POI_NAME,POI_ADDRESS,LICENSE_NUMBER, MESSAGE_KEYID) VALUES('2','1410405738000','demo_friend_2','刘一','15910838085','1410405748000','1410405728000','116.38','39.90','车辆位置','北京市西城区宣武门外东大街8号','体验车辆','2')",
                             
                             
                             //                              发送到车消息
                             @"INSERT INTO MESSAGE_SEND_TO_CAR(KEYID,SENDER_USER_ID,SENDER_USER_NAME,SENDER_USER_TEL,SEND_TIME,LON,LAT,POI_NAME,POI_ADDRESS,POI_ID,EVENT_TIME,EVENT_CONTENT,MESSAGE_KEYID) VALUES('3','demo_friend_1','王五','15910838084','1410405738000','116.38','39.90','车辆位置','北京市西城区宣武门外东大街8号','demo_POI_ID','1410405838000','来这里集合','3')",
                             
                             //                             电子围栏demo数据
                             @"INSERT INTO MESSAGE_ELECTRONIC_FENC(KEYID,ALARM_TYPE,ALARM_TIME,ELECFENCE_ID,ELECFENCE_NAME,RADIUS,ELECFENCE_LON,ELECFENCE_LAT,LON,LAT,SPEED,DIRECTION,ADDRESS,DESCRIPTION,MESSAGE_KEYID) VALUES('4','0','1410405738000','123456','目前是假数据','15',116.111,40.123, 116.460370 , 39.832670 ,'50','35','北京市东城区西花市南里东区4号','体验车辆在北京市东城区西花市南里东区4号位置发生进入围栏报警。','4')",
//                                                             车辆控制消息
                             @"INSERT INTO MESSAGE_VEHICLE_CONTROL(KEYID,SEND_TIME,CMD_CODE,RESULT_CODE,RESULT_MSG,MESSAGE_KEYID) VALUES('5','1410405738000','5','0','指令执行成功','5')",
//                                                            车辆故障诊断
                             @"INSERT INTO MESSAGE_DIAGNOSIS_REPORT(KEYID,REPORT_ID,REPORT_TYPE,SEND_TIME,CHECK_RESULT,CHECK_TIME,MESSAGE_KEYID) VALUES('6','demo_report_id','0','1410405728000','0','1410405738000','6')",
                             
                             @"INSERT INTO MESSAGE_DIAGNOSIS_REPORT_FAULT_ITEM(KEYID,REPORT_ID,CHECK_ITEM_TYPE,CHECK_ITEM_TYPE_NAME,FAULT_ITEM_ID,FAULT_ITEM_NAME,FAULT_ITEM_DESC,FAULT_CREATE_TIME) VALUES('demo_report_fault_id1','demo_report_id','1','发动机/变速器系统','','','','')",
                             @"INSERT INTO MESSAGE_DIAGNOSIS_REPORT_FAULT_ITEM(KEYID,REPORT_ID,CHECK_ITEM_TYPE,CHECK_ITEM_TYPE_NAME,FAULT_ITEM_ID,FAULT_ITEM_NAME,FAULT_ITEM_DESC,FAULT_CREATE_TIME) VALUES('demo_report_fault_id2','demo_report_id','2','排放系统','','','','')",
                             @"INSERT INTO MESSAGE_DIAGNOSIS_REPORT_FAULT_ITEM(KEYID,REPORT_ID,CHECK_ITEM_TYPE,CHECK_ITEM_TYPE_NAME,FAULT_ITEM_ID,FAULT_ITEM_NAME,FAULT_ITEM_DESC,FAULT_CREATE_TIME) VALUES('demo_report_fault_id3','demo_report_id','3','安全气囊系统','','','','')",
                             @"INSERT INTO MESSAGE_DIAGNOSIS_REPORT_FAULT_ITEM(KEYID,REPORT_ID,CHECK_ITEM_TYPE,CHECK_ITEM_TYPE_NAME,FAULT_ITEM_ID,FAULT_ITEM_NAME,FAULT_ITEM_DESC,FAULT_CREATE_TIME) VALUES('demo_report_fault_id4','demo_report_id','4','车身稳定控制系统','','','','')",
                             @"INSERT INTO MESSAGE_DIAGNOSIS_REPORT_FAULT_ITEM(KEYID,REPORT_ID,CHECK_ITEM_TYPE,CHECK_ITEM_TYPE_NAME,FAULT_ITEM_ID,FAULT_ITEM_NAME,FAULT_ITEM_DESC,FAULT_CREATE_TIME) VALUES('demo_report_fault_id5','demo_report_id','5','制动防抱死系统','','','','')",
                             @"INSERT INTO MESSAGE_DIAGNOSIS_REPORT_FAULT_ITEM(KEYID,REPORT_ID,CHECK_ITEM_TYPE,CHECK_ITEM_TYPE_NAME,FAULT_ITEM_ID,FAULT_ITEM_NAME,FAULT_ITEM_DESC,FAULT_CREATE_TIME) VALUES('demo_report_fault_id6','demo_report_id','6','车联网系统','','','','')",
                             @"INSERT INTO MESSAGE_DIAGNOSIS_REPORT_FAULT_ITEM(KEYID,REPORT_ID,CHECK_ITEM_TYPE,CHECK_ITEM_TYPE_NAME,FAULT_ITEM_ID,FAULT_ITEM_NAME,FAULT_ITEM_DESC,FAULT_CREATE_TIME) VALUES('demo_report_fault_id7','demo_report_id','7','车辆维护','','','','')",
                             
                             /**
                             @"INSERT INTO MESSAGE_DIAGNOSIS_REPORT_FAULT_ITEM(KEYID,REPORT_ID,CHECK_ITEM_TYPE,CHECK_ITEM_TYPE_NAME,FAULT_ITEM_ID,FAULT_ITEM_NAME,FAULT_ITEM_DESC,FAULT_CREATE_TIME) VALUES('demo_report_fault_id1','demo_report_id','1','发动机/变速器系统','demo_report_fault_id1','排气管','堵塞','1410405728000')",
                             @"INSERT INTO MESSAGE_DIAGNOSIS_REPORT_FAULT_ITEM(KEYID,REPORT_ID,CHECK_ITEM_TYPE,CHECK_ITEM_TYPE_NAME,FAULT_ITEM_ID,FAULT_ITEM_NAME,FAULT_ITEM_DESC,FAULT_CREATE_TIME) VALUES('demo_report_fault_id2','demo_report_id','1','发动机/变速器系统','demo_report_fault_id2','PEPS的电源继电器','机油过低','1410405728000')",
                             @"INSERT INTO MESSAGE_DIAGNOSIS_REPORT_FAULT_ITEM(KEYID,REPORT_ID,CHECK_ITEM_TYPE,CHECK_ITEM_TYPE_NAME,FAULT_ITEM_ID,FAULT_ITEM_NAME,FAULT_ITEM_DESC,FAULT_CREATE_TIME) VALUES('demo_report_fault_id3','demo_report_id','1','发动机/变速器系统','demo_report_fault_id3','发动机','温度过高','1410405728000')",
                             @"INSERT INTO MESSAGE_DIAGNOSIS_REPORT_FAULT_ITEM(KEYID,REPORT_ID,CHECK_ITEM_TYPE,CHECK_ITEM_TYPE_NAME,FAULT_ITEM_ID,FAULT_ITEM_NAME,FAULT_ITEM_DESC,FAULT_CREATE_TIME) VALUES('demo_report_fault_id4','demo_report_id','2','排放系统','demo_report_fault_id4','1111','11111','1410405728000')",
                             @"INSERT INTO MESSAGE_DIAGNOSIS_REPORT_FAULT_ITEM(KEYID,REPORT_ID,CHECK_ITEM_TYPE,CHECK_ITEM_TYPE_NAME,FAULT_ITEM_ID,FAULT_ITEM_NAME,FAULT_ITEM_DESC,FAULT_CREATE_TIME) VALUES('demo_report_fault_id5','demo_report_id','2','排放系统','demo_report_fault_id5','2222','22222','1410405728000')",
                             @"INSERT INTO MESSAGE_DIAGNOSIS_REPORT_FAULT_ITEM(KEYID,REPORT_ID,CHECK_ITEM_TYPE,CHECK_ITEM_TYPE_NAME,FAULT_ITEM_ID,FAULT_ITEM_NAME,FAULT_ITEM_DESC,FAULT_CREATE_TIME) VALUES('demo_report_fault_id6','demo_report_id','3','安全气囊系统','demo_report_fault_id6','1111','11111','1410405728000')",
                             @"INSERT INTO MESSAGE_DIAGNOSIS_REPORT_FAULT_ITEM(KEYID,REPORT_ID,CHECK_ITEM_TYPE,CHECK_ITEM_TYPE_NAME,FAULT_ITEM_ID,FAULT_ITEM_NAME,FAULT_ITEM_DESC,FAULT_CREATE_TIME) VALUES('demo_report_fault_id7','demo_report_id','4','车身稳定控制系统','demo_report_fault_id7','1111','11111','1410405728000')",
                             @"INSERT INTO MESSAGE_DIAGNOSIS_REPORT_FAULT_ITEM(KEYID,REPORT_ID,CHECK_ITEM_TYPE,CHECK_ITEM_TYPE_NAME,FAULT_ITEM_ID,FAULT_ITEM_NAME,FAULT_ITEM_DESC,FAULT_CREATE_TIME) VALUES('demo_report_fault_id8','demo_report_id','5','制动防抱死系统','demo_report_fault_id8','1111','11111','1410405728000')",
                             @"INSERT INTO MESSAGE_DIAGNOSIS_REPORT_FAULT_ITEM(KEYID,REPORT_ID,CHECK_ITEM_TYPE,CHECK_ITEM_TYPE_NAME,FAULT_ITEM_ID,FAULT_ITEM_NAME,FAULT_ITEM_DESC,FAULT_CREATE_TIME) VALUES('demo_report_fault_id9','demo_report_id','6','车联网系统','demo_report_fault_id9','1111','11111','1410405728000')",
                             @"INSERT INTO MESSAGE_DIAGNOSIS_REPORT_FAULT_ITEM(KEYID,REPORT_ID,CHECK_ITEM_TYPE,CHECK_ITEM_TYPE_NAME,FAULT_ITEM_ID,FAULT_ITEM_NAME,FAULT_ITEM_DESC,FAULT_CREATE_TIME) VALUES('demo_report_fault_id10','demo_report_id','7','车辆维护','','','','')",
                              */
                             //                             车辆异常报警消息
                             @"INSERT INTO MESSAGE_VEHICLE_ABNORMAL_ALARM(KEYID,ALARM_TYPE,ALARM_TIME,LON,LAT,SPEED,DIRECTION,ADDRESS,MESSAGE_KEYID) VALUES('7','0','1410405738000',116.460370,39.832670,'50','35','北京市朝阳区','7')",
                             //保养提醒消息
                             @"INSERT INTO MESSAGE_MAINTENANCE_ALERT(KEYID,MAINTAIN_TIME,MAINTAIN_MILEAGE,MAINTAIN_ITEMS,DESCRIPTION,MESSAGE_KEYID) VALUES('8','1410405738000','4000','机油，滤芯','您的车辆已经行驶了3500公里，离本次保养公里数还有500公里。','8')",
//                             车辆状态demo数据
//                              [NSString stringWithFormat: @"INSERT INTO VEHICLE_STATUS(KEYID,VIN,SEND_TIME,RESULT_CODE,RESULT_MSG,UPLOAD_TIME,RECEIVE_TIME,LON,LAT,SPEED,DIRECTION,MILEAGE,FUEL_LEVEL,FUEL_CONSUMPTION,FL_TIRE_PRESSURE,FR_TIRE_PRESSURE,RL_TIRE_PRESSURE,RR_TIRE_PRESSURE,DRIVER_DOOR_STS,PASSENGER_DOOR_STS,RL_DOOR_STS,RR_DOOR_STS,HOOD_STS,TRUNK_STS,BEAM_STS,CBN_TEMP,CDNG_OFF) VALUES('8','demo_vin','1410405738000','1','','%@','1410405748000',116.460370,39.832670,'50','35','3500','1.5','9.6','2.2','2.2','2.3','2.3','0','0','1','0','0','0','1','25','0')",cTimeStr]
//                            ,
                             [NSString stringWithFormat:@"INSERT INTO VEHICLE_STATUS(KEYID,VIN,SEND_TIME,RESULT_CODE,RESULT_MSG,UPLOAD_TIME,RECEIVE_TIME,LON,LAT,SPEED,DIRECTION,MILEAGE,FUEL_LEVEL,FUEL_LEVEL_STATE,FUEL_CONSUMPTION,FL_TIRE_PRESSURE,FL_TIRE_PRESSURE_STATE,FR_TIRE_PRESSURE,FR_TIRE_PRESSURE_STATE,RL_TIRE_PRESSURE,RL_TIRE_PRESSURE_STATE,RR_TIRE_PRESSURE,RR_TIRE_PRESSURE_STATE,DRIVER_DOOR_STS,PASSENGER_DOOR_STS,RL_DOOR_STS,RR_DOOR_STS,HOOD_STS,TRUNK_STS,BEAM_STS,CBN_TEMP,CDNG_OFF,USER_KEYID) VALUES('9','demo_vin','1410405738000','1','','%@','1410405748000',116.460370,39.832670,'50','35','3500','1.5','0','9.6','2.2','0','2.2','0','2.3','0','2.3','0','0','0','1','0','0','0','1','25','0','demo_admin')",[App getTimeSince1970_1000]]
                             ,
                             
//                             收藏夹demo数据
                             
                             
                             [NSString stringWithFormat:@"INSERT INTO POI_FAVORITES(KEYID,FPOIID,POIID,NAME,CREATE_TIME,LON,LAT,PHONE,ADDRESS,DESC,FLAG,POST_CODE,LEVEL,USER_ID) VALUES('demo_fpoi_favorites_1','demo_fpoi_favorites_1','demo_poi_favorites_1','天安门','1410405738000','116.388174','39.904687','862655511','北京市长安街1号','','%d','110011','0','demo_admin')",COLLECT_SYNC_YES],
                             [NSString stringWithFormat:@"INSERT INTO POI_FAVORITES(KEYID,FPOIID,POIID,NAME,CREATE_TIME,LON,LAT,PHONE,ADDRESS,DESC,FLAG,POST_CODE,LEVEL,USER_ID) VALUES('demo_fpoi_favorites_2','demo_fpoi_favorites_2','demo_poi_favorites_2','长城','1410405738000','116.487174','39.904687','862655512','北京市八达岭街2号','','%d','110011','0','demo_admin')",COLLECT_SYNC_YES],
                             [NSString stringWithFormat:@"INSERT INTO POI_FAVORITES(KEYID,FPOIID,POIID,NAME,CREATE_TIME,LON,LAT,PHONE,ADDRESS,DESC,FLAG,POST_CODE,LEVEL,USER_ID) VALUES('demo_fpoi_favorites_3','demo_fpoi_favorites_3','demo_poi_favorites_3','刘少奇故居','1410405738000','116.387174','39.954687','862655513','北京市解放路3号','','%d','110011','0','demo_admin')",COLLECT_SYNC_YES],
                             
                             nil];
                            

        //遍历数组，把所有写好的sql语句都执行一遍
        for (NSString *sql in sqlArray)
        {
            NSLog(@"%@",sql);
            sqlite3_stmt *stmt;
            int result = sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) ;
            if(result== SQLITE_OK)
            {
                NSLog(@"adding DEMO data.");
//                NSLog(@"%d",sqlite3_step(stmt));
                if(sqlite3_step(stmt) != SQLITE_DONE)
                {
                    NSLog(@"add DEMO data Error.");
                }
            }
            else
            {
                NSAssert1(0,@"Error:%s",sqlite3_errmsg(database));
            }
            sqlite3_reset(stmt);
            sqlite3_finalize(stmt);
        }
        if (sqlArray) {
            [sqlArray release];
            sqlArray = nil;
        }
        
        sqlite3_close(database);
    }
}


@end
