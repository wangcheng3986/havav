

/*!
 @header ElectronicFenceDetailViewController.h
 @abstract 电子围栏消息类
 @author mengy
 @version 1.00 13-5-2 Creation
 */
#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "NICommonFormatDefine.h"
#import "ElectronicFenceMessageData.h"
#import "CherryDBControl.h"
#import "UIMapBaseViewController.h"
#import "CustomMapView.h"
@interface ElectronicFenceDetailViewController : UIMapBaseViewController
{
    
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *timeTitleLabel;
    IBOutlet UILabel *timeLabel;
    
    IBOutlet UILabel *carNumTitleLabel;
    IBOutlet UILabel *carNumLabel;
    
    IBOutlet UILabel *addressTitleLabel;
    IBOutlet UITextView *addressTextView;
    
    IBOutlet UILabel *explainTitleLabel;
    IBOutlet UITextView *explainTextView;
    
    CherryDBControl *mCherryDBControl;
    IBOutlet CustomMapView* _mapView;
    //添加单个大头针标注 可以换图片
//    NIPointAnnotation* onePoint;
//    NIAnnotationView* viewPaopao;
//    //气泡
//    NIActionPaopaoAnnotation* ppAnnotation;
}
/*!
 @method setKeyID:(NSString *)keyid
 @abstract 设置keyid
 @discussion 设置keyid
 @param keyid
 @result 无
 */
-(void)setKeyID:(NSString *)keyid;
@end
