
/*!
 @header SendToCarViewController.m
 @abstract 发送到车消息类
 @author mengy
 @version 1.00 13-5-2 Creation
 */
#import "SendToCarViewController.h"
#import "App.h"
#import "SendToCarDetailViewController.h"
@interface SendToCarViewController ()
{
    UIBarButtonItem *rightButton;
    int editType;
}
@end

@implementation SendToCarViewController
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
    [_sendToCarMutableArray removeAllObjects];
    [_sendToCarMutableArray release];
    _sendToCarMutableArray=nil;
    
    [_deleteMutableArray removeAllObjects];
    [_deleteMutableArray release];
    _deleteMutableArray=nil;
    [rightButton release];
    
    [mDelete release];
    
    [sendToCarTableView release],sendToCarTableView = nil;
    [titleLabel release],titleLabel = nil;
    [loadButton release],loadButton = nil;
    [footerLabel release],footerLabel = nil;
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
    editType=EDIT;
    Resources *oRes = [Resources getInstance];
    
//    titleLabel.text=[oRes getText:@"message.sendToCarViewController.title"];
//    titleLabel.font =[UIFont navBarTitleSize];
//    titleLabel.textColor=[UIColor whiteColor];
//    self.navigationItem.titleView=titleLabel;
    
    self.navigationItem.title=[oRes getText:@"message.sendToCarViewController.title"];
    
    editBtn = [[RightButton alloc]init];
    backBtn = [[LeftButton alloc]init];
    [editBtn setTitle:[oRes getText:@"message.MessageViewController.editButton"] forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(editOrFinish)forControlEvents:UIControlEventTouchUpInside];
    editBtn.titleLabel.font =[UIFont navBarItemSize];
    rightButton=[[UIBarButtonItem alloc]initWithCustomView:editBtn];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    sendToCarTableView.backgroundColor = [UIColor colorWithRed:231.0/255.0f green:231.0/255.0f blue:231.0/255.0f alpha:1];
    
    self.deleteMutableArray = [[NSMutableArray alloc] initWithCapacity:0];
//    [self loadData];
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
 @method loadData
 @abstract 加载本地消息
 @discussion 加载本地消息
 @param 无
 @result 无
 */
