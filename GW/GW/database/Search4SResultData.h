
/*!
 @header Search4SResultData.h
 @abstract 定义Search4SResult结构
 @author mengy
 @version 1.00 14-9-18 Creation
 */
#import <Foundation/Foundation.h>
/*!
 @class
 @abstract 定义Search4SResult结构
 */
@interface Search4SResultData : NSObject
{
    NSString *mKeyID;
    NSString *mID;
    NSString *mLon;
    NSString *mLat;
    NSString *mName;
    NSString *mLevel;
    NSString *mStartOpenTime;
    NSString *mEndOpenTime;
    NSString *mBrandAgent;
    NSString *mtel;
    NSString *mAddress;
    NSString *mDistance;
    
}
@property(nonatomic,copy)NSString *mKeyID;
@property(nonatomic,copy)NSString *mID;
@property(nonatomic,copy)NSString *mLon;
@property(nonatomic,copy)NSString *mLat;
@property(nonatomic,copy)NSString *mName;
@property(nonatomic,copy)NSString *mLevel;
@property(nonatomic,copy)NSString *mStartOpenTime;
@property(nonatomic,copy)NSString *mEndOpenTime;
@property(nonatomic,copy)NSString *mBrandAgent;
@property(nonatomic,copy)NSString *mtel;
@property(nonatomic,copy)NSString *mAddress;
@property(nonatomic,copy)NSString *mDistance;
@end