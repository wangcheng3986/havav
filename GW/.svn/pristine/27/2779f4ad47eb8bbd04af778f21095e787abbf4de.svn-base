/***********************************
 * 版权所有：北京四维图新科技股份有限公司
 * 文件名称：FriendListViewController.m
 * 文件标识：
 * 内容摘要：车友列表
 * 其他说明：
 * 当前版本：
 * 作    者：刘铁成，王立琼
 * 完成日期：2013-08-25
 * 修改记录1：
 *	修改日期：2013-08-28
 *	版 本 号：
 *	修 改 人：孟磊
 *	修改内容：刷新车友列表但不请求服务器
 **************************************/


#import <AddressBookUI/AddressBookUI.h>
#import <AddressBook/AddressBook.h>
#import "FriendListViewController.h"
#import "App.h"
#import "MainViewController.h"
#import "FriendTabBarViewController.h"
#import "FriendDetailViewController.h"
#import "SelfDetailViewController.h"
@interface FriendListViewController ()
{
    int isFirstLoginFriend;
    int tableviewType;
    int friendType;
    int editType;
    int sexType;
    UIBarButtonItem *rightButton;
    UIBarButtonItem *leftButton;
    UIBarButtonItem *backButton;
    UserData *selfData;
    int friendLoad;
    int blackLoad;
    int mLengthOfContactBook;
    int mLeftLengthOfContactBook;
    //NSMutableArray *mLocalContactsList;
    int mAddFriendCount;
    
    int mLengthOfDeleteContacts;
    int mLeftLengthOfDeleteContacts;
    
    
    //modified by menglei 0902
    //处理viewdidload 被重复调用时产生的问题
    BOOL isSelfFirstLoad;
    
    /* 判断车友列表的刷新方式 孟磊 2013年9月3日*/
    BOOL isEGOrefresh;
    
    // 判断车友列表加载是否完成，主要解决同步与获取同时进行时，由于车友数量过多导致刷新列表时主线程被阻塞，有卡顿现象
    UIAlertView *alertSyncResult;
    
    
    int nResultCount ;
    BOOL syncSuccess;
    
    CGRect cgRectForFirstLoginView;
    
    BOOL isSyncContacts;
    NSString *newFriendName;
    int newFriendRow;
    BOOL isDeleteFriend;
}
@end

@implementation FriendListViewController
//@synthesize picUrlString = _picUrlString;
@synthesize imageView = _imageView;
@synthesize progressHUD = _progressHUD;
@synthesize deleteMutableArray;
@synthesize dataMutableArray;
@synthesize blacklistDataMutableArray;
@synthesize tempDeleteMutableArray;



- (id)init
{
    self = [super initWithNibName:@"FriendListViewController" bundle:nil];
    if (self)
    {
        mLengthOfContactBook        = 0;
        mLeftLengthOfContactBook    = 0;
        mAddFriendCount             = 0;
        _isSyncAndGetContactsList   = NO;
    }
    return self;
}
- (void)dealloc
{
    
    [syncContactsButton release],syncContactsButton = nil;
    if (firstLoginView) {
        [firstLoginView removeFromSuperview];
        [firstLoginView release],firstLoginView = nil;
    }
    if (tableview) {
        [tableview removeFromSuperview];
        [tableview release],tableview = nil;
    }
    
    [footerView removeFromSuperview];
    [footerView release],footerView = nil;
    
    [titleLabel release],titleLabel = nil;
    [syncTitleLabel release],syncTitleLabel =nil;
    [syncTextLabel release],syncTextLabel = nil;
    
    [editBtn release],editBtn = nil;
    
    [footerLabel release],footerLabel =nil;
    [activityIndicator release],activityIndicator = nil;
    [btnView removeFromSuperview];
    [btnView release],btnView = nil;
    [friendlistBtn release],friendlistBtn =nil;
    [blacklistBtn release],blacklistBtn =nil;
    if (mDeleteContacts) {
        [mDeleteContacts release];
    }
    if (mUpdateContacts) {
        [mUpdateContacts release];
    }
    if (mGetContacts) {
        mGetContacts.mDelegate = nil;
        [mGetContacts release];
        mGetContacts = nil;
    }
    if (mSyncContacts) {
        [mSyncContacts release];
    }
    
    if (_progressHUD) {
        [_progressHUD removeFromSuperview];
        [_progressHUD release];
        _progressHUD = nil;
    }
    
    
    //[_refreshHeaderView release];
    [navigation release];
    [dataMutableArray removeAllObjects];
    [dataMutableArray release];
    dataMutableArray=nil;
    
    [blacklistDataMutableArray removeAllObjects];
    [blacklistDataMutableArray release];
    blacklistDataMutableArray=nil;
    
    [deleteMutableArray removeAllObjects];
    [deleteMutableArray release];
    deleteMutableArray=nil;
    
    [tempDeleteMutableArray release];
    tempDeleteMutableArray=nil;
    
    [m_segmentedControl release],m_segmentedControl = nil;
    [rightButton release];
    [leftButton release];
    [backButton release];
    
    [_imageView release];
    
    [alertSyncResult release];
    if (mGetBlack) {
        [mGetBlack release];
    }
    if (mDeleteBlack) {
        [mDeleteBlack release];
    }
    if (newFriendName) {
        [newFriendName release];
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

//modified by menglei 0902
-(void)doViewDidLoad
{
    mGetContacts = [[NIGetContactsList alloc]init];
    mSyncContacts = [[NISyncContacts alloc]init];
    mDeleteContacts = [[NIDeleteContacts alloc]init];
    mUpdateContacts = [[NIUpdateContacts alloc]init];
    mGetBlack = [[NIGetBlack alloc]init];
    mDeleteBlack = [[NIDeleteBlack alloc]init];
    //适配IOS7，替换背景图片
    if([App getVersion]>=IOS_VER_7){
        [App ios7ViewLocation:self];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_ios7_navBar_bg"] forBarMetrics:UIBarMetricsDefault];
        
        cgRectForFirstLoginView = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 20);
    }
    else
    {
        cgRectForFirstLoginView = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_ios6_navBar_bg"] forBarMetrics:UIBarMetricsDefault];
    }
    editType=FINISH;
    if (_refreshHeaderView == nil) {
        EGORefreshTableHeaderView *view1 = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.view.bounds.size.height, tableview.frame.size.width, self.view.bounds.size.height)];
        view1.delegate = self;
        [tableview addSubview:view1];
        _refreshHeaderView = view1;
        [view1 release];
    }
    [_refreshHeaderView refreshLastUpdatedDate];
    firstLoginView.frame = cgRectForFirstLoginView;
    [firstLoginView setHidden: YES];
    
    App *app = [App getInstance];
    [self setFistLoginFlag];
    
    tableviewType=FRIEND_LIST;
    Resources *oRes = [Resources getInstance];
    syncTextLabel.text=[oRes getText:@"friend.FriendListViewController.syncContactsButtonText"];
    syncTitleLabel.text=[oRes getText:@"friend.FriendListViewController.syncContactsButtonTitle"];
    
    //Navigationbar实现左右button
    editBtn = [[RightButton alloc]init];
    [editBtn setTitle:[oRes getText:@"friend.FriendListViewController.rightButtonEditTitle"] forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(editOrFinish)forControlEvents:UIControlEventTouchUpInside];
    rightButton=[[UIBarButtonItem alloc]initWithCustomView:editBtn];
    
//    titleLabel.text=[oRes getText:@"friend.FriendTabBarViewController.friendFirstLoginTitle"];
//    titleLabel.font =[UIFont navBarTitleSize];
    self.navigationItem.title = [oRes getText:@"friend.FriendTabBarViewController.friendFirstLoginTitle"];
    
    [friendlistBtn setTitle:[oRes getText:@"friend.FriendTabBarViewController.allFriendListTitle"] forState:UIControlStateNormal];
    [friendlistBtn addTarget:self action:@selector(displayFriendList)forControlEvents:UIControlEventTouchUpInside];
    
    [blacklistBtn setTitle:[oRes getText:@"friend.FriendTabBarViewController.blacklistTitle"] forState:UIControlStateNormal];
    [blacklistBtn addTarget:self action:@selector(displayBlackList)forControlEvents:UIControlEventTouchUpInside];
    UIColor *titleColor = [[UIColor alloc] initWithRed:0.451 green:0.451 blue:0.451 alpha:1];
    [blacklistBtn setTitleColor:titleColor forState:UIControlStateNormal];

    [titleColor release];
    
