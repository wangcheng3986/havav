

/*!
 @header PosData.h
 @abstract 定义PosData结构
 @author kexin
 @version 1.00 12-7-23 Creation
 */


#import <Foundation/Foundation.h>

@interface PosData : NSObject
{
    double      mLng;
    double      mLat;
}

@property(assign)double mLng;
@property(assign)double mLat;

@end
