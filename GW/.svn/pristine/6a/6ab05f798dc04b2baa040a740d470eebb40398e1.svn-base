

/*!
 @header CollectViewController.m
 @abstract 收藏夹类
 @author mengy
 @version 1.00 13-4-24 Creation
 */
#import <QuartzCore/QuartzCore.h>
#import "CollectViewController.h"
#import "App.h"
#import "POIDetailViewController.h"
#import "POIData.h"
#import "MapTabBarViewController.h"
@interface CollectViewController ()
{
    int editType;
    int collectSyncType;
    POIData *poiData;
    int poiLoad;
    int isFirst;
    int count;
    int operateType;
    int startCount;
    double lon;
    double lat;
    NSString *Lon;
    NSString *Lat;
    int loginType;
}
@end

@implementation CollectViewController
@synthesize picUrlString = _picUrlString;
@synthesize imageView = _imageView;
@synthesize progressHUD = _progressHUD;
POIDetailViewController *poiDetailViewController;
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
    if (_refreshHeaderView) {
        [_refreshHeaderView removeFromSuperview];
        [_refreshHeaderView release];
    }
    [mQueryPOI release];
    [mDeletePOI release];
    [mPOISycn release];
    if (_deleteMutableArray) {
        [_deleteMutableArray removeAllObjects];
        [_deleteMutableArray release];
        _deleteMutableArray=nil;
    }
    if (_unCollectData) {
        [_unCollectData removeAllObjects];
        [_unCollectData release];
        _unCollectData=nil;
    }
    if (_collectTableData) {
        [_collectTableData removeAllObjects];
        [_collectTableData release];
        _collectTableData=nil;
    }
    if (_picUrlString) {
        [_picUrlString release];
    }
    if (collectTableView) {
        [collectTableView removeFromSuperview];
        [collectTableView release];
    }
    if (titleLabel) {
        [titleLabel removeFromSuperview];
        [titleLabel release];
    }
    if (sycnBtn) {
        [sycnBtn removeFromSuperview];
        [sycnBtn release];
    }
    if (editBtn) {
        [editBtn removeFromSuperview];
        [editBtn release];
    }
    if (btnView) {
        [btnView removeFromSuperview];
        [btnView release];
    }
    if (self.imageView) {
        [self.imageView removeFromSuperview];
        [self.imageView release];
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
    }
    self.view.backgroundColor = [UIColor colorWithRed:231.0/255 green:231.0/255 blue:231.0/255 alpha:1];
    App *app=[App getInstance];
    mUserData=[app getUserData];
    mQueryPOI = [[NIQueryPOI alloc]init];
    mDeletePOI = [[NIDeletePOI alloc]init];
    mPOISycn = [[NIPOISycn alloc]init];
    loginType=mUserData.mType;
    self.deleteMutableArray =[[NSMutableArray alloc] initWithCapacity:0];
    Resources *oRes = [Resources getInstance];
    [sycnBtn setTitle:[oRes getText:@"map.collectViewController.syncButton"] forState:UIControlStateNormal];
    sycnBtn.contentEdgeInsets = UIEdgeInsetsMake(0,RIGHTBTN_TEXT_LOCATION, 0, 0);
    sycnBtn.titleLabel.font =[UIFont navBarItemSize];
    [editBtn setTitle:[oRes getText:@"map.collectViewController.editButton"] forState:UIControlStateNormal];
    editBtn.titleLabel.font =[UIFont navBarItemSize];
    editType=FINISH;
    startCount=1;
//    设置图片
    self.imageView.backgroundColor = [UIColor clearColor];
    self.imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.imageView.layer.borderWidth = 5.0;
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.cornerRadius = 10.0;
    CGRect rect = CGRectMake( self.navigationController.view.frame.origin.x, self.navigationController.view.frame.origin.y,self.view.frame.size.width,self.view.frame.size.height);
    collectTableView.frame = rect;
    poiLoad=[_rootController poiLoadType];
    [self.view addSubview:collectTableView];
    
    // Do any additional setup after loading the view from its nib.
}

