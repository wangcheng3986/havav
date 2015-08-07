
/*!
 @header SendToCarViewViewController.m
 @abstract 发送到车类
 @author mengy
 @version 1.00 13-5-4 Creation
 */
#import "SendToCarViewViewController.h"
#import "App.h"
#import "SelectFriendViewController.h"
#import "POIDetailViewController.h"
#import "POIData.h"
@interface SendToCarViewViewController ()
{
    UserData *mUserData;
    NSDate *date;
    NSString *content;
    NSArray *nameValues;
    NSArray *phoneValues;
    NSString *mlon;
    NSString *mlat;
    NSString *mTitle;
    NSString *mAddress;
    NSString *mPoiID;
    NSString *mPoiName;
    int loginType;
    int sendCount;
    POIData *POI;
    UIBarButtonItem *rightButton;
    UIColor *searchBarColor;
//    BOOL pop;
}
@end

@implementation SendToCarViewViewController
@synthesize picUrlString = _picUrlString;
@synthesize imageView = _imageView;
@synthesize progressHUD = _progressHUD;
@synthesize phoneDictionary;
@synthesize nameDictionary;
@synthesize numDictionary;
@synthesize phoneNameDictionary;
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
    if (self.progressHUD){
        [self.progressHUD removeFromSuperview];
        [self.progressHUD release];
        self.progressHUD = nil;
        
    }
    if (searchBarColor) {
        [searchBarColor release];
    }
    if (content) {
        [content release];
    }
    if (mlon) {
        [mlon release];
    }
    if (mlat) {
        [mlat release];
    }
    if (mAddress) {
        [mAddress release];
    }
    if (mTitle) {
        [mTitle release];
    }
    if (mPoiID) {
        [mPoiID release];
    }
    if (mPoiName) {
        [mPoiName release];
    }
    if (phoneValues) {
        [phoneValues release];
        phoneValues=nil;
    }
    if (phoneDictionary) {
        [phoneDictionary removeAllObjects];
        [phoneDictionary release];
        phoneDictionary=nil;
    }
    if (nameDictionary) {
        [nameDictionary removeAllObjects];
        [nameDictionary release];
        nameDictionary=nil;
    }
    if (numDictionary) {
        [numDictionary removeAllObjects];
        [numDictionary release];
        numDictionary=nil;
    }
    if (phoneNameDictionary) {
        [phoneNameDictionary removeAllObjects];
        [phoneNameDictionary release];
        phoneNameDictionary = nil;
    }
    if (mDisView) {
        [mDisView removeFromSuperview];
        [mDisView release];
    }
    if (eventView) {
        [eventView removeFromSuperview];
        [eventView release];
    }
    if (receiverLabel) {
        [receiverLabel removeFromSuperview];
        [receiverLabel release];
    }
    if (eventLabel) {
        [eventLabel removeFromSuperview];
        [eventLabel release];
    }
    if (receivePlaceholderLabel) {
        [receivePlaceholderLabel removeFromSuperview];
        [receivePlaceholderLabel release];
    }
    if (message) {
        [message removeFromSuperview];
        [message release];
    }
    if (messageBg) {
        [messageBg removeFromSuperview];
        [messageBg release];
    }
    if (addReceiverButton) {
        [addReceiverButton removeFromSuperview];
        [addReceiverButton release];
    }
    if (addEventButton) {
        [addEventButton removeFromSuperview];
        [addEventButton release];
    }
    if (datePicker) {
        [datePicker removeFromSuperview];
        [datePicker release];
    }
    if (titleLabel) {
        [titleLabel removeFromSuperview];
        [titleLabel release];
    }
    if (cencelBtn) {
        [cencelBtn removeFromSuperview];
        [cencelBtn release];
    }
    if (sendBtn) {
        [sendBtn removeFromSuperview];
        [sendBtn release];
    }
    if (downBg) {
        [downBg removeFromSuperview];
        [downBg release];
    }
    if (upBg) {
        [upBg removeFromSuperview];
        [upBg release];
    }
    if (self.imageView) {
        [self.imageView removeFromSuperview];
        [self.imageView release];
    }
    if (textCountLabel) {
        [textCountLabel release];
        textCountLabel = nil;
    }
    [mSendToCar release];
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
    sendCount=0;
    App *app=[App getInstance];
    mUserData=[app getUserData];
    loginType=mUserData.mType;
    Resources *oRes = [Resources getInstance];
    eventView.hidden=YES;
    mSendToCar = [[NISendToCar alloc]init];
   
    if([App getVersion]>=IOS_VER_7)
    {
        [App ios7ViewLocation:self];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_ios7_navBar_bg"] forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_ios6_navBar_bg"] forBarMetrics:UIBarMetricsLandscapePhone];
    }
        //        根据设备屏幕大小判断
    
    enum SCREEN_SIZE   deviceSize = [App getScreenSize];
    if (deviceSize == SCREEN_SIZE_960_640)
    {
        [message setFrame:CGRectMake(message.frame.origin.x, message.frame.origin.y-10, message.frame.size.width, message.frame.size.height)];
        [textCountLabel setFrame:CGRectMake(textCountLabel.frame.origin.x, textCountLabel.frame.origin.y-10, textCountLabel.frame.size.width, textCountLabel.frame.size.height)];
        [messagePlaceholderLabel setFrame:CGRectMake(messagePlaceholderLabel.frame.origin.x+2, messagePlaceholderLabel.frame.origin.y-10, messagePlaceholderLabel.frame.size.width, messagePlaceholderLabel.frame.size.height)];
        [datePicker setFrame:CGRectMake(datePicker.frame.origin.x, datePicker.frame.origin.y-10, datePicker.frame.size.width, datePicker.frame.size.height)];
        [messageBg setFrame:CGRectMake(messageBg.frame.origin.x, messageBg.frame.origin.y-10, messageBg.frame.size.width, messageBg.frame.size.height)];
    }
    messagePlaceholderLabel.text = [oRes getText:@"selectFriendViewController.remindTextPlaceholder"];
    messagePlaceholderLabel.font = [UIFont inputTextSize];
    self.navigationItem.leftBarButtonItem =[self createCencelButton];

    self.navigationItem.title=[oRes getText:@"sendToCarViewController.title"];
    
    receivePlaceholderLabel.text = [oRes getText:@"selectFriendViewController.recipientTextPlaceholder"];
    receivePlaceholderLabel.font = [UIFont inputTextSize];
    [receiveTextView setTextColor:[[UIColor alloc] initWithRed:0.45 green:0.45 blue:0.45 alpha:1]];
    
    receiveTextView.font = [UIFont inputTextSize];
    receiveTextView.delegate = self;
    receiveTextView.editable = NO;
    
    
    textCountLabel.text = @"0/80";
