/*!
 @header ehicleControlViewController.m
 @abstract 车辆遥控主控界面
 @author wangqiwei
 @version 1.00 2014/9/1 Create
 */

#import "VehicleControlViewController.h"
#import "vehicleControlNetManager.h"
#import "SetParameterViewController.h"
#import "App.h"



@interface VehicleControlViewController ()
{
    NSString *commondCodeState;
    CarData *mCarData;
    int indexFlag;//已经开始执行的动画数量
    
    NSInteger exeNumber;

}
@end

@implementation VehicleControlViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        NSLog(@"加载的XIB为：%@",nibNameOrNil);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:passwordViewBG];
    [self.view addSubview:passwordView];
    passwordViewBG.hidden = YES;
    passwordView.hidden = YES;
    passwordTield.delegate = self;
    vehicleControlNet = [[VehicleControlNetManager alloc] init];
    
    [self getTemperature];
    
    [EngineSwitch setBackgroundImage:[UIImage imageNamed:@"car_vehicleControl_openEngine"] forState:UIControlStateNormal];
    [EngineSwitch setBackgroundImage:[UIImage imageNamed:@"car_vehicleControl_closeEngine"] forState:UIControlStateSelected];
   
    //显示加载等待框
    self.progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.progressHUD];
    [self.view bringSubviewToFront:self.progressHUD];
    self.progressHUD.delegate = self;
    
    Resources *res =[Resources getInstance];
    openCoolAirLable.text = [res getText:@"Car.VehicleControl.openCoolAirLable"];
    closeCoolAirLable.text = [res getText:@"Car.VehicleControl.closeCoolAirLable"];
    openDoorLable.text = [res getText:@"Car.VehicleControl.openDoorLable"];
    closeDoorLable.text = [res getText:@"Car.VehicleControl.closeDoorLable"];
    
    currentTemperatureTitle.text = [res getText:@"Car.VehicleControl.currentTemperatureTitle"];
    temperatureUnit.text = [res getText:@"Car.VehicleControl.currentTemperatureUnit"];
    
    
    animationCarBG.hidden = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshControlCode:) name:Notification_New_VehicleControl object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getTemperature];
}

- (void)getTemperature
{
    App *app = [App getInstance];
    mCarData=[app getCarData];
    Resources *res = [Resources getInstance];
    NSUserDefaults *setData = [NSUserDefaults standardUserDefaults];

    if (app.mUserData.mType == USER_LOGIN_DEMO)
    {
        NSMutableDictionary *setDic = [setData objectForKey:demoUser];
        if (setDic == nil) {
            NSString *temperature = [res getText:@"Car.VehicleControl.defaultTemperatureText"];
            NSMutableString *tempString =[[NSMutableString alloc] initWithCapacity:0];
            [tempString appendString:temperature];
            temperatureInCar.text = [NSString stringWithString:tempString];
            
        } else {
            NSString *temperature = [setDic objectForKey:temperatureKey];
            NSMutableString *tempString =[[NSMutableString alloc] initWithCapacity:0];
            [tempString appendString:temperature];
            temperatureInCar.text = [NSString stringWithString:tempString];
        }
        
        
    }
    else
    {
        NSMutableDictionary *setDic = [setData objectForKey:mCarData.mVin];
        if (setDic == nil)
        {
            NSString *temperature = [res getText:@"Car.VehicleControl.defaultTemperatureText"];
            NSMutableString *tempString =[[NSMutableString alloc] initWithCapacity:0];
            [tempString appendString:temperature];
            temperatureInCar.text = [NSString stringWithString:tempString];
        }
        else
        {
            NSString *temperature = [setDic objectForKey:temperatureKey];
            NSMutableString *tempString =[[NSMutableString alloc] initWithCapacity:0];
            [tempString appendString:temperature];
            temperatureInCar.text = [NSString stringWithString:tempString];
        }
        
        
    }

}

