//
//  DSRequestData.m
//  DirectSale
//
//  Created by Sean Guo on 7/16/12.
//  Copyright (c) 2012 Voxeo. All rights reserved.
//


@import LITCommon;

#import "DSRequestInfo.h"
#import "AGNetworkDefine.h"
//#import "NSObject+Singleton.h"
#import "AGRequestBinary.h"
#import "LITRequestForm.h"
#import "LITRequestFormField.h"

@interface DSRequestInfo(){
    
}


//@property (nonatomic, strong) NSString *headerForPostingOrder;
@property (nonatomic, strong) NSURL *defaultURL;
@property (nonatomic, strong) NSMutableData *defaultBody;

@end

@implementation DSRequestInfo

//- (instancetype)init{
//    @throw [NSException exceptionWithName:@"init is invalid" reason:@"please use AGRemoter GET/POST" userInfo:nil];
//}

+ (instancetype)instance{
    DSRequestInfo *requestInfo = [[DSRequestInfo alloc] init];
    [requestInfo setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    return requestInfo;
}

#pragma mark - properties

- (NSURL *)defaultURL{
    NSMutableString* urlStr = [NSMutableString stringWithString:@"/"];
    if (self.protocolVersion) [urlStr appendString:self.protocolVersion];
    if (self.requestType) [urlStr appendFormat:@"/%@",self.requestType];
    _defaultURL = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@%@", self.serverUrl, urlStr]];
    return _defaultURL;
}

- (NSString *)method{
    if (_method) return _method;
    return HTTP_METHOD_GET;
}

- (NSString *)key{
    return [[self URL] absoluteString];
}

- (NSString *)randomRequestIdStr{
    NSUUID *uuid = [[NSUUID alloc] init];
    NSString *uuidStr = [uuid UUIDString];
    uuidStr = [uuidStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return uuidStr;
}

- (NSString *)protocolVersion{
    if (!_protocolVersion) return [AGNetworkDefine singleton].defaultProtocolVersion;
    return _protocolVersion;
}

- (NSString *)serverUrl{
    if (!_serverUrl) return [AGNetworkDefine singleton].defaultServerUrl;
    return _serverUrl;
}

#pragma mark - assemble request

- (void)setThirdPartyHeaders{
    //            TLOG(@"self.thirdPartyHeaders -> %@", self.thirdPartyHeaders);
    if (self.thirdPartyHeaders) [self setAllHTTPHeaderFields:self.thirdPartyHeaders];
}

- (void)setHeaders{
    [self setAllHTTPHeaderFields:NETWORK.defaultHeaders];
    if (self.randomRequestId) [self setValue:self.randomRequestIdStr forHTTPHeaderField:@"X-Client-Request-Id"];
    
    //headers only in this request
//    TLOG(@"self.headers -> %@", self.headers);
    if (self.headers) {
        for (NSInteger i = 0; i<self.headers.allKeys.count; i++) {
            NSString *key = [self.headers.allKeys objectAtIndex:i];
            NSString *value = [self.headers valueForKey:key];
            [self setValue:value forHTTPHeaderField:key];
        }
    }
    
}

- (void)assemble{
//    TLOG(@"");
     @try {
        [self setHTTPMethod:[self method]];
//        [self setTimeoutInterval:60];

        if ([self thirdPartyUrl]) {
            [self setURL:self.thirdPartyUrl];
            [self setThirdPartyHeaders];
        }else{
            [self setURL:self.defaultURL];
            [self setHeaders];
        }
         
        id defaultBody = self.defaultBody;
        if (defaultBody) [self setHTTPBody:defaultBody];
        
//         TLOG(@"self.allHTTPHeaderFields -> %@", self.allHTTPHeaderFields);
        
    }@catch (NSException *exception) {
        TLOG(@"exception -> %@", exception);
    }
}


- (NSData *)defaultBodyWithRequestBody{
    if (!self.requestBody) return nil;
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self.requestBody options:NSJSONWritingPrettyPrinted error:&error];
    _defaultBody = [NSMutableData dataWithData:data];
    return _defaultBody;
}

- (NSData *)defaultBodyWithRequestBinary{ // will be defaultBodyWithRequestBodyAndRequestBinary some day
    NSString *boundary = [self boundaryInstance];
    _defaultBody = [NSMutableData data];
    
    AGRequestBinary *requestBinary = self.requestBody;
    
    // process request binary
    [_defaultBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [_defaultBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", requestBinary.name, requestBinary.file] dataUsingEncoding:NSUTF8StringEncoding]];
    //            [_defaultBody appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [_defaultBody appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [_defaultBody appendData:requestBinary.data];
    [_defaultBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];

    
    [_defaultBody appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    NSString *headerForContentLength = [NSString stringWithFormat:@"%ld", (unsigned long)[_defaultBody length]];
    
    //headers
    [self setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary] forHTTPHeaderField:HTTP_HEAD_CONTENT_TYPE];
    [self setValue:headerForContentLength forHTTPHeaderField:@"Content-Length"];

    
    return _defaultBody;
}

//- (NSData *)defaultBodyWithRequestBinary{ // will be defaultBodyWithRequestBodyAndRequestBinary some day
//
//    _defaultBody = [NSMutableData data];
//    [_defaultBody appendData:self.requestBinary.data];
////        NSString *headerForContentLength = [NSString stringWithFormat:@"%ld", (unsigned long)[_defaultBody length]];
//    [self setValue:self.defaultBodyContentLength forHTTPHeaderField:@"Content-Length"];
//    [self setValue:@"application/octet-stream" forHTTPHeaderField:@"Content-Type"];
//
//    return _defaultBody;
//}

- (NSData *)defaultBodyWithRequestForm{
    _defaultBody = [NSMutableData data];
    
    LITRequestForm *form = (LITRequestForm *)self.requestBody;
    NSArray *fields = form.fields;
    
    for (NSInteger i = 0; i<fields.count; i++) {
        LITRequestFormField *field = [fields objectAtIndex:i];
        [_defaultBody appendData:form.boundary];
        [_defaultBody appendData:field.body];
    }
    [_defaultBody appendData:form.boundaryEnd];
    
    
    TLOG(@"body str -> %@ %@", [[NSString alloc] initWithData:_defaultBody encoding:NSUTF8StringEncoding] , _defaultBody);
    
    //headers
    [self setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@",form.boundarySymbol] forHTTPHeaderField:HTTP_HEAD_CONTENT_TYPE];
    [self setValue:self.defaultBodyContentLength forHTTPHeaderField:@"Content-Length"];
    
    
    return _defaultBody;
}

- (id)defaultBodyContentLength{
    return [@([_defaultBody length]) stringValue];
}

- (NSData *)defaultBody{
    if ([self.requestBody isKindOfClass:[LITRequestForm class]]) return [self defaultBodyWithRequestForm];
    if ([self.requestBody isKindOfClass:[AGRequestBinary class]]) return [self defaultBodyWithRequestBinary];
    return [self defaultBodyWithRequestBody];
}


- (NSString *)boundaryInstance{
    NSString *hexRandom = [NSString stringWithFormat:@"%06X", (arc4random() % 16777216)];
    return hexRandom;
}


@end