//    textCountLabel.hidden = YES;
    [addEventButton setBackgroundImage:[UIImage imageNamed:@"map_send2car_checkbox_selected"] forState:UIControlStateNormal];
    sendBtn = [[RightButton alloc]init];
    [sendBtn setTitle:[oRes getText:@"sendToCarViewController.sendBtnTitle"] forState:UIControlStateNormal];
     [sendBtn addTarget:self action:@selector(sendToCar:)forControlEvents:UIControlEventTouchUpInside];
    rightButton=[[UIBarButtonItem alloc]initWithCustomView:sendBtn];
    self.navigationItem.rightBarButtonItem = rightButton;
    [self load];
    message.delegate=self;
    mDisView.hidden=YES;
    [self.navigationController.view addSubview:mDisView];
    phoneDictionary = [[NSMutableDictionary alloc]initWithCapacity:0];
    nameDictionary = [[NSMutableDictionary alloc]initWithCapacity:0];
    numDictionary = [[NSMutableDictionary alloc]initWithCapacity:0];
    phoneNameDictionary = [[NSMutableDictionary alloc]initWithCapacity:0];
    //当send时，重新设置imageView
    [self.imageView setImage:nil];
    [self.imageView setFrame:CGRectMake(160, 200, 0, 0)];
    //显示加载等待框
    self.progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.progressHUD];
    [self.view bringSubviewToFront:self.progressHUD];
    self.progressHUD.delegate = self;
    eventScrollView.delegate = self;
    eventScrollViewBottom = [[UIView alloc]initWithFrame:CGRectMake(0, 479, 320, 109)];
    //监听键盘状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [receiveTextView setContentOffset:CGPointMake(0, 0) animated:NO];
    if ([receiveTextView.text isEqualToString:@""]) {
        receivePlaceholderLabel.hidden = NO;
    }
    else
    {
        receivePlaceholderLabel.hidden = YES;
    }
    [super viewWillAppear:animated];
}

