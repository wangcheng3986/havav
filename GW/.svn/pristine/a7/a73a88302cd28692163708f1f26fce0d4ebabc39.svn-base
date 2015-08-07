
/*!
 @header ElectronicFenceDetailViewController.m
 @abstract 电子围栏消息类
 @author mengy
 @version 1.00 13-5-2 Creation
 */
#import "ElectronicFenceDetailViewController.h"
#import "App.h"
@interface ElectronicFenceDetailViewController ()
{
    NSString *keyID;
    ElectronicFenceMessageData *mData;
}
@end

@implementation ElectronicFenceDetailViewController

- (void)dealloc
{
    [titleLabel release]; titleLabel = nil;
    [timeTitleLabel release]; timeTitleLabel = nil;
    [timeLabel release]; timeLabel = nil;
    [carNumTitleLabel release]; carNumTitleLabel = nil;
    [carNumLabel release]; carNumLabel = nil;
    [addressTitleLabel release]; addressTitleLabel = nil;
    [addressTextView release]; addressTextView = nil;
    [explainTitleLabel release]; explainTitleLabel = nil;
    [explainTextView release]; explainTextView = nil;
    if (_mapView.POIData) {
        [_mapView.POIData removeAllObjects];
        [_mapView.POIData release];
        _mapView.POIData = nil;
    }
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
    }
    else
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_ios6_navBar_bg"] forBarMetrics:UIBarMetricsLandscapePhone];
        addressTextView.frame = CGRectMake(addressTextView.frame.origin.x-3,addressTextView.frame.origin.y,addressTextView.frame.size.width+3,addressTextView.frame.size.height);
    }
//    if ([App getScreenSize]==SCREEN_SIZE_1136_640) {
//        CGRect rec;
//        rec=mLocationText.frame;
//        rec.origin.y=rec.origin.y+4;
//        mLocationText.frame=rec;
//    }
    mCherryDBControl = [CherryDBControl sharedCherryDBControl];
    Resources *oRes = [Resources getInstance];
    
    addressTextView.editable=NO;
    explainTextView.editable=NO;
    
    mData = [mCherryDBControl loadMeetReqElectronicFenceMessageByKeyID:keyID];
    if ([mData.mAlarmType intValue] == 0) {
        
        self.navigationItem.title = [oRes getText:@"message.ElecFenceDetailViewController.intoTitle"];
    }
    else
    {
        
        self.navigationItem.title = [oRes getText:@"message.ElecFenceDetailViewController.outTitle"];
    }

    NSLog(@"electronic.frame = %f,%f,%f,%f",self.navigationItem.titleView.frame.origin.x,self.navigationItem.titleView.frame.origin.y,self.navigationItem.titleView.frame.size.height,self.navigationItem.titleView.frame.size.width);

    timeTitleLabel.text = [oRes getText:@"message.ElecFenceDetailViewController.timeTitle"];
    carNumTitleLabel.text = [oRes getText:@"message.ElecFenceDetailViewController.carNumTitle"];
    addressTitleLabel.text = [oRes getText:@"message.ElecFenceDetailViewController.addressTitle"];
    explainTitleLabel.text = [oRes getText:@"message.ElecFenceDetailViewController.explainTitle"];
    timeTitleLabel.font = [UIFont size15];
    carNumTitleLabel.font = [UIFont size15];
    addressTitleLabel.font = [UIFont size15];
    explainTitleLabel.font = [UIFont size15];
    timeLabel.font = [UIFont size15];
    addressTextView.font = [UIFont size15];
    explainTextView.font = [UIFont size15];
    carNumLabel.font = [UIFont size15];
    timeTitleLabel.textColor = [UIColor colorWithRed:27.0/255.0f green:27.0/255.0f blue:27.0/255.0f alpha:1];
    addressTitleLabel.textColor = [UIColor colorWithRed:27.0/255.0f green:27.0/255.0f blue:27.0/255.0f alpha:1];
    explainTitleLabel.textColor = [UIColor colorWithRed:27.0/255.0f green:27.0/255.0f blue:27.0/255.0f alpha:1];
    carNumTitleLabel.textColor = [UIColor colorWithRed:27.0/255.0f green:27.0/255.0f blue:27.0/255.0f alpha:1];
    
    timeLabel.textColor = [UIColor colorWithRed:129.0/255.0f green:129.0/255.0f blue:129.0/255.0f alpha:1];
    addressTextView.textColor = [UIColor colorWithRed:129.0/255.0f green:129.0/255.0f blue:129.0/255.0f alpha:1];
    explainTextView.textColor = [UIColor colorWithRed:129.0/255.0f green:129.0/255.0f blue:129.0/255.0f alpha:1];
    carNumLabel.textColor = [UIColor colorWithRed:129.0/255.0f green:129.0/255.0f blue:129.0/255.0f alpha:1];
    self.view.backgroundColor = [UIColor colorWithRed:231.0/255.0f green:231.0/255.0f blue:231.0/255.0f alpha:1];
    
    self.view.backgroundColor = [UIColor colorWithRed:231.0/255.0f green:231.0/255.0f blue:231.0/255.0f alpha:1];
    [self initMessage];
    
    [self initMapView];
}


     
/*!
 @method initMapView
 @abstract 初始化地图
 @discussion 初始化地图
 @param 无
 @result 无
 */
 -(void)initMapView
{
    [self setMapView:_mapView];
    self.requestReverseGeoFlag = NO;
    self.LongPressure = NO;
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
    if(mData.mLat != 0 && mData.mLon != 0 )
    {
        [self setPOI];
        
        ptemp.targetGeoPt = CLLocationCoordinate2DMake(mData.mLat, mData.mLon);
    }
    else
    {
        ptemp.targetGeoPt = CLLocationCoordinate2DMake(MAP_DEFAULT_CENTER_LAT, MAP_DEFAULT_CENTER_LON);
    }
    
    //动画移动到中心点
    [_mapViewBase.mapViewShare.mapView setMapStatus:ptemp withAnimation:NO];
    [ptemp release];
}

