//
//  NIOpenUIPData.m
//  author: wlq
//
//  Created by mac on 13-5-29.
//  Copyright (c) 2013 NavInfo. All rights reserved.
//
//  version 1.0 2013-5-30 wlq create.
//
//
//

#import "NIOpenUIPData.h"

@implementation NIOpenUIPData
@synthesize mutableDict;
//@synthesize KeyValue,TypeValue;
- (id)init
{
    self = [super init];
    mutableDict = [[NSMutableDictionary alloc] init];//[NSMutableDictionary dictionary];
//    [self setKeyValue:@"_v"];
//    [self setTypeValue:@"_c"];
    return self;
}

- (void)dealloc
{
    [mutableDict removeAllObjects];
    [mutableDict release];
    mutableDict=nil;
//    [KeyValue release];
//    [TypeValue release];
    
    [super dealloc];
}


//int,1
- (bool)setInt:(NSString *) key value:(int)value
{
//    NSMutableDictionary *sub1Dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:1],TypeValue,[NSNumber numberWithInteger:value],KeyValue,nil];
    
    [mutableDict setValue:[NSNumber numberWithInteger:value] forKey:key];
    
    //[sub1Dict release];
    return true;
}

//bstr is a string with Chinese characters, its type value is 2.
- (bool)setBstr:(NSString *) key value:(NSString *)value
{
//    //NSLog(@"value:%@", value);
//    //base 64 encode use the third parity GTMBase64.
//    NSData *data = [value dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
//    data = [GTMBase64 encodeData:data];
//    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    //NSLog(@"base64String:%@", base64String);
//
////    NSMutableDictionary *sub1Dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:base64String,KeyValue,[NSNumber numberWithInteger:2],TypeValue,nil];
//    
//    
//    [mutableDict setValue:value forKey:key];
//    [base64String release];
    
    
    
    NSString *tempValue = [[NSString alloc] initWithString: value];
    
    // NSMutableDictionary *sub1Dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:4],TypeValue,tempValue,KeyValue,nil];
    
    //[mutableDict setValue:sub1Dict forKey:key];
    [mutableDict setValue:tempValue forKey:key];
    [tempValue release];
    return true;
}

//long's type value is 3
- (bool)setLong:(NSString *)key value:(long long)value
{
//    NSMutableDictionary *sub1Dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:3],TypeValue,[NSNumber numberWithLongLong:value],KeyValue,nil];
    
    [mutableDict setValue:[NSNumber numberWithLongLong:value] forKey:key];
    return true;
}

//String's type value is 4.
- (bool)setString:(NSString *)key value:(NSString *)value
{
    NSString *tempValue = [[NSString alloc] initWithString: value];
    
   // NSMutableDictionary *sub1Dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:4],TypeValue,tempValue,KeyValue,nil];
    
    //[mutableDict setValue:sub1Dict forKey:key];
    [mutableDict setValue:tempValue forKey:key];
    [tempValue release];
    return true;
}

//long's type value is 5.
//- (bool)setTime: (NSString *)key date:(NSString *)value
//{
//    NSMutableDictionary *sub1Dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:5],TypeValue,value,KeyValue,nil];
//    
//    [mutableDict setValue:sub1Dict forKey:key];
//    return true;
//}

- (bool)setTime: (NSString *)key date:(long long)value
{
//    NSMutableDictionary *sub1Dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:5],TypeValue,[NSNumber numberWithLongLong:value],KeyValue,nil];
    
    [mutableDict setValue:[NSNumber numberWithLongLong:value] forKey:key];
    return true;
}


//boolean's type value is 6.
//- (bool)setBoolean:(NSString *)key value:(Boolean)value
//{
//    NSMutableDictionary *sub1Dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:6],TypeValue,[NSNumber numberWithUnsignedChar:value],KeyValue,nil];
//    [mutableDict setValue:sub1Dict forKey:key];
//    return true;
//}

- (bool)setBoolean:(NSString *)key value:(NSString *)value
{
//    NSMutableDictionary *sub1Dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:6],TypeValue,value,KeyValue,nil];
    [mutableDict setValue:value forKey:key];
    return true;
}

//float's type value is 7.
- (bool)setFloat:(NSString *)key value:(float)value
{
//    NSMutableDictionary *sub1Dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:7],TypeValue,[NSNumber numberWithFloat:value],KeyValue,nil];
    
    [mutableDict setValue:[NSNumber numberWithFloat:value] forKey:key];
 
    return true;
}

//double's type value is 8.
- (bool)setDouble:(NSString *)key value:(double)value
{
//    NSMutableDictionary *sub1Dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:8],TypeValue,[NSNumber numberWithDouble:value],KeyValue,nil];
    
    [mutableDict setValue:[NSNumber numberWithDouble:value] forKey:key];

    return true;
}

// Map's type value is 9.
- (bool)setObject:(NSString *)key object:(NSMutableDictionary *)object
{
//    NSMutableDictionary *sub1Dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:9],TypeValue,object.mutableDict,KeyValue,nil];
    
    [mutableDict setObject:object forKey:key];
     return true;
    
}

// List's type value is 10.
- (bool)setList:(NSString *) key list:(NSArray *)value 
{
 //   NSMutableArray *temp = [[[NSMutableArray alloc] init] autorelease] ;
    //transfor the array to JSON
//    for (id obj in value) {
//        NSMutableDictionary *sub1Dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:4],TypeValue,obj,KeyValue,nil];
//        [temp addObject:sub1Dict];
//    }
//    NSMutableDictionary *sub2Dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:10],TypeValue,temp,KeyValue,nil];

    
    [mutableDict setValue:value forKey:key];

    //[temp release];
    return true;
}


// List's type value is 10.
- (bool)setObjList:(NSString *)key list:(NSArray *)value
{    
/*          NSMutableArray *temp = [[[NSMutableArray alloc] init] retain];
          NSMutableDictionary *sub2Dict=[NSMutableDictionary dictionary];
          sub2Dict=[NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:10],TypeValue,value,KeyValue,nil];
         
          [mutableDict setValue:sub2Dict forKey:key];
          [sub2Dict release];
          [temp release];
          return true;*/
//    [value retain];
//    NSMutableArray *temp = [[[NSMutableArray alloc] init] autorelease];
//    //transfor the array to JSON
//    for (id obj in value) {
//        NSMutableDictionary *sub1Dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:9],TypeValue,obj,KeyValue,nil];
//        [temp addObject:sub1Dict];
//    }
//    NSMutableDictionary *sub2Dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:10],TypeValue,temp,KeyValue,nil];
    
    
    [mutableDict setValue:value forKey:key];
    //[temp release];
    return true;
}
    
    
//tranfor the mutableDict from NSDictionary to NSString.
- (NSString *)toString
{
    NSError *error=nil;
    //NSLog(@"mutableDict %@",mutableDict);
    NSData *JsonData=[NSJSONSerialization dataWithJSONObject:mutableDict options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        NSLog(@"Error %@",[error localizedDescription]);
    }
    
    NSString *aString = [[[NSString alloc] initWithData:JsonData encoding:NSUTF8StringEncoding] autorelease];
    //NSLog(@"aString %@",aString);

    return aString;
}


- (NSString *)formatDate:(NSDate *)date
{
    return NULL;
}

+ (NIOpenUIPData *)OpenUIPData
{
    return [[[NIOpenUIPData alloc] init] autorelease];
}
@end
