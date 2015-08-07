/*!
 @header SetParameterViewController.m
 @abstract 车辆遥控参数设置界面
 @author wangqiwei
 @version 1.00 2014/9/1 Create
 */

#import "SetParameterViewController.h"
#import "ReturnButton.h"
#import "SaveButton.h"
#import "app.h"



@interface SetParameterViewController ()
{
    CarData *mCarData;
}

@end

@implementation SetParameterViewController

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
    
    headerView.backgroundColor = [UIColor colorWithRed:231.0/255 green:231.0/255 blue:231.0/255 alpha:1];
    buttomView.backgroundColor = [UIColor colorWithRed:231.0/255 green:231.0/255 blue:231.0/255 alpha:1];
    
    //适配IOS5.0
    if([App getVersion]==IOS_VER_5)
    {
        [engineSlider setMinimumTrackImage:[[UIImage imageNamed:@"car_vehicleStatus_setting_slider_bg_green"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)] forState:UIControlStateNormal];
        [engineSlider setMaximumTrackImage:[[UIImage imageNamed:@"car_vehicleStatus_setting_slider_bg_gray"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)] forState:UIControlStateNormal];
        
        [temperatureSlider setMinimumTrackImage:[[UIImage imageNamed:@"car_vehicleStatus_setting_slider_bg_red"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)] forState:UIControlStateNormal];
        [temperatureSlider setMaximumTrackImage:[[UIImage imageNamed:@"car_vehicleStatus_setting_slider_bg_gray"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)] forState:UIControlStateNormal];
        
        [coolAirTimeSlider setMinimumTrackImage:[[UIImage imageNamed:@"car_vehicleStatus_setting_slider_bg_green"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)] forState:UIControlStateNormal];
        [coolAirTimeSlider setMaximumTrackImage:[[UIImage imageNamed:@"car_vehicleStatus_setting_slider_bg_gray"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)] forState:UIControlStateNormal];
        
        NSLog(@"engineSlider:%f ",engineSlider.frame.size.height);
    }
    else
    {
        [engineSlider setMinimumTrackImage:[[UIImage imageNamed:@"car_vehicleStatus_setting_slider_bg_green"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5) resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
        [engineSlider setMaximumTrackImage:[[UIImage imageNamed:@"car_vehicleStatus_setting_slider_bg_gray"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5) resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
        
        [temperatureSlider setMinimumTrackImage:[[UIImage imageNamed:@"car_vehicleStatus_setting_slider_bg_red"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5) resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
        [temperatureSlider setMaximumTrackImage:[[UIImage imageNamed:@"car_vehicleStatus_setting_slider_bg_gray"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5) resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
        
        [coolAirTimeSlider setMinimumTrackImage:[[UIImage imageNamed:@"car_vehicleStatus_setting_slider_bg_green"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5) resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
        [coolAirTimeSlider setMaximumTrackImage:[[UIImage imageNamed:@"car_vehicleStatus_setting_slider_bg_gray"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5) resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
    }
    
    
    

    [engineSlider  setThumbImage:[UIImage imageNamed:@"car_vehicleStatus_setting_sliderThumb"] forState:UIControlStateNormal];

    [temperatureSlider  setThumbImage:[UIImage imageNamed:@"car_vehicleStatus_setting_sliderThumb"] forState:UIControlStateNormal];
    
    [coolAirTimeSlider  setThumbImage:[UIImage imageNamed:@"car_vehicleStatus_setting_sliderThumb"] forState:UIControlStateNormal];


    Resources *oRes = [Resources getInstance];
    self.navigationItem.title = [oRes getText:@"Car.setParameterViewController.setParaTitle"];
    openEngineTitle.text = [oRes getText:@"Car.setParameterViewController.engineTitle"];
    openCoolAirTitle.text = [oRes getText:@"Car.setParameterViewController.CoolAirTitle"];
    
    coolAirTimeTitle.text = [oRes getText:@"Car.setParameterViewController.CoolAirTime"];
    coolAirTemperatureTitle.text = [oRes getText:@"Car.setParameterViewController.CoolAirTemperature"];
    
    ReturnButton* _returnBt = [[ReturnButton alloc]init];
    [_returnBt addTarget:self action:@selector(returnHome)forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_returnBt];
    [_returnBt release];
    
//    SaveButton* _saveBt = [[SaveButton alloc]init];
//    [_saveBt addTarget:self action:@selector(savePara)forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_saveBt];
//    [_saveBt release];
    
    
    NSUserDefaults *setData = [NSUserDefaults standardUserDefaults];
    App *app = [App getInstance];
    mCarData=[app getCarData];
    if (app.mUserData.mType == USER_LOGIN_DEMO) {
        NSMutableDictionary *setDic = [setData objectForKey:demoUser];
        if (setDic == nil) {
            engineTime.text = [NSString stringWithFormat:@"%d",(int)roundf(engineSlider.value)];
            temperature.text = [NSString stringWithFormat:@"%d",(int)roundf(temperatureSlider.value)];
            coolAirTime.text = [NSString stringWithFormat:@"%d",(int)roundf(coolAirTimeSlider.value)];
        }
        else
        {
            engineTime.text = [setDic objectForKey:engineTimeKey];
            temperature.text = [setDic objectForKey:temperatureKey];
            coolAirTime.text = [setDic objectForKey:coolAirTimeKey];
            
            engineSlider.value = [engineTime.text floatValue];
            temperatureSlider.value = [temperature.text floatValue];
            coolAirTimeSlider.value = [coolAirTime.text floatValue];
        }

    } else {
        NSMutableDictionary *setDic = [setData objectForKey:mCarData.mVin];
        if (setDic == nil) {
            engineTime.text = [NSString stringWithFormat:@"%d",(int)roundf(engineSlider.value)];
            temperature.text = [NSString stringWithFormat:@"%d",(int)roundf(temperatureSlider.value)];
            coolAirTime.text = [NSString stringWithFormat:@"%d",(int)roundf(coolAirTimeSlider.value)];
        }
        else
        {
            engineTime.text = [setDic objectForKey:engineTimeKey];
            temperature.text = [setDic objectForKey:temperatureKey];
            coolAirTime.text = [setDic objectForKey:coolAirTimeKey];
            
            engineSlider.value = [engineTime.text floatValue];
            temperatureSlider.value = [temperature.text floatValue];
            coolAirTimeSlider.value = [coolAirTime.text floatValue];
        }
    }
    

}

#pragma mark-buttonDelegate

- (void)returnHome
{
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

//- (void)savePara
//{
//    NSUserDefaults *setParaData = [NSUserDefaults standardUserDefaults];
//    App *app = [App getInstance];
//
//    NSMutableDictionary *setparaDic = [NSMutableDictionary dictionary];
//    [setparaDic setObject:temperature.text forKey:temperatureKey];
//    [setparaDic setObject:engineTime.text forKey:engineTimeKey];
//    [setparaDic setObject:coolAirTime.text forKey:coolAirTimeKey];
//    if (app.mUserData.mType == USER_LOGIN_DEMO)
//    {
//        [setParaData setObject:setparaDic forKey:demoUser];
//    }
//    else
//    {
//        [setParaData setObject:setparaDic forKey:mCarData.mVin];
//    }
//
//    [setParaData synchronize];
//    
//    
//}

- (IBAction)engineDecreaseButton:(id)sender
{
    engineSlider.value = engineSlider.value-1;
    int vaule = (int)roundf(engineSlider.value);
    engineTime.text = [NSString stringWithFormat:@"%d",vaule];
    [self AutoSavePara];
}

- (IBAction)engineRiseButton:(id)sender
{
    engineSlider.value = engineSlider.value+1;
    int vaule = (int)roundf(engineSlider.value);
    engineTime.text = [NSString stringWithFormat:@"%d",vaule];
    [self AutoSavePara];
}

- (IBAction)coolAirTimeDecreaseButton:(id)sender
{
    coolAirTimeSlider.value = coolAirTimeSlider.value-1;
    int vaule = (int)roundf(coolAirTimeSlider.value);
    coolAirTime.text = [NSString stringWithFormat:@"%d",vaule];
    [self AutoSavePara];
}

- (IBAction)coolAirTimeRiseButton:(id)sender
{
    coolAirTimeSlider.value = coolAirTimeSlider.value+1;
    int vaule = (int)roundf(coolAirTimeSlider.value);
    coolAirTime.text = [NSString stringWithFormat:@"%d",vaule];
    [self AutoSavePara];
}

- (IBAction)coolAirTemperatureDecreaseButton:(id)sender
{
    temperatureSlider.value = temperatureSlider.value-1;
    int vaule = (int)roundf(temperatureSlider.value);
    temperature.text = [NSString stringWithFormat:@"%d",vaule];
    [self AutoSavePara];
}
- (IBAction)coolAirTemperatureRiseButton:(id)sender
{
   temperatureSlider.value = temperatureSlider.value+1;
    int vaule = (int)roundf(temperatureSlider.value);
    temperature.text = [NSString stringWithFormat:@"%d",vaule];
    [self AutoSavePara];
}




#pragma mark - sliderDelegate
- (IBAction)temperatureSlider:(id)sender
{
    UISlider *slider = (UISlider *)sender;
    int vaule = (int)roundf(slider.value);
    temperature.text = [NSString stringWithFormat:@"%d",vaule];
    
}



- (IBAction)engineSlider:(id)sender
{
    UISlider *slider = (UISlider *)sender;
    int vaule = (int)roundf(slider.value);
    engineTime.text = [NSString stringWithFormat:@"%d",vaule];
}

- (IBAction)coolAirTimeSlider:(id)sender
{
    UISlider *slider = (UISlider *)sender;
    int vaule = (int)roundf(slider.value);
    coolAirTime.text = [NSString stringWithFormat:@"%d",vaule];
}


- (IBAction)engineSliderEditEnd:(id)sender
{
    [self AutoSavePara];
}

- (IBAction)coolAirTimeSliderEditEnd:(id)sender
{
    [self AutoSavePara];
}

- (IBAction)temperatureSliderEditEnd:(id)sender
{
    [self AutoSavePara];
}

- (void)AutoSavePara
{
    NSUserDefaults *setParaData = [NSUserDefaults standardUserDefaults];
    App *app = [App getInstance];
    
    NSMutableDictionary *setparaDic = [NSMutableDictionary dictionary];
    [setparaDic setObject:temperature.text forKey:temperatureKey];
    [setparaDic setObject:engineTime.text forKey:engineTimeKey];
    [setparaDic setObject:coolAirTime.text forKey:coolAirTimeKey];
    if (app.mUserData.mType == USER_LOGIN_DEMO)
    {
        [setParaData setObject:setparaDic forKey:demoUser];
    }
    else
    {
        [setParaData setObject:setparaDic forKey:mCarData.mVin];
    }
    
    [setParaData synchronize];

}

#pragma mark - MemoryWarning
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [openEngineTitle release];
    [engineTime release];
    [openCoolAirTitle release];
    [temperature release];
    [coolAirTime release];
    [engineSlider release];
    [temperatureSlider release];
    [coolAirTimeSlider release];
    [headerView release];
    [buttomView release];
    [coolAirTimeTitle release];
    [coolAirTemperatureTitle release];
    [super dealloc];
}
- (void)viewDidUnload {
    [openEngineTitle release];
    engineTime = nil;
    [openEngineTitle release];
    engineTime = nil;
    [openCoolAirTitle release];
    openCoolAirTitle = nil;
    [temperature release];
    temperature = nil;
    [coolAirTime release];
    coolAirTime = nil;
    [engineSlider release];
    engineSlider = nil;
    [temperatureSlider release];
    temperatureSlider = nil;
    [coolAirTimeSlider release];
    coolAirTimeSlider = nil;
    [headerView release];
    headerView = nil;
    [buttomView release];
    buttomView = nil;
    [coolAirTimeTitle release];
    coolAirTimeTitle = nil;
    [coolAirTemperatureTitle release];
    coolAirTemperatureTitle = nil;
    [super viewDidUnload];
}
@end
