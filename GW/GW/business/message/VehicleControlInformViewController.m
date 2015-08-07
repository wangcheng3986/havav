

/*!
 @header VehicleControlInformViewController.m
 @abstract 车辆控制消息类
 @author mengy
 @version 1.00 14-9-3 Creation
 */
#import "VehicleControlInformViewController.h"
#import "App.h"
@interface VehicleControlInformViewController ()
{
    UIBarButtonItem *rightButton;
    int editType;
}
@end

@implementation VehicleControlInformViewController
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
    
    [self.deleteMutableArray removeAllObjects];
    [self.deleteMutableArray release];
    self.deleteMutableArray=nil;
    [rightButton release];
    
    
    [vehicleControlInformTableView release],vehicleControlInformTableView = nil;
    [titleLabel release],titleLabel = nil;
    if (backBtn) {
        [backBtn release];
        backBtn = nil;
    }
    if (editBtn) {
        [editBtn release];
        editBtn = nil;
    }
    if (self.progressHUD){
        [self.progressHUD removeFromSuperview];
        [self.progressHUD release];
        self.progressHUD = nil;
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
    editType=EDIT;
    Resources *oRes = [Resources getInstance];
    mCherryDBControl = [CherryDBControl sharedCherryDBControl];
//    titleLabel.text=[oRes getText:@"message.VehicleControlInformViewController.Title"];
//    titleLabel.font =[UIFont navBarTitleSize];
//    titleLabel.textColor=[UIColor whiteColor];
//    self.navigationItem.titleView=titleLabel;
    
    self.navigationItem.title=[oRes getText:@"message.VehicleControlInformViewController.Title"];
    
    editBtn = [[RightButton alloc]init];
    backBtn = [[LeftButton alloc]init];
    [editBtn setTitle:[oRes getText:@"message.MessageViewController.editButton"] forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(editOrFinish)forControlEvents:UIControlEventTouchUpInside];
    editBtn.titleLabel.font =[UIFont navBarItemSize];
    rightButton=[[UIBarButtonItem alloc]initWithCustomView:editBtn];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    
    self.view.backgroundColor = [UIColor colorWithRed:231.0/255.0f green:231.0/255.0f blue:231.0/255.0f alpha:1];
    self.deleteMutableArray = [[NSMutableArray alloc] initWithCapacity:0];
    [self loadData];
    //当进入视图时，重新设置imageView
    [self.imageView setImage:nil];
    [self.imageView setFrame:CGRectMake(160, 200, 0, 0)];
    //显示加载等待框
    self.progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.progressHUD];
    [self.view bringSubviewToFront:self.progressHUD];
    self.progressHUD.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNewMessage:) name:Notification_New_Message object:nil];
    
}


/*!
 @method viewWillAppear：
 @abstract 重新加载本地数据
 @discussion 重新加载本地数据
 @param 无
 @result 无
 */
-(void)viewWillAppear:(BOOL)animated
{
    
    [self setMessageReader];
    [self loadData];
    [super viewWillAppear:animated];
}

/*!
 @method showNewMessage：
 @abstract 接收到新消息的广播
 @discussion 接收到新消息的广播
 @param 无
 @result 无
 */
- (void)showNewMessage:(NSNotification*) notification
{
    //    id obj = [notification object];
    //    NSLog(@"%@",obj);
    //    int newMessageCount = [obj integerValue];
    //
    //    if (newMessageCount > 0)
    //    {
    //        [self loadData];
    //    }
}


/*!
 @method setMessageReader
 @abstract 设置消息为已读
 @discussion 设置消息为已读
 @param 无
 @result 无
 */
-(void)setMessageReader
{
    if (self.vehicleControlInformMutableArray.count > 0) {
        NSString * keyIDs=[NSString stringWithFormat:@""];
        for (int i=0; i<self.vehicleControlInformMutableArray.count; i++) {
            VehicleControlInformMessageData *mdata = [self.vehicleControlInformMutableArray objectAtIndex:i];
            keyIDs=[NSString stringWithFormat:@"%@','%@",keyIDs,mdata.mMessageKeyID];
        }
        if (keyIDs.length >= 4) {
            keyIDs = [keyIDs substringFromIndex:3];
        }
       
        [[App getInstance] setMessageAsReaded:keyIDs];
    }
}

