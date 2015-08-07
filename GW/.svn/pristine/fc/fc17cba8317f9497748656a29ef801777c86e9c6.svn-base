/*!
 @header ProtocolViewController.m
 @abstract 协议类
 @author mengy
 @version 1.00 14-7-28 Creation
 */
#import "ProtocolViewController.h"

@interface ProtocolViewController ()
{
    
    UIWebView *webView;
    LeftButton *leftBtn;
    UIBarButtonItem *leftBarBtnItem;
}

@end

@implementation ProtocolViewController

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
    if (webView != nil) {
        [webView removeFromSuperview];
        [webView release];
        webView = nil;
    }
    if (leftBtn) {
        [leftBtn release];
        leftBtn = nil;
    }
    
    if (leftBarBtnItem) {
        [leftBarBtnItem release];
        leftBarBtnItem = nil;
    }
    [super dealloc];
}

/*!
 @method viewDidLoad
 @abstract 重写viewDidLoad方法，初始化界面显示以及数据信息
 @discussion 重写viewDidLoad方法，初始化界面显示以及数据信息
 @param 无
 @result 无
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    Resources *oRes = [Resources getInstance];
    leftBtn = [[LeftButton alloc]init];
    [leftBtn addTarget:self action:@selector(popself) forControlEvents:UIControlEventTouchDown];
    leftBarBtnItem=[[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarBtnItem;
//    titleLabel.text = [oRes getText:@"OpenTSevice.protocol.Title"];
//    titleLabel.font = [UIFont navBarTitleSize];
//    self.navigationItem.titleView = titleLabel;
    self.navigationItem.title=[oRes getText:@"OpenTSevice.protocol.Title"];
    [self openBrowserByWebView];
    // Do any additional setup after loading the view from its nib.
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


/*!
 @method openBrowserByWebView
 @abstract 加载WebView
 @discussion 加载WebView
 @param 无
 @result 无
 */
-(void)openBrowserByWebView
{
    self.view.backgroundColor = [UIColor whiteColor];
//    webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    CGRect rect_screen = [[UIScreen mainScreen]bounds];
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(rect_screen.origin.x, rect_screen.origin.y, rect_screen.size.width, rect_screen.size.height-64)];
    webView.scalesPageToFit = YES;
    [self.view addSubview:webView];
    //app中的html
    [self loadDocument:@"terms.html"];
    
}

/*!
 @method loadDocument:(NSString*)docName
 @abstract 加载html
 @discussion 加载html
 @param 无
 @result 无
 */
- (void)loadDocument:(NSString*)docName {
    
    
    NSString *mainBundleDirectory = [[NSBundle mainBundle] bundlePath];
    NSString *path = [mainBundleDirectory  stringByAppendingPathComponent:docName];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    webView.scalesPageToFit = YES;
    [webView loadRequest:request];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
