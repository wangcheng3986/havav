/*!
 @header ElecFenceViewController.m
 @abstract 电子围栏主控界面
 @author wangqiwei
 @version 1.00 2014/9/1 Create
 */
#import "ElecFenceViewController.h"
#import "ElecFenceDetailViewController.h"
#import "CherryDBControl.h"
#import "App.h"
#import "CustomTableViewCell.h"
#define ELEC_FLAG 1
#define HIDE 1
@interface ElecFenceViewController ()
{
    CherryDBControl *cherryDBControl;
    CarData *mCarData;
    BOOL hideFlag;
}
@end

@implementation ElecFenceViewController
@synthesize tempDeleteMutableArray;

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
    self.deleteMutableArray = [[NSMutableArray alloc] initWithCapacity:0];
    tempDeleteMutableArray = [[NSMutableArray alloc] initWithCapacity:0];
    self.elecFenceList = [[NSMutableArray alloc]initWithCapacity:0];

    Resources *oRes = [Resources getInstance];
    headerDetail.text = [oRes getText:@"Car.ElecFenceViewController.detail"];
    
    if (_refreshHeaderView == nil) {
        EGORefreshTableHeaderView *view1 = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.view.bounds.size.height, self.elecFenceTableView.frame.size.width, self.view.bounds.size.height)];
        view1.delegate = self;
        [self.elecFenceTableView addSubview:view1];
        _refreshHeaderView = view1;
        [view1 release];
    }
    NewElecButton.text =[oRes getText:@"Car.ElecFenceViewController.newElec"];


    self.view.backgroundColor = [UIColor colorWithRed:231.0/255 green:231.0/255 blue:231.0/255 alpha:1];
    self.elecFenceTableView.backgroundColor =[UIColor colorWithRed:231.0/255 green:231.0/255 blue:231.0/255 alpha:1];
    
    //显示加载等待框
    self.progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.progressHUD];
    [self.view bringSubviewToFront:self.progressHUD];

}
/*!
 @method reloadTableViewData
 @abstract 进入电子围栏列表重新加载电子围栏数据
 @discussion 进入电子围栏列表重新加载电子围栏数据
 @result 无
 */
- (void)reloadTableViewData
{
    [self.elecFenceList removeAllObjects];
   //  self.elecFenceList = [[NSMutableArray alloc]initWithCapacity:0];
    cherryDBControl = [CherryDBControl sharedCherryDBControl];
    App *app = [App getInstance];
    mCarData = [app getCarData];
    Resources *oRes = [Resources getInstance];
    if (app.mUserData.mType == USER_LOGIN_DEMO)
    {
        self.elecFenceList =[cherryDBControl selectWithVin:@"demo_vin"];
        [self.elecFenceTableView reloadData];
    }
    else
    {
        if (app.elecLoadType == ELEC_LOAD_YES)
        {
        //如果是登入后第一次进入电子围栏list，从服务器获取list
            if (elecFenceQueryNetManager == nil) {
                elecFenceQueryNetManager = [[ElecFenceQueryNetManager alloc] init];
            }
            
            self.progressHUD.labelText = [oRes getText:@"Car.loading.text"];
            self.progressHUD.detailsLabelText= [oRes getText:@"Car.loading.detailtext"];
            [self.progressHUD show:YES];
            
            [elecFenceQueryNetManager queryRequest:mCarData.mVin];
            [elecFenceQueryNetManager sendRequestWithAsync:self];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        }
        else
        {
            mCarData = [app getCarData];
            self.elecFenceList =[cherryDBControl selectWithVin:mCarData.mVin];
            [self.elecFenceTableView reloadData];
        }
        
        

    }

}
#pragma mark - elecFenceDelegate
/*!
 @method onElecFenceQueryResult
 @abstract 电子围栏查询网络请求的回调函数
 @discussion 电子围栏查询网络请求的回调函数
 @result 无
 */
