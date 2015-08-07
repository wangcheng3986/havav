/*!
 @header VehicleDiagnosisViewController.m
 @abstract 车辆在线诊断主控界面
 @author wangqiwei
 @version 1.00 2014/9/1 Create
 */

#import "VehicleDiagnosisInformDetailViewController.h"
#import "App.h"
#import "DiagnosisReportItemData.h"

#define POWERSYSTEM      @"powerSystem"
#define CHASSIS          @"chassis"
#define ELECTRONICSYSTEM @"electronicSystem"
#define AUTOMATICSYSTEM  @"autoMaticSystem"
static VehicleDiagnosisInformDetailViewController *vehicleDiagnosisInformDetailViewController = nil;
@interface VehicleDiagnosisInformDetailViewController ()
{
    NSMutableDictionary *ReportItemDataDic;
    int countAll;
    
    
    UIBarButtonItem *leftBarBtn;

}
@end

@implementation VehicleDiagnosisInformDetailViewController

@synthesize messageKeyID;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //add for mengy
    
    backBtn = [[LeftButton alloc]init];
    [backBtn addTarget:self action:@selector(popself) forControlEvents:UIControlEventTouchUpInside];
    leftBarBtn = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
    if([App getVersion]>=IOS_VER_7){
        [App ios7ViewLocation:self];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_ios7_navBar_bg"] forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_ios6_navBar_bg"] forBarMetrics:UIBarMetricsLandscapePhone];
    }
    
    self.view.backgroundColor = [UIColor colorWithRed:231.0/255.0f green:231.0/255.0f blue:231.0/255.0f alpha:1];
    
    //end
    
    
    
    
    
    
     Resources *oRes =[Resources getInstance];
    self.diagnosisDataAll = [[NSMutableArray alloc]initWithCapacity:0];
    self.titleArray = [[NSMutableArray alloc]initWithCapacity:0];
    self.subdiagnosisDataTemp = [[NSMutableArray alloc]initWithCapacity:0];
    ReportItemDataDic = [[NSMutableDictionary alloc] initWithCapacity:0];
   
    self.expandedIndexes = [[NSMutableDictionary alloc] init];

    self.subCellNumInGroup = [[NSMutableDictionary alloc] init];

    DiagnosisTimeTitle.text = [oRes getText:@"Car.vehicleDiagnosisViewController.DiagnosisTimeTitle"];
    DiagnosisNumTitle.text =[oRes getText:@"Car.vehicleDiagnosisViewController.DiagnosisNumber"];


    [self loadData];
    
    AllTableView.backgroundColor = [UIColor clearColor];
    AllTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    
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

