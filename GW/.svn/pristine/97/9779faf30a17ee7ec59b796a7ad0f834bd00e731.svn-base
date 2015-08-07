
/*!
 @header Resources.m
 @abstract 管理文字资源
 @author kexin
 @version 1.00 12-6-5 Creation
 */
#import "Resources.h"

static Resources *mRes = nil;
/*!
 @class
 @abstract 资源文字类。
 */
@interface Resources(Private)

- (id)init;

@end

@implementation Resources

- (id)init
{
    mDefList = nil;
    mDataList = [[NSMutableDictionary alloc]initWithCapacity:0];
    return [super init];
}

/*!
 @method getInstance
 @abstract 实例化Resources，单例
 @discussion 实例化Resources，单例
 @param 无
 @result self
 */
+(id)getInstance
{
    if(mRes == nil)
    {
        mRes = [[Resources alloc]init];
    }
    
    return mRes;
}

/*!
 @method dealloc
 @abstract 释放数据存储空间
 @discussion 释放数据存储空间
 @param 无
 @result 无
 */
- (void)dealloc
{
    [mDataList release];
    [super dealloc];
}

#pragma mark - Business Logic
-(void)setLanguage:(NSString*)language
{
    if(language)
    {
        mDefList = [mDataList objectForKey:language];
    }
}

/*!
 @method addTextFromFile:
 @abstract 从文件中读取文字信息
 @discussion 从文件中读取文字信息
 @param file 文件名
 @result 无
 */

-(void)addTextFromFile:(NSString*)file
{
    if(file)
    {
        NSData *oData = [[NSData alloc] initWithContentsOfFile:file];
        if(oData)
        {
            NSXMLParser *oParser = [[[NSXMLParser alloc]initWithData:oData]autorelease];
            [oParser setDelegate:self];
            [oParser parse];
        }
        [oData release];
    }
}


/*!
 @method getText:
 @abstract 获取文字资源
 @discussion 获取文字资源
 @param key
 @result text 文字
 */
-(NSString*)getText:(NSString*)key   //withOutEnter
{
    NSMutableString *text = nil;
    NSString * descript = nil;
    if(key && mDefList && [key length] != 0)
    {
        descript = [mDefList objectForKey:key];
        if (descript && [descript length] != 0) {
            text = [NSMutableString stringWithString:descript];
        }
    }
    if(text == nil)
    {
        text = [NSMutableString stringWithString:@"undefine"];
    }
    //[text replaceOccurrencesOfString:@"\n" withString:@" " options:NSCaseInsensitiveSearch range:NSMakeRange(0, [text length])];
    return text;
}

/*!
 @method getTextWithEnter:
 @abstract 获取文字资源
 @discussion 获取文字资源
 @param key
 @result text 文字
 */
-(NSString *)getTextWithEnter:(NSString *)key
{
    NSString *text = @"";
    if(key && mDefList)
    {
        text = [mDefList objectForKey:key];
    }
    if(text == nil)
    {
        text = @"undefine";
    }
    return text;
}

/*!
 @method getText: withIndex:
 @abstract 获取key对应的文字中第index行文字
 @discussion 获取key对应的文字中第index行文字
 @param key
 @param index 第几行
 @result text 文字
 */
- (NSString*) getText:(NSString *)key withIndex:(NSInteger)index
{
    if (key == nil || index < 0) {
        return nil;
    }
    NSString *text = [self getTextWithEnter:key];
    NSArray *text_list =[text componentsSeparatedByString:NSLocalizedString(@"\n", nil)];
    if (index > [text_list count] - 1) {
        return nil;
    }
    return [text_list objectAtIndex:index];
    
}
- (NSString*)getText:(NSString *)key withPlaceHolder:(NSString *)PlaceHolder withDescription:(NSString*)Description
{
    NSArray *placehodlers = [[NSArray alloc] initWithObjects:PlaceHolder, nil];
    NSArray *descriptions = [[NSArray alloc] initWithObjects:Description, nil];
    return [self getText:key withPlaceHolders:placehodlers withDescriptions:descriptions];
}

- (NSString*)getText:(NSString *)key withPlaceHolders:(NSArray *)PlaceHolders withDescriptions:(NSArray*)Descriptions
{
    if (key == nil || PlaceHolders == nil || Descriptions == nil || [PlaceHolders count] != [Descriptions count]) {
        return nil;
    }
    NSMutableString *text = [[NSMutableString alloc] initWithString:[self getText:key]];
    [self getText:key];
    for (int i = 0; i < [PlaceHolders count]; i++) {
        [text replaceOccurrencesOfString:[PlaceHolders objectAtIndex:i] withString:[Descriptions objectAtIndex:i] options:NSCaseInsensitiveSearch range:NSMakeRange(0, [text length])];
    }
    return text;
}


#pragma mark - NSXMLParserDelegate
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    //set default list
    if(!mDefList)
    {
        mDefList = mTempList;
    }
    mTempList = nil;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
    if([elementName isEqualToString:@"LangDef"])
    {
        NSString *sKey = [attributeDict objectForKey:@"langCode"];
        
        NSLog(@"key:%@",sKey);
        if(sKey)
        {
            NSMutableDictionary *oList = [mDataList objectForKey:sKey];
            if(oList)
            {
                mTempList = oList;
            }
            else
            {
                mTempList = [[NSMutableDictionary alloc]initWithCapacity:0];
                [mDataList setObject:mTempList forKey:sKey];
            }
        }
    }
    else if([elementName isEqualToString:@"LangID"])
    {
        if(mTempList)
        {
            NSString *sID = [attributeDict objectForKey:@"ID"];
            NSMutableString *sText = [NSMutableString stringWithString:[attributeDict objectForKey:@"Text"]];
            NSRange wholeShebang = NSMakeRange(0, [sText length]);
            [sText replaceOccurrencesOfString: @"\\n" withString: @"\n"
                                      options: NSCaseInsensitiveSearch
                                        range: wholeShebang];
            
            //NSLog(@"id:%@:%@",sID,sText);
            [mTempList setObject:sText forKey:sID];
        }
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
}

@end