-(void)loadData
{
    App *app = [App getInstance];
    self.sendToCarMutableArray = [app loadAllMeetRequestSendToCarMessage];
    NSLog(@"%d",_sendToCarMutableArray.count);
  
    if (_sendToCarMutableArray.count==0) {
        //footerLabel提示没有信息
        footerLabel.hidden=NO;
        //没有消息时编辑按钮不可用
        editBtn.enabled = NO;
    }
    else
    {
        editBtn.enabled = YES;
    }
    [sendToCarTableView reloadData];
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
        [sendToCarTableView reloadData];
        [self tableViewEdit];
    }
    else//点击完成按钮
    {
        editType=EDIT;
        [editBtn setTitle:[oRes getText:@"message.MessageViewController.editButton"] forState:UIControlStateNormal];
        //提交操作，未完成
        [self submitData];
        [self tableViewEdit];
        [sendToCarTableView reloadData];
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
//    int row;
    Resources *oRes = [Resources getInstance];
    SendToCarMessageData *tempData;
    //int code=2001;
//    NSMutableArray *ntfyList = [[[NSMutableArray alloc] init]autorelease];
//    NSString *delID;
    //取到要删除文件的车友ID
    int deleteMessagesNumber = [_deleteMutableArray count];
    if (deleteMessagesNumber > 0) {
        //网络接口OK后使用下面代码
//        for (row= 0; row < deleteMessagesNumber; row++)
//        {
//            tempData=[self.deleteMutableArray objectAtIndex:row];
//            delID=[NSString stringWithFormat:@"%@",tempData.mID];
//            [ntfyList addObject:delID];
//        }
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
            [app deleteSendToCarMessageWithIDs:str];
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
            [app deleteSendToCarMessageWithIDs:str];
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

/**
 *现不使用
//删除消息的回调函数
- (void)onDeleteNotificationResult:(NSMutableDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg
{
    App *app = [App getInstance];
    SendToCarMessageData *tempData;
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
        [app deleteSendToCarMessageWithIDs:str];
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
 @abstract 编辑列表
 @discussion 编辑列表
 @param 无
 @result 无
 */
- (void)tableViewEdit
{
    [sendToCarTableView setEditing:!sendToCarTableView.editing animated:YES];
}

/*!
 @method popself
 @abstract 返回上一页，刷新数据
 @discussion 返回上一页，刷新数据
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
 @method showSendToCarDetail：
 @abstract 查看消息详情
 @discussion 查看消息详情
 @param rowValue 消息所在行数
 @result 无
 */
-(void)showSendToCarDetail:(NSString *)rowValue
{
    SendToCarDetailViewController *sendToCarDetailViewController=[[[SendToCarDetailViewController alloc]init]autorelease];
    [sendToCarDetailViewController setKeyID:rowValue];
    [self.navigationController pushViewController:sendToCarDetailViewController animated:YES];
    NSLog(@"%@",rowValue);
}

/*!
 @method tableviewReloadData
 @abstract 重新加载消息列表
 @discussion 重新加载消息列表
 @param 无
 @result 无
 */
-(void)tableviewReloadData
{
    [sendToCarTableView reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    _sendToCarMutableArray= nil;
    _deleteMutableArray=nil;
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
    return [_sendToCarMutableArray count];
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
    static NSString *identifier = @"naviIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SendToCarCell" owner:self options:nil] lastObject];
    }

    NSUInteger row = [indexPath row];
    NSLog(@"%d",[_sendToCarMutableArray count]);
    UIView * contentView= (UIView*)[cell viewWithTag:20];
    UIView * loadView= (UIView*)[cell viewWithTag:10];
   // footerView= (UIView*)[cell viewWithTag:10];
    if (row==[_sendToCarMutableArray count]) {
        if ([_sendToCarMutableArray count] == 0) {
            
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
    }else
    {
        loadView.hidden=YES;
        UILabel *time=(UILabel*)[cell viewWithTag:2];
        UILabel *message=(UILabel*)[cell viewWithTag:3];
        UIImageView *image = (UIImageView *)[cell viewWithTag:1];
        UIButton *detail=(UIButton*)[cell viewWithTag:4];
        UILabel *name=(UILabel*)[cell viewWithTag:5];
        
        
        detail.tag = indexPath.row+100;
        if (editType==FINISH) {
            detail.hidden=YES;
            
        }
        [detail addTarget:self action:@selector(detailButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        SendToCarMessageData *mdata = [_sendToCarMutableArray objectAtIndex:row];
        
        //设置图标需要判断是否已读，以及是不是消息类型
        App *app = [App getInstance];
        

        if ([app getMessageStatus:mdata.mMessageKeyID] == MESSAGE_READ)
        {
            if (mdata.mEventTime !=nil && ![mdata.mEventTime isEqualToString:@""])
            {
                image.image = [UIImage imageNamed:@"message_event_receive_open"];
            }
            else
            {
                image.image = [UIImage imageNamed:@"message_icon_open"];
            }
        }
        else
        {
            if (mdata.mEventTime !=nil && ![mdata.mEventTime isEqualToString:@""])
            {
                image.image = [UIImage imageNamed:@"message_event_receive_close"];
            }
            else
            {
                image.image = [UIImage imageNamed:@"message_icon_close"];
            }
        }
        NSDate *date = nil;
        NSString *fName = @"";
        NSString *fLocName = @"";
        NSString *sendTime = @"";
        if ([mdata.mSendUserID isEqualToString:app.mUserData.mUserID]) {
            fName = [[NSString alloc]initWithString:[oRes getText:@"friend.FriendList.selfName"]];
        }
        else
        {
            if (mdata.mSendUserName != nil &&![mdata.mSendUserName isEqualToString:@""]) {
                fName = [[NSString alloc]initWithString:mdata.mSendUserName];
            }
            else if(mdata.mSendUserTel != nil &&![mdata.mSendUserTel isEqualToString:@""])
            {
                fName = [[NSString alloc]initWithString:mdata.mSendUserTel];
            }
            else
            {
                fName = [[NSString alloc]initWithString:@""];
            }
        }
        
        if (mdata.mPoiName != nil &&![mdata.mPoiName isEqualToString:@""]) {
            fLocName = [[NSString alloc]initWithString:mdata.mPoiName];
        }
        
        time.text = [app getCreateTime:mdata.mKeyID];//[dateFormatter stringFromDate:date];
        sendTime = [App getDateWithTimeSince1970:mdata.mSendTime];
        
        NSString *messageinfo=nil;
        if (fName) {
           messageinfo = [NSString stringWithFormat:@"%@%@%@%@%@%@",fName,[oRes getText:@"message.SendToCarViewController.message1"],sendTime,[oRes getText:@"message.SendToCarViewController.message2"],fLocName,[oRes getText:@"message.SendToCarViewController.message3"]];//mdata.mCONTENT];
        }
        else
        {
            messageinfo = [NSString stringWithFormat:@"%@%@%@%@%@",[oRes getText:@"message.SendToCarViewController.message1"],sendTime,[oRes getText:@"message.SendToCarViewController.message2"],fLocName,[oRes getText:@"message.SendToCarViewController.message3"]];//mdata.mCONTENT];
        }
        
        
        
        
//        NSString *messageinfo = [[NSString alloc] initWithFormat:@"您于【%@】发送【%@】给您的好友【%@】。", time.text, mdata.mCONTENT, mdata.mSENDER,];
        message.text = messageinfo;
        message.textColor = [UIColor colorWithRed:87.0/255.0f green:87.0/255.0f blue:87.0/255.0f alpha:1];
        time.textColor = [UIColor colorWithRed:129.0/255.0f green:129.0/255.0f blue:129.0/255.0f alpha:1];
        
        message.font = [UIFont boldSystemFontOfSize:12];
        name.font = [UIFont boldSystemFontOfSize:15];
        time.font = [UIFont boldSystemFontOfSize:10];
        name.text=fName;
        name.textColor = [UIColor colorWithRed:0.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:1];
        message.textColor = [UIColor colorWithRed:87.0/255.0f green:87.0/255.0f blue:87.0/255.0f alpha:1];
        time.textColor = [UIColor colorWithRed:129.0/255.0f green:129.0/255.0f blue:129.0/255.0f alpha:1];

    }
	return cell;
}

/*!
 @method onclickLoad
 @abstract 加载更多消息，暂时无用
 @discussion 加载更多消息，暂时无用
 @param 无
 @result 无
 */
-(void)onclickLoad
{
//获取更多消息
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
    if (indexPath.row==[_sendToCarMutableArray count])
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
 @abstract 选择某行进入详情
 @discussion 选择某行进入详情
 @param tableView，indexPath
 @result 无
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    if(row<_sendToCarMutableArray.count)
    {
        SendToCarMessageData *rowValue = [_sendToCarMutableArray objectAtIndex:row];
        SendToCarDetailViewController *sendToCarDetailViewController=[[SendToCarDetailViewController alloc]init];
        [sendToCarDetailViewController setKeyID:rowValue.mMessageKeyID];
        sendToCarDetailViewController.navigationItem.leftBarButtonItem =[self createBackButton];
        [self.navigationController pushViewController:sendToCarDetailViewController animated:YES];
        [sendToCarDetailViewController release];
        App *app = [App getInstance];
        
        [app setMessageAsReaded:rowValue.mMessageKeyID];
    }
    
}

/*!
 @method dresserDetails:(NSInteger)index
 @abstract 点击详情按钮进入详情界面
 @discussion 点击详情按钮进入详情界面
 @param index
 @result 无
 */
-(void) dresserDetails:(NSInteger)index
{
    SendToCarMessageData *rowValue = [_sendToCarMutableArray objectAtIndex:index];
    SendToCarDetailViewController *sendToCarDetailViewController=[[SendToCarDetailViewController alloc]init];
    [sendToCarDetailViewController setKeyID:rowValue.mMessageKeyID];
    sendToCarDetailViewController.navigationItem.leftBarButtonItem =[self createBackButton];
    [self.navigationController pushViewController:sendToCarDetailViewController animated:YES];
    [sendToCarDetailViewController release];

    App *app = [App getInstance];
    [app setMessageAsReaded:rowValue.mMessageKeyID];
}

/*!
 @method detailButtonClicked:(id)sender
 @abstract 点击详情按钮
 @discussion 点击详情按钮
 @param 无
 @result 无
 */
-(IBAction)detailButtonClicked:(id)sender{
    //    NSLog(@"%d",((UIButton *)sender).tag);
    [self dresserDetails:((UIButton *)sender).tag-100];
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
    [_deleteMutableArray addObject:[_sendToCarMutableArray objectAtIndex:indexPath.row]];
    [_sendToCarMutableArray removeObjectAtIndex:indexPath.row];
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
//    删除效果，暂不启用
    [sendToCarTableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
//    [sendToCarTableView reloadData];
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
