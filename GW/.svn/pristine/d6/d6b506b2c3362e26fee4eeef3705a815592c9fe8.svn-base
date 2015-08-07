/*!
 @header CarTabBarViewController.m
 @abstract 爱车的tabbar主控界面
 @author wangqiwei
 @version 1.00 2014/9/1 Create
 */

#import "CarTabBarViewController.h"
#import "App.h"
#import "DiagnosisButton.h"

#import "SetParaButton.h"
#import "RefreshButton.h"
#import "SetParameterViewController.h"

@interface CarTabBarViewController ()

@end

@implementation CarTabBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
/*
 -(void)loadCustomTabBar
 {
 UIImageView *imageBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 49)];
 imageBG.userInteractionEnabled = YES;
 imageBG.image = [UIImage imageNamed:@"friend_tabbar_bg"];
 [self.tabBar addSubview:imageBG];
 
 [imageBG release];
 
 int coorX = 0;
 for (int index = 0; index <4; index++) {
 UIButton *TabBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
 TabBarButton.tag = index;
 NSString *name = [NSString stringWithFormat:@"%d",index+1];
 [TabBarButton setBackgroundImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
 TabBarButton.frame = CGRectMake(19+coorX, 49.0/2-20, 42, 40);
 coorX += 80;
 
 [imageBG addSubview:TabBarButton];
 [TabBarButton addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventTouchUpInside];
 
 }
 }
 */
/*!
 @method loadViewControllers
 @abstract 给tabbar加载ViewControllers
 @discussion 给tabbar加载ViewControllers
 @result 无
 */
