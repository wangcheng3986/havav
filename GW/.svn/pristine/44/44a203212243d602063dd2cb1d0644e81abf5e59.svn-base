
/*!
 @header MessageViewController.m
 @abstract 消息分类
 @author mengy
 @version 1.00 13-5-2 Creation
 */
#import "MessageViewController.h"
#import "App.h"
#import "ElectronicFenceViewController.h"
#import "LocationRequestViewController.h"
#import "FriendLocationViewController.h"
#import "SendToCarViewController.h"
#import "SystemMessageViewController.h"
@interface MessageViewController ()
{
    int locReqCount;
    int friendLocCount;
    int send2carCount;
    int elecFenceCount;
    int vehicleControlCount;
    int vehicleDiagnosisCount;
    int vehicleAbnormalAlarmCount;
    int maintenanceAlarmCount;
    UIBarButtonItem *leftBarBtnItem;
}
@end

@implementation MessageViewController

@synthesize picUrlString = _picUrlString;
@synthesize imageView = _imageView;
@synthesize progressHUD = _progressHUD;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
        [titleLabel release] ,titleLabel = nil;
        [backBtn release] ,backBtn = nil;
    if (childBackBtn) {
        [childBackBtn release];
        childBackBtn = nil;
    }
    if (leftBarBtnItem) {
        [leftBarBtnItem release];
        leftBarBtnItem = nil;
    }
    if (sectionOneCountMutableArray) {
        [sectionOneCountMutableArray removeAllObjects];
        [sectionOneCountMutableArray release];
        sectionOneCountMutableArray = nil;
    }
    if (sectionTwoCountMutableArray) {
        [sectionTwoCountMutableArray removeAllObjects];
        [sectionTwoCountMutableArray release];
        sectionTwoCountMutableArray = nil;
    }
    if (sectionThreeCountMutableArray) {
        [sectionThreeCountMutableArray removeAllObjects];
        [sectionThreeCountMutableArray release];
        sectionThreeCountMutableArray = nil;
    }
    if (sectionOneMutableArray) {
        [sectionOneMutableArray removeAllObjects];
        [sectionOneMutableArray release];
        sectionOneMutableArray = nil;
    }
    if (sectionTwoMutableArray) {
        [sectionTwoMutableArray removeAllObjects];
        [sectionTwoMutableArray release];
        sectionTwoMutableArray = nil;
    }
    if (sectionThreeMutableArray) {
        [sectionThreeMutableArray removeAllObjects];
        [sectionThreeMutableArray release];
        sectionThreeMutableArray = nil;
    }
    if (sectionOneIconMutableArray) {
        [sectionOneIconMutableArray removeAllObjects];
        [sectionOneIconMutableArray release];
        sectionOneIconMutableArray = nil;
    }
    if (sectionOneIconMutableArray) {
        [sectionOneIconMutableArray removeAllObjects];
        [sectionOneIconMutableArray release];
        sectionOneIconMutableArray = nil;
    }
    if (sectionOneIconMutableArray) {
        [sectionOneIconMutableArray removeAllObjects];
        [sectionOneIconMutableArray release];
        sectionOneIconMutableArray = nil;
    }
    if (_imageView) {
        [_imageView removeFromSuperview];
        [_imageView release];
        _imageView = nil;
    }
    [super dealloc];
}

/*!
 @method viewDidLoad
 @abstract 加载界面信息，初始化数据
 @discussion 加载界面信息，初始化数据
 @param 无
 @result 无
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    if([App getVersion]>=IOS_VER_7){
        [App ios7ViewLocation:self];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_ios7_navBar_bg"] forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_ios6_navBar_bg"] forBarMetrics:UIBarMetricsLandscapePhone];
    }
    Resources *oRes = [Resources getInstance];
//    titleLabel.text=[oRes getText:@"message.MessageViewController.title"];
//    titleLabel.font =[UIFont navBarTitleSize];
//    titleLabel.textColor=[UIColor whiteColor];
//    self.navigationItem.titleView=titleLabel;
    
    self.navigationItem.title = [oRes getText:@"message.MessageViewController.title"];

    backBtn = [[HomeButton alloc]init];
    childBackBtn = [[LeftButton alloc]init];
    [backBtn addTarget:self action:@selector(popself)forControlEvents:UIControlEventTouchUpInside];
    leftBarBtnItem =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftBarBtnItem;
    
    self.view.backgroundColor = [UIColor colorWithRed:231.0/255.0f green:231.0/255.0f blue:231.0/255.0f alpha:1];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNewMessage:) name:Notification_New_Message object:nil];
    
    [self loadTableViewMessageCount];
    [self loadTableViewMessage];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    Resources *oRes = [Resources getInstance];
    [backBtn setTitle:[oRes getText:@"common.HomeButtonTitle"] forState:UIControlStateNormal];
    
    [self loadTableViewMessageCount];
    [messageTableView reloadData];
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

/*!
 @method loadTableViewMessage
 @abstract 加载界面显示信息
 @discussion 加载界面显示信息
 @param 无
 @result 无
 */
