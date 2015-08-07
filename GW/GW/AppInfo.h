//
//  AppInfo.h
//  VW
//
//  Created by kexin on 12-6-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#ifndef VW_AppInfo_h
#define VW_AppInfo_h

//Version
#define APP_VER         @"V0.60.201304010"
#define APP_UPDATE      @"01.04.2013"

//Fal enable
//#define FAL

//default
#define MAP_URL @"http://218.249.91.76:8003/Map/map.html"

//yangfan pc no zip
//#define MAP_URL @"http://192.168.0.111:8080/map/BASE/map.html"

//#define MAP_URL @"http://192.168.0.248:8080/Map/map.html"

//service
//#define MAP_URL @"http://192.168.0.248:8080/GIS/BASE/map.html"

//#define MAP_URL @"http://192.168.0.200/Map/map.html" 
//#define MAP_URL @"http://192.168.0.248:8080/GIS/BASE/map.html"

//#define MAP_URL @"http://218.249.91.76:8003/Maps/map.html"

//#define MAP_URL @"http://192.168.0.111:8080/Map/map.html"


#define ROUTE_URL @"http://vapi.fundrive.com.cn/route"
#define FAL_URL @"https://portals.htichina.cn.com/HTIWebGateway/GateWay"

#define NOTIFICATION_UPDATE                 @"notification_update"
#define NOTIFICATION_POI_UPDATE             @"poi_update"
#define NOTIFICATION_POI_RELOAD             @"poi_reload"
#define NOTIFICATION_POI_DELETE             @"del_poi_success"
#define NOTIFICATION_ADDRESSBOOK_CHANGE     @"addressbook_change"
#define NOTIFICATION_TRIP_OPTION_CHANGE     @"trip_option_change"
#define NOTIFICATION_CAR_STATUS_CHANGE      @"car_status_change"
#define NOTIFICATION_CAR_COMMAND_SUCCESS    @"car_command_success"
#define NOTIFICATION_CAR_COMMAND_FAIL       @"car_command_fail"
#define NOTIFICATION_DEL_TRIP_SUCCESS       @"del_trip_success"
#define NOTIFICATION_EVENTS_UPDATE          @"event_update"
#define NOTIFICATION_AGENDA_UPDATE          @"agenda_update"
//add liutch
#define NOTIFICATION_DEALER_SEARCH          @"dealer_search"
#define NOTIFICATION_MEETME_SEND            @"meetme_send"
#define NOTIFICATION_MEETME_ACCEPT          @"meetme_accept"
#define NOTIFICATION_MEETME_DECLINE         @"meetme_decline"
#define NOTIFICATION_MEETME_IGNORE          @"meetme_ignore"
#define NOTIFICATION_MEETME_CANCEL          @"meetme_cancel"
#define NOTIFICATION_MEETME_ADD             @"meetme_add"
#define NOTIFICATION_MEETME_CREATE          @"meetme_create_req"

#define NOTIFICATION_NAVIGATE_KEYWORD       @"navigate_keyword"
#define NOTIFICATION_NAVIGATE_AROUND        @"navigate_arround"
//add lvy
#define NOTIFICATION_SYNC_FRIENDS           @"update_friends"
#define NOTIFICATION_ADD_FAVOTITY           @"add_favority"
#define NOTIFICATION_ADD_FRIENDS            @"add_friends"
//Data
#define KEY_SAVE        @"save_username"
#define KEY_USERNAME    @"username"

#define IOS_VER_5   5.0
#define IOS_VER_6   6.0
#define IOS_VER_7   7.0
#define IOS_VER_8   8.0

#define iPhone_1G   @"iPhone 1G"
#define iPhone_3G   @"iPhone 3G"
#define iPhone_3GS   @"iPhone 3GS"
#define iPhone_4   @"iPhone 4"
#define iPhone_4S   @"iPhone 4S"
#define iPhone_5   @"iPhone 5"
#define iPhone_5S   @"iPhone 5S"

#define POI_GPS     @"gps"
#define POI_CAR     @"car"

#define UPDATE_CAR_STATUS_DELAY     (2 * 60)
#define UPDATE_CHECK_CAR_DELAY            20

//地图控件缩小的最小倍数
#define MAP_MIN_MULT                4

//微博发布sina
#define kAppKey_Sina             @"3225636532"
#define kAppSecret_Sina          @"5feccfc075aaa14eea6db49eb9a59181"
#define kAppRedirectURI_Sina     @"http://"
//开心
#define kAppKey_kaixin           @"554913663224ef6999687819abfba3d0"
#define kSecretKey_kaixin        @"35353680977eb73844dabca17210ab15"
#define kRedirectURL_kaixin      @"http://www.vw.com.cn/zh.html"
//豆瓣
#define kAPIKey_douban           @"0636d5379142626212a47fa6b3c72726"
#define kPrivateKey_douban       @"cc5c9281518236bd"
#define kRedirectUrl_douban      @"http://www.douban.com/location/mobile"

//QQ
#define kAppKey_QQ              @"801282335"
#define kSecretKey_QQ           @"09b28f35bda691e8d442765fb71093f4"
#define kRedirectUrl_QQ         @"http://www.vw.com.cn/zh.html"
//人人
#define kAppID_Renren          @"221344"
#define kAppKey_Renren         @"32c3ffc0673a48ef993e25f045e2984a"

@protocol BlogInterface <NSObject>

-(void)clearBlog;

@end

#define APP_DEBUG

#endif