//    blacklistDataMutableArray=[[NSMutableArray alloc] initWithCapacity:0];
//    dataMutableArray=[[NSMutableArray alloc] initWithCapacity:0];
    deleteMutableArray=[[NSMutableArray alloc] initWithCapacity:0];
    tempDeleteMutableArray=[[NSMutableArray alloc] initWithCapacity:0];
    friendType=FRIENDLIST;//默认的是好友列表，黑名单列表隐藏
    selfData=[app getUserData];
    [app loadCarData];
    
    friendLoad=app.friendLoadType;
    blackLoad=app.blackLoadType;
    
    
    [self selectView];
    
    footerLabel.text=[oRes getText:@"map.collectViewController.footerlabeltext"];
    footerLabel.font =[UIFont size12];
    footerLabel.hidden=YES;
    _rootController.mSelectFlag = NO;
    self.view.backgroundColor = [UIColor colorWithRed:231.0/255 green:231.0/255 blue:231.0/255 alpha:1];
    _imageView.backgroundColor = [UIColor colorWithRed:231.0/255.0f green:231.0/255.0f blue:231.0/255.0f alpha:1];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    isSelfFirstLoad = YES;
    isSyncContacts = NO;
    isDeleteFriend = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadFriendList) name:Notification_Delete_Contacts object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadBlackList) name:Notification_Delete_Black object:nil];
    //modified by menglei 0902
    [self doViewDidLoad];
    self.tabBarController.navigationItem.rightBarButtonItem=rightButton;
}

