/*!
 @header VehicleStatusViewController.m
 @abstract 车辆监控主控界面
 @author wangqiwei
 @version 1.00 2014/9/1 Create
 */
#import "VehicleStatusViewController.h"
#import "vehicleStatusNetManager.h"
#import "App.h"
#import "VehicleStatusInformMessageData.h"

#define MOMENT 1
#define MINUTE 2
#define HOUR   3
#define DAY    4
#define ERROR  5
#define offsetY 25

@interface VehicleStatusViewController ()
{
    
}
@end

@implementation VehicleStatusViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];


    
    
    Resources *oRes = [Resources getInstance];

    
    refreshTimeTitle.text = [oRes getText:@"Car.vehicleStatusViewController.refreshTimeTitle"];
    temperatureInCarTitle.text = [oRes getText:@"Car.vehicleStatusViewController.temperatureInCar"];
    mileageTitle.text = [oRes getText:@"Car.vehicleStatusViewController.mileage"];
    oilWearTitle.text = [oRes getText:@"Car.vehicleStatusViewController.oilWear"];
    oilMassTitle.text = [oRes getText:@"Car.vehicleStatusViewController.oilMass"];

    [self loadstateData];
    
    //显示加载等待框
    self.progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.progressHUD];
    [self.view bringSubviewToFront:self.progressHUD];
    self.progressHUD.delegate = self;
    //适配iphone4S
    enum SCREEN_SIZE   deviceSize = [App getScreenSize];
    if (deviceSize == SCREEN_SIZE_960_640)
    {
       // carImage.frame = CGRectMake(carImage.frame.origin.x, carImage.frame.origin.y-20, carImage.frame.size.width, carImage.frame.size.height);
        
        speedIconImage.frame = CGRectMake(speedIconImage.frame.origin.x, speedIconImage.frame.origin.y-offsetY, speedIconImage.frame.size.width, speedIconImage.frame.size.height);
        mileageTitle.frame = CGRectMake(mileageTitle.frame.origin.x, mileageTitle.frame.origin.y-offsetY, mileageTitle.frame.size.width, mileageTitle.frame.size.height);
        mileageNum.frame = CGRectMake(mileageNum.frame.origin.x, mileageNum.frame.origin.y-offsetY, mileageNum.frame.size.width, mileageNum.frame.size.height);
        
        oilWearImage.frame = CGRectMake(oilWearImage.frame.origin.x, oilWearImage.frame.origin.y-offsetY-10, oilWearImage.frame.size.width, oilWearImage.frame.size.height);
        oilWearTitle.frame = CGRectMake(oilWearTitle.frame.origin.x, oilWearTitle.frame.origin.y-offsetY-10, oilWearTitle.frame.size.width, oilWearTitle.frame.size.height);
        oilWearNum.frame = CGRectMake(oilWearNum.frame.origin.x, oilWearNum.frame.origin.y-offsetY-10, oilWearNum.frame.size.width, oilWearNum.frame.size.height);
        
        
        oilMassImage.frame = CGRectMake(oilMassImage.frame.origin.x, oilMassImage.frame.origin.y-offsetY-20, oilMassImage.frame.size.width, oilMassImage.frame.size.height);
        oilMassTitle.frame = CGRectMake(oilMassTitle.frame.origin.x, oilMassTitle.frame.origin.y-offsetY-20, oilMassTitle.frame.size.width, oilMassTitle.frame.size.height);
        oilMassNum.frame = CGRectMake(oilMassNum.frame.origin.x, oilMassNum.frame.origin.y-offsetY-20, oilMassNum.frame.size.width, oilMassNum.frame.size.height);
        
        
        speedIconDiviner.frame = CGRectMake(speedIconDiviner.frame.origin.x, speedIconDiviner.frame.origin.y-offsetY-5, speedIconDiviner.frame.size.width, speedIconDiviner.frame.size.height);
        oilWearImageDiviner.frame = CGRectMake(oilWearImageDiviner.frame.origin.x, oilWearImageDiviner.frame.origin.y-offsetY-15, oilWearImageDiviner.frame.size.width, oilWearImageDiviner.frame.size.height);
        oilMassImageDiviner.frame = CGRectMake(oilMassImageDiviner.frame.origin.x, oilMassImageDiviner.frame.origin.y-offsetY-25, oilMassImageDiviner.frame.size.width, oilMassImageDiviner.frame.size.height);
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshloadstateData:) name:Notification_New_VehicleStatus object:nil];
}

