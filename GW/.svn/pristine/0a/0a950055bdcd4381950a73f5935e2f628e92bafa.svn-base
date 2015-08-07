
/*!
 @header LocationRequestViewController.m
 @abstract 位置请求消息类
 @author mengy
 @version 1.00 13-5-2 Creation
 */

#import "LocationRequestViewController.h"
#import "App.h"
#import "LocationRequestDetailViewController.h"
@interface LocationRequestViewController ()
{
    UIBarButtonItem *rightButton;
    int editType;
        bool _reloading;
}
@end

@implementation LocationRequestViewController
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
    [_locationRequestMutableArray removeAllObjects];
    [_locationRequestMutableArray release];
    _locationRequestMutableArray=nil;
    
    [_deleteMutableArray removeAllObjects];
    [_deleteMutableArray release];
    _deleteMutableArray=nil;
    [rightButton release];
    [mDelete release];
    
    [locationRequestTableView release],locationRequestTableView = nil;
    [titleLabel release],titleLabel = nil;
    
    [loadButton release],loadButton = nil;
    //   [footerView release],footerView = nil;
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
        //[self.navigationController.navigationBar setShadowImage:[UIImage imageNamed:@"common_ios7_shadowImage_bg"]];
    }
    else
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_ios6_navBar_bg"] forBarMetrics:UIBarMetricsLandscapePhone];
    }
    mDelete = [[NINotificationDelete alloc]init];
    //后期可能会用下拉刷新
//    if (_refreshHeaderView == nil) {
//        _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.view.bounds.size.height, self.view.frame.size.width, self.view.bounds.size.height)];
//        _refreshHeaderView.delegate = self;
//        [locationRequestTableView addSubview:_refreshHeaderView];
//    }
//    [_refreshHeaderView refreshLastUpdatedDate];
    
    
    locationRequestTableView.backgroundColor = [UIColor colorWithRed:231.0/255.0f green:231.0/255.0f blue:231.0/255.0f alpha:1];
    
    editType=EDIT;
    Resources *oRes = [Resources getInstance];
    
    footerLabel.text=[oRes getText:@"map.collectViewController.footerlabeltext"];
    footerLabel.font =[UIFont size12];
    footerLabel.hidden=YES;
    
//    titleLabel.text=[oRes getText:@"message.locationRequestViewController.title"];
//    titleLabel.font =[UIFont navBarTitleSize];
//    titleLabel.textColor=[UIColor whiteColor];
//    self.navigationItem.titleView=titleLabel;
    
    self.navigationItem.title = [oRes getText:@"message.locationRequestViewController.title"];
    
    editBtn = [[RightButton alloc]init];
    backBtn = [[LeftButton alloc]init];
    [editBtn setTitle:[oRes getText:@"message.MessageViewController.editButton"] forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(editOrFinish)forControlEvents:UIControlEventTouchUpInside];
    rightButton=[[UIBarButtonItem alloc]initWithCustomView:editBtn];
    self.navigationItem.rightBarButtonItem = rightButton;
    self.deleteMutableArray = [[NSMutableArray alloc] initWithCapacity:0];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNewMessage:) name:Notification_New_Message object:nil];
    // Do any additional setup after loading the view from its nib.
}


/*!
 @method viewWillAppear
 @abstract 加载消息
 @discussion 加载消息
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
 @abstract 加载本地数据
 @discussion 加载本地数据
 @param 无
 @result 无
 */
-(void)loadData
{
    App *app = [App getInstance];
    self.locationRequestMutableArray = [app loadAllMeetRequestFriendLocationMessage];
    if (_locationRequestMutableArray.count==0) {
        //footerLabel提示没有信息
        footerLabel.hidden=NO;
        //没有消息时编辑按钮不可用
        editBtn.enabled = NO;
    }
    else
    {
        editBtn.enabled = YES;
    }
    [locationRequestTableView reloadData];
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
 @method loadeditOrFinishData
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
        [locationRequestTableView reloadData];
        [self tableViewEdit];
    }
    else//点击完成按钮
    {
        editType=EDIT;
        [editBtn setTitle:[oRes getText:@"message.MessageViewController.editButton"] forState:UIControlStateNormal];
        //提交操作，未完成
        [self submitData];
        [self tableViewEdit];
        [locationRequestTableView reloadData];
    }
}

/*!
 @method submitData
 @abstract 提交
 @discussion 提交，删除本地消息
 @param 无
 @result 无
 */
