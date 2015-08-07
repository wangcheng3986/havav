/*!
 @header SearchResultData.m
 @abstract 定义SearchResult结构
 @author mengy
 @version 1.00 13-5-14 Creation
 */
#import "SearchResultData.h"
/*!
 @class
 @abstract 定义SearchResult结构
 */
@interface SearchResultData(Private)

@end
@implementation SearchResultData
@synthesize mUserID;
@synthesize mCreateTime;
@synthesize mAddress;
@synthesize mDesc;
@synthesize mID;
@synthesize mKeyID;
@synthesize mLat;
@synthesize mLon;
@synthesize mName;
@synthesize mPhone;
@synthesize mTypeName;
@synthesize mTypeCode;
@synthesize mDistance;
@synthesize mGid;
@synthesize mTelphone;
@synthesize mPostCode;


- (void)dealloc
{
    if (mUserID) {
        [mUserID release];
    }
    if (mCreateTime) {
        [mCreateTime release];
    }
    if (mAddress) {
        [mAddress release];
    }
    if (mDesc) {
        [mDesc release];
    }
    if (mID) {
        [mID release];
    }
    if (mKeyID) {
        [mKeyID release];
    }
    if (mLat) {
        [mLat release];
    }
    if (mLon) {
        [mLon release];
    }
    if (mName) {
        [mName release];
    }
    if (mPhone) {
        [mPhone release];
    }
    if (mTypeName) {
        [mTypeName release];
    }
    if (mTypeCode) {
        [mTypeCode release];
    }
    if (mDistance) {
        [mDistance release];
    }
    if (mGid) {
        [mGid release];
    }
    if (mTelphone) {
        [mTelphone release];
    }
    if (mPostCode) {
        [mPostCode release];
    }
    [super dealloc];
}
@end