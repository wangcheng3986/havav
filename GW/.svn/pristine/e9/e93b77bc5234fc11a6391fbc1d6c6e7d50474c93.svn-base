
/*!
 @header ElectronicFenceViewController.m
 @abstract 电子围栏消息类
 @author mengy
 @version 1.00 13-5-2 Creation
 */
#import "ElectronicFenceViewController.h"
#import "App.h"
#import "ElectronicFenceDetailViewController.h"
@interface ElectronicFenceViewController ()
{
    UIBarButtonItem *rightButton;
    int editType;
        bool _reloading;
}
@end

@implementation ElectronicFenceViewController


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
    [_electronicFenceMutableArray removeAllObjects];
    [_electronicFenceMutableArray release];
    _electronicFenceMutableArray=nil;
    
    [_deleteMutableArray removeAllObjects];
    [_deleteMutableArray release];
    _deleteMutableArray=nil;
    [rightButton release];
    
    
    [electronicFenceTableView release],electronicFenceTableView = nil;
    [titleLabel release],titleLabel =nil;
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
        //[self.navigationController.navigationBar setShadowImage:[UIImage imageNamed:@"common_ios7_shadowImage_bg"]];
    }
    else
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_ios6_navBar_bg"] forBarMetrics:UIBarMetricsLandscapePhone];
    }
    mCherryDBControl = [CherryDBControl sharedCherryDBControl];
    
    editType=EDIT;
    Resources *oRes = [Resources getInstance];
    
    
//    titleLabel.text=[oRes getText:@"message.ElecFenceViewController.Title"];
//    titleLabel.font =[UIFont navBarTitleSize];
//    titleLabel.textColor=[UIColor whiteColor];
//    self.navigationItem.titleView=titleLabel;
    
    self.navigationItem.title = [oRes getText:@"message.ElecFenceViewController.Title"];
    
    editBtn = [[RightButton alloc]init];
    backBtn = [[LeftButton alloc]init];
    //Navigationbar实现左右button
    [editBtn setTitle:[oRes getText:@"message.MessageViewController.editButton"] forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(editOrFinish)forControlEvents:UIControlEventTouchUpInside];
    editBtn.titleLabel.font =[UIFont navBarItemSize];
    rightButton=[[UIBarButtonItem alloc]initWithCustomView:editBtn];
    self.navigationItem.rightBarButtonItem = rightButton;
    self.deleteMutableArray = [[NSMutableArray alloc] initWithCapacity:0];
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
    
    self.electronicFenceMutableArray = [mCherryDBControl loadElectronicFenceMessage:app.mUserData.mUserID];

    if (_electronicFenceMutableArray.count==0) {
        //没有消息时编辑按钮不可用
        editBtn.enabled = NO;
    }
    else
    {
        editBtn.enabled = YES;
    }
    [electronicFenceTableView reloadData];
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
//    点击编辑
    if (editType==EDIT)
    {
        editType=FINISH;
        [editBtn setTitle:[oRes getText:@"message.MessageViewController.finishButton"] forState:UIControlStateNormal];
        [electronicFenceTableView reloadData];
        [self tableViewEdit];
    }
//    点击完成
    else
    {
        editType=EDIT;
        [editBtn setTitle:[oRes getText:@"message.MessageViewController.editButton"] forState:UIControlStateNormal];
        //提交操作，未完成
        [self submitData];
        [self tableViewEdit];
        [electronicFenceTableView reloadData];
    }
}

