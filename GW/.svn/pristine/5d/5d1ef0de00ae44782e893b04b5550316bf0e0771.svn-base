/*!
 @header NIMessagePoll.m
 @abstract 发送到车消息类
 @author 王 立琼
 @version 1.00 13-7-16 Creation
 */
#import "NIMessagePoll.h"
#import "NSString+Extensions.h"
#import <AudioToolbox/AudioToolbox.h>
@implementation NIMessagePoll

//@synthesize mLastReqTime;

/*!
 @method init
 @abstract 初始化数据
 @discussion 初始化数据
 @param 无
 @result self
 */
- (id)init
{
    self = [super init];
    mNotifications = [[NIGetNotificationsList alloc] init];
//    if (mLocationService==nil) {
//        mLocationService = [[NILocationService alloc]initWithLicense:nil userKey:nil];
//        mLocationService.delegate = self;
//    }
    if (frindLocationArray == nil) {
        frindLocationArray = [[NSMutableArray alloc]initWithCapacity:0];
    }
    if (vehicleControlDic== nil) {
        vehicleControlDic = [[NSMutableDictionary alloc]initWithCapacity:0];
    }
    if (vehicleStatusArray== nil) {
        vehicleStatusArray = [[NSMutableArray alloc]initWithCapacity:0];
    }
    if (vehicleDiagnosisArray== nil) {
        vehicleDiagnosisArray = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return self;
}

- (void)dealloc
{
    [mLastReqTime release];
    [mTimer release];
    [mNotifications release];
//    [mLocationService release];
    if (frindLocationArray) {
        [frindLocationArray removeAllObjects];
        [frindLocationArray release];
        frindLocationArray = nil;
    }
    if (vehicleControlDic) {
        [vehicleControlDic removeAllObjects];
        [vehicleControlDic release];
        vehicleControlDic = nil;
    }
    if (vehicleStatusArray) {
        [vehicleStatusArray removeAllObjects];
        [vehicleStatusArray release];
        vehicleStatusArray = nil;
    }
    if (vehicleDiagnosisArray) {
        [vehicleDiagnosisArray removeAllObjects];
        [vehicleDiagnosisArray release];
        vehicleDiagnosisArray = nil;
    }
    [super dealloc];
}

/*!
 @method start
 @abstract 开始消息轮询
 @discussion 开始消息轮询
 @param 无
 @result 无
 */
- (void)start
{
    App *app = [App getInstance];
    if (mLastReqTime)
    {
        [mLastReqTime release];
    }
    mLastReqTime = [[NSString alloc] initWithString: app.mUserData.mLastReqTime];
    if (!mTimer) {
        mTimer=[NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(handleTime:) userInfo:nil repeats:YES];
        [mTimer fire];
        
    }
    
}
/*!
 @method stop
 @abstract 停止消息轮询
 @discussion 停止消息轮询
 @param 无
 @result 无
 */
- (void)stop
{
    if ([mTimer isValid]) {
        NSLog(@"取消定时器！！");
        
        [mTimer invalidate];
        //这行代码很关键
        mTimer=nil;
    }
}

/*!
 @method handleTime：
 @abstract 进行网络请求
 @discussion 进行网络请求
 @param 无
 @result 无
 */
-(void)handleTime:(id)sender
{
    NSLog(@"执行了NSTimer");
    
    //本地数据库中会记录LastReqTime但是，这个类当中同样缓存了LastReqTime，所以无需反复访问数据库来得到LastReqTime
    
    if ([mLastReqTime longLongValue] == 0 ) {
        App *app = [App getInstance];
        NSLog(@"the lastreqtime is %@",app.mUserData.mLastReqTime);
        [mNotifications createRequest:0 targetId:@"webccc" isNeedSrc:@"true"];//1369900796000是一个临时的值
        [mNotifications sendRequestWithAsync:self];
    }else
    {
        
        [mNotifications createRequest:[mLastReqTime longLongValue] targetId:@"webccc" isNeedSrc:@"true"];
        [mNotifications sendRequestWithAsync:self];
    }
    
    
}

/*!
 @method getMessage
 @abstract 获取消息
 @discussion 获取消息
 @param 无
 @result 无
 */
-(void)getMessage
{
    NSLog(@"------>获取消息");
    [mNotifications createRequest:0 targetId:@"webccc" isNeedSrc:@"true"];
    [mNotifications sendRequestWithAsync:self];
}

/*!
 @method onGetListResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg
 @abstract 消息请求，回调函数
 @discussion 消息请求，回调函数，将消息存入本地数据库，并发通知
 @param result 返回数据
 @param code 返回码
 @param errorMsg 错误信息
 @result 无
 */
- (void)onGetListResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg
{
    NSLog(@"------>获取消息结束");
    NSLog(@"receive the result.");
    [frindLocationArray removeAllObjects];
    [vehicleControlDic removeAllObjects];
    [vehicleStatusArray removeAllObjects];
    [vehicleDiagnosisArray removeAllObjects];
    if (NAVINFO_RESULT_SUCCESS == code) {
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0 ];
        if (nil != result)
        {
            NSLog(@"result is :%@", result);
        }
        if ([[result objectForKey:@"c"] integerValue] ==0 ) {
            App *app = [App getInstance];
            Resources *oRes = [Resources getInstance];
            if ([result objectForKey:@"messageList"]) {
                NSArray *messages = [result objectForKey:@"messageList"];
                NSMutableArray *tempSql = [[[NSMutableArray alloc]initWithCapacity:0]autorelease];
                for (NSDictionary *dict in messages)
                {
                    switch ([[dict objectForKey:@"messageType"] integerValue])
                    {
                                                    //                        电子围栏消息，现取消
                        case MESSAGE_ELECTRONIC:
                        {
                             NSLog(@"receive the ElectronicFenceDetail message.");
                            
                             //保存到电子围栏表
                            NSDictionary *src = [dict objectForKey:@"messageData"];
                            
                            NSString *ID = @"";
                            if ([dict objectForKey:@"messageId"]) {
                                ID = [dict objectForKey:@"messageId"];
                            }
//                            1	vin	string	触发车辆vin号码	◎
//                            2	alarmType	string	围栏报警类型。0：入栏；1：出栏	◎
//                            3	alarmTime	time	围栏报警时间	◎
//                            4	elecFenceId	string	触发围栏ID	◎
//                            5	elecFenceName	string	触发围栏名称	◎
//                            6	elecFenceLon	double	触发时电子围栏中心点经度	◎
//                            7	elecFenceLat	double	触发时电子围栏中心点纬度	◎
//                            8	elecFenceRadius	int	触发时电子围栏半径	◎
//                            9	lon	double	车辆位置经度	◎
//                            11	lat	double	车辆位置纬度	◎
//                            12	speed	int	车辆速度	◎
//                            13	direction	int	车辆方向	◎
//                            15	description	string	报警详细说明
                            if (src) {
                                NSString *vin = @"";
                                NSString *alarmType = @"";
                                NSString *alarmTime = @"";
                                NSString *elecFenceId = @"";
                                NSString *elecFenceName = @"";
                                double elecFenceLon = 0;
                                double elecFenceLat = 0;
                                NSString *elecFenceRadius = @"";
                                double lon = 0;
                                double lat = 0;
                                NSString * speed = @"";
                                NSString *  direction = @"";
                                NSString *description = @"";
                                NSString *address = @"";
                                if ([src objectForKey:@"vin"]) {
                                    vin = [src objectForKey:@"vin"];
                                }
                                if ([src objectForKey:@"alarmType"]) {
                                    alarmType = [src objectForKey:@"alarmType"];
                                }
                                if ([src objectForKey:@"alarmTime"]) {
                                    alarmTime = [NSString stringWithFormat:@"%@",[src objectForKey:@"alarmTime"]];
                                }
                                if ([src objectForKey:@"elecFenceId"]) {
                                    elecFenceId = [src objectForKey:@"elecFenceId"];
                                }
                                if ([src objectForKey:@"elecFenceName"]) {
                                    elecFenceName = [src objectForKey:@"elecFenceName"];
                                }
                                if ([src objectForKey:@"elecFenceLon"]) {
                                    elecFenceLon = [[src objectForKey:@"elecFenceLon"] doubleValue];
                                }
                                if ([src objectForKey:@"elecFenceLat"]) {
                                    elecFenceLat = [[src objectForKey:@"elecFenceLat"]doubleValue];
                                }
                                if ([src objectForKey:@"elecFenceRadius"]) {
                                    elecFenceRadius = [src objectForKey:@"elecFenceRadius"];
                                }
                                if ([src objectForKey:@"description"]) {
                                    description = [src objectForKey:@"description"];
                                }
                                if ([src objectForKey:@"lon"]) {
                                    lon = [[src objectForKey:@"lon"]doubleValue];
                                }
                                if ([src objectForKey:@"lat"]) {
                                    lat = [[src objectForKey:@"lat"] doubleValue];
                                }
                                if ([src objectForKey:@"speed"]) {
                                    speed = [src objectForKey:@"speed"];
                                }
                                if ([src objectForKey:@"direction"]) {
                                    direction = [src objectForKey:@"direction"];
                                }
                                if ([src objectForKey:@"address"]) {
                                    address = [src objectForKey:@"address"];
                                    if ([App isNSNull:address]) {
                                        address = @"";
                                    }
                                }
                                NSString *uuid = [App createUUID];
                                NSString *sql=[NSString stringWithFormat:@"INSERT INTO %@(KEYID,ID,TYPE,CREATE_TIME,STATUS,VEHICLE_VIN,USER_ID) VALUES('%@','%@','%d','%@','%d','%@','%@')",TABLE_MESSAGE_INFO_DATA,uuid,ID,MESSAGE_ELECTRONIC,[App getSystemTime],MESSAGE_UNREAD,vin,app.mUserData.mUserID];
                                NSLog(@"%@",sql);
                                [tempSql addObject:sql];
                                sql=[NSString stringWithFormat:@"INSERT INTO %@(KEYID,ALARM_TYPE,ALARM_TIME,ELECFENCE_ID,ELECFENCE_NAME,RADIUS,ELECFENCE_LON,ELECFENCE_LAT,LON,LAT,SPEED,DIRECTION,ADDRESS,DESCRIPTION,MESSAGE_KEYID) VALUES('%@','%@','%@','%@','%@','%@',%f,%f,%f,%f,'%@','%@','%@','%@','%@')",TABLE_ELECTRONIC_FENCE_MESSAGE_DATA,uuid,alarmType,alarmTime,elecFenceId,[elecFenceName avoidSingleQuotesForSqLite],elecFenceRadius,elecFenceLon,elecFenceLat,lon,lat,speed,direction,[address avoidSingleQuotesForSqLite],[description avoidSingleQuotesForSqLite],uuid];
                                NSLog(@"%@",sql);
                                [tempSql addObject:sql];
                                
                            }
                        }
                             break;
                        case MESSAGE_SEND_TO_CAR:
                        {
                            //NSLog(@"receive the Send to car message.%@",dict);
//                            1	senderUserId	string	发送者用户id	◎
//                            2	senderUserName	string	发送者用户名称	◎
//                            3	senderUserTel	String	发送者用户手机号，用于添加黑名单或车友	◎
//                            4	sendTime	time	发送时间	◎
//                            5	lon	double	经度	◎
//                            6	lat	double	纬度	◎
//                            7	poiName	string	位置名称	◎
//                            8	poiId	string	四维永久poiId	
//                            9	poiAddress	string	位置地址	
//                            10	eventTime	time	日历事件提醒时间	
//                            11	eventContent	string	日历事件提醒内容
                            //保存到Send2Car表
                            NSDictionary *src = [dict objectForKey:@"messageData"];
                            
                            NSString *ID = @"";
                            if ([dict objectForKey:@"messageId"]) {
                                ID = [dict objectForKey:@"messageId"];
                            }
                            if (src) {
                                NSString *senderUserId = @"";
                                NSString *senderUserName = @"";
                                NSString *senderUserTel = @"";
                                NSString *sendTime = @"";
                                float lon = 0;
                                float lat = 0;
                                NSString *poiName = @"";
                                NSString *poiId = @"";
                                NSString *poiAddress = @"";
                                NSString *eventTime = @"";
                                NSString *eventContent = @"";
                                NSString *eventLocName = @"";
                                NSString *eventAddress = @"";
                                if ([src objectForKey:@"senderUserId"]) {
                                    senderUserId = [src objectForKey:@"senderUserId"];
                                }
                                if ([src objectForKey:@"lon"]) {
                                    lon = [[src objectForKey:@"lon"] doubleValue];
                                }
                                if ([src objectForKey:@"lat"]) {
                                    lat = [[src objectForKey:@"lat"] doubleValue];
                                }
                                if ([src objectForKey:@"sendTime"]) {
                                    sendTime = [NSString stringWithFormat:@"%@",[src objectForKey:@"sendTime"]];
                                    
                                }
                                if ([src objectForKey:@"eventTime"]) {
                                    eventTime = [NSString stringWithFormat:@"%@",[src objectForKey:@"eventTime"]];
                                }
                                if ([src objectForKey:@"senderUserName"]) {
                                    senderUserName = [src objectForKey:@"senderUserName"];
                                    senderUserName = [senderUserName avoidSingleQuotesForSqLite];
                                }
                                if ([src objectForKey:@"senderUserTel"]) {
                                    senderUserTel = [src objectForKey:@"senderUserTel"];
                                }
                                if ([src objectForKey:@"poiName"]) {
                                    poiName = [src objectForKey:@"poiName"];
                                    eventLocName = [src objectForKey:@"poiName"];
                                    if ([App isNSNull:poiName]) {
                                        poiName = @"";
                                        eventLocName = @"";
                                    }
                                    poiName = [poiName avoidSingleQuotesForSqLite];
                                }
                                
                                if ([src objectForKey:@"poiAddress"]) {
                                    poiAddress = [src objectForKey:@"poiAddress"];
                                    eventAddress = [src objectForKey:@"poiAddress"];
                                    if ([App isNSNull:poiAddress]) {
                                        poiAddress = @"";
                                        eventAddress = @"";
                                    }
                                    poiAddress = [poiAddress avoidSingleQuotesForSqLite];
                                }
                                if ([src objectForKey:@"poiId"]) {
                                    poiId = [src objectForKey:@"poiId"];
                                }
                                if ([src objectForKey:@"eventContent"]) {
                                    eventContent = [src objectForKey:@"eventContent"];
                                }
                                NSString *uuid = [App createUUID];
                                NSString *sql=[NSString stringWithFormat:@"INSERT INTO %@(KEYID,ID,TYPE,CREATE_TIME,STATUS,VEHICLE_VIN,USER_ID) VALUES('%@','%@','%d','%@','%d','','%@')",TABLE_MESSAGE_INFO_DATA,uuid,ID,MESSAGE_SEND_TO_CAR,[App getSystemTime],MESSAGE_UNREAD,app.mUserData.mUserID];
                                NSLog(@"%@",sql);
                                [tempSql addObject:sql];
//                                @"CREATE TABLE IF NOT EXISTS %@ (KEYID TEXT NOT NULL ,SENDER_USER_ID TEXT,SENDER_USER_NAME TEXT,SENDER_USER_TEL TEXT,SEND_TIME TEXT,LON DOUBLE ,LAT DOUBLE ,POI_NAME TEXT,POI_ADDRESS TEXT,POI_ID TEXT,EVENT_TIME TEXT,EVENT_CONTENT TEXT,MESSAGE_KEYID TEXT)",
                                sql=[NSString stringWithFormat:@"INSERT INTO %@(KEYID,SENDER_USER_ID,SENDER_USER_NAME,SENDER_USER_TEL,SEND_TIME,LON,LAT,POI_NAME,POI_ADDRESS,POI_ID,EVENT_TIME,EVENT_CONTENT,MESSAGE_KEYID) VALUES('%@','%@','%@','%@','%@','%f','%f','%@','%@','%@','%@','%@','%@')",TABLE_SEND_TO_CAR_MESSAGE_DATA,uuid,senderUserId,senderUserName,senderUserTel,sendTime,lon,lat,poiName,poiAddress,poiId,eventTime,[eventContent avoidSingleQuotesForSqLite],uuid];
                                NSLog(@"%@",sql);
                                [tempSql addObject:sql];
                                //eventTime
                                
                                //判断是否为提醒，并确定是否添加提醒事件
                                if ([src objectForKey:@"eventTime"])
                                {
                                    
                                    NSLog(@"the eventtime is %@", [src objectForKey:@"eventTime"]);
                                    NSDate *date = nil;
                                    
                                    date = [NSDate dateWithTimeIntervalSince1970:[eventTime doubleValue]/1000];
                                    NSString *eventMessage = nil;
                                    eventMessage=[NSString stringWithFormat:@"%@%@%@%@ %@%@",[oRes getText:@"map.sendToCarViewController.eventCentent"],eventLocName,[oRes getText:@"map.sendToCarViewController.eventCentent2"],eventAddress,[oRes getText:@"map.sendToCarViewController.eventCentent3"],eventContent];
                                    NSLog(@"date = %@",date);
                                    [self addEvent:date content:eventMessage];
                                }
                            }
                        }
                            break;
                        case MESSAGE_FRIEND_REQUEST_LOCATION:
                        {
//                            1	reqUID	string	位置请求事务id	◎
//                            2	requestUserId	string	请求者用户id	◎
//                            3	requestUserName	string	请求者名称	◎
//                            4	requestUserTel	String	请求者手机号，用于添加黑名单或车友	◎
//                            5	requestTime	time	请求时间	◎
//                            6	description	string	请求描述
                            //位置请求
                            NSLog(@"receive the Location request message.");
                            //保存到Location表
                            NSDictionary *src = [dict objectForKey:@"messageData"];
                            
                            NSString *ID = @"";
                            if ([dict objectForKey:@"messageId"]) {
                                ID = [dict objectForKey:@"messageId"];
                            }
                            if (src) {
                                NSString *reqUID = @"";
                                NSString *requestUserId = @"";
                                NSString *requestUserName = @"";
                                NSString *requestUserTel = @"";
                                NSString *requestTime = @"";
                                NSString *description = @"";
                                if ([src objectForKey:@"reqUID"]) {
                                    reqUID = [src objectForKey:@"reqUID"];
                                }
                                if ([src objectForKey:@"requestUserId"]) {
                                    requestUserId = [src objectForKey:@"requestUserId"];
                                }
                                if ([src objectForKey:@"requestUserName"]) {
                                    requestUserName = [src objectForKey:@"requestUserName"];
                                    requestUserName = [requestUserName avoidSingleQuotesForSqLite];
                                }
                                if ([src objectForKey:@"requestUserTel"]) {
                                    requestUserTel = [src objectForKey:@"requestUserTel"];
                                }
                                if ([src objectForKey:@"requestTime"]) {
                                    requestTime = [NSString stringWithFormat:@"%@",[src objectForKey:@"requestTime"]];
                                }
                                if ([src objectForKey:@"description"]) {
                                    description = [src objectForKey:@"description"];
                                    description = [description avoidSingleQuotesForSqLite];
                                }
                                NSString *uuid = [App createUUID];
                                NSString *sql=[NSString stringWithFormat:@"INSERT INTO %@(KEYID,ID,TYPE,CREATE_TIME,STATUS,VEHICLE_VIN,USER_ID) VALUES('%@','%@','%d','%@','%d','','%@')",TABLE_MESSAGE_INFO_DATA,uuid,ID,MESSAGE_FRIEND_REQUEST_LOCATION,[App getSystemTime],MESSAGE_UNREAD,app.mUserData.mUserID];
                                NSLog(@"%@",sql);
                                [tempSql addObject:sql];
//                                @"CREATE TABLE IF NOT EXISTS %@ (KEYID TEXT  NOT NULL,REQ_UID TEXT,REQUEST_USER_ID TEXT, REQUEST_USER_NAME TEXT,REQUEST_USER_TEL TEXT, REQUEST_TIME TEXT, DESCRIPTION TEXT, RP_STATE TEXT, RP_TIME TEXT, MESSAGE_KEYID TEXT)", 
                                sql=[NSString stringWithFormat:@"INSERT INTO %@(KEYID,REQ_UID,REQUEST_USER_ID, REQUEST_USER_NAME, REQUEST_USER_TEL, REQUEST_TIME,DESCRIPTION, RP_STATE, RP_TIME, MESSAGE_KEYID) VALUES('%@','%@','%@','%@','%@','%@','%@','%d','','%@')",TABLE_FRIEND_REQUEST_LOCATION_MESSAGE_DATA,uuid,reqUID, requestUserId,requestUserName, requestUserTel, requestTime, description, FRIEND_LOCATION_UNTREATED, uuid];
                                [tempSql addObject:sql];
                                NSLog(@"sql=%@",sql);
                            }
                        }
                            break;
                            
                        case MESSAGE_FRIEND_LOCATION:
                        {
                            //车友位置信息
                            NSLog(@"receive the Friend location message.");
                            //保存到Locationrequest表
//                            1	sendTime	time	车友位置请求发送时间	◎
//                            2	friendUserId	string	车友（应答者）用户id	◎
//                            3	friendUserName	string	车友（应答者）名称	◎
//                            4	friendUserTel	String	车友（应答者）手机号，用于添加黑名单或车友	◎
//                            5	responseTime	time	车友（应答者）处理请求时间	◎
//                            6	vin	string	位置所属车辆vin号码	◎
//                            7	uploadTime	time	位置上传时间	◎
//                            8	lon	double	经度	◎
//                            9	lat	double	纬度	◎
//                            10	poiName	string	位置名称	◎
//                            11	poiAddress	string	位置地址
                            NSDictionary *src = [dict objectForKey:@"messageData"];
                            
                            NSString *ID = @"";
                            if ([dict objectForKey:@"messageId"]) {
                                ID = [dict objectForKey:@"messageId"];
                            }
                            if (src) {
                                NSString *sendTime = @"";
                                NSString *friendUserId = @"";
                                NSString *friendUserName = @"";
                                NSString *friendUserTel = @"";
                                NSString *responseTime = @"";
                                NSString *licenseNumber = @"";
                                NSString *uploadTime = @"";
                                float lon = 0;
                                float lat = 0;
                                NSString *poiName = @"";
                                NSString *poiAddress = @"";
                                NSString *locName = @"";
                                NSString *locAddress = @"";
                                if ([src objectForKey:@"lon"]) {
                                    lon = [[src objectForKey:@"lon"] doubleValue];
                                }
                                if ([src objectForKey:@"lat"]) {
                                    lat = [[src objectForKey:@"lat"] doubleValue];
                                }
                                if ([src objectForKey:@"sendTime"]) {
                                    sendTime = [NSString stringWithFormat:@"%@",[src objectForKey:@"sendTime"]];
                                }
                                if ([src objectForKey:@"friendUserId"]) {
                                    friendUserId = [src objectForKey:@"friendUserId"];
                                }
                                if ([src objectForKey:@"friendUserName"]) {
                                    friendUserName = [src objectForKey:@"friendUserName"];
                                    friendUserName = [friendUserName avoidSingleQuotesForSqLite];
                                }
                                if ([src objectForKey:@"friendUserTel"]) {
                                    friendUserTel = [src objectForKey:@"friendUserTel"];
                                }
                                if ([src objectForKey:@"poiName"]) {
                                    poiName = [src objectForKey:@"poiName"];
                                    if ([App isNSNull:poiName]) {
                                        poiName = @"";
                                    }
                                    locName = poiName;
                                    poiName = [poiName avoidSingleQuotesForSqLite];
                                }
                                if ([src objectForKey:@"poiAddress"]) {
                                    poiAddress = [src objectForKey:@"poiAddress"];
                                    if ([App isNSNull:poiAddress]) {
                                        poiName = @"";
                                    }
                                    
                                    locAddress = poiAddress;
                                    poiAddress = [poiAddress avoidSingleQuotesForSqLite];
                                }
                                if ([src objectForKey:@"responseTime"]) {
                                    responseTime = [NSString stringWithFormat:@"%@",[src objectForKey:@"responseTime"]];
                                }
                                if ([src objectForKey:@"uploadTime"]) {
                                    uploadTime = [NSString stringWithFormat:@"%@",[src objectForKey:@"uploadTime"]];
                                }
                                if ([src objectForKey:@"licenseNumber"]) {
                                    licenseNumber = [src objectForKey:@"licenseNumber"];
                                }
                                
                                NSString *uuid = [App createUUID];
                                NSString *sql=[NSString stringWithFormat:@"INSERT INTO %@(KEYID,ID,TYPE,CREATE_TIME,STATUS,VEHICLE_VIN,USER_ID) VALUES('%@','%@','%d','%@','%d','','%@')",TABLE_MESSAGE_INFO_DATA,uuid,ID,MESSAGE_FRIEND_LOCATION,[App getSystemTime],MESSAGE_UNREAD,app.mUserData.mUserID];
                                NSLog(@"%@",sql);
                                [tempSql addObject:sql];
//                                @"CREATE TABLE IF NOT EXISTS %@ (KEYID TEXT NOT NULL,SEND_TIME TEXT,FRIEND_USER_ID TEXT,FRIEND_USER_NAME TEXT,FRIEND_USER_TEL TEXT,RESPONSE_TIME TEXT,UPLOAD_TIME TEXT, LON DOUBLE, LAT DOUBLE, POI_NAME TEXT, POI_ADDRESS TEXT, MESSAGE_KEYID TEXT)", 
                                if ([src objectForKey:@"lon"]!=nil &&[src objectForKey:@"lat"]!=nil) {
                                    sql=[NSString stringWithFormat:@"INSERT INTO %@(KEYID,SEND_TIME,FRIEND_USER_ID,FRIEND_USER_NAME,FRIEND_USER_TEL,RESPONSE_TIME,UPLOAD_TIME,LON, LAT,POI_NAME,POI_ADDRESS,LICENSE_NUMBER, MESSAGE_KEYID) VALUES('%@','%@','%@','%@','%@','%@','%@','%f','%f','%@','%@','%@','%@')",TABLE_FRIEND_LOCATION_MESSAGE_DATA,uuid,sendTime,friendUserId,friendUserName,friendUserTel,responseTime,uploadTime,lon,lat,poiName,poiAddress,licenseNumber,uuid];
                                }
                                else
                                {
                                    NSLog(@"车友位置消息数据错误");
                                    sql=[NSString stringWithFormat:@"INSERT INTO %@(KEYID,SEND_TIME,FRIEND_USER_ID,FRIEND_USER_NAME,FRIEND_USER_TEL,RESPONSE_TIME,UPLOAD_TIME,LON, LAT,POI_NAME,POI_ADDRESS,LICENSE_NUMBER, MESSAGE_KEYID) VALUES('%@','%@','%@','%@','%@','%@','%@','','','%@','%@','%@','%@')",TABLE_FRIEND_LOCATION_MESSAGE_DATA,uuid,sendTime,friendUserId,friendUserName,friendUserTel,responseTime,uploadTime,poiName,poiAddress,licenseNumber,uuid];
                                }
                                NSLog(@"%@",sql);
                                [tempSql addObject:sql];
                                //更新车友表位置信息
                                if ([src objectForKey:@"lon"]!=nil && [src objectForKey:@"lat"]!=nil) {
                                    sql = [NSString stringWithFormat:@"UPDATE %@ SET LON='%f',LAT='%f',LAST_RQ_TIME=%@ ,POI_NAME = '%@',POI_ADDRESS = '%@' WHERE USER_KEYID='%@'AND PHONE='%@'",TABLE_FRIENDS_DATA,lon,lat,uploadTime,poiName,poiAddress,app.mUserData.mUserID,friendUserTel];
                                    [tempSql addObject:sql];
                                    NSLog(@"update location sql = %@",sql);
                                    //更新车友详情界面位置信息
                                    NSMutableDictionary *friendLocationDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:friendUserTel,@"phone", [NSString stringWithFormat:@"%f",lon],@"lon",[NSString stringWithFormat:@"%f",lat],@"lat",uploadTime,@"locTime",locName,@"poiName",locAddress,@"poiAddress",nil];
                                    [frindLocationArray addObject:friendLocationDictionary];
                                    [friendLocationDictionary release];
                                }
                            }
                        }
                            break;
                        case MESSAGE_VEHICLE_ABNORMAL_ALARM:
                        {
                            //车辆异常报警信息
                            NSLog(@"receive the Friend location message.");
//                            1	vin	string	报警车辆vin号码	◎
//                            2	alarmType	     string	异常报警类型。0：车门异常打开；1：TBox报警	◎
//                            3	alarmTime	     time	车辆异常报警时间	◎
//                            4	lon	double	车辆位置经度	◎
//                            5	lat	double	车辆位置纬度	◎
//                            6	speed	int	车辆速度	◎
//                            7	direction	int	车辆方向	◎
//                            8	address	string	报警地点	◎

                            NSDictionary *src = [dict objectForKey:@"messageData"];
                            NSString *ID = @"";
                            if ([dict objectForKey:@"messageId"]) {
                                ID = [dict objectForKey:@"messageId"];
                            }
                            if (src) {
                                NSString *vin = @"";
                                NSString *alarmType = @"";
                                NSString *alarmTime = @"";
                                NSString *speed = @"";
                                NSString *direction = @"";
                                NSString *address = @"";
                                double lon = 0;
                                double lat = 0;
                                
                                if ([src objectForKey:@"vin"]) {
                                    vin = [src objectForKey:@"vin"];
                                }
                                if ([src objectForKey:@"alarmType"]) {
                                    alarmType = [src objectForKey:@"alarmType"];
                                }
                                if ([src objectForKey:@"alarmTime"]) {
                                    alarmTime = [NSString stringWithFormat:@"%@",[src objectForKey:@"alarmTime"]];
                                }
                                if ([src objectForKey:@"speed"]) {
                                    speed = [src objectForKey:@"speed"];
                                }
                                if ([src objectForKey:@"direction"]) {
                                    direction = [src objectForKey:@"direction"];
                                }
                                if ([src objectForKey:@"address"]) {
                                    address = [src objectForKey:@"address"];
                                    if ([App isNSNull:address]) {
                                        address = @"";
                                    }
                                }
                                if ([src objectForKey:@"lon"]) {
                                    lon = [[src objectForKey:@"lon"] doubleValue];
                                }
                                if ([src objectForKey:@"lat"]) {
                                    lat = [[src objectForKey:@"lat"] doubleValue];
                                }
                                NSString *uuid = [App createUUID];
                                 NSString *sql=[NSString stringWithFormat:@"INSERT INTO %@(KEYID,ID,TYPE,CREATE_TIME,STATUS,VEHICLE_VIN,USER_ID) VALUES('%@','%@','%d','%@','%d','%@','%@')",TABLE_MESSAGE_INFO_DATA,uuid,ID,MESSAGE_VEHICLE_ABNORMAL_ALARM,[App getSystemTime],MESSAGE_UNREAD,vin,app.mUserData.mUserID];
                                NSLog(@"%@",sql);
                                [tempSql addObject:sql];
                                sql=[NSString stringWithFormat:@"INSERT INTO %@(KEYID,ALARM_TYPE,ALARM_TIME,LON,LAT,SPEED,DIRECTION,ADDRESS,MESSAGE_KEYID) VALUES('%@','%@','%@',%f,%f,'%@','%@','%@','%@')",TABLE_VEHICLE_ABNORMAL_ALARM_MESSAGE_DATA,uuid,alarmType,alarmTime,lon,lat,speed,direction,[address avoidSingleQuotesForSqLite],uuid];
                                NSLog(@"%@",sql);
                                [tempSql addObject:sql];
                            }
                        }
                            break;
                        case MESSAGE_VEHICLE_CONTROL:
                        {
                            //车辆控制信息
                            NSLog(@"receive the Friend location message.");
                            //                            1	vin	string	指令目标车辆车架号	◎
                            //                            2	sendTime	time	指令请求发送时间	◎
                            //                            3	cmdCode	string	指令类型码	◎
                            //                            4	resultCode	int	指令执行结果。
                            //                            0：指令执行成功；1：指令执行失败	◎
                            //                            5	resultMsg	string	指令执行错误提示
                            NSDictionary *src = [dict objectForKey:@"messageData"];
                            NSString *ID = @"";
                            if ([dict objectForKey:@"messageId"]) {
                                ID = [dict objectForKey:@"messageId"];
                            }
                            if (src) {
                                NSString *vin = @"";
                                NSString *sendTime = @"";
                                NSString *cmdCode = @"";
                                NSString *resultCode = @"";
                                NSString *resultMsg = @"";
                                
                                if ([src objectForKey:@"vin"]) {
                                    vin = [src objectForKey:@"vin"];
                                }
                                if ([src objectForKey:@"sendTime"]) {
                                    sendTime = [NSString stringWithFormat:@"%@",[src objectForKey:@"sendTime"]];
                                }
                                if ([src objectForKey:@"cmdCode"]) {
                                    cmdCode = [src objectForKey:@"cmdCode"];
                                }
                                if ([src objectForKey:@"resultMsg"]) {
                                    resultMsg = [src objectForKey:@"resultMsg"];
                                }
                                if ([src objectForKey:@"resultCode"]) {
                                    resultCode = [src objectForKey:@"resultCode"];
                                }
                                NSString *uuid = [App createUUID];
                                NSString *sql=[NSString stringWithFormat:@"INSERT INTO %@(KEYID,ID,TYPE,CREATE_TIME,STATUS,VEHICLE_VIN,USER_ID) VALUES('%@','%@','%d','%@','%d','%@','%@')",TABLE_MESSAGE_INFO_DATA,uuid,ID,MESSAGE_VEHICLE_CONTROL,[App getSystemTime],MESSAGE_UNREAD,vin,app.mUserData.mUserID];
                                NSLog(@"%@",sql);
                                [tempSql addObject:sql];
                                sql=[NSString stringWithFormat:@"INSERT INTO %@(KEYID,SEND_TIME,CMD_CODE,RESULT_CODE,RESULT_MSG,MESSAGE_KEYID) VALUES('%@','%@','%@','%@','%@','%@')",TABLE_VEHICLE_CONTROL_MESSAGE_DATA,uuid,sendTime,cmdCode,resultCode,[resultMsg avoidSingleQuotesForSqLite],uuid];
                                NSLog(@"%@",sql);
                                [tempSql addObject:sql];
                               // if ([sendTime intValue]%1000 - [[App getTimeSince1970]intValue] <= 60*10 )
                               // {
                                    NSMutableDictionary *vehicleControlDataDic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:cmdCode,@"cmdCode",resultCode,@"resultCode",nil];
                                    [vehicleControlDic setObject:vehicleControlDataDic forKey:vin];
                                    [vehicleControlDataDic release];
                                    
                               // }
                            }
                        }
                            break;
                        case MESSAGE_MAINTENANCE_ALARM:
                        {
                            //车辆保养信息
                            NSLog(@"receive the Friend location message.");
//                            1	vin	string	保养提醒目标车辆vin	◎
//                            2	maintainTime	time	提醒保养时间	◎
//                            3	maintainMileage	int	提醒保养里程	◎
//                            4	maintainItems	list<string>	提醒保养项目列表	◎
//                            4-1	itemName	string	提醒保养项目名称	◎
//                            5	description	string	提醒内容	◎
                            NSDictionary *src = [dict objectForKey:@"messageData"];
                            if (src) {
                                NSString *ID = @"";
                                NSString *vin = @"";
                                NSString *maintainTime = @"";
                                NSString *maintainMileage = @"";
                                NSString *description = @"";
                                NSString *maintainItems = @"";
                                
                                if ([dict objectForKey:@"messageId"]) {
                                    ID = [dict objectForKey:@"messageId"];
                                }
                                if ([src objectForKey:@"vin"]) {
                                    vin = [src objectForKey:@"vin"];
                                }
                                if ([src objectForKey:@"maintainTime"]) {
                                    maintainTime = [NSString stringWithFormat:@"%@",[src objectForKey:@"maintainTime"]];
                                }
                                if ([src objectForKey:@"maintainMileage"]) {
                                    maintainMileage = [src objectForKey:@"maintainMileage"];
                                }
                                if ([src objectForKey:@"description"]) {
                                    description = [src objectForKey:@"description"];
                                }
                                if ([src objectForKey:@"maintainItems"]) {
                                    NSArray *itemArray= [src objectForKey:@"maintainItems"];
                                    for (id item in itemArray)
                                    {
//                                         NSString *name = [item objectForKey:@"itemName"];
                                        NSString *name = item;
                                        maintainItems = [maintainItems stringByAppendingString:[NSString stringWithFormat:@",%@",name]];
                                    }
                                    maintainItems = [maintainItems substringFromIndex:1];
                                }
                                NSString *uuid = [App createUUID];
                                NSString *sql=[NSString stringWithFormat:@"INSERT INTO %@(KEYID,ID,TYPE,CREATE_TIME,STATUS,VEHICLE_VIN,USER_ID) VALUES('%@','%@','%d','%@','%d','%@','%@')",TABLE_MESSAGE_INFO_DATA,uuid,ID,MESSAGE_MAINTENANCE_ALARM,[App getSystemTime],MESSAGE_UNREAD,vin,app.mUserData.mUserID];
                                NSLog(@"%@",sql);
                                [tempSql addObject:sql];
                                sql=[NSString stringWithFormat:@"INSERT INTO %@(KEYID,MAINTAIN_TIME,MAINTAIN_MILEAGE,MAINTAIN_ITEMS,DESCRIPTION,MESSAGE_KEYID) VALUES('%@','%@','%@','%@','%@','%@')",TABLE_MAINTENANCE_ALERT_MESSAGE_DATA,uuid,maintainTime,maintainMileage,[maintainItems avoidSingleQuotesForSqLite],[description avoidSingleQuotesForSqLite],uuid];
                                NSLog(@"%@",sql);
                                [tempSql addObject:sql];
                            }
                        }
                            break;
                        case MESSAGE_VEHICLE_STATUS:
                        {
                            //车辆状况信息
                            NSLog(@"receive the Friend location message.");
//                            1	vin	string	远程监控目标车辆车架号	◎
//                            2	sendTime	time	远程监控请求发送时间	◎
//                            3	resultCode	string	0：远程监控成功；1：远程监控失败	◎
//                            4	resultMsg	string	远程监控错误提示
//                            5	uploadTime	time	车辆状况上传时间
//                            6	lon	double	车辆位置经度
//                            7	lat	double	车辆位置纬度
//                            8	speed	int	车辆速度
//                            9	direction	int	车辆方向
//                            10	mileage	int	车辆行驶里程
//                            11	fuelLevel	int	剩余油量，单位：升（L）
//                            12	fuelConsumption	int	油耗，单位：升/百公里（L/100km）
//                            13	FLTirePressure	int	左前轮胎胎压
//                            14	FRTirePressure	int	右前轮胎胎压
//                            15	RLTirePressure	int	左后轮胎胎压
//                            16	RRTirePressure	int	右后轮胎胎压	
//                            17	driverDoorSts	string	主驾驶车门是否开启。0：关；1：开	
//                            18	passengerDoorSts	string	副驾驶车门是否开启。0：关；1：开	
//                            19	RLDoorSts	string	左后车门是否开启。0：关；1：开	
//                            20	RRDoorSts	string	右后车门是否开启。0：关；1：开	
//                            21	hoodSts	string	机舱盖是否开启。0：关；1：开	
//                            22	trunkSts	string	后备箱是否开启。0：关；1：开	
//                            23	beamSts	string	大灯状态。0：关；1：开	
//                            24	cbnTemp	int	车内温度	
//                            25	cdngOff	string	空调是否关闭。0：关；1：开
                            NSDictionary *src = [dict objectForKey:@"messageData"];
                            if (src) {
                                NSString *ID = @"";
                                NSString *vin = @"";
                                NSString *sendTime = @"";
                                NSString *resultCode = @"";
                                NSString *resultMsg = @"";
                                NSString *uploadTime = @"";
                                double lon = 0;
                                double lat = 0;
                                NSString *speed = @"";
                                NSString *direction = @"";
                                NSString *mileage = @"";
                                NSString *fuelLevel = @"";
                                NSString *fuelLevelState = @"";
                                NSString *fuelConsumption = @"";
                                NSString *fLTirePressure = @"";
                                NSString *fRTirePressure = @"";
                                NSString *rLTirePressure = @"";
                                NSString *rRTirePressure = @"";
                                NSString *fLTirePressureState = @"";
                                NSString *fRTirePressureState = @"";
                                NSString *rLTirePressureState = @"";
                                NSString *rRTirePressureState = @"";
                                NSString *driverDoorSts = @"";
                                NSString *passengerDoorSts = @"";
                                NSString *rLDoorSts = @"";
                                NSString *rRDoorSts = @"";
                                NSString *hoodSts = @"";
                                NSString *trunkSts = @"";
                                NSString *beamSts = @"";
                                NSString *cbnTemp = @"";
                                NSString *cdngOff = @"";
                                
                                if ([dict objectForKey:@"messageId"]) {
                                    ID = [dict objectForKey:@"messageId"];
                                }
                                if ([src objectForKey:@"vin"]) {
                                    vin = [src objectForKey:@"vin"];
                                }
                                if ([src objectForKey:@"sendTime"]) {
                                    sendTime = [src objectForKey:@"sendTime"];
                                }
                                if ([src objectForKey:@"resultCode"]) {
                                    resultCode = [src objectForKey:@"resultCode"];
                                }
                                if ([src objectForKey:@"resultMsg"]) {
                                    resultMsg = [src objectForKey:@"resultMsg"];
                                }
                                if ([src objectForKey:@"uploadTime"]) {
                                    uploadTime = [src objectForKey:@"uploadTime"];
                                }
                                if ([src objectForKey:@"lon"]) {
                                    lon = [[src objectForKey:@"lon"] doubleValue];
                                }
                                if ([src objectForKey:@"lat"]) {
                                    lat = [[src objectForKey:@"lat"] doubleValue];
                                }
                                if ([src objectForKey:@"speed"]) {
                                    speed = [src objectForKey:@"speed"];
                                }
                                if ([src objectForKey:@"direction"]) {
                                    direction = [src objectForKey:@"direction"];
                                }
                                if ([src objectForKey:@"mileage"]) {
                                    mileage = [src objectForKey:@"mileage"];
                                }
                                if ([src objectForKey:@"fuelLevel"]) {
                                    fuelLevel = [src objectForKey:@"fuelLevel"];
                                }
                                if ([src objectForKey:@"fuelLevelState"]) {
                                    fuelLevelState = [src objectForKey:@"fuelLevelState"];
                                }
                                if ([src objectForKey:@"fuelConsumption"]) {
                                    fuelConsumption = [src objectForKey:@"fuelConsumption"];
                                }
                                if ([src objectForKey:@"FLTirePressure"]) {
                                    fLTirePressure = [src objectForKey:@"FLTirePressure"];
                                }
                                if ([src objectForKey:@"FRTirePressure"]) {
                                    fRTirePressure = [src objectForKey:@"FRTirePressure"];
                                }
                                if ([src objectForKey:@"RLTirePressure"]) {
                                    rLTirePressure = [src objectForKey:@"RLTirePressure"];
                                }
                                if ([src objectForKey:@"RRTirePressure"]) {
                                    rRTirePressure = [src objectForKey:@"RRTirePressure"];
                                }
                                
                                if ([src objectForKey:@"FLTirePressureState"]) {
                                    fLTirePressureState = [src objectForKey:@"FLTirePressureState"];
                                }
                                if ([src objectForKey:@"FRTirePressureState"]) {
                                    fRTirePressureState = [src objectForKey:@"FRTirePressureState"];
                                }
                                if ([src objectForKey:@"RLTirePressureState"]) {
                                    rLTirePressureState = [src objectForKey:@"RLTirePressureState"];
                                }
                                if ([src objectForKey:@"RRTirePressureState"]) {
                                    rRTirePressureState = [src objectForKey:@"RRTirePressureState"];
                                }
                                if ([src objectForKey:@"driverDoorSts"]) {
                                    driverDoorSts = [src objectForKey:@"driverDoorSts"];
                                }
                                if ([src objectForKey:@"passengerDoorSts"]) {
                                    passengerDoorSts = [src objectForKey:@"passengerDoorSts"];
                                }
                                if ([src objectForKey:@"RLDoorSts"]) {
                                    rLDoorSts = [src objectForKey:@"RLDoorSts"];
                                }
                                if ([src objectForKey:@"RRDoorSts"]) {
                                    rRDoorSts = [src objectForKey:@"RRDoorSts"];
                                }
                                if ([src objectForKey:@"hoodSts"]) {
                                    hoodSts = [src objectForKey:@"hoodSts"];
                                }
                                if ([src objectForKey:@"trunkSts"]) {
                                    trunkSts = [src objectForKey:@"trunkSts"];
                                }
                                if ([src objectForKey:@"beamSts"]) {
                                    beamSts = [src objectForKey:@"beamSts"];
                                }
                                if ([src objectForKey:@"cbnTemp"]) {
                                    cbnTemp = [src objectForKey:@"cbnTemp"];
                                }
                                if ([src objectForKey:@"cdngOff"]) {
                                    cdngOff = [src objectForKey:@"cdngOff"];
                                }
                                NSString *uuid = [App createUUID];
//                                NSString *sql=[NSString stringWithFormat:@"INSERT INTO %@(KEYID,ID,TYPE,CREATE_TIME,STATUS,VEHICLE_VIN,USER_ID) VALUES('%@','%@','%d','%@','%d','%@','%@')",TABLE_MESSAGE_INFO_DATA,uuid,ID,MESSAGE_VEHICLE_STATUS,[App getSystemTime],MESSAGE_UNREAD,vin,app.mUserData.mAccount];
                                if([resultCode intValue] == 0)
                                {
                                    NSString *sql=[NSString stringWithFormat:@"DELETE FROM %@ WHERE VIN = '%@'",TABLE_VEHICLE_STATUS_MESSAGE_DATA,vin];
                                    NSLog(@"%@",sql);
                                    [tempSql addObject:sql];
                                    sql=[NSString stringWithFormat:@"INSERT INTO %@(KEYID,VIN,SEND_TIME,RESULT_CODE,RESULT_MSG,UPLOAD_TIME,RECEIVE_TIME,LON,LAT,SPEED,DIRECTION,MILEAGE,FUEL_LEVEL,FUEL_LEVEL_STATE,FUEL_CONSUMPTION,FL_TIRE_PRESSURE,FL_TIRE_PRESSURE_STATE,FR_TIRE_PRESSURE,FR_TIRE_PRESSURE_STATE,RL_TIRE_PRESSURE,RL_TIRE_PRESSURE_STATE,RR_TIRE_PRESSURE,RR_TIRE_PRESSURE_STATE,DRIVER_DOOR_STS,PASSENGER_DOOR_STS,RL_DOOR_STS,RR_DOOR_STS,HOOD_STS,TRUNK_STS,BEAM_STS,CBN_TEMP,CDNG_OFF,USER_KEYID) VALUES('%@','%@','%@','%@','%@','%@','%@',%f,%f,'%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",TABLE_VEHICLE_STATUS_MESSAGE_DATA,uuid,vin,sendTime,resultCode,resultMsg,uploadTime,[App getSystemTime],lon,lat,speed,direction,mileage,fuelLevel,fuelLevelState,fuelConsumption,fLTirePressure,fLTirePressureState,fRTirePressure,fRTirePressureState,rLTirePressure,rLTirePressureState,rRTirePressure,rRTirePressureState,driverDoorSts,passengerDoorSts,rLDoorSts,rRDoorSts,hoodSts,trunkSts,beamSts,cbnTemp,cdngOff,app.mUserData.mUserID];
                                    NSLog(@"%@",sql);
                                    [tempSql addObject:sql];
                                    [vehicleStatusArray addObject:vin];
                                }
                                
                            }
                        }
                            break;
                        case MESSAGE_VEHICLE_DIAGNOSIS:
                        {
                            //车辆故障诊断结果
                            NSLog(@"receive the Friend location message.");
//                            1	reportId	string	诊断报告的id	◎
//                            2	reportType	string	诊断报告类型。0：在线诊断结果；1：定期情况报告；2：自动诊断结果；	◎
//                            3	vin	string	远程诊断目标车辆车架号	◎
//                            4	sendTime	time	远程诊断请求发送时间，注：定期情况报告没有发送时间	◎
//                            5	checkResult	string	检查结果。0:无故障；1：有故障；2：诊断失败	◎
//                            6	checkTime	time	检查时间，本次检查结果生成时间。	◎
//                            7	checkItems	list	检查项列表	◎
//                            7-1	checkItemType	int	检查项的类型	◎
//                            7-2	checkItemTypeName	string	检查项的类型名称	◎
//                            7-3	faultItemId	string	故障项的id	
//                            7-4	faultItemName	string	故障项的名称	
//                            7-5	faultItemDesc	string	故障项的描述	
//                            7-6	faultCreateTime	time	故障生成时间
                            NSDictionary *src = [dict objectForKey:@"messageData"];
                            if (src) {
                                NSString *ID = @"";
                                NSString *reportId = @"";
                                NSString *reportType = @"";
                                NSString *vin = @"";
                                NSString *sendTime = @"";
                                NSString *checkResult = @"";
                                NSString *checkTime = @"";
                                
                                NSString *checkItemType = @"";
                                NSString *checkItemTypeName = @"";
                                NSString *faultItemId = @"";
                                NSString *faultItemName = @"";
                                NSString *faultItemDesc = @"";
                                NSString *faultCreateTime = @"";
                                if ([dict objectForKey:@"messageId"]) {
                                    ID = [dict objectForKey:@"messageId"];
                                }
                                if ([src objectForKey:@"reportId"]) {
                                    reportId = [src objectForKey:@"reportId"];
                                }
                                if ([src objectForKey:@"reportType"]) {
                                    reportType = [src objectForKey:@"reportType"];
                                }
                                if ([src objectForKey:@"vin"]) {
                                    vin = [src objectForKey:@"vin"];
                                }
                                if ([src objectForKey:@"sendTime"]) {
                                    sendTime = [src objectForKey:@"sendTime"];
                                }
                                if ([src objectForKey:@"checkResult"]) {
                                    checkResult = [src objectForKey:@"checkResult"];
                                }
                                if ([src objectForKey:@"checkTime"]) {
                                    checkTime = [src objectForKey:@"checkTime"];
                                }
                                NSString *uuid = [App createUUID];
                                NSString *sql=[NSString stringWithFormat:@"INSERT INTO %@(KEYID,ID,TYPE,CREATE_TIME,STATUS,VEHICLE_VIN,USER_ID) VALUES('%@','%@','%d','%@','%d','%@','%@')",TABLE_MESSAGE_INFO_DATA,uuid,ID,MESSAGE_VEHICLE_DIAGNOSIS,[App getSystemTime],MESSAGE_UNREAD,vin,app.mUserData.mUserID];
                                NSLog(@"%@",sql);
                                [tempSql addObject:sql];
                                sql=[NSString stringWithFormat:@"INSERT INTO %@(KEYID,REPORT_ID,REPORT_TYPE,SEND_TIME,CHECK_RESULT,CHECK_TIME,MESSAGE_KEYID) VALUES('%@','%@','%@','%@','%@','%@','%@')",TABLE_VEHICLE_DIAGNOSIS_MESSAGE_DATA,uuid,reportId,reportType,sendTime,[checkResult avoidSingleQuotesForSqLite],checkTime,uuid];
                                NSLog(@"%@",sql);
                                [tempSql addObject:sql];
                                
                                
                                if ([src objectForKey:@"checkItems"]) {
                                    NSArray *itemArray= [src objectForKey:@"checkItems"];
                                    for (id item in itemArray)
                                    {
                                        
                                        checkItemType = @"";
                                        checkItemTypeName = @"";
                                        faultItemId = @"";
                                        faultItemName = @"";
                                        faultItemDesc = @"";
                                        faultCreateTime = @"";
                                        NSDictionary *reportItemDic = item;
                                        if ([reportItemDic objectForKey:@"checkItemType"]) {
                                            checkItemType = [reportItemDic objectForKey:@"checkItemType"];
                                        }
                                        if ([reportItemDic objectForKey:@"checkItemTypeName"]) {
                                            checkItemTypeName = [reportItemDic objectForKey:@"checkItemTypeName"];
                                        }
                                        if ([reportItemDic objectForKey:@"faultItemId"]) {
                                            faultItemId = [reportItemDic objectForKey:@"faultItemId"];
                                        }
                                        if ([reportItemDic objectForKey:@"faultItemName"]) {
                                            faultItemName = [reportItemDic objectForKey:@"faultItemName"];
                                        }
                                        if ([reportItemDic objectForKey:@"faultItemDesc"]) {
                                            faultItemDesc = [reportItemDic objectForKey:@"faultItemDesc"];
                                        }
                                        if ([reportItemDic objectForKey:@"faultCreateTime"]) {
                                            faultCreateTime = [reportItemDic objectForKey:@"faultCreateTime"];
                                        }
                                        uuid = [App createUUID];
                                        sql=[NSString stringWithFormat:@"INSERT INTO %@(KEYID,REPORT_ID,CHECK_ITEM_TYPE,CHECK_ITEM_TYPE_NAME,FAULT_ITEM_ID,FAULT_ITEM_NAME,FAULT_ITEM_DESC,FAULT_CREATE_TIME) VALUES('%@','%@','%@','%@','%@','%@','%@','%@')",TABLE_VEHICLE_DIAGNOSIS_REPORT_ITEM_DATA,uuid,reportId,checkItemType,checkItemTypeName,faultItemId,faultItemName,[faultItemDesc avoidSingleQuotesForSqLite],faultCreateTime];
                                        NSLog(@"%@",sql);
                                        [tempSql addObject:sql];
                                    }
                                }
                                [vehicleDiagnosisArray addObject:vin];
                            }
                        }
                            break;
                        case MESSAGE_VEHICLE_DIAGNOSIS_AUTOMATIC:
                        {
                            //车辆故障诊断结果
                            NSLog(@"receive the Friend location message.");
                            //                            1	reportId	string	诊断报告的id	◎
                            //                            2	reportType	string	诊断报告类型。0：在线诊断结果；1：定期情况报告；2：自动诊断结果；	◎
                            //                            3	vin	string	远程诊断目标车辆车架号	◎
                            //                            4	sendTime	time	远程诊断请求发送时间，注：定期情况报告没有发送时间	◎
                            //                            5	checkResult	string	检查结果。0:无故障；1：有故障；2：诊断失败	◎
                            //                            6	checkTime	time	检查时间，本次检查结果生成时间。	◎
                            //                            7	checkItems	list	检查项列表	◎
                            //                            7-1	checkItemType	int	检查项的类型	◎
                            //                            7-2	checkItemTypeName	string	检查项的类型名称	◎
                            //                            7-3	faultItemId	string	故障项的id
                            //                            7-4	faultItemName	string	故障项的名称
                            //                            7-5	faultItemDesc	string	故障项的描述
                            //                            7-6	faultCreateTime	time	故障生成时间
                            NSDictionary *src = [dict objectForKey:@"messageData"];
                            if (src) {
                                NSString *ID = @"";
                                NSString *reportId = @"";
                                NSString *reportType = @"";
                                NSString *vin = @"";
                                NSString *sendTime = @"";
                                NSString *checkResult = @"";
                                NSString *checkTime = @"";
                                
                                NSString *checkItemType = @"";
                                NSString *checkItemTypeName = @"";
                                NSString *faultItemId = @"";
                                NSString *faultItemName = @"";
                                NSString *faultItemDesc = @"";
                                NSString *faultCreateTime = @"";
                                if ([dict objectForKey:@"messageId"]) {
                                    ID = [dict objectForKey:@"messageId"];
                                }
                                if ([src objectForKey:@"reportId"]) {
                                    reportId = [src objectForKey:@"reportId"];
                                }
                                if ([src objectForKey:@"reportType"]) {
                                    reportType = [src objectForKey:@"reportType"];
                                }
                                if ([src objectForKey:@"vin"]) {
                                    vin = [src objectForKey:@"vin"];
                                }
                                if ([src objectForKey:@"sendTime"]) {
                                    sendTime = [src objectForKey:@"sendTime"];
                                }
                                if ([src objectForKey:@"checkResult"]) {
                                    checkResult = [src objectForKey:@"checkResult"];
                                }
                                if ([src objectForKey:@"checkTime"]) {
                                    checkTime = [src objectForKey:@"checkTime"];
                                }
                                NSString *uuid = [App createUUID];
                                NSString *sql=[NSString stringWithFormat:@"INSERT INTO %@(KEYID,ID,TYPE,CREATE_TIME,STATUS,VEHICLE_VIN,USER_ID) VALUES('%@','%@','%d','%@','%d','%@','%@')",TABLE_MESSAGE_INFO_DATA,uuid,ID,MESSAGE_VEHICLE_DIAGNOSIS,[App getSystemTime],MESSAGE_UNREAD,vin,app.mUserData.mUserID];
                                NSLog(@"%@",sql);
                                [tempSql addObject:sql];
                                sql=[NSString stringWithFormat:@"INSERT INTO %@(KEYID,REPORT_ID,REPORT_TYPE,SEND_TIME,CHECK_RESULT,CHECK_TIME,MESSAGE_KEYID) VALUES('%@','%@','%@','%@','%@','%@','%@')",TABLE_VEHICLE_DIAGNOSIS_MESSAGE_DATA,uuid,reportId,reportType,sendTime,[checkResult avoidSingleQuotesForSqLite],checkTime,uuid];
                                NSLog(@"%@",sql);
                                [tempSql addObject:sql];
                                
                                
                                if ([src objectForKey:@"checkItems"]) {
                                    NSArray *itemArray= [src objectForKey:@"checkItems"];
                                    for (id item in itemArray)
                                    {
                                        
                                        checkItemType = @"";
                                        checkItemTypeName = @"";
                                        faultItemId = @"";
                                        faultItemName = @"";
                                        faultItemDesc = @"";
                                        faultCreateTime = @"";
                                        NSDictionary *reportItemDic = item;
                                        if ([reportItemDic objectForKey:@"checkItemType"]) {
                                            checkItemType = [reportItemDic objectForKey:@"checkItemType"];
                                        }
                                        if ([reportItemDic objectForKey:@"checkItemTypeName"]) {
                                            checkItemTypeName = [reportItemDic objectForKey:@"checkItemTypeName"];
                                        }
                                        if ([reportItemDic objectForKey:@"faultItemId"]) {
                                            faultItemId = [reportItemDic objectForKey:@"faultItemId"];
                                        }
                                        if ([reportItemDic objectForKey:@"faultItemName"]) {
                                            faultItemName = [reportItemDic objectForKey:@"faultItemName"];
                                        }
                                        if ([reportItemDic objectForKey:@"faultItemDesc"]) {
                                            faultItemDesc = [reportItemDic objectForKey:@"faultItemDesc"];
                                        }
                                        if ([reportItemDic objectForKey:@"faultCreateTime"]) {
                                            faultCreateTime = [reportItemDic objectForKey:@"faultCreateTime"];
                                        }
                                        uuid = [App createUUID];
                                        sql=[NSString stringWithFormat:@"INSERT INTO %@(KEYID,REPORT_ID,CHECK_ITEM_TYPE,CHECK_ITEM_TYPE_NAME,FAULT_ITEM_ID,FAULT_ITEM_NAME,FAULT_ITEM_DESC,FAULT_CREATE_TIME) VALUES('%@','%@','%@','%@','%@','%@','%@','%@')",TABLE_VEHICLE_DIAGNOSIS_REPORT_ITEM_DATA,uuid,reportId,checkItemType,checkItemTypeName,faultItemId,faultItemName,[faultItemDesc avoidSingleQuotesForSqLite],faultCreateTime];
                                        NSLog(@"%@",sql);
                                        [tempSql addObject:sql];
                                    }
                                }
                                [vehicleDiagnosisArray addObject:vin];
                            }
                        }
                            break;
                        default:
                            break;
                    }
                }
                if (tempSql.count != 0) {
                    [self messageAlert];
                    [app addMessageWithSqls:tempSql];
                }
            }
            
            if ([[result objectForKey:@"total"]integerValue] > 0) {
                [[NSNotificationCenter defaultCenter] postNotificationName:Notification_New_Message object:[result objectForKey:@"total"]];
                
            }
            //            将车友位置信息通知车友详情界面，待完成
            
            if (frindLocationArray.count > 0) {
                [[NSNotificationCenter defaultCenter] postNotificationName:Notification_New_FriendLocation object:frindLocationArray];
                
            }
            if (vehicleStatusArray.count > 0) {
                [[NSNotificationCenter defaultCenter] postNotificationName:Notification_New_VehicleStatus object:vehicleStatusArray];
            }
            if ([[vehicleControlDic allKeys]count] > 0) {
                [[NSNotificationCenter defaultCenter] postNotificationName:Notification_New_VehicleControl object:vehicleControlDic];
            }
            if (vehicleDiagnosisArray.count > 0) {
                [[NSNotificationCenter defaultCenter] postNotificationName:Notification_New_VehicleDiagnosis object:vehicleDiagnosisArray];
            }
            
        }
        
    }
    else
    {
        NSLog(@"Errors on reveice result.");
    }
}


