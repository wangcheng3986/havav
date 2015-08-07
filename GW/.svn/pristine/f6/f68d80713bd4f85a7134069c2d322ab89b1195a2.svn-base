
/*!
 @header ClearHistoryViewController.m
 @abstract 清除历史类
 @author mengy
 @version 1.00 14-8-7 Creation
 */
#import "ClearHistoryViewController.h"

@interface ClearHistoryViewController ()
{
    UIBarButtonItem *leftBtn;
    UIBarButtonItem *rightBtn;
    enum CLEAR_TYPE clearType;
    NSMutableArray *clearTypeArray;
    NSMutableArray *numArray;
    
}

@end

@implementation ClearHistoryViewController
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
    if (backBtn) {
        [backBtn removeFromSuperview];
        [backBtn release];
        backBtn = nil;
    }
    if (clearBtn) {
        [clearBtn removeFromSuperview];
        [clearBtn release];
        clearBtn = nil;
    }
    if (leftBtn) {
        [leftBtn release];
        leftBtn = nil;
    }
    if (rightBtn) {
        [rightBtn release];
        rightBtn = nil;
    }
    if (clearTableView) {
        [clearTableView removeFromSuperview];
        [clearTableView release];
        clearTableView = nil;
    }
    
    if (titleLabel) {
        [titleLabel removeFromSuperview];
        [titleLabel release];
        titleLabel = nil;
    }
    if (listTitleArray) {
        [listTitleArray release];
        listTitleArray = nil;
    }
    if (listMessageArray) {
        [listMessageArray release];
        listMessageArray = nil;
    }
    if (listIconNameArray) {
        [listIconNameArray release];
        listIconNameArray = nil;
    }
    if (mDisView) {
        [mDisView removeFromSuperview];
        [mDisView release];
        mDisView = nil;
    }
    if (clearView) {
        [clearView removeFromSuperview];
        [clearView release];
        clearView = nil;
    }
    if (cencelBtn) {
        [cencelBtn removeFromSuperview];
        [cencelBtn release];
        cencelBtn = nil;
    }
    if (affirmBtn) {
        [affirmBtn removeFromSuperview];
        [affirmBtn release];
        affirmBtn = nil;
    }
    if (alertMessageLabel) {
        [alertMessageLabel removeFromSuperview];
        [alertMessageLabel release];
        alertMessageLabel = nil;
    }
    if (clearTypeArray) {
        [clearTypeArray removeAllObjects];
        [clearTypeArray release];
        clearTypeArray = nil;
    }
    if (numArray) {
        [numArray removeAllObjects];
        [numArray release];
        numArray = nil;
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
 @abstract 加载界面信息
 @discussion 加载界面信息
 @param 无
 @result 无
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    Resources *oRes = [Resources getInstance];
    backBtn = [[LeftButton alloc]init];
    [backBtn addTarget:self action:@selector(popself) forControlEvents:UIControlEventTouchDown];
    leftBtn=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    self.navigationItem.leftBarButtonItem= leftBtn;
    
    clearBtn = [[RightButton alloc]init];
    [clearBtn setTitle:[oRes getText:@"set.clearViewController.clearBtnTitle"] forState:UIControlStateNormal];
    [clearBtn addTarget:self action:@selector(clearHistory) forControlEvents:UIControlEventTouchDown];
    rightBtn=[[UIBarButtonItem alloc]initWithCustomView:clearBtn];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    
//    titleLabel.text=[oRes getText:@"set.clearViewController.title"];
//    titleLabel.font =[UIFont navBarTitleSize];
//    self.navigationItem.titleView= titleLabel;
    self.navigationItem.title = [oRes getText:@"set.clearViewController.title"];
//    [self.view addSubview:clearTableView];
    CGRect rect = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    mDisView.frame = rect;
    [self.view addSubview:mDisView];
    mDisView.hidden = YES;
    [self.view addSubview:clearView];
    rect = CGRectMake(18, 92, clearView.frame.size.width, clearView.frame.size.height);
    clearView.frame = rect;
    clearView.hidden = YES;
    numArray = [[NSMutableArray alloc]initWithCapacity:0];
    [self loadViewMessage];
    self.view.backgroundColor = [UIColor colorWithRed:231.0/255 green:231.0/255 blue:231.0/255 alpha:1];
    [cencelBtn setTitle:[oRes getText:@"set.setViewController.clearCencelButton"] forState:UIControlStateNormal];
    [affirmBtn setTitle:[oRes getText:@"set.setViewController.clearConfirmButton"] forState:UIControlStateNormal];
    clearTypeArray = [[NSMutableArray alloc]initWithCapacity:0];
    //当进入视图时，重新设置imageView
    [self.imageView setImage:nil];
    [self.imageView setFrame:CGRectMake(160, 200, 0, 0)];
    //显示加载等待框
    self.progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.progressHUD];
    [self.view bringSubviewToFront:self.progressHUD];
    self.progressHUD.delegate = self;
    // Do any additional setup after loading the view from its nib.
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
 @method loadViewMessage
 @abstract 加载界面信息
 @discussion 加载界面信息
 @param 无
 @result 无
 */
