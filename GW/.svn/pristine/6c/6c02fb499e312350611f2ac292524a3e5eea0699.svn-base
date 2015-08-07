
/*!
 @header FriendLocationViewController.m
 @abstract 车友位置消息类
 @author mengy
 @version 1.00 13-5-2 Creation
 */
#import "FriendLocationViewController.h"
#import "App.h"
#import "FriendLocationDetailViewController.h"
@interface FriendLocationViewController ()
{
    UIBarButtonItem *rightButton;
    int editType;
        bool _reloading;
}
@end

@implementation FriendLocationViewController
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
    [_friendLocationMutableArray removeAllObjects];
    [_friendLocationMutableArray release];
    _friendLocationMutableArray=nil;
    
    [_deleteMutableArray removeAllObjects];
    [_deleteMutableArray release];
    _deleteMutableArray=nil;
    [rightButton release];
    [mDelete release];
    
    [friendLocationTableView release],friendLocationTableView = nil;
    [titleLabel release],titleLabel =nil;
    [loadButton release],loadButton =nil;
    [footerLabel release],footerLabel =nil;
    if (backBtn) {
        [backBtn release];
        backBtn = nil;
    }
    if (editBtn) {
        [editBtn release];
        editBtn = nil;
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
    mDelete = [[NINotificationDelete alloc]init];
    Resources *oRes = [Resources getInstance];
    
    footerLabel.text=[oRes getText:@"map.collectViewController.footerlabeltext"];
    footerLabel.font =[UIFont size12];
    footerLabel.hidden=YES;
    
    editType=EDIT;
    
    self.navigationItem.title = [oRes getText:@"message.friendLocationViewController.title"];
    
    editBtn = [[RightButton alloc]init];
    backBtn = [[LeftButton alloc]init];
    [editBtn setTitle:[oRes getText:@"message.MessageViewController.editButton"] forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(editOrFinish)forControlEvents:UIControlEventTouchUpInside];
    rightButton=[[UIBarButtonItem alloc]initWithCustomView:editBtn];
    
    self.navigationItem.rightBarButtonItem = rightButton;
    
    friendLocationTableView.backgroundColor = [UIColor colorWithRed:231.0/255.0f green:231.0/255.0f blue:231.0/255.0f alpha:1];
    
    self.deleteMutableArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNewMessage:) name:Notification_New_Message object:nil];
    // Do any additional setup after loading the view from its nib.
}


/*!
 @method viewWillAppear：
 @abstract 加载消息数据
 @discussion 加载消息数据
 @param 无
 @result 无
 */
-(void)viewWillAppear:(BOOL)animated
{
    [self loadData];
    [super viewWillAppear:animated];
}

/*!
 @method loadData
 @abstract 本地加载数据
 @discussion 本地加载数据
 @param 无
 @result 无
 */
-(void)loadData
{
    App *app = [App getInstance];
    self.friendLocationMutableArray = [app loadAllMeetRequestFriendRequestLocationMessage];
    NSLog(@"%d",_friendLocationMutableArray.count);
    if (_friendLocationMutableArray.count==0) {
        //footerLabel提示没有信息
        footerLabel.hidden=NO;
        //没有消息时编辑按钮不可用
        editBtn.enabled = NO;
    }
    else
    {
        editBtn.enabled = YES;
    }
    [friendLocationTableView reloadData];
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
    id obj = [notification object];
    NSLog(@"%@",obj);
    int newMessageCount = [obj integerValue];
    
    if (newMessageCount > 0)
    {
        [self loadData];
    }
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
        [friendLocationTableView reloadData];
        [self tableViewEdit];
    }
    else//点击完成按钮
    {
        editType=EDIT;
        [editBtn setTitle:[oRes getText:@"message.MessageViewController.editButton"] forState:UIControlStateNormal];
        //提交操作，未完成
        [self submitData];
        [self tableViewEdit];
        [friendLocationTableView reloadData];
    }
}