/*!
 @method cencel
 @abstract 返回上一页
 @discussion 返回上一页
 @param 无
 @result 无
 */
-(void)cencel
{
    [self popself];
}

/*!
 @method createCencelButton
 @abstract 创建返回按钮
 @discussion 创建返回按钮
 @param 无
 @result UIBarButtonItem
 */
-(UIBarButtonItem*) createCencelButton

{
    cencelBtn = [[LeftButton alloc]init];
    [cencelBtn addTarget:self action:@selector(cencel)forControlEvents:UIControlEventTouchUpInside];
    return [[[UIBarButtonItem alloc]initWithCustomView:cencelBtn]autorelease];
}

/*!
 @method setData:(NSMutableDictionary *)PhoneDictionary phoneNameDictionary:(NSMutableDictionary *)PhoneNameDictionary nameDictionary
 @abstract send2car界面和选择车友界面之间转换的数据传递
 @discussion send2car界面和选择车友界面之间转换的数据传递
 @param PhoneDictionary nameDictionary numDictionary
 @result 无
 */
-(void)setData:(NSMutableDictionary *)PhoneDictionary phoneNameDictionary:(NSMutableDictionary *)PhoneNameDictionary nameDictionary:(NSMutableDictionary *)NameDictionary numDictionary:(NSMutableDictionary*)NumDictionary
{
    [phoneDictionary removeAllObjects];
    [nameDictionary removeAllObjects];
    [phoneNameDictionary removeAllObjects];
    [numDictionary removeAllObjects];
    [phoneDictionary addEntriesFromDictionary:PhoneDictionary];
    [phoneNameDictionary addEntriesFromDictionary:PhoneNameDictionary];
    [nameDictionary addEntriesFromDictionary:NameDictionary];
    [numDictionary addEntriesFromDictionary:NumDictionary];
    nameValues=[NSArray arrayWithArray:[nameDictionary allValues]];
    NSString *str=[[[NSString alloc]init]autorelease];
    NSString *str2=[[NSString alloc]init];
    NSString *str3=@",";
    for (int count=0; count<nameValues.count; count++) {
        str2=[nameValues objectAtIndex:count];
        str = [str stringByAppendingString:str2];
        if (count!=nameValues.count-1) {
            str = [str stringByAppendingString:str3];
        }
    }
    receiveTextView.text = str;

    [str3 release];
    [str2 release];
    
}


/*!
 @method load
 @abstract 加载界面信息
 @discussion 加载界面信息
 @param 无
 @result 无
 */
-(void)load
{
    Resources *oRes = [Resources getInstance];
    receiverLabel.text=[oRes getText:@"sendToCarViewController.receiverLabel"];
    eventLabel.text=[oRes getText:@"sendToCarViewController.eventlabel"];
    receiverLabel.font =[UIFont size12];
    eventLabel.font =[UIFont size12];
    [addEventButton setBackgroundImage:[UIImage imageNamed:@"map_send2car_checkbox"] forState:UIControlStateNormal];
}

/*!
 @method onclickEvent:
 @abstract 添加事件
 @discussion 添加事件
 @param 无
 @result 无
 */
-(IBAction)onclickEvent:(id)sender
{
    [message resignFirstResponder];
    if (eventView.hidden==YES)
    {
        [addEventButton setBackgroundImage:[UIImage imageNamed:@"map_send2car_checkbox_selected"] forState:UIControlStateNormal];
        message.font =[UIFont inputTextSize];
        eventView.hidden=NO;
    }
    else
    {
        [addEventButton setBackgroundImage:[UIImage imageNamed:@"map_send2car_checkbox"] forState:UIControlStateNormal];
        eventView.hidden=YES;
//        datePicker.minimumDate = [NSDate date];
    }
    
}