-(void)loadViewMessage
{
    Resources *oRes = [Resources getInstance];
    
    listTitleArray = [[NSArray alloc]initWithObjects:[oRes getText:@"set.clearViewController.searchHistoryTitle"],[oRes getText:@"set.clearViewController.locRequestHistoryTitle"],[oRes getText:@"set.clearViewController.friendLoacHistoryTitle"],[oRes getText:@"set.clearViewController.send2CarHistoryTitle"],[oRes getText:@"set.clearViewController.elecFenceHistoryTitle"],[oRes getText:@"set.clearViewController.vehicleControlHistoryTitle"],[oRes getText:@"set.clearViewController.vehicleDiagnosisHistoryTitle"],[oRes getText:@"set.clearViewController.vehicleAbnormalHistoryTitle"],[oRes getText:@"set.clearViewController.maintenanceHistoryTitle"],nil];
    listMessageArray = [[NSArray alloc]initWithObjects:[oRes getText:@"set.clearViewController.searchHistoryMessage"],[oRes getText:@"set.clearViewController.locRequestHistoryMessage"],[oRes getText:@"set.clearViewController.friendLoacHistoryMessage"],[oRes getText:@"set.clearViewController.send2CarHistoryMessage"], [oRes getText:@"set.clearViewController.elecFenceHistoryMessage"],[oRes getText:@"set.clearViewController.vehicleControlHistoryMessage"],[oRes getText:@"set.clearViewController.vehicleDiagnosisHistoryMessage"],[oRes getText:@"set.clearViewController.vehicleAbnormalHistoryMessage"],[oRes getText:@"set.clearViewController.maintenanceHistoryMessage"],nil];
    listIconNameArray = [[NSArray alloc]initWithObjects:@"setting_clear_history_ic",@"setting_clear_locRq_ic",@"setting_clear_friendLoc_ic",@"setting_clear_send2car_ic",@"setting_clear_elecFence_ic",@"setting_clear_vehicleControl_ic",@"setting_clear_vehicleDiagnos_ic",@"setting_clear_vehicleAbnormal_ic",@"setting_clear_maintenance_ic", nil];
    
    
    
    
    
    listTitleArray = [[NSArray alloc]initWithObjects:[oRes getText:@"set.clearViewController.searchHistoryTitle"],[oRes getText:@"set.clearViewController.locRequestHistoryTitle"],[oRes getText:@"set.clearViewController.friendLoacHistoryTitle"],[oRes getText:@"set.clearViewController.send2CarHistoryTitle"],[oRes getText:@"set.clearViewController.vehicleControlHistoryTitle"],[oRes getText:@"set.clearViewController.elecFenceHistoryTitle"],[oRes getText:@"set.clearViewController.vehicleAbnormalHistoryTitle"],[oRes getText:@"set.clearViewController.maintenanceHistoryTitle"],[oRes getText:@"set.clearViewController.vehicleDiagnosisHistoryTitle"],nil];
    listMessageArray = [[NSArray alloc]initWithObjects:[oRes getText:@"set.clearViewController.searchHistoryMessage"],[oRes getText:@"set.clearViewController.locRequestHistoryMessage"],[oRes getText:@"set.clearViewController.friendLoacHistoryMessage"],[oRes getText:@"set.clearViewController.send2CarHistoryMessage"], [oRes getText:@"set.clearViewController.vehicleControlHistoryMessage"],[oRes getText:@"set.clearViewController.elecFenceHistoryMessage"],[oRes getText:@"set.clearViewController.vehicleAbnormalHistoryMessage"],[oRes getText:@"set.clearViewController.maintenanceHistoryMessage"],[oRes getText:@"set.clearViewController.vehicleDiagnosisHistoryMessage"],nil];
    listIconNameArray = [[NSArray alloc]initWithObjects:@"setting_clear_history_ic",@"setting_clear_locRq_ic",@"setting_clear_friendLoc_ic",@"setting_clear_send2car_ic",@"setting_clear_vehicleControl_ic",@"setting_clear_elecFence_ic",@"setting_clear_vehicleAbnormal_ic",@"setting_clear_maintenance_ic",@"setting_clear_vehicleDiagnos_ic", nil];
    for (int i = 0; i < listTitleArray.count; i++)
    {
        [numArray setObject:@"0" atIndexedSubscript:i];
    }
}

