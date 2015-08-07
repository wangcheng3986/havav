/*!
 @header ElecFenceDetailViewController.m
 @abstract 电子围栏详情界面
 @author wangqiwei
 @version 1.00 2014/9/1 Create
 */
#import "ElecFenceDetailViewController.h"
#import "App.h"
#import "ReturnButton.h"
#import "SaveButton.h"
#import "CherryDBControl.h"
#import "ElecFenceViewController.h"
#import "MapPoiData.h"

#define kNum @"0123456789"
@interface ElecFenceDetailViewController ()
{
 //   MapViewController *mapController;
    int validState;
    int selectYesState;
    int selectNoState;
    ElecFenceViewController *elecFenceView;
    CherryDBControl *cherryDBControl;
    ElecFenceData *mElecFenceData;
    int elecFlag;
    BOOL isCreate;
    double mlon;
    double mlat;
    NICustomPoi *elecPOI;
    CarData *mCarData;
    
    IBOutlet CustomMapView* _mapView;
    //长按大头针
    NIPointAnnotation* pointAnnotation;
    //气泡
    NIActionPaopaoAnnotation* ppAnnotation;
    NIAnnotationView* _viewPoint;
    NIAnnotationView* viewPaopao;
    //圆形覆盖物
    NICircle* circle;
    
}
@end

@implementation ElecFenceDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)releasePoint
{
    if (pointAnnotation)
    {
        [_mapViewBase.mapViewShare.mapView removeAnnotation:pointAnnotation];
        [pointAnnotation release];
        pointAnnotation = nil;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    validState = 0;
    selsecNoButton.selected = YES;
    selsecButton.selected = NO;
    elecFenceView = [[ElecFenceViewController alloc]init];
    elecFenceAddNetManager = [[ElecFenceAddNetManager alloc] init];
    
    Resources *oRes = [Resources getInstance];
    self.navigationItem.title = [oRes getText:@"Car.ElecFenceDetailViewController.title"];
    
    ReturnButton* _returnBt = [[ReturnButton alloc]init];
    [_returnBt addTarget:self action:@selector(returnHome)forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_returnBt];
    [_returnBt release];
    
    SaveButton* _saveBt = [[SaveButton alloc]init];
    [_saveBt addTarget:self action:@selector(save)forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_saveBt];
    [_saveBt release];
    
    [self setMapView:_mapView];
    [self loadMapBaseParameter];
    
    MonitorRadius.text = [oRes getText:@"Car.ElecFenceDetailViewController.MonitorRadius"];
    effectTitle.text = [oRes getText:@"Car.ElecFenceDetailViewController.effectTitle"];
    address.text = [oRes getText:@"Car.ElecFenceDetailViewController.address"];
    _placeHolder.text = [oRes getText:@"Car.ElecFenceViewController.placeHolder"];
    radiusUnit.text = [oRes getText:@"Car.ElecFenceViewController.radiusUnit"];

    adressText.editable = NO;
    
    
    
    textFieldRadius.delegate = self;
    textFieldRadius.keyboardType = UIKeyboardTypeNumberPad;
    textFieldRadius.returnKeyType = UIReturnKeyDone;
    
    
    [selsecButton setBackgroundImage:[UIImage imageNamed:@"car_elecfence_radio_false"] forState:UIControlStateNormal];
    [selsecButton setBackgroundImage:[UIImage imageNamed:@"car_elecfence_radio_true"] forState:UIControlStateSelected];
    
    [selsecNoButton setBackgroundImage:[UIImage imageNamed:@"car_elecfence_radio_false"] forState:UIControlStateNormal];
    [selsecNoButton setBackgroundImage:[UIImage imageNamed:@"car_elecfence_radio_true"] forState:UIControlStateSelected];
    
    if (elecFlag == 0)//新建电子围栏 初始化参数
    {
        textFieldRadius.text = @"15";
        selsecButton.selected =NO;
        adressText.text = @"";

    }
    else//通过cell点击进入
    {
        textFieldRadius.text = [NSString stringWithFormat:@"%d",mElecFenceData.radius];
        int valid = [mElecFenceData.valid intValue];
        if (valid == 0) {
            selsecButton.selected =NO;
            selsecNoButton.selected = YES;
        } else {
            selsecButton.selected =YES;
            selsecNoButton.selected = NO;
        }
        adressText.text = mElecFenceData.address;
        

        _placeHolder.hidden =YES;
    }
    
    //显示加载等待框
    self.progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.progressHUD];
    [self.view bringSubviewToFront:self.progressHUD];
    self.progressHUD.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(databack) name:@"databack" object:nil];
    
    
    
}


-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    [UIMenuController sharedMenuController].menuVisible = NO;
    [textFieldRadius resignFirstResponder];
    return NO;
}



- (void)setElecFenceData:(ElecFenceData *)elecFenceData flag:(int)flag
{
    mElecFenceData = elecFenceData;
    elecFlag =flag;
    isCreate = YES;
}