-(void)loadTableViewMessage
{
    Resources *oRes = [Resources getInstance];
    sectionOneMutableArray = [[NSMutableArray alloc]initWithCapacity:0];
    sectionTwoMutableArray = [[NSMutableArray alloc]initWithCapacity:0];
    sectionThreeMutableArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    sectionOneIconMutableArray = [[NSMutableArray alloc]initWithCapacity:0];
    sectionTwoIconMutableArray = [[NSMutableArray alloc]initWithCapacity:0];
    sectionThreeIconMutableArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    [sectionOneMutableArray addObject:[oRes getText:@"message.MessageViewController.locationRequestButton"]];
    [sectionOneMutableArray addObject:[oRes getText:@"message.MessageViewController.friendLocationButton"]];
    [sectionOneMutableArray addObject:[oRes getText:@"message.MessageViewController.sendToCarButton"]];
    [sectionOneMutableArray addObject:[oRes getText:@"message.MessageViewController.controlResultButton"]];
    [sectionTwoMutableArray addObject:[oRes getText:@"message.MessageViewController.elecronicFenceButton"]];
    [sectionTwoMutableArray addObject:[oRes getText:@"message.MessageViewController.abnormalAlarmButton"]];
    [sectionThreeMutableArray addObject:[oRes getText:@"message.MessageViewController.maintenanceAlarmButton"]];
    [sectionThreeMutableArray addObject:[oRes getText:@"message.MessageViewController.diagnosisResultButton"]];
    
    [sectionOneIconMutableArray addObject:@"message_main_requestposition_icon"];
    [sectionOneIconMutableArray addObject:@"message_main_friendposition_icon"];
    [sectionOneIconMutableArray addObject:@"message_main_sendtocar_icon"];
    App *app = [App getInstance];
    if (app.userAccountState == USER_ACCOUNT_STATE_ALL_FUNCTION)
    {
        [sectionOneIconMutableArray addObject:@"message_main_controlresult_icon"];
        [sectionTwoIconMutableArray addObject:@"message_main_elecfence_icon"];
        [sectionTwoIconMutableArray addObject:@"message_main_vehicleabnormal_icon"];
        [sectionThreeIconMutableArray addObject:@"message_main_maintance_icon"];
        [sectionThreeIconMutableArray addObject:@"message_main_diagnosis_icon"];
        
    }
    else
    {
        [sectionOneIconMutableArray addObject:@"message_main_controlresult_disabled_icon"];
        [sectionTwoIconMutableArray addObject:@"message_main_elecfence_disabled_icon"];
        [sectionTwoIconMutableArray addObject:@"message_main_vehicleabnormal_disabled_icon"];
        [sectionThreeIconMutableArray addObject:@"message_main_maintance_disabled_icon"];
        [sectionThreeIconMutableArray addObject:@"message_main_diagnosis_disabled_icon"];
    }
    
    
    
    
}

/*!
 @method loadTableViewMessageCount
 @abstract 加载消息数量
 @discussion 加载消息数量
 @param 无
 @result 无
 */