- (void)refreshView:(NSNotification *)notification
{
    [self loadstateData];
}
/*!
 @method loadstateData
 @abstract 从数据库中加载车辆的状态数据
 @discussion 从数据库中加载车辆的状态数据
 @result 无
 */
- (void)loadstateData
{
    Resources *oRes = [Resources getInstance];
    App *app = [App getInstance];
    CherryDBControl *cherryDBControl = [CherryDBControl sharedCherryDBControl];
    VehicleStatusInformMessageData *statusData;
    if(app.mUserData.mType == USER_LOGIN_DEMO)
    {
        statusData  = [cherryDBControl loadVehicleStatusByVin:@"demo_vin"];
    } else {
        statusData  = [cherryDBControl loadVehicleStatusByVin:app.mCarData.mVin];
    }
    
    NSInteger iDriverBeamSts = [statusData.mBeamSts intValue];
    if (iDriverBeamSts == 0)
    {
        frontLight.hidden =YES;
        rearLight.hidden = YES;
    }
    else
    {
        frontLight.hidden =NO;
        rearLight.hidden = NO;
    }
    
    
    
    NSInteger iDriverDoorSts = [statusData.mDriverDoorSts intValue];
    if (iDriverDoorSts == 0)
    {
        leftFrontDoor.hidden = YES;
    }
    else
    {
        leftFrontDoor.hidden = NO;
    }
    
    NSInteger iPassengerDoorSts = [statusData.mPassengerDoorSts intValue];
    if (iPassengerDoorSts == 0)
    {
        rightFrontDoor.hidden = YES;
    }
    else
    {
        rightFrontDoor.hidden = NO;
    }
    
    NSInteger iRLDoorSts = [statusData.mRlDoorSts intValue];
    if (iRLDoorSts == 0)
    {
        leftRearDoor.hidden = YES;
    }
    else
    {
        leftRearDoor.hidden = NO;
    }
    
    NSInteger iRRDoorSts = [statusData.mRrDoorSts intValue];
    if (iRRDoorSts == 0)
    {
        rightRearDoor.hidden = YES;
    }
    else
    {
       rightRearDoor.hidden = NO;
    }
    //左前胎 胎压
    NSString *nonPara = [oRes getText:@"Car.vehicleStatusViewController.errorNum"];
    NSMutableString *leftFrontTire = [NSMutableString stringWithString:[oRes getText:@"Car.vehicleStatusViewController.left"]];
    if (statusData.mFlTirePressure == nil)
    {
        [leftFrontTire appendString:nonPara];
        leftFrontTirePressure.text = leftFrontTire;
    }
    else
    {
        [leftFrontTire appendString:statusData.mFlTirePressure];
        leftFrontTirePressure.text = leftFrontTire;
        if([statusData.mFlTirePressureState intValue] == 1)
        {
            leftFrontTirePressure.textColor = [UIColor colorWithRed:255/255 green:0/255 blue:0/255 alpha:1];
        }
    }
    //左后胎 胎压
    NSMutableString *leftRearTire = [NSMutableString stringWithString:[oRes getText:@"Car.vehicleStatusViewController.left"]];
    if (statusData.mRlTirePressure == nil)
    {
        [leftRearTire appendString:nonPara];
        leftRearTirePressure.text = leftRearTire;
    }
    else
    {
        [leftRearTire appendString:statusData.mRlTirePressure];
        leftRearTirePressure.text = leftRearTire;
        if([statusData.mRlTirePressureState intValue] == 1)
        {
            leftRearTirePressure.textColor = [UIColor colorWithRed:255/255 green:0/255 blue:0/255 alpha:1];
        }
    }
    //右前胎 胎压
    NSMutableString *rightFrontTire = [NSMutableString stringWithString:[oRes getText:@"Car.vehicleStatusViewController.right"]];
    if (statusData.mFrTirePressure == nil)
    {
        [rightFrontTire appendString:nonPara];
        rightFrontTirePressure.text = rightFrontTire;
    }
    else
    {
        [rightFrontTire appendString:statusData.mFrTirePressure];
        rightFrontTirePressure.text = rightFrontTire;
        if([statusData.mFrTirePressureState intValue] == 1)
        {
            rightFrontTirePressure.textColor = [UIColor colorWithRed:255/255 green:0/255 blue:0/255 alpha:1];
        }
    }
    
    //右后胎 胎压
    NSMutableString *rightRearTire = [NSMutableString stringWithString:[oRes getText:@"Car.vehicleStatusViewController.right"]];
    if (statusData.mFrTirePressure == nil)
    {
        [rightRearTire appendString:nonPara];
        rightRearTirePressure.text = rightRearTire;
    }
    else
    {
        [rightRearTire appendString:statusData.mRrTirePressure];
        rightRearTirePressure.text = rightRearTire;
        if([statusData.mRrTirePressureState intValue] == 1)
        {
            rightRearTirePressure.textColor = [UIColor colorWithRed:255/255 green:0/255 blue:0/255 alpha:1];
        }
    }
    //车内温度
    NSString * temperatureUnit = [oRes getText:@"Car.vehicleStatusViewController.temperatureUnit"];
    if (statusData.mCbnTemp == nil)
    {
        NSMutableString *cbnTemp = [NSMutableString stringWithString:nonPara];
        [cbnTemp appendString:@" "];
        [cbnTemp appendString:temperatureUnit];
        temperatureInCarNum.text = cbnTemp;
    }
    else
    {
        NSMutableString *cbnTemp = [NSMutableString stringWithString:statusData.mCbnTemp];
        [cbnTemp appendString:@" "];
        [cbnTemp appendString:temperatureUnit];
        temperatureInCarNum.text = cbnTemp;
    }
    
    //里程
    NSString * mileageUnit = [oRes getText:@"Car.vehicleStatusViewController.mileageUnit"];
    if (statusData.mMileage == nil) {
        NSMutableString *mMileage = [NSMutableString stringWithString:nonPara];
        [mMileage appendString:@" "];
        [mMileage appendString:mileageUnit];
        mileageNum.text = mMileage;
    } else {
        NSMutableString *mMileage = [NSMutableString stringWithString:statusData.mMileage];
        [mMileage appendString:@" "];
        [mMileage appendString:mileageUnit];
        mileageNum.text = mMileage;
    }
    
    //油耗
    NSString * oilWearUnit = [oRes getText:@"Car.vehicleStatusViewController.oilWearUnit"];
    if (statusData.mFuelConsumption == nil)
    {
        NSMutableString *mFuelConsumption = [NSMutableString stringWithString:nonPara];
        [mFuelConsumption appendString:@" "];
        [mFuelConsumption appendString:oilWearUnit];
        oilWearNum.text = mFuelConsumption;
    }
    else
    {
        NSMutableString *mFuelConsumption = [NSMutableString stringWithString:statusData.mFuelConsumption];
        [mFuelConsumption appendString:@" "];
        [mFuelConsumption appendString:oilWearUnit];
        oilWearNum.text = mFuelConsumption;
    }
    
    //油量
    NSString * oilMassUnit = [oRes getText:@"Car.vehicleStatusViewController.oilMassUnit"];
    if (statusData.mFuelLevel == nil)
    {
        NSMutableString *mFuelLevel = [NSMutableString stringWithString:nonPara];
        [mFuelLevel appendString:@" "];
        [mFuelLevel appendString:oilMassUnit];
        oilMassNum.text = mFuelLevel;
    }
    else
    {
        NSMutableString *mFuelLevel = [NSMutableString stringWithString:statusData.mFuelLevel];
        [mFuelLevel appendString:@" "];
        [mFuelLevel appendString:oilMassUnit];
        oilMassNum.text = mFuelLevel;
        if([statusData.mFuelLevelState intValue] == 1)
        {
            oilMassNum.textColor = [UIColor colorWithRed:255/255 green:0/255 blue:0/255 alpha:1];
        }
    }
    
    
    //刷新时间 = 本地时间-上报时间
    //本地当前时间
    NSDate *date = [NSDate date];
 //   NSTimeInterval a = [date timeIntervalSince1970];
    //上报时间
    NSString *mUploadTime = statusData.mUploadTime;
    if (mUploadTime == nil)
    {
        NSString * unitType = [oRes getText:@"Car.vehicleStatusViewController.error"];
        refreshTimeTitleNum.text = [NSString stringWithString:unitType];
    }
    else
    {
        NSDate *uploadTime = [NSDate dateWithTimeIntervalSince1970:[mUploadTime doubleValue]/1000];
        double intervalTime = fabs([date timeIntervalSinceDate:uploadTime]);
        NSDictionary *stateDic = [self getTimeState:intervalTime];
        [self refreshTime:stateDic];
    }
}
/*!
 @method refreshloadstateData
 @abstract 通知重新从数据库中加载车辆的状态数据
 @discussion 通知重新从数据库中加载车辆的状态数据
 @result 无
 */