/*!
 @method addFriend:
 @abstract 选择车友
 @discussion 选择车友
 @param 无
 @result 无
 */
-(IBAction)addFriend:(id)sender
{
    SelectFriendViewController *selectFriendViewController=[[SelectFriendViewController alloc]init];
    selectFriendViewController.rootController=self;
//    NSMutableArray *targetList=[self getList];
//    [self deleteInvalidData:targetList];
    [self.navigationController pushViewController:selectFriendViewController animated:YES];
    [selectFriendViewController release];
}

/*!
 @method getList
 @abstract 筛选数据，并将中文状态下的“，”换为英文状态下的“，”
 @discussion 筛选数据，并将中文状态下的“，”换为英文状态下的“，”
 @param 无
 @result list
 */
-(NSMutableArray *)getList
{
//    NSString *text = [NSString stringWithFormat:@"%@",[searchBar.text stringByReplacingOccurrencesOfString:@"，" withString:@","]];
//    NSString *text = [NSString stringWithFormat:@"%@",[receiveTextField.text stringByReplacingOccurrencesOfString:@"，" withString:@","]];
    NSString *text = [NSString stringWithFormat:@"%@",[receiveTextView.text stringByReplacingOccurrencesOfString:@"，" withString:@","]];
    NSArray *array=[text componentsSeparatedByString:@","];
    NSString *str;
    NSMutableArray *targetList=[[[NSMutableArray alloc]initWithCapacity:0]autorelease];
    int targetObj=0;
    for (int count=0; count<array.count; count++) {
        str=[array objectAtIndex:count];
        if (![[str stringByTrimmingCharactersInSet:
              [NSCharacterSet whitespaceAndNewlineCharacterSet]] compare:@""
             options:NSLiteralSearch]==NSOrderedSame)
        {
            [targetList insertObject:str atIndex:targetObj];
            targetObj++;
            
        }
    }
    return targetList;
}

/*!
 @method getList
 @abstract 将筛选过的数据重新整合至本地缓存中，待selectFriendViewController留用
 @discussion 将筛选过的数据重新整合至本地缓存中，待selectFriendViewController留用
 @param list 发送列表
 @result 无
 */
-(void)deleteInvalidData:(NSMutableArray *)list
{
    NSString *str;
    NSMutableDictionary *tempPhoneDictionary=[[NSMutableDictionary alloc]initWithCapacity:0];
    NSMutableDictionary *tempNameDictionary=[[NSMutableDictionary alloc]initWithCapacity:0];
    NSMutableDictionary *tempPhoneNameDictionary=[[NSMutableDictionary alloc]initWithCapacity:0];
    int row=0;
    for (int count=0; count<list.count; count++) {
        str=[list objectAtIndex:count];
        if ([phoneDictionary objectForKey:str]) {
            [tempPhoneDictionary setObject:[phoneDictionary objectForKey:str] forKey:str];
            row=[[numDictionary objectForKey:str]integerValue];
            [tempNameDictionary setObject:str forKey:[NSString stringWithFormat:@"%d",row]];
            [tempPhoneNameDictionary setObject:str forKey:[phoneDictionary objectForKey:str]];
        }
    }
    [phoneDictionary removeAllObjects];
    [nameDictionary removeAllObjects];
    [phoneNameDictionary removeAllObjects];
    [phoneDictionary addEntriesFromDictionary:tempPhoneDictionary];
    [nameDictionary addEntriesFromDictionary:tempNameDictionary];
    [phoneNameDictionary addEntriesFromDictionary:tempPhoneNameDictionary];
    [tempPhoneDictionary removeAllObjects];
    [tempPhoneDictionary release];
    tempPhoneDictionary=nil;
    [tempNameDictionary removeAllObjects];
    [tempNameDictionary release];
    tempNameDictionary=nil;
    [tempPhoneNameDictionary removeAllObjects];
    [tempPhoneNameDictionary release];
    tempPhoneNameDictionary=nil;
}

/*!
 @method resetData:(NSMutableArray *)list
 @abstract 重新整理数据
 @discussion 重新整理数据
 @param list 发送列表
 @result list
 */
