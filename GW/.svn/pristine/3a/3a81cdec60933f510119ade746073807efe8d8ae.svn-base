


/*!
 @header MaintenanceAlertInformDetailViewController.m
 @abstract 保养提醒详情界面
 @author mengy
 @version 1.00 14-9-3 Creation
 */
#import "MaintenanceAlertInformDetailViewController.h"
#import "MaintenanceAlertInformViewController.h"
@interface MaintenanceAlertInformDetailViewController ()
{
    
    NSString *keyID;
    UIBarButtonItem *leftBarBtn;
    
    MaintenanceAlertInformMessageData *mData;
}
@end

@implementation MaintenanceAlertInformDetailViewController

- (void)dealloc
{
    
    if (backBtn) {
        [backBtn release];
        backBtn = nil;
    }
    
    if (leftBarBtn) {
        [leftBarBtn release];
        leftBarBtn = nil;
    }
    [timeTitleLabel release]; timeTitleLabel = nil;
    [carNumTitleLabel release]; carNumTitleLabel = nil;
    [mileageTitleLabel release]; mileageTitleLabel = nil;
    [timeLabel release]; timeLabel = nil;
    [carNumLabel release]; carNumLabel = nil;
    [mileageLabel release]; mileageLabel = nil;
    [explainTitleLabel release]; explainTitleLabel = nil;
    [explainTextView release]; explainTextView = nil;
    [itemsTitleLabel release]; itemsTitleLabel = nil;
    [itemsTextView release]; itemsTextView = nil;
    [titleLabel release],titleLabel = nil;
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
    backBtn = [[LeftButton alloc]init];
    [backBtn addTarget:self action:@selector(popself) forControlEvents:UIControlEventTouchUpInside];
    leftBarBtn = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
    
    Resources *oRes = [Resources getInstance];
    
    mCherryDBControl = [CherryDBControl sharedCherryDBControl];
    mData = [mCherryDBControl loadMaintenanceAlertByKeyID:keyID];
//    titleLabel.text=[oRes getText:@"message.MaintenanceAlertInformDetailViewController.Title"];
//    titleLabel.font =[UIFont navBarTitleSize];
//    titleLabel.textColor=[UIColor whiteColor];
//    self.navigationItem.titleView=titleLabel;
    
    self.navigationItem.title = [oRes getText:@"message.MaintenanceAlertInformDetailViewController.Title"];
    
    timeTitleLabel.text = [oRes getText:@"message.MaintenanceAlertInformDetailViewController.timeTitle"];
    carNumTitleLabel.text = [oRes getText:@"message.MaintenanceAlertInformDetailViewController.carNumTitle"];
    mileageTitleLabel.text = [oRes getText:@"message.MaintenanceAlertInformDetailViewController.mileageTitle"];
    explainTitleLabel.text = [oRes getText:@"message.MaintenanceAlertInformDetailViewController.explainTitle"];
    itemsTitleLabel.text = [oRes getText:@"message.MaintenanceAlertInformDetailViewController.itemsTitle"];
    timeTitleLabel.font = [UIFont size15];
    carNumTitleLabel.font = [UIFont size15];
    mileageTitleLabel.font = [UIFont size15];
    explainTitleLabel.font = [UIFont size15];
    itemsTitleLabel.font = [UIFont size15];
    
    timeLabel.font = [UIFont size15];
    carNumLabel.font = [UIFont size15];
    mileageLabel.font = [UIFont size15];
    explainTextView.font = [UIFont size15];
    itemsTextView.font = [UIFont size15];
    timeTitleLabel.textColor = [UIColor colorWithRed:27.0/255.0f green:27.0/255.0f blue:27.0/255.0f alpha:1];
    carNumTitleLabel.textColor = [UIColor colorWithRed:27.0/255.0f green:27.0/255.0f blue:27.0/255.0f alpha:1];
    mileageTitleLabel.textColor = [UIColor colorWithRed:27.0/255.0f green:27.0/255.0f blue:27.0/255.0f alpha:1];
    explainTitleLabel.textColor = [UIColor colorWithRed:27.0/255.0f green:27.0/255.0f blue:27.0/255.0f alpha:1];
    itemsTitleLabel.textColor = [UIColor colorWithRed:27.0/255.0f green:27.0/255.0f blue:27.0/255.0f alpha:1];
    
    
    timeLabel.textColor = [UIColor colorWithRed:129.0/255.0f green:129.0/255.0f blue:129.0/255.0f alpha:1];
    carNumLabel.textColor = [UIColor colorWithRed:129.0/255.0f green:129.0/255.0f blue:129.0/255.0f alpha:1];
    mileageLabel.textColor = [UIColor colorWithRed:129.0/255.0f green:129.0/255.0f blue:129.0/255.0f alpha:1];
    explainTextView.textColor = [UIColor colorWithRed:129.0/255.0f green:129.0/255.0f blue:129.0/255.0f alpha:1];
    itemsTextView.textColor = [UIColor colorWithRed:129.0/255.0f green:129.0/255.0f blue:129.0/255.0f alpha:1];
    
    [self initMessage];
    self.view.backgroundColor = [UIColor colorWithRed:231.0/255.0f green:231.0/255.0f blue:231.0/255.0f alpha:1];
    
}


/*!
 @method initMessage
 @abstract 初始化消息数据
 @discussion 初始化消息数据
 @param 无
 @result 无
 */
-(void)initMessage
{
    //本地获取数据
    
    Resources *oRes = [Resources getInstance];
    timeLabel.text = [App getDateWithTimeSince1970:mData.mMaintainTime];
    carNumLabel.text = [[App getInstance] searchCarNum:mData.mMessageKeyID];
    mileageLabel.text = [NSString stringWithFormat:@"%@ %@",mData.mMaintainMileage,[oRes getText:@"message.MaintenanceAlertInformViewController.mileage"]];
    explainTextView.text = mData.mDescription;
    itemsTextView.text = mData.mMaintainItems;
    
}


/*!
 @method setKeyID:(NSString *)keyid
 @abstract 设置keyid
 @discussion 设置keyid
 @param keyid
 @result 无
 */
-(void)setKeyID:(NSString *)keyid
{
    keyID=keyid;
}

/*!
 @method popself
 @abstract 返回上个界面
 @discussion 返回上个界面
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


@end