-(void)loadTableViewMessageCount
{
    App *app = [App getInstance];
    if (sectionOneCountMutableArray == nil) {
        sectionOneCountMutableArray = [[NSMutableArray alloc]initWithCapacity:0];
    }
    else
    {
        [sectionOneCountMutableArray removeAllObjects];
    }
    if (sectionTwoCountMutableArray == nil) {
        sectionTwoCountMutableArray = [[NSMutableArray alloc]initWithCapacity:0];
    }
    else
    {
        [sectionTwoCountMutableArray removeAllObjects];
    }
    if (sectionThreeCountMutableArray == nil) {
        sectionThreeCountMutableArray = [[NSMutableArray alloc]initWithCapacity:0];
    }
    else
    {
        [sectionThreeCountMutableArray removeAllObjects];
    }
    [sectionOneCountMutableArray addObject:[NSString stringWithFormat:@"%d",[app loadMessageCountWithType:MESSAGE_FRIEND_REQUEST_LOCATION]]];
    [sectionOneCountMutableArray addObject:[NSString stringWithFormat:@"%d",[app loadMessageCountWithType:MESSAGE_FRIEND_LOCATION]]];
    [sectionOneCountMutableArray addObject:[NSString stringWithFormat:@"%d",[app loadMessageCountWithType:MESSAGE_SEND_TO_CAR]]];
    [sectionOneCountMutableArray addObject:[NSString stringWithFormat:@"%d",[app loadMessageCountWithType:MESSAGE_VEHICLE_CONTROL]]];
    [sectionTwoCountMutableArray addObject:[NSString stringWithFormat:@"%d",[app loadMessageCountWithType:MESSAGE_ELECTRONIC]]];
    [sectionTwoCountMutableArray addObject:[NSString stringWithFormat:@"%d",[app loadMessageCountWithType:MESSAGE_VEHICLE_ABNORMAL_ALARM]]];
    [sectionThreeCountMutableArray addObject:[NSString stringWithFormat:@"%d",[app loadMessageCountWithType:MESSAGE_MAINTENANCE_ALARM]]];
    [sectionThreeCountMutableArray addObject:[NSString stringWithFormat:@"%d",[app loadMessageCountWithType:MESSAGE_VEHICLE_DIAGNOSIS]]];
}



/*!
 @method initMessageCount
 @abstract 初始化message count
 @discussion 初始化message count
 @param 无
 @result 无
 */
-(void)initMessageCount
{
    App *app = [App getInstance];

    locReqCount=[app loadMessageCountWithType:MESSAGE_FRIEND_REQUEST_LOCATION];
    friendLocCount=[app loadMessageCountWithType:MESSAGE_FRIEND_LOCATION];
    send2carCount=[app loadMessageCountWithType:MESSAGE_SEND_TO_CAR];
    elecFenceCount=[app loadMessageCountWithType:MESSAGE_ELECTRONIC];
    vehicleControlCount=[app loadMessageCountWithType:MESSAGE_VEHICLE_CONTROL];
    vehicleDiagnosisCount=[app loadMessageCountWithType:MESSAGE_VEHICLE_DIAGNOSIS];
    vehicleAbnormalAlarmCount=[app loadMessageCountWithType:MESSAGE_VEHICLE_ABNORMAL_ALARM];
    maintenanceAlarmCount=[app loadMessageCountWithType:MESSAGE_MAINTENANCE_ALARM];
}



/*!
 @method popself
 @abstract 返回上一页
 @discussion 返回上一页
 @param 无
 @result 无
 */
-(void)popself
{
    [self.navigationController popViewControllerAnimated:YES];
}

/*!
 @method createBackButton
 @abstract 创建返回按钮
 @discussion 创建返回按钮
 @param 无
 @result UIBarButtonItem
 */
-(UIBarButtonItem*) createBackButton
{
    [childBackBtn addTarget:self action:@selector(popself)forControlEvents:UIControlEventTouchUpInside];
    return [[[UIBarButtonItem alloc]initWithCustomView:childBackBtn] autorelease];
    
}


/*!
 @method goElectronicFence
 @abstract 进入电子围栏消息界面
 @discussion 进入电子围栏消息界面
 @param 无
 @result 无
 */
-(void)goElectronicFence
{
    //App *app = [App getInstance];
    ElectronicFenceViewController *electronicFenceViewController = [[ElectronicFenceViewController alloc] init];
    electronicFenceViewController.navigationItem.leftBarButtonItem =[self createBackButton];
    [self.navigationController pushViewController:electronicFenceViewController animated:YES];
    [electronicFenceViewController release];
}

/*!
 @method goLocationRequest
 @abstract 进入位置请求消息界面
 @discussion 进入位置请求消息界面
 @param 无
 @result 无
 */