- (void)refreshloadstateData:(NSNotification *)notification
{
    [self loadstateData];
}
/*!
 @method getTimeState
 @abstract 判断车辆状态刷新事件的显示方式，之后存入字典
 @discussion 判断车辆状态刷新事件的显示方式，之后存入字典
 @result 无
 */
- (NSMutableDictionary*)getTimeState:(double)secs
{
    int stateTime = 0;
    int timeNum = 0;
    NSMutableDictionary *timeDic = [[NSMutableDictionary alloc] initWithCapacity:2];
    if (secs <60 )
    {
        stateTime = MOMENT;
    }
    else if(secs >60 && secs< 3600)
    {
        stateTime = MINUTE;
        timeNum = secs/60;
    }
    else if (secs >3600 && secs < 86400)
    {
        stateTime = HOUR;
        timeNum = secs/3600;
    }
    else if (secs > 86400)
    {
        stateTime = DAY;
        timeNum = secs/86400;
    }
    else
    {
        stateTime = ERROR;
        timeNum = ERROR;
    }
    [timeDic setObject:[NSNumber numberWithInt:stateTime] forKey:@"stateTimeKey"];
    [timeDic setObject:[NSNumber numberWithInt:timeNum] forKey:@"timeNumKey"];
    
    return timeDic;
}
/*!
 @method refreshTime
 @abstract 将字典中的时间显示方式，提取出来，显示在UI上
 @discussion 将字典中的时间显示方式，提取出来，显示在UI上
 @result 无
 */