- (void)loadData
{
    //数据库初始化
        countAll= 0;
    App *app = [App getInstance];
    
    //add for mengy
    CherryDBControl *cherryDBControl = [CherryDBControl sharedCherryDBControl];
    VehicleDiagnosisInformMessageData* InformMessageData =  [cherryDBControl loadVehicleDiagnosisMessageByKeyID:messageKeyID];
    //title
    Resources *oRes = [Resources getInstance];
    int typeCode = [InformMessageData.mRepertType intValue];
    switch (typeCode) {
        case VEHICLE_DIAGNOSIS_TYPE_ONLINE:
//            titleLabel.text = [oRes getText:@"message.VehicleDiagnosisInformViewController.online"];
            self.navigationItem.title=[oRes getText:@"message.VehicleDiagnosisInformViewController.online"];
            break;
        case VEHICLE_DIAGNOSIS_TYPE_PERIODIC:
//            titleLabel.text = [oRes getText:@"message.VehicleDiagnosisInformViewController.periodic"];
            self.navigationItem.title=[oRes getText:@"message.VehicleDiagnosisInformViewController.periodic"];
            break;
        case VEHICLE_DIAGNOSIS_TYPE_AUTO:
//            titleLabel.text = [oRes getText:@"message.VehicleDiagnosisInformViewController.auto"];
            self.navigationItem.title=[oRes getText:@"message.VehicleDiagnosisInformViewController.auto"];
            break;
        default:
            break;
    }
//    titleLabel.font =[UIFont navBarTitleSize];
//    titleLabel.textColor=[UIColor whiteColor];
//    self.navigationItem.titleView=titleLabel;
    
    
    //end
    
    
    
    int checkResult = [InformMessageData.mCheckResult intValue];
//    checkResult = 2;
    //0:无故障；1：有故障；2：诊断失败
    if (checkResult == 0 || checkResult == 1)
    {
        NSMutableArray *checkItemTypeArray = [cherryDBControl selectWithReportID:InformMessageData.mRepertId];
        NSInteger  reportIDcount = [checkItemTypeArray count];
        for (int index = 0; index < reportIDcount; index++)
        {
            
            NSMutableArray *ReportItemDataArray = [cherryDBControl selectWithReportID:InformMessageData.mRepertId checkItemType:checkItemTypeArray[index]];
            [self.diagnosisDataAll addObject:ReportItemDataArray];
            
        }
        NSLog(@"%d",[self.diagnosisDataAll count]);
        
        
        
        //UI数据初始化
        NSInteger diagnosisDataAllCount = [self.diagnosisDataAll count];
        
        for (int index = 0; index < diagnosisDataAllCount ; index++)
        {
            NSArray *tempArray = [self.diagnosisDataAll objectAtIndex:index];
            NSInteger tempArrayCount = [tempArray count];
            DiagnosisReportItemData *ReportItemData = [tempArray objectAtIndex:0];
            if (tempArrayCount >1)
            {
                countAll = countAll + tempArrayCount;
            }
            else
            {
                if(![ReportItemData.mFaultItemId isEqualToString:@""])
                {
                    countAll += 1;
                }
            }
            
            
            
            NSMutableString *str = [NSMutableString stringWithString:@"检查项："];
            [str appendString:ReportItemData.mCheckItemTypeName];
            [self.titleArray addObject:str];
        }
        footView.backgroundColor = [UIColor whiteColor];
        AllTableView.hidden = NO;//隐藏主表格tableView
        DiagnosisFailureBG.hidden = YES;
        DiagnosisFailureCarBG.hidden = YES;
        DiagnosisTextFailureOrNull.hidden = YES;
        DiagnosisFailureLeftIcon.hidden = YES;
        DiagnosisFailureTextBG.hidden = YES;

        NSLog(@"%d",[self.titleArray count]);
    }
    

    
    //诊断失败
    if (checkResult == 2)
    {
        DiagnosisNumContent.text = @"诊断失败";//
        DiagnosisNumContent.textColor = [UIColor redColor];
        AllTableView.hidden = YES;//隐藏主表格tableView
        footView.backgroundColor = [UIColor colorWithRed:231.0/255.0f green:231.0/255.0f blue:231.0/255.0f alpha:1];
        DiagnosisTextFailureOrNull.text = @"故障诊断失败";
        
        DiagnosisFailureBG.hidden = NO;
        DiagnosisFailureCarBG.hidden = NO;
        DiagnosisTextFailureOrNull.hidden = NO;
        DiagnosisFailureLeftIcon.hidden = NO;
        DiagnosisFailureTextBG.hidden = NO;
        
    }
    else
    {
        if (countAll == 0)
        {
            DiagnosisNumContent.text = @"无故障";//
            DiagnosisNumContent.textColor = [UIColor colorWithRed:45.0/255.0f green:147.0/255.0f blue:0.0/255.0f alpha:1];
        }
        else
        {
           // DiagnosisNumContent.text = [NSString stringWithFormat:@"%d",countAll];//故障总数
            DiagnosisNumContent.text = @"有故障";
            DiagnosisNumContent.textColor = [UIColor redColor];
        }
    }
    

    //诊断时间
    if ([self.diagnosisDataAll count] == 0)
    {
        DiagnosisTimeContent.text = @"---";
    }
    else
    {
        NSDate *uploadTime = [NSDate dateWithTimeIntervalSince1970:[InformMessageData.mCheckTime doubleValue]/1000];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *date=[dateFormatter stringFromDate:uploadTime];
        DiagnosisTimeContent.text = date;
        [dateFormatter release];
    }
    
    
    /**
    //适配iphone4S
    enum SCREEN_SIZE   deviceSize = [App getScreenSize];
    if (deviceSize == SCREEN_SIZE_960_640)
    {
        DiagnosisFailureBG.frame = CGRectMake(DiagnosisFailureBG.frame.origin.x, DiagnosisFailureBG.frame.origin.y+60, DiagnosisFailureBG.frame.size.width, DiagnosisFailureBG.frame.size.height-60);
        
        DiagnosisFailureCarBG.frame = CGRectMake(DiagnosisFailureCarBG.frame.origin.x, DiagnosisFailureCarBG.frame.origin.y-30, DiagnosisFailureCarBG.frame.size.width, DiagnosisFailureCarBG.frame.size.height);
        
        DiagnosisFailureTextBG.frame = CGRectMake(DiagnosisFailureTextBG.frame.origin.x, DiagnosisFailureTextBG.frame.origin.y-30, DiagnosisFailureTextBG.frame.size.width, DiagnosisFailureTextBG.frame.size.height);
        
        DiagnosisFailureLeftIcon.frame = CGRectMake(DiagnosisFailureLeftIcon.frame.origin.x, DiagnosisFailureLeftIcon.frame.origin.y-30, DiagnosisFailureLeftIcon.frame.size.width, DiagnosisFailureLeftIcon.frame.size.height);
        
        DiagnosisTextFailureOrNull.frame = CGRectMake(DiagnosisTextFailureOrNull.frame.origin.x, DiagnosisTextFailureOrNull.frame.origin.y-30, DiagnosisTextFailureOrNull.frame.size.width, DiagnosisTextFailureOrNull.frame.size.height);
    }
    */


}


