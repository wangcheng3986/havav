
/*!
 @header SystemMessageViewController.m
 @abstract 系统消息类
 @author mengy
 @version 1.00 13-5-2 Creation
 */
#import "SystemMessageViewController.h"
#import "App.h"
#import "SystemMessageDetailViewController.h"
@interface SystemMessageViewController ()
{
    UIBarButtonItem *rightButton;
    int editType;
    bool _reloading;
}
@end

@implementation SystemMessageViewController
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
    [_deleteMutableArray removeAllObjects];
    [_deleteMutableArray release];
    _deleteMutableArray=nil;

    [_systemMessageMutableArray removeAllObjects];
    [_systemMessageMutableArray release];
    _systemMessageMutableArray=nil;
    [rightButton release];
    [mDelete release];
    
    [systemMessageTableView release],systemMessageTableView = nil;
    [titleLabel release],titleLabel = nil;
    [footerLabel release],footerLabel = nil;
    [noMessageView removeFromSuperview];
    [noMessageView release],noMessageView = nil;
    if (backBtn) {
        [backBtn release];
        backBtn = nil;
    }
    if (editBtn) {
        [editBtn release];
        editBtn = nil;
    }
    [self.imageView release];
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
    mDelete = [[NINotificationDelete alloc]init];
    editType=EDIT;
    
    Resources *oRes = [Resources getInstance];
    
    footerLabel.text=[oRes getText:@"map.collectViewController.footerlabeltext"];
    footerLabel.font =[UIFont size12];
    footerLabel.hidden=YES;
    
//    titleLabel.text=[oRes getText:@"message.systemMessageViewController.title"];
//    titleLabel.font =[UIFont navBarTitleSize];
//    titleLabel.textColor=[UIColor whiteColor];
//    self.navigationItem.titleView=titleLabel;
    
    self.navigationItem.title=[oRes getText:@"message.systemMessageViewController.title"];
    
    editBtn = [[RightButton alloc]init];
    backBtn = [[LeftButton alloc]init];
    [editBtn setTitle:[oRes getText:@"message.MessageViewController.editButton"] forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(editOrFinish)forControlEvents:UIControlEventTouchUpInside];
    editBtn.titleLabel.font =[UIFont navBarItemSize];
    rightButton=[[UIBarButtonItem alloc]initWithCustomView:editBtn];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    systemMessageTableView.backgroundColor = [UIColor colorWithRed:231.0/255.0f green:231.0/255.0f blue:231.0/255.0f alpha:1];
    
    self.deleteMutableArray = [[NSMutableArray alloc] initWithCapacity:0];
    [self loadData];
    // Do any additional setup after loading the view from its nib.
}

/*!
 @method loadData
 @abstract 加载消息数据
 @discussion 加载消息数据
 @param 无
 @result 无
 */
-(void)loadData
{
    App *app = [App getInstance];
    self.systemMessageMutableArray = [app loadAllMeetRequestSystemMessage];
    NSLog(@"%d",_systemMessageMutableArray.count);
    if (_systemMessageMutableArray.count==0) {
        //footerLabel提示没有信息
        footerLabel.hidden=NO;
        //没有消息时编辑按钮不可用
        editBtn.enabled = NO;
    }
    else
    {
        editBtn.enabled = YES;
    }
    [systemMessageTableView reloadData];
}

/*!
 @method editOrFinish
 @abstract 点击编辑按钮或完成按钮
 @discussion 点击编辑按钮或完成按钮
 @param 无
 @result 无
 */
-(void)editOrFinish
{
    
    Resources *oRes = [Resources getInstance];
    if (editType==EDIT)
    {
        editType=FINISH;
        [editBtn setTitle:[oRes getText:@"message.MessageViewController.finishButton"] forState:UIControlStateNormal];
        [systemMessageTableView reloadData];
        [self tableViewEdit];
    }
    else
    {
        editType=EDIT;
        [editBtn setTitle:[oRes getText:@"message.MessageViewController.editButton"] forState:UIControlStateNormal];
        //提交操作，未完成
        [self submitData];
        [self tableViewEdit];
        [systemMessageTableView reloadData];
    }
}