/*!
 @method submitData
 @abstract 提交删除数据
 @discussion 提交删除数据
 @param 无
 @result 无
 */
-(void)submitData
{
    Resources *oRes = [Resources getInstance];
    FriendRequestLocationMessageData *tempData;
    //int code=2004;
    //取到要删除文件的车友ID
    int deleteMessagesNumber = [_deleteMutableArray count];
    if (deleteMessagesNumber > 0) {
        //        删除本地数据，未使用接口
        App *app = [App getInstance];
        if (app.mUserData.mType == USER_LOGIN_DEMO)//判断是否DEMO用户
        {
            App *app = [App getInstance];
        
            //将本地的数据修改
            NSString *str=[NSString stringWithFormat:@""];
            for (int i=0; i<_deleteMutableArray.count; i++) {
                tempData=[_deleteMutableArray objectAtIndex:i];
                str=[NSString stringWithFormat:@"%@,'%@'",str,tempData.mMessageKeyID];
            }
            str = [str substringFromIndex:1];
            //一次性删除多条消息
            [app deleteFriendRequestLocationMessageWithIDs:str];
            [app deleteMessageInfoWithIDs:str];
            [self.deleteMutableArray removeAllObjects];
            [self loadData];
        }
        else
        {
            
            
            //将本地的数据修改
            NSString *str=[NSString stringWithFormat:@""];
            for (int i=0; i<_deleteMutableArray.count; i++) {
                tempData=[_deleteMutableArray objectAtIndex:i];
                str=[NSString stringWithFormat:@"%@,'%@'",str,tempData.mMessageKeyID];
            }
            str = [str substringFromIndex:1];
            //一次性删除多条消息
            [app deleteFriendRequestLocationMessageWithIDs:str];
            [app deleteMessageInfoWithIDs:str];
            [self.deleteMutableArray removeAllObjects];
            [self loadData];
            self.navigationItem.leftBarButtonItem.enabled = YES;
            editBtn.enabled=YES;
            
            
//            //使用删除接口
//            self.navigationItem.leftBarButtonItem.enabled = NO;
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
        }
        [self MBProgressHUDMessage:[oRes getText:@"message.common.deleteSuccess"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
}

/*!
 @method onDeleteNotificationResult:(NSMutableDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg
 @abstract 服务器删除数据回调函数，暂时无用
 @discussion 服务器删除数据回调函数，暂时无用
 @param result 返回数据
 @param code 返回码
 @param errorMsg 错误信息
 @result 无
 */
/**
 *无用
- (void)onDeleteNotificationResult:(NSMutableDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg
{
    App *app = [App getInstance];
    FriendRequestLocationMessageData *tempData;
    NSLog(@"receive the result.");
    if (code == NAVINFO_RESULT_SUCCESS) {
        NSLog(@"result is :%@", result);
        
        //将本地的数据修改
        NSString *str=[NSString stringWithFormat:@""];
        for (int i=0; i<_deleteMutableArray.count; i++) {
            tempData=[_deleteMutableArray objectAtIndex:i];
            str=[NSString stringWithFormat:@"%@,'%@'",str,tempData.mMessageKeyID];
        }
        str = [str substringFromIndex:1];
        //一次性删除多条消息
        [app deleteFriendRequestLocationMessageWithIDs:str];
        [app deleteMessageInfoWithIDs:str];
    }
    else if(code == NET_ERROR )
    {
        Resources *oRes = [Resources getInstance];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[oRes getText:@"common.noNetAlert.message"]delegate:self cancelButtonTitle:[oRes getText:@"common.noNetAlert.cancelButtonTitle"] otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    //tokenid失效操作
    else if(code == NAVINFO_TOKENID_INVALID)
    {
        Resources *oRes = [Resources getInstance];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[oRes getText:@"common.loseTokenID.message"]delegate:self cancelButtonTitle:[oRes getText:@"common.loseTokenID.cancelButtonTitle"] otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    else
    {
        Resources *oRes = [Resources getInstance];
        UIAlertView *alert;
        alert = [[UIAlertView alloc] initWithTitle:nil message:[oRes getText:@"message.common.deleteFail"]delegate:self cancelButtonTitle:[oRes getText:@"message.common.deleteFailCencel"] otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    [self.imageView setFrame:CGRectMake(160, 200, 0, 0)];
    if (self.progressHUD){
        [self.progressHUD removeFromSuperview];
        [self.progressHUD release];
        self.progressHUD = nil;
    }
    
    [self.deleteMutableArray removeAllObjects];
    [self loadData];
    self.navigationItem.leftBarButtonItem.enabled = YES;
    editBtn.enabled=YES;
}
*/


/*!
 @method tableViewEdit
 @abstract 列表编辑
 @discussion 列表编辑
 @param 无
 @result 无
 */
- (void)tableViewEdit
{
    [friendLocationTableView setEditing:!friendLocationTableView.editing animated:YES];
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
    [self loadData];
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
 @method showFriendLocationDetail:
 @abstract 进入消息详情
 @discussion 进入消息详情
 @param rowValue 消息所在行数
 @result 无
 */
-(void)showFriendLocationDetail:(NSString *)rowValue
{
    FriendLocationDetailViewController *friendLocationDetailViewController=[[[FriendLocationDetailViewController alloc]init]autorelease];
    [friendLocationDetailViewController setKeyID:rowValue];
    friendLocationDetailViewController.navigationItem.leftBarButtonItem =[self createBackButton];
    [self.navigationController pushViewController:friendLocationDetailViewController animated:YES];
}



/*!
 @method tableviewReloadData:
 @abstract 列表刷新
 @discussion 列表刷新
 @param 无
 @result 无
 */
-(void)tableviewReloadData
{
    [friendLocationTableView reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    _friendLocationMutableArray= nil;
    _deleteMutableArray=nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

/*!
 @method tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
 @abstract 设置列表行数
 @discussion 设置列表行数
 @param tableView
 @param section
 @result count 列表行数
 */
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [_friendLocationMutableArray count];
}

#pragma mark - button action

/*!
 @method onclickLoad
 @abstract 加载更多数据
 @discussion 加载更多数据，无用
 @param 无
 @result 无
 */
-(void)onclickLoad
{
    //获取更多消息
}


/*!
 @method tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 @abstract 新建某一行并返回
 @discussion 新建某一行并返回
 @param tableView
 @param indexPath
 @result cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"naviIdentifier";
    Resources *oRes = [Resources getInstance];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FriendLocationCell" owner:self options:nil] lastObject];
    }
    NSUInteger row = [indexPath row];
    
    UIView * contentView= (UIView*)[cell viewWithTag:20];
    UIView * loadView= (UIView*)[cell viewWithTag:10];
   // footerView= (UIView*)[cell viewWithTag:10];
    if (row==[_friendLocationMutableArray count]) {
        if (row == 0) {
            contentView.hidden=YES;
            footerLabel= (UILabel*)[cell viewWithTag:12];
            footerLabel.text=[oRes getText:@"map.collectViewController.footerlabeltext"];
            footerLabel.font =[UIFont size12];
            //footerLabel.hidden=NO;不再显示对不起，没有数据
            footerLabel.hidden=YES;
            //editBtn.enabled = NO;
        }else
        {
            editBtn.enabled = YES;
            contentView.hidden=YES;
            loadButton= (UIButton*)[cell viewWithTag:11];
            loadButton.titleLabel.font=[UIFont size12];
            [loadButton addTarget:self action:@selector(onclickLoad) forControlEvents:UIControlEventTouchDown];
            [loadButton  setTitle:[oRes getText:@"message.MessageViewController.loadButton"] forState:UIControlStateNormal];
            loadButton.hidden = NO;
        }
    }
    else
    {
        loadView.hidden=YES;
        UILabel *sender = (UILabel*)[cell viewWithTag:2];
        UILabel *time=(UILabel*)[cell viewWithTag:3];
        UILabel *message=(UILabel*)[cell viewWithTag:4];
        UIImageView *image = (UIImageView *)[cell viewWithTag:1];
        UIButton *detail=(UIButton*)[cell viewWithTag:5];
        detail.tag = indexPath.row+100;
        if (editType==FINISH) {
            detail.hidden=YES;
            
        }
        [detail addTarget:self action:@selector(detailButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        
        NSUInteger row = [indexPath row];
        
        NSLog(@"%d",[_friendLocationMutableArray count]);
        FriendRequestLocationMessageData *mdata = [_friendLocationMutableArray objectAtIndex:row];
        //设置图标
        App *app = [App getInstance];
        
        if ([app getMessageStatus:mdata.mMessageKeyID] == 1) {
            image.image = [UIImage imageNamed:@"message_icon_open"];

        }
        else{
            image.image = [UIImage imageNamed:@"message_icon_close"];
        }
        NSString *fName;
        if (app.mUserData.mType == USER_LOGIN_DEMO) {
            fName=mdata.mFriendUserName;
        }
        else
        {
            if (mdata.mFriendUserName != nil &&![mdata.mFriendUserName isEqualToString:@""]) {
                fName = [[NSString alloc]initWithString:mdata.mFriendUserName];
            }
            else if(mdata.mFriendUserTel != nil &&![mdata.mFriendUserTel isEqualToString:@""])
            {
                fName = [[NSString alloc]initWithString:mdata.mFriendUserTel];
            }
            else
            {
                fName = [[NSString alloc]initWithString:@""];
            }
            
        }
        
        message.font = [UIFont boldSystemFontOfSize:12];
        sender.font = [UIFont boldSystemFontOfSize:15];
        time.font = [UIFont boldSystemFontOfSize:10];
        sender.text=fName;
        sender.textColor = [UIColor colorWithRed:0.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:1];
        message.textColor = [UIColor colorWithRed:87.0/255.0f green:87.0/255.0f blue:87.0/255.0f alpha:1];
        time.textColor = [UIColor colorWithRed:129.0/255.0f green:129.0/255.0f blue:129.0/255.0f alpha:1];
//        NSDate *date = nil;
//        NSString *sendTime= nil;
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        if (app.mUserData.mType == USER_LOGIN_DEMO) {
//            [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
//            date = [dateFormatter dateFromString:mdata.mResponseTime];
//            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//            sendTime = [dateFormatter stringFromDate:date];
//            //modify for locationTime by wangqiwei 2014 6 13
//            time.text = [app getCreateTime:mdata.mKeyID];//[dateFormatter stringFromDate:date];
//        }
//        else
//        {
//            sendTime = [App getDateWithTimeSince1970:mdata.mResponseTime];
//            //modify for locationTime by wangqiwei 2014 6 13
//            time.text = [app getCreateTime:mdata.mKeyID];//[dateFormatter stringFromDate:date];
//        }
//        [dateFormatter release];
        NSString *sendTime= nil;
        sendTime = [App getDateWithTimeSince1970:mdata.mResponseTime];
        //modify for locationTime by wangqiwei 2014 6 13
        time.text = [app getCreateTime:mdata.mKeyID];//[dateFormatter stringFromDate:date];
        if (fName) {
            //消息格式
            //NSString *messageinfo = [NSString stringWithFormat:@"您的好友%@，于%@已经%@您查看他的位置信息。",fName,time.text,@"同意"];
            NSString *messageinfo = [NSString stringWithFormat:@"%@%@%@%@",fName,[oRes getText:@"message.friendLocationDetailViewController.message1"],sendTime,[oRes getText:@"message.friendLocationDetailViewController.message2"]];
            message.text = messageinfo;
        }
        else
        {
            NSString *messageinfo = [NSString stringWithFormat:@"%@%@%@",[oRes getText:@"message.friendLocationDetailViewController.message1"],sendTime,[oRes getText:@"message.friendLocationDetailViewController.message2"]];
            message.text = messageinfo;
        }
        
    }
	return cell;
}


/*!
 @method tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 @abstract 设置列表是否可编辑
 @discussion 设置列表是否可编辑
 @param tableView
 @param indexPath
 @result bool
 */
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==[_friendLocationMutableArray count])
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

/*!
 @method tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 @abstract 列表选中某行
 @discussion 列表选中某行，执行方法，进入详情界面
 @param tableView
 @param indexPath
 @result 无
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    if(row<_friendLocationMutableArray.count)
    {
        FriendRequestLocationMessageData *rowValue = [_friendLocationMutableArray objectAtIndex:row];
        FriendLocationDetailViewController *friendLocationDetailViewController=[[[FriendLocationDetailViewController alloc]init]autorelease];
        [friendLocationDetailViewController setKeyID:rowValue.mMessageKeyID];
        friendLocationDetailViewController.navigationItem.leftBarButtonItem =[self createBackButton];
        [self.navigationController pushViewController:friendLocationDetailViewController animated:YES];
        //Update ElectronicFenceMessageData数据库修改状态为已读。
        App *app = [App getInstance];
        
        [app setMessageAsReaded:rowValue.mMessageKeyID];
    }
}

/*!
 @method dresserDetails:
 @abstract 进入详情
 @discussion 进入详情
 @param index 第几行
 @result 无
 */
-(void) dresserDetails:(NSInteger)index{
    FriendRequestLocationMessageData *rowValue = [_friendLocationMutableArray objectAtIndex:index];
    FriendLocationDetailViewController *friendLocationDetailViewController=[[FriendLocationDetailViewController alloc]init];
    [friendLocationDetailViewController setKeyID:rowValue.mMessageKeyID];
    friendLocationDetailViewController.navigationItem.leftBarButtonItem =[self createBackButton];
    [self.navigationController pushViewController:friendLocationDetailViewController animated:YES];
    [friendLocationDetailViewController release];
    App *app = [App getInstance];
    
    [app setMessageAsReaded:rowValue.mMessageKeyID];
}


/*!
 @method detailButtonClicked:
 @abstract 点击详情按钮
 @discussion 点击详情按钮
 @param 无
 @result 无
 */
-(IBAction)detailButtonClicked:(id)sender{
    [self dresserDetails:((UIButton *)sender).tag-100];
}



/*!
 @method tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
 @abstract 是否为删除格式
 @discussion 是否为删除格式
 @param 无
 @result UITableViewCellEditingStyle
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
 @abstract 点击删除，将数据从列表移除
 @discussion 点击删除，将数据从列表移除
 @param tableView，editingStyle，indexPath
 @result 无
 */
- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    //点击按钮事件发生
    [_deleteMutableArray addObject:[_friendLocationMutableArray objectAtIndex:indexPath.row]];

    [_friendLocationMutableArray removeObjectAtIndex:indexPath.row];
//    删除效果，暂不启用
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [friendLocationTableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
//    [friendLocationTableView reloadData];
}


/*!
 @method tableView:(UITableView *)tableView
 titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
 @abstract 删除按钮文字
 @discussion 删除按钮文字
 @param tableView，indexPath
 @result NSString
 */
-(NSString *)tableView:(UITableView *)tableView
titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
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


/**
 *下拉刷新，无用
#pragma mark –
#pragma mark Data Source Loading / Reloading Methods
- (void)reloadTableViewDataSource{
    [friendLocationTableView reloadData];
    NSLog(@"==开始加载数据");
    _reloading = YES;
}
- (void)doneLoadingTableViewData{
    NSLog(@"===加载完数据");
    _reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:friendLocationTableView];
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
    return [NSDate date];;
}
*/
@end