#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [self.titleArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *number;
    static NSString* identifier = @"AlltableView";
    GroupCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GroupCell" owner:self options:nil]lastObject];
    }
    cell.groupCellTitle.text = self.titleArray[indexPath.row];
    [cell getmain:self];
    
    
    NSArray* subdiagnosisData = [self.diagnosisDataAll objectAtIndex:indexPath.row];
    
    NSInteger subCount = [subdiagnosisData count];
    
    DiagnosisReportItemData *ReportItemData = [subdiagnosisData objectAtIndex:0];
    if (subCount == 1 && [ReportItemData.mFaultItemId isEqualToString:@""])
    {
        cell.groupCellFaultNum.text = @"无故障";
        cell.groupCellFaultNum.textColor = [UIColor colorWithRed:45.0/255.0f green:147.0/255.0f blue:0.0/255.0f alpha:1];
        cell.expandedImage.image = [UIImage imageNamed:@"car_diagnosis_check_icon"];
    }
    else
    {
        cell.groupCellFaultNum.text = [NSString stringWithFormat:@"%d个故障",subCount];
        cell.subCellNumber = subCount;
    }


    if (subCount == 1 && [ReportItemData.mFaultItemId isEqualToString:@""])
    {
        subCount = 0;
        number = [NSNumber numberWithInt:subCount];//封装真实数据
    }
    else
    {
        number = [NSNumber numberWithInt:subCount];//封装真实数据
    }
    NSString *keyStr = [NSString stringWithFormat:@"%d",indexPath.row];
    [_subCellNumInGroup setObject:number forKey:keyStr];
    
    [ReportItemDataDic setObject:subdiagnosisData forKey:keyStr];
    //先移除subCell上次描画的数据，然后存入本次需要描画的数据
    //表格绘制的顺序：先绘制外面大标题的表格，再绘制本次大标题表格内部存在的subcell
    [self.subdiagnosisDataTemp removeAllObjects];
    [self.subdiagnosisDataTemp addObjectsFromArray:[ReportItemDataDic objectForKey:keyStr]];


    return  cell;
}