/*!
 @method submitData
 @abstract 提交，本地删除消息
 @discussion 提交，本地删除消息
 @param 无
 @result 无
 */
-(void)submitData
{
    
    int row;
    SystemMessageData *tempData;
   // int code=2005;
    
   // NSMutableArray *ntfyList = [[[NSMutableArray alloc] init]autorelease];
   // NSString *delID;
    //取到要删除文件的车友ID
    int deleteMessagesNumber = [_deleteMutableArray count];
    if (deleteMessagesNumber > 0) {
        //网络接口OK后使用下面代码
//        for (row= 0; row < deleteMessagesNumber; row++)
//        {
//            tempData=[self.deleteMutableArray objectAtIndex:row];
//            delID=[NSString stringWithFormat:@"%@",tempData.mDATA_ID];
//            
//            [ntfyList addObject:delID];
//        }
        //        删除本地数据，未使用接口
        App *app = [App getInstance];
        if (app.mUserData.mType == USER_LOGIN_DEMO)//判断是否DEMO用户
        {
            App *app = [App getInstance];
            
            //将本地的数据修改
            for (row= 0; row < [_deleteMutableArray count]; row++)
            {
                tempData = [self.deleteMutableArray objectAtIndex:row];
                [app deleteSystemMessage:tempData.mMessageID];
                [app deleteMessageInfo:tempData.mKeyID];
            }
            [self loadData];
        }
//        非demo用户
//        else
//        {
//            //使用删除接口
//            backBtn.enabled=NO;
//            editBtn.enabled=NO;
//            Resources *oRes = [Resources getInstance];
//            //点击完成时，重新设置imageView
//            [self.imageView setImage:nil];
//            [self.imageView setFrame:CGRectMake(160, 200, 0, 0)];
//            //显示加载等待框
//            self.progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
//            [self.view addSubview:self.progressHUD];
//            [self.view bringSubviewToFront:self.progressHUD];
//            self.progressHUD.delegate = self;
//            self.progressHUD.labelText = [oRes getText:@"message.common.deleteTitle"];
//            self.progressHUD.detailsLabelText = [oRes getText:@"message.common.deleteText"];
//            [self.progressHUD show:YES];
//            [mDelete createRequest:ntfyList code:code];
//            [mDelete sendRequestWithAsync:self];
//        }
    }

    
}


/*!
 @method tableViewEdit
 @abstract 列表编辑
 @discussion 列表编辑
 @param 无
 @result 无
 */
- (void)tableViewEdit
{
    [systemMessageTableView setEditing:!systemMessageTableView.editing animated:YES];
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
    [backBtn addTarget:self action:@selector(popself)forControlEvents:UIControlEventTouchUpInside];
    return [[[UIBarButtonItem alloc]initWithCustomView:backBtn] autorelease];
}

/*!
 @method showSystemMessageDetail：
 @abstract 查看消息详情，暂时无用
 @discussion 查看消息详情，暂时无用
 @param rowValue 消息所在行数
 @result 无
 */
-(void)showSystemMessageDetail:(NSString *)rowValue
{
    SystemMessageDetailViewController *systemMessageDetailViewController=[[SystemMessageDetailViewController alloc]init];
    [systemMessageDetailViewController setKeyID:rowValue];
    systemMessageDetailViewController.navigationItem.leftBarButtonItem =[self createBackButton];
    [self.navigationController pushViewController:systemMessageDetailViewController animated:YES];
    [systemMessageDetailViewController release];
    NSLog(@"%@",rowValue);
}


/*!
 @method tableviewReloadData
 @abstract 列表重新加载
 @discussion 列表重新加载
 @param 无
 @result 无
 */