-(void)submitData
{

    Resources *oRes = [Resources getInstance];
    FriendLocationData *tempData;
    //取到要删除文件的车友ID
    int deleteMessagesNumber = [_deleteMutableArray count];
    if (deleteMessagesNumber > 0) {
//        删除本地数据，未使用接口
        App *app = [App getInstance];
        if (app.mUserData.mType == USER_LOGIN_DEMO)//判断是否DEMO用户
        {
           
            //App *app = [App getInstance];
            
            //将本地的数据修改
            NSString *str=[NSString stringWithFormat:@""];
            for (int i=0; i<_deleteMutableArray.count; i++) {
                tempData=[_deleteMutableArray objectAtIndex:i];
                str=[NSString stringWithFormat:@"%@,'%@'",str,tempData.mMessageKeyID];
            }
            str = [str substringFromIndex:1];
            //一次性删除多条消息
            [app deleteFriendLocationMessageWithIDs:str];
            [app deleteMessageInfoWithIDs:str];
            [self.deleteMutableArray removeAllObjects];
            [self loadData];
        }
        else
        {
            
            NSString *str=[NSString stringWithFormat:@""];
            for (int i=0; i<_deleteMutableArray.count; i++) {
                tempData=[_deleteMutableArray objectAtIndex:i];
                str=[NSString stringWithFormat:@"%@,'%@'",str,tempData.mMessageKeyID];
            }
            str = [str substringFromIndex:1];
            //一次性删除多条消息
            [app deleteFriendLocationMessageWithIDs:str];
            [app deleteMessageInfoWithIDs:str];
            [self.deleteMutableArray removeAllObjects];
            [self loadData];
            self.navigationItem.leftBarButtonItem.enabled = YES;
            editBtn.enabled=YES;
            
            
//原来的机制是删除本地消息，先向服务器发请求，如果服务器数据删除成功，在删除本地。
            //使用删除接口
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
 @abstract 删除消息的回调函数，现无用
 @discussion 删除消息的回调函数
 @param result 返回数据
 @param code 返回码
 @param errorMsg 错误信息
 @result 无
 */
/**
 *现无用
- (void)onDeleteNotificationResult:(NSMutableDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg
{
    App *app = [App getInstance];
    FriendLocationData *tempData;
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
        [app deleteFriendLocationMessageWithIDs:str];
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
        [alert release];    }
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
 @abstract 列表状态
 @discussion 列表状态
 @param 无
 @result 无
 */
- (void)tableViewEdit
{
    [locationRequestTableView setEditing:!locationRequestTableView.editing animated:YES];
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
    [backBtn addTarget:self action:@selector(popself) forControlEvents:UIControlEventTouchUpInside];
    return [[[UIBarButtonItem alloc]initWithCustomView:backBtn] autorelease];
}

/*!
 @method showLocationRequeseDetail：
 @abstract 进入消息详情
 @discussion 进入消息详情
 @param rowValue 消息所在行数
 @result 无
 */
-(void)showLocationRequeseDetail:(NSString *)rowValue
{
    LocationRequestDetailViewController *locationRequestDetailViewController=[[[LocationRequestDetailViewController alloc]init]autorelease];
    [locationRequestDetailViewController setKeyID:rowValue];
//    locationRequestDetailViewController.navigationItem.leftBarButtonItem =[self createBackButton];
    [self.navigationController pushViewController:locationRequestDetailViewController animated:YES];
    NSLog(@"%@",rowValue);
}



/*!
 @method tableviewReloadData
 @abstract 重新加载列表
 @discussion 重新加载列表
 @param 无
 @result 无
 */
-(void)tableviewReloadData
{
    [locationRequestTableView reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    _locationRequestMutableArray= nil;
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
 @abstract 返回行数
 @discussion 返回行数
 @param tableView，section
 @result 无
 */
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [_locationRequestMutableArray count];
}

#pragma mark - button action
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
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LocationRequestCell" owner:self options:nil] lastObject];
    }
    
    NSUInteger row = [indexPath row];

    UIView * contentView= (UIView*)[cell viewWithTag:20];
    UIView * loadView= (UIView*)[cell viewWithTag:10];
  //  footerView= (UIView*)[cell viewWithTag:10];
    if (row==[_locationRequestMutableArray count]) {
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
    }else
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
        
        NSLog(@"%d",[_locationRequestMutableArray count]);
        FriendLocationData *mdata = [_locationRequestMutableArray objectAtIndex:row];
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
            fName=mdata.mRqUserName;
        }
        else
        {
            if (mdata.mRqUserName != nil &&![mdata.mRqUserName isEqualToString:@""]) {
                fName = [[NSString alloc]initWithString:mdata.mRqUserName];
            }
            else if(mdata.mRqUserTel != nil &&![mdata.mRqUserTel isEqualToString:@""])
            {
                fName = [[NSString alloc]initWithString:mdata.mRqUserTel];
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
        
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//
//        NSDate *date = nil;
//        NSString *sendTime = nil;
//        if (app.mUserData.mType == USER_LOGIN_DEMO) {
//            [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
//            date = [dateFormatter dateFromString:mdata.mRqTime];
//            //modify for locationTime by wangqiwei 2014 6 13
//             sendTime = [dateFormatter stringFromDate:date];
//            time.text = [app getCreateTime:mdata.mKeyID];//[dateFormatter stringFromDate:date];
//            NSLog(@"%@", date);
//        }
//        else
//        {
//            date = [NSDate dateWithTimeIntervalSince1970:[mdata.mRqTime doubleValue]/1000];
//            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//            //modify for locationTime by wangqiwei 2014 6 13
//            sendTime = [dateFormatter stringFromDate:date];
//            time.text = [app getCreateTime:mdata.mKeyID];//[dateFormatter stringFromDate:date];
//        }
//        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//        //modify for locationTime by wangqiwei 2014 6 13
//        sendTime = [dateFormatter stringFromDate:date];
//        time.text =[app getCreateTime:mdata.mKeyID];//[dateFormatter stringFromDate:date];
//        [dateFormatter release];
        
        NSString *sendTime = nil;
        sendTime = [App getDateWithTimeSince1970:mdata.mRqTime];
        time.text =[app getCreateTime:mdata.mKeyID];//[dateFormatter stringFromDate:date];
        if (fName) {
            NSString *messageinfo = [NSString stringWithFormat:@"%@%@%@%@",fName,[oRes getText:@"message.locationRequestViewController.message1"],sendTime,[oRes getText:@"message.locationRequestViewController.message2"]];
            message.text = messageinfo;
        }
        else
        {
            //消息格式
            //NSString *messageinfo = [NSString stringWithFormat:@"您的好友【%@】，于【%@】请求位置信息,请您处理。",mdata.mFriendPhone,time.text];
             NSString *messageinfo = [NSString stringWithFormat:@"%@%@%@",[oRes getText:@"message.locationRequestViewController.message2"],sendTime,[oRes getText:@"message.locationRequestViewController.message3"]];
            message.text = messageinfo;
        }

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
    if (indexPath.row==[_locationRequestMutableArray count])
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
    if(row<_locationRequestMutableArray.count)
    {
        FriendLocationData *rowValue = [_locationRequestMutableArray objectAtIndex:row];
        LocationRequestDetailViewController *locationRequestDetailViewController=[[LocationRequestDetailViewController alloc]init];
        [locationRequestDetailViewController setKeyID:rowValue.mMessageKeyID];
        locationRequestDetailViewController.navigationItem.leftBarButtonItem =[self createBackButton];
        [self.navigationController pushViewController:locationRequestDetailViewController animated:YES];
        [locationRequestDetailViewController release];
        App *app = [App getInstance];
        
        [app setMessageAsReaded:rowValue.mMessageKeyID];
    }
}


/*!
 @method dresserDetails:(NSInteger)index
 @abstract 进入消息详情
 @discussion 进入消息详情
 @param index 第几个消息
 @result 无
 */
-(void) dresserDetails:(NSInteger)index{

    FriendLocationData *rowValue = [_locationRequestMutableArray objectAtIndex:index];
    LocationRequestDetailViewController *locationRequestDetailViewController=[[LocationRequestDetailViewController alloc]init];
    [locationRequestDetailViewController setKeyID:rowValue.mMessageKeyID];
    locationRequestDetailViewController.navigationItem.leftBarButtonItem =[self createBackButton];
    [self.navigationController pushViewController:locationRequestDetailViewController animated:YES];
    [locationRequestDetailViewController release];
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
 @abstract 设置列表样式
 @discussion 设置列表样式
 @param tableView，indexPath
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
 @abstract 点击删除按钮的事件
 @discussion 点击删除按钮的事件
 @param tableView，indexPath，editingStyle
 @result 无
 */
- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    //点击按钮事件发生
    [_deleteMutableArray addObject:[_locationRequestMutableArray objectAtIndex:indexPath.row]];
    [_locationRequestMutableArray removeObjectAtIndex:indexPath.row];
//    删除效果，暂不启用
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [locationRequestTableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
//    [locationRequestTableView reloadData];
}

/*!
 @method tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 @abstract 删除按钮的文字显示
 @discussion 删除按钮的文字显示
 @param tableView，indexPath
 @result str
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
    [locationRequestTableView reloadData];
    NSLog(@"==开始加载数据");
    _reloading = YES;
}
- (void)doneLoadingTableViewData{
    NSLog(@"===加载完数据");
    _reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:locationRequestTableView];
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
*/

@end