-(void)editOrFinish2
{
    
    Resources *oRes = [Resources getInstance];
    //    点击编辑
    if (editType==EDIT)
    {
        editType=FINISH;
        [editBtn setTitle:[oRes getText:@"message.MessageViewController.finishButton"] forState:UIControlStateNormal];
    }
    //    点击完成
    else
    {
        editType=EDIT;
        [editBtn setTitle:[oRes getText:@"message.MessageViewController.editButton"] forState:UIControlStateNormal];
        //提交操作，未完成
        [self submitData];
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
    ElectronicFenceMessageData *tempData;
    //取到要删除文件的车友ID
    int deleteMessagesNumber = [_deleteMutableArray count];
    if (deleteMessagesNumber > 0) {
        //网络接口OK后使用下面代码
        App *app = [App getInstance];
        
        //将本地的数据修改
        NSString *str=[NSString stringWithFormat:@""];
        for (int i=0; i<_deleteMutableArray.count; i++) {
            tempData=[_deleteMutableArray objectAtIndex:i];
            str=[NSString stringWithFormat:@"%@,'%@'",str,tempData.mMessageKeyID];
            
        }
        str = [str substringFromIndex:1];
        //一次性删除多条消息
        [mCherryDBControl deleteElectronicFenceMessageWithIDs:str];
        [app deleteMessageInfoWithIDs:str];
        [self.deleteMutableArray removeAllObjects];
        [self loadData];
        [self MBProgressHUDMessage:[oRes getText:@"message.common.deleteSuccess"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
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
    [electronicFenceTableView setEditing:!electronicFenceTableView.editing animated:YES];
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
    Resources *oRes = [Resources getInstance];
    
    [backBtn setTitle:[oRes getText:@"message.DetailViewController.leftButton"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(popself)forControlEvents:UIControlEventTouchUpInside];
    return [[[UIBarButtonItem alloc]initWithCustomView:backBtn]autorelease];
}

/*!
 @method showElectronicFenceDetail:
 @abstract 进入消息详情
 @discussion 进入消息详情
 @param rowValue 消息所在行数
 @result 无
 */
-(void)showElectronicFenceDetail:(NSString *)rowValue
{
    ElectronicFenceDetailViewController *electronicFenceDetailViewController=[[ElectronicFenceDetailViewController alloc]init];
    [electronicFenceDetailViewController setKeyID:rowValue];
    electronicFenceDetailViewController.navigationItem.leftBarButtonItem =[self createBackButton];
    [self.navigationController pushViewController:electronicFenceDetailViewController animated:YES];
    [electronicFenceDetailViewController release];
    NSLog(@"%@",rowValue);
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
    [electronicFenceTableView reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    _electronicFenceMutableArray= nil;
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
 @param tableView
 @param section
 @result count 列表行数
 */
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{ 
    return [_electronicFenceMutableArray count];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ElectronicFenceCell" owner:self options:nil] lastObject];
    }
    NSUInteger row = [indexPath row];
    
    UILabel *type = (UILabel*)[cell viewWithTag:2];
    UILabel *time=(UILabel*)[cell viewWithTag:3];
    UILabel *message=(UILabel*)[cell viewWithTag:4];
    UIImageView *image = (UIImageView *)[cell viewWithTag:1];
    UIButton *detail=(UIButton*)[cell viewWithTag:5];
    
    detail.tag = indexPath.row+100;
    if (editType==FINISH) {
        detail.hidden=YES;
    }
    [detail addTarget:self action:@selector(detailButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    NSLog(@"%d",[_electronicFenceMutableArray count]);
    ElectronicFenceMessageData *mdata = [_electronicFenceMutableArray objectAtIndex:row];
    //设置图标,通过读MessageInfo数据实现
    App *app = [App getInstance];
    
    if ([app getMessageStatus:mdata.mMessageKeyID] == MESSAGE_READ) {
        image.image = [UIImage imageNamed:@"message_icon_open"];
        
    }
    else{
        image.image = [UIImage imageNamed:@"message_icon_close"];
        
    }
    
    type.textColor = [UIColor colorWithRed:0.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:1];
    message.textColor = [UIColor colorWithRed:87.0/255.0f green:87.0/255.0f blue:87.0/255.0f alpha:1];
    time.textColor = [UIColor colorWithRed:129.0/255.0f green:129.0/255.0f blue:129.0/255.0f alpha:1];
    type.font = [UIFont boldSystemFontOfSize:15];
    message.font = [UIFont boldSystemFontOfSize:12];
    time.font = [UIFont boldSystemFontOfSize:10];
    Resources *oRes = [Resources getInstance];
    if ([mdata.mAlarmType intValue] == 0) {
        type.text=[oRes getText:@"message.ElecFenceViewController.typeWithInto"];
    }
    else
    {
        type.text=[oRes getText:@"message.ElecFenceViewController.typeWithOut"];
    }
    
    time.text = [app getCreateTime:mdata.mKeyid];
    NSString *messageinfo = [NSString stringWithFormat:@"%@%@%@%@%@%@",[[App getInstance] searchCarNum:mdata.mMessageKeyID],[oRes getText:@"message.ElecFenceViewController.message1"],[App getDateWithTimeSince1970:mdata.mAlarmTime],[oRes getText:@"message.ElecFenceViewController.message2"],type.text,[oRes getText:@"message.ElecFenceViewController.message3"]];
    message.text = messageinfo;
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
    if (indexPath.row==[_electronicFenceMutableArray count])
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
    if (row < _electronicFenceMutableArray.count) {
        ElectronicFenceMessageData *rowValue = [_electronicFenceMutableArray objectAtIndex:row];
        
        ElectronicFenceDetailViewController *electronicFenceDetailViewController=[[ElectronicFenceDetailViewController alloc]init];
        [electronicFenceDetailViewController setKeyID:rowValue.mMessageKeyID];
        electronicFenceDetailViewController.navigationItem.leftBarButtonItem =[self createBackButton];
        [self.navigationController pushViewController:electronicFenceDetailViewController animated:YES];
        [electronicFenceDetailViewController release];
        
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
    ElectronicFenceMessageData *rowValue = [_electronicFenceMutableArray objectAtIndex:index];
    ElectronicFenceDetailViewController *electronicFenceDetailViewController=[[[ElectronicFenceDetailViewController alloc]init]autorelease];
    [electronicFenceDetailViewController setKeyID:rowValue.mMessageKeyID];
    electronicFenceDetailViewController.navigationItem.leftBarButtonItem =[self createBackButton];
    [self.navigationController pushViewController:electronicFenceDetailViewController animated:YES];
    
    //Update ElectronicFenceMessageData数据库修改状态为已读。
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
    //    NSLog(@"%d",((UIButton *)sender).tag);
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
//   if (editType==EDIT)
//   {
//       [self editOrFinish2];
//   }
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (editType==FINISH)
//    {
//        [self editOrFinish2];
//    }
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
    [_deleteMutableArray addObject:[_electronicFenceMutableArray objectAtIndex:indexPath.row]];
    [_electronicFenceMutableArray removeObjectAtIndex:indexPath.row];
//    删除效果，暂不启用
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [electronicFenceTableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
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