- (void)refreshTime:(NSDictionary *)timeDic
{
    
    Resources *oRes = [Resources getInstance];
    NSString *unitType;
    NSMutableString *TimeStringAll;
    
    int timeIndex = [[timeDic objectForKey:@"stateTimeKey"]intValue];
    int timeNum = [[timeDic objectForKey:@"timeNumKey"]intValue];
    switch (timeIndex)
    {
           
        case 1:
            unitType = [oRes getText:@"Car.vehicleStatusViewController.moment"];
            refreshTimeTitleNum.text = [NSString stringWithString:unitType];
            break;
        case 2:
            unitType = [oRes getText:@"Car.vehicleStatusViewController.minute"];
            TimeStringAll = [NSMutableString stringWithFormat:@"%d",timeNum];
            [TimeStringAll appendString:unitType];
            refreshTimeTitleNum.text = TimeStringAll;
            break;
        case 3:
            unitType = [oRes getText:@"Car.vehicleStatusViewController.hour"];
            TimeStringAll = [NSMutableString stringWithFormat:@"%d",timeNum];
            [TimeStringAll appendString:unitType];
            refreshTimeTitleNum.text = TimeStringAll;
            break;
        case 4:
            unitType = [oRes getText:@"Car.vehicleStatusViewController.day"];
            TimeStringAll = [NSMutableString stringWithFormat:@"%d",timeNum];
            [TimeStringAll appendString:unitType];
            refreshTimeTitleNum.text = TimeStringAll;
            break;
        case 5:
            unitType = [oRes getText:@"Car.vehicleStatusViewController.error"];
            refreshTimeTitleNum.text = [NSString stringWithString:unitType];
            break;
    }
}


