
/*!
 @header SystemMessageDetailViewController.m
 @abstract 系统消息类
 @author mengy
 @version 1.00 13-5-3 Creation
 */
#import "SystemMessageDetailViewController.h"
#import "App.h"
@interface SystemMessageDetailViewController ()
{
    NSString *keyID;
}
@end

@implementation SystemMessageDetailViewController

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
    [titleLabel release],titleLabel = nil;
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
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_ios7_navBar_bg"] forBarMetrics:UIBarMetricsDefault];
        //[self.navigationController.navigationBar setShadowImage:[UIImage imageNamed:@"common_ios7_shadowImage_bg"]];
    }
    else
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_ios6_navBar_bg"] forBarMetrics:UIBarMetricsLandscapePhone];
    }
    Resources *oRes = [Resources getInstance];
//    titleLabel.text=[oRes getText:@"message.systemMessageViewController.title"];
//    titleLabel.font =[UIFont navBarTitleSize];
//    titleLabel.textColor=[UIColor whiteColor];
//    self.navigationItem.titleView=titleLabel;
    
    self.navigationItem.title=[oRes getText:@"message.systemMessageViewController.title"];
    
    // Do any additional setup after loading the view from its nib.
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
