//
//  AGNetworkConfig.m
//  AGNetwork
//
//  Created by traintrackcn on 23/9/14.
//  Copyright (c) 2014 AboveGEM. All rights reserved.
//

@import LITCommon;

#import "AGNetworkDefine.h"


@implementation AGNetworkDefine

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setDefaultProtocolVersion:[aDecoder decodeObjectForKey:@"default-protocol-version"]];
        //        [self setToken:[aDecoder decodeObjectForKey:@"token"]];
        [self setDefaultServerUrl:[aDecoder decodeObjectForKey:@"default-server-url"]];
        [self setToken:[aDecoder decodeObjectForKey:@"token"]];
        [self setClientID:[aDecoder decodeObjectForKey:@"client-id"]];
        [self setClientSecret:[aDecoder decodeObjectForKey:@"client-secret"]];
//        [self setIsOG:[[aDecoder decodeObjectForKey:@"is-og"] boolValue]];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.defaultProtocolVersion forKey:@"default-protocol-version"];
    //    [aCoder encodeObject:self.token forKey:@"token"];
    [aCoder encodeObject:self.defaultServerUrl forKey:@"default-server-url"];
    [aCoder encodeObject:self.token forKey:@"token"];
    [aCoder encodeObject:self.clientID forKey:@"client-id"];
    [aCoder encodeObject:self.clientSecret forKey:@"client-secret"];
//    [aCoder encodeObject:[NSNumber numberWithBool:self.isOG] forKey:@"is-og"];
}


//- (void)setFlurryKey:(NSString *)flurryKey{
//    _flurryKey = flurryKey;
//    [Flurry startSession:flurryKey];
//}

#pragma mark - headers


- (NSMutableDictionary *)defaultHeaders{
    if (!_defaultHeaders) {
        _defaultHeaders = [NSMutableDictionary dictionary];
        [_defaultHeaders setObject:DS_SERVER_CONTENT_TYPE_JSON forKey:HTTP_HEAD_ACCEPT_TYPE];
        [_defaultHeaders setObject:[DSDeviceUtil identifier] forKey:HTTP_HEAD_DEVICE_ID];
        
        [_defaultHeaders setObject:[DSDeviceUtil systemInfo] forKey:HTTP_HEAD_DEVICE_INFO];
        [_defaultHeaders setObject:@"iOS" forKey:HTTP_HEAD_OS_INFO];
        
        [_defaultHeaders setObject:@"application/json; charset=utf-8" forKey:HTTP_HEAD_CONTENT_TYPE];
        [_defaultHeaders setObject:@"gzip" forKey:@"Accept-Encoding"];
    }
    
    if (NETWORK.clientID) [_defaultHeaders setObject:NETWORK.clientID forKey:@"X-Client-Id"];
    if (NETWORK.clientSecret) [_defaultHeaders setObject:NETWORK.clientSecret forKey:@"X-Client-Secret"];
    
//    TLOG(@"token -> %@", self.token);
    
    if (self.token) {
        [_defaultHeaders setObject:self.token forKey:@"X-Authentication-Token"];
    }else{
        [_defaultHeaders removeObjectForKey:@"X-Authentication-Token"];
    }
    
    NSString *langID = [NSLocale preferredLanguages].firstObject;
    [_defaultHeaders setObject:langID forKey:HTTP_HEAD_ACCEPT_LANGUAGE];
    
    return _defaultHeaders;
}



@end
