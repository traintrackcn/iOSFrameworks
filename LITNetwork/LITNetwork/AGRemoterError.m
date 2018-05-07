//
//  AGRemoterResultError.m
//  AboveGEM
//
//  Created by traintrackcn on 19/8/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//


@import LITCommon;

#import "AGRemoterError.h"
#import "AFURLResponseSerialization.h"


@interface AGRemoterError(){

}

@property (nonatomic, strong) id recoverySuggestion;
@property (nonatomic, strong) id message;
@property (nonatomic, strong) id stack;
@property (nonatomic, strong) id data;
@property (nonatomic, strong) NSArray *codes;

@end

@implementation AGRemoterError

#pragma mark - parsers

- (void)parseErrorRaw:(id)errorRaw{
    
    [self setRaw:errorRaw];
    
    TLOG(@"errorRaw -> %@", errorRaw);
    
    if ([self isAvailableForKey:@"error-code"]) {
        [self setType:[self stringForKey:@"error-code"]];
    }
    
    if ([self isAvailableForKey:@"code"]) {
        [self setType:[self stringForKey:@"code"]];
    }
    
    if ([self isAvailableForKey:@"message"]) {
        [self setMessage:[self stringForKey:@"message"]];
    }
    
    if ([self isAvailableForKey:@"developer-message"]) {
        [self setDevelopMessage:[self stringForKey:@"developer-message"]];
    }
    
    if ([self isAvailableForKey:@"developerMessage"]){
        [self setDevelopMessage:[self stringForKey:@"developerMessage"]];
    }
    
    if ([self isAvailableForKey:@"errorMessage"]){
        [self setMessage:[self stringForKey:@"errorMessage"]];
    }
    
    if ([self isAvailableForKey:@"errorStack"]){
        [self setStack:[self objectForKey:@"errorStack"]];
    }
    
    if ([self isAvailableForKey:@"errorData"]){
        [self setData:[self objectForKey:@"errorData"]];
    }
    
//    if ([self isAvailableForKey:@"data"]){
//        [self setData:[self objectForKey:@"data"]];
//    }
    
}


- (void)parseResponseRaw:(id)responseRaw{
    TLOG(@"responseRaw -> %@", responseRaw);
    if ([responseRaw objectForKey:@"error"]){
        [self setName:[responseRaw objectForKey:@"error"]];
        [self setMessage:[responseRaw objectForKey:@"error"]];
    }
    
    if ([responseRaw objectForKey:@"message"]){
        [self setMessage:[responseRaw objectForKey:@"message"]];
    }
    
}

- (void)parseError:(NSError *)error{
    
    id userInfo = error.userInfo;
    
    [self setLocalizedDesc:[userInfo objectForKey:@"NSLocalizedDescription"]];
    [self setFailingURL:[userInfo objectForKey:@"NSErrorFailingURLKey"]];
    
    NSString *recoverySuggestionStr = [userInfo objectForKey:@"NSLocalizedRecoverySuggestion"];
    NSData *recoverySuggestionData;
    
    if (recoverySuggestionStr) {
        recoverySuggestionData = [recoverySuggestionStr dataUsingEncoding:NSUTF8StringEncoding];
    }else{
        recoverySuggestionData = [userInfo objectForKey:AFNetworkingOperationFailingURLResponseDataErrorKey];
    }
    
    
    if (recoverySuggestionData){
        [self setRecoverySuggestion:[NSJSONSerialization JSONObjectWithData:recoverySuggestionData options:NSJSONReadingAllowFragments error:nil]];
        
        //if error in meta
        if (self.errorRaw) {
            [self parseErrorRaw:self.errorRaw];
        }
//        else{
//            [self updateWithRaw:self.recoverySuggestion];
//        }
    }
}

#pragma mark - setters

- (void)setData:(id)data{
    _data = data;
    
    if (![data isKindOfClass:[NSArray class]]) return;
    NSArray *arr = data;
    NSMutableArray *tmpArr = [NSMutableArray array];
    for (NSInteger i = 0; i < arr.count; i++) {
        id raw = [arr objectAtIndex:i];
        TLOG(@"raw -> %@ %@", raw, [raw class]);
        if ([raw isKindOfClass:[NSDictionary class]]) {
            NSString *errorCode = [DSValueUtil toString:[raw objectForKey:@"errorCode"]];
            [tmpArr addObject:errorCode];
        }
    }
    [self setCodes:tmpArr];
    
    TLOG(@"errorCodes -> %@", self.codes);
}

#pragma mark -

- (BOOL)contains:(NSString *)errorCode{
    return [self.codes containsObject:errorCode];
}

#pragma mark - properties

- (id)metaRaw{
    return [self.recoverySuggestion objectForKey:@"meta"];
}

- (id)errorRaw{
    return [self.metaRaw objectForKey:@"error"];
}

- (id)request{
    return [self.recoverySuggestion objectForKey:@"request"];
}

- (id)headers{
    return [self.request objectForKey:@"headers"];
}

- (id)response{
    return [self.recoverySuggestion objectForKey:@"response"];
}


#pragma mark - util


- (NSArray *)messages{
    NSMutableArray *msgs = [NSMutableArray array];
    
    //append message for users
    if (self.message) {
        [msgs addObjectsFromArray:[self.message componentsSeparatedByString:@"\\n"]];
    }
    
    
    [msgs addObjectsFromArray:[self messagesFromData]];
    
    if (msgs.count == 0) { //if no message for users, append message for developers
        if (self.localizedDesc) [msgs addObject:self.localizedDesc];
        if (self.developMessage){
            if (![self.developMessage isEqualToString:@""]) [msgs addObject:self.developMessage];
        }
        if (self.stack) [msgs addObject:self.stack];
//        if (self.data) [msgs addObject:self.data];
    }

    return msgs;
}

- (NSArray *)messagesFromData{
    TLOG(@"self.data -> %@ self.data.class -> %@", self.data, [self.data class]);
    if ([self.data isKindOfClass:[NSArray class]]) return [self messagesFromDataAsArray];
    if ([self.data isKindOfClass:[NSDictionary class]]) return [self messagesFromDataAsDictionary];    
    if (self.data) return @[self.data];
    return @[];
}

- (NSArray *)messagesFromDataAsArray{
    NSMutableArray *msgs = [NSMutableArray array];
    NSArray *arr = (NSArray *)self.data;
    for (NSInteger i = 0; i<arr.count; i++) {
        id raw = [arr objectAtIndex:i];
        //            TLOG(@"raw -> %@", raw);
        @try {
            if ([raw isKindOfClass:[NSDictionary class]] && [raw objectForKey:@"message"]){
                [msgs addObject:[raw objectForKey:@"message"]];
            }
        } @catch (NSException *exception) {
            TLOG(@"exception -> %@", exception);
        } 
    }
    return msgs;
}

- (NSArray *)messagesFromDataAsDictionary{
    NSMutableArray *msgs = [NSMutableArray array];
    NSArray *failures = [self.data objectForKey:@"failures"];
    if (failures && [failures isKindOfClass:[NSArray class]]){
        for (NSInteger i = 0; i<failures.count; i++) {
            id failure = [failures objectAtIndex:i];
            [msgs addObject:[failure objectForKey:@"message"]];
        }
    }
    
    return msgs;
}

@end