- (void)refreshControlCode:(NSNotification *)notification
{
    Resources *oRes = [Resources getInstance];
    App *app = [App getInstance];
    NSDictionary *notify = [notification object];
    NSDictionary *Dic = [notify objectForKey:[app getCarData].mVin];
    int cmdCode = [[Dic objectForKey:@"cmdCode"]intValue];
    int resultCode = [[Dic objectForKey:@"resultCode"]intValue];

    [self removeAllAnimations];
    
        switch (cmdCode)
        {
            case OPEN_ENGINES:
            {
                if (resultCode == 0)
                {
                    [self MBProgressHUDMessage:[oRes getText:@"Car.VehicleControlViewController.openEngineSuccess"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
                    AudioServicesAddSystemSoundCompletion(kSystemSoundID_Vibrate, NULL, NULL,finishPalySoundCallBack, (void*)self);
                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                    EngineSwitch.selected = YES;
                  
                    
                }
                else
                {
                    [self MBProgressHUDMessage:[oRes getText:@"Car.VehicleControlViewController.openEngineDailure"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
                    
                }
                
                EngineSwitch.selected = YES;
                animationCarBG.hidden = NO;
                [self setImageTransparent:animationEngine];
            }
                
                break;
            case TURNOff_ENGINE:
            {
                if (resultCode == 0)
                {
                    [self MBProgressHUDMessage:[oRes getText:@"Car.VehicleControlViewController.turnOffEngineSuccess"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
                    
                }
                else
                {
                    [self MBProgressHUDMessage:[oRes getText:@"Car.VehicleControlViewController.turnOffEngineFailure"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
                    
                }
                
                animationCarBG.hidden = YES;
                EngineSwitch.selected = NO;
            }
                break;
            case OPEN_COOLAIR:
            {
                if (resultCode == 0)
                {
                    [self MBProgressHUDMessage:[oRes getText:@"Car.VehicleControlViewController.openCoolAirSuccess"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
                    
                }
                else
                {
                    [self MBProgressHUDMessage:[oRes getText:@"Car.VehicleControlViewController.openCoolAirFailure"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
                    
                }
                
                animationCarBG.hidden = NO;
                [self setImageTransparent:animationCoolAir];
            }
                break;
            case TURNOff_COOLAIR:
            {
                if (resultCode == 0)
                {
                    [self MBProgressHUDMessage:[oRes getText:@"Car.VehicleControlViewController.turnOffCoolAirSuccess"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
                    
                }
                else
                {
                    [self MBProgressHUDMessage:[oRes getText:@"Car.VehicleControlViewController.turnOffCoolAirFailure"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
                    
                }
                
                animationCarBG.hidden = YES;
            }
                break;
            case OPEN_DOORLOCK:
            {
                if (resultCode == 0)
                {
                    [self MBProgressHUDMessage:[oRes getText:@"Car.VehicleControlViewController.openDoorLockSuccess"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
                    
                }
                else
                {
                    [self MBProgressHUDMessage:[oRes getText:@"Car.VehicleControlViewController.openDoorLockFailure"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
                    
                }
                
                animationCarBG.hidden = YES;
                [self setImageTransparent:animationDoor];
            }
                break;
            case TURNOff_DOORLOCK:
            {
                if (resultCode == 0)
                {
                    [self MBProgressHUDMessage:[oRes getText:@"Car.VehicleControlViewController.turnOffDoorLockSuccess"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
                    
                }
                else
                {
                    [self MBProgressHUDMessage:[oRes getText:@"Car.VehicleControlViewController.turnOffDoorLockFailure"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
                    
                }
                
                animationCarBG.hidden = YES;
            }
                break;
            case WHISTLE_AND_FLASHING_LIGHT:
            {
                if (resultCode == 0)
                {
                    [self MBProgressHUDMessage:[oRes getText:@"Car.VehicleControlViewController.whistleAndFlashingLightSuccess"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
                    AudioServicesAddSystemSoundCompletion(kSystemSoundID_Vibrate, NULL, NULL,finishPalySoundCallBack, (void*)self);
                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                }
                else
                {
                    [self MBProgressHUDMessage:[oRes getText:@"Car.VehicleControlViewController.whistleAndFlashingLightFailure"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
                    
                }
                
                animationCarBG.hidden = YES;
                [self setImageTransparent:animationWhistleAndFlashingLight];
            }
                break;
            default:
                NSLog(@"接收的指令码错误，不是规定的指令码,错误指令码为: %d",cmdCode);
                
                break;
        }
    
    
    
}

- (void)moveViewPasswordView
{
    Resources *oRes = [Resources getInstance];
    //适配iphone4S
    enum SCREEN_SIZE   deviceSize = [App getScreenSize];
    if (deviceSize == SCREEN_SIZE_960_640)
    {
        passwordView.frame = CGRectMake(self.view.bounds.origin.x+25, self.view.bounds.origin.y+30, passwordView.frame.size.width, passwordView.frame.size.height);
    }
    else
    {
        passwordView.frame = CGRectMake(self.view.bounds.origin.x+25, self.view.bounds.origin.y+100, passwordView.frame.size.width, passwordView.frame.size.height);
    }

    passwordTield.keyboardType = UIKeyboardTypeNumberPad;
    passwordTield.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordView.hidden = NO;
    passwordTield.placeholder = [oRes getText:@"Car.VehicleControlViewController.placeHolder"];
    [passwordTield becomeFirstResponder];
    
}

- (void)removePasswordView
{
    passwordViewBG.hidden = YES;
    passwordView.hidden = YES;
    [passwordTield setText:@""];
    [passwordTield resignFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{

    if (range.location>5) {
        return NO;
    }
    
    return YES;
}

- (IBAction)touchViewTap:(id)sender
{
    passwordViewBG.hidden = YES;
    passwordView.hidden = YES;
    [passwordTield setText:@""];
    [passwordTield resignFirstResponder];
}

- (void)shake
{
    if (exeNumber<2)
    {
        NSLog(@"exeNumber:%d",exeNumber);
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        exeNumber++;
        
    }
    else
    {
        NSLog(@"exeNumber is over");
        AudioServicesRemoveSystemSoundCompletion(kSystemSoundID_Vibrate);
        [NSObject cancelPreviousPerformRequestsWithTarget:self
                                                 selector:@selector(shake)
                                                   object:nil];
    }
    
}

void finishPalySoundCallBack(SystemSoundID sound_id,void* user_data)
{
    [(id)user_data performSelector:@selector(shake) withObject:nil afterDelay:1];
}

- (IBAction)passwordViewOKButton:(id)sender
{
    App *app = [App getInstance];
    Resources *oRes = [Resources getInstance];
    int commondCode = [commondCodeState intValue];
    NSUserDefaults *setParaData = [NSUserDefaults standardUserDefaults];
    NSDictionary *setParaDic = [setParaData objectForKey:[app getCarData].mVin];
    
    int engineDuration =[[setParaDic objectForKey:engineTimeKey]intValue];
    int iTemperature = [[setParaDic objectForKey:temperatureKey]intValue];
    int coolAirDuration = [[setParaDic objectForKey:coolAirTimeKey]intValue];
    
    if ([passwordTield.text isEqualToString:@""])
    {
        [self MBProgressHUDMessage:[oRes getText:@"Car.VehicleControlViewController.placeHolder"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    if(passwordTield.text.length <6)
    {
        [self MBProgressHUDMessage:[oRes getText:@"Car.VehicleControlViewController.textNum"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else
    {
        if(app.mUserData.mType == USER_LOGIN_DEMO)
        {
            [self MBProgressHUDMessage:[oRes getText:@"Car.vehicleDiagnosisViewController.success"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
            [self removeAllAnimations];
      //      animationState =1;
       //     finishFlag =0;
            switch (commondCode)
            {
                case 5:
                    animationCarBG.hidden = YES;
                    [self setImageTransparent:animationDoor];

                    break;
                case 6:
                    animationCarBG.hidden = YES;
                    break;
                case 7:
                    animationCarBG.hidden = YES;
                    
                    AudioServicesAddSystemSoundCompletion(kSystemSoundID_Vibrate, NULL, NULL,finishPalySoundCallBack, (void*)self);
                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                    
                    [self setImageTransparent:animationWhistleAndFlashingLight];
                    break;
                case 1:
                    EngineSwitch.selected = YES;
                    animationCarBG.hidden = NO;
                    [self setImageTransparent:animationEngine];
                    AudioServicesAddSystemSoundCompletion(kSystemSoundID_Vibrate, NULL, NULL,finishPalySoundCallBack, (void*)self);
                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                    break;
                case 2:
                    animationCarBG.hidden = YES;
                    EngineSwitch.selected = NO;
                    break;
                case 3:
                    animationCarBG.hidden = NO;
                    [self setImageTransparent:animationCoolAir];
                   
                    break;
                case 4:
                    animationCarBG.hidden = YES;
                    break;
                default:
                    break;
            }

            
        }
        else
        {
            switch (commondCode) {
                case 5:
                    [vehicleControlNet createRequest:[app getCarData].mVin cmdCode:commondCodeState pwd:passwordTield.text duration:defaultVaule temperature:defaultVaule];
                    break;
                case 6:
                    [vehicleControlNet createRequest:[app getCarData].mVin cmdCode:commondCodeState pwd:passwordTield.text duration:defaultVaule temperature:defaultVaule];
                    break;
                case 7:
                    [vehicleControlNet createRequest:[app getCarData].mVin cmdCode:commondCodeState pwd:passwordTield.text duration:defaultVaule temperature:defaultVaule];
                    break;
                case 1:
                    [vehicleControlNet createRequest:[app getCarData].mVin cmdCode:commondCodeState pwd:passwordTield.text duration:engineDuration temperature:defaultVaule];
                    break;
                case 2:
                    [vehicleControlNet createRequest:[app getCarData].mVin cmdCode:commondCodeState pwd:passwordTield.text duration:engineDuration temperature:defaultVaule];
                    break;
                case 3:
                    [vehicleControlNet createRequest:[app getCarData].mVin cmdCode:commondCodeState pwd:passwordTield.text duration:coolAirDuration temperature:iTemperature];
                    break;
                case 4:
                    [vehicleControlNet createRequest:[app getCarData].mVin cmdCode:commondCodeState pwd:passwordTield.text duration:coolAirDuration temperature:iTemperature];
                    break;
                default:
                    break;
            }
            self.progressHUD.labelText = [oRes getText:@"Car.VehicleControl.loading.titleText"];
            self.progressHUD.detailsLabelText= [oRes getText:@"Car.VehicleControl.loading.detailtext"];
            [self.progressHUD show:YES];
            NSLog(@"commondCodeState: %@  pwd: %@ ",commondCodeState,passwordTield.text);
            [vehicleControlNet sendRequestWithAsync:self];
        }
        
        [self removePasswordView];

    }
    
   }



- (void)setImageTransparent:(UIImageView *)animationView
{
    indexFlag += 1;
    [UIView animateWithDuration:1.0 delay:0.0 options:0 animations:^{
        animationView.alpha = 1;
        
    } completion:^(BOOL finished){
        [UIView animateWithDuration:1.0
                              delay:0.0
                            options:UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat
                         animations:^(void){
                             [UIView setAnimationRepeatCount:4.5];
                             animationView.alpha = 0;
                         }completion:^(BOOL finished){

                             if (indexFlag <= 1)
                             {
                                 animationCarBG.hidden = YES;
                             }

                             
                             indexFlag -= 1;
                             
                             
                         }];
        
    }];
    
    
}

- (void)removeAllAnimations
{
    [animationDoor.layer removeAllAnimations];
    [animationEngine.layer removeAllAnimations];
    [animationCoolAir.layer removeAllAnimations];
    [animationWhistleAndFlashingLight.layer removeAllAnimations];
   
}


- (IBAction)passwordViewCancelButton:(id)sender
{
    passwordViewBG.hidden = YES;
    passwordView.hidden = YES;
    [passwordTield setText:@""];
    [passwordTield resignFirstResponder];
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
#pragma mark-buttonDelegate
- (IBAction)EngineSwitch:(id)sender
{
    [self moveViewPasswordView];

        if (EngineSwitch.selected)
        {
            commondCodeState = TURNOff_ENGINE_CODE;
        }
        else
        {
            commondCodeState = OPEN_ENGINE_CODE;
        }

     passwordViewBG.hidden = NO;
}


- (IBAction)openEngine:(id)sender
{
   
    commondCodeState = OPEN_ENGINE_CODE;
   
}
- (IBAction)turnOffEngine:(id)sender
{
    [self moveViewPasswordView];
    commondCodeState = TURNOff_ENGINE_CODE;
    passwordViewBG.hidden = NO;
}
- (IBAction)whistleAndFlashingLight:(id)sender
{
    [self moveViewPasswordView];
    commondCodeState = WHISTLE_AND_FLASHING_LIGHT_CODE;
    passwordViewBG.hidden = NO;
}
- (IBAction)openCoolAir:(id)sender
{
    [self moveViewPasswordView];
    commondCodeState = OPEN_COOLAIR_CODE;
    passwordViewBG.hidden = NO;
}
- (IBAction)turnOffCoolAir:(id)sender
{
    [self moveViewPasswordView];
    commondCodeState = TURNOff_COOLAIR_CODE;
    passwordViewBG.hidden = NO;
}
- (IBAction)openDoorLock:(id)sender
{
    [self moveViewPasswordView];
    commondCodeState = OPEN_DOORLOCK_CODE;
    passwordViewBG.hidden = NO;
}
- (IBAction)turnOffDoorLock:(id)sender
{
    [self moveViewPasswordView];
    commondCodeState = TURNOff_DOORLOCK_CODE;
    passwordViewBG.hidden = NO;
}

#pragma mark - net Delegate
- (void)onVehicleControlResult:(NSDictionary *)result code:(int)code errorMsg:(NSString *)errorMsg;
{
    NSLog(@"receive the result of onVehicleControl.");
    [self.progressHUD hide:YES];
    Resources *oRes = [Resources getInstance];
    if (NAVINFO_RESULT_SUCCESS == code)
    {
        [self MBProgressHUDMessage:[oRes getText:@"Car.VehicleControlViewController.success"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else if (NAVINFO_CONTROL_ERROR == code)
    {
        [self MBProgressHUDMessage:[oRes getText:@"Car.VehicleControlViewController.error"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
    else if(NAVINFO_CONTROL_EXECUTING == code)
    {
        [self MBProgressHUDMessage:[oRes getText:@"Car.VehicleControlViewController.executing"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
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
        [self MBProgressHUDMessage:[oRes getText:@"Car.VehicleControlViewController.failure"] delayTime:TOAST_DELAY_TIME xOffset:TOAST_OFFICE_X yOffset:TOAST_OFFICE_Y];
    }
}

#pragma mark-MemoryWarning
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:Notification_New_VehicleControl object:nil];
    [_progressHUD release];
    _progressHUD = nil;
    [vehicleControlNet release];
    [whistleAndFlashingLight release];
    [openCoolAir release];
    [turnOffCoolAir release];
    [openDoorLock release];
    [turnOffDoorLock release];
    [passwordTield release];
    [passwordView release];
    [passwordViewBG release];
    [temperatureInCar release];
    [carControllView release];
    [setParaView release];
    [EngineSwitch release];
    [openCoolAirLable release];
    [closeCoolAirLable release];
    [openDoorLable release];
    [closeDoorLable release];
    [currentTemperatureTitle release];
    [temperatureUnit release];
    [animationDoor release];
    [animationCarBG release];
    [animationCoolAir release];
    [animationEngine release];
    [animationWhistleAndFlashingLight release];
    [super dealloc];
}
- (void)viewDidUnload {
    [whistleAndFlashingLight release];
    whistleAndFlashingLight = nil;
    [openCoolAir release];
    openCoolAir = nil;
    [turnOffCoolAir release];
    turnOffCoolAir = nil;
    [openDoorLock release];
    openDoorLock = nil;
    [turnOffDoorLock release];
    turnOffDoorLock = nil;
    [passwordTield release];
    passwordTield = nil;
    [passwordView release];
    passwordView = nil;
    [passwordViewBG release];
    passwordViewBG = nil;
    [temperatureInCar release];
    temperatureInCar = nil;
    [carControllView release];
    carControllView = nil;
    [setParaView release];
    setParaView = nil;
    [EngineSwitch release];
    EngineSwitch = nil;
    [openCoolAirLable release];
    openCoolAirLable = nil;
    [closeCoolAirLable release];
    closeCoolAirLable = nil;
    [openDoorLable release];
    openDoorLable = nil;
    [closeDoorLable release];
    closeDoorLable = nil;
    [currentTemperatureTitle release];
    currentTemperatureTitle = nil;
    [temperatureUnit release];
    temperatureUnit = nil;
    [animationDoor release];
    animationDoor = nil;
    [animationCarBG release];
    animationCarBG = nil;
    [animationCoolAir release];
    animationCoolAir = nil;
    [animationEngine release];
    animationEngine = nil;
    [animationWhistleAndFlashingLight release];
    animationWhistleAndFlashingLight = nil;
    [super viewDidUnload];
}
@end
