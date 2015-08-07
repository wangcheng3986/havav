
/*!
 @header SelectFriendViewController.m
 @abstract 选择车友
 @author mengy
 @version 1.00 13-5-14 Creation
 */

#import "SelectFriendViewController.h"
#import "SendToCarViewViewController.h"
#import "App.h"
@interface SelectFriendViewController ()
{
    int sexType;
    UserData *mUserData;
    BOOL rootPop;
    NSMutableArray *numArray;
    NSMutableArray *nameArray;
    int selectedCount;
    UIBarButtonItem *leftButton;
    UIBarButtonItem *rightButton;
}
@end

@implementation SelectFriendViewController
@synthesize selectDataArray;
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
    if (_dataMutableArray) {
        [_dataMutableArray removeAllObjects];
        [_dataMutableArray release];
        _dataMutableArray=nil;
    }
    if (phoneDictionary) {
        [phoneDictionary removeAllObjects];
        [phoneDictionary release];
        phoneDictionary=nil;
    }
    if (phoneNameDictionary) {
        [phoneNameDictionary removeAllObjects];
        [phoneNameDictionary release];
        phoneNameDictionary=nil;
    }
    if (nameDictionary) {
        [nameDictionary removeAllObjects];
        [nameDictionary release];
        nameDictionary=nil;
    }
    if (numArray) {
        [numArray removeAllObjects];
        [numArray release];
        numArray=nil;
    }
    if (nameArray) {
        [nameArray removeAllObjects];
        [nameArray release];
        nameArray=nil;
    }
    if (selectDataArray) {
        [selectDataArray removeAllObjects];
        [selectDataArray release];
        selectDataArray=nil;
    }
    if(tableview)
    {
        [tableview removeFromSuperview];
        [tableview release];
    }
    if(titleLabel)
    {
        [titleLabel removeFromSuperview];
        [titleLabel release];
    }
    if(backBtn)
    {
        [backBtn removeFromSuperview];
        [backBtn release];
    }
    if(finishBtn)
    {
        [finishBtn removeFromSuperview];
        [finishBtn release];
    }
    if (leftButton) {
        [leftButton release];
        leftButton = nil;
    }
    
    if (rightButton) {
        [rightButton release];
        rightButton = nil;
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
 @abstract 加载界面，初始化数据
 @discussion 加载界面，初始化数据
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
    Resources *oRes=[Resources getInstance];
//    titleLabel.text=[oRes getText:@"selectFriendViewController.title"];
//    titleLabel.font =[UIFont navBarTitleSize];
//    self.navigationItem.titleView=titleLabel;
    
    self.navigationItem.title=[oRes getText:@"selectFriendViewController.title"];
    
    finishBtn = [[RightButton alloc]init];
    [finishBtn setTitle:[oRes getText:@"selectFriendViewController.rightButton"] forState:UIControlStateNormal];
    [finishBtn addTarget:self action:@selector(finish)forControlEvents:UIControlEventTouchUpInside];
    rightButton=[[UIBarButtonItem alloc]initWithCustomView:finishBtn];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    backBtn = [[LeftButton alloc]init];
    [backBtn addTarget:self action:@selector(goBack)forControlEvents:UIControlEventTouchUpInside];
    leftButton=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftButton;
     selectDataArray = [[NSMutableArray alloc]initWithCapacity:0];
    numArray = [[NSMutableArray alloc]initWithCapacity:0];
    nameArray = [[NSMutableArray alloc]initWithCapacity:0];
    phoneDictionary = [[NSMutableDictionary alloc]initWithCapacity:0];
    nameDictionary = [[NSMutableDictionary alloc]initWithCapacity:0];
    phoneNameDictionary = [[NSMutableDictionary alloc]initWithCapacity:0];
    numDictionary = [[NSMutableDictionary alloc]initWithCapacity:0];
    [phoneNameDictionary addEntriesFromDictionary:_rootController.phoneNameDictionary];
    [nameDictionary addEntriesFromDictionary:_rootController.nameDictionary];
    [phoneDictionary addEntriesFromDictionary:_rootController.phoneDictionary];
    selectedCount =phoneDictionary.count;
    [self getLocalData];
    [tableview reloadData];
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
 @method getLocalData
 @abstract 获取本地车友列表
 @discussion 获取本地车友列表
 @param 无
 @result 无
 */
-(void)getLocalData
{
    //    本地获取数据
    App *app = [App getInstance];
    self.dataMutableArray =[app loadMeetRequestFriendData];
    for (int i = 0; i < self.dataMutableArray.count; i++) {
        [numArray setObject:@"0" atIndexedSubscript:i];
    }
    NSLog(@"%d",_dataMutableArray.count);
}


/*!
 @method goBack
 @abstract 返回上一页
 @discussion 返回上一页
 @param 无
 @result 无
 */
-(void)goBack
{
    [self popself];
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
 @param tableView,section
 @result count
 */
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return [_dataMutableArray count];
    
}
#pragma mark - button action

/*!
 @method tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 @abstract 加载列表数据
 @discussion 加载列表数据
 @param tableView,indexPath
 @result cell
 */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             TableSampleIdentifier];
    if (cell==nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"addFriendCell" owner:self options:nil] lastObject];
        
    }
    NSUInteger row = [indexPath row];
    UILabel *name = (UILabel*)[cell viewWithTag:1];
    UIButton *select=(UIButton*)[cell viewWithTag:2];
    select.tag = indexPath.row+100;
    select.imageView.hidden=YES;
    FriendsData *data = [_dataMutableArray objectAtIndex:row];
    name.text = data.mfName;
    name.font = [UIFont size14_5];
    [select addTarget:self action:@selector(selectFriend:) forControlEvents:UIControlEventTouchUpInside];
    if ( [phoneDictionary objectForKey:[NSString stringWithFormat:@"%@",[nameDictionary objectForKey:[NSString stringWithFormat:@"%d",row]]]] ||[[numArray objectAtIndex:row]integerValue]) {
        [select setImage:[UIImage imageNamed:@"map_send2car_addFriend_checkbox_selected"] forState:UIControlStateNormal];
        [numArray setObject:[NSString stringWithFormat:@"1"] atIndexedSubscript:row];
    }
    else
    {
        [numArray setObject:[NSString stringWithFormat:@"0"] atIndexedSubscript:row];
    }
    return cell;
}

