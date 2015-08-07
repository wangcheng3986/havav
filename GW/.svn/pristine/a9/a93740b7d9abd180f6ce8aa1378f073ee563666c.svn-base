
/*!
 @header POIMapViewController.m
 @abstract 地图类
 @author mengy
 @version 1.00 13-4-27 Creation
 */
#import "POIMapViewController.h"
#import "App.h"
#import "POIDetailViewController.h"
@interface POIMapViewController ()
{
    MapPoiData *poi;
    BOOL normalExit;
    double Lon;
    double Lat;
    UIBarButtonItem *leftBarItem;
}
@end

@implementation POIMapViewController

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
    if (titleLabel) {
        [titleLabel removeFromSuperview];
        [titleLabel release];
    }
    if (backBtn) {
        [backBtn removeFromSuperview];
        [backBtn release];
    }
    if (leftBarItem) {
        [leftBarItem release];
        leftBarItem = nil;
    }
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //加载界面信息
    normalExit=NO;
    if([App getVersion]>=IOS_VER_7){
        [App ios7ViewLocation:self];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_ios7_navBar_bg"] forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_ios6_navBar_bg"] forBarMetrics:UIBarMetricsLandscapePhone];
    }
    
    backBtn = [[LeftButton alloc]init];
    [backBtn addTarget:self action:@selector(goBack)forControlEvents:UIControlEventTouchUpInside];
    leftBarItem =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem =leftBarItem;
    [self loadMapView];
    

}

//加载地图界面
-(void)loadMapView
{
    //    加载地图界面
    
    [self setMapView:_mapView];
    self.LongPressure = NO;
    self.requestReverseGeoFlag = NO;
    [self loadMapBaseParameter];
    [_mapView initDataDic];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //设置指南针消失
    [_mapView.mapViewShare.mapView setShowDirection:NO image:nil];
    [_mapView.mapViewShare.mapView setScalePoint:CGPointMake(5.0,10.0)];
    NIMapStatus *ptemp = [[NIMapStatus alloc]init];
    ptemp.fLevel = MAP_DEFAULT_ZOOM;
    CGPoint target;
    target.x =(_mapView.frame.size.width/2)*2;
    target.y = (_mapView.frame.size.height/2)*2;
    ptemp.targetScreenPt = target;
    
    ptemp.targetGeoPt = poi.coordinate;
    
    //动画移动到中心点
    [_mapView.mapViewShare.mapView setMapStatus:ptemp withAnimation:NO];
    [ptemp release];
    
}


- (void)mapLoadFinish:(NIMapView *)mapView
{
    
    [self addOneAnnotation:poi];
    
    
}