/*!
 @method loadData
 @abstract 加载本地消息
 @discussion 加载本地消息
 @param 无
 @result 无
 */
-(void)loadData
{
    App *app = [App getInstance];
    self.vehicleControlInformMutableArray = [mCherryDBControl loadVehicleControlMessage:app.mUserData.mUserID];
    NSLog(@"%d",self.vehicleControlInformMutableArray.count);
    
    if (self.vehicleControlInformMutableArray.count==0) {
        //没有消息时编辑按钮不可用
        editBtn.enabled = NO;
    }
    else
    {
        editBtn.enabled = YES;
    }
    [vehicleControlInformTableView reloadData];
}


/*!
 @method editOrFinish
 @abstract 编辑或完成
 @discussion 编辑或完成
 @param 无
 @result 无
 */
-(void)editOrFinish
{
    
    Resources *oRes = [Resources getInstance];
    if (editType==EDIT)//点击编辑按钮
    {
        editType=FINISH;
        [editBtn setTitle:[oRes getText:@"message.MessageViewController.finishButton"] forState:UIControlStateNormal];
        [self tableViewEdit];
        [vehicleControlInformTableView reloadData];
    }
    else//点击完成按钮
    {
        editType=EDIT;
        [editBtn setTitle:[oRes getText:@"message.MessageViewController.editButton"] forState:UIControlStateNormal];
        //提交操作，未完成
        [self submitData];
        [self tableViewEdit];
        [vehicleControlInformTableView reloadData];
    }
}


/*!
 @method submitData
 @abstract 提交数据删除本地数据
 @discussion 提交数据删除本地数据
 @param 无
 @result 无
 */