/*!
 @method selectFriend:(id)sender
 @abstract 选中某个车友时执行方法
 @discussion 选中某个车友时执行方法
 @param 无
 @result 无
 */
-(IBAction)selectFriend:(id)sender {
    NSString *tempPhone;
    NSString *tempName;
    App *app=[App getInstance];
    mUserData=[app getUserData];
    Resources *oRes = [Resources getInstance];
    UIButton *btn = (UIButton*)sender;
    int index=btn.tag-100;
    FriendsData *data = [_dataMutableArray objectAtIndex:index];
    tempPhone=data.mfPhone;
    tempName=data.mfName;
    if ([btn imageForState:UIControlStateNormal]==nil) {
        if (selectedCount >= 10) {
            [self MBProgressHUDMessage:[oRes getText:@"selectFriendViewController.alertCentent"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
        }
        else
        {
            [numArray setObject:[NSString stringWithFormat:@"1"] atIndexedSubscript:index];
            [btn setImage:[UIImage imageNamed:@"map_send2car_addFriend_checkbox_selected"] forState:UIControlStateNormal];
            selectedCount += 1;
        }
        
    }
    else
    {
        [numArray setObject:[NSString stringWithFormat:@"0"] atIndexedSubscript:index];
        [btn setImage:nil forState:UIControlStateNormal];
        selectedCount -= 1;
    }
}




/*!
 @method finish
 @abstract 单击完成时，组装数据，并返回send2car界面
 @discussion 单击完成时，组装数据，并返回send2car界面
 @param 无
 @result 无
 */
-(void) finish
{
    [selectDataArray removeAllObjects];
    NSString *name;
     NSMutableDictionary *tempDic = [[NSMutableDictionary alloc]initWithCapacity:0];
//    将选中的数据放入selectDataArray中
    for (int i = 0; i<[numArray count]; i ++) {
        if ([[numArray objectAtIndex:i]intValue]) {
            FriendsData *data = [_dataMutableArray objectAtIndex:i];
            name=data.mfName;
            if ([tempDic objectForKey:name]) {
                [tempDic setObject:[NSString stringWithFormat:@"%d",[[tempDic objectForKey:name]intValue]+1] forKey:name];
            }
            else
            {
                [tempDic setObject:[NSString stringWithFormat:@"%d",1] forKey:name];
            }
            
            FriendsData *data2 = [[FriendsData alloc]init];
            data2.mfKeyID = data.mfKeyID;
            data2.mfID = data.mfID;
            data2.mfName = data.mfName;
            data2.mfPhone = data.mfPhone;
            [selectDataArray addObject:data2];
            [data2 release];
            
        }
    }
//    从tempDic中移除未重复的name
    NSArray *array = [tempDic allKeys];
    int count = tempDic.count;
    for (int i = 0; i < count; i++) {
        if ([[tempDic objectForKey:[array objectAtIndex:i]]intValue]==1) {
            [tempDic removeObjectForKey:[array objectAtIndex:i]];
        }
    }
//    在重复的name后加数字
    for (int i = selectDataArray.count-1; i >= 0; i --) {
        FriendsData *data = [selectDataArray objectAtIndex:i];
        name = data.mfName;
        if ([[tempDic objectForKey:name]intValue] > 0)
        {
            data.mfName = [NSString stringWithFormat:@"%@%d",data.mfName,[[tempDic objectForKey:name]intValue]];
            [tempDic setObject:[NSString stringWithFormat:@"%d",[[tempDic objectForKey:name]intValue]-1] forKey:name];
        }
    }
    
//    把数据存入nameDictionary，phoneDictionary，phoneNameDictionary，_rootController.numDictionary中
    NSString *tempPhone;
    NSString *tempName;
    int num = 0;
    [nameDictionary removeAllObjects];
    [phoneDictionary removeAllObjects];
    [phoneNameDictionary removeAllObjects];
    for (int i = 0; i<[numArray count]; i ++) {
        if ([[numArray objectAtIndex:i]intValue]==1) {
            FriendsData *data = [selectDataArray objectAtIndex:num];
            num ++;
            tempName=data.mfName;
            tempPhone=data.mfPhone;
            [phoneDictionary setObject:tempPhone forKey:[NSString stringWithFormat:@"%@",tempName]];
            [nameDictionary setObject:tempName forKey:[NSString stringWithFormat:@"%d",i]];
            [phoneNameDictionary setObject:tempName forKey:tempPhone];
            [numDictionary setObject:[NSString stringWithFormat:@"%d",i] forKey:tempName];
        }
    }
    if (tempDic) {
        [tempDic removeAllObjects];
        [tempDic release];
        tempDic = nil;
    }
    [_rootController setData:phoneDictionary phoneNameDictionary:phoneNameDictionary nameDictionary:nameDictionary numDictionary:numDictionary];
    [self popself];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
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