/*!
 @method viewWillAppear:(BOOL)animated
 @abstract 修改导航栏按钮位置，本地加载收藏夹数据
 @discussion 修改导航栏按钮位置，本地加载收藏夹数据
 @param 无
 @result 无
 */
-(void)viewWillAppear:(BOOL)animated
{
    Resources *oRes = [Resources getInstance];
//    titleLabel.text=[oRes getText:@"map.collectViewController.title"];
//    self.tabBarController.navigationItem.titleView=titleLabel;
    self.tabBarController.navigationItem.titleView= nil;
    self.tabBarController.navigationItem.title = [oRes getText:@"map.collectViewController.title"];
    
    self.tabBarController.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:btnView]autorelease];
    if (self.tabBarController.navigationItem.rightBarButtonItems.count>0) {
		UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
		if([App getVersion]<IOS_VER_7) {
			space.width = -5.0;
		} else {
			space.width = -16.0;
		}
		self.tabBarController.navigationItem.rightBarButtonItems = [@[space] arrayByAddingObjectsFromArray:self.tabBarController.navigationItem.rightBarButtonItems];
	}
    [self.unCollectData removeAllObjects];
    [self.collectTableData removeAllObjects];
    isFirst=[_rootController isFirstInCollect];
    [_rootController setIsFirstInCollect:0];
    [self getLocalData];
    
}

/*!
 @method viewWillDisappear:(BOOL)animated
 @abstract 清除导航栏右部按钮
 @discussion 清除导航栏右部按钮
 @param 无
 @result 无
 */
- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.navigationItem.rightBarButtonItems=nil;
    [super viewWillDisappear:animated];
}


/*!
 @method editOrFinish:(id)sender
 @abstract 点击编辑或完成按钮的操作
 @discussion 点击编辑或完成按钮的操作
 @param 无
 @result 无
 */
- (IBAction)editOrFinish:(id)sender
{
    Resources *oRes = [Resources getInstance];
    //点击完成按钮的操作
    if (editType == EDIT)
    {
        editType = FINISH;
        self.navigationItem.leftBarButtonItem.enabled=YES;
        [editBtn setTitle:[oRes getText:@"map.collectViewController.editButton"] forState:UIControlStateNormal];
        sycnBtn.enabled = YES;
        _rootController.tabBarEnabled = YES;
        [self submitData];
        [self tableViewEdit];
        
    }
    //点击编辑按钮的操作
    else
    {
        editType = EDIT;
        [editBtn setTitle:[oRes getText:@"map.collectViewController.finishButton"] forState:UIControlStateNormal];
        sycnBtn.enabled = NO;
        _rootController.tabBarEnabled = NO;
        [self tableViewEdit];
    }
    
    [collectTableView reloadData];
}

/*!
 @method editOrFinish:(id)sender
 @abstract 点击同步按钮操作
 @discussion 点击同步按钮操作，将本地未同步数据组装进行同步
 @param 无
 @result 无
 */