- (void)viewWillAppear:(BOOL)animated
{
    editBtn.hidden = NO;
    self.tabBarController.navigationItem.titleView=btnView;
    if (tableviewType == FRIEND_LIST) {
        [self getLocalFriendlData];
    }
    else
    {
        [self getLocalBlackData];
    }
    [tableview reloadData];
     [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    editBtn.hidden = YES;
    [super viewWillDisappear:animated];
}
/*!
 @method reloadFriendList
 @abstract 刷新车友列表
 @discussion 刷新车友列表
 @result 无
 */
-(void)reloadFriendList
{
    if (friendType == FRIENDLIST) {
        NSLog(@"刷新车友列表了");
        [deleteMutableArray removeAllObjects];
        [self getLocalFriendlData];
        [tableview reloadData];
    }
}
/*!
 @method reloadBlackList
 @abstract 刷新黑名单列表了
 @discussion 刷新黑名单列表了
 @result 无
 */
-(void)reloadBlackList
{
    if (friendType == BLACKLIST) {
        NSLog(@"刷新黑名单列表了");
        [deleteMutableArray removeAllObjects];
        [self getLocalBlackData];
        [tableview reloadData];
    }
}
/*!
 @method JumptoNew
 @abstract UI界面设置
 @discussion UI界面设置
 @param name 名称
 @result 无
 */
-(void)JumptoNew:(NSString *)name
{
    
//    if (_dataMutableArray.count>0) {
//        [self scroll2TableViewTop];
//    }
    if (newFriendName) {
        [newFriendName release];
        newFriendName = nil;
    }
    newFriendName = [[NSString alloc]initWithString:name];
    NSLog(@"name = %@",newFriendName);
    [self displayFriendList];
    [self searchAndScroll2NewFriend];
    
}
/*!
 @method searchAndScroll2NewFriend
 @abstract UI界面设置
 @discussion UI界面设置
 @result 无
 */
-(void)searchAndScroll2NewFriend
{
    newFriendRow = 0;
    for (int i = 0; i<dataMutableArray.count; i++) {
        FriendsData *data = [dataMutableArray objectAtIndex:i];
        if (newFriendName && [newFriendName isEqualToString:data.mfName])
        {
            newFriendRow = i;
        }
    }
    [self scroll2TableViewAtRow:newFriendRow];
}
/*!
 @method editOrFinish
 @abstract UI界面设置
 @discussion UI界面设置
 @result 无
 */
-(void)editOrFinish
{
    Resources *oRes = [Resources getInstance];
    if ([[editBtn currentTitle] compare:[oRes getText:@"friend.FriendListViewController.rightButtonEditTitle"]
                                options:NSLiteralSearch]==NSOrderedSame)
    {
        editType=EDIT;
        _rootController.mSelectFlag = NO;
        [editBtn setTitle:[oRes getText:@"friend.FriendListViewController.rightButtonFinishTitle"] forState:UIControlStateNormal];
        [self.tabBarController.navigationItem.titleView setUserInteractionEnabled:NO];
        
        //刷新TableView的全部内容
        [tableview reloadData];
        
        //设置TableView可编辑
        [self tableViewEdit];
    }
    else
    {
        editType=FINISH;
        _rootController.mSelectFlag = YES;
        [editBtn setTitle:[oRes getText:@"friend.FriendListViewController.rightButtonEditTitle"] forState:UIControlStateNormal];
        [self submitData];
        [self.tabBarController.navigationItem.titleView setUserInteractionEnabled:YES];
        [self tableViewEdit];
        [tableview reloadData];
    }
    [self setEditButtonEnabledByLoadedData];
    [self setEditType:editType];
}
/*!
 @method goHome
 @abstract UI界面设置
 @discussion UI界面设置
 @result 无
 */
-(void)goHome
{
    [self.navigationController popViewControllerAnimated:YES];
    [_rootController goBack];
}
/*!
 @method popself
 @abstract UI界面设置
 @discussion UI界面设置
 @result 无
 */
-(void)popself
{
    NSLog(@"the self count is %d",[self retainCount]);
    [self.navigationController popViewControllerAnimated:YES];
    
}


/*!
 @method setTableviewType
 @abstract 记录显示的列表类型
 @discussion 记录显示的列表类型
 @result 无
 */
-(void)setTableviewType:(int)type
{
    tableviewType=type;
    if (tableviewType==FRIEND_LIST)
    {
        friendType=FRIENDLIST;
    }
    else
    {
        friendType=BLACKLIST;
    }
}
/*!
 @method setEditType
 @abstract UI界面设置
 @discussion UI界面设置
 @result 无
 */
-(void)setEditType:(int)type
{
    editType=type;
}


/*!
 @method selectView
 @abstract 由于需求变更现进入车友均显示车友列表界面
 @discussion 由于需求变更现进入车友均显示车友列表界面
 @result 无
 */
-(void)selectView
{
    [self addFriendListView];
    if (isFirstLoginFriend==USER_FIRSTLOGIN)
    {
        //首次进入车友从服务器获取车友列表，如果无车友列表提示用户同步通讯录
        App *app = [App getInstance];
        if (app.mUserData.mType == USER_LOGIN_DEMO)//判断是否DEMO用户
        {
            //本地获取数据刷新显示好友列表
            [self getLocalFriendlData];
            [tableview reloadData];
        }
        else
        {
            [self severLoadData];
        }
        
    }
    else
    {
        if (friendLoad == FRIEND_LOAD_YES) {
            App *app = [App getInstance];
            if (app.mUserData.mType == USER_LOGIN_DEMO)//判断是否DEMO用户
            {
                //本地获取数据刷新显示好友列表
                [self getLocalFriendlData];
                [tableview reloadData];
            }
            else
            {
                [self severLoadData];
            }
        }
        else
        {
            //本地获取数据刷新显示好友列表
            [self getLocalFriendlData];
            [tableview reloadData];
        }
    }
    
}

/*!
 @method getLocalFriendlData
 @abstract 获得车友数据
 @discussion 获得车友数据
 @result 无
 */
-(void)getLocalFriendlData
{
    App *app = [App getInstance];
    if (friendType==FRIENDLIST)
    {
        if (dataMutableArray) {
            [dataMutableArray removeAllObjects];
            [dataMutableArray release];
            dataMutableArray = nil;
        }
        dataMutableArray =[[NSMutableArray alloc]initWithArray:[app loadMeetRequestFriendData]];
    }
    [self setEditButtonEnabledByLoadedData];
}
/*!
 @method getLocalBlackData
 @abstract 获得黑名单数据
 @discussion 获得黑名单数据
 @result 无
 */
-(void)getLocalBlackData
{
    App *app = [App getInstance];
    if (blacklistDataMutableArray) {
        [blacklistDataMutableArray removeAllObjects];
        [blacklistDataMutableArray release];
        blacklistDataMutableArray = nil;
    }
    blacklistDataMutableArray =[[NSMutableArray alloc]initWithArray:[app loadBlackData]];
    [self setEditButtonEnabledByLoadedData];
}

/*!
 @method refreshFriendList
 @abstract 需要刷新车友列表时调用
 @discussion 需要刷新车友列表时调用 bShowHUD=NO，不显示等待框
 @result 无
 */
-(void) refreshFriendList:(BOOL)bShowHUD
{
    //使用get车友接口，NIGetContactsList
    _rootController.backBtn.enabled = NO;
    [self sendGetContactListRequest];
}

/*!
 @method demoDisplayFriendList
 @abstract 同步通讯录demo
 @discussion 同步通讯录demo
 @result 无
 */
-(void) demoDisplayFriendList
{
    [self displayFriendList];
    
    //使用alert 提示同步结果
    Resources *oRes = [Resources getInstance];
    NSString *alertmessage = [NSString stringWithFormat:@"%@%d%@",[oRes getText:@"friend.AddFriendViewController.alertMessage1"],0,[oRes getText:@"friend.AddFriendViewController.alertMessage2"]];
    
    
    [self MBProgressHUDMessage:alertmessage delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
}

/*!
 @method syncFriendList
 @abstract 同步通讯录
 @discussion 同步通讯录
 @result 无
 */
-(void) syncFriendList:(BOOL)bShowHUD
{
    
    
    ABAddressBookRef addressBook = ABAddressBookCreate();
    __block BOOL accessGranted = NO;
    if (ABAddressBookRequestAccessWithCompletion != NULL) {
        
        // we're on iOS 6
        //NSLog(@"on iOS 6 or later, trying to grant access permission");
        
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            accessGranted = granted;
            dispatch_semaphore_signal(sema);
        });
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        dispatch_release(sema);
    }
    else { // we're on iOS 5 or older
        
        //NSLog(@"on iOS 5 or older, it is OK");
        accessGranted = YES;
    }
    
    if (accessGranted) {
        
        
        App *app = [App getInstance];
        isSyncContacts = YES;
        _isSyncAndGetContactsList = YES;
        if (tableviewType != FRIEND_LIST) {
            [self displayFriendList];
        }
        
        //此时禁用编辑按键，等到同步结束再启用
        editBtn.enabled = NO;
        _rootController.backBtn.enabled = NO;
        //当进入视图时，重新设置imageView
        mLengthOfContactBook = 0;
        mLeftLengthOfContactBook = 0;
        mAddFriendCount = 0;
        [self.imageView setImage:nil];
        [self.imageView setFrame:CGRectMake(160, 200, 0, 0)];
        //显示加载等待框
        Resources *oRes = [Resources getInstance];
        [self SafeAllocProgressHUD];
        [self.view bringSubviewToFront:self.progressHUD];
        self.progressHUD.labelText = [oRes getText:@"friend.OnSynchronazingContactsList.Title"];
        self.progressHUD.detailsLabelText= [oRes getText:@"common.load.text"];
        
        /*禁用tabBar  20140317 孟月*/
        _rootController.mSelectFlag = NO;
        
        /*设置等待框是否显示，孟磊 2013年9月9日*/
        if (bShowHUD) {
            [self.progressHUD show:YES];
        }
        
        
        //NSLog(@"we got the access right");
        
        CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople (addressBook);
        
        NSDictionary *temp;
        
        NSMutableArray *localContactsList =[[[NSMutableArray alloc]init]autorelease];
        
        for (id person in (NSArray *) allPeople)
        {
            NSString * name = (NSString *)ABRecordCopyCompositeName(person);
            ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
            //                当联系人有多个电话号码时取其中一个电话号码
            //                孟月 20140123
            if (ABMultiValueGetCount(phone) > 0) {
                NSString * personPhone = nil;
                NSMutableString *phoneNumber = nil;
                //                去最后一个电话号码
                //                for (int k = 0; k<ABMultiValueGetCount(phone); k++)
                //                {
                //获取电话Label
                //NSString * personPhoneLabel = (NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(phone, k));
                //获取該Label下的电话值
                personPhone = (NSString *)ABMultiValueCopyValueAtIndex(phone, ABMultiValueGetCount(phone)-1);
                
                phoneNumber = [NSMutableString stringWithString:personPhone];
                NSString *character = nil;
                //Iphone通讯录中的电话号码会带有‘-’‘(’')'等符号在同步通讯录时需要去掉
                
                for (int i = 0; i < phoneNumber.length; i ++) {
                    character = [phoneNumber substringWithRange:NSMakeRange(i, 1)];
                    if ([character isEqualToString:@"-"])
                    {
                        [phoneNumber deleteCharactersInRange:NSMakeRange(i, 1)];
                        i--;
                    }
                    if ([character isEqualToString:@"("])
                    {
                        [phoneNumber deleteCharactersInRange:NSMakeRange(i, 1)];
                        i--;}
                    if ([character isEqualToString:@")"])
                    {
                        [phoneNumber deleteCharactersInRange:NSMakeRange(i, 1)];
                        i--;}
                    if ([character isEqualToString:@" "])
                    {
                        [phoneNumber deleteCharactersInRange:NSMakeRange(i, 1)];
                        i--;}
                }
                //                }
                if([phoneNumber hasPrefix:@"+86"])
                {
                    [phoneNumber deleteCharactersInRange:NSMakeRange(0, 3)];
                }
                if([phoneNumber hasPrefix:@"86"])
                {
                    [phoneNumber deleteCharactersInRange:NSMakeRange(0, 2)];
                }
                if(![phoneNumber isEqualToString:app.selfPhone])
                {
                    temp= [NSDictionary dictionaryWithObjectsAndKeys:
                           name,@"name",phoneNumber,@"phone",nil];
                    [localContactsList addObject:temp];
                }
                //mLengthOfContactBook++;
                [personPhone release];
                
            }
            [name release];
        }
        /**
        //测试单次上传
        for (int i = 0; i<2000; i++) {
            temp= [NSDictionary dictionaryWithObjectsAndKeys:
                   @"我想不想起床想继续睡觉啦啦啦啦拉拉来啊拉来啊啦拉来啊了",@"name",@"12345678901",@"phone",nil];
            [localContactsList addObject:temp];
        }
        
        
        
         NSLog(@"Send Async Request Only Once :------------%@",[NSDate date] );
         [mSyncContacts createRequest:localContactsList];//add the release of memeory
         [mSyncContacts sendRequestWithAsync:self];
         */
        
        //NSLog(@"-------------------Send Async Request Times :------------%@",[NSDate date] );
        //联系人名称去重
       
       
        NSLog(@"%d",localContactsList.count);
        NSMutableArray *mLocalContactsList = nil;
        if (localContactsList.count>1) {
            mLocalContactsList= [self getUiqueMutableArray : localContactsList];
        }
        else
        {
            mLocalContactsList = localContactsList;
        }
        mLengthOfContactBook = mLocalContactsList.count;
        if (mLocalContactsList.count > 0) {
            //发送异步请求
            int nCapacity = 500;
            syncSuccess = NO;
            if (mLocalContactsList.count < nCapacity) {
                nCapacity = mLocalContactsList.count;
            }
            NSMutableArray * contactList = [[[NSMutableArray alloc] initWithCapacity:nCapacity] autorelease];
            for (int i = 0; i < mLocalContactsList.count; i++) {
                [contactList addObject:mLocalContactsList[i]];
                if ((i+1) % nCapacity == 0 || i == mLocalContactsList.count-1) {
                    [mSyncContacts createRequest: contactList];//add the release of memeory
                    [mSyncContacts sendRequestWithAsync:self];
                    contactList = [[[NSMutableArray alloc] initWithCapacity:nCapacity < mLocalContactsList.count-i-1 ?  nCapacity : mLocalContactsList.count-i-1] autorelease];
                    nResultCount ++;//记录异步请求的次数
                }
            }
        }
        else
        {
            [self sycnWhenPeopleIsNull];
        }
        CFRelease(allPeople);
        CFRelease(addressBook);
    }
    else
    {
        [self getLocalFriendlData];
        [tableview reloadData];
        Resources *oRes = [Resources getInstance];
        [self MBProgressHUDMessage:[oRes getText:@"friend.FriendListViewController.getLocalContactsFailAlert"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
}

/*!
 @method sycnWhenPeopleIsNull
 @abstract当通讯录为空时不与服务器交互
 @discussion 当通讯录为空时不与服务器交互
 @result 无
 */
-(void)sycnWhenPeopleIsNull
{
    [self getLocalFriendlData];
    [tableview reloadData];
    Resources *oRes = [Resources getInstance];
    [self.imageView setFrame:CGRectMake(160, 200, 0, 0)];
    [self SafeHideProgressHUD];
    /*启用用tabBar  20140317 孟月*/
    _rootController.mSelectFlag = YES;
    //使用alert 提示同步结果
    [self MBProgressHUDMessage:[oRes getText:@"friend.FriendListViewController.LocalContactsIsNull"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];

    //同步结束启用btn
//    editBtn.enabled = YES;
    _rootController.backBtn.enabled = YES;
}


/*!
 @method severLoadData
 @abstract 加载数据
 @discussion 加载数据
 @result 无
 */
-(void)severLoadData
{
    //禁用编辑和返回按钮，等待获取通讯录结束后再启用
    editBtn.enabled = NO;
    _rootController.backBtn.enabled = NO;
    if(!isEGOrefresh)
    {
        
        [self.imageView setImage:nil];
        [self.imageView setFrame:CGRectMake(160, 200, 0, 0)];
        [self SafeAllocProgressHUD];
        
        [self.view bringSubviewToFront:self.progressHUD];
        Resources *oRes = [Resources getInstance];
        self.progressHUD.labelText = [oRes getText:@"friend.OnLoadingContactsList.Title"];
        self.progressHUD.detailsLabelText= [oRes getText:@"common.load.text"];
        
        [self.progressHUD show:YES];
        
        //重置标志位，控制
        isEGOrefresh = NO;
    }
    //使用get车友接口，NIGetContactsList
    [self sendGetContactListRequest];

}
/*!
 @method sendGetContactListRequest
 @abstract 发送异步请求
 @discussion 发送异步请求
 @result 无
 */
-(void)sendGetContactListRequest
{
    Resources *oRes = [Resources getInstance];
    self.progressHUD.labelText = [oRes getText:@"friend.OnLoadingContactsList.Title"];
    self.progressHUD.detailsLabelText= [oRes getText:@"common.load.text"];
    
    //使用get车友接口，NIGetContactsList
    _rootController.backBtn.enabled = NO;
    [mGetContacts createRequest];
    [mGetContacts sendRequestWithAsync:self];
}

/*!
 @method onSyncResult:code:errorMsg:
 @abstract 同步通讯录后，处理返回的结果
 @discussion 同步通讯录后，处理返回的结果
 @result 无
 */


- (void)onSyncResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg
{
    //测试单次同步全部通讯录
    //NSLog(@"Receive Async Request Response Once :------------%@",[NSDate date] );
    
    nResultCount--;//接收到返回结果后，将计数器减一
    Resources *oRes = [Resources getInstance];
    if (NAVINFO_RESULT_SUCCESS == code)
    {
        
        if (nil != result)
        {
            syncSuccess = YES;
            //修改通讯录计数和车友计数，这里应统计车友计数 total->vtotal 孟磊 2013年9月4日
            // int vTotalNum = [[result valueForKey:@"vtotal"] integerValue];
            int totalNum = [[result valueForKey:@"total"] integerValue];
            //mLengthOfContactBook += totalNum;
            mAddFriendCount += totalNum;
        }
    }
    if (nResultCount <= 0) { //全部接收完成后，刷新列表
        //NSLog(@"------------------Receive Async Request Times :------------%@",[NSDate date] );
        
        if (syncSuccess) {
            [self sendGetContactListRequest];
            //使用alert 提示同步结果
            NSString *alertmessage = [NSString stringWithFormat:@"%@%d%@",[oRes getText:@"friend.AddFriendViewController.alertMessage1"],mAddFriendCount,[oRes getText:@"friend.AddFriendViewController.alertMessage2"]];
            
            
            [self MBProgressHUDMessage:alertmessage delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
        }
        else
        {
            
            if(code == NET_ERROR)
            {
                [self MBProgressHUDMessage:[oRes getText:@"common.noNetAlert.message"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
                
                
            }
            else if(NAVINFO_TOKENID_INVALID == code)//TokenID失效处理
            {
                [self MBProgressHUDMessage:[oRes getText:@"common.loseTokenID.message"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
            }
            else
            {
                [self MBProgressHUDMessage:[oRes getText:@"friend.FriendListViewController.syncContactsFailAlert"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
            }
            //此时启用编辑按键，等到同步结束再启用
            [self setEditButtonEnabledByLoadedData];
            _rootController.backBtn.enabled = YES;
            isSyncContacts = NO;
            _rootController.mSelectFlag = YES;
            
            [self.imageView setFrame:CGRectMake(160, 200, 0, 0)];
            [self SafeHideProgressHUD];
            
        }
        
        mLengthOfContactBook = 0;
        mAddFriendCount = 0;
        
    }
    
}

/*!
 @method dropDownList
 @abstract 模拟下拉刷新
 @discussion 模拟下拉刷新
 @result 无
 */
-(void)dropDownList
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    tableview.contentOffset = CGPointMake(0.0, -150.0);
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:tableview];
    [UIView commitAnimations];
}

/*!
 @method showSyncResultAlert:
 @abstract 提示框
 @discussion 提示框
 @result 无
 */
- (void)showSyncResultAlert
{
    if (alertSyncResult != nil) {
        [alertSyncResult show];
    }
}
/*!
 @method onGetListResult:code:errorMsg:
 @abstract 回调函数
 @discussion 回调函数
 @result 无
 */



- (void)onGetListResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg
{
    NSLog(@"receive the result.");
    Resources *oRes = [Resources getInstance];
    [self doneLoadingTableViewData];
    if (NAVINFO_RESULT_SUCCESS == code)
    {
        if (nil != result)
        {
            NSLog(@"result is :%@", result);
            App *app = [App getInstance];
            //服务器获取好友列表
            [app deleteAllFriend];
            NSString *uuid = [App createUUID];
            NSLog(@"%@",app.selfPhone);
            [app updateFriendData:uuid fid:app.loginID fname:[oRes getText:@"friend.FriendList.selfName"] fphone:app.selfPhone flon:@"" flat:@"" fLastRqTime:app.mUserData.mLastReqTime fLastUpdate:@"" sendLocationRqTime:@"" createTime:[App getTimeSince1970_1000] friendUserID:app.loginID poiName:@"" poiAddress:@"" pinyin:@""];
            if ([result objectForKey:@"friendList"])
            {
                NSArray *friendListFromNet = [result objectForKey:@"friendList"];
                if (friendListFromNet.count != 0) {
                    
                    NSMutableArray *tempSql = [[[NSMutableArray alloc]initWithCapacity:0]autorelease];
                    for (id friend in friendListFromNet) {
                        NSDictionary *contactsDic = [friend objectForKey:@"friend"];
                        NSDictionary *lastPosDic = [friend objectForKey:@"location"];
                        NSString *uuid = [App createUUID];
                        NSString *fkeyid=uuid;
                        if (!fkeyid) {
                            fkeyid = @"";
                        }
                        NSString *fid=[contactsDic objectForKey:@"id"];
                        if (!fid) {
                            fid = @"";
                        }
                        NSString *fname=[contactsDic objectForKey:@"name"];
                        if (!fname) {
                            fname = @"";
                        }
                        NSString *fphone=[contactsDic objectForKey:@"phone"];
                        if (!fphone) {
                            fphone = @"";
                        }
                        NSString *flon;
                        NSString *flat;
                        NSString *fLastRqTime;
                        NSString *fPoiName;
                        NSString *fPoiAddress;
                        if (lastPosDic) {
                            flon=[lastPosDic objectForKey:@"lon"];
                            if (!flon) {
                                flon = @"";
                            }
                            flat=[lastPosDic objectForKey:@"lat"];
                            if (!flat) {
                                flat = @"";
                            }
                            fLastRqTime=[lastPosDic objectForKey:@"reportTime"];
                            if (!fLastRqTime) {
                                fLastRqTime = @"";
                            }
                            fPoiName=[lastPosDic objectForKey:@"poiName"];
                            if (!fPoiName) {
                                fPoiName = @"";
                            }
                            fPoiAddress=[lastPosDic objectForKey:@"poiAddress"];
                            if (!fPoiAddress) {
                                fPoiAddress = @"";
                            }
                        }
                        else
                        {
                            flon = @"";
                            flat = @"";
                            fLastRqTime = @"";fPoiName = @"";fPoiAddress = @"";
                            
                        }
                        NSString *fLastUpdate=[contactsDic objectForKey:@"lastUpdate"];
                        if (!fLastUpdate) {
                            fLastUpdate = @"0";
                        }
                        NSString *createTime=[contactsDic objectForKey:@"createTime"];
                        if (!createTime) {
                            createTime = @"0";
                        }
                        NSString *pinyin=[contactsDic objectForKey:@"pinyin"];
                        if (!pinyin) {
                            pinyin = @"";
                        }
                        NSString *friendUserID=[contactsDic objectForKey:@"friendUserId"];
                        if (!friendUserID) {
                            friendUserID = @"";
                        }
                        //                将多次访问数据库插入好友改为拼写sql数组一次访问数据库
                        //                2013.12.10   孟月
                        NSString *sendRqTime = @"";
                        fname = [fname avoidSingleQuotesForSqLite];
                        pinyin = [pinyin avoidSingleQuotesForSqLite];
                        NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ (KEYID,ID,NAME,PHONE,USER_KEYID,LON,LAT,LAST_RQ_TIME,LAST_UPDATE,SEND_LOCATION_REQUEST_TIME,CREATE_TIME,FRIEND_USER_ID,POI_NAME,POI_ADDRESS,PINYIN) VALUES('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",TABLE_FRIENDS_DATA,fkeyid,fid,fname,fphone,app.mUserData.mUserID,flon,flat,fLastRqTime,fLastUpdate,sendRqTime,createTime,friendUserID,fPoiName,fPoiAddress,pinyin];
                        NSLog(@"addFriend sql = %@",sql);
                        [tempSql addObject:sql];
                        
                    }
                    [app addFriendDataWithSqls:tempSql];
                }
            }
            [self getLocalFriendlData];
            [tableview reloadData];
            if (isSyncContacts) {
                [NSThread sleepForTimeInterval:1];
            }
            [self MBProgressHUDMessage:[oRes getText:@"friend.AddFriendViewController.updateContactsSuccess"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
        }
        else
        {
            if (isSyncContacts) {
                [NSThread sleepForTimeInterval:1];
            }
            [self MBProgressHUDMessage:[oRes getText:@"friend.AddFriendViewController.updateContactsFailed"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
        }
        
        
    }
    else if(code == NET_ERROR)
    {
        if (isSyncContacts) {
            [NSThread sleepForTimeInterval:1];
        }
        [self MBProgressHUDMessage:[oRes getText:@"common.noNetAlert.message"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
        
        
    }
    else if(NAVINFO_TOKENID_INVALID == code)//TokenID失效处理
    {
        if (isSyncContacts) {
            [NSThread sleepForTimeInterval:1];
        }
        [self MBProgressHUDMessage:[oRes getText:@"common.loseTokenID.message"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else
    {
        if (isSyncContacts) {
            [NSThread sleepForTimeInterval:1];
        }
        [self MBProgressHUDMessage:[oRes getText:@"friend.AddFriendViewController.updateContactsFailed"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
        
    }
    if (isFirstLoginFriend == USER_FIRSTLOGIN)
    {
        App *app = [App getInstance];
        [app updateIsFirstLogin];
        isFirstLoginFriend = USER_UNFIRSTLOGIN;
    }
    //此时启用编辑按键，等到同步结束再启用
    [self setEditButtonEnabledByLoadedData];
    _rootController.backBtn.enabled = YES;
    isSyncContacts = NO;
    _rootController.mSelectFlag = YES;
    
    [self.imageView setFrame:CGRectMake(160, 200, 0, 0)];
    [self SafeHideProgressHUD];
}

/*!
 @method addFriendListView:
 @abstract 添加好友列表界面
 @discussion 添加好友列表界面
 @result 无
 */
-(void)addFriendListView
{
    //好友列表，从服务器获取，现为本地数据
    self.tabBarController.navigationItem.rightBarButtonItem = rightButton;
    self.tabBarController.navigationItem.titleView = btnView;
    //[self getSegmentedControl];
    CGRect rect = CGRectMake(self.navigationController.view.frame.origin.x, self.navigationController.view.frame.origin.y,self.view.frame.size.width,self.view.frame.size.height);
    tableview.frame = rect;
    [self.view addSubview:tableview];
}

/*!
 @method submitData:
 @abstract 数据修改
 @discussion 数据修改
 @result 无
 */
-(void)submitData //delete
{
    App *app = [App getInstance];
    Resources *oRes = [Resources getInstance];
    mLengthOfDeleteContacts = 0;
    mLeftLengthOfDeleteContacts = 0;
    [deleteMutableArray addObjectsFromArray:tempDeleteMutableArray];
    [tempDeleteMutableArray removeAllObjects];
    //将服务器中的数据修改
    if (tableviewType==FRIEND_LIST)//delete
    {
        //取到要删除文件的车友ID
        int deleteContactsNumber = [deleteMutableArray count];
        mLengthOfDeleteContacts = deleteContactsNumber;
        mLeftLengthOfDeleteContacts = deleteContactsNumber;
        if (deleteContactsNumber > 0) {
            FriendsData *frienddata;
            App *app = [App getInstance];
            NSMutableArray *idsArray =[[NSMutableArray alloc] init];
            //将本地的数据修改,
            for (int row= 0; row < [deleteMutableArray count]; row++)
            {
                frienddata=[deleteMutableArray objectAtIndex:row];
                [idsArray addObject:frienddata.mfID];
            }
            
            if (app.mUserData.mType == USER_LOGIN_DEMO)//判断是否DEMO用户
            {
                
                [app deleteMutiFriendsData:idsArray];
                [deleteMutableArray removeAllObjects];
                [self MBProgressHUDMessage:[oRes getText:@"friend.AddFriendViewController.deleteContactsSuccess"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
            }
            else
            {
                //使用删除车友接口，NIDeleteContacts
//                [self sendDeleteContactListRequest];
                isDeleteFriend = YES;
                _rootController.backBtn.enabled = NO;
                editBtn.enabled = NO;
                _rootController.mSelectFlag = NO;
                [self.tabBarController.navigationItem.titleView setUserInteractionEnabled:NO];
                [self.imageView setImage:nil];
                [self.imageView setFrame:CGRectMake(160, 200, 0, 0)];
                [self SafeAllocProgressHUD];
                
                [self.view bringSubviewToFront:self.progressHUD];
                Resources *oRes = [Resources getInstance];
                self.progressHUD.labelText = [oRes getText:@"friend.DeleteContactsList.Title"];
                self.progressHUD.detailsLabelText= [oRes getText:@"common.load.text"];
                [self.progressHUD show:YES];
                [mDeleteContacts createRequest:idsArray];//add the release of memeory
                [mDeleteContacts sendRequestWithAsync:self];
//
            }
            if (idsArray) {
                [idsArray removeAllObjects];
                [idsArray release];
                idsArray = nil;
            }
        }
    }
    else
    {
//        黑名单与车友分开后代码
        //        需要传递参数
        int row;
        BlackData *black;
        //取到要修改的车友信息
        int deleteContactsNumber = [deleteMutableArray count];
        if (deleteContactsNumber > 0)
        {
            NSMutableArray *idList = [[NSMutableArray alloc] init];
            for (row= 0; row < [deleteMutableArray count]; row++)
            {
                black=[deleteMutableArray objectAtIndex:row];
                [idList addObject:black.mID];
            }
//            App *app = [App getInstance];
            if (app.mUserData.mType == USER_LOGIN_DEMO)//判断是否DEMO用户
            {
                App *app = [App getInstance];
                //将本地的数据修改
                [app deleteBlackDataWithIDs:idList];
                [deleteMutableArray removeAllObjects];
                [self MBProgressHUDMessage:[oRes getText:@"friend.friendListViewController.delBlackSuccess"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
            }
            else
            {
                //使用黑名单删除接口
                isDeleteFriend = YES;
                _rootController.backBtn.enabled = NO;
                editBtn.enabled = NO;
                _rootController.mSelectFlag = NO;
                [self.tabBarController.navigationItem.titleView setUserInteractionEnabled:NO];
                [self.imageView setImage:nil];
                [self.imageView setFrame:CGRectMake(160, 200, 0, 0)];
                [self SafeAllocProgressHUD];
                
                [self.view bringSubviewToFront:self.progressHUD];
                Resources *oRes = [Resources getInstance];
                self.progressHUD.labelText = [oRes getText:@"friend.DeleteBlackList.Title"];
                self.progressHUD.detailsLabelText= [oRes getText:@"common.load.text"];
                [self.progressHUD show:YES];
                [mDeleteBlack createRequest:idList];
                [mDeleteBlack sendRequestWithAsync:self];
            }
            if (idList) {
                [idList removeAllObjects];
                [idList release];
                idList = nil;
            }
            
        }
    }
}
/*!
 @method sendDeleteContactListRequest:
 @abstract 发送删除数据请求
 @discussion 发送删除数据请求
 @result 无
 */
-(void)sendDeleteContactListRequest
{
    
    NSMutableArray *contactsList =[[NSMutableArray alloc]init];
    FriendsData *friend;
    NSDictionary *temp;
    for(int i = 0; i < [deleteMutableArray count]; i++)
    {
        friend=[deleteMutableArray objectAtIndex:i];
        temp= [NSDictionary dictionaryWithObjectsAndKeys:
               friend.mfID,@"id",nil];
        [contactsList addObject:temp];
    }
    
    //使用get车友接口，NIGetContactsList
    [mDeleteContacts createRequest:[contactsList autorelease]];//add the release of memeory
    [mDeleteContacts sendRequestWithAsync:self];
}


/*!
 @method onDeleteContactsResult:code:errorMsg:
 @abstract 发送删除数据请求回调函数
 @discussion 发送删除数据请求回调函数
 @result 无
 */
- (void)onDeleteContactsResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg
{
    NSLog(@"receive the result.");
    [self SafeHideProgressHUD];
    Resources *oRes = [Resources getInstance];
    
    if (NAVINFO_RESULT_SUCCESS == code) {
//        if (nil != result)
//        {
//            NSLog(@"result is :%@", result);
//            int totalNum = [[result valueForKey:@"total"] integerValue];
//            NSLog(@"totalNum is :%d", totalNum);
            int row;
            FriendsData *frienddata;
            App *app = [App getInstance];
            NSMutableArray *idsArray =[[NSMutableArray alloc] init];
            //将本地的数据修改
            for (row= 0; row < [deleteMutableArray count]; row++)
            {
                frienddata=[deleteMutableArray objectAtIndex:row];
                [idsArray addObject:frienddata.mfID];
            }
        if (idsArray.count > 0) {
            [app deleteMutiFriendsData:idsArray];
        }
//        }
        [self MBProgressHUDMessage:[oRes getText:@"friend.AddFriendViewController.deleteContactsSuccess"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
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
        [self MBProgressHUDMessage:[oRes getText:@"friend.AddFriendViewController.deleteContactsFailed"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    [self.imageView setFrame:CGRectMake(160, 200, 0, 0)];
    
    [self.tabBarController.navigationItem.titleView setUserInteractionEnabled:YES];
    _rootController.backBtn.enabled = YES;
    editBtn.enabled = YES;
    isDeleteFriend = NO;
    _rootController.mSelectFlag = YES;
    [deleteMutableArray removeAllObjects];
    [self getLocalFriendlData];
    [tableview reloadData];
    
}


- (void)tableViewEdit
{
    [tableview setEditing:!tableview.editing animated:YES];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    dataMutableArray = nil;
    blacklistDataMutableArray=nil;
    deleteMutableArray=nil;
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
 numberOfRowsInSection:(NSInteger)section {
    
    if (tableviewType==FRIEND_LIST)
    {
        return [dataMutableArray count];
    }
    else
    {
        return [blacklistDataMutableArray count];
    }
    
}
#pragma mark - button action


//每行显示的数
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             TableSampleIdentifier];
    
    NSUInteger row = [indexPath row];
    if (tableviewType==FRIEND_LIST)
    {
        if (cell==nil) {
            //装置FriendListCell布局文件
            cell = [[[NSBundle mainBundle] loadNibNamed:@"FriendListCell" owner:self options:nil] lastObject];
        }
        FriendsData *data = [[FriendsData alloc] init];
        data = [dataMutableArray objectAtIndex:row];
        UILabel *name = (UILabel*)[cell viewWithTag:1];
        name.font = [UIFont size14_5];
        name.textColor = [UIColor blackColor];
        UIButton *detail=(UIButton*)[cell viewWithTag:2];
        detail.tag = indexPath.row+100;
        name.text = data.mfName;
        if (editType==EDIT) {
            detail.hidden=YES;
        }
        [detail addTarget:self action:@selector(detailButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    else
    {
        if (cell==nil) {
            //装置BlackListCell布局文件
            cell = [[[NSBundle mainBundle] loadNibNamed:@"BlackListCell" owner:self options:nil] lastObject];
        }
        UIImageView *image=(UIImageView*)[cell viewWithTag:0];
        UILabel *name = (UILabel*)[cell viewWithTag:1];
        name.font = [UIFont size14_5];
        name.textColor = [UIColor blackColor];
        BlackData *data = [blacklistDataMutableArray objectAtIndex:row];
        name.text = data.mName;
        if (editType==EDIT) {
            CGRect rect = name.frame;
            rect.origin.x += 20;
            name.frame = rect;
            rect = image.frame;
            rect.origin.x += 20;
            image.frame = rect;
        }
    }
	return cell;
}


//index 是什么？
-(void) dresserDetails:(NSInteger)index{
    /**************************
     *判断是否为自己
     *变更按Index判断为按用户登录账号
     *孟磊 2013年9月4日
     **************************/
    FriendsData *data = [dataMutableArray objectAtIndex:index];
    App *app=[App getInstance];
    
    if([data.mfID isEqualToString: app.loginID])
    {
        [_rootController goSelfDetail:dataMutableArray index:index];
    }
    else
    {
        [_rootController goFriendDetail:dataMutableArray index:index];
    }
}
-(IBAction)detailButtonClicked:(id)sender{
    //    NSLog(@"%d",((UIButton *)sender).tag);
    [self dresserDetails:((UIButton *)sender).tag-100];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableviewType==FRIEND_LIST)
    {
        /**************************
         *判断是否为自己
         *变更按Index判断为按用户ID
         *孟磊 2013年9月4日
         **************************/
        FriendsData *data = [dataMutableArray objectAtIndex:indexPath.row];
        App *app=[App getInstance];
        if([data.mfID isEqualToString: app.loginID])
        {
            return NO;
        }
        else
        {
            return YES;
        }
    }
    else
    {
        return YES;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableviewType==FRIEND_LIST)
    {
        NSUInteger row = [indexPath row];
        
        [self dresserDetails:row];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
    if (tempDeleteMutableArray.count > 0) {
        
        [self submitData];
    }
}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    //点击按钮事件发生
    if (tableviewType==FRIEND_LIST)
    {
        [tempDeleteMutableArray addObject:[dataMutableArray objectAtIndex:indexPath.row]];
        [dataMutableArray removeObjectAtIndex:indexPath.row];
        NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
        [tableview deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    }
    else
    {
        
        [tempDeleteMutableArray addObject:[blacklistDataMutableArray objectAtIndex:indexPath.row]];
        [blacklistDataMutableArray removeObjectAtIndex:indexPath.row];
        NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
        [tableview deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    }
    
//    [tableview reloadData];
}

-(NSString *)tableView:(UITableView *)tableView
titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    //设置按钮的名称
    Resources *oRes = [Resources getInstance];
    return [oRes getText:@"common.delete"];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return footerView;
}

#pragma mark - private method
/*!
 @method SafeShowProgressHUD
 @abstract 显示信息提示
 @discussion 显示信息提示
 @result 无
 */
-(void) SafeShowProgressHUD
{
    if (_progressHUD != nil) {
        [_progressHUD show:YES];
    }
}//显示信息提示
/*!
 @method SafeHideProgressHUD
 @abstract ProgressHUD提示框
 @discussion ProgressHUD提示框
 @result 无
 */
-(void) SafeHideProgressHUD
{
    if (_progressHUD != nil) {
        [_progressHUD hide:YES];
    }
}
/*!
 @method SafeAllocProgressHUD
 @abstract ProgressHUD提示框
 @discussion ProgressHUD提示框
 @result 无
 */
-(void) SafeAllocProgressHUD
{
    if (_progressHUD == nil) {
        self.progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:self.progressHUD];
        self.progressHUD.delegate = self;
    }
}
#pragma mark - displayList可能有问题
/*!
 @method displayFriendList
 @abstract 初始化信息提示
 @discussion 初始化信息提示
 @result 无
 */
-(void)displayFriendList
{
    /***********************
     * 由于需求变更，车友列表界面显示编辑按钮，
     * 以下代码为车友列表界面不显示编辑按钮
     * 变更代码editBtn.hidden
     * 孟月 2014年3月10日
     ***********************/
    //    editBtn.hidden = YES;
//    if (isFirstLoginFriend==USER_UNFIRSTLOGIN)
//    {
        //重新读取数据
        //        [self tableviewReloadData];
        //设置当前TableViewType为车友
        [self setTableviewType:FRIEND_LIST];
        //TableView重新加载数据
        //        [self tabelViewReload];
        
        [self getLocalFriendlData];
        [tableview reloadData];
        
        //设置编辑按钮的显示状态
        [self setEditButtonEnabledByLoadedData];
        
        //切换TABButton的图片和文字
        [self changeTabButtonImage:YES];
//    }
}
/*!
 @method displayBlackList
 @abstract 显示黑名单
 @discussion 显示黑名单
 @result 无
 */
-(void)displayBlackList
{
    //显示黑名单
    Resources *oRes = [Resources getInstance];
    App *app=[App getInstance];
    [self setTableviewType:BLACK_LIST];
    if (app.mUserData.mType!= USER_LOGIN_DEMO)//判断是否DEMO用户
    {
        if (blackLoad == BLACK_LOAD_YES) {
            //        服务器获取黑名单列表
            [self SafeAllocProgressHUD];
            [self.view bringSubviewToFront:self.progressHUD];
            self.progressHUD.labelText = [oRes getText:@"friend.friendListViewController.loadBlack"];
            self.progressHUD.detailsLabelText= [oRes getText:@"common.load.text"];
            [self.progressHUD show:YES];
            _rootController.backBtn.enabled = NO;
            [self sendGetBlackRequest];
            [app setBlackLoadType:BLACK_LOAD_NO];
            blackLoad = BLACK_LOAD_NO;
            NSLog(@"服务器获取黑名单");
        }
        else
        {
            [self getLocalBlackData];
            [tableview reloadData];
            
        }
    }
    else
    {
        [self getLocalBlackData];
        [tableview reloadData];
    }
    //设置编辑按钮的显示状态
    [self setEditButtonEnabledByLoadedData];
    [self changeTabButtonImage:NO];
}
#pragma mark –
#pragma mark Data Source Loading / Reloading Methods
/*!
 @method reloadTableViewDataSource
 @abstract 加载数据
 @discussion 加载数据
 @result 无
 */
- (void)reloadTableViewDataSource{
    NSLog(@"==开始加载数据");
    App *app=[App getInstance];
    if (app.mUserData.mType!= USER_LOGIN_DEMO)//判断是否DEMO用户
    {
//        editBtn.enabled = NO;
        _rootController.backBtn.enabled = NO;
        if (tableviewType==FRIEND_LIST)
        {
            [self sendGetContactListRequest];
        }
        else
        {
            [self sendGetBlackRequest];
        }
        
    }
    else
    {
        if (tableviewType==FRIEND_LIST)
        {
            [self getLocalFriendlData];
        }
        else
        {
            [self getLocalBlackData];
        }
        [tableview reloadData];
    }
    _reloading = YES;
}
- (void)doneLoadingTableViewData{
    NSLog(@"===加载完数据");
    _reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:tableview];
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
    
    /*设置标志位，控制等待提示框的显隐 孟磊 2013年9月3日*/
    isEGOrefresh = YES;
    
    [self reloadTableViewDataSource];
    App *app    = [App getInstance];
    if (app.mUserData.mType == USER_LOGIN_DEMO)
    {
        [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
    }

}
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    return _reloading;
}
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    return [NSDate date];;
}

#pragma mark - 孟磊 - 公有方法
- (void) addFriendIntoList:(FriendsData *) friendData
{
    //加入数据
    //[self addRow2TableViewBottom:friendData];
    
    //滚动到列表末尾
    [self scroll2TableViewBottom];
    
}

#pragma mark - 孟磊 - 私有方法
/*!
 @method addRow2TableViewBottom
 @abstract UI界面设置
 @discussion UI界面设置
 @result 无
 */
- (void) addRow2TableViewBottom:(FriendsData *) friend
{
    [dataMutableArray addObject:friend];
    [tableview reloadData];
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    NSIndexPath *indexPath= [NSIndexPath indexPathForRow:[dataMutableArray count]-1 inSection:0];
    [indexPaths addObject:indexPath];
    
    [tableview beginUpdates];
    [tableview insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
    [tableview endUpdates];
    
    [indexPaths release];
}
/*!
 @method scroll2TableViewBottom
 @abstract UI界面设置
 @discussion UI界面设置
 @result 无
 */
- (void) scroll2TableViewBottom
{
    if([dataMutableArray count]>0)
    {
        //滚动到最后
        NSIndexPath *lastRow = [NSIndexPath indexPathForRow:([dataMutableArray count] - 1) inSection:0];
        [tableview scrollToRowAtIndexPath:lastRow
                         atScrollPosition:UITableViewScrollPositionBottom
                                 animated:YES];
    }
}
/*!
 @method scroll2TableViewTop
 @abstract UI界面设置
 @discussion UI界面设置
 @result 无
 */
-(void)scroll2TableViewTop
{
    NSIndexPath *scrollRow = [NSIndexPath indexPathForRow:0 inSection:0];
    [tableview scrollToRowAtIndexPath:scrollRow
                     atScrollPosition:UITableViewScrollPositionTop
                             animated:NO];
}
/*!
 @method scroll2TableViewAtRow
 @abstract UI界面设置
 @discussion UI界面设置
 @result 无
 */
-(void)scroll2TableViewAtRow:(int)row
{
    if (row > 0) {
        NSIndexPath *scrollRow = [NSIndexPath indexPathForRow:row inSection:0];
        [tableview scrollToRowAtIndexPath:scrollRow
                         atScrollPosition:UITableViewScrollPositionTop
                                 animated:YES];
    }
    if (newFriendName) {
        [newFriendName release];
        newFriendName = nil;
    }
}
/*!
 @method changeTabButtonImage
 @abstract UI界面设置
 @discussion UI界面设置
 @result 无
 */
- (void) changeTabButtonImage:(BOOL)bShowFriendList
{
    UIColor *titlewhiteColor = [[UIColor alloc] initWithRed:1 green:1 blue:1 alpha:1];
    UIColor *titlegrayColor = [[UIColor alloc] initWithRed:0.451 green:0.451 blue:0.451 alpha:1];
    
    if (bShowFriendList)
    {
        UIImage *enabled    = [UIImage imageNamed:@"friend_list_left_yes"];
        UIImage *unenabled  = [UIImage imageNamed:@"friend_list_right_no"];
        [friendlistBtn setBackgroundImage:enabled forState:UIControlStateNormal];
        [blacklistBtn setBackgroundImage:unenabled forState:UIControlStateNormal];
        [blacklistBtn setTitleColor:titlegrayColor forState:UIControlStateNormal];
        [friendlistBtn setTitleColor:titlewhiteColor forState:UIControlStateNormal];
    }
    else
    {
        UIImage *enabled    = [UIImage imageNamed:@"friend_list_right_yes"];
        UIImage *unenabled  = [UIImage imageNamed:@"friend_list_left_no"];
        [friendlistBtn setBackgroundImage:unenabled forState:UIControlStateNormal];
        [blacklistBtn setBackgroundImage:enabled forState:UIControlStateNormal];
        [blacklistBtn setTitleColor:titlewhiteColor forState:UIControlStateNormal];
        [friendlistBtn setTitleColor:titlegrayColor forState:UIControlStateNormal];
    }
    [titlewhiteColor release];
    [titlegrayColor release];
    
}
/*!
 @method setFistLoginFlag
 @abstract UI界面设置
 @discussion UI界面设置
 @result 无
 */
-(void) setFistLoginFlag
{
    App *app    = [App getInstance];
    int login   =[app getIsFirstLogin];
    if (app.mUserData.mType == USER_LOGIN_DEMO)
    {
        //        isFirstLoginFriend = USER_FIRSTLOGIN;
        isFirstLoginFriend = app.demoIsFirstLoginFriend;
    }
    else
    {
        isFirstLoginFriend = login;
    }
}
/*!
 @method setButtonDisabled
 @abstract UI界面设置
 @discussion UI界面设置
 @result 无
 */
-(void) setButtonDisabled
{
    if (isFirstLoginFriend==USER_FIRSTLOGIN)
    {
        _rootController.mSelectFlag = NO;
        [self.tabBarController.navigationItem.titleView setUserInteractionEnabled:NO];
    }
}

/*!
 @method setButtonEnable
 @abstract 设置全部按钮可用
 @discussion 设置全部按钮可用
 @result 无
 */
-(void) setButtonEnable
{
    _rootController.backBtn.enabled = YES;
    editBtn.enabled = YES;
    
    _rootController.mSelectFlag = YES;
    
    [self.tabBarController.navigationItem.titleView setUserInteractionEnabled:YES];
}

/*!
 @method setEditButtonEnabledByLoadedData
 @abstract 根据已载入数据的情况，设置编辑按钮是否可用
 @discussion 根据已载入数据的情况，设置编辑按钮是否可用
 @result 无
 */
-(void) setEditButtonEnabledByLoadedData
{
    editBtn.enabled = YES;
    if (tableviewType==BLACK_LIST)
    {
        if ([blacklistDataMutableArray count] == 0)
        {
            if (editType == FINISH) {
                editBtn.enabled = NO; //列表为空时“编辑”按钮失效
            }
        }
        
    }
    else
    {
        if ([dataMutableArray count] == 0)
        {
            if (editType == FINISH) {
                editBtn.enabled = NO; //列表为空时“编辑”按钮失效
            }
        }
        else if ([dataMutableArray count] == 1)
        {
            FriendsData *data = [dataMutableArray objectAtIndex:0];
            App *app=[App getInstance];
            if([data.mfID isEqualToString: app.loginID])
            {
                if (editType == FINISH) {
                    editBtn.enabled = NO; //列表为空时“编辑”按钮失效
                }
            }
        }
    }
    if (isDeleteFriend == YES) {
        editBtn.enabled = NO;
    }
    
}

/*!
 @method getUiqueMutableArray
 @abstract 按联系人名称剔除姓名重复的联系人
 @discussion 按联系人名称剔除姓名重复的联系人
 @result 无
 */
-(NSMutableArray *) getUiqueMutableArray: (NSMutableArray *) array
{
    NSMutableArray *mUniqueList = [NSMutableArray arrayWithArray: [array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1[@"name"] compare:obj2[@"name"] options:NSCaseInsensitiveSearch];
    }]];
    
    NSMutableIndexSet * indexSet = [[NSMutableIndexSet alloc]init];
    BOOL bFlag = NO;
    NSLog(@"%d",mUniqueList.count);
    for(int i = 0; i < mUniqueList.count - 1; i++)
    {
        if ([mUniqueList[i][@"name"] isEqualToString:mUniqueList[i+1][@"name"]]) {
            if (!bFlag) {//与前面的不同，这里处理的是：如果存在相同，一个不留
                [indexSet addIndex:i];
            }
            [indexSet addIndex:i+1];
            bFlag = YES;
        }
        else
        {
            bFlag = NO;
        }
    }
    
    [mUniqueList removeObjectsAtIndexes:indexSet];
    
    [indexSet release];
    
    for(int i = 0; i < mUniqueList.count; i++)
    {
        NSLog(@"%@",mUniqueList[i][@"name"]);
    }
    return mUniqueList;
}

-(void)sendSyncContactListRequest:(NSMutableArray *) array segment:(int)segement
{
    if (array == nil) return;
    if (array.count == 0) return;
    if (array.count < segement) segement = array.count;
    NSMutableArray * contactList = [[[NSMutableArray alloc] initWithCapacity:segement]autorelease];
    for (int i = 0; i < array.count; i++) {
        [contactList addObject:array[i]];
        if ((i+1) % segement == 0) {
            [self createRequestAsync : contactList];
            contactList = [[[NSMutableArray alloc] initWithCapacity:segement]autorelease];
        }
    }
}

/*!
 @method createRequestAsync:
 @abstract Observer 发送同步请求
 @discussion Observer 发送同步请求
 @result 无
 */
-(void) createRequestAsync : (NSMutableArray *) array
{
    //@autoreleasepool{
    //        NSThread *curThread = [NSThread currentThread];
    //        if (curThread.isMainThread) {
    //            NSLog(@"Main Thread is excuting");
    //        }
    [mSyncContacts createRequest:[array autorelease]];//add the release of memeory
    [mSyncContacts sendRequestWithAsync:self];
    //}
}

/*!
 @method observeValueForKeyPath:ofObject:change:context:
 @abstract Observer 回调方法
 @discussion Observer 回调方法
 @result 无
 */

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSThread *curThread = [NSThread currentThread];
    if (curThread.isMainThread) {
        if ([keyPath isEqualToString:@"isFinished"]) {
            NSLog(@"keypath changed : %@",  [change objectForKey:@"isFinished"]) ;
        }
        NSLog(@"Thread is excuting: %@",object);
    }
}

/*!
 @method sendGetBlackRequest:
 @abstract 发送获取黑名单请求
 @discussion 发送获取黑名单请求
 @result 无
 */
-(void)sendGetBlackRequest
{
    //使用get黑名单接口，NIGetBlack
    
    _rootController.backBtn.enabled = NO;
    [mGetBlack createRequest];
    [mGetBlack sendRequestWithAsync:self];
}
/*!
 @method onGetBlackResult:code:errorMsg:
 @abstract 发送获取黑名单请求回调函数
 @discussion 发送获取黑名单请求请求回调函数
 @result 无
 */
- (void)onGetBlackResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg
{
    Resources *oRes = [Resources getInstance];
    [self SafeHideProgressHUD];
    
    [self doneLoadingTableViewData];
    if (NAVINFO_RESULT_SUCCESS == code)
    {
        if (nil != result)
        {
            NSLog(@"result is :%@", result);
            
            App *app = [App getInstance];
            //服务器获取黑名单列表
            [app deleteAllBlackData];
            
            if ([result objectForKey:@"blackList"]) {
                NSArray *BlackFromNet = [result objectForKey:@"blackList"];
                NSMutableArray *tempSql = [[[NSMutableArray alloc]initWithCapacity:0]autorelease];
                for (id black in BlackFromNet)
                {
                    NSString *uuid = [App createUUID];
                    NSString *keyid=uuid;
                    NSString *ID=[black objectForKey:@"id"];
                    if (!ID) {
                        ID = @"";
                    }
                    NSString *mobile=[black objectForKey:@"phone"];
                    if (!mobile) {
                        mobile = @"";
                    }
                    NSString *name=[black objectForKey:@"name"];
                    if (!name) {
                        name = @"";
                    }
                    NSString *pinyin=[black objectForKey:@"pinyin"];
                    if (!pinyin) {
                        pinyin = @"";
                    }
                    NSString *lastUpdate=[black objectForKey:@"lastUpdate"];
                    if (!lastUpdate) {
                        lastUpdate = @"";
                    }
                    NSString *createTime=[black objectForKey:@"createTime"];
                    if (!createTime) {
                        createTime = @"";
                    }
                    name = [name avoidSingleQuotesForSqLite];
                    pinyin = [pinyin avoidSingleQuotesForSqLite];
                    NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ (KEYID,ID,NAME,MOBILE,LAST_UPDATE,CREATE_TIME,USER_KEYID,PINYIN) VALUES('%@','%@','%@','%@','%@','%@','%@','%@')",TABLE_BLACK_DATA,keyid,ID,name,mobile,lastUpdate,createTime,app.mUserData.mUserID,pinyin];
                    [tempSql addObject:sql];
                    
                }
                [app addBlackDataWithSqls:tempSql];
            }
           [self MBProgressHUDMessage:[oRes getText:@"friend.AddFriendViewController.updateContactsSuccess"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
           
        }
        else
        {
            [self MBProgressHUDMessage:[oRes getText:@"friend.AddFriendViewController.updateContactsFailed"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
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
        [self MBProgressHUDMessage:[oRes getText:@"friend.AddFriendViewController.updateContactsFailed"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];

    }
    [self.imageView setFrame:CGRectMake(160, 200, 0, 0)];
    
    //刷新黑名单列表
    [self getLocalBlackData];
    [tableview reloadData];
    _rootController.backBtn.enabled = YES;
}

/*!
 @method onDeleteBlackResult:code:errorMsg:
 @abstract 发送删除黑名单请求回调函数
 @discussion 发送删除黑名单请求请求回调函数
 @result 无
 */
- (void)onDeleteBlackResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg
{
    NSLog(@"receive the result.");
    [self SafeHideProgressHUD];
    Resources *oRes = [Resources getInstance];
    
    if (NAVINFO_RESULT_SUCCESS == code)
    {
//        if (nil != result)
//        {
//            NSLog(@"result is :%@", result);
//            int totalNum = [[result valueForKey:@"total"] integerValue];
//            NSLog(@"totalNum is :%d", totalNum);
            int row;
            BlackData *black;
            App *app = [App getInstance];
            NSMutableArray *idsArray =[[NSMutableArray alloc] init];
            //将本地的数据修改
            for (row= 0; row < [deleteMutableArray count]; row++)
            {
                black=[deleteMutableArray objectAtIndex:row];
                [idsArray addObject:black.mID];
            }
        if (idsArray.count > 0) {
            [app deleteBlackDataWithIDs:idsArray];
        }
        
//        }
        [self MBProgressHUDMessage:[oRes getText:@"friend.friendListViewController.delBlackSuccess"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];

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
        [self MBProgressHUDMessage:[oRes getText:@"friend.friendListViewController.delBlackFailed"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];

    }
    [self.imageView setFrame:CGRectMake(160, 200, 0, 0)];
    
    //        刷新列表
    [self.tabBarController.navigationItem.titleView setUserInteractionEnabled:YES];
    _rootController.backBtn.enabled = YES;
    editBtn.enabled = YES;
    isDeleteFriend = NO;
    _rootController.mSelectFlag = YES;
    [deleteMutableArray removeAllObjects];
    [self getLocalBlackData];
    [tableview reloadData];
}
#pragma mark -MBProgressHUDMessage
//message:提示内容 time：消失延迟时间（s） xOffset:相对屏幕中心点的X轴偏移 yOffset:相对屏幕中心点的Y轴偏移
- (void)MBProgressHUDMessage:(NSString *)message delayTime:(int)time xOffset:(float)xOffset yOffset:(float)yOffset
{
    MBProgressHUD *progressHUDMessage = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    progressHUDMessage.OffsetFlag = 1;
    progressHUDMessage.mode = MBProgressHUDModeText;
	progressHUDMessage.labelText = message;
	progressHUDMessage.margin = 10.f;
    progressHUDMessage.xOffset = xOffset;
    progressHUDMessage.yOffset = yOffset;
	progressHUDMessage.removeFromSuperViewOnHide = YES;
	[progressHUDMessage hide:YES afterDelay:time];
    
}

@end