- (void)loadViewControllers
{
    //
    //    if([App getVersion]==IOS_VER_7){
    //        [App ios7ViewLocation:self];
    //        [self setNeedsStatusBarAppearanceUpdate];
    //        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_ios7_navBar_bg"] forBarMetrics:UIBarMetricsDefault];
    //    }
    //    else
    //    {
    //        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_ios6_navBar_bg"] forBarMetrics:UIBarMetricsDefault];
    //    }
    
    
    Resources *oRes = [Resources getInstance];
    self.tabBar.backgroundImage=[UIImage imageNamed:@"car_elecfence_tabbar_bg"];
    self.delegate = self;
//    vehicleControl = [[VehicleControlViewController alloc]init];
    
    //适配iphone4S
    enum SCREEN_SIZE   deviceSize = [App getScreenSize];
    if (deviceSize == SCREEN_SIZE_960_640)
    {
       vehicleControl = [[VehicleControlViewController alloc]initWithNibName:@"VehicleControlViewController4" bundle:nil];
    }
    else
    {
       vehicleControl = [[VehicleControlViewController alloc]initWithNibName:@"VehicleControlViewController" bundle:nil];
    }
    
    
    vehicleStatus = [[VehicleStatusViewController alloc]init];
    ElecFence = [[ElecFenceViewController alloc] init];
    vehicleDiagnosis = [[VehicleDiagnosisViewController alloc]init];
    
    
    if ([App getVersion]>=IOS_VER_7) {
        UIImage * normalImage = [[UIImage imageNamed:@"car_vehicleControl_tabbar_NoSelectd"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage * selectImage = [[UIImage imageNamed:@"car_vehicleControl_tabbar_selectd"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vehicleControl.tabBarItem = [[UITabBarItem alloc]initWithTitle:[oRes getText:@"car.carTabBarViewController.vehicleControlTabBarItem"] image:normalImage selectedImage:selectImage];
        
        normalImage = [[UIImage imageNamed:@"car_vehicleStatus_tabbar_NoSelectd"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        selectImage = [[UIImage imageNamed:@"car_vehicleStatus_tabbar_selectd"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vehicleStatus.tabBarItem = [[UITabBarItem alloc]initWithTitle:[oRes getText:@"car.carTabBarViewController.vehicleStatusTabBarItem"] image:normalImage selectedImage:selectImage];
        
        normalImage = [[UIImage imageNamed:@"car_elecfence_tabbar_NoSelectd"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        selectImage = [[UIImage imageNamed:@"car_elecfence_tabbar_selectd"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        ElecFence.tabBarItem = [[UITabBarItem alloc]initWithTitle:[oRes getText:@"car.carTabBarViewController.ElecFenceTabBarItem"] image:normalImage selectedImage:selectImage];
        
        normalImage = [[UIImage imageNamed:@"car_diagnosis_tabbar_NoSelectd"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        selectImage = [[UIImage imageNamed:@"car_diagnosis_tabbar_selectd"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vehicleDiagnosis.tabBarItem = [[UITabBarItem alloc]initWithTitle:[oRes getText:@"car.carTabBarViewController.vehicleDiagnosisTabBarItem"] image:normalImage selectedImage:selectImage];
    }
    else
    {
        vehicleControl.tabBarItem.title = [oRes getText:@"car.carTabBarViewController.vehicleControlTabBarItem"];
        vehicleStatus.tabBarItem.title = [oRes getText:@"car.carTabBarViewController.vehicleStatusTabBarItem"];
        ElecFence.tabBarItem.title = [oRes getText:@"car.carTabBarViewController.ElecFenceTabBarItem"];
        vehicleDiagnosis.tabBarItem.title = [oRes getText:@"car.carTabBarViewController.vehicleDiagnosisTabBarItem"];
        
        [vehicleControl.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"car_vehicleControl_tabbar_selectd"] withFinishedUnselectedImage:[UIImage imageNamed:@"car_vehicleControl_tabbar_NoSelectd"]];
        
        
        [vehicleStatus.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"car_vehicleStatus_tabbar_selectd"] withFinishedUnselectedImage:[UIImage imageNamed:@"car_vehicleStatus_tabbar_NoSelectd"]];
        
        
        [ElecFence.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"car_elecfence_tabbar_selectd"] withFinishedUnselectedImage:[UIImage imageNamed:@"car_elecfence_tabbar_NoSelectd"]];
        
        
        [vehicleDiagnosis.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"car_diagnosis_tabbar_selectd"] withFinishedUnselectedImage:[UIImage imageNamed:@"car_diagnosis_tabbar_NoSelectd"]];
    }
    
    
    
    self.tabBar.tintColor = [UIColor whiteColor];
    
    [vehicleControl.tabBarItem setTitleTextAttributes:@{ UITextAttributeFont : [UIFont size12]}forState:UIControlStateNormal];
    [vehicleStatus.tabBarItem setTitleTextAttributes:@{ UITextAttributeFont : [UIFont size12]}forState:UIControlStateNormal];
    [ElecFence.tabBarItem setTitleTextAttributes:@{ UITextAttributeFont : [UIFont size12]}forState:UIControlStateNormal];
    [vehicleDiagnosis.tabBarItem setTitleTextAttributes:@{ UITextAttributeFont : [UIFont size12]}forState:UIControlStateNormal];
    
    NSArray *views = @[vehicleControl,vehicleStatus,ElecFence,vehicleDiagnosis];
    
    [self setViewControllers:views animated:YES];
    
    _homeBtn = [[HomeButton alloc]init];
    [_homeBtn addTarget:self action:@selector(goBack)forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_homeBtn];
    
    SetParaButton* _setParaBt = [[SetParaButton alloc]init];
    [_setParaBt addTarget:self action:@selector(goSetPara)forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_setParaBt];
    [_setParaBt release];
    
    self.navigationItem.title =[oRes getText:@"car.carTabBarViewController.vehicleControlTabBarItem"];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadViewControllers];
    


}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    //NSLog(@"========!!!!!> %d",item.tag);
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    Resources *oRes = [Resources getInstance];
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.rightBarButtonItems = nil;
   // NSLog(@"----------->selectedIndex=%d",tabBarController.selectedIndex);
    
    if (viewController == vehicleControl) {
        NSLog(@"vehicleControl");
        self.navigationItem.title =[oRes getText:@"car.carTabBarViewController.vehicleControlTabBarItem"];
     //   [UIFont navBarTitleSize]
        SetParaButton* _setParaBt = [[SetParaButton alloc]init];
        [_setParaBt addTarget:self action:@selector(goSetPara)forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_setParaBt];
        [_setParaBt release];
        
        if (self.navigationItem.rightBarButtonItems.count>0)
        {
            UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            if([App getVersion]<IOS_VER_7) {
                space.width = -5.0;
            } else {
                space.width = -16.0;
            }
            self.navigationItem.rightBarButtonItems = [@[space] arrayByAddingObjectsFromArray:self.navigationItem.rightBarButtonItems];
        }
    }
    
    if (viewController == vehicleStatus) {
        NSLog(@"vehicleStatus");
        self.navigationItem.title = [oRes getText:@"car.carTabBarViewController.vehicleStatusTabBarItem"];
        
        RefreshButton* _refreshBt = [[RefreshButton alloc]init];
        [_refreshBt addTarget:self action:@selector(goRefresh)forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_refreshBt];
        [_refreshBt release];
        if (self.navigationItem.rightBarButtonItems.count>0)
        {
            UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            if([App getVersion]<IOS_VER_7) {
                space.width = -5.0;
            } else {
                space.width = -16.0;
            }
            self.navigationItem.rightBarButtonItems = [@[space] arrayByAddingObjectsFromArray:self.navigationItem.rightBarButtonItems];
        }
        
    }
    
    if (viewController == ElecFence) {
        NSLog(@"ElecFence");
        self.navigationItem.title = [oRes getText:@"car.carTabBarViewController.ElecFenceTabBarItem"];
        editState = EDIT_STATE;//设置编辑按钮的初始化状态
        _editBt = [[EditButton alloc]init];
        [_editBt addTarget:self action:@selector(goedit)forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_editBt];
        
        
        if (self.navigationItem.rightBarButtonItems.count>0)
        {
            UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            if([App getVersion]<IOS_VER_7) {
                space.width = -5.0;
            } else {
                space.width = -16.0;
            }
            self.navigationItem.rightBarButtonItems = [@[space] arrayByAddingObjectsFromArray:self.navigationItem.rightBarButtonItems];
        }
    }
    
    if (viewController == vehicleDiagnosis) {
        NSLog(@"vehicleDiagnosis");
        self.navigationItem.title = [oRes getText:@"car.carTabBarViewController.vehicleDiagnosisTabBarItem"];
        
//        DiagnosisButton* _DiagnosisBt = [[DiagnosisButton alloc]init];
//        [_DiagnosisBt addTarget:self action:@selector(goDiagnosis)forControlEvents:UIControlEventTouchUpInside];
//        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_DiagnosisBt];
//        [_DiagnosisBt release];
        
        if (self.navigationItem.rightBarButtonItems.count>0)
        {
            UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            if([App getVersion]<IOS_VER_7) {
                space.width = -5.0;
            } else {
                space.width = -16.0;
            }
            self.navigationItem.rightBarButtonItems = [@[space] arrayByAddingObjectsFromArray:self.navigationItem.rightBarButtonItems];
        }
    }
    
    return YES;
}

#pragma mark buttonDelegate
/*!
 @method goBack
 @abstract 返回上一级viewController
 @discussion 返回上一级viewController
 @result 无
 */
- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
/*!
 @method goSetPara
 @abstract 进入设置参数界面
 @discussion 进入设置参数界面
 @result 无
 */
- (void)goSetPara
{
    
    SetParameterViewController *setParameter;
    //适配iphone4S
    enum SCREEN_SIZE   deviceSize = [App getScreenSize];
    if (deviceSize == SCREEN_SIZE_960_640)
    {
        setParameter = [[SetParameterViewController alloc]initWithNibName:@"SetParameterViewController4" bundle:nil];
    }
    else
    {
        setParameter = [[SetParameterViewController alloc]initWithNibName:@"SetParameterViewController" bundle:nil];
    }
    [self.navigationController pushViewController:setParameter animated:YES];
    [setParameter release];
    
}
/*!
 @method goRefresh
 @abstract 发送刷新网络请求
 @discussion 发送刷新网络请求
 @result 无
 */
- (void)goRefresh
{
    [vehicleStatus sendrequest];
}
/*!
 @method goedit
 @abstract 进入tableView编辑模式
 @discussion 进入tableView编辑模式
 @result 无
 */
- (void)goedit
{
     Resources *oRes = [Resources getInstance];
    if (editState ==EDIT_STATE) {
        editState = FINIS_STATE;
        [_editBt setTitle:[oRes getText:@"car.ElecFenceViewController.rightButtonFinishButton"] forState:UIControlStateNormal];
        [ElecFence tableViewEdit];
        

    }
    else
    {
        editState =EDIT_STATE;
        [_editBt setTitle:[oRes getText:@"Car.ElecFenceViewController.editButton"] forState:UIControlStateNormal];
        [ElecFence submitData];
        [ElecFence tableViewFinish];
        

    }
    

}
/*!
 @method goDiagnosis
 @abstract 发送诊断网络请求
 @discussion 发送诊断网络请求
 @result 无
 */
- (void)goDiagnosis
{
    [vehicleDiagnosis sendrequest];
}
#pragma mark MemoryWarning
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_editBt release];
    [vehicleControl release];
    [vehicleStatus release];
    [ElecFence release];
    [vehicleDiagnosis release];
    [_homeBtn release];

    [super dealloc];
}

@end