-(IBAction)sync:(id)sender
{
    
    Resources *oRes = [Resources getInstance];
    [self.unCollectData removeAllObjects];
    App *app = [App getInstance];
    self.unCollectData = [app loadMeetRequestPOIDataSyncNO];
    if (loginType!=USER_LOGIN_DEMO)
    {
        
        //同步收藏夹
        
        NSDictionary *para;
        NSMutableArray *addList;
        NSMutableArray *delList;
        NSMutableArray *updateList;
        addList = [[NSMutableArray alloc] initWithCapacity:0];
        delList = [[NSMutableArray alloc] initWithCapacity:0];
        updateList = [[NSMutableArray alloc] initWithCapacity:0];
        NSString *poiID;
        /*禁用tabBar 20140318 孟月*/
        _rootController.tabBarEnabled = NO;
        self.tabBarController.navigationItem.leftBarButtonItem.enabled=NO;
        _rootController.backBtn.enabled = NO;
        sycnBtn.enabled=NO;
        editBtn.enabled=NO;
        _rootController.mDisView.hidden=NO;
        //当进入视图时，重新设置imageView
        [self.imageView setImage:nil];
        [self.imageView setFrame:CGRectMake(160, 200, 0, 0)];
        //显示加载等待框
        self.progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:self.progressHUD];
        [self.view bringSubviewToFront:self.progressHUD];
        self.progressHUD.delegate = self;
        self.progressHUD.labelText = [oRes getText:@"map.collectViewController.sycnTitle"];
        self.progressHUD.detailsLabelText = [oRes getText:@"common.load.text"];
        [self.progressHUD show:YES];
//        [_rootController showProgressHUDWithLabelTitle:[oRes getText:@"map.collectViewController.sycnTitle"] message:[oRes getText:@"common.load.text"]];
        //封装同步数据
        for (int row = 0; row < [self.unCollectData count]; row++) {
            poiData = [_unCollectData objectAtIndex:row];
            if (poiData.mFlag==COLLECT_SYNC_NO_ADD) {
                //同步收藏夹
                NSString *postCode = nil;
                if (poiData.mPostCode) {
                    postCode = poiData.mPostCode;
                }
                else
                {
                    postCode = @"";
                }
                para = [NSDictionary dictionaryWithObjectsAndKeys:
                        poiData.mName,@"poiName",// POI名称
                        poiData.mID,@"poiId",// 如果POI来源是基础数据,需要提供此值,可选
                        poiData.mLon,@"lon",// 经度
                        poiData.mLat,@"lat",// 纬度
                        poiData.mAddress,@"address",// 地址
                        poiData.mPhone,@"conatctsNum",// 联系电话
                        poiData.mCreateTime,@"createTime",
                        nil];
                NSLog(@"%@",para);
                [addList addObject:para];
            }
            if (poiData.mFlag==COLLECT_SYNC_NO_UPDATE) {
                //同步收藏夹
                NSString *postCode = nil;
                if (poiData.mPostCode) {
                    postCode = poiData.mPostCode;
                }
                else
                {
                    postCode = @"";
                }
                para = [NSDictionary dictionaryWithObjectsAndKeys:
                        poiData.mName,@"poiName",// POI名称
                        poiData.mfID,@"id",// 收藏id
                        poiData.mID,@"poiId",// 如果POI来源是基础数据,需要提供此值,可选
                        poiData.mLon,@"lon",// 经度
                        poiData.mLat,@"lat",// 纬度
                        poiData.mAddress,@"address",// 地址
                        poiData.mPhone,@"conatctsNum",// 联系电话
                        poiData.mCreateTime,@"createTime",
                        nil];
                NSLog(@"%@",para);
                [updateList addObject:para];
            }
            else
            {
                poiID = [[NSString alloc]initWithFormat:@"%@",poiData.mfID];
                [delList addObject:poiID];
                [poiID release];
            }
            
        }
        
        [mPOISycn createRequest:addList delList:delList updateList:updateList];
        [mPOISycn sendRequestWithAsync:self];
        [addList removeAllObjects];
        [addList release];
        addList=nil;
        [delList removeAllObjects];
        [delList release];
        delList=nil;
        [updateList removeAllObjects];
        [updateList release];
        updateList=nil;
    }
    else
    {
        if (_unCollectData.count > 0) {
            NSMutableArray *addIDList = [[NSMutableArray alloc]initWithCapacity:0];
            //封装同步数据
            for (int row = 0; row < [self.unCollectData count]; row++)
            {
                poiData = [_unCollectData objectAtIndex:row];
                [addIDList addObject:poiData.mID];
            }
            App *app = [App getInstance];
            [app updateFlag:COLLECT_SYNC_YES IDs:addIDList];
            [addIDList removeAllObjects];
            [addIDList release];
            addIDList = nil;
        }
        [self getLocalData];
        [self MBProgressHUDMessage:[oRes getText:@"map.collectViewController.syncYesAlert"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
        
    }
    
    
    
}

/*!
 @method onPOISyncResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg
 @abstract POI同步回调函数
 @discussion POI同步回调函数，成功后将本地数据清除，将同步下来的数据插入到本地数据库中
 @param result 搜索结果
 @param code 返回码
 @param errorMsg 错误信息
 @result 无
 */
- (void)onPOISyncResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg
{
    App *app = [App getInstance];
    Resources *oRes = [Resources getInstance];
    NSLog(@"receive the result.");
    NSString *address;
    NSString *ID;
    NSString *lastUpdate;
    NSString *poiName;
    NSString *conatctsNum;
    NSString *poiId;
    int flag=COLLECT_SYNC_YES;
    NSLog(@"%d",operateType);
    //同步成功操作
    if (code == NAVINFO_RESULT_SUCCESS) {
        [app deleteAllPOIData];
        NSLog(@"result is :%@", result);
        if ([result objectForKey:@"favoriteList"]) {
            NSArray *temp = [result objectForKey:@"favoriteList"];
            NSMutableArray *tempSql = [[[NSMutableArray alloc]initWithCapacity:0]autorelease];
            for (int i=0; i<temp.count; i++) {
                NSDictionary *dict = [temp objectAtIndex:i];
                if ([dict valueForKey:@"poiId"] != nil && ![[dict valueForKey:@"poiId"]isEqualToString:@""]) {
                    poiId = [dict valueForKey:@"poiId"] ;
                }
                else
                {
                    poiId = @"";
                }
                if ([dict valueForKey:@"poiAddress"]) {
                    address=[dict valueForKey:@"poiAddress"] ;
                }
                else
                {
                    address=@"";
                }
                if ([dict objectForKey:@"id"]) {
                    ID=[dict objectForKey:@"id"];
                }
                else
                {
                    ID=@"";
                }
                if ([dict objectForKey:@"lastUpdate"]) {
                    lastUpdate=[dict objectForKey:@"lastUpdate"];
                }
                else
                {
                    lastUpdate=@"";
                }
                if ([dict objectForKey:@"lat"]) {
                    lat=[[dict objectForKey:@"lat"]doubleValue];
                }
                else
                {
                    lat=0;
                }
                if ([dict objectForKey:@"lon"]) {
                    lon=[[dict objectForKey:@"lon"]doubleValue];
                }
                else
                {
                    lon=0;
                }
                if ([dict objectForKey:@"poiName"]) {
                    poiName=[dict objectForKey:@"poiName"];
                }
                else
                {
                    poiName=@"";
                }
                if ([dict valueForKey:@"tel"]) {
                    conatctsNum=[dict valueForKey:@"tel"];
                }
                else
                {
                    conatctsNum=@"";
                }
                poiName = [poiName avoidSingleQuotesForSqLite];
                address = [address avoidSingleQuotesForSqLite];
                Lon=[NSString stringWithFormat:@"%f",lon];
                Lat=[NSString stringWithFormat:@"%f",lat];
                NSString *uuid = [App createUUID];
                NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@(KEYID, FPOIID, POIID,NAME,CREATE_TIME,LON,LAT,PHONE,ADDRESS,DESC,FLAG,USER_ID,LEVEL,POST_CODE) VALUES('%@','%@','%@','%@','%@','%@','%@','%@','%@','',%d,'%@',%d,'')",TABLE_POIDATA,uuid,ID,poiId,poiName,lastUpdate,Lon,Lat,conatctsNum,address,flag,app.mUserData.mUserID,LEVEL_PRIVATE];
                NSLog(@"%@",sql);
                [tempSql addObject:sql];
            }
            [app addPOIDataWithSqls:tempSql];
        }
        [self MBProgressHUDMessage:[oRes getText:@"map.collectViewController.syncYesAlert"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
        
    }
    //服务器返回数据为空或者网络错误操作
    else if(code == NET_ERROR )
    {
        [self MBProgressHUDMessage:[oRes getText:@"common.noNetAlert.message"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    //tokenid失效操作
    else if(code == NAVINFO_TOKENID_INVALID)
    {
        
        [self MBProgressHUDMessage:[oRes getText:@"common.loseTokenID.message"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    //其他错误操作
    else
    {
        [self MBProgressHUDMessage:[oRes getText:@"map.collectViewController.syncNoAlert"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
//    //消除等待框
    [self.imageView setFrame:CGRectMake(160, 200, 0, 0)];
    if (self.progressHUD){
        [self.progressHUD removeFromSuperview];
        [self.progressHUD release];
        self.progressHUD = nil;
    }
//    [_rootController hiddenProgressHUD];
    _rootController.mDisView.hidden=YES;
    _rootController.backBtn.enabled = YES;
    self.tabBarController.navigationItem.leftBarButtonItem.enabled=YES;
    sycnBtn.enabled=YES;
    editBtn.enabled=YES;
    /*禁用tabBar 20140318 孟月*/
    _rootController.tabBarEnabled = YES;
    [self getLocalData];
    [collectTableView reloadData];
}

/*!
 @method getLocalData
 @abstract 本地获取数据
 @discussion 本地获取数据，获取已同步的和添加未同步的数据
 @param 无
 @result 无
 */
-(void)getLocalData
{
    [self.unCollectData removeAllObjects];
    [self.collectTableData removeAllObjects];
    App *app = [App getInstance];
    self.collectTableData = [app loadMeetRequestCollectTableData];
    count = _collectTableData.count;
    if (count == 0) {
        editBtn.enabled = NO;
    }
    else
    {
        editBtn.enabled = YES;
    }
    [collectTableView reloadData];
    
}


/*!
 @method submitData
 @abstract 点击完成时提交数据操作
 @discussion 点击完成时提交数据操作
 @param 无
 @result 无
 */
-(void)submitData
{
    Resources *oRes = [Resources getInstance];
    App *app = [App getInstance];
    // 判断用户类型，如果是demo用户直接删除本地数据
    if (loginType==USER_LOGIN_DEMO) {
        if ([_deleteMutableArray count]!=0) {
            for (int row= 0; row < [_deleteMutableArray count]; row++)
            {
                poiData=[_deleteMutableArray objectAtIndex:row];
                Lon=[NSString stringWithFormat:@"%@",poiData.mLon];
                Lat=[NSString stringWithFormat:@"%@",poiData.mLat];
                [app deletePOIData:Lon lat:Lat ID:poiData.mID fID:poiData.mfID];
            }
            [self getLocalData];
            [self.deleteMutableArray removeAllObjects];
            [self MBProgressHUDMessage:[oRes getText:@"map.collectViewController.deleteSuccess"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
        }
    }
    //    除demo用户之外的用户的删除操作
    else
    {
        if ([_deleteMutableArray count]!=0) {
            App *app = [App getInstance];
            
            NSString *str=[NSString stringWithFormat:@""];
            for (int i=0; i<_deleteMutableArray.count; i++) {
                poiData=[_deleteMutableArray objectAtIndex:i];
                str=[NSString stringWithFormat:@"%@,'%@'",str,poiData.mfID];
                
            }
            str = [str substringFromIndex:1];
            //一次性删除多个poi信息 以及修改标识flag
            [app deletePOIDataWithFID:str];
            
            //收藏夹中无数据时，编辑按钮不可用
            if (_collectTableData.count == 0) {
                editBtn.enabled=NO;
            }
            else
            {
                editBtn.enabled=YES;
            }
            [self getLocalData];
            [self.deleteMutableArray removeAllObjects];
            [self MBProgressHUDMessage:[oRes getText:@"map.collectViewController.deleteSuccess"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
        }
    }
    

}


/*!
 @method tableViewEdit
 @abstract 列表的编辑状态
 @discussion 列表的编辑状态
 @param 无
 @result 无
 */
- (void)tableViewEdit
{
    [collectTableView setEditing:!collectTableView.editing animated:YES];
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
    [self getLocalData];
    [collectTableView reloadData];
    [poiDetailViewController dismissViewControllerAnimated:YES completion:nil];
}


/*!
 @method showPOI:(POIData *)poi
 @abstract 进入poi详情
 @discussion 进入poi详情
 @param 无
 @result 无
 */
-(void)showPOI:(POIData *)poi
{
    [_rootController showPOI:poi];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    _deleteMutableArray=nil;
    _unCollectData=nil;
    _collectTableData = nil;
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
    count=_collectTableData.count;
    return count;
    
}

#pragma mark - button action


/*!
 @method tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 @abstract 加载列表信息
 @discussion 加载列表信息，新建某一行并返回
 @param 无
 @result cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"naviIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"mapcell" owner:self options:nil] lastObject];
    }
    
    NSUInteger row = [indexPath row];
    UIImageView *image=(UIImageView*)[cell viewWithTag:1];
    UILabel *name = (UILabel*)[cell viewWithTag:2];
    UILabel *explain = (UILabel*)[cell viewWithTag:3];
    UIImageView *detail=(UIImageView*)[cell viewWithTag:4];
//    UIImageView *line=(UIImageView*)[cell viewWithTag:5];
//    if (row == _collectTableData.count - 1) {
//        line.hidden = YES;
//    }
    poiData=[_collectTableData objectAtIndex:row];
    if ([poiData.mName isEqualToString:@""]||[poiData.mName isEqualToString:@"(null)"]) {
        poiData.mName=@"";
    }
    if ([poiData.mAddress isEqualToString:@""]||[poiData.mAddress isEqualToString:@"(null)"]) {
        poiData.mAddress=@"";
    }
    name.text=poiData.mName;
    explain.text=poiData.mAddress;
    name.font =[UIFont size14_5];
    explain.font =[UIFont size12];
    if (poiData.mFlag==COLLECT_SYNC_YES) {
        image.image=[UIImage imageNamed:@"map_collect_icon_sycn"];
    }
    else
    {
        image.image=[UIImage imageNamed:@"map_collect_icon_unsycn"];
    }
    
    if (editType==EDIT) {
        detail.hidden=YES;
    }
	return cell;
}

/*!
 @method tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 @abstract 设置列表是否可编辑
 @discussion 设置列表是否可编辑
 @param 无
 @result bool
 */
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}



/*!
 @method tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 @abstract 单击某行进入详情
 @discussion 单击某行进入详情
 @param indexPath
 @result 无
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    poiData = [_collectTableData objectAtIndex:row];
    [self showPOI:poiData];

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*!
 @method tableView:(UITableView *)mTable editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
 @abstract 控制列表滑动显示删除按钮
 @discussion 控制列表滑动显示删除按钮 
 @param indexPath，mTable
 @result 无
 */
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
 @method tableView:(UITableView *)mTable editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
 @abstract 点击删除按钮时的事件
 @discussion 点击删除按钮时，将删除数据存放在数组中
 @param tableView，editingStyle，indexPath
 @result 无
 */
- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    //点击按钮事件发生
    [_deleteMutableArray addObject:[_collectTableData objectAtIndex:indexPath.row]];
    [_collectTableData removeObjectAtIndex:indexPath.row];
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    //    删除效果
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
//    [collectTableView reloadData];
}


/*!
 @method tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
 @abstract 设置删除按钮的名称
 @discussion 设置删除按钮的名称
 @param tableView，indexPath
 @result name
 */
-(NSString *)tableView:(UITableView *)tableView
titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Resources *oRes = [Resources getInstance];
    return [oRes getText:@"common.delete"];
}


#pragma mark -
#pragma mark MBProgressHUDDelegate methods
/*!
 @method hudWasHidden:(MBProgressHUD *)hud
 @abstract 移除等待框
 @discussion 移除等待框
 @param hud
 @result 无
 */
- (void)hudWasHidden:(MBProgressHUD *)hud {
//    NSLog(@"Hud: %@", hud);
    // Remove HUD from screen when the HUD was hidded
    [self.progressHUD removeFromSuperview];
    [self.progressHUD release];
    self.progressHUD = nil;
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