-(void)messageAlert
{
    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
    
    //    AudioServicesPlayAlertSound(1007);//系统提示声音
    
    //                    NSString *path = [NSString stringWithFormat:@"/System/Library/Audio/UISounds/mail-sent.caf"];
    //                    NSString *path = [[NSBundle mainBundle] pathForResource:@"tap" ofType:@"caf"];
    //组装并播放音效
    //                    SystemSoundID theSoundID;
    //                    NSURL *fileURL = [NSURL fileURLWithPath:path isDirectory:NO];
    //
    //                    if (fileURL) {
    //                        OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileURL,&theSoundID);
    //                        if (error == kAudioServicesNoError) {//获取的声音无误
    //                            AudioServicesPlayAlertSound(theSoundID);
    //                        }
    //                    }
    
}



/*!
 @method getTime
 @abstract 获取本地时间
 @discussion 获取本地时间
 @param 无
 @result time
 */
-(NSString *)getTime
{
    NSDate * newDate = [NSDate date];
    NSDateFormatter *dateformat=[[NSDateFormatter alloc] init];
    [dateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * newDateOne = [dateformat stringFromDate:newDate];
    [dateformat setDateStyle:NSDateFormatterFullStyle];
    [dateformat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSLog(@"request start time%@",newDateOne);
    [dateformat release];
    return newDateOne;
}

/*!
 @method addEvent:(NSDate *) date content:(NSString *)content
 @abstract 向本地日历中添加事件提醒
 @discussion 向本地日历中添加事件提醒
 @param date 时间
 @param content 内容
 @result 无
 */
-(void)addEvent:(NSDate *) date content:(NSString *)content
{
    Resources *oRes = [Resources getInstance];
    EKEventStore *eventDB = [[EKEventStore alloc] init];
    
    /* iOS 6 requires the user grant your application access to the Event Stores */
    //    if (requestAccessToEntityType != NULL) { // we're on iOS 6
    //        addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    //        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    //        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
    //            accessGranted = granted;
    //            dispatch_semaphore_signal(sema);
    //        });
    //        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    //        dispatch_release(sema);
    //    }
    //    eventDB cen
    if ([eventDB respondsToSelector:@selector(requestAccessToEntityType:completion:)])
    {
        /* iOS Settings > Privacy > Calendars > MY APP > ENABLE | DISABLE */
        [eventDB requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error)
         {
             if ( granted )
             {
                 NSTimeInterval secondsPerTenMin = 10 * 60;
                 NSLog(@"User has granted permission!");
                 EKEvent *myEvent  = [EKEvent eventWithEventStore:eventDB];
                 myEvent.title     = [oRes getText:@"map.sendToCarViewController.eventTitle"] ;
                 myEvent.location  = content;
                 
                 myEvent.startDate = [[NSDate alloc]initWithTimeInterval:10 sinceDate:[date dateByAddingTimeInterval: -secondsPerTenMin]];
                 myEvent.endDate   = date;
                 myEvent.allDay = NO;
                 EKAlarm *alarm=[EKAlarm alarmWithRelativeOffset:0];
                 [myEvent addAlarm:alarm];
                 alarm=[EKAlarm alarmWithRelativeOffset:10 * 60];
                 [myEvent addAlarm:alarm];
                 
                 myEvent.notes=[oRes getText:@"map.sendToCarViewController.eventNotes"];
                 [myEvent setCalendar:[eventDB defaultCalendarForNewEvents]];
                 NSError *err;
                 if (![eventDB saveEvent:myEvent span:EKSpanThisEvent error:&err]) {
                     NSLog(@"%@",err);
                 }
                 NSLog(@"添加事件");
             }
             else
             {
                 NSLog(@"User has not granted permission!");
             }
         }];
    }
    else
    {
        NSTimeInterval secondsPerTenMin = 10 * 60;
        NSLog(@"User has granted permission!");
        EKEvent *myEvent  = [EKEvent eventWithEventStore:eventDB];
        myEvent.title     = [oRes getText:@"map.sendToCarViewController.eventTitle"] ;
        myEvent.location  = content;
        
        myEvent.startDate = [[NSDate alloc]initWithTimeInterval:10 sinceDate:[date dateByAddingTimeInterval: -secondsPerTenMin]];
        myEvent.endDate   = date;
        myEvent.allDay = NO;
        EKAlarm *alarm=[EKAlarm alarmWithRelativeOffset:0];
        [myEvent addAlarm:alarm];
        alarm=[EKAlarm alarmWithRelativeOffset:10 * 60];
        [myEvent addAlarm:alarm];
        
        myEvent.notes=[oRes getText:@"map.sendToCarViewController.eventNotes"];
        [myEvent setCalendar:[eventDB defaultCalendarForNewEvents]];
        NSError *err;
        [eventDB saveEvent:myEvent span:EKSpanThisEvent error:&err];
    }
}


@end