-(NSMutableArray *)resetData:(NSMutableArray *)list
{
    NSString *str;
    NSMutableArray *tempList=[[NSMutableArray alloc]initWithCapacity:0];
    //将从选择车友中来的车友名字换成其电话号码
    for (int count=0; count<list.count; count++) {
        str=[list objectAtIndex:count];
        if ([phoneDictionary objectForKey:str]) {
            [list removeObjectAtIndex:count];
            [list insertObject:[phoneDictionary objectForKey:str] atIndex:count];
        }
    }
    //删除号码中重复的数据
    for (int count=0; count<list.count; count++) {
        str=[list objectAtIndex:count];
        BOOL exist=NO;
        for (int row=count+1; row<list.count; row++) {
            if ([str isEqualToString:[list objectAtIndex:row]]) {
                exist=YES;
            }
        }
        if (!exist) {
            [tempList addObject:str];
        }
    }
    [list removeAllObjects];
    [list addObjectsFromArray:tempList];
    [tempList removeAllObjects];
    [tempList release];
    tempList=nil;
    return list;
}

/*!
 @method backgroundTap
 @abstract 取消键盘
 @discussion 取消键盘
 @param 无
 @result 无
 */
-(IBAction)backgroundTap:(id)sender
{
    [message resignFirstResponder];
}

/*!
 @method setPOI:(POIData *)poi
 @abstract 设置poi点
 @discussion 设置poi点
 @param poi poi信息
 @result 无
 */
-(void)setPOI:(POIData *)poi
{
    POI=poi;
    mTitle=[[NSString alloc]initWithFormat:@"%@",POI.mName];
    mAddress=[[NSString alloc]initWithFormat:@"%@",POI.mAddress];
    mlon=[[NSString alloc]initWithFormat:@"%@",POI.mLon];
    mlat=[[NSString alloc]initWithFormat:@"%@",POI.mLat];
    mPoiID = [[NSString alloc]initWithFormat:@"%@",POI.mID];
    mPoiName = [[NSString alloc]initWithFormat:@"%@",POI.mName];
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
    return [[UIBarButtonItem alloc]
            initWithTitle:[oRes getText:@"common.BackButtonTitle"]
            style:UIBarButtonItemStyleBordered
            target:self
            action:@selector(popself)];
}



/*!
 @method sendToCar
 @abstract 发送到车，
 @discussion 发送到车
 @param 无
 @result 无
 */