-(void)tableviewReloadData
{
    [systemMessageTableView reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    _systemMessageMutableArray= nil;
    _deleteMutableArray=nil;
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
    //    NSLog(@"%d",[_locationRequestMutableArray count]);
    //如果没有消息，则不显示点击加载更多
    if ([_systemMessageMutableArray count] == 0) {
        return 0;
    }
    else
    {
        return [_systemMessageMutableArray count];
    }
    
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
    static NSString *identifier = @"naviIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SystemMessageCell" owner:self options:nil] lastObject];
    }
    UILabel *message=(UILabel*)[cell viewWithTag:2];
    UIImageView *image = (UIImageView *)[cell viewWithTag:1];
//    UIButton *detail=(UIButton*)[cell viewWithTag:3];
//    detail.tag = indexPath.row+100;
//    //    [detail setBackgroundImage:[UIImage imageNamed:@"default"] forState:UIControlStateNormal];
//    if (editType==EDIT) {
//        detail.hidden=YES;
//    }
//    [detail addTarget:self action:@selector(detailButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    //设置图标
    //[image initWithImage: [UIImage imageNamed:@"message_system_icon"]];
    image.image = [UIImage imageNamed:@"message_system_icon"];
    SystemMessageData *systemMessage;
    systemMessage = [_systemMessageMutableArray objectAtIndex:indexPath.row];
//    message.text = systemMessage.mContent;
    message.text=@"您的车辆【辽A12345】于【2013-3-18 08:08:08】发生非正常位置移动，请您进行核实，并采取相应措施。";
    message.textColor = [UIColor colorWithRed:87.0/255.0f green:87.0/255.0f blue:87.0/255.0f alpha:1];

    
    App *app = [App getInstance];
    [app setMessageAsReaded:@"5"];
    
    return cell;
}
//-(void) dresserDetails:(NSInteger)index{
//    //NSLog(@"indexPath.row=%d",index);
//    Resources *oRes = [Resources getInstance];
//    NSString *rowValue = [_electronicFenceMutableArray objectAtIndex:index];
//    [self showElectronicFenceDetail:rowValue];
//}
//-(IBAction)detailButtonClicked:(id)sender{
//    [self dresserDetails:((UIButton *)sender).tag-100];
//}

/*!
 @method tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 @abstract 设置列表是否为可编辑
 @discussion 设置列表是否为可编辑
 @param tableView，indexPath
 @result bool
 */
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(![tableView isEditing])
    {
        return UITableViewCellEditingStyleNone;
    }
    
    return UITableViewCellEditingStyleDelete;
}


/**********************************************************
 函数名称:- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
 函数描述:显示无消息的提示信息，
 输入参数:N/A
 返回值:UIView :noMessageView。
 **********************************************************/
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return noMessageView;
}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    //点击按钮事件发生
    [_deleteMutableArray addObject:[_systemMessageMutableArray objectAtIndex:indexPath.row]];
    [_systemMessageMutableArray removeObjectAtIndex:indexPath.row];
//    删除效果，暂不启用
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [systemMessageTableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
//    [systemMessageTableView reloadData];
}

-(NSString *)tableView:(UITableView *)tableView
titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    //设置按钮的名称
    Resources *oRes = [Resources getInstance];
    return [oRes getText:@"common.delete"];
}
#pragma mark –
#pragma mark Data Source Loading / Reloading Methods
- (void)reloadTableViewDataSource{
    [systemMessageTableView reloadData];
    NSLog(@"==开始加载数据");
    //    App *app=[App getInstance];
    //    if (app.mUserData.mType!= USER_LOGIN_DEMO)//判断是否DEMO用户
    //    {
    //        //[self serverLoad];
    //        //[sendToCarTableView reloadData];
    //    }
    _reloading = YES;
}
- (void)doneLoadingTableViewData{
    NSLog(@"===加载完数据");
    _reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:systemMessageTableView];
}

#pragma mark –
#pragma mark UIScrollViewDelegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}
#pragma mark –
#pragma mark EGORefreshTableHeaderDelegate Methods
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    [self reloadTableViewDataSource];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
}
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    return _reloading;
}
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    return [NSDate date];
}

@end