-(void)goLocationRequest
{
    LocationRequestViewController *locationRequestViewController = [[LocationRequestViewController alloc] init];
    locationRequestViewController.navigationItem.leftBarButtonItem =[self createBackButton];
    [self.navigationController pushViewController:locationRequestViewController animated:YES];
    [locationRequestViewController release];
}

/*!
 @method goFriendLocation
 @abstract 进入车友位置消息界面
 @discussion 进入车友位置消息界面
 @param 无
 @result 无
 */
-(void)goFriendLocation
{

    FriendLocationViewController *friendLocationViewController = [[FriendLocationViewController alloc] init];
    friendLocationViewController.navigationItem.leftBarButtonItem =[self createBackButton];
    [self.navigationController pushViewController:friendLocationViewController animated:YES];
    [friendLocationViewController release];
}

/*!
 @method goSendToCar
 @abstract 进入发送到车消息界面
 @discussion 进入发送到车消息界面
 @param 无
 @result 无
 */
-(void)goSendToCar
{

    SendToCarViewController *sendToCarViewController = [[SendToCarViewController alloc] init];
    sendToCarViewController.navigationItem.leftBarButtonItem =[self createBackButton];
    [self.navigationController pushViewController:sendToCarViewController animated:YES];
    [sendToCarViewController release];
}

/*!
 @method goVehicleControl
 @abstract 进入车辆控制消息界面
 @discussion 进入车辆控制消息界面
 @param 无
 @result 无
 */
-(void)goVehicleControl
{
    
    VehicleControlInformViewController *vehicleControlInformVC = [[VehicleControlInformViewController alloc] init];
    vehicleControlInformVC.navigationItem.leftBarButtonItem =[self createBackButton];
    [self.navigationController pushViewController:vehicleControlInformVC animated:YES];
    [vehicleControlInformVC release];
}

/*!
 @method goVehicleDiagnosis
 @abstract 进入车辆诊断消息界面
 @discussion 进入车辆诊断消息界面
 @param 无
 @result 无
 */
-(void)goVehicleDiagnosis
{
    
    VehicleDiagnosisInformViewController *vehicleDiagnosisInformVC = [[VehicleDiagnosisInformViewController alloc] init];
    vehicleDiagnosisInformVC.navigationItem.leftBarButtonItem =[self createBackButton];
    [self.navigationController pushViewController:vehicleDiagnosisInformVC animated:YES];
    [vehicleDiagnosisInformVC release];
}


/*!
 @method goVehicleAbnormalAlarm
 @abstract 进入车辆异常报警消息界面
 @discussion 进入车辆异常报警消息界面
 @param 无
 @result 无
 */
-(void)goVehicleAbnormalAlarm
{
    
    VehiclesAbnormalAlarmViewController *vehiclesAbnormalAlarmVC = [[VehiclesAbnormalAlarmViewController alloc] init];
    vehiclesAbnormalAlarmVC.navigationItem.leftBarButtonItem =[self createBackButton];
    [self.navigationController pushViewController:vehiclesAbnormalAlarmVC animated:YES];
    [vehiclesAbnormalAlarmVC release];
}

/*!
 @method goMaintenanceAlert
 @abstract 进入保养提醒消息界面
 @discussion 进入保养提醒消息界面
 @param 无
 @result 无
 */
-(void)goMaintenanceAlert
{
    
    MaintenanceAlertInformViewController *maintenanceAlertInformVC = [[MaintenanceAlertInformViewController alloc] init];
    maintenanceAlertInformVC.navigationItem.leftBarButtonItem =[self createBackButton];
    [self.navigationController pushViewController:maintenanceAlertInformVC animated:YES];
    [maintenanceAlertInformVC release];
}

/*!
 @method goSystemMessage：
 @abstract 进入系统消息界面
 @discussion 进入系统消息界面
 @param 无
 @result 无
 */
-(IBAction)goSystemMessage:(id)sender
{
    SystemMessageViewController *systemMessageViewController = [[SystemMessageViewController alloc] init];
    systemMessageViewController.navigationItem.leftBarButtonItem =[self createBackButton];
    [self.navigationController pushViewController:systemMessageViewController animated:YES];
    [systemMessageViewController release];
}

/*!
 @method showNewMessage：
 @abstract 接收到新消息通知，刷新消息数据
 @discussion 接收到新消息通知，刷新消息数据
 @param notification 通知
 @result 无
 */