- (void)onElecFenceQueryResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg
{
    NSLog(@"receive the result of add elecFence.");
    [self doneLoadingTableViewDataFinish];
    [self.progressHUD hide:YES];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    Resources *oRes = [Resources getInstance];
    if (NAVINFO_RESULT_SUCCESS == code)
    {
        if (nil != result)
        {
            NSLog(@"result is :%@", result);
            if([result valueForKey:@"elecFenceList"])
            {
                NSArray *elecDic = [result valueForKey:@"elecFenceList"];
                
                NSInteger count = [elecDic count];
                
                App *app = [App getInstance];
                mCarData=[app getCarData];
                cherryDBControl = [CherryDBControl sharedCherryDBControl];//二期专用数据控制单例
                [cherryDBControl removeWithAllDBVin:mCarData.mVin];
                if (count == 0) {
                    [self MBProgressHUDMessage:[oRes getText:@"Car.ElecFence.alert.selectSuccess"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
                }
                for (int index = 0; index <count; index++)
                {
                    NSDictionary *aDic = [NSDictionary dictionaryWithDictionary:[elecDic objectAtIndex:index]];
                    NSString *elecFenceID = [aDic valueForKey:@"id"];
                     NSString *name  = [aDic valueForKey:@"name"];
                    NSString *lastUpdate =[aDic objectForKey:@"lastUpdate"];
                    NSString *valid = [aDic objectForKey:@"valid"];
                    NSString *lon = [aDic objectForKey:@"lon"];
                    NSString *lat = [aDic objectForKey:@"lat"];
                    NSString *radius = [aDic objectForKey:@"radius"];
                    NSString *description = [aDic objectForKey:@"description"];
                    if (description ==nil) {
                        description = @"";
                    }
                    NSString *elecAddress = [aDic objectForKey:@"address"];
                    
                    NSString *uuid = [App createUUID];
                    
                    //插入数据库
                    BOOL result = [cherryDBControl addElecFenceWithKeyid:uuid ID:elecFenceID name:name lastUpdate:lastUpdate valid:valid lon:[lon doubleValue] lat:[lat doubleValue] radius:[radius intValue] description:description address:elecAddress vin:mCarData.mVin userKeyID:app.loginID];
                    if (result)
                    {
                        [self MBProgressHUDMessage:[oRes getText:@"Car.ElecFence.alert.selectSuccess"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
                    }
                    else
                    {
                        [self MBProgressHUDMessage:[oRes getText:@"Car.ElecFence.alert.selectFailure"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
                    }
                }
            }
            else
            {
                [self MBProgressHUDMessage:[oRes getText:@"Car.ElecFence.alert.selectFailure"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
            }
            
        }
    }
    else if(code == NET_ERROR)
    {
        [self MBProgressHUDMessage:[oRes getText:@"common.noNetAlert.message"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else if(NAVINFO_TOKENID_INVALID == code)//TokenID失效处理
    {
        [self MBProgressHUDMessage:[oRes getText:@"common.loseTokenID.message"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else
    {
        NSLog(@"Errors on reveice result.");
        [self MBProgressHUDMessage:[oRes getText:@"Car.ElecFence.alert.selectFailure"] delayTime:2 xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    
    self.elecFenceList =[cherryDBControl selectWithVin:mCarData.mVin];
    [self.elecFenceTableView reloadData];
}
/*!
 @method onElecFenceDeleteResult
 @abstract 电子围栏删除网络请求的回调函数
 @discussion 电子围栏删除网络请求的回调函数
 @result 无
 */
- (void)onElecFenceDeleteResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg
{
    NSLog(@"receive the result of delete elecFence.");
    [self.progressHUD hide:YES];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    Resources *oRes = [Resources getInstance];
    if (NAVINFO_RESULT_SUCCESS == code)
    {
    
            NSUInteger count = [self.deleteMutableArray count];
                
            App *app = [App getInstance];
            mCarData=[app getCarData];
            cherryDBControl = [CherryDBControl sharedCherryDBControl];//二期专用数据控制单例
        
            for (int index = 0; index <count; index++)
            {
                ElecFenceData *EFData;
                EFData = self.deleteMutableArray[index];
                [cherryDBControl removeWithDBID:EFData.elecFenceId vin:mCarData.mVin];
            }
        
            [self.deleteMutableArray removeAllObjects];
        [self MBProgressHUDMessage:[oRes getText:@"Car.ElecFence.alert.deleteSuccess"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
        
    }
    else if(code == NET_ERROR)
    {
        [self MBProgressHUDMessage:[oRes getText:@"common.noNetAlert.message"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else if(NAVINFO_TOKENID_INVALID == code)//TokenID失效处理
    {
        [self MBProgressHUDMessage:[oRes getText:@"common.loseTokenID.message"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else
    {
        NSLog(@"Errors on reveice result.");
        [self MBProgressHUDMessage:[oRes getText:@"Car.ElecFence.alert.deleteFailure"] delayTime:2 xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    
    self.elecFenceList =[cherryDBControl selectWithVin:mCarData.mVin];
    [self.elecFenceTableView reloadData];
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

#pragma mark - submitData
/*!
 @method submitData
 @abstract 删除电子围栏提交后发送网络请求（demo直接本地删除），含单选删除和批量删除
 @discussion 删除电子围栏提交后发送网络请求（demo直接本地删除），含单选删除和批量删除
 @result 无
 */
- (void)submitData
{
    App *app = [App getInstance];
    Resources *oRes = [Resources getInstance];
    [self.deleteMutableArray addObjectsFromArray:tempDeleteMutableArray];
    [tempDeleteMutableArray removeAllObjects];
    NSUInteger count = [self.deleteMutableArray count];
    NSMutableArray *elecIDlist = [NSMutableArray arrayWithCapacity:0];
    if (app.mUserData.mType == USER_LOGIN_DEMO)
    {
        
        for (int index = 0; index <count; index++)
        {
            ElecFenceData *EFData;
            EFData = self.deleteMutableArray[index];
            [cherryDBControl removeWithDBID:EFData.elecFenceId vin:EFData.vin];
        }
        [self.deleteMutableArray removeAllObjects];
        
        if (count !=0)
        {
        [self MBProgressHUDMessage:[oRes getText:@"Car.ElecFence.alert.deleteSuccess"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
        }
        
    }
    else if(count == 0)
    {
        return;
        
    }
    else
    {
        if (elecFenceDeleteNetManager == nil) {
            elecFenceDeleteNetManager = [[ElecFenceDeleteNetManager alloc]init];
        }
        for (int index = 0; index <count; index++)
        {
            ElecFenceData *EFData;
            EFData = self.deleteMutableArray[index];
            [elecIDlist addObject:EFData.elecFenceId];
        }
        self.progressHUD.labelText = [oRes getText:@"Car.ElecFenceDelete.loading.titleText"];
        self.progressHUD.detailsLabelText= [oRes getText:@"Car.ElecFence.loading.detailtext"];
        [self.progressHUD show:YES];
        
        [elecFenceDeleteNetManager deleteRequest:elecIDlist];
        [elecFenceDeleteNetManager sendRequestWithAsync:self];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    }
}
#pragma mark - refesher
- (void)doneLoadingTableViewDataFinish{
    NSLog(@"===加载完数据");
    _reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.elecFenceTableView];
    App *app = [App getInstance];
    Resources *oRes = [Resources getInstance];
    if (app.mUserData.mType == USER_LOGIN_DEMO)
    {
        [self MBProgressHUDMessage:[oRes getText:@"Car.ElecFence.alert.selectSuccess"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
}
#pragma mark UIScrollViewDelegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}
#pragma mark EGORefreshTableHeaderDelegate Methods
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    
    //设置标志位，控制等待提示框的显隐 孟磊 2013年9月3日*
   // isEGOrefresh = YES;
    if (elecFenceQueryNetManager == nil) {
        elecFenceQueryNetManager = [[ElecFenceQueryNetManager alloc] init];
    }
    App *app = [App getInstance];
    if (app.mUserData.mType == USER_LOGIN_DEMO)
    {
        [self performSelector:@selector(doneLoadingTableViewDataFinish) withObject:nil afterDelay:1.0];
    }
    else
    {
        [elecFenceQueryNetManager queryRequest:mCarData.mVin];
        [elecFenceQueryNetManager sendRequestWithAsync:self];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    }

    //[self reloadTableViewDataSource];//需要添加下拉刷新做的事情
    NSLog(@"下拉刷新");
    
}
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    return _reloading;
}
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    return [NSDate date];;
}

#pragma mark - buttonDelegate
- (IBAction)createElecFence:(id)sender
{
    ElecFenceDetailViewController *elecFenceDetail = [[ElecFenceDetailViewController alloc] init];
    [self.navigationController pushViewController:elecFenceDetail animated:YES];
    [elecFenceDetail release];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [self reloadTableViewData];
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    App *app = [App getInstance];
    [app setElecLoadType:ELEC_LOAD_NO];
    [super viewDidAppear:animated];
}

#pragma mark - cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSUInteger row = [indexPath row];
    ElecFenceData *EFData = [self.elecFenceList objectAtIndex:row];
    ElecFenceDetailViewController *elecFenceDetail = [[ElecFenceDetailViewController alloc] init];
    [elecFenceDetail setElecFenceData:EFData flag:ELEC_FLAG];
    
    
    [self.navigationController pushViewController:elecFenceDetail animated:YES];
    [elecFenceDetail release];
}
//可否编辑电子围栏list
- (void)tableViewEdit
{
    [self.elecFenceTableView setEditing:!self.elecFenceTableView.editing animated:YES];
    hideFlag = YES;
    creatNewElecButton.enabled = NO;
    self.tabBarController.tabBar.userInteractionEnabled = NO;
    [self.elecFenceTableView reloadData];
}

- (void)tableViewFinish
{
    [self.elecFenceTableView setEditing:!self.elecFenceTableView.editing animated:YES];
    hideFlag = NO;
    creatNewElecButton.enabled = YES;
    self.tabBarController.tabBar.userInteractionEnabled = YES;
    [self.elecFenceTableView reloadData];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath*)indexPath
{

    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tempDeleteMutableArray.count > 0) {
        
        [self submitData];
    }
}


- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return @"删除";
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	// 如果正在提交删除操作
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		// 从UITable程序界面上删除指定表格行。
      //  NSLog(@"%@",ElecFenceList[0]);
        NSLog(@"++++++++>>>>>   %d",[self.elecFenceList count]);
        [tempDeleteMutableArray addObject:[self.elecFenceList objectAtIndex:indexPath.row]];
         NSLog(@"++++++++>>>>>deleteMutableArray:   %d",[tempDeleteMutableArray count]);
        [self.elecFenceList removeObjectAtIndex:indexPath.row];
		[tableView deleteRowsAtIndexPaths:[NSArray
                                           arrayWithObject:indexPath]
                        withRowAnimation:UITableViewRowAnimationFade];
	}

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"self.elecFenceList: %d",[self.elecFenceList count]);
    NSLog(@"%p",self.elecFenceList);
    return [self.elecFenceList count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString *identifier = @"elecFencecell";
    ElecFenceData *EFData;
    Resources *oRes = [Resources getInstance];
    App *app = [App getInstance];
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ElecFenceList" owner:self options:nil]lastObject];
        UILabel *nameTitle =  (UILabel *)[cell viewWithTag:101];
        nameTitle.text = [oRes getText:@"Car.ElecFenceViewController.nameTitle"];
        
        UILabel *centerTitle =  (UILabel *)[cell viewWithTag:102];
        centerTitle.text = [oRes getText:@"Car.ElecFenceViewController.center"];
        
        
        UILabel *radiusTitle =  (UILabel *)[cell viewWithTag:103];
        radiusTitle.text = [oRes getText:@"Car.ElecFenceViewController.radius"];

    }
    EFData = self.elecFenceList[indexPath.row];
    //在demo模式下，电子围栏的名字显示为本地时间
    //非demo模式下，电子围栏名字显示的是lastUpdate字段的时间
    if (app.mUserData.mType == USER_LOGIN_DEMO)
    {
        UILabel *nameContext =  (UILabel *)[cell viewWithTag:201];
        nameContext.text = EFData.name;
    }
    else
    {
        UILabel *nameContext =  (UILabel *)[cell viewWithTag:201];
        nameContext.text = [App getDateWithTimeSince1970:EFData.lastUpdate];;
    }

    
    UITextView *centerContext =  (UITextView *)[cell viewWithTag:202];
    centerContext.text = EFData.address;
    centerContext.backgroundColor = [UIColor colorWithRed:231.0/255 green:231.0/255 blue:231.0/255 alpha:1];
    centerContext.editable = NO;
    
    UILabel *radiusContext =  (UILabel *)[cell viewWithTag:204];
    radiusContext.text = [NSString stringWithFormat:@"%d",EFData.radius];
    
    UILabel *radiusUnit =  (UILabel *)[cell viewWithTag:205];
    radiusUnit.text = [oRes getText:@"Car.ElecFenceViewController.radiusUnit"];
    
     UILabel *elecStateText = (UILabel *)[cell viewWithTag:301];
    elecStateText.text = [oRes getText:@"Car.ElecFenceViewController.elecStateText"];
    
    UILabel *elecState = (UILabel *)[cell viewWithTag:302];
    int valid = [EFData.valid intValue];
    if (valid == 1)
    {
        cell.backgroundColor = [UIColor whiteColor];
//这个主要是针对IOS5 添加的<<<<<<<<<<<<<<<<<<<<<
        cell.contentView.backgroundColor = [UIColor whiteColor];
//        NSArray *subviews = [cell.contentView subviews];
//        for(id view in subviews)
//        {
//            if([view isKindOfClass:[UIImageView class]])
//            {
//                UIImageView *image = view;
//                image.backgroundColor = [UIColor whiteColor];
//            }
//        }
//这个主要是针对IOS5 添加的>>>>>>>>>>>>>>>>>>>>>>>>

        UITextView *centerContext =  (UITextView *)[cell viewWithTag:202];
        centerContext.backgroundColor = [UIColor whiteColor];
        UIImageView *image = (UIImageView*)[cell viewWithTag:99];
        image.image = [UIImage imageNamed:@"car_elecfence_list_selected"];
        
        elecState.text = [oRes getText:@"Car.ElecFenceViewController.elecStateValid"];

    }
    else
    {
    elecState.text = [oRes getText:@"Car.ElecFenceViewController.elecStateInvalid"];
    }
    
    
    if (hideFlag == HIDE)
    {
        UIImageView *imageView = (UIImageView*)[cell viewWithTag:88];
        imageView.hidden = YES;
    }

    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [elecFenceQueryNetManager release];
    [elecFenceDeleteNetManager release];
    [_elecFenceTableView release];
    _elecFenceTableView = nil;
    [_headerView release];
    [headerImage release];
    [headerDetail release];
    [headerNewButton release];
    [bgImage release];
    [_deleteMutableArray release];
    [_elecFenceList release];
    _elecFenceList = nil;
    [NewElecButton release];
    [creatNewElecButton release];
    
    
    [tempDeleteMutableArray release];
    tempDeleteMutableArray = nil;
    [super dealloc];
}
- (void)viewDidUnload {
    [_elecFenceTableView release];
    _elecFenceTableView = nil;
    [_headerView release];
    _headerView = nil;
    [self setHeaderView:nil];
    [headerImage release];
    headerImage = nil;
    [headerDetail release];
    headerDetail = nil;
    [headerNewButton release];
    headerNewButton = nil;
    [bgImage release];
    bgImage = nil;
    [NewElecButton release];
    NewElecButton = nil;
    [creatNewElecButton release];
    creatNewElecButton = nil;
    [super viewDidUnload];
}
//测试下拉刷新
//- (IBAction)testRefresh:(id)sender
//{
//    
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.2];
//    
//    self.elecFenceTableView.contentOffset = CGPointMake(0.0, -150.0);
//    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:self.elecFenceTableView];
//    [UIView commitAnimations];
//    
//    
//}

@end
