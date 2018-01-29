//
//  DSText.m
//  og
//
//  Created by traintrackcn on 13-8-6.
//  Copyright (c) 2013 2ViVe. All rights reserved.
//

@import LITCommon;

#import "AGTextCoordinator.h"


@interface AGTextCoordinator()<CHCSVParserDelegate>{
}

@property (nonatomic, strong) NSMutableDictionary *dic;
@property (nonatomic, strong) NSMutableDictionary *dicForEN;
@property (nonatomic, strong) id currentLineKey;
@property (nonatomic, assign) NSUInteger currentLineIdx;
@property (nonatomic, strong) NSMutableArray *availableLanguages;

@end

@implementation AGTextCoordinator

- (id)init{
    self = [super init];
    if (self) {
        [self load];
    }
    return self;
}


#pragma mark - main ops

+ (NSString *)textForKey:(NSString *)key roleCode:(NSString *)roleCode{
    return [TEXT_C textForKey:key roleCode:roleCode];
}

+ (NSString *)textWithStarForKey:(NSString *)key roleCode:(NSString *)roleCode{
    NSString *text = [TEXT_C textForKey:key roleCode:roleCode];
    return [NSString stringWithFormat:@"%@ *", text];
}

+ (BOOL)isAvailableTextKey:(NSString *)key roleCode:(NSString *)roleCode{
    return [TEXT_C isAvailableTextKey:key roleCode:roleCode];
}

- (NSString *)textForKey:(NSString *)key roleCode:(NSString *)roleCode{
//    NSString *originalKey = [key copy];
    
//    if ([key isEqualToString:@"KEY_MSG_INVITE_DOWNLINE_TIP"]){
//        TLOG(@"dic -> %@ dicForEN -> %@", self.dic, self.dicForEN);
//    }
    
    NSArray *keys = [key componentsSeparatedByString:@"|"];
    id value;
    
    for (NSInteger i = 0; i < keys.count; i++) {
        key = [keys objectAtIndex:i];
        
        if (roleCode) {
            key = [NSString stringWithFormat:@"%@-%@", key, roleCode.lowercaseString];
        }
        
//        TLOG(@"key -> %@", key);
        if (!value) {
            value = [self.extraDic objectForKey:key];
            if (value == [NSNull null]) value = nil;
        }
        if (!value) value = [self.dic objectForKey:key];
        if (!value) value = [self.dicForEN objectForKey:key];
        
        
        if (value) return value;
    }
    
    if ([[[self class] singleton] returnFirstKeyIfNoValue]) {
        return keys.firstObject;
    }
    
    return keys.lastObject;
}

- (BOOL)isAvailableTextKey:(NSString *)key roleCode:(NSString *)roleCode{
    NSArray *keys = [key componentsSeparatedByString:@","];
    id value;
    
    for (NSInteger i = 0; i < keys.count; i++) {
        key = [keys objectAtIndex:i];
        if (roleCode) {
            key = [NSString stringWithFormat:@"%@-%@", key, roleCode.lowercaseString];
        }
        
        value = [self.dic objectForKey:key];
        if (value) return YES;
    }
    return NO;
}


#pragma mark - load localized texts

- (void)reload{
    [self setDic:nil];
    [self setAvailableLanguages:nil];
    [self load];
}

- (void)load{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"localization" withExtension:@"csv"];
    TLOG(@"url -> %@", url);
    
    if (url) {
        [self parseCSVWithURL:url];
    }else{
        [self generateCSV];
    }
    
//    [self generateCSV];
}

#pragma mark - 

- (void)parseCSVWithURL:(NSURL *)url{
    CHCSVParser *parser = [[CHCSVParser alloc] initWithContentsOfCSVURL:url];
    [parser setDelegate:self];
    [parser parse];
}

- (id)dicFromPlist{
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Text-en" ofType:@"plist"];
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    id tmpDic = [NSPropertyListSerialization
                 propertyListFromData:plistXML
                 mutabilityOption:NSPropertyListMutableContainersAndLeaves
                 format:&format
                 errorDescription:&errorDesc];
    //    if (!data) TLOG(@"Error reading plist: %@, format: %lu", errorDesc, format);
    //    TLOG(@"text-%@ -> %@", languageID, data);
//    [self setDic:tmpDic];
    return tmpDic;
}