- (void)showNewMessage:(NSNotification*) notification
{
    id obj = [notification object];
    NSLog(@"%@",obj);
    int newMessageCount = [obj integerValue];
    
    if (newMessageCount > 0)
    {
        [self loadTableViewMessageCount];
        [messageTableView reloadData];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Table View Data Source Methods
//返回分组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

//返回行数
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return sectionOneMutableArray.count;
            break;
        case 1:
            return sectionTwoMutableArray.count;
            break;
        case 2:
            return sectionThreeMutableArray.count;
            break;
            
        default:
            return 0;
            break;
    };
    
}

#pragma mark -
#pragma mark Table View delegate
/*!
 @method tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 @abstract 新建某一行并返回
 @discussion 新建某一行并返回
 @param tableView，indexPath
 @result cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Resources *oRes = [Resources getInstance];
    App *app = [App getInstance];
    static NSString *identifier = @"naviIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MessageViewCell" owner:self options:nil] lastObject];
    }
    
    NSUInteger row = [indexPath row];
    
    UIImageView *icon = (UIImageView *)[cell viewWithTag:1];
    UILabel *title = (UILabel*)[cell viewWithTag:2];
    UIImageView *detailIcon = (UIImageView *)[cell viewWithTag:3];
    UIImageView *line = (UIImageView *)[cell viewWithTag:4];
    UIImageView *messageCountBg = (UIImageView *)[cell viewWithTag:5];
    UILabel *messageCount = (UILabel*)[cell viewWithTag:6];
    
    title.font = [UIFont size14];
    title.textColor = [UIColor colorWithRed:89.0/255.0f green:89.0/255.0f blue:89.0/255.0f alpha:1];
    messageCount.font = [UIFont size13];
    messageCount.textColor = [UIColor whiteColor];
    switch (indexPath.section) {
        case 0:
            title.text = [sectionOneMutableArray objectAtIndex:row];
            [icon setImage:[UIImage imageNamed:[sectionOneIconMutableArray objectAtIndex:row]]];
            if (row == 3) {
                line.hidden =YES;
                if (app.userAccountState == USER_ACCOUNT_STATE_PART_FUNCTION) {
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
            }
            if ([[sectionOneCountMutableArray objectAtIndex:row]intValue] > 0) {
                messageCountBg.hidden=NO;
                messageCount.hidden=NO;
                detailIcon.hidden=YES;
                if ([[sectionOneCountMutableArray objectAtIndex:row]intValue]<=9) {
                    [messageCountBg setImage:[UIImage imageNamed:@"message_count_icon"]];
                    messageCount.text=[sectionOneCountMutableArray objectAtIndex:row];
                    messageCountBg.frame = CGRectMake(messageCountBg.frame.origin.x, messageCountBg.frame.origin.y, MESSAGE_COUNT_IMG_MIN_WIDTH, messageCountBg.frame.size.height);
                    messageCount.frame = CGRectMake(messageCount.frame.origin.x, messageCount.frame.origin.y, MESSAGE_COUNT_LABEL_MIN_WIDTH, messageCount.frame.size.height);
                }
                else if ([[sectionOneCountMutableArray objectAtIndex:row]intValue]<=99)
                {
                    [messageCountBg setImage:[UIImage imageNamed:@"message_count_icon2"]];
                    messageCount.text=[sectionOneCountMutableArray objectAtIndex:row];
                    messageCountBg.frame = CGRectMake(messageCountBg.frame.origin.x-5, messageCountBg.frame.origin.y, MESSAGE_COUNT_IMG_WIDTH, messageCountBg.frame.size.height);
                    messageCount.frame = CGRectMake(messageCount.frame.origin.x-3, messageCount.frame.origin.y, MESSAGE_COUNT_LABEL_WIDTH, messageCount.frame.size.height);
                }
                else
                {
                    [messageCountBg setImage:[UIImage imageNamed:@"message_count_icon3"]];
                    messageCount.text=[NSString stringWithFormat:@"99+"];
                    messageCountBg.frame = CGRectMake(messageCountBg.frame.origin.x-13, messageCountBg.frame.origin.y, MESSAGE_COUNT_IMG_MAX_WIDTH, messageCountBg.frame.size.height);
                    messageCount.frame = CGRectMake(messageCount.frame.origin.x-7, messageCount.frame.origin.y, MESSAGE_COUNT_LABEL_MAX_WIDTH, messageCount.frame.size.height);
                }
                
            }
            else
            {
                messageCountBg.hidden=YES;
                messageCount.hidden=YES;
                detailIcon.hidden=NO;
            }
            break;
        case 1:
            if (app.userAccountState == USER_ACCOUNT_STATE_PART_FUNCTION) {
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            title.text = [sectionTwoMutableArray objectAtIndex:row];
            [icon setImage:[UIImage imageNamed:[sectionTwoIconMutableArray objectAtIndex:row]]];
            if (row == 1) {
                line.hidden =YES;
            }
            if ([[sectionTwoCountMutableArray objectAtIndex:row]intValue] > 0) {
                messageCountBg.hidden=NO;
                messageCount.hidden=NO;
                detailIcon.hidden=YES;
                if ([[sectionTwoCountMutableArray objectAtIndex:row]intValue]<=9) {
                    [messageCountBg setImage:[UIImage imageNamed:@"message_count_icon"]];
                    messageCount.text=[sectionTwoCountMutableArray objectAtIndex:row];
                    messageCountBg.frame = CGRectMake(messageCountBg.frame.origin.x, messageCountBg.frame.origin.y, MESSAGE_COUNT_IMG_MIN_WIDTH, messageCountBg.frame.size.height);
                    messageCount.frame = CGRectMake(messageCount.frame.origin.x, messageCount.frame.origin.y, MESSAGE_COUNT_LABEL_MIN_WIDTH, messageCount.frame.size.height);
                }
                else if ([[sectionTwoCountMutableArray objectAtIndex:row]intValue]<=99)
                {
                    [messageCountBg setImage:[UIImage imageNamed:@"message_count_icon2"]];
                    messageCount.text=[sectionTwoCountMutableArray objectAtIndex:row];
                    messageCount.text=[NSString stringWithFormat:@"99"];
                    messageCountBg.frame = CGRectMake(messageCountBg.frame.origin.x-5, messageCountBg.frame.origin.y, MESSAGE_COUNT_IMG_WIDTH, messageCountBg.frame.size.height);
                    messageCount.frame = CGRectMake(messageCount.frame.origin.x-3, messageCount.frame.origin.y, MESSAGE_COUNT_LABEL_WIDTH, messageCount.frame.size.height);
                }
                else
                {
                    [messageCountBg setImage:[UIImage imageNamed:@"message_count_icon3"]];
                    messageCount.text=[NSString stringWithFormat:@"99+"];
                    messageCountBg.frame = CGRectMake(messageCountBg.frame.origin.x-13, messageCountBg.frame.origin.y, MESSAGE_COUNT_IMG_MAX_WIDTH, messageCountBg.frame.size.height);
                    messageCount.frame = CGRectMake(messageCount.frame.origin.x-7, messageCount.frame.origin.y, MESSAGE_COUNT_LABEL_MAX_WIDTH, messageCount.frame.size.height);
                }
            }
            else
            {
                messageCountBg.hidden=YES;
                messageCount.hidden=YES;
                detailIcon.hidden=NO;
            }
            break;
        case 2:
            if (app.userAccountState == USER_ACCOUNT_STATE_PART_FUNCTION) {
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            title.text = [sectionThreeMutableArray objectAtIndex:row];
            [icon setImage:[UIImage imageNamed:[sectionThreeIconMutableArray objectAtIndex:row]]];
            if (row == 1) {
                line.hidden =YES;
            }
            if ([[sectionThreeCountMutableArray objectAtIndex:row]intValue] > 0) {
                messageCountBg.hidden=NO;
                messageCount.hidden=NO;
                detailIcon.hidden=YES;
                if ([[sectionThreeCountMutableArray objectAtIndex:row]intValue]<=9) {
                    [messageCountBg setImage:[UIImage imageNamed:@"message_count_icon"]];
                    messageCount.text=[sectionThreeCountMutableArray objectAtIndex:row];
                    messageCountBg.frame = CGRectMake(messageCountBg.frame.origin.x, messageCountBg.frame.origin.y, MESSAGE_COUNT_IMG_MIN_WIDTH, messageCountBg.frame.size.height);
                    messageCount.frame = CGRectMake(messageCount.frame.origin.x, messageCount.frame.origin.y, MESSAGE_COUNT_LABEL_MIN_WIDTH, messageCount.frame.size.height);
                }
                else if ([[sectionThreeCountMutableArray objectAtIndex:row]intValue]<=99)
                {
                    [messageCountBg setImage:[UIImage imageNamed:@"message_count_icon2"]];
                    messageCount.text=[sectionThreeCountMutableArray objectAtIndex:row];
                    messageCountBg.frame = CGRectMake(messageCountBg.frame.origin.x-5, messageCountBg.frame.origin.y, MESSAGE_COUNT_IMG_WIDTH, messageCountBg.frame.size.height);
                    messageCount.frame = CGRectMake(messageCount.frame.origin.x-3, messageCount.frame.origin.y, MESSAGE_COUNT_LABEL_WIDTH, messageCount.frame.size.height);
                }
                else
                {
                    [messageCountBg setImage:[UIImage imageNamed:@"message_count_icon3"]];
                    messageCount.text=[NSString stringWithFormat:@"99+"];
                    messageCountBg.frame = CGRectMake(messageCountBg.frame.origin.x-13, messageCountBg.frame.origin.y, MESSAGE_COUNT_IMG_MAX_WIDTH, messageCountBg.frame.size.height);
                    messageCount.frame = CGRectMake(messageCount.frame.origin.x-7, messageCount.frame.origin.y, MESSAGE_COUNT_LABEL_MAX_WIDTH, messageCount.frame.size.height);
                }
            }
            else
            {
                messageCountBg.hidden=YES;
                messageCount.hidden=YES;
                detailIcon.hidden=NO;
            }
            break;
            
        default:
            break;
    }
	return cell;
}


/*!
 @method tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 @abstract 设置列表是否可编辑
 @discussion 设置列表是否可编辑
 @param tableView，indexPath
 @result bool
 */
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}