- (SubCell *)item:(GroupCell *)groupCell setSubItem:(SubCell *)subCell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"_________________>>>>>%d",indexPath.row);
    DiagnosisReportItemData *ReportItemData = [self.subdiagnosisDataTemp objectAtIndex:indexPath.row];
    subCell.subCellTitle.text = [NSString stringWithString:ReportItemData.mFaultItemName];
    subCell.subCellContent.text = [NSString stringWithString:ReportItemData.mFaultItemDesc];;
    
    
    return subCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *keyStr = [NSString stringWithFormat:@"%d",indexPath.row];
    int number =[[_subCellNumInGroup objectForKey:keyStr] intValue];
    
    if ([[_expandedIndexes objectForKey:keyStr] boolValue])
    {
        return [GroupCell getGroupCellHeight]+[GroupCell getSubCellHeight]*number;
    }
    else
    {
        
        return [GroupCell getGroupCellHeight];
    }
    
    
}
//
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GroupCell *cell = (GroupCell *)[tableView cellForRowAtIndexPath:indexPath];
     NSString *keyStr = [NSString stringWithFormat:@"%d",indexPath.row];
    //每次点击大标题，都清理一次数据缓存
    [self.subdiagnosisDataTemp removeAllObjects];
    [self.subdiagnosisDataTemp addObjectsFromArray:[ReportItemDataDic objectForKey:keyStr]];

    DiagnosisReportItemData *ReportItemData = [[ReportItemDataDic objectForKey:keyStr]objectAtIndex:0];
   
    int number = [[_subCellNumInGroup objectForKey:keyStr] intValue];
	BOOL isExpanded = ![[_expandedIndexes objectForKey:keyStr] boolValue];
    NSLog(@"%d",indexPath.row);
    NSLog(@"%@",indexPath);
	NSNumber *expandedIndex = [NSNumber numberWithBool:isExpanded];
    if (isExpanded == YES && number != 0 && ![ReportItemData.mFaultItemId isEqualToString:@""])
    {
        
        cell.expandedImage.image = [UIImage imageNamed:@"car_diagnosis_list_expand_icon_on"];
    }
    else if(isExpanded == NO && number != 0 && ![ReportItemData.mFaultItemId isEqualToString:@""])
    {
        cell.expandedImage.image = [UIImage imageNamed:@"car_diagnosis_list_expand_icon_off"];
    }
    else
    {
        cell.expandedImage.image = [UIImage imageNamed:@"car_diagnosis_check_icon"];
    }
	[_expandedIndexes setObject:expandedIndex forKey:keyStr];
    [AllTableView beginUpdates];
    [AllTableView endUpdates];
}

#pragma mark - system
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:Notification_New_VehicleDiagnosis object:nil];
    [_titleArray release];
    [_subContentDic release];
    [_expandedIndexes release];
    [_subCellNumInGroup release];
    [_diagnosisDataAll release];
    [_subdiagnosisDataTemp release];
    [ReportItemDataDic release];
    
    [AllTableView release];
    [headerBG release];
    [headerIcon release];
    [DiagnosisTimeTitle release];
    [DiagnosisNumTitle release];
    [DiagnosisTimeContent release];
    [DiagnosisNumContent release];
    
    if (self.progressHUD){
        [self.progressHUD removeFromSuperview];
        [self.progressHUD release];
        self.progressHUD = nil;
    }
    [DiagnosisFailureBG release];
    [footView release];
    [DiagnosisTextFailureOrNull release];
    [DiagnosisFailureCarBG release];
    [DiagnosisFailureLeftIcon release];
    [DiagnosisFailureTextBG release];
    [super dealloc];
}
- (void)viewDidUnload {

    [AllTableView release];
    AllTableView = nil;
    [headerBG release];
    headerBG = nil;
    [headerIcon release];
    headerIcon = nil;
    [DiagnosisTimeTitle release];
    DiagnosisTimeTitle = nil;
    [DiagnosisNumTitle release];
    DiagnosisNumTitle = nil;
    [DiagnosisTimeContent release];
    DiagnosisTimeContent = nil;
    [DiagnosisNumContent release];
    DiagnosisNumContent = nil;
    [DiagnosisFailureBG release];
    DiagnosisFailureBG = nil;
    [footView release];
    footView = nil;
    [DiagnosisTextFailureOrNull release];
    DiagnosisTextFailureOrNull = nil;
    [DiagnosisFailureCarBG release];
    DiagnosisFailureCarBG = nil;
    [DiagnosisFailureLeftIcon release];
    DiagnosisFailureLeftIcon = nil;
    [DiagnosisFailureTextBG release];
    DiagnosisFailureTextBG = nil;
    [super viewDidUnload];
}
@end