/*!
 @method sendrequest
 @abstract 车辆状态刷新按钮的事件
 @discussion 车辆状态刷新按钮的事件
 @result 无
 */
- (void)sendrequest
{
    App *app = [App getInstance];
    Resources *oRes = [Resources getInstance];
    CherryDBControl *cherryDBControl = [CherryDBControl sharedCherryDBControl];
    VehicleStatusInformMessageData *statusData = [cherryDBControl loadVehicleStatusByVin:@"demo_vin"];
    if (app.mUserData.mType == USER_LOGIN_DEMO)
    {
        NSDate *date = [NSDate date];
        
        //上报时间
        NSString *mUploadTime =statusData.mUploadTime;
        
        NSDate *uploadTime = [NSDate dateWithTimeIntervalSince1970:[mUploadTime doubleValue]/1000];
        double intervalTime = fabs([date timeIntervalSinceDate:uploadTime]);
        
        NSDictionary *stateDic = [self getTimeState:intervalTime];
        [self refreshTime:stateDic];
         [self MBProgressHUDMessage:[oRes getText:@"Car.vehicleStatusViewController.noLogin"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];

    }
    else
    {
        self.progressHUD.labelText = [oRes getText:@"Car.vehicleStatus.loading.titleText"];
        self.progressHUD.detailsLabelText= [oRes getText:@"Car.vehicleStatus.loading.detailtext"];
        [self.progressHUD show:YES];
        
        VehicleStatusNetManager *vehicleStatusNet = [[VehicleStatusNetManager alloc]init];
        [vehicleStatusNet createRequest:[app getCarData].mVin];
        [vehicleStatusNet sendRequestWithAsync:self];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    }
    

}

#pragma mark - net Delegate
/*!
 @method sendrequest
 @abstract 车辆状态刷新网络请求的执行结果（是否成功）
 @discussion 车辆状态刷新网络请求的执行结果（是否成功）
 @result 无
 */
- (void)onVehicleStatusResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg;
{
    NSLog(@"receive the result of VehicleStatusResult.");
    [self.progressHUD hide:YES];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    Resources *oRes = [Resources getInstance];
    if (NAVINFO_RESULT_SUCCESS == code)
    {
        
        [self MBProgressHUDMessage:[oRes getText:@"Car.vehicleStatusViewController.success"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];

    }
    else if(code == NET_ERROR)
    {
        [self MBProgressHUDMessage:[oRes getText:@"common.noNetAlert.message"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
        
    }
    else if(code == NAVINFO_VEHICLE_STATUS_EXECUTING)
    {
        [self MBProgressHUDMessage:[oRes getText:@"Car.vehicleStatusViewController.executing"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
        
    }
    else if(NAVINFO_TOKENID_INVALID == code)//TokenID失效处理
    {
        [self MBProgressHUDMessage:[oRes getText:@"common.loseTokenID.message"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
        

    }
    else
    {
        NSLog(@"Errors on reveice result.");
        [self MBProgressHUDMessage:[oRes getText:@"Car.vehicleStatusViewController.failure"] delayTime:2 xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];

    }
    

}
#pragma mark -MBProgressHUDMessage
//message:提示内容 time：消失延迟时间（s） xOffset:相对屏幕中心点的X轴偏移 yOffset:相对屏幕中心点的Y轴偏移
- (void)MBProgressHUDMessage:(NSString *)message delayTime:(int)time xOffset:(float)xOffset yOffset:(float)yOffset
{
    MBProgressHUD *progressHUDMessage = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    progressHUDMessage.OffsetFlag = 1;
    progressHUDMessage.mode = MBProgressHUDModeText;
	progressHUDMessage.labelText = message;
	progressHUDMessage.margin = 10.f;
    progressHUDMessage.xOffset = xOffset;
    progressHUDMessage.yOffset = yOffset;
	progressHUDMessage.removeFromSuperViewOnHide = YES;
	[progressHUDMessage hide:YES afterDelay:time];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:Notification_New_VehicleStatus object:nil];
    [refreshTimeTitle release];
    [refreshTimeTitleNum release];
    [leftFrontTirePressure release];
    [leftRearTirePressure release];
    [rightFrontTirePressure release];
    [rightRearTirePressure release];
    [temperatureInCarTitle release];
    [temperatureInCarNum release];
    [mileageTitle release];
    [mileageNum release];
    [oilWearTitle release];
    [oilWearNum release];
    [oilMassTitle release];
    [oilMassNum release];
    
    if (_progressHUD){
        [_progressHUD removeFromSuperview];
        [_progressHUD release];
        _progressHUD = nil;
    }
    [speedIconImage release];
    [oilWearImage release];
    [oilMassImage release];
    [speedIconDiviner release];
    [oilWearImageDiviner release];
    [oilMassImageDiviner release];
    [carImage release];
    [leftFrontDoor release];
    [leftRearDoor release];
    [rightFrontDoor release];
    [rightRearDoor release];
    [frontLight release];
    [rearLight release];
    [super dealloc];
}
- (void)viewDidUnload {
    [refreshTimeTitle release];
    refreshTimeTitle = nil;
    [refreshTimeTitleNum release];
    refreshTimeTitleNum = nil;
    [leftFrontTirePressure release];
    leftFrontTirePressure = nil;
    [leftRearTirePressure release];
    leftRearTirePressure = nil;
    [rightFrontTirePressure release];
    rightFrontTirePressure = nil;
    [rightRearTirePressure release];
    rightRearTirePressure = nil;
    [temperatureInCarTitle release];
    temperatureInCarTitle = nil;
    [temperatureInCarNum release];
    temperatureInCarNum = nil;
    [mileageTitle release];
    mileageTitle = nil;
    [mileageNum release];
    mileageNum = nil;
    [oilWearTitle release];
    oilWearTitle = nil;
    [oilWearNum release];
    oilWearNum = nil;
    [oilMassTitle release];
    oilMassTitle = nil;
    [oilMassNum release];
    oilMassNum = nil;
    [speedIconImage release];
    speedIconImage = nil;
    [oilWearImage release];
    oilWearImage = nil;
    [oilMassImage release];
    oilMassImage = nil;
    [speedIconDiviner release];
    speedIconDiviner = nil;
    [oilWearImageDiviner release];
    oilWearImageDiviner = nil;
    [oilMassImageDiviner release];
    oilMassImageDiviner = nil;
    [carImage release];
    carImage = nil;
    [leftFrontDoor release];
    leftFrontDoor = nil;
    [leftRearDoor release];
    leftRearDoor = nil;
    [rightFrontDoor release];
    rightFrontDoor = nil;
    [rightRearDoor release];
    rightRearDoor = nil;
    [frontLight release];
    frontLight = nil;
    [rearLight release];
    rearLight = nil;
    [super viewDidUnload];
}
@end