/*!
 @method tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 @abstract 选择某行进入详情
 @discussion 选择某行进入详情
 @param tableView，indexPath
 @result 无
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    App *app = [App getInstance];
    if (app.userAccountState == USER_ACCOUNT_STATE_ALL_FUNCTION)
    {
        switch (indexPath.section) {
            case 0:
                switch (row) {
                    case 0:
                        [self goLocationRequest];
                        break;
                    case 1:
                        [self goFriendLocation];
                        break;
                    case 2:
                        [self goSendToCar];
                        break;
                    case 3:
                        [self goVehicleControl];
                        break;
                    default:
                        break;
                }
                break;
            case 1:
                switch (row) {
                    case 0:
                        [self goElectronicFence];
                        break;
                    case 1:
                        [self goVehicleAbnormalAlarm];
                        break;
                    default:
                        break;
                }
                break;
            case 2:
                switch (row) {
                    case 0:
                        [self goMaintenanceAlert];
                        break;
                    case 1:
                        [self goVehicleDiagnosis];
                        break;
                    default:
                        break;
                }
                break;
            default:
                break;
        }
        
    }
    else
    {
        switch (indexPath.section) {
            case 0:
                switch (row) {
                    case 0:
                        [self goLocationRequest];
                        break;
                    case 1:
                        [self goFriendLocation];
                        break;
                    case 2:
                        [self goSendToCar];
                        break;
                    default:
                        [self unopenedAlert];
                        break;
                }
                break;
            default:
                [self unopenedAlert];
                break;
        }
        
    }
    
}

-(void)unopenedAlert
{
    Resources *oRes = [Resources getInstance];
    [self MBProgressHUDMessage:[oRes getText:@"common.unopenedAlert"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
}

//message:提示内容 time：消失延迟时间（s） xOffset:相对屏幕中心点的X轴偏移 yOffset:相对屏幕中心点的Y轴偏移
- (void)MBProgressHUDMessage:(NSString *)message delayTime:(int)time xOffset:(float)xOffset yOffset:(float)yOffset
{
    MBProgressHUD *progressHUDMessage = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    progressHUDMessage.OffsetFlag =1;
    progressHUDMessage.mode = MBProgressHUDModeText;
	progressHUDMessage.labelText = message;
	progressHUDMessage.margin = 10.f;
    progressHUDMessage.xOffset = xOffset;
    progressHUDMessage.yOffset = yOffset;
	progressHUDMessage.removeFromSuperViewOnHide = YES;
	[progressHUDMessage hide:YES afterDelay:time];
    
}


@end