/*!
 @method clearHistory
 @abstract 清除历史记录
 @discussion 清除历史记录
 @param 无
 @result 无
 */
-(void)clearHistory
{
    Resources *oRes = [Resources getInstance];
    [clearTypeArray removeAllObjects];
    for (int i = 0; i < numArray.count; i++)
    {
        if ([[numArray objectAtIndex:i]intValue]) {
            switch (i) {
                    //                CLEAR_SEARCH_HISTORY=1,//删除搜索历史
                    //
                    //                CLEAR_MESSAGE_ELECTRONIC=15,// 删除电子围栏消息
                    //                CLEAR_MESSAGE_SEND_TO_CAR=13,//删除发送至车消息
                    //                CLEAR_MESSAGE_FRIEND_LOCATION=12,//删除好友位置消息
                    //                CLEAR_MESSAGE_FRIEND_REQUEST_LOCATION=11,//删除好友位置请求消息
                    //                CLEAR_MESSAGE_VEHICLE_CONTROL=14,//删除车辆控制消息
                    //                CLEAR_MESSAGE_VEHICLE_ABNORMAL_ALARM=17,//删除车辆异常报警消息
                    //                CLEAR_MESSAGE_MAINTENANCE_ALARM=18,//删除保养提醒消息
                    //                CLEAR_MESSAGE_VEHICLE_STATUS=20,//删除车辆状况消息
                    //                CLEAR_MESSAGE_VEHICLE_DIAGNOSIS=16,//删除诊断结果消息
                case 0:
                    [clearTypeArray addObject:[NSString stringWithFormat:@"%d",CLEAR_SEARCH_HISTORY]];
                    break;
                case 1:
                    [clearTypeArray addObject:[NSString stringWithFormat:@"%d",CLEAR_MESSAGE_FRIEND_REQUEST_LOCATION]];
                    break;
                case 2:
                    [clearTypeArray addObject:[NSString stringWithFormat:@"%d",CLEAR_MESSAGE_FRIEND_LOCATION]];
                    break;
                case 3:
                    [clearTypeArray addObject:[NSString stringWithFormat:@"%d",CLEAR_MESSAGE_SEND_TO_CAR]];
                    break;
                case 4:
                    [clearTypeArray addObject:[NSString stringWithFormat:@"%d",CLEAR_MESSAGE_VEHICLE_CONTROL]];
                    break;
                case 5:
                    [clearTypeArray addObject:[NSString stringWithFormat:@"%d",CLEAR_MESSAGE_ELECTRONIC]];
                    break;
                case 6:
                    [clearTypeArray addObject:[NSString stringWithFormat:@"%d",CLEAR_MESSAGE_VEHICLE_ABNORMAL_ALARM]];
                    break;
                case 7:
                    [clearTypeArray addObject:[NSString stringWithFormat:@"%d",CLEAR_MESSAGE_MAINTENANCE_ALARM]];
                    break;
                case 8:
                    [clearTypeArray addObject:[NSString stringWithFormat:@"%d",CLEAR_MESSAGE_VEHICLE_DIAGNOSIS]];
                    break;
                    
                default:
                    break;
            }

        }
    }
    
    if (clearTypeArray.count == 0) {
        [self MBProgressHUDMessage:[oRes getText:@"set.clearAlert.selectClearType"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else
    {
        alertMessageLabel.text = [oRes getText:@"set.clearAlert.message"];
        clearView.hidden = NO;
        mDisView.hidden = NO;
    }
}



/*!
 @method onClickCencelBtn:
 @abstract 点击取消按钮，清除界面消失
 @discussion 点击取消按钮，清除界面消失
 @param 无
 @result 无
 */
-(IBAction)onClickCencelBtn:(id)sender
{
    clearView.hidden = YES;
    mDisView.hidden = YES;
}

/*!
 @method onClickDisView:
 @abstract 点击背景，清除界面消失
 @discussion 点击背景，清除界面消失
 @param 无
 @result 无
 */
-(IBAction)onClickDisView:(id)sender
{
    clearView.hidden = YES;
    mDisView.hidden = YES;
}

/*!
 @method onClickAffirmBtn:
 @abstract 点击确定按钮，清除历史，界面消失
 @discussion 点击确定按钮，清除历史，界面消失
 @param 无
 @result 无
 */
-(IBAction)onClickAffirmBtn:(id)sender
{
    Resources *oRes = [Resources getInstance];
    if ([[App getInstance]clearHistoryData:clearTypeArray]) {
        [self MBProgressHUDMessage:[oRes getText:@"set.clearAlert.clearSuccess"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
        [clearTypeArray removeAllObjects];
        for (int i = 0; i < listTitleArray.count; i++)
        {
            [numArray setObject:@"0" atIndexedSubscript:i];
        }
        [clearTableView reloadData];
        [self MBProgressHUDMessage:[oRes getText:@"set.clearAlert.clearSuccess"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else
    {
        [self MBProgressHUDMessage:[oRes getText:@"set.clearAlert.clearfail"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    clearView.hidden = YES;
    mDisView.hidden = YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Table View Data Source Methods
//返回行数
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return listTitleArray.count;
    
}

#pragma mark - Table View deleget
/*!
 @method tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 @abstract 加载列表信息
 @discussion 加载列表信息
 @param tableView，indexPath
 @result 无
 */
//新建某一行并返回
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"naviIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ClearViewCell" owner:self options:nil] lastObject];
    }
    NSUInteger row = [indexPath row];
    UIImageView *image=(UIImageView*)[cell viewWithTag:1];
    UILabel *title = (UILabel*)[cell viewWithTag:2];
    UILabel *message = (UILabel*)[cell viewWithTag:3];
    UIButton *btn=(UIButton*)[cell viewWithTag:5];
    image.image=[UIImage imageNamed:[listIconNameArray objectAtIndex:row]];
    title.text=[listTitleArray objectAtIndex:row];
    message.text=[listMessageArray objectAtIndex:row];
    title.font = [UIFont size15];
    message.font = [UIFont size12];
    btn.titleLabel.font = [UIFont size13];
//    [btn setTitle:[oRes getText:@"set.clearViewController.clearBtnTitle"] forState:UIControlStateNormal];
    message.textColor = [UIColor colorWithRed:148.0/255.0 green:148.0/255.0 blue:148.0/255.0 alpha:1];
    [btn setImage:nil forState:UIControlStateNormal];
    btn.tag = indexPath.row+100;
    [btn addTarget:self action:@selector(onClickCheckbox:) forControlEvents:UIControlEventTouchDown];
    if ([[numArray objectAtIndex:row]integerValue]) {
        [btn setImage:[UIImage imageNamed:@"map_send2car_addFriend_checkbox_selected"] forState:UIControlStateNormal];
        [numArray setObject:[NSString stringWithFormat:@"1"] atIndexedSubscript:row];
    }
    else
    {
        [numArray setObject:[NSString stringWithFormat:@"0"] atIndexedSubscript:row];
    }
    
	return cell;
}

/*!
 @method onClickCheckbox
 @abstract 点击复选框
 @discussion 点击复选框
 @param 无
 @result 无
 */
-(IBAction)onClickCheckbox:(id)sender
{
    
    Resources *oRes = [Resources getInstance];
    App *app = [App getInstance];
    UIButton *btn = (UIButton*)sender;
    int index=btn.tag-100;
    if (index >= 4 && app.userAccountState == USER_ACCOUNT_STATE_PART_FUNCTION)
    {
        [self MBProgressHUDMessage:[oRes getText:@"set.clearAlert.noCherry"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else
    {
        if ([btn imageForState:UIControlStateNormal]==nil) {
            [numArray setObject:[NSString stringWithFormat:@"1"] atIndexedSubscript:index];
            [btn setImage:[UIImage imageNamed:@"map_send2car_addFriend_checkbox_selected"] forState:UIControlStateNormal];
            
        }
        else
        {
            [numArray setObject:[NSString stringWithFormat:@"0"] atIndexedSubscript:index];
            [btn setImage:nil forState:UIControlStateNormal];
        }
        
    }
    
    
}

/*!
 @method tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 @abstract 设置列表不可编辑
 @discussion 设置列表不可编辑
 @param tableView，indexPath
 @result 无
 */
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}


/*!
 @method tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 @abstract 设置列表不可编辑
 @discussion 设置列表不可编辑
 @param tableView，indexPath
 @result 无
 */
- (UITableViewCellEditingStyle)tableView:(UITableView *)mTable editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(![mTable isEditing])
    {
        return UITableViewCellEditingStyleNone;
    }
    
    return UITableViewCellEditingStyleDelete;
}

#pragma mark -MBProgressHUDMessage
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