- (void)viewDidAppear:(BOOL)animated
{

    [super viewDidAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self removeOnePoint];
    [self releasePaopao];
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}



/*!
 @method initMessage
 @abstract 加载消息信息
 @discussion 加载消息信息
 @param 无
 @result 无
 */
-(void)initMessage
{
    App *app =[App getInstance];
    Resources *oRes = [Resources getInstance];
    NSString *type = @"";
    if ([mData.mAlarmType intValue] == 0) {
        type=[oRes getText:@"message.ElecFenceViewController.typeWithInto"];
    }
    else
    {
        type=[oRes getText:@"message.ElecFenceViewController.typeWithOut"];
    }
    timeLabel.text = [App getDateWithTimeSince1970:mData.mAlarmTime];
    carNumLabel.text = [app searchCarNum:mData.mMessageKeyID];
    addressTextView.text = mData.mAddress;
    NSString *messageinfo = [NSString stringWithFormat:@"%@%@%@%@%@。",[app searchCarNum:mData.mMessageKeyID],[oRes getText:@"message.ElecFenceViewController.message1"],[App getDateWithTimeSince1970:mData.mAlarmTime],[oRes getText:@"message.ElecFenceViewController.message2"],type];
    explainTextView.text = messageinfo;
    
}


/*!
 @method setPOI
 @abstract 向地图上描点
 @discussion 向地图上描点
 @param 无
 @result 无
 */
-(void)setPOI
{
    Resources *oRes = [Resources getInstance];
    
    MapPoiData *customPoi = [[MapPoiData alloc]initWithID:ID_POI_CUSTOM];
    customPoi.mName = [oRes getText:@"message.common.alarmPOITitle"];
    if (mData.mAddress && ![mData.mAddress isEqualToString:@"(null)"])
    {
        customPoi.mAddress = mData.mAddress;
    }
    customPoi.coordinate = CLLocationCoordinate2DMake(mData.mLat, mData.mLon);
    [self addOneAnnotation:customPoi];
    [customPoi release];
    
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

#pragma 复写父类方法，为了改变泡泡位置
- (NIAnnotationView *)mapView:(NIMapView *)mapView viewForAnnotation:(id <NIAnnotation>)annotation
{
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
        
        
        return viewPoint;
    }
    else if ([annotation isKindOfClass:[NIActionPaopaoAnnotation class]] ) {
        
        NSString *AnnotationViewID = @"paopaoMark";
        //        if (viewPaopao == nil) {
        
        NIActionPaopaoView* viewPaopao = [[[NIActionPaopaoView alloc] initWithNIMapView:mapView reuseIdentifier:AnnotationViewID]autorelease];
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
        //        }
        NSLog(@"%@",viewPaopao);
        return viewPaopao;
        
    }
    
    
    return nil;
}


-(UIImage *)getImageFromView:(UIView *)view{
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2)
        UIGraphicsBeginImageContextWithOptions(view.bounds.size,NO,2);
    else
        UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    [view release];
    UIGraphicsEndImageContext();
    return image;
}



@end