-(void)submitData
{
    Resources *oRes = [Resources getInstance];
    VehicleControlInformMessageData *tempData;
    //取到要删除文件的车友ID
    int deleteMessagesNumber = [self.deleteMutableArray count];
    if (deleteMessagesNumber > 0) {
        App *app = [App getInstance];
        //将本地的数据修改
        NSString *str=[NSString stringWithFormat:@""];
        for (int i=0; i<self.deleteMutableArray.count; i++) {
            tempData=[self.deleteMutableArray objectAtIndex:i];
            str=[NSString stringWithFormat:@"%@,'%@'",str,tempData.mMessageKeyID];
        }
        str = [str substringFromIndex:1];
        //一次性删除多条消息
        [mCherryDBControl deleteVehicleControlMessageWithIDs:str];
        [app deleteMessageInfoWithIDs:str];
        [self.deleteMutableArray removeAllObjects];
        [self loadData];
        [self MBProgressHUDMessage:[oRes getText:@"message.common.deleteSuccess"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
}


/*!
 @method tableViewEdit
 @abstract 编辑列表
 @discussion 编辑列表
 @param 无
 @result 无
 */
- (void)tableViewEdit
{
    [vehicleControlInformTableView setEditing:!vehicleControlInformTableView.editing animated:YES];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    vehicleControlInformTableView= nil;
    self.deleteMutableArray=nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Table View Data Source Methods
/*!
 @method tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
 @abstract 设置列表行数
 @discussion 设置列表行数
 @param tableView，section
 @result count
 */
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [self.vehicleControlInformMutableArray count];
}

#pragma mark - button action

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
        cell = [[[NSBundle mainBundle] loadNibNamed:@"VehicleControlInformCell" owner:self options:nil] lastObject];
    }
    
    NSUInteger row = [indexPath row];
    
    UILabel *type = (UILabel*)[cell viewWithTag:2];
    UILabel *time=(UILabel*)[cell viewWithTag:3];
    UILabel *message=(UILabel*)[cell viewWithTag:4];
    UIImageView *image = (UIImageView *)[cell viewWithTag:1];
    UIImageView *statusImage=(UIImageView*)[cell viewWithTag:5];
    
    NSLog(@"%d",[self.vehicleControlInformMutableArray count]);
    VehicleControlInformMessageData *mdata = [self.vehicleControlInformMutableArray objectAtIndex:row];
    //设置图标,通过读MessageInfo数据实现
    
    int cmdCode = [mdata.mCmdCode intValue];
    switch (cmdCode) {
        case OPEN_DOOR:
            type.text = [oRes getText:@"message.VehicleControlInformViewController.openDoor"];
            break;
        case CLOSE_DOOR:
            type.text = [oRes getText:@"message.VehicleControlInformViewController.closeDoor"];
            break;
        case WHISTLE:
            type.text = [oRes getText:@"message.VehicleControlInformViewController.blow"];
            break;
        case OPEN_ENGINE:
            type.text = [oRes getText:@"message.VehicleControlInformViewController.bootupEngine"];
            break;
        case CLOSE_ENGINE:
            type.text = [oRes getText:@"message.VehicleControlInformViewController.turnOffEngine"];
            break;
        case OPEN_AIRCON:
            type.text = [oRes getText:@"message.VehicleControlInformViewController.openAirConditioner"];
            break;
        case CLOSE_AIRCON:
            type.text = [oRes getText:@"message.VehicleControlInformViewController.turnOffAirConditioner"];
            break;
        default:
            break;
    }
    
    time.text = [app getCreateTime:mdata.mKeyid];
    NSString *result = @"";
    if ([app getMessageStatus:mdata.mMessageKeyID] == MESSAGE_READ) {
        image.image = [UIImage imageNamed:@"message_icon_open"];
        
    }
    else{
        image.image = [UIImage imageNamed:@"message_icon_close"];
        
    }
    if ([mdata.mResultCode intValue] == VEHICLE_CONTROL_RESULT_SUCCESS)
    {
        result = [oRes getText:@"message.VehicleControlInformViewController.messageSuccess"];
        statusImage.image = [UIImage imageNamed:@"message_vehicleControl_success"];
    }
    else
    {
        result = [oRes getText:@"message.VehicleControlInformViewController.messageFailure"];
         statusImage.image = [UIImage imageNamed:@"message_vehicleControl_failure"];
    }
    message.text = [NSString stringWithFormat:@"%@%@%@%@%@%@",[[App getInstance] searchCarNum:mdata.mMessageKeyID],[oRes getText:@"message.VehicleControlInformViewController.message1"],[App getDateWithTimeSince1970:mdata.mSendTime],[oRes getText:@"message.VehicleControlInformViewController.message2"],type.text,result];
    
    type.textColor = [UIColor colorWithRed:0.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:1];
    message.textColor = [UIColor colorWithRed:87.0/255.0f green:87.0/255.0f blue:87.0/255.0f alpha:1];
    time.textColor = [UIColor colorWithRed:129.0/255.0f green:129.0/255.0f blue:129.0/255.0f alpha:1];
    
    type.font = [UIFont boldSystemFontOfSize:15];
    message.font = [UIFont boldSystemFontOfSize:12];
    time.font = [UIFont boldSystemFontOfSize:10];
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
    if (indexPath.row==[self.vehicleControlInformMutableArray count])
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

/*!
 @method tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
 @abstract 设置列表状态
 @discussion 设置列表状态
 @param tableView，indexPath
 @result 无
 */
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //禁止滑动删除，现无限制
    //    if(![tableView isEditing])
    //    {
    //        return UITableViewCellEditingStyleNone;
    //    }
    
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_deleteMutableArray.count > 0) {
        
        [self submitData];
    }
}


/*!
 @method tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 @abstract 点击删除按钮执行
 @discussion 点击删除按钮执行
 @param tableView，indexPath，editingStyle
 @result 无
 */
- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    //点击按钮事件发生
    NSLog(@"删除第%d行",indexPath.row);
    [self.deleteMutableArray addObject:[self.vehicleControlInformMutableArray objectAtIndex:indexPath.row]];
    [self.vehicleControlInformMutableArray removeObjectAtIndex:indexPath.row];
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    //    删除效果，暂不启用
    [vehicleControlInformTableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
}

/*!
 @method tableView:(UITableView *)tableView
 titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
 @abstract 设置删除按钮文字
 @discussion 设置删除按钮文字
 @param tableView，indexPath
 @result str
 */
-(NSString *)tableView:(UITableView *)tableView
titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //设置按钮的名称
    Resources *oRes = [Resources getInstance];
    return [oRes getText:@"common.delete"];
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

