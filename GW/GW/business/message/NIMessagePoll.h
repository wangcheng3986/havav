
/*!
 @header NIMessagePoll.h
 @abstract 发送到车消息类
 @author 王 立琼
 @version 1.00 13-7-16 Creation
 */
#import <Foundation/Foundation.h>
#import "NIGetNotificationsList.h"
#import "BaseViewController.h"
#import "CherryDBControl.h"
#import <EventKit/EventKit.h>

@interface NIMessagePoll : NSObject<NIGetNotificationsListDelegate>
{
//    NILocationService *mLocationService;
    NIGetNotificationsList *mNotifications;
    NSTimer *mTimer;
    NSString *mLastReqTime;
//    NSString *address;
    NSMutableArray *frindLocationArray;
    NSMutableArray *vehicleStatusArray;
    NSMutableDictionary *vehicleControlDic;
    NSMutableArray *vehicleDiagnosisArray;
}

//@property(nonatomic,retain) NSTimer *mTimer;
//@property(nonatomic,retain) NSString *mLastReqTime;

- (void)start;
- (void)stop;
/*!
 @method getMessage
 @abstract 获取消息
 @discussion 获取消息
 @param 无
 @result 无
 */
-(void)getMessage;
@end