- (void)generateCSV{
    NSString *path = [NSString stringWithFormat:@"%@/localization_copy.csv", [[NSBundle mainBundle] bundlePath]];
    [[NSFileManager defaultManager] createFileAtPath:path contents:[@"" dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"localization_copy" ofType:@"csv"];
    TLOG(@"path -> %@", path);
    if (!path) return;
    CHCSVWriter *writer = [[CHCSVWriter alloc] initForWritingToCSVFile:path];
//    TLOG(@"writer -> %@", writer);
    id dic = [self dicFromPlist];
    
    if (dic && writer) {
        NSInteger lineIdx = 0;
        for (NSString *key in dic) {
            id value = [dic objectForKey:key];
            //                TLOG(@"key -> %@ value -> %@", key, value);
            if (lineIdx != 0) {
                [writer writeField:key];
                [writer writeField:value];
            }else{
                [writer writeField:@"key"];
                [writer writeField:@"en"];
            }
            
            [writer finishLine];
            lineIdx ++;
        }
        
        TLOG(@"%@ generated", path);
    }
}


#pragma mark -

- (void)nextLine{
    self.currentLineIdx ++;
}

- (BOOL)firstLine{
    if (self.currentLineIdx == 0) return YES;
    return NO;
}

- (void)parserDidBeginDocument:(CHCSVParser *)parser{
    [self setCurrentLineIdx:0];
}

- (void)parserDidEndDocument:(CHCSVParser *)parser{
    TLOG(@"current -> %@ availableLanguages -> %@", self.currentLanguageMainID,self.availableLanguages);
}

- (void)parser:(CHCSVParser *)parser didBeginLine:(NSUInteger)recordNumber{
//    TLOG(@"lineIdx -> %luld", (unsigned long)recordNumber);
}

- (void)parser:(CHCSVParser *)parser didEndLine:(NSUInteger)recordNumber{
    [self nextLine];
}
- (void)parser:(CHCSVParser *)parser didReadField:(NSString *)field atIndex:(NSInteger)fieldIndex{
//    TLOG(@"field -> %@ %ld", field, (long)fieldIndex);
    if ([self firstLine]) {
        if (fieldIndex != 0) { //available langugages
            field = [field componentsSeparatedByString:@" "].firstObject;
            [self.availableLanguages addObject:field];
        }
    }else{
        if (fieldIndex == 0) {
           [self setCurrentLineKey:field];
        }else{
            NSString *langID = [self languageIDForFieldIndex:fieldIndex];
            NSString *langKey = self.currentLineKey;
            NSString *langValue = [NSString removeQuoteForField:field];
            BOOL exsits = ![langValue isEqualToString:@""];
            
            if (exsits) [self cacheKey:langKey value:langValue forLanguage:langID];
        }
    }
}

- (void)parser:(CHCSVParser *)parser didFailWithError:(NSError *)error{
    TLOG(@"error -> %@", error);
}

#pragma mark - 

- (void)cacheKey:(NSString *)key value:(NSString *)value forLanguage:(NSString *)languageID{
//    TLOG(@"languageID -> %@ self.currentLanguageMainID -> %@", languageID, self.currentLanguageMainID);
    
    if ([languageID isEqualToString:@"en"]){
        [self.dicForEN setValue:value forKey:key];
    }else if ([languageID rangeOfString:self.currentLanguageMainID].location != NSNotFound) {
//        TLOG(@"languageID -> %@ self.currentLanguageMainID -> %@", languageID, self.currentLanguageMainID);
//        TLOG(@"%@(%@):%@",key, languageID, value);
        
        id valueFromDic = [self.dic objectForKey:key];
        BOOL exactlyMatch = [languageID isEqualToString:self.currentLanguageID];
        
        if (!valueFromDic || exactlyMatch) {
            valueFromDic = value;
        }
        
        [self.dic setValue:valueFromDic forKey:key];
        
    }
}


#pragma mark - properties

- (NSMutableDictionary *)dicForEN{
    if (!_dicForEN) {
        _dicForEN = [NSMutableDictionary dictionary];
    }
    return _dicForEN;
}

- (NSMutableDictionary *)dic{
    if (!_dic) {
        _dic = [NSMutableDictionary dictionary];
    }
    return _dic;
}

- (NSString *)languageIDForFieldIndex:(NSInteger)fieldIndex{
    NSInteger langIdx = fieldIndex - 1;
    return [self.availableLanguages objectAtIndex:langIdx];
}

- (NSString *)currentLanguageID{
    NSLocale *locale = [NSLocale autoupdatingCurrentLocale];
    return locale.localeIdentifier;
}

- (NSString *)currentLanguageMainID{
    return [self.currentLanguageID componentsSeparatedByString:@"_"].firstObject;
}

- (NSMutableArray *)availableLanguages{
    if (!_availableLanguages) {
        _availableLanguages = [NSMutableArray array];
    }
    return _availableLanguages;
}

@end