- (void)viewWillDisappear:(BOOL)animated
{
    
    [self releasePaopao];
    [self removeOnePoint];
    [super viewWillDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}




-(void)goBack
{
    [self popself];
}

-(void)popself

{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)setPOI:(MapPoiData *)POI;
{
    poi=POI;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//隐藏气泡
-(void)hidePaopao{
    if (viewPaopao != nil)
    {
        viewPaopao.visable = NO;
        viewPaopao.enabled = NO;
    }
}

-(void)releasePaopao{
    if (ppAnnotation) {
        [_mapView.mapViewShare.mapView removeAnnotation:ppAnnotation];
        [ppAnnotation release];
        ppAnnotation = nil;
    }
    if (viewPaopao) {
        [viewPaopao release];
        viewPaopao = nil;
    }
}

/**
 *点中底图空白处会回调此接口
 *@param mapview 地图View
 *@param coordinate 空白处坐标点的经纬度
 */
- (void)mapView:(NIMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate{
    [self hidePaopao];
    
    if ([_mapView.POIData objectForKey:BUBBLE_INFO_KEY])
    {
        [_mapView.POIData removeObjectForKey:BUBBLE_INFO_KEY];
    }
}

// 当点击annotation view时，调用此接口
- (void)mapView:(NIMapView *)mapView onClickedAnnotation:(id <NIAnnotation>)annotation
{
    [self showBubble:annotation];
    
    MapPoiData* tempData = [[MapPoiData alloc]init];
    tempData.mID = annotation.annotationID;
    tempData.coordinate = [annotation coordinate];
    tempData.mName = annotation.title;
    tempData.mAddress = annotation.subtitle;
    
    [_mapView.POIData setObject:tempData forKey:BUBBLE_INFO_KEY];
    [tempData release];
    
    
    [_mapView.mapViewShare.mapView setCenter:tempData.coordinate];
    
    //    NIMapStatus *ptemp = [[NIMapStatus alloc]init];
    //    ptemp.fLevel = _mapView.mapViewShare.mapView.mapStatus.fLevel;
    //    ptemp.targetGeoPt = [annotation coordinate];
    //    ptemp.fRotation = _mapView.mapViewShare.mapView.mapStatus.fRotation;
    //    //动画移动到中心点
    //    [_mapView.mapViewShare.mapView setMapStatus:ptemp withAnimation:YES];
    //    [ptemp release];
    
}

//弹出泡泡
-(void)showBubble:(id <NIAnnotation>)annotation
{
    if (ppAnnotation == nil)
    {
        ppAnnotation = [[NIActionPaopaoAnnotation alloc]initWithMapView:_mapView.mapViewShare.mapView];
        ppAnnotation.annotationID = annotation.annotationID;
        ppAnnotation.title = annotation.title;
        ppAnnotation.subtitle =annotation.subtitle;
        ppAnnotation.coordinate = [annotation coordinate];
        [_mapView.mapViewShare.mapView addAnnotation:ppAnnotation];
        NSLog(@"showBubble -init");
    }
    else{
        NSLog(@"showBubble -update");
        ppAnnotation.annotationID = annotation.annotationID;
        ppAnnotation.title = annotation.title;
        ppAnnotation.subtitle = annotation.subtitle;
        ppAnnotation.coordinate = [annotation coordinate];
        
        viewPaopao.image = [self getPaoPaoImage:ppAnnotation];
        [_mapView.mapViewShare.mapView updateAnnotation:ppAnnotation withAnnotationView:viewPaopao];
        viewPaopao.visable = YES;
        viewPaopao.enabled = YES;
        NSLog(@"viewPaopao.priority>>>>>>>>>>>>%d",viewPaopao.priority);
    }
}

-(UIImage*)getPaoPaoImage:(id <NIAnnotation>)annotation{
    UIImage *imageNormal;
    
    if([App getVersion] <= IOS_VER_5)
    {
        imageNormal = [[UIImage imageNamed:@"icon_paopao_middle_left.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0,10,0,8)];
    }
    else
    {
        imageNormal = [[UIImage imageNamed:@"icon_paopao_middle_left.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0,10,0,8)resizingMode:UIImageResizingModeStretch];
    }
    NSLog(@"%f",imageNormal.size.height);
    UIImageView *leftBgd = [[UIImageView alloc]initWithImage:imageNormal];
    
    
    if([App getVersion] <= IOS_VER_5)
    {
        imageNormal = [[UIImage imageNamed:@"icon_paopao_middle_right.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0,8,0,10)];
    }
    else
    {
        imageNormal = [[UIImage imageNamed:@"icon_paopao_middle_right.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0,8,0,10)resizingMode:UIImageResizingModeStretch];
    }
    UIImageView *rightBgd = [[UIImageView alloc] initWithImage:imageNormal];
    
    
    //》》》》    mengy
    
    
    NSString* textlable = annotation.subtitle;
    NSString *titleTextlable =annotation.title;
    
    NSInteger textCount =textlable.length;
    NSInteger titleCount = titleTextlable.length;
    CGFloat width = 0;
    
    if (titleCount >= 15) {
        width =15*17;
    }
    else if (titleCount > textCount)
    {
        width =titleCount*17;
    }
    else
    {
        if (textCount>=15) {
            width = (15*15 >= titleCount*17)?15*15:titleCount*17;
        }
        else
        {
            width = (textCount*15 >= titleCount*17)?textCount*15:titleCount*17;
        }
    }
    
    //《《《《      mengy
    
    
    // 》》》》    wangcheng
    //    NSString* textlable = annotation.subtitle;
    //    CGFloat width = (textlable.length)*15;
    //《《《《      wangcheng
    
    
    UIView *viewForImage = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width,imageNormal.size.height)];
    leftBgd.frame = CGRectMake(0, 0, width/2,imageNormal.size.height);
    rightBgd.frame = CGRectMake(width/2, 0, width/2,imageNormal.size.height);
    [viewForImage addSubview:leftBgd];
    [viewForImage sendSubviewToBack:leftBgd];
    [viewForImage addSubview:rightBgd];
    [viewForImage sendSubviewToBack:rightBgd];
    [leftBgd release];
    [rightBgd release];
    //》》》》    mengy
    
    UILabel *title;
    
    if (titleCount > 15 )
    {
        title =[[UILabel alloc]initWithFrame:CGRectMake(15,0,width-20,imageNormal.size.height/2)];
    }
    else
    {
        title =[[UILabel alloc]initWithFrame:CGRectMake(0,0,width,imageNormal.size.height/2)];
    }
    
    //《《《《      mengy
    
    //》》》》    wangcheng
    //    UILabel *title =[[UILabel alloc]initWithFrame:CGRectMake(0,0,width,imageNormal.size.height/2)];
    //《《《《      wangcheng
    title.textColor = [UIColor blackColor];
    title.backgroundColor=[UIColor clearColor];
    title.font = [UIFont systemFontOfSize:15.0];
    title.text=annotation.title;
    title.textAlignment = NSTextAlignmentCenter;
    [viewForImage addSubview:title];
    [title release];
    
    //》》》》    mengy
    //    UILabel *label;
    UILabel *label;
    if (textCount>15)
    {
        label=[[UILabel alloc]initWithFrame:CGRectMake(15,imageNormal.size.height/2-10,width-20,imageNormal.size.height/2)];
    } else {
        label=[[UILabel alloc]initWithFrame:CGRectMake(0,imageNormal.size.height/2-10,width,imageNormal.size.height/2)];
    }
    
    label.text=annotation.subtitle;
    //《《《《      mengy
    
    
    //》》》》    wangcheng
    //    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0,imageNormal.size.height/2-10,width,imageNormal.size.height/2)];
    //《《《《      wangcheng
    label.text=annotation.subtitle;
    label.font = [UIFont systemFontOfSize:13.0];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor=[UIColor clearColor];
    [viewForImage addSubview:label];
    [label release];
    return [self getImageFromView:viewForImage];
}

#pragma 复写父类方法，为了改变泡泡位置
- (NIAnnotationView *)mapView:(NIMapView *)mapView viewForAnnotation:(id <NIAnnotation>)annotation
{
     NSLog(@"开始执行viewForAnnotation");
    if ([annotation isKindOfClass:[NIPointAnnotation class]] )
    {
        NSString *AnnotationViewID = @"pointMark";
        NIAnnotationView* viewPoint = [[[NIPinAnnotationView alloc] initWithNIMapView:mapView reuseIdentifier:AnnotationViewID]autorelease];
        viewPoint.priority = 11;
        int pointID = annotation.annotationID;
        if (pointID == ID_POI_CUSTOM || pointID == ID_POI_URL) {
            viewPoint.image = [UIImage imageNamed:[NSString stringWithFormat:@"map_position_ic"]];
        }
        else
        {
            viewPoint.image = [UIImage imageNamed:[NSString stringWithFormat:@"map_result_map_ic_%d",pointID]];
        }
        
        NSAssert(viewPoint.image, @"viewPoint.image must not be nil.");
        NSAssert(viewPoint, @"viewPoint must not be nil.");
        NSLog(@"结束执行viewForAnnotation");
        return viewPoint;
    }
    else if ([annotation isKindOfClass:[NIActionPaopaoAnnotation class]] ) {
        
        NSString *AnnotationViewID = @"paopaoMark";
        if (viewPaopao == nil) {
        
        viewPaopao = [[NIActionPaopaoView alloc] initWithNIMapView:mapView reuseIdentifier:AnnotationViewID];
            UIImage *imageNormal;
            
            if([App getVersion] <= IOS_VER_5)
            {
                imageNormal = [[UIImage imageNamed:@"icon_paopao_middle_left.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0,10,0,8)];
            }
            else
            {
                imageNormal = [[UIImage imageNamed:@"icon_paopao_middle_left.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0,10,0,8)resizingMode:UIImageResizingModeStretch];
            }
            NSLog(@"%f",imageNormal.size.height);
            UIImageView *leftBgd = [[UIImageView alloc]initWithImage:imageNormal];
            
            
            if([App getVersion] <= IOS_VER_5)
            {
                imageNormal = [[UIImage imageNamed:@"icon_paopao_middle_right.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0,8,0,10)];
            }
            else
            {
                imageNormal = [[UIImage imageNamed:@"icon_paopao_middle_right.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0,8,0,10)resizingMode:UIImageResizingModeStretch];
            }
            UIImageView *rightBgd = [[UIImageView alloc] initWithImage:imageNormal];
            
            NSString* textlable = annotation.subtitle;
            NSString *titleTextlable =annotation.title;
            
            NSInteger textCount =textlable.length;
            NSInteger titleCount = titleTextlable.length;
            CGFloat width = 0;
            
            if (titleCount >= 15) {
                width =15*17;
            }
            else if (titleCount > textCount)
            {
                width =titleCount*17;
            }
            else
            {
                if (textCount>=15) {
                    width = (15*15 >= titleCount*17)?15*15:titleCount*17;
                }
                else
                {
                    width = (textCount*15 >= titleCount*17)?textCount*15:titleCount*17;
                }
            }
            
            UIView *viewForImage = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width,imageNormal.size.height)];
            leftBgd.frame = CGRectMake(0, 0, width/2,imageNormal.size.height);
            rightBgd.frame = CGRectMake(width/2, 0, width/2,imageNormal.size.height);
            [viewForImage addSubview:leftBgd];
            [viewForImage sendSubviewToBack:leftBgd];
            [viewForImage addSubview:rightBgd];
            [viewForImage sendSubviewToBack:rightBgd];
            [leftBgd release];
            [rightBgd release];
            UILabel *title;
            
            if (titleCount > 15 )
            {
                title =[[UILabel alloc]initWithFrame:CGRectMake(15,0,width-20,imageNormal.size.height/2)];
            }
            else
            {
                title =[[UILabel alloc]initWithFrame:CGRectMake(0,0,width,imageNormal.size.height/2)];
            }
            
            title.textColor = [UIColor blackColor];
            title.backgroundColor=[UIColor clearColor];
            title.font = [UIFont systemFontOfSize:15.0];
            title.text=annotation.title;
            title.textAlignment = NSTextAlignmentCenter;
            [viewForImage addSubview:title];
            [title release];
            
            UILabel *label;
            if (textCount>15)
            {
                label=[[UILabel alloc]initWithFrame:CGRectMake(15,imageNormal.size.height/2-10,width-20,imageNormal.size.height/2)];
            } else {
                label=[[UILabel alloc]initWithFrame:CGRectMake(0,imageNormal.size.height/2-10,width,imageNormal.size.height/2)];
            }
            
            label.text=annotation.subtitle;
            label.font = [UIFont systemFontOfSize:13.0];
            label.textColor = [UIColor blackColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.backgroundColor=[UIColor clearColor];
            label.lineBreakMode = NSLineBreakByTruncatingTail;
            [viewForImage addSubview:label];
            [label release];
            
            //其中30是气泡的偏移量，上为正，下为负
            [viewPaopao setAnchor:NIAnchorMake(0.5f,MAP_DEFAULT_PAOPAO_HIGHT)];
            
            viewPaopao.priority = 20;
            viewPaopao.image = [self getImageFromView:viewForImage];
            NSLog(@"%f",viewPaopao.image.size.height);
        }
        NSLog(@"%@",viewPaopao);
        if (viewPaopao.image == nil) {
            NSLog(@"viewPaopao.image == nil");
        }
        NSAssert(viewPaopao.image, @"viewPaopao.image must not be nil.");
        NSAssert(viewPaopao, @"viewPaopao must not be nil.");
        NSLog(@"结束执行viewForAnnotation");
        return viewPaopao;
        
    }
    
    
    NSLog(@"结束执行viewForAnnotation");
    return nil;
}



-(UIImage *)getImageFromView:(UIView *)view{
    if(view !=nil)
    {
        NSLog(@"getImageFromView--------start %@",view);
        if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2)
            UIGraphicsBeginImageContextWithOptions(view.bounds.size,NO,2);
        else
            UIGraphicsBeginImageContext(view.bounds.size);
        [view.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        NSLog(@"getImageFromView--------end %@",image);
//        [view release];
        return image;
        
    }
    else
    {
        return nil;
    }
    
}


//地图上添加单个大头针标注
- (void)addOneAnnotation:(MapPoiData*)coordData
{
    NSLog(@"开始addOneAnnotation");
    onePoint = [[NIPointAnnotation alloc]initWithMapView:_mapViewBase.mapViewShare.mapView];
    
    onePoint.title = coordData.mName;
    onePoint.subtitle = coordData.mAddress;
    onePoint.annotationID = coordData.mID;
    onePoint.coordinate = coordData.coordinate;
    
    [_mapView.mapViewShare.mapView setCenter:coordData.coordinate];
    [_mapView.mapViewShare.mapView addAnnotation:onePoint];
    NSLog(@"结束addOneAnnotation");
}


//移除自定义大头针
-(void)removeOnePoint
{
    if (onePoint != nil)
    {
        [_mapView.mapViewShare.mapView removeAnnotation:onePoint];
        [onePoint release];
        onePoint=nil;
    }
    
}

@end