-(IBAction)sendToCar:(id)sender
{
    
    Resources *oRes = [Resources getInstance];
    NSDictionary *para;
    NSDictionary *target;
    NSMutableArray *targetList=[[[NSMutableArray alloc]initWithCapacity:0]autorelease];
    if ([receiveTextView.text compare:@""
                               options:NSLiteralSearch]==NSOrderedSame) {
        [self MBProgressHUDMessage:[oRes getText:@"sendToCarViewController.numberNillAlert"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else if([[receiveTextView.text stringByTrimmingCharactersInSet:
              [NSCharacterSet whitespaceAndNewlineCharacterSet]] compare:@""
             options:NSLiteralSearch]==NSOrderedSame)
    {
        receiveTextView.text=@"";
        [self MBProgressHUDMessage:[oRes getText:@"common.noTextAlert.message"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else if (eventView.hidden==NO && [[NSDate date] compare: datePicker.date] == NSOrderedDescending)
    {
        [self MBProgressHUDMessage:[oRes getText:@"common.earlyEventTime.message"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else
    {
        
        NSArray *tempList=[[[NSArray alloc] initWithArray:[phoneDictionary allValues]]autorelease];
        NSString *str;
        int targetObj=0;
//        更改前
//        tempList=[self getList];
//        //重新整理数据，包括将名字换成电话号码，及去重
//        tempList=[self resetData:tempList];
        App *app = [App getInstance];
        NSMutableDictionary *tempDic = [app loadFriendUserIDWithPhoneList:tempList];
        for (int row=0; row<tempList.count; row++) {
            str=[tempList objectAtIndex:row];
            if ([tempDic objectForKey:str]) {
                
                target = [NSDictionary dictionaryWithObjectsAndKeys:
                          [tempDic objectForKey:str],@"userId",nil];
            }
            else
            {
                
                target = [NSDictionary dictionaryWithObjectsAndKeys:
                          str,@"tid",nil];
            }
            [targetList insertObject:target atIndex:targetObj];
            targetObj++;
        }
        sendCount=targetList.count;
        NSLog(@"%@",targetList);
        date=datePicker.date;
        NSTimeInterval time = [date timeIntervalSince1970];
        long long dTime = [[NSNumber numberWithDouble:time*1000] longLongValue]; // 将double转为long long型
        NSString *curTime = [NSString stringWithFormat:@"%llu",dTime]; // 输出long long型
        NSLog(@"%@",curTime);
        NSString *source=@"app";
        Resources *oRes = [Resources getInstance];
        if([message.text length]==0)
        {
            content=[[NSString alloc] initWithFormat:@"" ];
        }
        else
        {
            content=[[NSString alloc] initWithFormat:@"%@",message.text];
        }
        
        
        
        if (loginType==USER_LOGIN_DEMO) {
            if (eventView.hidden==NO) {
                [self addEvent];
            }
            [self MBProgressHUDMessage:[oRes getText:@"map.sendToCarViewController.sendYesAlert"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
        }
        else if(sendCount==0)
        {
            receiveTextView.text=@"";
            [self MBProgressHUDMessage:[oRes getText:@"common.noTextAlert.message"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
        }
        else{
            [receiveTextView resignFirstResponder];
            [message resignFirstResponder];
            cencelBtn.enabled=NO;
            mDisView.hidden=NO;
            self.progressHUD.labelText = [oRes getText:@"sendToCarViewController.sendTitle"];
            self.progressHUD.detailsLabelText = [oRes getText:@"common.load.text"];
            [self.progressHUD show:YES];
            
            double lon=[mlon doubleValue];
            double lat=[mlat doubleValue];
            NSLog(@"%@",mlon);
            NSLog(@"%f",lon);
            para = [NSDictionary dictionaryWithObjectsAndKeys:
                    content,@"content",// 内容
                    source,@"source",// 来源
                    targetList,@"targetList",// 列表
                    nil];
            [mSendToCar createRequest:para eventTime:dTime lon:lon lat:lat event:eventView.hidden poiID:mPoiID poiName:mPoiName poiAddress:mAddress];
            [mSendToCar sendRequestWithAsync:self];
        }
        
    }
}

/*!
 @method addEvent
 @abstract 本地添加事件提醒
 @discussion 本地添加事件提醒
 @param 无
 @result 无
 */
-(void)addEvent
{
    Resources *oRes = [Resources getInstance];
    EKEventStore *eventDB = [[EKEventStore alloc] init];
    if ([eventDB respondsToSelector:@selector(requestAccessToEntityType:completion:)])
    {
        /* iOS Settings > Privacy > Calendars > MY APP > ENABLE | DISABLE */
        [eventDB requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error)
         {
             if ( granted )
             {
                 NSTimeInterval secondsPerTenMin = 10 * 60;
                 NSLog(@"User has granted permission!");
                 EKEvent *myEvent  = [EKEvent eventWithEventStore:eventDB];
                 myEvent.title     = [oRes getText:@"map.sendToCarViewController.eventTitle"] ;
                 myEvent.location  = [NSString stringWithFormat:@"%@%@%@%@ %@%@",[oRes getText:@"map.sendToCarViewController.eventCentent"],mTitle,[oRes getText:@"map.sendToCarViewController.eventCentent2"],mAddress,[oRes getText:@"map.sendToCarViewController.eventCentent3"],content];
                 date=datePicker.date;
                 myEvent.startDate = date;
                 myEvent.endDate   = [NSDate dateWithTimeInterval:10 sinceDate:[date dateByAddingTimeInterval: secondsPerTenMin]];
                 myEvent.allDay = NO;
                 EKAlarm *alarm=[EKAlarm alarmWithRelativeOffset:-10 * 60];
                 [myEvent addAlarm:alarm];
                 myEvent.notes=[oRes getText:@"map.sendToCarViewController.eventNotes"];
                 [myEvent setCalendar:[eventDB defaultCalendarForNewEvents]];
                 NSError *err;
                 if (![eventDB saveEvent:myEvent span:EKSpanThisEvent error:&err]) {
                     NSLog(@"%@",err);
                 }
                 
             }
             else
             {
                 NSLog(@"User has not granted permission!");
             }
         }];
    }
    else
    {
        NSTimeInterval secondsPerTenMin = 10 * 60;
        EKEvent *myEvent  = [EKEvent eventWithEventStore:eventDB];
        myEvent.title     = [oRes getText:@"map.sendToCarViewController.eventTitle"] ;
        
        myEvent.location=[NSString stringWithFormat:@"%@%@%@%@ %@%@",[oRes getText:@"map.sendToCarViewController.eventCentent"],mTitle,[oRes getText:@"map.sendToCarViewController.eventCentent2"],mAddress,[oRes getText:@"map.sendToCarViewController.eventCentent3"],content];
        date=datePicker.date;
        myEvent.startDate = date;
        myEvent.endDate   = [NSDate dateWithTimeInterval:10 sinceDate:[date dateByAddingTimeInterval: secondsPerTenMin]];
        myEvent.allDay = NO;
        EKAlarm *alarm=[EKAlarm alarmWithRelativeOffset:-10 * 60];
        [myEvent addAlarm:alarm];
        
        myEvent.notes=[oRes getText:@"map.sendToCarViewController.eventNotes"];
        [myEvent setCalendar:[eventDB defaultCalendarForNewEvents]];
        NSError *err;
        if (![eventDB saveEvent:myEvent span:EKSpanThisEvent error:&err]) {
            NSLog(@"%@",err);
        }
    }
    [eventDB release];
}

/*!
 @method onResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg
 @abstract 发送到车，回调函数
 @discussion 发送到车，回调函数
 @param result 返回数据
 @param code 返回码
 @param errorMsg 错误信息
 @result 无
 */
- (void)onResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg
{
    
    Resources *oRes = [Resources getInstance];
    //发送成功
    if (code == NAVINFO_RESULT_SUCCESS) {
        if (result==nil) {
            [self MBProgressHUDMessage:[oRes getText:@"map.sendToCarViewController.sendYesAlert"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
            if (eventView.hidden==NO) {
                [self addEvent];
            }
        }
        else
        {
            NSLog(@"%@",result);
            if ([result objectForKey:@"failCount"]) {
                int failCount = [[result objectForKey:@"failCount"] integerValue];
                NSLog(@"%d",failCount);
                //如果发送的数量与失败的数量相同，提示发送失败
                if (sendCount==failCount) {
                    
                    [self MBProgressHUDMessage:[oRes getText:@"map.sendToCarViewController.sendfailAlert"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
                }
                //否则提示失败的人名
                else
                {
                    NSString *str=[NSString stringWithFormat:@""];
                    if ([result objectForKey:@"failFriendUserIdList"] || [result objectForKey:@"failIdentityList"]) {
                        if ([result objectForKey:@"failFriendUserIdList"]) {
                            NSMutableArray *temp =[[NSMutableArray alloc]initWithArray:[result objectForKey:@"failFriendUserIdList"]];
                            NSString *name;
                            NSDictionary *tempDic = [[App getInstance]loadFriendNameWithFriendUserID:temp];
                            for (int i=0; i<temp.count; i++) {
                                name=[tempDic objectForKey:[NSString stringWithFormat:@"%@",[temp objectAtIndex:i]]];
                                if (name) {
                                    str=[NSString stringWithFormat:@"%@,%@",str,name];
                                }
                                
                            }
                            
                            if (temp) {
                                [temp release];
                                temp = nil;
                            }
                        }
                        if ([result objectForKey:@"failIdentityList"]) {
                            NSArray *temp =[[NSArray alloc]initWithArray:[result objectForKey:@"failIdentityList"]];
                            NSString *name;
                            for (int i=0; i<temp.count; i++) {
                                name=[phoneNameDictionary objectForKey:[NSString stringWithFormat:@"%@",[temp objectAtIndex:i]]];
                                if (name) {
                                    str=[NSString stringWithFormat:@"%@,%@",str,name];
                                }
                                else
                                {
                                    str=[NSString stringWithFormat:@"%@,%@",str,[temp objectAtIndex:i]];
                                }
                                
                            }
                            
                            if (temp) {
                                [temp release];
                                temp = nil;
                            }
                        }
                        if (![str isEqualToString:@""]) {
                            str = [str substringFromIndex:1];
                        }
                        NSLog(@"%@",str);
                        NSString *alertCentent=[NSString stringWithFormat:@"%@%d%@%@%@",[oRes getText:@"map.sendToCarViewController.sendAlertCentent1"],sendCount - failCount,[oRes getText:@"map.sendToCarViewController.sendAlertCentent2"],str,[oRes getText:@"map.sendToCarViewController.sendAlertCentent3"] ];
                        [self MBProgressHUDMessage:alertCentent delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
                        if (eventView.hidden==NO) {
                            [self addEvent];
                        }
                    }
                    else
                    {
                        [self MBProgressHUDMessage:[oRes getText:@"map.sendToCarViewController.sendNoAlert"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
                    }
                }
            }
        }
        
    }
    else if(code == NAVINFO_SEND2CAR_SEND_MORETHAN_LIMIT)
    {
        [self MBProgressHUDMessage:[result objectForKey:@"message"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else if(code == NET_ERROR)
    {
        [self MBProgressHUDMessage:[oRes getText:@"common.noNetAlert.message"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else if(code == NAVINFO_TOKENID_INVALID)
    {
        [self MBProgressHUDMessage:[oRes getText:@"common.loseTokenID.message"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else
    {
        [self MBProgressHUDMessage:[oRes getText:@"map.sendToCarViewController.sendNoAlert"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    [self.progressHUD hide:YES];
    mDisView.hidden=YES;
    cencelBtn.enabled=YES;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark Search button methods
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    [searchBar resignFirstResponder];
}

- (BOOL)canBecomeFirstResponder
{
    return NO;
}

#pragma mark -
#pragma mark uiTextView methods
- (void)textViewDidChange:(UITextView *)textView
{
    NSLog(@"shuru");
    eventScrollView.contentOffset = CGPointMake( 0, 0);
    UITextRange *selectedRange = [textView markedTextRange];
    //获取高亮部分
//    UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
//    NSLog(@"position = %@",position);
    NSString * newText = [textView textInRange:selectedRange];
    
    if(textView==message)
    {
        if(newText == nil || [newText isEqualToString:@""])
        {
            if (message.text.length > 80) {
                message.text = [message.text substringToIndex:80];
            }
        }
        if ([message.text isEqualToString:@""] ) {
            messagePlaceholderLabel.hidden = NO;
        }
        else
        {
            messagePlaceholderLabel.hidden = YES;
        }
        textCountLabel.text = [NSString stringWithFormat:@"%d/80",textView.text.length];
    }
    
}


//无用代码
//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    NSString * toBeString = [textView.text stringByReplacingCharactersInRange:range withString:text]; //得到输入框的内容
//    if(textView==message)
//    {
//        if (message.text.length > 80) {
//            message.text = [toBeString substringToIndex:80];
//            return NO;
//        }
//    }
//    return YES;
//}


/*!
 @method keyboardWillHide:(NSNotification *)notification
 @abstract 键盘消失
 @discussion 键盘消失
 @param notification
 @result 无
 */
- (void)keyboardWillHide:(NSNotification *)notification
{
    [eventScrollViewBottom removeFromSuperview];
    eventScrollView.contentSize = CGSizeMake(eventScrollView.frame.size.width, eventScrollView.frame.size.height);
}

/*!
 @method keyboardWillShow:(NSNotification *)notification
 @abstract 键盘弹起
 @discussion 键盘弹起
 @param notification
 @result 无
 */
- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    [eventScrollView addSubview:eventScrollViewBottom];
    eventScrollView.contentSize = CGSizeMake(eventScrollView.frame.size.width, eventScrollView.frame.size.height+keyboardSize.height);
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