- (void)setPOIadress:(NSString *)POIadress
{
    self.POIadress = POIadress;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [textFieldRadius resignFirstResponder];
}
#pragma mark - netDelegate
/*!
 @method onElecFenceAddResult
 @abstract 添加电子围栏回调函数
 @discussion 添加电子围栏回调函数
 @result 无
 */

- (void)onElecFenceAddResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg
{
    NSLog(@"receive the result of add elecFence.");
    [self.progressHUD hide:YES];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    Resources *oRes = [Resources getInstance];
    App *app = [App getInstance];
    if (NAVINFO_RESULT_SUCCESS == code)
    {
        if (nil != result)
        {
            NSLog(@"result is :%@", result);
            if([result valueForKey:@"elecFence"])
            {
                NSString *elecFenceID = [[result valueForKey:@"elecFence"]objectForKey:@"id"];
                NSString *name  = [[result valueForKey:@"elecFence"]objectForKey:@"name"];
                NSString *lastUpdate =[[result valueForKey:@"elecFence"]objectForKey:@"lastUpdate"];
                NSString *valid = [[result valueForKey:@"elecFence"]objectForKey:@"valid"];
                NSString *lon = [[result valueForKey:@"elecFence"]objectForKey:@"lon"];
                NSString *lat = [[result valueForKey:@"elecFence"]objectForKey:@"lat"];
                NSString *radius = [[result valueForKey:@"elecFence"]objectForKey:@"radius"];
                NSString *description = [[result valueForKey:@"elecFence"]objectForKey:@"description"];
                if (description ==nil) {
                    description = @"";
                }
                NSString *elecAddress = [[result valueForKey:@"elecFence"]objectForKey:@"address"];
                
                if ( [valid intValue] == 1)
                {
                    [cherryDBControl updateElecFenceWithValid:@"0" vin:app.mCarData.mVin];
                }
                
                
                
                //与服务器交互
                App *app = [App getInstance];
                mCarData=[app getCarData];
                cherryDBControl = [CherryDBControl sharedCherryDBControl];//二期专用数据控制单例
                //此处的keyID用uuid来填充
                NSString *uuid = [App createUUID];

                //插入数据库
                BOOL result = [cherryDBControl addElecFenceWithKeyid:uuid ID:elecFenceID name:name lastUpdate:lastUpdate valid:valid lon:[lon doubleValue] lat:[lat doubleValue] radius:[radius intValue] description:description address:elecAddress vin:mCarData.mVin userKeyID:app.loginID];
                if (result)
                {
                   [self MBProgressHUDMessage:[oRes getText:@"Car.ElecFence.alert.addSuccess"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
                }
                else
                {
                    [self MBProgressHUDMessage:[oRes getText:@"Car.ElecFence.alert.addFailure"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
                }
                
            }
            else
            {
                [self MBProgressHUDMessage:[oRes getText:@"Car.ElecFence.alert.addFailure"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
            }
            
        }
    }
    else if (NAVINFO_ELEC_NUM_EXIST == code)//此车辆已经存在3个电子围栏
    {
        
        [self MBProgressHUDMessage:[oRes getText:@"Car.ElecFence.alert.num"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];

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
         [self MBProgressHUDMessage:[oRes getText:@"Car.ElecFence.alert.addFailure"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];

    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

/*!
 @method onElecFenceModifyResult
 @abstract 修改电子围栏回调函数
 @discussion 修改电子围栏回调函数
 @result 无
 */

- (void)onElecFenceModifyResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg
{
    NSLog(@"receive the result of update elecFence.");
    [self.progressHUD hide:YES];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    Resources *oRes = [Resources getInstance];
    App *app = [App getInstance];
    if (NAVINFO_RESULT_SUCCESS == code)
    {
        if (nil != result)
        {
            NSLog(@"result is :%@", result);
            if([result valueForKey:@"elecFence"])
            {
                NSString *elecFenceID = [[result valueForKey:@"elecFence"]objectForKey:@"id"];
                NSString *name  = [[result valueForKey:@"elecFence"]objectForKey:@"name"];
                NSString *lastUpdate =[[result valueForKey:@"elecFence"]objectForKey:@"lastUpdate"];
                NSString *valid = [[result valueForKey:@"elecFence"]objectForKey:@"valid"];
                NSString *lon = [[result valueForKey:@"elecFence"]objectForKey:@"lon"];
                NSString *lat = [[result valueForKey:@"elecFence"]objectForKey:@"lat"];
                NSString *radius = [[result valueForKey:@"elecFence"]objectForKey:@"radius"];
                NSString *description = [[result valueForKey:@"elecFence"]objectForKey:@"description"];
                if (description ==nil) {
                    description = @"";
                }
                NSString *elecAddress = [[result valueForKey:@"elecFence"]objectForKey:@"address"];
                
                if ( [valid intValue] == 1)
                {
                    [cherryDBControl updateElecFenceWithValid:@"0" vin:app.mCarData.mVin];
                }
  
                //与服务器交互
                App *app = [App getInstance];
                mCarData=[app getCarData];
                cherryDBControl = [CherryDBControl sharedCherryDBControl];//二期专用数据控制单例
                
                //更新数据库
                BOOL result = [cherryDBControl updateElecFenceWithID:elecFenceID name:name lastUpdate:lastUpdate valid:valid lon:[lon doubleValue] lat:[lat doubleValue] radius:[radius intValue] description:description address:elecAddress vin:mCarData.mVin];
                if (result)
                {
                    [self MBProgressHUDMessage:[oRes getText:@"Car.ElecFence.alert.modifySuccess"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
                }
                else
                {
                    [self MBProgressHUDMessage:[oRes getText:@"Car.ElecFence.alert.modifyFailure"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
                }
            }
            else
            {
                [self MBProgressHUDMessage:[oRes getText:@"Car.ElecFence.alert.modifyFailure"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
            }
            
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
        NSLog(@"Errors on reveice result.");
        [self MBProgressHUDMessage:[oRes getText:@"Car.ElecFence.alert.addFailure"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - buttonDelegate
- (void)returnHome
{
    [self.navigationController popViewControllerAnimated:YES];
}
/*!
 @method carButton
 @abstract 自车定位按钮
 @discussion 自车定位按钮
 @result 无
 */
- (IBAction)carButton:(id)sender
{
    [self removeLongclickPoint];
    [self releasePaopao];
     App *app = [App getInstance];
    Resources *oRes = [Resources getInstance];
    double dLon = [app.mCarData.mLon doubleValue];
    double dLat = [app.mCarData.mLat doubleValue];
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = dLat;
    coordinate.longitude = dLon;
    if (pointAnnotation == nil) {
        pointAnnotation = [[NIPointAnnotation alloc]initWithMapView:_mapViewBase.mapViewShare.mapView];
        pointAnnotation.coordinate = coordinate;
        mlon = coordinate.longitude;
        mlat = coordinate.latitude;
        pointAnnotation.title = [NSString stringWithFormat:@"%@(%@)",[oRes getText:@"friend.FriendDetailViewController.selfLocationTitle"],app.mCarData.mCarNumber];
        [_mapViewBase.mapViewShare.mapView addAnnotation:pointAnnotation];
        
    }
    
    [self LaunchSearcher:coordinate];
    
    NIMapStatus *ptemp = [[NIMapStatus alloc]init];
    ptemp.fLevel = _mapViewBase.mapViewShare.mapView.mapStatus.fLevel;
    ptemp.targetGeoPt = coordinate;
    ptemp.fRotation = _mapViewBase.mapViewShare.mapView.mapStatus.fRotation;
    //动画移动到中心点
    [_mapViewBase.mapViewShare.mapView setMapStatus:ptemp withAnimation:YES];
    [ptemp release];

    [self removeCircle];
    [self addOverlayView:coordinate radius:[textFieldRadius.text intValue]*1000];
}

/*!
 @method save
 @abstract 保存或修改电子围栏按钮事件
 @discussion 保存或修改电子围栏按钮事件
 @result 无
 */

- (void)save
{
    App *app = [App getInstance];
    Resources *oRes = [Resources getInstance];


    if ([adressText.text  isEqualToString:@""] || [textFieldRadius.text isEqualToString:@""])
    {
        if ([adressText.text  isEqualToString:@""])
        {
            [self MBProgressHUDMessage:[oRes getText:@"Car.ElecFenceDetailViewController.setTitle"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
        }
        else
        {
            [self MBProgressHUDMessage:[oRes getText:@"Car.ElecFenceDetailViewController.numberError"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
        }
        
    }
    else if([adressText.text isEqualToString:[oRes getText:@"Car.ElecFenceViewController.addressInfo"]])
    {
        [self MBProgressHUDMessage:[oRes getText:@"Car.ElecFenceViewController.addressInfo"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else if ([textFieldRadius.text intValue] == 0)//输入不能为0
    {
        [self MBProgressHUDMessage:[oRes getText:@"Car.ElecFenceDetailViewController.numberError"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else if ([[textFieldRadius.text substringToIndex:1]intValue] == 0)//输入不能0开头
    {
        [self MBProgressHUDMessage:[oRes getText:@"Car.ElecFenceDetailViewController.numberError"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else
    {
        cherryDBControl = [CherryDBControl sharedCherryDBControl];
        if (app.mUserData.mType == USER_LOGIN_DEMO)
        {
            
            
                self.elecFenceList =[cherryDBControl selectWithVin:@"demo_vin"];

                NSMutableArray *elecFenceDic = [cherryDBControl selectWithvin:mElecFenceData.vin elecFenceId:mElecFenceData.elecFenceId];
                if (nil != elecFenceDic)
                {
                    BOOL result =  [cherryDBControl updateElecFenceWithID:mElecFenceData.elecFenceId name:mElecFenceData.name lastUpdate:mElecFenceData.lastUpdate valid:[NSString stringWithFormat:@"%d",validState] lon:mlon lat:mlat radius:[textFieldRadius.text intValue]  description:mElecFenceData.description address:adressText.text vin:mElecFenceData.vin];
                    
                    if (result) {
                        [self MBProgressHUDMessage:[oRes getText:@"Car.ElecFence.alert.modifySuccess"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
                        NSLog(@"modify 成功");
                    } else {
                        NSLog(@"modify 失败");
                    }
                }
                else
                {
                    int count = [self.elecFenceList count];
                    if (count > 2)
                    {
                        [self MBProgressHUDMessage:[oRes getText:@"Car.ElecFenceDetailViewController.newElecFailure"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
                        
                    }
                    else
                    {
                        NSString *vin = @"demo_vin";
                        NSString *elecID = [NSString stringWithFormat:@"%d",(arc4random() % 5)];
                        
                        NSString *keyID = [App createUUID];
                        double lon = mlon;
                        double lat = mlat;
                        
                        int radius = [textFieldRadius.text intValue];
                        NSString *valid = [NSString stringWithFormat:@"%d",validState];
                        NSString *adress = adressText.text;
                        NSString *description = @"";
                        
                        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                        NSDate *date = [NSDate date];
                        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                        NSString *timeStr= [dateFormatter stringFromDate:date];
                        [dateFormatter release];
                        NSString *name = timeStr;
                        BOOL result =  [cherryDBControl addElecFenceWithKeyid:keyID ID:elecID name:name lastUpdate:timeStr valid:valid lon:lon lat:lat radius:radius description:description address:adress vin:vin userKeyID:app.loginID];
                        
                        if (result) {
                            NSLog(@"添加成功");
                            [self MBProgressHUDMessage:[oRes getText:@"Car.ElecFence.alert.addSuccess"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
                        } else {
                            NSLog(@"添加失败");
                        }
                    }

                    
                }
                
                
            
            [self.navigationController popViewControllerAnimated:YES];
            
            
        }
        else
        {
           Resources *oRes = [Resources getInstance];
            NSMutableArray *elecFenceDic = [cherryDBControl selectWithvin:mElecFenceData.vin elecFenceId:mElecFenceData.elecFenceId];
            if (nil != elecFenceDic)
            {
                if (elecFenceModifyNetManager == nil) {
                    elecFenceModifyNetManager = [[ElecFenceModifyNetManager alloc]init];
                }
                
                ElecFenceData *data;
                data = [elecFenceDic objectAtIndex:0];
                data.lon = mlon;
                data.lat = mlat;
                data.radius = [textFieldRadius.text intValue];
                data.valid = [NSString stringWithFormat:@"%d",validState];
                data.address = adressText.text;
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                NSDate *date = [NSDate date];
                [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                NSString *timeStr= [dateFormatter stringFromDate:date];
                [dateFormatter release];
                
                data.name = timeStr;
                
                self.progressHUD.labelText = [oRes getText:@"Car.ElecFence.loading.titleText"];
                self.progressHUD.detailsLabelText= [oRes getText:@"Car.ElecFence.loading.detailtext"];
                [self.progressHUD show:YES];
                
                NSArray *updateArray = [NSArray arrayWithObject:data];
                [elecFenceModifyNetManager modifyElecRequest:updateArray];
                [elecFenceModifyNetManager sendRequestWithAsync:self];
                [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
            }
            else
            {
                
                
                App *app = [App getInstance];
                mCarData=[app getCarData];
                self.elecFenceList =[cherryDBControl selectWithVin:mCarData.mVin];
                int count = [self.elecFenceList count];
                if (count > 2)
                {
                    [self MBProgressHUDMessage:[oRes getText:@"Car.ElecFenceDetailViewController.newElecFailure"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
                    
                }
                else
                {
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    NSDate *date = [NSDate date];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                    NSString *timeStr= [dateFormatter stringFromDate:date];
                    [dateFormatter release];
                    
                    self.progressHUD.labelText = [oRes getText:@"Car.ElecFence.loading.titleText"];
                    self.progressHUD.detailsLabelText= [oRes getText:@"Car.ElecFence.loading.detailtext"];
                    [self.progressHUD show:YES];
                    
                    [elecFenceAddNetManager createRequest:mCarData.mVin name:timeStr valid:[NSString stringWithFormat:@"%d",validState] lon:mlon lat:mlat radius:[textFieldRadius.text intValue] adress:adressText.text];
                    
                    [elecFenceAddNetManager sendRequestWithAsync:self];
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
                }

            }
            
            
            

        }
    }
    
    
    
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
/*!
 @method validStateButton
 @abstract 设置电子围栏是否生效的按钮事件
 @discussion 设置电子围栏是否生效的按钮事件
 @result 无
 */
- (IBAction)validStateButton:(id)sender
{
    UIButton *button = (UIButton *)sender;
    switch (button.tag)
    {
        case 1:
            {
                selsecButton.selected = YES;
                selsecNoButton.selected = NO;
                validState =1;//电子围栏有效
            }
            break;
        case 2:
            {
                selsecButton.selected = NO;
                selsecNoButton.selected = YES;
                validState =0;//电子围栏无效
            }

    }
    

}

#pragma mark - textViewDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSMutableString *textString = [[NSMutableString alloc]initWithCapacity:0];
    [textString appendString:textField.text];
    [textString appendString:string];
    int number = [textString intValue];
    //不是删除模式
    if (![string isEqualToString:@""])
    {
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:kNum] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basic = [string isEqualToString:filtered];
        
        if (!basic)
        {
            return NO;
        }
    }

    
    //不是删除模式，并且textField文字框中的字符大于0
    if ([textField.text intValue] != 0 && ![string isEqualToString:@""])
    {
        
        if(textString.length >3)
        {
            number = 500;
            textField.text = [NSString stringWithFormat:@"%d",number];
            [self removeCircle];
            [self addOverlayView:pointAnnotation.coordinate radius:[textField.text intValue]*1000];
            return NO ;
        }
       
        if (number>500) {
            number = 500;
            textField.text = [NSString stringWithFormat:@"%d",number];
            [self removeCircle];
            [self addOverlayView:pointAnnotation.coordinate radius:[textField.text intValue]*1000];
            return NO ;
        }

    }
    //只有在地图上扎点画圆之后，才会根据输入的半径实时描画
    if(textField.text.length !=0)
    {
    
        if ([string isEqualToString:@""])
        {
            if (textString.length == 1 )
            {
                [self removeCircle];
            }
            else
            {
                [self removeCircle];
                NSString *text = [textString substringToIndex:textField.text.length-1];
                [self addOverlayView:pointAnnotation.coordinate radius:[text intValue]*1000];
            }
        }
        else
        {
            [self removeCircle];
            [self addOverlayView:pointAnnotation.coordinate radius:[textString intValue]*1000];
        }
    }

    
    
    return YES;
}
#pragma mark - map
//重写父类扎点回调
- (NIAnnotationView *)mapView:(NIMapView *)mapView viewForAnnotation:(id <NIAnnotation>)annotation
{
    if ([annotation isKindOfClass:[NIPointAnnotation class]] )
    {
        NSString *AnnotationViewID = @"pointMark";
         _viewPoint = [[NIAnnotationView alloc] initWithNIMapView:mapView reuseIdentifier:AnnotationViewID];
        _viewPoint.priority = 11;
        _viewPoint.image = [UIImage imageNamed:[NSString stringWithFormat:@"map_customPoi_icon"]];
        NSLog(@"》》》》》》》》》已经回调到viewForAnnotation》》》》》》》");
        return _viewPoint;
    }
//    else if ([annotation isKindOfClass:[NIActionPaopaoAnnotation class]] )
//    {
//        
//        NSString *AnnotationViewID = @"paopaoMark";
//        
//       viewPaopao = [[NIActionPaopaoView alloc] initWithNIMapView:mapView reuseIdentifier:AnnotationViewID];
//        UIImage *imageNormal;
//        //        imageNormal = [[UIImage imageNamed:@"wqw_paopao_middle_left@2x.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0,18,0,15)];
//        
//        if([App getVersion] <= IOS_VER_5)
//        {
//            imageNormal = [[UIImage imageNamed:@"icon_paopao_middle_left.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0,10,0,8)];
//        }
//        else
//        {
//            imageNormal = [[UIImage imageNamed:@"icon_paopao_middle_left.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0,10,0,8)resizingMode:UIImageResizingModeStretch];
//        }
//        NSLog(@"%f",imageNormal.size.height);
//        UIImageView *leftBgd = [[UIImageView alloc]initWithImage:imageNormal];
//        
//        
//        if([App getVersion] <= IOS_VER_5)
//        {
//            imageNormal = [[UIImage imageNamed:@"icon_paopao_middle_right.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0,8,0,10)];
//        }
//        else
//        {
//            imageNormal = [[UIImage imageNamed:@"icon_paopao_middle_right.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0,8,0,10)resizingMode:UIImageResizingModeStretch];
//        }
//        UIImageView *rightBgd = [[UIImageView alloc] initWithImage:imageNormal];
//        
//        NSString* textlable = annotation.subtitle;
//        NSString *titleTextlable =annotation.title;
//        
//        NSInteger textCount =textlable.length;
//        CGFloat width = 0;
//        if (textCount > 15)
//        {
//            width = 15*15;//(textlable.length)*15;
//        }
//        else
//        {
//            width =(textlable.length)*15;
//        }
//        
//        if (textlable.length < titleTextlable.length)
//        {
//            width =(titleTextlable.length)*17;
//            
//        }
//        
//        UIView *viewForImage = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width,imageNormal.size.height)];
//        leftBgd.frame = CGRectMake(0, 0, width/2,imageNormal.size.height);
//        rightBgd.frame = CGRectMake(width/2, 0, width/2,imageNormal.size.height);
//        [viewForImage addSubview:leftBgd];
//        [viewForImage sendSubviewToBack:leftBgd];
//        [viewForImage addSubview:rightBgd];
//        [viewForImage sendSubviewToBack:rightBgd];
//        [leftBgd release];
//        [rightBgd release];
//        UILabel *title;
//        if (textCount > 15)
//        {
//            title =[[UILabel alloc]initWithFrame:CGRectMake(15,0,width-20,imageNormal.size.height/2)];
//        } else {
//            title =[[UILabel alloc]initWithFrame:CGRectMake(0,0,width,imageNormal.size.height/2)];
//        }
//        
//        title.textColor = [UIColor blackColor];
//        title.backgroundColor=[UIColor clearColor];
//        title.font = [UIFont systemFontOfSize:15.0];
//        title.text=annotation.title;
//        title.textAlignment = NSTextAlignmentCenter;
//        [viewForImage addSubview:title];
//        [title release];
//        
//        UILabel *label;
//        if (textCount > 15)
//        {
//            label=[[UILabel alloc]initWithFrame:CGRectMake(15,imageNormal.size.height/2-10,width-20,imageNormal.size.height/2)];
//        } else {
//            label=[[UILabel alloc]initWithFrame:CGRectMake(0,imageNormal.size.height/2-10,width,imageNormal.size.height/2)];
//        }
//        
//        if (textlable.length < titleTextlable.length)
//        {
//            label.text= @"";
//        }
//        else
//        {
//            label.text=annotation.subtitle;
//        }
//        
//        label.font = [UIFont systemFontOfSize:13.0];
//        label.textColor = [UIColor blackColor];
//        label.textAlignment = NSTextAlignmentCenter;
//        label.backgroundColor=[UIColor clearColor];
//        label.lineBreakMode = NSLineBreakByTruncatingTail;
//        [viewForImage addSubview:label];
//        [label release];
//        
//        //其中30是气泡的偏移量，上为正，下为负
//        [viewPaopao setAnchor:NIAnchorMake(0.5f,1.6)];
//     
//        
//        viewPaopao.priority = 20;
//        viewPaopao.image = [self getImageFromView:viewForImage];
//        NSLog(@"%f",viewPaopao.image.size.height);
//        return viewPaopao;
//    }
    

    return nil;
}

-(UIImage *)getImageFromView:(UIView *)view{
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2)
        UIGraphicsBeginImageContextWithOptions(view.bounds.size,NO,2);
    else
        UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return image;
}

//添加内置覆盖物
- (void)addOverlayView:(CLLocationCoordinate2D)centerpos radius:(CLLocationDistance)radius
{
    if (circle == nil) {
        circle = [NICircle circleWithCenterCoordinate:centerpos radius:radius mapView:_mapViewBase.mapViewShare.mapView];
        [_mapViewBase.mapViewShare.mapView addOverlay:circle];
    }
}

-(void)removeCircle
{
    if (circle)
    {
        [_mapViewBase.mapViewShare.mapView removeOverlay:circle];
        [circle release];
        circle = nil;
    }
}

//根据overlay生成对应的View
- (NIOverlayView *)mapView:(NIMapView *)mapView viewForOverlay:(id <NIOverlay>)overlay
{
    if ([overlay isKindOfClass:[NICircle class]])
    {
        NICircleView* circleView = [[[NICircleView alloc] initWithOverlay:overlay] autorelease];
        circleView.fillColor = [[[UIColor greenColor] colorWithAlphaComponent:0.5] autorelease];
        circleView.lineWidth = 5.0;
        return circleView;
    }
    
    return nil;
}

//移除气泡
-(void)releasePaopao{
    if (ppAnnotation != nil)
    {
        [_mapViewBase.mapViewShare.mapView removeAnnotation:ppAnnotation];
        [ppAnnotation release];
        ppAnnotation=nil;
        [viewPaopao release];
        viewPaopao = nil;
    }
}

//移除长按大头针
-(void)removeLongclickPoint{
    if (pointAnnotation != nil)
    {
        [_mapViewBase.mapViewShare.mapView removeAnnotation:pointAnnotation];
        [pointAnnotation release];
        pointAnnotation=nil;
        [_viewPoint release];
        _viewPoint = nil;
    }
}
//重写父类长按扎点
- (void)mapView:(NIMapView *)mapView onLongClick:(CLLocationCoordinate2D)coordinate
{
    [self releasePaopao];
    [self removeLongclickPoint];
    mlon = coordinate.longitude;
    mlat = coordinate.latitude;
    if (pointAnnotation == nil) {
        pointAnnotation = [[NIPointAnnotation alloc]initWithMapView:_mapViewBase.mapViewShare.mapView];
        pointAnnotation.coordinate = coordinate;
        pointAnnotation.annotationID = ID_POI_CUSTOM;
        [_mapViewBase.mapViewShare.mapView addAnnotation:pointAnnotation];
        
    }
    _placeHolder.hidden = YES;
    Resources *oRes = [Resources getInstance];
    adressText.text = [oRes getText:@"Car.ElecFenceViewController.addressInfo"];
    [self LaunchSearcher:coordinate];
    
    [self removeCircle];
    [self addOverlayView:coordinate radius:[textFieldRadius.text intValue]*1000];

}
//重写父类逆地理
- (void)onGetReverseGeoCodeResult:(NIGeoCodeSearch *)searcher result:(NIReverseGeoCodeResult *)result  errorCode:(int)error
{

    if (error == 0)
    {
        if (pointAnnotation.title == nil)
        {
            pointAnnotation.title = @"自定义位置";
        }
        
        
        NSMutableString *addr = [[NSMutableString alloc]initWithCapacity:0];
        [addr appendString:result.adminregion.provname];
        if (!([result.adminregion.provname isEqualToString:result.adminregion.cityname] || result.adminregion.provname == nil || result.adminregion.cityname == nil))
        {
            [addr appendString:result.adminregion.cityname];
        }
        
        [addr appendString:result.adminregion.distname];
        
        if (!([result.address isEqualToString:@""] || result.address == nil))
        {
            [addr appendString:result.address];
        }
        pointAnnotation.subtitle =[NSString stringWithString:addr];
        //    ppAnnotation.subtitle = [NSString stringWithString:addr];
        _POIadress = [NSString stringWithString:addr];
    }
    else
    {
        pointAnnotation.title = @"自定义位置";
        pointAnnotation.subtitle = @"";
        _POIadress = @"";
    }

    [[NSNotificationCenter defaultCenter] postNotificationName:@"databack"object:self];


}
//重写父类单击大头针回调函数
- (void)mapView:(NIMapView *)mapView onClickedAnnotation:(id <NIAnnotation>)annotation
{
//    if (ppAnnotation != nil)
//    {
//        [self releasePaopao];
//    }
//    else
//    {
//        if (ppAnnotation == nil)
//        {
//            ppAnnotation = [[NIActionPaopaoAnnotation alloc]initWithMapView:_mapViewBase.mapViewShare.mapView];
//        }
//        ppAnnotation.title = annotation.title;
//        ppAnnotation.subtitle = annotation.subtitle;
//        ppAnnotation.coordinate  = annotation.coordinate;
//        
//         [_mapViewBase.mapViewShare.mapView addAnnotation:ppAnnotation];
//
//    }
    NIMapStatus *ptemp = [[NIMapStatus alloc]init];
    ptemp.fLevel = _mapViewBase.mapViewShare.mapView.mapStatus.fLevel;
    ptemp.targetGeoPt = [annotation coordinate];
    ptemp.fRotation = _mapViewBase.mapViewShare.mapView.mapStatus.fRotation;
//    ptemp.targetScreenPt = _mapViewBase.mapViewShare.mapView.mapStatus.targetScreenPt;
    
    CGPoint target;
    target.x =(_mapView.frame.size.width/2)*2;
    target.y = (_mapView.frame.size.height/2)*2;
    
    ptemp.targetScreenPt=target;
     //动画移动到中心点
    [_mapViewBase.mapViewShare.mapView setMapStatus:ptemp withAnimation:NO];
    [ptemp release];

   

}

// 当点击地图空白处时，调用此接口
- (void)mapView:(NIMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate{
    [self releasePaopao];
}


- (void)databack
{
    adressText.text = self.POIadress;
    _placeHolder.hidden = YES;
}
//    获取当前经纬度的地址信息失败回调函数
- (void)onError:(NSError*)error
{
    NSLog(@"error");
}


/*!
 @method setPOIWithlon:(double)lon lat:(double)lat
 @abstract 设置poi点
 @discussion 设置poi点
 @param lon 经度
 @param lat 纬度
 @result 无
 */
//-(BOOL)setPOIWithlon:(double)lon lat:(double)lat
//{
//    //if (lon != nil && lat != nil && ![lon isEqualToString:@""] && ![lat isEqualToString:@""])
//    // {
//    double m_lon = lon;//[lon doubleValue];
//    double m_lat = lat;//[lat doubleValue];
//    if (elecPOI == nil)
//    {
//        elecPOI = [[NICustomPoi alloc] initWithID:@"currentPin"];
//        
//    }
//    LayoutInfo layout;
//    layout.align    = ALIGN_CENTER | ALIGN_BOTTOM;
//    layout.x        = 0;
//    layout.y        = 0;
//    elecPOI.LayoutInfo= layout;
//    elecPOI.WGS84Pos  = WGS84Make(m_lon,m_lat);
//    elecPOI.Title     = mElecFenceData.name;
//    elecPOI.Describe    = mElecFenceData.address;
//    elecPOI.AutoGetLocation = YES;
//    [elecPOI setImage:[UIImage imageNamed:@"map_position_ic"]];
//    [mapController addPOI:elecPOI];
//    
//    [mapController moveTo:WGS84Make(m_lon,m_lat)];
//    [mapController refresh];
//    return YES;
//
//}

#pragma mark - system
- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    //设置指南针消失
    [_mapView.mapViewShare.mapView setShowDirection:NO image:nil];
    [_mapView.mapViewShare.mapView setScalePoint:CGPointMake(5.0, _mapView.frame.size.height-25)];
    App *app = [App getInstance];
    CLLocationCoordinate2D coord;
    
    
     if (elecFlag == 0)
     {
         if (app.mUserData.mType == USER_LOGIN_DEMO)
         {
             
             coord.latitude = MAP_DEFAULT_CENTER_LAT;
             coord.longitude = MAP_DEFAULT_CENTER_LON;
         }
         else
         {
             if (app.mCarData.mLon==nil || app.mCarData.mLat==nil || [app.mCarData.mLon isEqualToString:@""] || [app.mCarData.mLat isEqualToString:@""])
             {
                 coord.latitude = MAP_DEFAULT_CENTER_LAT;
                 coord.longitude = MAP_DEFAULT_CENTER_LON;
             }
             else
             {
                 
                 coord.latitude = [app.mCarData.mLat doubleValue];
                 coord.longitude = [app.mCarData.mLon doubleValue];
             }
             
         }
         //   [self setMapCenter:coord];
         NIMapStatus *ptemp = [[NIMapStatus alloc]init];
         ptemp.fLevel = 11.0;
         ptemp.targetGeoPt = coord;
         CGPoint target;
         target.x =(_mapView.frame.size.width/2)*2;
         target.y = (_mapView.frame.size.height/2)*2;
         
         ptemp.targetScreenPt=target;
         //动画移动到中心点
         [_mapViewBase.mapViewShare.mapView setMapStatus:ptemp withAnimation:NO];
         [ptemp release];

     }
    else
    {
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = mElecFenceData.lat;
        coordinate.longitude = mElecFenceData.lon;
        if (pointAnnotation == nil) {
            pointAnnotation = [[NIPointAnnotation alloc]initWithMapView:_mapViewBase.mapViewShare.mapView];
            pointAnnotation.coordinate = coordinate;
            pointAnnotation.title = @"自定义位置";
            pointAnnotation.subtitle = mElecFenceData.address;
            
            NIMapStatus *ptemp = [[NIMapStatus alloc]init];
            ptemp.fLevel = 11.0;
            ptemp.targetGeoPt = coordinate;
            CGPoint target;
            target.x =(_mapView.frame.size.width/2)*2;
            target.y = (_mapView.frame.size.height/2)*2;
            
            ptemp.targetScreenPt=target;
            //动画移动到中心点
            [_mapViewBase.mapViewShare.mapView setMapStatus:ptemp withAnimation:NO];
            [ptemp release];
            
            
            [_mapViewBase.mapViewShare.mapView addAnnotation:pointAnnotation];
            

            [self addOverlayView:coordinate radius:[textFieldRadius.text intValue]*1000];
            
            
   //          [self setMapCenter:coordinate];

        }

    }
    
    
    
    


}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [self releasePaopao];
    [self removeLongclickPoint];
    [self removeCircle];
    [super viewWillDisappear:animated];
}
#pragma mark - system
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"databack"object:nil];
    [elecFenceModifyNetManager release];
    [elecPOI release];

    [mMapContext removeFromSuperview];
    [mMapContext release],mMapContext = nil;
    [mMapContext release];
    [MonitorRadius release];
    [effectTitle release];
    [address release];
    
    [selsecButton release];
    [adressText release];
    
    [elecFenceView release];
    [_placeHolder release];
    [carButton release];
    [radiusUnit release];

    if (self.progressHUD){
        [_progressHUD removeFromSuperview];
        [_progressHUD release];
        _progressHUD = nil;
    }
    [selsecNoButton release];
    

    [textFieldRadius release];
    [super dealloc];
}
- (void)viewDidUnload {
    [mMapContext release];
    mMapContext = nil;
    [MonitorRadius release];
    MonitorRadius = nil;
    [effectTitle release];
    effectTitle = nil;
    [address release];
    address = nil;
    
    [selsecButton release];
    selsecButton = nil;
    [adressText release];
    adressText = nil;
    
    [_placeHolder release];
    _placeHolder = nil;
    [carButton release];
    carButton = nil;

    [radiusUnit release];
    radiusUnit = nil;
    [selsecNoButton release];
    selsecNoButton = nil;
    [textFieldRadius release];
    textFieldRadius = nil;
    [super viewDidUnload];
}


@end